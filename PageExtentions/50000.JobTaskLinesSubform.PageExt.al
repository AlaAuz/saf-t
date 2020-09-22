/*pageextension 50000 "AUZ Job Task Lines Subform" extends "Job Task Lines Subform"
{
    layout
    {
        addafter("Schedule (Total Price)")
        {
            field("AUZ Line Amount"; "AUZ Line Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Amt. Rcd. Not Invoiced")
        {
            field("AUZ Budgeted Quantity"; "AUZ Budgeted Quantity")
            {
                ApplicationArea = All;
            }
            field("AUZ Invoiced Amount"; "AUZ Invoiced Amount")
            {
                ApplicationArea = All;
            }
            field("AUZ Non-Transferred Case Lines"; "AUZ Non-Transferred Case Lines")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
            field("AUZ Non-Posted Case Lines"; "AUZ Non-Posted Case Lines")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
        }
    }
} */

