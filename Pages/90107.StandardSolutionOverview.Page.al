page 90107 "Standard Solution Overview"
{
    Caption = 'Standard Solution Overview';
    CardPageID = "Standard Solution Card";
    Editable = false;
    PageType = List;
    SourceTable = "AUZ Standard Solution";
    SourceTableView = SORTING ("Solution No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = Indentation;
                IndentationControls = "No.";
                ShowAsTree = true;
                field("No."; "No.")
                {
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field(Name; Name)
                {
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field(Description; Description)
                {
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field("Responsible Resource No."; "Responsible Resource No.")
                {
                    Visible = false;
                }
                field("Responsible Resource Name"; "Responsible Resource Name")
                {
                    Visible = false;
                }
                field(Importance; Importance)
                {
                    Style = Strong;
                    StyleExpr = Importance = Importance::High;
                    Visible = false;
                }
                field(Type; Type)
                {
                    Visible = false;
                }
                field("Object Type"; "Object Type")
                {
                    Visible = false;
                }
                field("Prefix / Suffix"; "Prefix / Suffix")
                {
                }
                field("Start ID"; "Start ID")
                {
                    BlankZero = true;
                }
                field("End ID"; "End ID")
                {
                    BlankZero = true;
                }
                field("AppSource Prefix / Suffix"; "AppSource Prefix / Suffix")
                {
                    Visible = false;
                }
                field("AppSource Start ID"; "AppSource Start ID")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("AppSource End ID"; "AppSource End ID")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("No of Versions"; "No of Versions")
                {
                }
                field("Last Version Code"; "Last Version Code")
                {
                }
                field("Date Created"; "Date Created")
                {
                    Visible = false;
                }
                field("Date Modified"; "Date Modified")
                {
                    Visible = false;
                }
                field("3. Part Integration"; "3. Part Integration")
                {
                    Visible = false;
                }
                field("Obsolete State"; "Obsolete State")
                {
                    BlankZero = true;
                }
                field("Obsolete Reason"; "Obsolete Reason")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Liste)
            {
                Caption = 'List';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Standard Solution List";
            }
            action(Saker)
            {
                Caption = 'Cases';
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Case List";
                RunPageLink = "Standard Solution No." = FIELD ("No.");
            }
            action(Felt)
            {
                Caption = 'Fields';
                Image = SelectField;
                RunObject = Page "Standard Solution Field List";
                RunPageLink = "Standard Solution No." = FIELD ("No.");
            }
            action(Utgivelser)
            {
                Caption = 'Releases';
                Image = Versions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Standard Solution Release List";
                RunPageLink = "Standard Solution No." = FIELD ("No.");
            }
            action(Oppgaver)
            {
                Caption = 'To-do';
                Image = TaskList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Standard Solution To-Do List";
                RunPageLink = "Standard Solution No." = FIELD ("No.");
            }
            action(SubSolutions)
            {
                Caption = 'Sub Solutions';
                Image = BOMVersions;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowSubSolutions;
                end;
            }
            action(Files)
            {
                Caption = 'Files';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ShowFileEntries;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if "Solution No." in ['', "No."] then
            Indentation := 0
        else
            Indentation := 1;
    end;

    trigger OnOpenPage()
    begin
        SetRange("3. Part Integration", false);
    end;
}

