page 90207 "Computer Types"
{
    Caption = 'Computer Types';
    PageType = List;
    SourceTable = "Computer Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

