page 90027 "Case Work Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 09.09.2016 HHV Added file management code. (AZ99999)

    Caption = 'Case Work Card';
    DataCaptionFields = "No.", Description;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Case,Resource,Status';
    RefreshOnActivate = true;
    SourceTable = "AUZ Case Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Control1000000039; Status)
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Status = Status::Completed then
                            ClosePage;
                    end;
                }
                field("Waiting for"; "Waiting for")
                {
                    Editable = Status = Status::"Waiting for Reply";
                    Importance = Promoted;
                }
                field("Development Status"; "Development Status")
                {
                    Importance = Promoted;
                }
                field("Standard Solution No."; "Standard Solution No.")
                {
                    Importance = Additional;

                    trigger OnAssistEdit()
                    begin
                        ShowStandardSolutionLastRelease;
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("No. of Standard Solutions"; "No. of Standard Solutions")
                {
                    Importance = Additional;
                }
                field("No. of Related Cases"; "No. of Related Cases")
                {
                    Importance = Additional;
                }
                field("Update License"; "Update License")
                {
                }
                group("URL-adresse for informasjon")
                {
                    Caption = 'Information URL';
                    field(InformationURL; InformationURL)
                    {
                        ExtendedDatatype = URL;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;

                        trigger OnValidate()
                        begin
                            SetInformationURL(InformationURL);
                        end;
                    }
                }
            }
            group(Informasjon)
            {
                Caption = 'Information';
                group(Control1120119008)
                {
                    ShowCaption = false;
                    field(Description; Description)
                    {
                        Importance = Promoted;
                    }
                    field(Comment; Comment)
                    {
                        Importance = Promoted;
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    group(Endring)
                    {
                        Caption = 'Change Request';
                        field(DescriptionChangeRequest; DescriptionChangeRequest)
                        {
                            Editable = DynamicEditable;
                            MultiLine = true;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                SaveDescriptionChangeRequest(DescriptionChangeRequest);
                            end;
                        }
                    }
                }
                group(Control1120119014)
                {
                    ShowCaption = false;
                    field("Consultant Comment"; "Consultant Comment")
                    {
                    }
                    field("Developer Comment"; "Developer Comment")
                    {
                    }
                    group("Løsning")
                    {
                        Caption = 'Solution';
                        field(DescriptionSolution; DescriptionSolution)
                        {
                            Editable = DynamicEditable;
                            MultiLine = true;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                SaveDescriptionSolution(DescriptionSolution);
                            end;
                        }
                    }
                }
            }
            part(CaseObjects; "Case Objects")
            {
                Caption = 'Objects';
                Editable = DynamicEditable;
                SubPageLink = "Case No." = FIELD("No.");
            }
            part(CaseLines; "Case SubPage")
            {
                Caption = 'Lines';
                Editable = DynamicEditable;
                Enabled = "Contact No." <> '';
                ShowFilter = false;
                SubPageLink = "Case No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part(ExtFileMgtFactBox; "External File FactBox")
            {
            }
            part(LoginInfoFactBox; "Login Info. FactBox")
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendEmail)
            {
                Caption = 'E-Mail';
                Ellipsis = true;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SendMail;
                end;
            }
            action(LoginInfo)
            {
                Caption = 'Login Information';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ShowLoginInformation();
                end;
            }
            action(InfoURL)
            {
                Caption = 'Information URL';
                Image = LaunchWeb;
                Promoted = true;
                PromotedCategory = Process;

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
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = Status <> Status::Completed;

                    trigger OnAction()
                    begin
                        if ConfirmCompleted then
                            ClosePage;
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Visible = Status = Status::Completed;

                    trigger OnAction()
                    begin
                        Validate(Status, Status::"In Progress");
                    end;
                }
                separator(Action1120119004)
                {
                }
                action(ChangeStatus)
                {
                    Caption = 'Change Status';
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

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
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

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
                    PromotedCategory = Category6;
                    PromotedIsBig = true;

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
                    //PromotedCategory = Category6;

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
            action(Kort)
            {
                Caption = 'Card';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SaveRecord;
                    PAGE.Run(PAGE::"Case Card", Rec);
                    if not CurrPage.LookupMode then
                        CurrPage.Close;
                end;
            }
            action(Objects)
            {
                Caption = 'Objects';
                Image = List;
                RunObject = Page "Case Object List";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action(RelatedCases)
            {
                Caption = 'Related Cases';
                Image = Register;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Related Cases";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action(StandardSolutions)
            {
                Caption = 'Standard Solutions';
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Case Standard Solutions";
                RunPageLink = "Case No." = FIELD("No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DynamicEditable := CurrPage.Editable;

        CurrPage.LoginInfoFactBox.PAGE.SetCaseHeader(Rec);

        //AZ99999+
        CurrPage.ExtFileMgtFactBox.PAGE.SetRec(Rec);
        //AZ99999-
    end;

    trigger OnAfterGetRecord()
    begin
        GetDescriptionChangeRequest(DescriptionChangeRequest);
        GetDescriptionSolution(DescriptionSolution);
        GetInformationURL(InformationURL);
    end;

    var
        CaseTools: Codeunit "Case Management";
        CaseNoteAction: Option ChangeRequest,Solution,Objects;
        DescriptionChangeRequest: Text;
        DescriptionSolution: Text;
        InformationURL: Text;
        DynamicEditable: Boolean;


    procedure LookupCaseResource()
    var
        CaseResource: Record "AUZ Case Resource";
        CaseResourceList: Page "Case Resource List";
    begin
        InsertCaseResource();

        CaseResource.SetRange("Case No.", "No.");
        CaseResourceList.SetTableView(CaseResource);
        CaseResourceList.RunModal;

        InsertCaseResource(); //In case delete

        BuildResourceFilter();
    end;

    local procedure ClosePage()
    begin
        CurrPage.SaveRecord;
        CurrPage.Close;
    end;

    local procedure UpdatePage()
    begin
        CurrPage.Update(true);
    end;
}

