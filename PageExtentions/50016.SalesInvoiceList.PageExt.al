pageextension 50016 "AUZ Sales Invoice List" extends "Sales Invoice List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("AUZ Invoicing Period Code"; "AUZ Invoicing Period Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

