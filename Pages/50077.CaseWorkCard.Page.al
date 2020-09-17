page 50077 "AUZ Case Work Card"
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
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Status = Status::Completed then
                            ClosePage;
                    end;
                }
                field("Waiting for"; "Waiting for")
                {
                    ApplicationArea = All;
                    Editable = Status = Status::"Waiting for Reply";
                    Importance = Promoted;
                }
                field("Development Status"; "Development Status")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Standard Solution No."; "Standard Solution No.")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No. of Related Cases"; "No. of Related Cases")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Update License"; "Update License")
                {
                    ApplicationArea = All;
                }
                group("URL-adresse for informasjon")
                {
                    Caption = 'Information URL';
                    field(InformationURL; InformationURL)
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field(Comment; Comment)
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                        Style = Attention;
                        StyleExpr = TRUE;
                    }
                    group(Endring)
                    {
                        Caption = 'Change Request';
                        field(DescriptionChangeRequest; DescriptionChangeRequest)
                        {
                            ApplicationArea = All;
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
                        ApplicationArea = All;
                    }
                    field("Developer Comment"; "Developer Comment")
                    {
                        ApplicationArea = All;
                    }
                    group("Løsning")
                    {
                        Caption = 'Solution';
                        field(DescriptionSolution; DescriptionSolution)
                        {
                            ApplicationArea = All;
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
            part(CaseObjects; "AUZ Case Objects")
            {
                ApplicationArea = All;
                Caption = 'Objects';
                Editable = DynamicEditable;
                SubPageLink = "Case No." = FIELD("No.");
            }
            part(CaseLines; "AUZ Case SubPage")
            {
                ApplicationArea = All;
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
            part(AFMFileFactBox; "AFM File FactBox")
            {
                ApplicationArea = All;
            }
            part(LoginInfoFactBox; "AUZ Login Info. FactBox")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SaveRecord;
                    PAGE.Run(PAGE::"AUZ Case Card", Rec);
                    if not CurrPage.LookupMode then
                        CurrPage.Close;
                end;
            }
            action(Objects)
            {
                Caption = 'Objects';
                Image = List;
                ApplicationArea = All;
                RunObject = Page "AUZ Case Object List";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action(RelatedCases)
            {
                Caption = 'Related Cases';
                Image = Register;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "AUZ Related Cases";
                RunPageLink = "Case No." = FIELD("No.");
            }
            action(StandardSolutions)
            {
                Caption = 'Standard Solutions';
                Image = TestFile;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "AUZ Case Standard Solutions";
                RunPageLink = "Case No." = FIELD("No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        DynamicEditable := CurrPage.Editable;

        CurrPage.LoginInfoFactBox.PAGE.SetCaseHeader(Rec);

        //AZ99999+
        CurrPage.AFMFileFactBox.PAGE.SetRecordVariant(Rec);
        //AZ99999-
    end;

    trigger OnAfterGetRecord()
    begin
        GetDescriptionChangeRequest(DescriptionChangeRequest);
        GetDescriptionSolution(DescriptionSolution);
        GetInformationURL(InformationURL);
    end;

    var
        DescriptionChangeRequest: Text;
        DescriptionSolution: Text;
        InformationURL: Text;
        DynamicEditable: Boolean;


    procedure LookupCaseResource()
    var
        CaseResource: Record "AUZ Case Resource";
        CaseResourceList: Page "AUZ Case Resource List";
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