tableextension 50011 "AUZ Purchase Header" extends "Purchase Header"
{
    // **** Auzilium AS ***
    // AZ99999 13.12.2015 EVA Added Recipient Bank Account, enable to modify.
    // 
    // <DC>
    //   Document Capture
    // </DC>
    fields
    {
        field(50000; "AUZ Recipient Bank Account No."; Code[35])
        {
            Caption = 'Recipient Bank Account No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RemAccount: Record "Remittance Account";
                Vendor: Record Vendor;
                RemmTools: Codeunit "Remittance Tools";
                ErrorMess: Text[250];
            begin
                //AZ99999+
                if "AUZ Recipient Bank Account No." <> xRec."AUZ Recipient Bank Account No." then
                    if Confirm(Text50001) then begin
                        Vendor.Get("Pay-to Vendor No.");
                        RemAccount.Get(Vendor."Remittance Account Code");
                        if "AUZ Recipient Bank Account No." <> '' then begin
                            ErrorMess := RemmTools.CheckAccountNo("AUZ Recipient Bank Account No.", RemAccount.Type);
                            if ErrorMess <> '' then
                                Error(ErrorMess);
                        end;

                        Vendor."Recipient Bank Account No." := "AUZ Recipient Bank Account No.";
                        Vendor.Modify;
                    end else
                        "AUZ Recipient Bank Account No." := xRec."AUZ Recipient Bank Account No.";
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

