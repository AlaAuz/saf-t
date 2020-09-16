pageextension 50014 "AUZ Job Card" extends "Job Card"
{
    // *** Auzilium AS ***
    // AZ99999 06.02.2018 HHV Added field "Description 2".
    layout
    {
        addafter(Description)
        {
            field("AUZ Description 2"; "Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field("AUZ Blocked for Time Registration"; "AUZ Blocked for Time Registration")
            {
                ApplicationArea = All;
            }
        }
    }
}

