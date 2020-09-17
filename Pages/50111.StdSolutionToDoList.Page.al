page 50111 "AUZ Std. Solution To-Do List"
{
    AutoSplitKey = true;
    Caption = 'To-do';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "AUZ Standard Solution To-do";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Version Code"; "Version Code")
                {
                    ApplicationArea = All;
                }
                field(Completed; Completed)
                {
                    ApplicationArea = All;
                }
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}