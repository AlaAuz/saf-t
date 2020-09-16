pageextension 50012 "AUZ Service Contract Subform" extends "Service Contract Subform"
{
    layout
    {
        modify("Starting Date")
        {
            Editable = true;
        }
        addafter("Item No.")
        {
            field("AUZ Quantity"; "AUZ Quantity")
            {
                ApplicationArea = All;
            }
            field("AUZ Unit Cost"; "AUZ Unit Cost")
            {
                ApplicationArea = All;
            }
            field("AUZ Sales Price"; "AUZ Sales Price")
            {
                ApplicationArea = All;
            }
        }
    }
}

