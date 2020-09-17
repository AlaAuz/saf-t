pageextension 50006 "AUZ Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("EU 3-Party Trade")
        {
            field("AUZ Invoicing Period Code"; "AUZ Invoicing Period Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Control1900316107)
        {
            part("AUZ Sales Case FactBox"; "AUZ Sales Case FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("AUZ Case No.");
            }
        }
    }
}

