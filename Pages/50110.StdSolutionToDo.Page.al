page 50110 "AUZ Std. Solution To-Do"
{
    AutoSplitKey = true;
    Caption = 'To-do';
    DelayedInsert = true;
    PageType = ListPart;
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
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;

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