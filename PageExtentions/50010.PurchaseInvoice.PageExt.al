pageextension 50010 "AUZ Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("AUZ Recipient Bank Account No."; "AUZ Recipient Bank Account No.")
            {
                ApplicationArea = All;
            }
        }

        moveafter("Vendor Invoice No."; KID, "Payment Terms Code")
        moveafter("Document Date"; "Due Date")

        modify(KID)
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