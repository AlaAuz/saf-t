page 90006 "Case E-Mail Templates"
{
    Caption = 'Case E-Mail Templates';
    CardPageID = "Case E-Mail Template";
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Case E-Mail Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Subject; Subject)
                {
                }
            }
        }
    }

    actions
    {
    }
}

