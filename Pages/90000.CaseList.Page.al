page 90000 "Case List"
{
    ApplicationArea = All;
    Caption = 'Case List';
    CardPageID = "Case Card";
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
                }
                field(Description; Description)
                {
                    StyleExpr = StyleExpr;
                }
                field(Comment; Comment)
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Consultant Comment"; "Consultant Comment")
                {
                    Visible = false;
                }
                field("Developer Comment"; "Developer Comment")
                {
                    Visible = false;
                }
                field("Registered Date"; "Registered Date")
                {
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field(Control1000000007; Status)
                {
                    StyleExpr = StyleExpr;
                }
                field("Waiting for"; "Waiting for")
                {
                    StyleExpr = StyleExpr;
                }
                field("Contact Company Name"; "Contact Company Name")
                {
                    StyleExpr = StyleExpr;
                }
                field("Contact Name"; "Contact Name")
                {
                    StyleExpr = StyleExpr;
                }
                field("Consultant ID"; "Consultant ID")
                {
                }
                field("Developer ID"; "Developer ID")
                {
                }
                field("Resource No."; "Resource No.")
                {
                    StyleExpr = StyleExpr;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    Visible = false;
                }
                field(Estimate; Estimate)
                {
                    StyleExpr = StyleExpr;
                }
                field("Agreed Estimate"; "Agreed Estimate")
                {
                    StyleExpr = StyleExpr;
                }
                field("Promised Shipment Date"; "Promised Shipment Date")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Registered Hours"; "Registered Hours")
                {
                    StyleExpr = StyleExpr;
                }
                field("Chargeable Hours"; "Chargeable Hours")
                {
                    StyleExpr = StyleExpr;
                }
                field("Development Approval Status"; "Development Approval Status")
                {
                    StyleExpr = StyleExpr;
                }
                field("Development Status"; "Development Status")
                {
                    StyleExpr = StyleExpr;
                }
                field("Update License"; "Update License")
                {
                }
                field(Priority; Priority)
                {
                    StyleExpr = StyleExpr;
                }
                field("Resource Search Text"; "Resource Search Text")
                {
                    Editable = false;
                    StyleExpr = StyleExpr;
                }
                field("Resource Name"; "Resource Name")
                {
                    StyleExpr = StyleExpr;
                }
                field("Contact No."; "Contact No.")
                {
                    StyleExpr = StyleExpr;
                }
                field("Contact Company No."; "Contact Company No.")
                {
                    StyleExpr = StyleExpr;
                }
                field("Registered By"; "Registered By")
                {
                    Visible = false;
                }
                field("Completed By"; "Completed By")
                {
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field("Ending Date"; "Ending Date")
                {
                    StyleExpr = StyleExpr;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
                field("Last Time Modified"; "Last Time Modified")
                {
                    StyleExpr = StyleExpr;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(CtrlMyCaseHours; "My Case Lines")
            {
            }
            part(LoginInfoFactBox; "Login Info. FactBox")
            {
            }
            systempart(Control1000000033; Notes)
            {
            }
            systempart(Control1000000034; Links)
            {
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
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Case Work Card";
                RunPageLink = "No." = FIELD ("No.");
                RunPageOnRec = true;
            }
            action(Objekter)
            {
                Caption = 'Objects';
                Image = List;
                RunObject = Page "Case Object List";
                RunPageLink = "Case No." = FIELD ("No.");
            }
            action("Relaterte saker")
            {
                Caption = 'Related Cases';
                Image = Register;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Related Cases";
                RunPageLink = "Case No." = FIELD ("No.");
            }
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Case Standard Solutions";
                RunPageLink = "Case No." = FIELD ("No.");
            }
            action("Rediger kladd")
            {
                Caption = 'Edit Journal';
                Image = EditJournal;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Case Journal";
            }
        }
        area(reporting)
        {
            action(Saksliste)
            {
                Caption = 'Case List';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Case List";
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
        CaseTools: Codeunit "Case Management";
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

