codeunit 71100 "Service Copy Management"
{

    trigger OnRun()
    begin
    end;

    var
        TempServiceInvLine: Record "Service Invoice Line" temporary;
        Item: Record Item;
        Currency: Record Currency;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ServiceItemCheckAvail: Codeunit "Service Item-Check Avail.";
        ServiceDocType: Option Quote,"Order",Invoice,"Credit Memo","Posted Shipment","Posted Invoice","Posted Credit Memo";
        Window: Dialog;
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        MoveNegLines: Boolean;
        WindowUpdateDateTime: DateTime;
        CreateToHeader: Boolean;
        HideDialog: Boolean;
        ExactCostRevMandatory: Boolean;
        ApplyFully: Boolean;
        AskApply: Boolean;
        ReappDone: Boolean;
        SkippedLine: Boolean;
        SomeAreFixed: Boolean;
        AsmHdrExistsForFromDocLine: Boolean;
        SkipCopyFromDescription: Boolean;
        SkipTestCreditLimit: Boolean;
        Text000: Label 'Please enter a Document No.';
        Text001: Label '%1 %2 cannot be copied onto itself.';
        Text003: Label 'The existing lines for %1 %2 will be deleted.\\Do you want to continue?', Comment = '%1=Document type, e.g. Invoice. %2=Document No., e.g. 001';
        Text004: Label 'Message from Auzilium AS: You cannot copy from service document to service order or quote. This part of the functionality has not been implementet and/or tested.';
        Text005: Label 'Exact Cost Reversing Link has not been created for all copied document lines.';
        Text006: Label '\';
        Text007: Label 'The document line(s) with a G/L account where direct posting is not allowed have not been copied to the new document by the Copy Document batch job.';
        Text008: Label 'There are no negative sales lines to move.';
        Text009: Label 'Copying document lines...\';
        Text010: Label 'Processing source lines      #1######\';
        Text011: Label '%1 %2:';
        Text012: Label 'Shipment No.,Invoice No.,Return Receipt No.,Credit Memo No.';
        Text013: Label '%1 - %2:';
        Text014: Label 'Inv. No. ,Shpt. No. ,Cr. Memo No. ,Rtrn. Rcpt. No. ';

    [EventSubscriber(ObjectType::Page, 5935, 'OnAfterActionEvent', 'CopyDocument', false, false)]
    local procedure "ServiceCrMemo.CopyDocument"(var Rec: Record "Service Header")
    var
        CopyServiceDocument: Report "Copy Service Document 2";
    begin
        CopyServiceDocument.SetServiceHeader(Rec);
        CopyServiceDocument.RunModal;
    end;

    [EventSubscriber(ObjectType::Page, 5933, 'OnAfterActionEvent', 'CopyDocument', false, false)]
    local procedure "ServceInvoice.CopyDocument"(var Rec: Record "Service Header")
    var
        CopyServiceDocument: Report "Copy Service Document 2";
    begin
        CopyServiceDocument.SetServiceHeader(Rec);
        CopyServiceDocument.RunModal;
    end;

    [Scope('Internal')]
    procedure SetProperties(NewIncludeHeader: Boolean; NewRecalculateLines: Boolean; NewMoveNegLines: Boolean; NewCreateToHeader: Boolean; NewHideDialog: Boolean; NewExactCostRevMandatory: Boolean; NewApplyFully: Boolean)
    begin
        IncludeHeader := NewIncludeHeader;
        RecalculateLines := NewRecalculateLines;
        MoveNegLines := NewMoveNegLines;
        CreateToHeader := NewCreateToHeader;
        HideDialog := NewHideDialog;
        ExactCostRevMandatory := NewExactCostRevMandatory;
        ApplyFully := NewApplyFully;
        AskApply := false;
        ReappDone := false;
        SkippedLine := false;
        SomeAreFixed := false;
        SkipCopyFromDescription := false;
        SkipTestCreditLimit := false;
    end;

    [Scope('Internal')]
    procedure ServiceHeaderDocType(ServiceHeader: Record "Service Header"; DocType: Option): Integer
    begin
        case DocType of
            ServiceDocType::Quote:
                exit(ServiceHeader."Document Type"::Quote);
            ServiceDocType::Order:
                exit(ServiceHeader."Document Type"::Order);
            ServiceDocType::Invoice:
                exit(ServiceHeader."Document Type"::Invoice);
            ServiceDocType::"Credit Memo":
                exit(ServiceHeader."Document Type"::"Credit Memo");
        end;
    end;

    [Scope('Internal')]
    procedure CopyServiceDoc(FromDocType: Option; FromDocNo: Code[20]; var ToServiceHeader: Record "Service Header")
    var
        PaymentTerms: Record "Payment Terms";
        ToServiceLine: Record "Service Line";
        ToServiceItemLine: Record "Service Item Line";
        OldServiceHeader: Record "Service Header";
        FromServiceHeader: Record "Service Header";
        FromServiceLine: Record "Service Line";
        FromServiceItemLine: Record "Service Item Line";
        FromServiceShptHeader: Record "Service Shipment Header";
        FromServiceShptLine: Record "Service Shipment Line";
        FromServiceInvHeader: Record "Service Invoice Header";
        FromServiceInvLine: Record "Service Invoice Line";
        FromServiceCrMemoHeader: Record "Service Cr.Memo Header";
        FromServiceCrMemoLine: Record "Service Cr.Memo Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        Customer: Record Customer;
        NextLineNo: Integer;
        NextItemLineNo: Integer;
        ItemChargeAssgntNextLineNo: Integer;
        LinesNotCopied: Integer;
        MissingExCostRevLink: Boolean;
        TempServiceShipmentLine: Record "Service Shipment Line";
    begin
        OnBeforeCopyServiceDoc(FromDocType, FromDocNo, ToServiceHeader);
        with ToServiceHeader do begin
            if not CreateToHeader then begin
                if FromDocNo = '' then
                    Error(Text000);
                Find;
            end;
            TransferOldExtLines.ClearLineNumbers;
            case FromDocType of
                ServiceDocType::Quote,
                ServiceDocType::Order,
                ServiceDocType::Invoice,
                ServiceDocType::"Credit Memo":
                    begin
                        FromServiceHeader.Get(ServiceHeaderDocType(ToServiceHeader, FromDocType), FromDocNo);
                        if MoveNegLines then
                            DeleteServiceLinesWithNegQty(FromServiceHeader, true);
                        if (FromServiceHeader."Document Type" = "Document Type") and
                           (FromServiceHeader."No." = "No.")
                        then
                            Error(Text001, "Document Type", "No.");

                        if "Document Type" <= "Document Type"::Invoice then begin
                            CheckCreditLimitService(FromServiceHeader, ToServiceHeader);
                        end;
                        CheckCopyFromServiceHeaderAvail(FromServiceHeader, ToServiceHeader);

                        if not IncludeHeader and not RecalculateLines then
                            CheckFromServiceHeader(FromServiceHeader, ToServiceHeader);
                    end;
                ServiceDocType::"Posted Shipment":
                    begin
                        FromServiceShptHeader.Get(FromDocNo);
                        CheckCopyFromServiceShptAvail(FromServiceShptHeader, ToServiceHeader);

                        if not IncludeHeader and not RecalculateLines then
                            CheckFromServiceShptHeader(FromServiceShptHeader, ToServiceHeader);
                    end;
                ServiceDocType::"Posted Invoice":
                    begin
                        FromServiceInvHeader.Get(FromDocNo);
                        if "Document Type" <= "Document Type"::Invoice then begin
                            if IncludeHeader then
                                FromServiceHeader.TransferFields(FromServiceInvHeader);
                            CheckCreditLimitService(FromServiceHeader, ToServiceHeader);
                        end;
                        CheckCopyFromServiceInvoiceAvail(FromServiceInvHeader, ToServiceHeader);

                        if not IncludeHeader and not RecalculateLines then
                            CheckFromServiceInvHeader(FromServiceInvHeader, ToServiceHeader);
                    end;
                ServiceDocType::"Posted Credit Memo":
                    begin
                        FromServiceCrMemoHeader.Get(FromDocNo);
                        if "Document Type" <= "Document Type"::Invoice then begin
                            if IncludeHeader then
                                FromServiceHeader.TransferFields(FromServiceInvHeader);
                            CheckCreditLimitService(FromServiceHeader, ToServiceHeader);
                        end;
                        CheckCopyFromServiceCrMemoAvail(FromServiceCrMemoHeader, ToServiceHeader);

                        if not IncludeHeader and not RecalculateLines then
                            CheckFromServiceCrMemoHeader(FromServiceCrMemoHeader, ToServiceHeader);
                    end;
            end;

            ToServiceLine.LockTable;
            ToServiceLine.SetRange("Document Type", "Document Type");
            ToServiceLine.SetRange("Document No.", "No.");

            ToServiceItemLine.LockTable;
            ToServiceItemLine.SetRange("Document Type", "Document Type");
            ToServiceItemLine.SetRange("Document No.", "No.");

            if CreateToHeader then
                Insert(true)
            else begin
                if IncludeHeader then
                    if not ToServiceLine.IsEmpty then begin
                        Commit;
                        if not
                           Confirm(
                             Text003, true,
                             "Document Type", "No.")
                        then
                            exit;
                        ToServiceLine.DeleteAll(true);
                    end;
            end;

            if ToServiceLine.FindLast then
                NextLineNo := ToServiceLine."Line No."
            else
                NextLineNo := 0;

            if ToServiceItemLine.FindLast then
                NextItemLineNo := ToServiceItemLine."Line No."
            else
                NextItemLineNo := 0;

            if IncludeHeader then begin
                if Customer.Get(FromServiceHeader."Customer No.") then
                    Customer.CheckBlockedCustOnDocs(Customer, "Document Type", false, false);
                OldServiceHeader := ToServiceHeader;
                case FromDocType of
                    ServiceDocType::Quote,
                    ServiceDocType::Order,
                    ServiceDocType::Invoice,
                    ServiceDocType::"Credit Memo":
                        begin
                            TransferFields(FromServiceHeader, false);
                            "Last Shipping No." := '';
                            if FromDocType in [ServiceDocType::Quote] then
                                if OldServiceHeader."Posting Date" = 0D then
                                    "Posting Date" := WorkDate
                                else
                                    "Posting Date" := OldServiceHeader."Posting Date";
                        end;
                    ServiceDocType::"Posted Shipment":
                        begin
                            Validate("Customer No.", FromServiceShptHeader."Customer No.");
                            TransferFields(FromServiceShptHeader, false);
                        end;
                    ServiceDocType::"Posted Invoice":
                        begin
                            Validate("Customer No.", FromServiceInvHeader."Customer No.");
                            TransferFields(FromServiceInvHeader, false);
                        end;
                    ServiceDocType::"Posted Credit Memo":
                        begin
                            Validate("Customer No.", FromServiceCrMemoHeader."Customer No.");
                            TransferFields(FromServiceCrMemoHeader, false);
                        end;
                end;

                if MoveNegLines or IncludeHeader then
                    Validate("Location Code");

                CopyFieldsFromOldServiceHeader(ToServiceHeader, OldServiceHeader);
                if RecalculateLines then
                    CreateDim(
                      DATABASE::"Responsibility Center", "Responsibility Center",
                      DATABASE::Customer, "Bill-to Customer No.",
                      DATABASE::"Salesperson/Purchaser", "Salesperson Code",
                      DATABASE::"Service Order Type", "Service Order Type",
                      DATABASE::"Service Contract Header", "Contract No.");
                "No. Printed" := 0;
                "Applies-to Doc. Type" := "Applies-to Doc. Type"::" ";
                "Applies-to Doc. No." := '';
                "Applies-to ID" := '';
                "Quote No." := '';
                if ((FromDocType = ServiceDocType::"Posted Invoice") and
                    ("Document Type" in ["Document Type"::"Credit Memo"])) or
                   ((FromDocType = ServiceDocType::"Posted Credit Memo") and
                    not ("Document Type" in ["Document Type"::"Credit Memo"]))
                then begin
                    CustLedgEntry.SetCurrentKey("Document No.");
                    if FromDocType = ServiceDocType::"Posted Invoice" then
                        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::Invoice)
                    else
                        CustLedgEntry.SetRange("Document Type", CustLedgEntry."Document Type"::"Credit Memo");
                    CustLedgEntry.SetRange("Document No.", FromDocNo);
                    CustLedgEntry.SetRange("Customer No.", "Bill-to Customer No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.FindFirst then begin
                        if FromDocType = ServiceDocType::"Posted Invoice" then begin
                            "Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
                            "Applies-to Doc. No." := FromDocNo;
                        end else begin
                            "Applies-to Doc. Type" := "Applies-to Doc. Type"::"Credit Memo";
                            "Applies-to Doc. No." := FromDocNo;
                        end;
                        CustLedgEntry.CalcFields("Remaining Amount");
                        CustLedgEntry."Amount to Apply" := CustLedgEntry."Remaining Amount";
                        CustLedgEntry."Accepted Payment Tolerance" := 0;
                        CustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                        CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry);
                    end;
                end;

                if "Document Type" in ["Document Type"::Quote] then
                    "Posting Date" := 0D;

                Correction := false;
                if "Document Type" in ["Document Type"::"Credit Memo"] then begin
                    GLSetup.Get;
                    Correction := GLSetup."Mark Cr. Memos as Corrections";
                    if ("Payment Terms Code" <> '') and ("Document Date" <> 0D) then
                        PaymentTerms.Get("Payment Terms Code")
                    else
                        Clear(PaymentTerms);
                    if not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
                        "Payment Terms Code" := '';
                        "Payment Discount %" := 0;
                        "Pmt. Discount Date" := 0D;
                    end;
                end;

                if CreateToHeader then begin
                    Validate("Payment Terms Code");
                    Modify(true);
                end else
                    Modify;
            end;

            LinesNotCopied := 0;
            case FromDocType of
                ServiceDocType::Quote,
                ServiceDocType::Order,
                ServiceDocType::Invoice,
                ServiceDocType::"Credit Memo":
                    begin
                        //Service lines
                        FromServiceLine.Reset;
                        FromServiceLine.SetRange("Document Type", FromServiceHeader."Document Type");
                        FromServiceLine.SetRange("Document No.", FromServiceHeader."No.");
                        if MoveNegLines then
                            FromServiceLine.SetFilter(Quantity, '<=0');

                        if ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Quote] then begin
                            //TEST+
                            Error(Text004);
                        end
                        //TEST-
                        else begin
                            //Service lines
                            if FromServiceLine.Find('-') then
                                repeat
                                    ToServiceLine."Document Type" := "Document Type";
                                    CopyServiceLine(ToServiceHeader, ToServiceLine, FromServiceHeader, FromServiceLine, NextLineNo, LinesNotCopied, false, 0);
                                until FromServiceLine.Next = 0;
                        end;
                    end;
                ServiceDocType::"Posted Shipment":
                    begin
                        FromServiceHeader.TransferFields(FromServiceShptHeader);

                        if ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Quote] then begin
                            //TEST+
                            Error(Text004);
                            //TEST-
                        end
                        else begin
                            //Service lines
                            FromServiceShptLine.Reset;
                            FromServiceShptLine.SetRange("Document No.", FromServiceShptHeader."No.");
                            if MoveNegLines then
                                FromServiceShptLine.SetFilter(Quantity, '<=0');
                            CopyServiceShptLinesToDoc(ToServiceHeader, FromServiceShptLine, LinesNotCopied, MissingExCostRevLink, 0);
                        end;
                    end;
                ServiceDocType::"Posted Invoice":
                    begin
                        FromServiceHeader.TransferFields(FromServiceInvHeader);

                        if ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Quote] then begin
                            //TEST+
                            Error(Text004);
                            /*
                            //Service item lines
                            FromServiceInvLine.RESET;
                            FromServiceInvLine.SETRANGE("Document No.",FromServiceInvHeader."No.");
                            IF MoveNegLines THEN
                              FromServiceInvLine.SETFILTER(Quantity,'<=0');

                            IF FromServiceInvLine.FINDLAST THEN BEGIN
                              FromServiceInvLine.GetServShptLines(TempServiceShipmentLine);
                              TempServiceShipmentLine.FINDLAST;

                              FromServiceShptItemLine.RESET;
                              FromServiceShptItemLine.SETRANGE("No.",TempServiceShipmentLine."Document No.");
                              CopyServiceShptItemLinesToDoc(ToServiceHeader,FromServiceShptItemLine,LinesNotCopied,MissingExCostRevLink);
                            END;
                            */
                            //TEST-
                        end
                        else begin
                            //Service lines
                            FromServiceInvLine.Reset;
                            FromServiceInvLine.SetRange("Document No.", FromServiceInvHeader."No.");
                            if MoveNegLines then
                                FromServiceInvLine.SetFilter(Quantity, '<=0');
                            CopyServiceInvLinesToDoc(ToServiceHeader, FromServiceInvLine, LinesNotCopied, MissingExCostRevLink);
                        end;
                    end;
                ServiceDocType::"Posted Credit Memo":
                    begin
                        FromServiceHeader.TransferFields(FromServiceCrMemoHeader);

                        if ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Quote] then begin
                            //TEST+
                            Error(Text004);
                            /*
                            //Service item lines
                            FromServiceCrMemoLine.RESET;
                            FromServiceCrMemoLine.SETRANGE("Document No.",FromServiceCrMemoHeader."No.");
                            IF MoveNegLines THEN
                              FromServiceCrMemoLine.SETFILTER(Quantity,'<=0');

                            IF FromServiceCrMemoLine.FINDLAST THEN BEGIN
                              FromServiceCrMemoLine.GetServShptLines(TempServiceShipmentLine);
                              TempServiceShipmentLine.FINDLAST;

                              FromServiceShptItemLine.RESET;
                              FromServiceShptItemLine.SETRANGE("No.",TempServiceShipmentLine."Document No.");
                              CopyServiceShptItemLinesToDoc(ToServiceHeader,FromServiceShptItemLine,LinesNotCopied,MissingExCostRevLink);
                            END;
                            */
                            //TEST-
                        end
                        else begin
                            //Service lines
                            FromServiceCrMemoLine.Reset;
                            FromServiceCrMemoLine.SetRange("Document No.", FromServiceCrMemoHeader."No.");
                            if MoveNegLines then
                                FromServiceCrMemoLine.SetFilter(Quantity, '<=0');
                            CopyServiceCrMemoLinesToDoc(ToServiceHeader, FromServiceCrMemoLine, LinesNotCopied, MissingExCostRevLink);
                        end;
                    end;
            end;
        end;

        if MoveNegLines then begin
            DeleteServiceLinesWithNegQty(FromServiceHeader, false);
        end;

        case true of
            MissingExCostRevLink and (LinesNotCopied <> 0):
                Message(Text005 + Text006 + Text007);
            MissingExCostRevLink:
                Message(Text005);
            LinesNotCopied <> 0:
                Message(Text007);
        end;
        OnAfterCopyServiceDoc(FromDocType, FromDocNo, ToServiceHeader);

    end;

    local procedure DeleteServiceLinesWithNegQty(FromServiceHeader: Record "Service Header"; OnlyTest: Boolean)
    var
        FromServiceLine: Record "Service Line";
    begin
        with FromServiceLine do begin
            SetRange("Document Type", FromServiceHeader."Document Type");
            SetRange("Document No.", FromServiceHeader."No.");
            SetFilter(Quantity, '<0');
            if OnlyTest then begin
                if not Find('-') then
                    Error(Text008);
                repeat
                    TestField("Shipment No.", '');
                    TestField("Quantity Shipped", 0);
                    TestField("Quantity Invoiced", 0);
                until Next = 0;
            end else
                DeleteAll(true);
        end;
    end;

    local procedure CheckCreditLimitService(FromServiceHeader: Record "Service Header"; ToServiceHeader: Record "Service Header")
    begin
        if SkipTestCreditLimit then
            exit;

        if IncludeHeader then
            CustCheckCreditLimit.ServiceHeaderCheck(FromServiceHeader)
        else
            CustCheckCreditLimit.ServiceHeaderCheck(ToServiceHeader);
    end;

    local procedure CheckCopyFromServiceHeaderAvail(FromServiceHeader: Record "Service Header"; ToServiceHeader: Record "Service Header")
    var
        FromServiceLine: Record "Service Line";
        ToServiceLine: Record "Service Line";
        FromServiceItemLine: Record "Service Item Line";
        ToServiceItemLine: Record "Service Item Line";
    begin
        with ToServiceHeader do
            if "Document Type" in ["Document Type"::Order, "Document Type"::Invoice] then begin
                FromServiceLine.SetRange("Document Type", FromServiceHeader."Document Type");
                FromServiceLine.SetRange("Document No.", FromServiceHeader."No.");
                FromServiceLine.SetRange(Type, FromServiceLine.Type::Item);
                FromServiceLine.SetFilter("No.", '<>%1', '');
                if FromServiceLine.Find('-') then
                    repeat
                        if FromServiceLine.Quantity > 0 then begin
                            ToServiceLine."No." := FromServiceLine."No.";
                            ToServiceLine."Variant Code" := FromServiceLine."Variant Code";
                            ToServiceLine."Location Code" := FromServiceLine."Location Code";
                            ToServiceLine."Bin Code" := FromServiceLine."Bin Code";
                            ToServiceLine."Unit of Measure Code" := FromServiceLine."Unit of Measure Code";
                            ToServiceLine."Qty. per Unit of Measure" := FromServiceLine."Qty. per Unit of Measure";
                            ToServiceLine."Outstanding Quantity" := FromServiceLine.Quantity;
                            if "Document Type" = "Document Type"::Order then
                                ToServiceLine."Outstanding Quantity" := FromServiceLine.Quantity;
                            CheckItemAvailableService(ToServiceHeader, ToServiceLine);

                            if "Document Type" = "Document Type"::Order then begin
                                ToServiceLine."Outstanding Quantity" := FromServiceLine.Quantity;
                            end;
                        end;
                    until FromServiceLine.Next = 0;
            end;
    end;

    local procedure CheckFromServiceHeader(ServiceHeaderFrom: Record "Service Header"; ServiceHeaderTo: Record "Service Header")
    begin
        with ServiceHeaderTo do begin
            ServiceHeaderFrom.TestField("Customer No.", "Customer No.");
            ServiceHeaderFrom.TestField("Bill-to Customer No.", "Bill-to Customer No.");
            ServiceHeaderFrom.TestField("Customer Posting Group", "Customer Posting Group");
            ServiceHeaderFrom.TestField("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
            ServiceHeaderFrom.TestField("Currency Code", "Currency Code");
            ServiceHeaderFrom.TestField("Prices Including VAT", "Prices Including VAT");
        end;
    end;

    local procedure CheckCopyFromServiceShptAvail(FromServiceShptHeader: Record "Service Shipment Header"; ToServiceHeader: Record "Service Header")
    var
        FromServiceShptLine: Record "Service Shipment Line";
        ToServiceLine: Record "Service Line";
        FromPostedAsmHeader: Record "Posted Assembly Header";
    begin
        if not (ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Invoice]) then
            exit;

        with ToServiceLine do begin
            FromServiceShptLine.SetRange("Document No.", FromServiceShptHeader."No.");
            FromServiceShptLine.SetRange(Type, FromServiceShptLine.Type::Item);
            FromServiceShptLine.SetFilter("No.", '<>%1', '');
            if FromServiceShptLine.Find('-') then
                repeat
                    if FromServiceShptLine.Quantity > 0 then begin
                        "No." := FromServiceShptLine."No.";
                        "Variant Code" := FromServiceShptLine."Variant Code";
                        "Location Code" := FromServiceShptLine."Location Code";
                        "Bin Code" := FromServiceShptLine."Bin Code";
                        "Unit of Measure Code" := FromServiceShptLine."Unit of Measure Code";
                        "Qty. per Unit of Measure" := FromServiceShptLine."Qty. per Unit of Measure";
                        "Outstanding Quantity" := FromServiceShptLine.Quantity;

                        CheckItemAvailableService(ToServiceHeader, ToServiceLine);
                    end;
                until FromServiceShptLine.Next = 0;
        end;
    end;

    local procedure CheckFromServiceShptHeader(ServiceShipmentHeaderFrom: Record "Service Shipment Header"; ServiceHeaderTo: Record "Service Header")
    begin
        with ServiceHeaderTo do begin
            ServiceShipmentHeaderFrom.TestField("Customer No.", "Customer No.");
            ServiceShipmentHeaderFrom.TestField("Bill-to Customer No.", "Bill-to Customer No.");
            ServiceShipmentHeaderFrom.TestField("Customer Posting Group", "Customer Posting Group");
            ServiceShipmentHeaderFrom.TestField("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
            ServiceShipmentHeaderFrom.TestField("Currency Code", "Currency Code");
            ServiceShipmentHeaderFrom.TestField("Prices Including VAT", "Prices Including VAT");
        end;
    end;

    local procedure CheckCopyFromServiceInvoiceAvail(FromServiceInvHeader: Record "Service Invoice Header"; ToServiceHeader: Record "Service Header")
    var
        FromServiceInvLine: Record "Service Invoice Line";
        ToServiceLine: Record "Service Line";
    begin
        if not (ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Invoice]) then
            exit;

        with ToServiceLine do begin
            FromServiceInvLine.SetRange("Document No.", FromServiceInvHeader."No.");
            FromServiceInvLine.SetRange(Type, FromServiceInvLine.Type::Item);
            FromServiceInvLine.SetFilter("No.", '<>%1', '');
            if FromServiceInvLine.Find('-') then
                repeat
                    if FromServiceInvLine.Quantity > 0 then begin
                        "No." := FromServiceInvLine."No.";
                        "Variant Code" := FromServiceInvLine."Variant Code";
                        "Location Code" := FromServiceInvLine."Location Code";
                        "Bin Code" := FromServiceInvLine."Bin Code";
                        "Unit of Measure Code" := FromServiceInvLine."Unit of Measure Code";
                        "Qty. per Unit of Measure" := FromServiceInvLine."Qty. per Unit of Measure";
                        "Outstanding Quantity" := FromServiceInvLine.Quantity;
                        CheckItemAvailableService(ToServiceHeader, ToServiceLine);
                    end;
                until FromServiceInvLine.Next = 0;
        end;
    end;

    local procedure CheckFromServiceInvHeader(ServiceInvoiceHeaderFrom: Record "Service Invoice Header"; ServiceHeaderTo: Record "Service Header")
    begin
        with ServiceHeaderTo do begin
            ServiceInvoiceHeaderFrom.TestField("Customer No.", "Customer No.");
            ServiceInvoiceHeaderFrom.TestField("Bill-to Customer No.", "Bill-to Customer No.");
            ServiceInvoiceHeaderFrom.TestField("Customer Posting Group", "Customer Posting Group");
            ServiceInvoiceHeaderFrom.TestField("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
            ServiceInvoiceHeaderFrom.TestField("Currency Code", "Currency Code");
            ServiceInvoiceHeaderFrom.TestField("Prices Including VAT", "Prices Including VAT");
        end;
    end;

    local procedure CheckCopyFromServiceCrMemoAvail(FromServiceCrMemoHeader: Record "Service Cr.Memo Header"; ToServiceHeader: Record "Service Header")
    var
        FromServiceCrMemoLine: Record "Service Cr.Memo Line";
        ToServiceLine: Record "Service Line";
    begin
        if not (ToServiceHeader."Document Type" in [ToServiceHeader."Document Type"::Order, ToServiceHeader."Document Type"::Invoice]) then
            exit;

        with ToServiceLine do begin
            FromServiceCrMemoLine.SetRange("Document No.", FromServiceCrMemoHeader."No.");
            FromServiceCrMemoLine.SetRange(Type, FromServiceCrMemoLine.Type::Item);
            FromServiceCrMemoLine.SetFilter("No.", '<>%1', '');
            if FromServiceCrMemoLine.Find('-') then
                repeat
                    if FromServiceCrMemoLine.Quantity > 0 then begin
                        "No." := FromServiceCrMemoLine."No.";
                        "Variant Code" := FromServiceCrMemoLine."Variant Code";
                        "Location Code" := FromServiceCrMemoLine."Location Code";
                        "Bin Code" := FromServiceCrMemoLine."Bin Code";
                        "Unit of Measure Code" := FromServiceCrMemoLine."Unit of Measure Code";
                        "Qty. per Unit of Measure" := FromServiceCrMemoLine."Qty. per Unit of Measure";
                        "Outstanding Quantity" := FromServiceCrMemoLine.Quantity;
                        CheckItemAvailableService(ToServiceHeader, ToServiceLine);
                    end;
                until FromServiceCrMemoLine.Next = 0;
        end;
    end;

    local procedure CheckFromServiceCrMemoHeader(ServiceCrMemoHeaderFrom: Record "Service Cr.Memo Header"; ServiceHeaderTo: Record "Service Header")
    begin
        with ServiceHeaderTo do begin
            ServiceCrMemoHeaderFrom.TestField("Customer No.", "Customer No.");
            ServiceCrMemoHeaderFrom.TestField("Bill-to Customer No.", "Bill-to Customer No.");
            ServiceCrMemoHeaderFrom.TestField("Customer Posting Group", "Customer Posting Group");
            ServiceCrMemoHeaderFrom.TestField("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
            ServiceCrMemoHeaderFrom.TestField("Currency Code", "Currency Code");
            ServiceCrMemoHeaderFrom.TestField("Prices Including VAT", "Prices Including VAT");
        end;
    end;

    local procedure CopyFieldsFromOldServiceHeader(var ToServiceHeader: Record "Service Header"; OldServiceHeader: Record "Service Header")
    begin
        with ToServiceHeader do begin
            "No. Series" := OldServiceHeader."No. Series";
            "Posting Description" := OldServiceHeader."Posting Description";
            "Posting No." := OldServiceHeader."Posting No.";
            "Posting No. Series" := OldServiceHeader."Posting No. Series";
            "Shipping No." := OldServiceHeader."Shipping No.";
            "Shipping No. Series" := OldServiceHeader."Shipping No. Series";
        end
    end;

    local procedure CopyServiceLine(var ToServiceHeader: Record "Service Header"; var ToServiceLine: Record "Service Line"; var FromServiceHeader: Record "Service Header"; var FromServiceLine: Record "Service Line"; var NextLineNo: Integer; var LinesNotCopied: Integer; RecalculateAmount: Boolean; ServiceItemLineNo: Integer): Boolean
    var
        ToServiceLine2: Record "Service Line";
        Customer: Record Customer;
        ServiceSetup: Record "Service Mgt. Setup";
        CustPostingGroup: Record "Customer Posting Group";
        RoundingLineInserted: Boolean;
        CopyThisLine: Boolean;
        InvDiscountAmount: Decimal;
    begin
        CopyThisLine := true;
        ServiceSetup.Get;

        if ((ToServiceHeader."Language Code" <> FromServiceHeader."Language Code") or RecalculateLines) and
           (FromServiceLine."Attached to Line No." <> 0)
        then
            exit(false);
        ToServiceLine.SetServHeader(ToServiceHeader);
        if RecalculateLines and not FromServiceLine."System-Created Entry" then
            ToServiceLine.Init
        else
            ToServiceLine := FromServiceLine;

        NextLineNo := NextLineNo + 10000;
        ToServiceLine."Document Type" := ToServiceHeader."Document Type";
        ToServiceLine."Document No." := ToServiceHeader."No.";
        ToServiceLine."Line No." := NextLineNo;
        ToServiceLine."Service Item Line No." := ServiceItemLineNo;

        if (ToServiceLine.Type <> ToServiceLine.Type::" ") and
           (ToServiceLine."Document Type" in [ToServiceLine."Document Type"::"Credit Memo"])
        then begin
            InvDiscountAmount := ToServiceLine."Inv. Discount Amount";
            ToServiceLine.Validate("Line Discount %");
            ToServiceLine.Validate("Inv. Discount Amount", InvDiscountAmount);
        end;
        ToServiceLine.Validate("Currency Code", FromServiceHeader."Currency Code");

        UpdateServiceLine(ToServiceHeader, ToServiceLine, FromServiceHeader, FromServiceLine, CopyThisLine, RecalculateAmount);

        if ExactCostRevMandatory and
           (FromServiceLine.Type = FromServiceLine.Type::Item) and
           (FromServiceLine."Appl.-from Item Entry" <> 0) and
           not MoveNegLines
        then begin
            if RecalculateAmount then begin
                ToServiceLine.Validate("Unit Price", FromServiceLine."Unit Price");
                ToServiceLine.Validate("Line Discount %", FromServiceLine."Line Discount %");
                ToServiceLine.Validate(
                  "Line Discount Amount",
                  Round(FromServiceLine."Line Discount Amount", Currency."Amount Rounding Precision"));
                ToServiceLine.Validate(
                  "Inv. Discount Amount",
                  Round(FromServiceLine."Inv. Discount Amount", Currency."Amount Rounding Precision"));
            end;
            ToServiceLine.Validate("Appl.-from Item Entry", FromServiceLine."Appl.-from Item Entry");
        end;

        if MoveNegLines and (ToServiceLine.Type <> ToServiceLine.Type::" ") then begin
            ToServiceLine.Validate(Quantity, -FromServiceLine.Quantity);
            ToServiceLine."Appl.-to Item Entry" := FromServiceLine."Appl.-to Item Entry";
            ToServiceLine."Appl.-from Item Entry" := FromServiceLine."Appl.-from Item Entry";
            ToServiceLine."Job No." := FromServiceLine."Job No.";
            ToServiceLine."Job Task No." := FromServiceLine."Job Task No.";
        end;

        //TEST+
        //Transfer extended texts
        //IF (ToServiceHeader."Language Code" <> FromServiceHeader."Language Code") OR RecalculateLines THEN BEGIN
        //  IF TransferExtendedText.ServiceCheckIfAnyExtText(ToServiceLine,FALSE) THEN BEGIN
        //    TransferExtendedText.InsertServiceExtText(ToServiceLine);
        //    ToServiceLine2.SETRANGE("Document Type",ToServiceLine."Document Type");
        //    ToServiceLine2.SETRANGE("Document No.",ToServiceLine."Document No.");
        //    ToServiceLine2.FINDLAST;
        //    NextLineNo := ToServiceLine2."Line No.";
        //  END;
        //END ELSE
        //  ToServiceLine."Attached to Line No." :=
        //    TransferOldExtLines.TransferExtendedText(FromServiceLine."Line No.",NextLineNo,FromServiceLine."Attached to Line No.");
        //TEST-

        ToServiceLine."Shortcut Dimension 1 Code" := FromServiceLine."Shortcut Dimension 1 Code";
        ToServiceLine."Shortcut Dimension 2 Code" := FromServiceLine."Shortcut Dimension 2 Code";
        ToServiceLine."Dimension Set ID" := FromServiceLine."Dimension Set ID";

        if CopyThisLine then begin
            ToServiceLine.Insert;
            if ToServiceLine.Reserve = ToServiceLine.Reserve::Always then
                ToServiceLine.AutoReserve;
        end else
            LinesNotCopied := LinesNotCopied + 1;
        exit(true);
    end;

    local procedure CopyServiceShptLinesToDoc(ToServiceHeader: Record "Service Header"; var FromServiceShptLine: Record "Service Shipment Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean; ServiceItemLineNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempTrkgItemLedgEntry: Record "Item Ledger Entry" temporary;
        FromServiceHeader: Record "Service Header";
        FromServiceLine: Record "Service Line";
        ToServiceLine: Record "Service Line";
        FromServiceLineBuf: Record "Service Line" temporary;
        FromServiceShptHeader: Record "Service Shipment Header";
        TempItemTrkgEntry: Record "Reservation Entry" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        OldDocNo: Code[20];
        NextLineNo: Integer;
        NextItemTrkgEntryNo: Integer;
        FromLineCounter: Integer;
        ToLineCounter: Integer;
        CopyItemTrkg: Boolean;
        SplitLine: Boolean;
        FillExactCostRevLink: Boolean;
        CopyLine: Boolean;
        InsertDocNoLine: Boolean;
    begin
        MissingExCostRevLink := false;
        InitCurrency(ToServiceHeader."Currency Code");
        OpenWindow;

        with FromServiceShptLine do
            if FindSet then
                repeat
                    FromLineCounter := FromLineCounter + 1;
                    if IsTimeForUpdate then
                        Window.Update(1, FromLineCounter);
                    if FromServiceShptHeader."No." <> "Document No." then begin
                        FromServiceShptHeader.Get("Document No.");
                        TransferOldExtLines.ClearLineNumbers;
                    end;
                    FromServiceHeader.TransferFields(FromServiceShptHeader);
                    //TEST+
                    //Copy item tracking
                    //FillExactCostRevLink :=
                    //  IsServiceFillExactCostRevLink(ToServiceHeader,0,FromServiceHeader."Currency Code");
                    //TEST-
                    FromServiceLine.TransferFields(FromServiceShptLine);
                    FromServiceLine."Appl.-from Item Entry" := 0;

                    if "Document No." <> OldDocNo then begin
                        OldDocNo := "Document No.";
                        InsertDocNoLine := true;
                    end;
                    //TEST+
                    //Copy item tracking
                    //SplitLine := TRUE;
                    //FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
                    //IF NOT SplitPstdServiceLinesPerILE(
                    //     ToServiceHeader,FromServiceHeader,ItemLedgEntry,FromServiceLineBuf,
                    //     FromServiceLine,NextLineNo,CopyItemTrkg,MissingExCostRevLink,FillExactCostRevLink,TRUE)
                    //THEN
                    //  IF CopyItemTrkg THEN
                    //    SplitLine :=
                    //      SplitServiceDocLinesPerItemTrkg(
                    //        ItemLedgEntry,TempItemTrkgEntry,FromServiceLineBuf,
                    //        FromServiceLine,NextLineNo,NextItemTrkgEntryNo,MissingExCostRevLink,TRUE)
                    //  ELSE
                    //TEST-
                    SplitLine := false;

                    if not SplitLine then begin
                        FromServiceLineBuf := FromServiceLine;
                        CopyLine := true;
                    end else
                        CopyLine := FromServiceLineBuf.FindSet and FillExactCostRevLink;

                    Window.Update(1, FromLineCounter);
                    if CopyLine then begin
                        NextLineNo := GetLastToServiceLineNo(ToServiceHeader);
                        if InsertDocNoLine then begin
                            InsertOldServiceDocNoLine(ToServiceHeader, "Document No.", 1, NextLineNo);
                            InsertDocNoLine := false;
                        end;
                        if (FromServiceLineBuf.Type <> FromServiceLineBuf.Type::" ") or
                           (FromServiceLineBuf."Attached to Line No." = 0)
                        then
                            repeat
                                ToLineCounter := ToLineCounter + 1;
                                if IsTimeForUpdate then
                                    Window.Update(2, ToLineCounter);
                                if CopyServiceLine(
                                     ToServiceHeader, ToServiceLine, FromServiceHeader, FromServiceLineBuf, NextLineNo, LinesNotCopied, false, ServiceItemLineNo)
                                then begin
                                    //TEST+
                                    //Copy item tracking
                                    //IF CopyItemTrkg THEN BEGIN
                                    //  IF SplitLine THEN BEGIN
                                    //    TempItemTrkgEntry.RESET;
                                    //    TempItemTrkgEntry.SETCURRENTKEY("Source ID","Source Ref. No.");
                                    //    TempItemTrkgEntry.SETRANGE("Source ID",FromServiceLineBuf."Document No.");
                                    //    TempItemTrkgEntry.SETRANGE("Source Ref. No.",FromServiceLineBuf."Line No.");
                                    //    CollectItemTrkgPerPstDocLine(TempItemTrkgEntry,TempTrkgItemLedgEntry,FALSE);
                                    //  END ELSE
                                    //    ItemTrackingMgt.CollectItemTrkgPerPstdDocLine(TempTrkgItemLedgEntry,ItemLedgEntry);
                                    //
                                    //  ItemTrackingMgt.CopyItemLedgEntryTrkgToServiceLn(
                                    //    TempTrkgItemLedgEntry,ToServiceLine,
                                    //    FillExactCostRevLink AND ExactCostRevMandatory,MissingExCostRevLink,
                                    //    FromServiceHeader."Prices Including VAT",ToServiceHeader."Prices Including VAT",TRUE);
                                    //END;

                                    //Extended texts
                                    //CopyServiceShptExtTextToDoc(
                                    //  ToServiceHeader,ToServiceLine,FromServiceShptLine,FromServiceHeader."Language Code",
                                    //  NextLineNo,FromServiceLineBuf."Appl.-from Item Entry" <> 0);
                                    //TEST-
                                end;
                            until FromServiceLineBuf.Next = 0;
                    end;
                until Next = 0;

        Window.Close;
    end;

    local procedure CopyServiceInvLinesToDoc(ToServiceHeader: Record "Service Header"; var FromServiceInvLine: Record "Service Invoice Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean)
    var
        ItemLedgEntryBuf: Record "Item Ledger Entry";
        TempTrkgItemLedgEntry: Record "Item Ledger Entry" temporary;
        FromServiceHeader: Record "Service Header";
        FromServiceLine: Record "Service Line";
        FromServiceLine2: Record "Service Line";
        ToServiceLine: Record "Service Line";
        FromServiceLineBuf: Record "Service Line" temporary;
        FromServiceInvHeader: Record "Service Invoice Header";
        TempItemTrkgEntry: Record "Reservation Entry" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        OldInvDocNo: Code[20];
        OldShptDocNo: Code[10];
        NextLineNo: Integer;
        NextItemTrkgEntryNo: Integer;
        FromLineCounter: Integer;
        ToLineCounter: Integer;
        CopyItemTrkg: Boolean;
        SplitLine: Boolean;
        FillExactCostRevLink: Boolean;
        ServiceInvLineCount: Integer;
        ServiceLineCount: Integer;
        BufferCount: Integer;
    begin
        MissingExCostRevLink := false;
        InitCurrency(ToServiceHeader."Currency Code");
        FromServiceLineBuf.Reset;
        FromServiceLineBuf.DeleteAll;
        TempItemTrkgEntry.Reset;
        TempItemTrkgEntry.DeleteAll;
        OpenWindow;
        TempServiceInvLine.DeleteAll;

        // Fill Service line buffer
        ServiceInvLineCount := 0;
        with FromServiceInvLine do
            if FindSet then
                repeat
                    FromLineCounter := FromLineCounter + 1;
                    if IsTimeForUpdate then
                        Window.Update(1, FromLineCounter);
                    if Type = Type::Item then begin
                        ServiceInvLineCount += 1;
                        TempServiceInvLine := FromServiceInvLine;
                        TempServiceInvLine.Insert;
                    end;

                    if FromServiceInvHeader."No." <> "Document No." then begin
                        FromServiceInvHeader.Get("Document No.");
                        TransferOldExtLines.ClearLineNumbers;
                    end;
                    FromServiceInvHeader.TestField("Prices Including VAT", ToServiceHeader."Prices Including VAT");
                    FromServiceHeader.TransferFields(FromServiceInvHeader);
                    //TEST+
                    //Copy item tracking
                    //FillExactCostRevLink :=
                    //  IsServiceFillExactCostRevLink(ToServiceHeader,1,FromServiceHeader."Currency Code");
                    //TEST-
                    FromServiceLine.TransferFields(FromServiceInvLine);
                    FromServiceLine."Appl.-from Item Entry" := 0;
                    // Reuse fields to buffer invoice line information
                    FromServiceLine."Shipment No." := "Document No.";
                    FromServiceLine."Shipment Line No." := 0;
                    //TEST+
                    //Copy item tracking
                    //SplitLine := TRUE;
                    //GetItemLedgEntries(ItemLedgEntryBuf,TRUE);
                    //IF NOT SplitPstdServiceLinesPerILE(
                    //     ToServiceHeader,FromServiceHeader,ItemLedgEntryBuf,FromServiceLineBuf,
                    //     FromServiceLine,NextLineNo,CopyItemTrkg,MissingExCostRevLink,FillExactCostRevLink,FALSE)
                    //THEN
                    //  IF CopyItemTrkg THEN
                    //    SplitLine :=
                    //      SplitServiceDocLinesPerItemTrkg(
                    //        ItemLedgEntryBuf,TempItemTrkgEntry,FromServiceLineBuf,
                    //        FromServiceLine,NextLineNo,NextItemTrkgEntryNo,MissingExCostRevLink,FALSE)
                    //  ELSE
                    //TEST-
                    SplitLine := false;

                    if not SplitLine then begin
                        FromServiceLine2 := FromServiceLineBuf;
                        FromServiceLineBuf := FromServiceLine;
                        FromServiceLineBuf."Document No." := FromServiceLine2."Document No.";
                        FromServiceLineBuf."Shipment Line No." := FromServiceLine2."Shipment Line No.";
                        FromServiceLineBuf."Line No." := NextLineNo;
                        NextLineNo := NextLineNo + 1;
                        FromServiceLineBuf.Insert;
                    end;
                until Next = 0;

        // Create Service line from buffer
        Window.Update(1, FromLineCounter);

        BufferCount := 0;
        with FromServiceLineBuf do begin
            // Sorting according to Service Line Document No.,Line No.
            SetCurrentKey("Document Type", "Document No.", "Line No.");
            ServiceLineCount := 0;
            if FindSet then
                repeat
                    if Type = Type::Item then
                        ServiceLineCount += 1;
                until Next = 0;
            if FindSet then begin
                NextLineNo := GetLastToServiceLineNo(ToServiceHeader);
                repeat
                    ToLineCounter := ToLineCounter + 1;
                    if IsTimeForUpdate then
                        Window.Update(2, ToLineCounter);
                    if "Shipment No." <> OldInvDocNo then begin
                        OldInvDocNo := "Shipment No.";
                        OldShptDocNo := '';
                        InsertOldServiceDocNoLine(ToServiceHeader, OldInvDocNo, 2, NextLineNo);
                    end;
                    if ("Document No." <> OldShptDocNo) and ("Shipment Line No." > 0) then begin
                        OldShptDocNo := "Document No.";
                        InsertOldServiceCombDocNoLine(ToServiceHeader, OldInvDocNo, OldShptDocNo, NextLineNo, true);
                    end;

                    if (Type <> Type::" ") or ("Attached to Line No." = 0) then begin
                        // Empty buffer fields
                        FromServiceLine2 := FromServiceLineBuf;
                        FromServiceLine2."Shipment No." := '';
                        FromServiceLine2."Shipment Line No." := 0;
                        if Type = Type::Item then begin
                            BufferCount += 1;
                        end;
                        if CopyServiceLine(
                             ToServiceHeader, ToServiceLine, FromServiceHeader,
                             FromServiceLine2, NextLineNo, LinesNotCopied, true, 0)
                        then begin
                            //FromServiceInvLine.GET("Shipment No.","Return Receipt Line No.");

                            //TEST+
                            //Copy item tracking
                            //IF (Type = Type::Item) AND (Quantity <> 0) THEN BEGIN
                            //  FromServiceInvLine."Document No." := OldInvDocNo;
                            //  FromServiceInvLine."Line No." := "Return Receipt Line No.";
                            //  FromServiceInvLine.GetItemLedgEntries(ItemLedgEntryBuf,TRUE);
                            //  IF IsCopyItemTrkg(ItemLedgEntryBuf,CopyItemTrkg,FillExactCostRevLink) THEN BEGIN
                            //    IF MoveNegLines OR NOT ExactCostRevMandatory THEN
                            //      ItemTrackingMgt.CollectItemTrkgPerPstdDocLine(TempTrkgItemLedgEntry,ItemLedgEntryBuf)
                            //    ELSE BEGIN
                            //      TempItemTrkgEntry.RESET;
                            //      TempItemTrkgEntry.SETCURRENTKEY("Source ID","Source Ref. No.");
                            //      TempItemTrkgEntry.SETRANGE("Source ID","Document No.");
                            //      TempItemTrkgEntry.SETRANGE("Source Ref. No.","Line No.");
                            //      CollectItemTrkgPerPstDocLine(TempItemTrkgEntry,TempTrkgItemLedgEntry,FALSE);
                            //    END;
                            //
                            //    ItemTrackingMgt.CopyItemLedgEntryTrkgToServiceLn(
                            //      TempTrkgItemLedgEntry,ToServiceLine,
                            //      FillExactCostRevLink AND ExactCostRevMandatory,MissingExCostRevLink,
                            //      FromServiceHeader."Prices Including VAT",ToServiceHeader."Prices Including VAT",FALSE);
                            //  END;
                            //END;

                            //Extended texts
                            //CopyServiceInvExtTextToDoc(
                            //  ToServiceHeader,ToServiceLine,FromServiceHeader."Language Code","Shipment No.",
                            //  "Return Receipt Line No.",NextLineNo,"Appl.-from Item Entry" <> 0);
                            //TEST-
                        end;
                    end;
                until Next = 0;
            end;
        end;

        Window.Close;
    end;

    local procedure CopyServiceCrMemoLinesToDoc(ToServiceHeader: Record "Service Header"; var FromServiceCrMemoLine: Record "Service Cr.Memo Line"; var LinesNotCopied: Integer; var MissingExCostRevLink: Boolean)
    var
        ItemLedgEntryBuf: Record "Item Ledger Entry" temporary;
        TempTrkgItemLedgEntry: Record "Item Ledger Entry";
        FromServiceHeader: Record "Service Header";
        FromServiceLine: Record "Service Line";
        FromServiceLine2: Record "Service Line";
        ToServiceLine: Record "Service Line";
        FromServiceLineBuf: Record "Service Line" temporary;
        FromServiceCrMemoHeader: Record "Service Cr.Memo Header";
        TempItemTrkgEntry: Record "Reservation Entry" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        OldCrMemoDocNo: Code[20];
        OldReturnRcptDocNo: Code[20];
        NextLineNo: Integer;
        NextItemTrkgEntryNo: Integer;
        FromLineCounter: Integer;
        ToLineCounter: Integer;
        CopyItemTrkg: Boolean;
        SplitLine: Boolean;
        FillExactCostRevLink: Boolean;
    begin
        MissingExCostRevLink := false;
        InitCurrency(ToServiceHeader."Currency Code");
        FromServiceLineBuf.Reset;
        FromServiceLineBuf.DeleteAll;
        TempItemTrkgEntry.Reset;
        TempItemTrkgEntry.DeleteAll;
        OpenWindow;

        // Fill Service line buffer
        with FromServiceCrMemoLine do
            if FindSet then
                repeat
                    FromLineCounter := FromLineCounter + 1;
                    if IsTimeForUpdate then
                        Window.Update(1, FromLineCounter);
                    if FromServiceCrMemoHeader."No." <> "Document No." then begin
                        FromServiceCrMemoHeader.Get("Document No.");
                        TransferOldExtLines.ClearLineNumbers;
                    end;
                    FromServiceHeader.TransferFields(FromServiceCrMemoHeader);
                    //TEST+
                    //Copy item tracking
                    //FillExactCostRevLink :=
                    //  IsServiceFillExactCostRevLink(ToServiceHeader,3,FromServiceHeader."Currency Code");
                    //TEST-
                    FromServiceLine.TransferFields(FromServiceCrMemoLine);
                    FromServiceLine."Appl.-from Item Entry" := 0;
                    // Reuse fields to buffer credit memo line information
                    FromServiceLine."Shipment No." := "Document No.";
                    FromServiceLine."Shipment Line No." := 0;
                    //TEST+
                    //Copy item tracking
                    //SplitLine := TRUE;
                    //GetItemLedgEntries(ItemLedgEntryBuf,TRUE);
                    //IF NOT SplitPstdServiceLinesPerILE(
                    //     ToServiceHeader,FromServiceHeader,ItemLedgEntryBuf,FromServiceLineBuf,
                    //     FromServiceLine,NextLineNo,CopyItemTrkg,MissingExCostRevLink,FillExactCostRevLink,FALSE)
                    //THEN
                    //  IF CopyItemTrkg THEN
                    //    SplitLine :=
                    //      SplitServiceDocLinesPerItemTrkg(
                    //        ItemLedgEntryBuf,TempItemTrkgEntry,FromServiceLineBuf,
                    //        FromServiceLine,NextLineNo,NextItemTrkgEntryNo,MissingExCostRevLink,FALSE)
                    //  ELSE
                    //TEST-
                    SplitLine := false;

                    if not SplitLine then begin
                        FromServiceLine2 := FromServiceLineBuf;
                        FromServiceLineBuf := FromServiceLine;
                        FromServiceLineBuf."Document No." := FromServiceLine2."Document No.";
                        FromServiceLineBuf."Shipment Line No." := FromServiceLine2."Shipment Line No.";
                        FromServiceLineBuf."Line No." := NextLineNo;
                        NextLineNo := NextLineNo + 1;
                        //ReCalcServiceLine(FromServiceHeader,ToServiceHeader,FromServiceLineBuf);
                        FromServiceLineBuf.Insert;
                    end;

                until Next = 0;

        // Create Service line from buffer
        Window.Update(1, FromLineCounter);
        with FromServiceLineBuf do begin
            // Sorting according to Service Line Document No.,Line No.
            SetCurrentKey("Document Type", "Document No.", "Line No.");
            if FindSet then begin
                NextLineNo := GetLastToServiceLineNo(ToServiceHeader);
                repeat
                    ToLineCounter := ToLineCounter + 1;
                    if IsTimeForUpdate then
                        Window.Update(2, ToLineCounter);
                    if "Shipment No." <> OldCrMemoDocNo then begin
                        OldCrMemoDocNo := "Shipment No.";
                        OldReturnRcptDocNo := '';
                        InsertOldServiceDocNoLine(ToServiceHeader, OldCrMemoDocNo, 4, NextLineNo);
                    end;
                    if ("Document No." <> OldReturnRcptDocNo) and ("Shipment Line No." > 0) then begin
                        OldReturnRcptDocNo := "Document No.";
                        InsertOldServiceCombDocNoLine(ToServiceHeader, OldCrMemoDocNo, OldReturnRcptDocNo, NextLineNo, false);
                    end;

                    if (Type <> Type::" ") or ("Attached to Line No." = 0) then begin
                        // Empty buffer fields
                        FromServiceLine2 := FromServiceLineBuf;
                        FromServiceLine2."Shipment No." := '';
                        FromServiceLine2."Shipment Line No." := 0;

                        if CopyServiceLine(
                             ToServiceHeader, ToServiceLine, FromServiceHeader,
                             FromServiceLine2, NextLineNo, LinesNotCopied, true, 0)
                        then begin
                            //TEST+
                            //FromServiceCrMemoLine.GET("Shipment No.","Return Receipt Line No.");

                            //Copy item tracking
                            //IF (Type = Type::Item) AND (Quantity <> 0) THEN BEGIN
                            //  FromServiceCrMemoLine."Document No." := OldCrMemoDocNo;
                            //  FromServiceCrMemoLine."Line No." := "Return Receipt Line No.";
                            //  FromServiceCrMemoLine.GetItemLedgEntries(ItemLedgEntryBuf,TRUE);
                            //  IF IsCopyItemTrkg(ItemLedgEntryBuf,CopyItemTrkg,FillExactCostRevLink) THEN BEGIN
                            //    IF MoveNegLines OR NOT ExactCostRevMandatory THEN
                            //      ItemTrackingMgt.CollectItemTrkgPerPstdDocLine(TempTrkgItemLedgEntry,ItemLedgEntryBuf)
                            //    ELSE BEGIN
                            //      TempItemTrkgEntry.RESET;
                            //      TempItemTrkgEntry.SETCURRENTKEY("Source ID","Source Ref. No.");
                            //      TempItemTrkgEntry.SETRANGE("Source ID","Document No.");
                            //      TempItemTrkgEntry.SETRANGE("Source Ref. No.","Line No.");
                            //      CollectItemTrkgPerPstDocLine(TempItemTrkgEntry,TempTrkgItemLedgEntry,FALSE);
                            //    END;
                            //
                            //    ItemTrackingMgt.CopyItemLedgEntryTrkgToServiceLn(
                            //      TempTrkgItemLedgEntry,ToServiceLine,
                            //      FillExactCostRevLink AND ExactCostRevMandatory,MissingExCostRevLink,
                            //      FromServiceHeader."Prices Including VAT",ToServiceHeader."Prices Including VAT",FALSE);
                            //  END;
                            //END;

                            //Extended texts
                            //CopyServiceCrMemoExtTextToDoc(
                            //  ToServiceHeader,ToServiceLine,FromServiceHeader."Language Code","Shipment No.",
                            //  "Return Receipt Line No.",NextLineNo,"Appl.-from Item Entry" <> 0);
                            //TEST-
                        end;
                    end;
                until Next = 0;
            end;
        end;

        Window.Close;
    end;

    local procedure CheckItemAvailableService(var ToServiceHeader: Record "Service Header"; var ToServiceLine: Record "Service Line")
    begin
        if HideDialog then
            exit;

        ToServiceLine."Document Type" := ToServiceHeader."Document Type";
        ToServiceLine."Document No." := ToServiceHeader."No.";
        ToServiceLine.Type := ToServiceLine.Type::Item;

        if ServiceItemCheckAvail.ServiceLineCheck(ToServiceLine, true) then
            ServiceItemCheckAvail.RaiseUpdateInterruptedError;
    end;

    local procedure UpdateServiceLine(var ToServiceHeader: Record "Service Header"; var ToServiceLine: Record "Service Line"; var FromServiceHeader: Record "Service Header"; var FromServiceLine: Record "Service Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean)
    var
        GLAcc: Record "G/L Account";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if RecalculateLines and not FromServiceLine."System-Created Entry" then begin
            ToServiceLine.Validate(Type, FromServiceLine.Type);
            ToServiceLine.Validate(Description, FromServiceLine.Description);
            ToServiceLine.Validate("Description 2", FromServiceLine."Description 2");
            if (FromServiceLine.Type <> 0) and (FromServiceLine."No." <> '') then begin
                if ToServiceLine.Type = ToServiceLine.Type::"G/L Account" then begin
                    ToServiceLine."No." := FromServiceLine."No.";
                    if GLAcc."No." <> FromServiceLine."No." then
                        GLAcc.Get(FromServiceLine."No.");
                    CopyThisLine := GLAcc."Direct Posting";
                    if CopyThisLine then
                        ToServiceLine.Validate("No.", FromServiceLine."No.");
                end else
                    ToServiceLine.Validate("No.", FromServiceLine."No.");
                ToServiceLine.Validate("Variant Code", FromServiceLine."Variant Code");
                ToServiceLine.Validate("Location Code", FromServiceLine."Location Code");
                ToServiceLine.Validate("Unit of Measure", FromServiceLine."Unit of Measure");
                ToServiceLine.Validate("Unit of Measure Code", FromServiceLine."Unit of Measure Code");
                ToServiceLine.Validate(Quantity, FromServiceLine.Quantity);

                if not (FromServiceLine.Type in [FromServiceLine.Type::Item, FromServiceLine.Type::Resource]) then begin
                    if (FromServiceHeader."Currency Code" <> ToServiceHeader."Currency Code") or
                       (FromServiceHeader."Prices Including VAT" <> ToServiceHeader."Prices Including VAT")
                    then begin
                        ToServiceLine."Unit Price" := 0;
                        ToServiceLine."Line Discount %" := 0;
                    end else begin
                        ToServiceLine.Validate("Unit Price", FromServiceLine."Unit Price");
                        ToServiceLine.Validate("Line Discount %", FromServiceLine."Line Discount %");
                    end;
                    if ToServiceLine.Quantity <> 0 then
                        ToServiceLine.Validate("Line Discount Amount", FromServiceLine."Line Discount Amount");
                end;
                ToServiceLine.Validate("Work Type Code", FromServiceLine."Work Type Code");
            end;
            if (FromServiceLine.Type = FromServiceLine.Type::" ") and (FromServiceLine."No." <> '') then
                ToServiceLine.Validate("No.", FromServiceLine."No.");
        end else begin
            SetDefaultValuesToServiceLine(ToServiceLine, ToServiceHeader, FromServiceLine."VAT Difference");
            if RecalculateAmount and (FromServiceLine."Appl.-from Item Entry" = 0) then begin
                if (ToServiceLine.Type <> ToServiceLine.Type::" ") and (ToServiceLine."No." <> '') then begin
                    ToServiceLine.Validate("Line Discount %", FromServiceLine."Line Discount %");
                    ToServiceLine.Validate(
                      "Inv. Discount Amount", Round(FromServiceLine."Inv. Discount Amount", Currency."Amount Rounding Precision"));
                end;
                ToServiceLine.Validate("Unit Cost (LCY)", FromServiceLine."Unit Cost (LCY)");
            end;
            if VATPostingSetup.Get(ToServiceLine."VAT Bus. Posting Group", ToServiceLine."VAT Prod. Posting Group") then
                ToServiceLine."VAT Identifier" := VATPostingSetup."VAT Identifier";

            if (ToServiceLine.Type = ToServiceLine.Type::Item) and (ToServiceLine."No." <> '') then begin
                GetItem(ToServiceLine."No.");
                if (Item."Costing Method" = Item."Costing Method"::Standard) and not ToServiceLine.IsShipment then
                    ToServiceLine.GetUnitCost;

                if Item.Reserve = Item.Reserve::Optional then
                    ToServiceLine.Reserve := ToServiceHeader.Reserve
                else
                    ToServiceLine.Reserve := Item.Reserve;
            end;
        end;
    end;

    local procedure InitCurrency(CurrencyCode: Code[10])
    begin
        if CurrencyCode <> '' then
            Currency.Get(CurrencyCode)
        else
            Currency.InitRoundingPrecision;

        Currency.TestField("Unit-Amount Rounding Precision");
        Currency.TestField("Amount Rounding Precision");
    end;

    local procedure OpenWindow()
    begin
        Window.Open(
          Text008 +
          Text009 +
          Text010);
        WindowUpdateDateTime := CurrentDateTime;
    end;

    local procedure IsTimeForUpdate(): Boolean
    begin
        if CurrentDateTime - WindowUpdateDateTime >= 1000 then begin
            WindowUpdateDateTime := CurrentDateTime;
            exit(true);
        end;
        exit(false);
    end;

    local procedure GetLastToServiceLineNo(ToServiceHeader: Record "Service Header"): Decimal
    var
        ToServiceLine: Record "Service Line";
    begin
        ToServiceLine.LockTable;
        ToServiceLine.SetRange("Document Type", ToServiceHeader."Document Type");
        ToServiceLine.SetRange("Document No.", ToServiceHeader."No.");
        if ToServiceLine.FindLast then
            exit(ToServiceLine."Line No.");
        exit(0);
    end;

    local procedure InsertOldServiceDocNoLine(ToServiceHeader: Record "Service Header"; OldDocNo: Code[20]; OldDocType: Integer; var NextLineNo: Integer)
    var
        ToServiceLine2: Record "Service Line";
    begin
        if SkipCopyFromDescription then
            exit;

        NextLineNo := NextLineNo + 10000;
        ToServiceLine2.Init;
        ToServiceLine2."Line No." := NextLineNo;
        ToServiceLine2."Document Type" := ToServiceHeader."Document Type";
        ToServiceLine2."Document No." := ToServiceHeader."No.";
        ToServiceLine2.Description := StrSubstNo(Text011, SelectStr(OldDocType, Text012), OldDocNo);
        ToServiceLine2.Insert;
    end;

    local procedure InsertOldServiceCombDocNoLine(ToServiceHeader: Record "Service Header"; OldDocNo: Code[20]; OldDocNo2: Code[20]; var NextLineNo: Integer; CopyFromInvoice: Boolean)
    var
        ToServiceLine2: Record "Service Line";
    begin
        NextLineNo := NextLineNo + 10000;
        ToServiceLine2.Init;
        ToServiceLine2."Line No." := NextLineNo;
        ToServiceLine2."Document Type" := ToServiceHeader."Document Type";
        ToServiceLine2."Document No." := ToServiceHeader."No.";
        if CopyFromInvoice then
            ToServiceLine2.Description :=
              StrSubstNo(
                Text013,
                CopyStr(SelectStr(1, Text014) + OldDocNo, 1, 23),
                CopyStr(SelectStr(2, Text014) + OldDocNo2, 1, 23))
        else
            ToServiceLine2.Description :=
              StrSubstNo(
                Text013,
                CopyStr(SelectStr(3, Text014) + OldDocNo, 1, 23),
                CopyStr(SelectStr(4, Text014) + OldDocNo2, 1, 23));
        ToServiceLine2.Insert;
    end;

    local procedure SetDefaultValuesToServiceLine(var ToServiceLine: Record "Service Line"; ToServiceHeader: Record "Service Header"; VATDifference: Decimal)
    begin
        ToServiceLine."Quantity Shipped" := 0;
        ToServiceLine."Qty. Shipped (Base)" := 0;
        ToServiceLine."Quantity Invoiced" := 0;
        ToServiceLine."Qty. Invoiced (Base)" := 0;
        ToServiceLine."Reserved Quantity" := 0;
        ToServiceLine."Reserved Qty. (Base)" := 0;
        ToServiceLine."Qty. to Ship" := 0;
        ToServiceLine."Qty. to Ship (Base)" := 0;
        ToServiceLine."Qty. to Invoice" := 0;
        ToServiceLine."Qty. to Invoice (Base)" := 0;
        ToServiceLine."Qty. Shipped Not Invoiced" := 0;
        ToServiceLine."Shipped Not Invoiced" := 0;
        ToServiceLine."Qty. Shipped Not Invd. (Base)" := 0;
        ToServiceLine."Shipped Not Invoiced (LCY)" := 0;
        ToServiceLine."Job No." := '';
        ToServiceLine."Job Task No." := '';
        ToServiceLine.InitOutstanding;
        if ToServiceLine."Document Type" in
           [ToServiceLine."Document Type"::"Credit Memo"]
        then begin
            ToServiceLine.InitQtyToInvoice;
        end else
            ToServiceLine.InitQtyToShip;
        ToServiceLine."VAT Difference" := VATDifference;
        ToServiceLine."Appl.-from Item Entry" := 0;
        ToServiceLine."Appl.-to Item Entry" := 0;
    end;

    local procedure GetItem(ItemNo: Code[20])
    begin
        if ItemNo <> Item."No." then
            if not Item.Get(ItemNo) then
                Item.Init;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCopyServiceDoc(FromDocType: Option; FromDocNo: Code[20]; var ToServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyServiceDoc(FromDocType: Option; FromDocNo: Code[20]; var ToServiceHeader: Record "Service Header")
    begin
    end;
}

