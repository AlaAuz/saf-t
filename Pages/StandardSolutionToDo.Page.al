page 90110 "Standard Solution To-Do"
{
    AutoSplitKey = true;
    Caption = 'To-do';
    DelayedInsert = true;
    PageType = ListPart;
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
                field("Case No."; "Case No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Completed)
            {
                Caption = 'Completed';
                Image = Completed;

                trigger OnAction()
                begin
                    if not Confirm(CompletedQst) then
                        Error('');
                    Validate(Completed, true);
                    CurrPage.Update(true);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;

    var
        CompletedQst: Label 'Is the task completed?';
}

