page 50108 "AUZ Std. Solution Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 08.10.2017 HHV Added file management code. (AZ99999)

    Caption = 'Standard Solution List';
    PageType = Card;
    SourceTable = "AUZ Standard Solution";
    SourceTableView = SORTING("Start ID", "End ID");

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                }
                field("Solution No."; "Solution No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                group("Ansvarlig ressurs")
                {
                    Caption = 'Responsible Resource';
                    field("Responsible Resource No."; "Responsible Resource No.")
                    {
                        Caption = 'No.';
                        ApplicationArea = All;
                        Importance = Additional;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Responsible Resource Name"; "Responsible Resource Name")
                    {
                        Caption = 'Name';
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                }
                group(Utdatert)
                {
                    Caption = 'Obsolete';
                    field("Obsolete State"; "Obsolete State")
                    {
                        Caption = 'State';
                        ApplicationArea = All;
                    }
                    field("Obsolete Reason"; "Obsolete Reason")
                    {
                        Caption = 'Reason';
                        ApplicationArea = All;
                    }
                }
                field("Last Version Code"; "Last Version Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No of Versions"; "No of Versions")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Date Modified"; "Date Modified")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                group("Utvidet beskrivelse")
                {
                    Caption = 'Extended Description';
                    field(ExtededDescription; ExtededDescription)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            SetExtededDescription(ExtededDescription);
                        end;
                    }
                }
            }
            group(Utvikling)
            {
                Caption = 'Development';
                group("OnPrem/Cloud")
                {
                    Caption = 'OnPrem/Cloud';
                    field("Prefix / Suffix"; "Prefix / Suffix")
                    {
                        ApplicationArea = All;
                    }
                    field("Start ID"; "Start ID")
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Importance = Promoted;
                    }
                    field("End ID"; "End ID")
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Importance = Promoted;
                    }
                }
                group(AppSource)
                {
                    Caption = 'AppSource';
                    field("AppSource Prefix / Suffix"; "AppSource Prefix / Suffix")
                    {
                        ApplicationArea = All;
                        Caption = 'Prefix / Suffix';
                    }
                    field("AppSource Start ID"; "AppSource Start ID")
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Caption = 'Start ID';
                    }
                    field("AppSource End ID"; "AppSource End ID")
                    {
                        ApplicationArea = All;
                        BlankZero = true;
                        Caption = 'End ID';
                    }
                }
            }
            group("Utdaterte felter")
            {
                Caption = 'Obsolete Fields';
                field("Version Tag"; "Version Tag")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Importance; Importance)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("3. Part Integration"; "3. Part Integration")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
            }
            part(Control1000000029; "AUZ Std. Solution Fields")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("No.");
            }
            part(Control1000000017; "AUZ Std. Solution Releases")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("No.");
            }
            part(Control1000000025; "AUZ Std. Solution To-Do")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("No."),
                              Completed = CONST(false);
            }
        }
        area(factboxes)
        {
            /*part(AFMFileFactBox; "AFM File FactBox")
            {
                ApplicationArea = All;
            } */
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
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case List";
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

    trigger OnAfterGetCurrRecord()
    begin
        //AZ99999+
        //CurrPage.AFMFileFactBox.PAGE.SetRecordVariant(Rec);
        //AZ99999-
    end;

    trigger OnAfterGetRecord()
    begin
        ExtededDescription := GetExtededDescription;
    end;

    var
        ExtededDescription: Text;
}

