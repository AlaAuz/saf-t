page 50055 "AUZ Case Resource List"
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
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}