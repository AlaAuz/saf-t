page 90112 "Standard Solution List"
{
    Caption = 'Standard Solutions';
    CardPageID = "Standard Solution Card";
    Editable = false;
    PageType = List;
    SourceTable = "AUZ Standard Solution";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Style = Strong;
                    StyleExpr = Importance = Importance::High;
                }
                field(Name; Name)
                {
                }
                field(Description; Description)
                {
                }
                field("Responsible Resource No."; "Responsible Resource No.")
                {
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
            action("Underløsninger")
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
        }
    }

    trigger OnOpenPage()
    begin
        SetFilter("Obsolete State", '<>%1', "Obsolete State"::Removed);
    end;
}

