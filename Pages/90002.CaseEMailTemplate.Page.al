page 90002 "Case E-Mail Template"
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
                }
                field(Description; Description)
                {
                }
                field(Internal; Internal)
                {
                }
                group(Til)
                {
                    Caption = 'To';
                    Enabled = Internal;
                    Visible = Internal;
                    field("To Resources"; "To Resources")
                    {
                        Caption = 'Resources';
                    }
                    field("To Consultant"; "To Consultant")
                    {
                        Caption = 'Salesperson';
                    }
                    field("To Developer"; "To Developer")
                    {
                        Caption = 'Developer';
                    }
                    field("To Development Admin."; "To Development Admin.")
                    {
                        Caption = 'Development Admin.';
                    }
                }
                group(Emne)
                {
                    Caption = 'Subject';
                    field(Subject; Subject)
                    {
                    }
                    field("Description in Subject"; "Description in Subject")
                    {
                        Caption = 'Include Description';
                    }
                    field("Company Name in Subject"; "Company Name in Subject")
                    {
                        Caption = 'Include Contact Company Name';
                    }
                }
                group(Bakgrunnssending)
                {
                    Caption = 'Background Sending';
                    Visible = false;
                    field("Use Default E-Mail"; "Use Default E-Mail")
                    {

                        trigger OnValidate()
                        begin
                            if "Use Default E-Mail" then
                                CaseSetup.TestField("Default E-Mail");
                        end;
                    }
                    field(DefaultEmail; DefaultEmail)
                    {
                        Caption = 'Default Email';
                        Editable = false;
                    }
                }
                group(Utseende)
                {
                    Caption = 'Layout';
                    field(MailLayout; MailLayout)
                    {
                        MultiLine = true;
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

    actions
    {
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

