page 90007 "Case Resource List"
{
    Caption = 'Case Resources';
    PageType = List;
    SourceTable = "Case Resource";

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

