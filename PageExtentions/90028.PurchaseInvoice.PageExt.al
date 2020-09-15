pageextension 90028 "AUZ Purchase Invoice" extends "Purchase Invoice"
{
    // *** Auzilium AS ***
    // AZ10001 10.05.2014 EVA Moved KID and other fiels for accounting.
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Recipient Bank Account No."; "Recipient Bank Account No.")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Vendor Invoice No."; KID, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Payment Terms Code")
        moveafter("Document Date"; "Due Date")

        modify(KID)
        {
            Visible = false;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;

            //ALA
            /*trigger OnValidate()
            begin
                ShortcutDimension1CodeOnAfterV;
            end; */
        }

        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
            //ALA
            /*
            trigger OnValidate()
            begin
                ShortcutDimension2CodeOnAfterV;
            end; */
        }

        modify("Payment Terms Code")
        {
            Importance = Promoted;
            Visible = false;

        }

        modify("Due Date")
        {
            Importance = Promoted;
            Visible = false;

        }

    }
}