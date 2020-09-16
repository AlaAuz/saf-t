page 50003 "Case Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "AUZ Case Cue";

    layout
    {
        area(content)
        {
            cuegroup("Mine saker")
            {
                Caption = 'My Cases';
                field(Open; Open)
                {
                    ToolTip = 'Shows all open cases';
                }
                field(Running; Running)
                {
                }
                field(Due; Due)
                {
                }
                field(Postponed; Postponed)
                {
                }

                actions
                {
                    action("Ny sak")
                    {
                        Caption = 'New Case';
                        Image = Task;
                        RunObject = Page "Case Card";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Mine åpne saker")
            {
                Caption = 'My Open Cases';
                field("Registered by Me"; "Registered by Me")
                {
                }
                field("Not Started"; "Not Started")
                {
                }
                field("In Progress"; "In Progress")
                {
                }
                field("Waiting for Reply"; "Waiting for Reply")
                {
                }
            }
            cuegroup("Mine prioriterte saker")
            {
                Caption = 'My Priority Cases';
                field("Waiting for Me"; "Waiting for Me")
                {
                }
                field("Ready for Testing"; "Ready for Testing")
                {
                }
                field("Ready for Installation"; "Ready for Installation")
                {
                }
                field("High Priority"; "High Priority")
                {
                }
                field("Promised Delivery"; "Promised Delivery")
                {
                    Caption = 'Promised Delivery (Within 1 Week)';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    //ALA CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

        if UserSetup.Get(UserId) then;

        SetFilter("Resource Filter", StrSubstNo('@*%1*', UserSetup."AUZ Resource No.")); // Used STRSUBSTNO because of bug

        if UserSetup."AUZ Consultant" then begin
            SetRange("Waiting for Filter", "Waiting for Filter"::Consultant);
            SetRange("Consultant Filter", UserSetup."User ID");
        end else
            if UserSetup."AUZ Developer" then begin
                SetRange("Waiting for Filter", "Waiting for Filter"::Developer);
                SetRange("Developer Filter", UserSetup."User ID");
            end;

        SetFilter("Status Filter", '%1|%2|%3', "Status Filter"::"Not Started", "Status Filter"::"In Progress", "Status Filter"::Running);
        SetFilter("Due Date Filter", '>%1&<=%2', 0D, WorkDate);
        SetRange("Promised Delivery Date Filter", CalcDate('<1D>', WorkDate), CalcDate('<1W + 1D>', WorkDate));
    end;

    var
        UserSetup: Record "User Setup";
        //ALA CueSetup: Codeunit "Cue Setup";
}

