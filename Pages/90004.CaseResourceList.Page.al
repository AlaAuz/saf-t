page 90004 "Case Resource List"
{
    Caption = 'Case Resources';
    PageType = List;
    SourceTable = "AUZ Case Resource";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

