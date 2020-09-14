pageextension 90048 "AUZ Sales Invoice List" extends "Sales Invoice List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
    }
}

