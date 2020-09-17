page 50107 "AUZ Std. Solution Overview"
{
    Caption = 'Standard Solution Overview';
    CardPageID = "AUZ Std. Solution Card";
    Editable = false;
    PageType = List;
    SourceTable = "AUZ Standard Solution";
    SourceTableView = SORTING("Solution No.");

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
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Indentation = 0;
                }
                field("Responsible Resource No."; "Responsible Resource No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Responsible Resource Name"; "Responsible Resource Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Importance; Importance)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Importance = Importance::High;
                    Visible = false;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prefix / Suffix"; "Prefix / Suffix")
                {
                    ApplicationArea = All;
                }
                field("Start ID"; "Start ID")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("End ID"; "End ID")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("AppSource Prefix / Suffix"; "AppSource Prefix / Suffix")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("AppSource Start ID"; "AppSource Start ID")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field("AppSource End ID"; "AppSource End ID")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field("No of Versions"; "No of Versions")
                {
                    ApplicationArea = All;
                }
                field("Last Version Code"; "Last Version Code")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date Modified"; "Date Modified")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("3. Part Integration"; "3. Part Integration")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Obsolete State"; "Obsolete State")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Obsolete Reason"; "Obsolete Reason")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Std. Solution List";
            }
            action(Saker)
            {
                Caption = 'Cases';
                Image = Timesheet;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case List";
                RunPageLink = "Standard Solution No." = FIELD("No.");
            }
            action(Felt)
            {
                Caption = 'Fields';
                Image = SelectField;
                ApplicationArea = All;
                RunObject = Page "AUZ Std. Solution Field List";
                RunPageLink = "Standard Solution No." = FIELD("No.");
            }
            action(Utgivelser)
            {
                Caption = 'Releases';
                Image = Versions;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Std. Solution Release List";
                RunPageLink = "Standard Solution No." = FIELD("No.");
            }
            action(Oppgaver)
            {
                Caption = 'To-do';
                Image = TaskList;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Std. Solution To-Do List";
                RunPageLink = "Standard Solution No." = FIELD("No.");
            }
            action(SubSolutions)
            {
                Caption = 'Sub Solutions';
                Image = BOMVersions;
                ApplicationArea = All;
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
                ApplicationArea = All;
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