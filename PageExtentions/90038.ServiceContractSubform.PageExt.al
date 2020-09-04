pageextension 90038 pageextension90038 extends "Service Contract Subform"
{
    // *** Auzilium AS ***
    // AZ99999 02.07.2018 DHG Starting Date to editable = TRUE.
    layout
    {
        modify("Starting Date")
        {
            Editable = true;
        }
        addafter("Item No.")
        {
            field(Quantity; Quantity)
            {
            }
            field("Unit Cost"; "Unit Cost")
            {
            }
            field("Sales Price"; "Sales Price")
            {
            }
        }
    }
}

