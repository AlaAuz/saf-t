report 50006 "Move Vendor Bank Info"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MoveVendorBankInfo.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {

            trigger OnAfterGetRecord()
            begin
                VendorBankAccount.Init;
                VendorBankAccount."Vendor No." := "No.";
                VendorBankAccount.Code := 'STD';
                VendorBankAccount.Name := Vendor."Bank Name";
                VendorBankAccount.Address := Vendor."Bank Address 1";
                VendorBankAccount."Address 2" := Vendor."Bank Address 2";

                if CopyStr(Vendor."Recipient Bank Account No.", 1, 2) = Vendor."Rcpt. Bank Country/Region Code" then
                    VendorBankAccount.IBAN := Vendor."Recipient Bank Account No."
                else
                    VendorBankAccount."Bank Account No." := Vendor."Recipient Bank Account No.";

                VendorBankAccount."Country/Region Code" := Vendor."Rcpt. Bank Country/Region Code";
                VendorBankAccount."SWIFT Code" := Vendor.SWIFT;

                VendorBankAccount.Insert;
                Vendor."Preferred Bank Account Code" := VendorBankAccount.Code;
                Modify;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VendorBankAccount: Record "Vendor Bank Account";
}

