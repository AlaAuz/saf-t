pageextension 50000 pageextension90001 extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Schedule (Total Price)")
        {
            field("Line Amount"; "Line Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amt. Rcd. Not Invoiced")
        {
            field("Budgeted Quantity"; "Budgeted Quantity")
            {
                ApplicationArea = All;
            }
            field("Invoiced Amount"; "Invoiced Amount")
            {
                ApplicationArea = All;
            }
            field("Non-Transferred Case Hours"; "Non-Transferred Case Hours")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
            field("Non-Posted Case Hours"; "Non-Posted Case Hours")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
        }
    }
}

