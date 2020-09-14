pageextension 90028 "AUZ Purchase Invoice" extends "Purchase Invoice"
{
    // *** Auzilium AS ***
    // AZ10001 10.05.2014 EVA Moved KID and other fiels for accounting.
    layout
    {
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(KID)
        {
            Visible = false;
        }
        addafter("Document Date")
        {
            field("Due Date"; "Due Date")
            {
                Importance = Promoted;
            }
        }
        addafter("Vendor Invoice No.")
        {
            field(KID; KID)
            {
            }
            field("Recipient Bank Account No."; "Recipient Bank Account No.")
            {
            }
            field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {

                trigger OnValidate()
                begin
                    ShortcutDimension1CodeOnAfterV;
                end;
            }
            field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {

                trigger OnValidate()
                begin
                    ShortcutDimension2CodeOnAfterV;
                end;
            }
            field("Payment Terms Code"; "Payment Terms Code")
            {
                Importance = Promoted;
            }
        }
    }
}

