pageextension 50004 "AUZ Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("AUZ Consultant ID"; "AUZ Consultant ID")
            {
                ApplicationArea = All;
            }
            field("AUZ Developer ID"; "AUZ Developer ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Invoice Copies")
        {
            field("AUZ Invoicing Period Code"; "AUZ Invoicing Period Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

