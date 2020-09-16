pageextension 50013 "AUZ Approval User Setup" extends "Approval User Setup"
{
    layout
    {
        addafter("Approval Administrator")
        {
            field("AUZ Development Administrator"; "AUZ Development Administrator")
            {
                ApplicationArea = All;
            }
        }
    }
}

