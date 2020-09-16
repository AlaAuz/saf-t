pageextension 50003 "AUZ User Setup" extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("AUZ Resource No."; "AUZ Resource No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Email)
        {
            field("AUZ Consultant"; "AUZ Consultant")
            {
                ApplicationArea = All;
            }
            field("AUZ Developer"; "AUZ Developer")
            {
                ApplicationArea = All;
            }
        }
    }
}

