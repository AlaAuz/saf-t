page 60007 "AUZ Case E-Mail Templates"
{
    Caption = 'Case E-Mail Templates';
    CardPageID = "AUZ Case E-Mail Template";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "AUZ Case E-Mail Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Subject; Subject)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}