codeunit 70901 "Distribute Sales Invoices"
{
    Permissions = TableData "Sales Invoice Header" = rm;
    TableNo = "Sales Invoice Header";

    trigger OnRun()
    begin
        TryDistributeSalesInvoice(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 invoices?';
        Text002: Label 'Do you want to distribute posted sales invoice %1?';

    local procedure TryDistributeSalesInvoice(SalesInvHeader: Record "Sales Invoice Header")
    var
        TempEInvoiceTransferFile: Record "E-Invoice Transfer File" temporary;
        EInvoiceExportSalesInvoice: Codeunit "E-Invoice Export Sales Invoice";
        EInvoiceExportCommon: Codeunit "E-Invoice Export Common";
    begin
        with SalesInvHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false);
                "Distribution Type"::"E-Mail":
                    EmailRecords(false);
                "Distribution Type"::EHF:
                    begin
                        EInvoiceExportSalesInvoice.Run(SalesInvHeader);
                        EInvoiceExportSalesInvoice.GetExportedFileInfo(TempEInvoiceTransferFile);
                        TempEInvoiceTransferFile."Line No." := 1;
                        TempEInvoiceTransferFile.Insert;
                        EInvoiceExportCommon.DownloadEInvoiceFile(TempEInvoiceTransferFile);
                    end;
            end;
        end;
    end;


    procedure DistributeSalesInvoiceOnAfterPosting(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        Commit;
        if not DistributeSalesInvoice(SalesInvoiceHeader) then
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
    end;


    procedure DistributeSalesInvoices(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with SalesInvoiceHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeSalesInvoice(SalesInvoiceHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeSalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header") DistributionOK: Boolean
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Sales Invoices", SalesInvoiceHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::"Sales Invoice";
        DistributionLogEntry."Document No." := SalesInvoiceHeader."No.";
        DistributionLogEntry.Date := Today;
        if DistributionOK then
            NoOfDistributions += 1
        else begin
            DistributionLogEntry.SetErrorMessage(GetLastErrorText);
            NoOfErrors += 1;
        end;
        DistributionLogEntry.Insert(true);
    end;

    local procedure InitValues()
    begin
        NoOfDistributions := 0;
        NoOfErrors := 0;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure SetDistributionTypeOnAfterValidateBilllToCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order, Rec."Document Type"::Invoice]) then exit;
        if Customer.Get(Rec."Bill-to Customer No.") then;
        Rec."Distribution Type" := Customer."Distribution Type";
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'Disitribute', false, false)]
    local procedure "PostedSalesInvoice.Disitribute"(var Rec: Record "Sales Invoice Header")
    begin
        if not Confirm(Text002, true, Rec."No.") then
            Error('');
        if DistributeSalesInvoice(Rec) then
            DistributionMgt.ShowCompletionMessage(1, 0, 1)
        else
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
        Rec.Find;
    end;

    [EventSubscriber(ObjectType::Page, 132, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedSalesInvoice.ChangeDistributionType"(var Rec: Record "Sales Invoice Header")
    begin
        ChangeSalesInvoiceDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 143, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedSalesInvoices.ChangeDistributionType"(var Rec: Record "Sales Invoice Header")
    begin
        ChangeSalesInvoiceDistributionType(Rec);
    end;

    local procedure ChangeSalesInvoiceDistributionType(var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        if DistributionMgt.SelectDistributionType(SalesInvoiceHeader."Distribution Type") then
            SalesInvoiceHeader.Modify;
    end;
}

