pageextension 50005 "AUZ Customer List" extends "Customer List"
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
        addafter("Sales (LCY)")
        {
            field("AUZ Invoicing Period Code"; "AUZ Invoicing Period Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

