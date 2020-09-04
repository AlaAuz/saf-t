pageextension 90045 pageextension90045 extends "Job Card"
{
    // *** Auzilium AS ***
    // AZ99999 06.02.2018 HHV Added field "Description 2".
    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
            }
        }
        addafter(Blocked)
        {
            field("Blocked for Time Registration"; "Blocked for Time Registration")
            {
            }
        }
    }
}

