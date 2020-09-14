tableextension 90023 "AUZ Purchase Header" extends "Purchase Header"
{
    // **** Auzilium AS ***
    // AZ99999 13.12.2015 EVA Added Recipient Bank Account, enable to modify.
    // 
    // <DC>
    //   Document Capture
    // </DC>
    fields
    {


        //Unsupported feature: Code Modification on ""Pay-to Vendor No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        if (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and
           (xRec."Pay-to Vendor No." <> '')
        #4..60
        Validate("Payment Method Code");
        Validate("Currency Code");
        Validate("Creditor No.",Vend."Creditor No.");

        OnValidatePurchaseHeaderPayToVendorNo(Vend);

        if "Document Type" = "Document Type"::Order then
        #68..91

        if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") then
          RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..63
        //AZ99999+
        "Recipient Bank Account No." := Vend."Recipient Bank Account No.";
        //AZ99999-
        #65..94
        */
        //end;
        field(50001; "Recipient Bank Account No."; Code[35])
        {
            Caption = 'Recipient Bank Account No.';
            Description = 'AZ99999';

            trigger OnValidate()
            var
                RemAccount: Record "Remittance Account";
                RemmTools: Codeunit "Remittance Tools";
                ErrorMess: Text[250];
            begin
                //AZ99999+
                if "Recipient Bank Account No." <> xRec."Recipient Bank Account No." then
                    if Confirm(Text50001) then begin
                        GetVend("Pay-to Vendor No.");
                        RemAccount.Get(Vend."Remittance Account Code");
                        if "Recipient Bank Account No." <> '' then begin
                            ErrorMess := RemmTools.CheckAccountNo("Recipient Bank Account No.", RemAccount.Type);
                            if ErrorMess <> '' then
                                Error(ErrorMess);
                        end;

                        Vend."Recipient Bank Account No." := "Recipient Bank Account No.";
                        Vend.Modify;
                    end else
                        "Recipient Bank Account No." := xRec."Recipient Bank Account No.";
                //AZ99999-
            end;
        }
    }

    procedure CreateSalesOrder()
    var
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
    begin
        CustomerNo := SelectCustomerNo;
        CreateSalesHeader(CustomerNo, Rec, SalesHeader);
        CreateSalesLine(Rec, SalesHeader);
        PAGE.Run(PAGE::"Sales Order", SalesHeader);
    end;

    local procedure SelectCustomerNo(): Code[20]
    var
        Customer: Record Customer;
    begin
        if ACTION::LookupOK = PAGE.RunModal(0, Customer, Customer."No.") then begin
            exit(Customer."No.");
        end;
    end;

    local procedure CreateSalesHeader(CustomerNo: Code[20]; PurchHeader: Record "Purchase Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Init;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader."Posting Date" := PurchHeader."Posting Date";
        SalesHeader.Validate("Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 1 Code");
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLine(PurchHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLine.SetFilter("Document No.", PurchHeader."No.");

        if PurchaseLine.FindSet then
            repeat
                SalesLine.Init;
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := PurchaseLine."Line No.";
                SalesLine.Insert(true);
                SalesLine.Validate(Type, PurchaseLine.Type);
                SalesLine.Validate("No.", PurchaseLine."No.");
                if SalesLine."No." <> '' then begin
                    SalesLine.Validate("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
                    SalesLine.Validate(Quantity, PurchaseLine.Quantity);
                    SalesLine.Validate("Unit Price", PurchaseLine."Direct Unit Cost");
                end;
                SalesLine.Description := PurchaseLine.Description;
                SalesLine.Modify(true);
            until PurchaseLine.Next = 0;
    end;

    var
        Text50001: Label 'Are you sure that you want to update the vendors bank account number.?';
}

