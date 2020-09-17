page 50050 "AUZ Case List"
{
    ApplicationArea = All;
    Caption = 'Case List';
    CardPageID = "AUZ Case Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Case,Status,Contact';
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "AUZ Case Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    StyleExpr = StyleExpr;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    StyleExpr = StyleExpr;
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Consultant Comment"; "Consultant Comment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Developer Comment"; "Developer Comment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Registered Date"; "Registered Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field(Control1000000007; Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Waiting for"; "Waiting for")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Contact Company Name"; "Contact Company Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Contact Name"; "Contact Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Consultant ID"; "Consultant ID")
                {
                    ApplicationArea = All;
                }
                field("Developer ID"; "Developer ID")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Estimate; Estimate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Agreed Estimate"; "Agreed Estimate")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Promised Shipment Date"; "Promised Shipment Date")
                {
                    ApplicationArea = All;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Registered Hours"; "Registered Hours")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Chargeable Hours"; "Chargeable Hours")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Development Approval Status"; "Development Approval Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Development Status"; "Development Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Update License"; "Update License")
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Resource Search Text"; "Resource Search Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExpr;
                }
                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Contact Company No."; "Contact Company No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Registered By"; "Registered By")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Completed By"; "Completed By")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field("Last Time Modified"; "Last Time Modified")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(CtrlMyCaseHours; "AUZ My Case Lines")
            {
                ApplicationArea = All;
            }
            part(LoginInfoFactBox; "AUZ Login Info. FactBox")
            {
                ApplicationArea = All;
            }
            systempart(Control1000000033; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control1000000034; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Email)
            {
                Caption = 'Email';
                Ellipsis = true;
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    SendMail;
                end;
            }
            action(Selskapskontakt)
            {
                Caption = 'Company Contact';
                Image = CustomerContact;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ShowContactCompanyCard;
                end;
            }
            action("Påloggingsinfo.")
            {
                Caption = 'Login Information';
                Image = Database;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ShowLoginInformation;
                end;
            }
            action("URL-adresse for informasjon")
            {
                Caption = 'Information URL';
                Image = LaunchWeb;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    OpenInformationURL;
                end;
            }
            group(Status)
            {
                Caption = 'Status';
                action(Completed)
                {
                    Caption = 'Completed';
                    Image = Completed;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = Status <> Status::Completed;

                    trigger OnAction()
                    begin
                        if ConfirmCompleted then
                            UpdatePage;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = Status = Status::Completed;

                    trigger OnAction()
                    begin
                        Validate(Status, Status::"In Progress");
                        UpdatePage;
                    end;
                }
                separator(Action100000014)
                {
                }
                action(ChangeStatus)
                {
                    Caption = 'Change Status';
                    Image = ChangeStatus;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SelectStatus;
                        UpdatePage;
                    end;
                }
                action(ChangeDevStatus)
                {
                    Caption = 'Change Dev. Status';
                    Image = ChangeStatus;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SelectDevelopmentStatus;
                        UpdatePage;
                    end;
                }
                action(WaitingFor)
                {
                    Caption = 'Waiting for';
                    Image = ChangeCustomer;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SelectWaitingFor;
                        UpdatePage;
                    end;
                }
                action(DevApprovalStatus)
                {
                    Caption = 'Dev. Approval Status';
                    Image = Approve;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SelectDevelopmentApprovalStatus;
                        UpdatePage;
                    end;
                }
            }
        }
        area(navigation)
        {
            action(Arbeidskort)
            {
                Caption = 'Work Card';
                Image = ServiceItemWorksheet;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case Work Card";
                RunPageLink = "No." = FIELD("No.");
                RunPageOnRec = true;
            }
            action(Objekter)
            {
                Caption = 'Objects';
                Image = List;
                ApplicationArea = All;
                RunObject = Page "AUZ Case Object List";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action("Relaterte saker")
            {
                Caption = 'Related Cases';
                Image = Register;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "AUZ Related Cases";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                Image = TestFile;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "AUZ Case Standard Solutions";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action("Rediger kladd")
            {
                Caption = 'Edit Journal';
                Image = EditJournal;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "AUZ Case Journal";
            }
        }
        area(reporting)
        {
            action(Saksliste)
            {
                Caption = 'Case List';
                Image = "Report";
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "AUZCase List";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetStyleExpr;

        CurrPage.LoginInfoFactBox.PAGE.SetCaseHeader(Rec);
    end;

    trigger OnAfterGetRecord()
    begin
        SetStyleExpr;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.CtrlMyCaseHours.PAGE.UpdateData(Calendar);
    end;

    var
        ZdRecRef: RecordRef;
        Calendar: Record Date;
        CaseTools: Codeunit "AUZ Case Management";
        StyleExpr: Text;

    local procedure SetStyleExpr()
    begin
        case true of
            "Development Status" = "Development Status"::Installed:
                StyleExpr := 'Strong';
            Status = Status::"Waiting for Reply":
                if (("Waiting for" = "Waiting for"::Consultant) and ("Consultant ID" = UserId)) or
                  (("Waiting for" = "Waiting for"::Developer) and ("Developer ID" = UserId))
                then begin
                    if Priority = Priority::High then
                        StyleExpr := 'Attention'
                    else
                        StyleExpr := 'Ambiguous';
                end else
                    StyleExpr := 'Favorable';
            Priority = Priority::High:
                StyleExpr := 'Attention';
            else
                StyleExpr := '';
        end;
    end;

    local procedure IsSalesperson(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if "Consultant ID" <> '' then begin
            UserSetup.SetRange("User ID", UserId);
            UserSetup.SetRange("Salespers./Purch. Code", "Consultant ID");
            exit(not UserSetup.IsEmpty)
        end;
    end;

    local procedure UpdatePage()
    begin
        CurrPage.Update(true);
    end;
}

