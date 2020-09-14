page 90108 "Standard Solution Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 08.10.2017 HHV Added file management code. (AZ99999)

    Caption = 'Standard Solution List';
    PageType = Card;
    SourceTable = "Standard Solution";
    SourceTableView = SORTING ("Start ID", "End ID");

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Standard;
                }
                field("Solution No."; "Solution No.")
                {
                }
                field(Name; Name)
                {
                    Importance = Additional;
                }
                field(Description; Description)
                {
                    Importance = Promoted;
                }
                group("Ansvarlig ressurs")
                {
                    Caption = 'Responsible Resource';
                    field("Responsible Resource No."; "Responsible Resource No.")
                    {
                        Caption = 'No.';
                        Importance = Additional;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Responsible Resource Name"; "Responsible Resource Name")
                    {
                        Caption = 'Name';
                        Importance = Promoted;
                    }
                }
                group(Utdatert)
                {
                    Caption = 'Obsolete';
                    field("Obsolete State"; "Obsolete State")
                    {
                        Caption = 'State';
                    }
                    field("Obsolete Reason"; "Obsolete Reason")
                    {
                        Caption = 'Reason';
                    }
                }
                field("Last Version Code"; "Last Version Code")
                {
                    Importance = Additional;
                }
                field("No of Versions"; "No of Versions")
                {
                    Importance = Promoted;
                }
                field("Date Created"; "Date Created")
                {
                    Importance = Additional;
                }
                field("Date Modified"; "Date Modified")
                {
                    Importance = Additional;
                }
                group("Utvidet beskrivelse")
                {
                    Caption = 'Extended Description';
                    field(ExtededDescription; ExtededDescription)
                    {
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
                    }
                    field("Start ID"; "Start ID")
                    {
                        BlankZero = true;
                        Importance = Promoted;
                    }
                    field("End ID"; "End ID")
                    {
                        BlankZero = true;
                        Importance = Promoted;
                    }
                }
                group(AppSource)
                {
                    Caption = 'AppSource';
                    field("AppSource Prefix / Suffix"; "AppSource Prefix / Suffix")
                    {
                        Caption = 'Prefix / Suffix';
                    }
                    field("AppSource Start ID"; "AppSource Start ID")
                    {
                        BlankZero = true;
                        Caption = 'Start ID';
                    }
                    field("AppSource End ID"; "AppSource End ID")
                    {
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
                }
                field(Type; Type)
                {
                    Importance = Promoted;
                }
                field("Object Type"; "Object Type")
                {
                    Importance = Promoted;
                }
                field(Importance; Importance)
                {
                    Importance = Additional;
                }
                field("3. Part Integration"; "3. Part Integration")
                {
                    Importance = Additional;
                }
            }
            part(Control1000000029; "Standard Solution Fields")
            {
                SubPageLink = "Standard Solution No." = FIELD ("No.");
            }
            part(Control1000000017; "Standard Solution Releases")
            {
                SubPageLink = "Standard Solution No." = FIELD ("No.");
            }
            part(Control1000000025; "Standard Solution To-Do")
            {
                SubPageLink = "Standard Solution No." = FIELD ("No."),
                              Completed = CONST (false);
            }
        }
        area(factboxes)
        {
            part(ExtFileMgtFactBox; "External File FactBox")
            {
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

    trigger OnAfterGetCurrRecord()
    begin
        //AZ99999+
        CurrPage.ExtFileMgtFactBox.PAGE.SetRec(Rec);
        //AZ99999-
    end;

    trigger OnAfterGetRecord()
    begin
        ExtededDescription := GetExtededDescription;
    end;

    var
        ExtededDescription: Text;
}

