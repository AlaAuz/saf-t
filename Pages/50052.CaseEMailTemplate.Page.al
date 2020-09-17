page 50052 "AUZ Case E-Mail Template"
{
    Caption = 'Case E-Mail Template';
    LinksAllowed = false;
    PageType = Document;
    SourceTable = "AUZ Case E-Mail Template";

    layout
    {
        area(content)
        {
            group("E-post")
            {
                Caption = 'Email';
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Internal; Internal)
                {
                    ApplicationArea = All;
                }
                group(Til)
                {
                    Caption = 'To';
                    Enabled = Internal;
                    Visible = Internal;
                    field("To Resources"; "To Resources")
                    {
                        Caption = 'Resources';
                        ApplicationArea = All;
                    }
                    field("To Consultant"; "To Consultant")
                    {
                        Caption = 'Salesperson';
                        ApplicationArea = All;
                    }
                    field("To Developer"; "To Developer")
                    {
                        Caption = 'Developer';
                        ApplicationArea = All;
                    }
                    field("To Development Admin."; "To Development Admin.")
                    {
                        Caption = 'Development Admin.';
                        ApplicationArea = All;
                    }
                }
                group(Emne)
                {
                    Caption = 'Subject';
                    field(Subject; Subject)
                    {
                        ApplicationArea = All;
                    }
                    field("Description in Subject"; "Description in Subject")
                    {
                        Caption = 'Include Description';
                        ApplicationArea = All;
                    }
                    field("Company Name in Subject"; "Company Name in Subject")
                    {
                        Caption = 'Include Contact Company Name';
                        ApplicationArea = All;
                    }
                }
                group(Bakgrunnssending)
                {
                    Caption = 'Background Sending';
                    Visible = false;
                    field("Use Default E-Mail"; "Use Default E-Mail")
                    {

                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if "Use Default E-Mail" then
                                CaseSetup.TestField("Default E-Mail");
                        end;
                    }
                    field(DefaultEmail; DefaultEmail)
                    {
                        Caption = 'Default Email';
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Utseende)
                {
                    Caption = 'Layout';
                    field(MailLayout; MailLayout)
                    {
                        MultiLine = true;
                        ApplicationArea = All;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            SaveMailLayout(MailLayout);
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GetMailLayout(MailLayout);
    end;

    trigger OnInit()
    begin
        CaseSetup.Get;
    end;

    trigger OnOpenPage()
    begin
        DefaultEmail := CaseSetup."Default E-Mail";
    end;

    var
        CaseSetup: Record "AUZ Case Setup";
        MailLayout: Text;
        DefaultEmail: Text;
}