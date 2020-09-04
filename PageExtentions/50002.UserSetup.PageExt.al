pageextension 90004 pageextension90004 extends "User Setup"
{
    // *** Auzilium AS ***
    // AZ99999 11.11.2016 HHV Added field "Show in Case Hours Chart".
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Resource No."; "Resource No.")
            {
            }
        }
        addafter(Email)
        {
            field(Consultant; Consultant)
            {
            }
            field(Developer; Developer)
            {
            }
        }
    }
}

