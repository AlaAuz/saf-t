page 90111 "Standard Solution To-Do List"
{
    AutoSplitKey = true;
    Caption = 'To-do';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Standard Solution To-do";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field("Version Code"; "Version Code")
                {
                }
                field(Completed; Completed)
                {
                }
                field("Case No."; "Case No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}

