pageextension 50015 "AUZ Job List" extends "Job List"
{
    layout
    {
        addafter("Project Manager")
        {
            field("AUZ Blocked for Time Registration"; "AUZ Blocked for Time Registration")
            {
                ApplicationArea = All;
            }
        }
    }
}

