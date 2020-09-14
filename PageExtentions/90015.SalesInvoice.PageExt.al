pageextension 90015 "AUZ Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("EU 3-Party Trade")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
        addafter(Control1900316107)
        {
            part(Control100000000; "Sales Case FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD ("Case No.");
            }
        }
    }
}

