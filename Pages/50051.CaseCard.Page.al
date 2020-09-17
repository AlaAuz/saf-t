page 50051 "AUZ Case Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 09.09.2016 HHV Added file management code. (AZ99999)

    Caption = 'Case Card';
    DataCaptionFields = "No.", Description;
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
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
                group(Kontakt)
                {
                    Caption = 'Contact';
                    field("Contact No."; "Contact No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        Importance = Promoted;
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Contact Name"; "Contact Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                        Importance = Promoted;
                    }
                    field("Contact Company No."; "Contact Company No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Company No.';
                        Importance = Additional;
                    }
                    field("Contact Company Name"; "Contact Company Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Name';
                        Importance = Promoted;
                    }
                }
                group(Ansvarlig)
                {
                    Caption = 'Responsible';
                    field("Consultant ID"; "Consultant ID")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Developer ID"; "Developer ID")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                }
                group(Ressurs)
                {
                    Caption = 'Resource';
                    field("Resource No."; "Resource No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        Importance = Promoted;

                        trigger OnAssistEdit()
                        begin
                            LookupCaseResource;
                        end;
                    }
                    field("Resource Name"; "Resource Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                        Importance = Additional;
                    }
                    field("Resource Search Text"; "Resource Search Text")
                    {
                        ApplicationArea = All;
                        Caption = 'Search Text';
                        Editable = false;
                        Importance = Standard;

                        trigger OnDrillDown()
                        begin
                            LookupCaseResource;
                        end;
                    }
                }
                group(Prosjekt)
                {
                    Caption = 'Job';
                    field("Job No."; "Job No.")
                    {
                        ApplicationArea = All;
                        Caption = 'No.';
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Job Task No."; "Job Task No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Task No.';
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Reference No. Mandatory"; "Reference No. Mandatory")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            UpdatePage;
                        end;
                    }
                }
            }
            part(CaseLines; "AUZ Case SubPage")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = DynamicEditable;
                Enabled = "Contact No." <> '';
                ShowFilter = false;
                SubPageLink = "Case No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Tilleggsinformasjon)
            {
                Caption = 'Additional Information';
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                group(Control100000016)
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
            group("Utførelse")
            {
                Caption = 'Execution';
                field("No. of Related Cases"; "No. of Related Cases")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                group(Control1120119010)
                {
                    ShowCaption = false;
                    field("Work Type Code"; "Work Type Code")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Agreed Estimate"; "Agreed Estimate")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field(Estimate; Estimate)
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Chargeable Hours"; "Chargeable Hours")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Registered Hours"; "Registered Hours")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                }
                group(Control1120119009)
                {
                    ShowCaption = false;
                    field("Registered Date"; "Registered Date")
                    {
                        ApplicationArea = All;
                        Importance = Standard;
                    }
                    field("Promised Shipment Date"; "Promised Shipment Date")
                    {
                        ApplicationArea = All;
                        Importance = Promoted;
                    }
                    field("Ending Date"; "Ending Date")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Last Date Modified"; "Last Date Modified")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                        Visible = false;
                    }
                    field("Last Time Modified"; "Last Time Modified")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Importance = Additional;
                        Visible = false;
                    }
                }
                field("Registered By"; "Registered By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Completed By"; "Completed By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field(Canceled; Canceled)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
            }
            group(Utvikling)
            {
                Caption = 'Developement';
                field("Development Approval Status"; "Development Approval Status")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Status';
                    Importance = Promoted;
                }
                field("Development Status"; "Development Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
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
                field("Update License"; "Update License")
                {
                    ApplicationArea = All;
                }
            }
            grid("Detaljert beskrivelse")
            {
                Caption = 'Detailed Description';
                GridLayout = Rows;
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
            part(CaseObjects; "AUZ Case Objects")
            {
                ApplicationArea = All;
                Caption = 'Objects';
                Editable = DynamicEditable;
                SubPageLink = "Case No." = FIELD("No.");
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
            part(Linjebeskrivelser; "AUZ Case Line Desc. FactBox")
            {
                ApplicationArea = All;
                Caption = 'Line Descriptions';
                Provider = CaseLines;
                SubPageLink = "Case No." = FIELD("Case No."),
                              "Case Line No." = FIELD("Line No.");
            }
            part(Control1000000053; "AUZ Case Line Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Case No." = FIELD("No.");
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
            action(CompCont)
            {
                Caption = 'Company Contact';
                Image = CustomerContact;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ShowContactCompanyCard();
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
            action(InforURL)
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
            group(Ressurser)
            {
                Caption = 'Resources';
                action(GetConsultantResource)
                {
                    Caption = 'Get Consultant Resource';
                    Image = SalesPurchaseTeam;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SetConsultantResource;
                        CurrPage.Update;
                    end;
                }
                action(GetDeveloperResource)
                {
                    Caption = 'Get Developer Resource';
                    Image = DesignCodeBehind;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SetDeveloperResource;
                        CurrPage.Update;
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

                trigger OnAction()
                begin
                    CurrPage.SaveRecord;
                    PAGE.Run(PAGE::"AUZ Case Work Card", Rec);
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



    procedure LookupCaseResource()
    var
        CaseResource: Record "AUZ Case Resource";
        CaseResourceList: Page "AUZ Case Resource List";
    begin
        InsertCaseResource;

        CaseResource.SetRange("Case No.", "No.");
        CaseResourceList.SetTableView(CaseResource);
        CaseResourceList.RunModal;

        InsertCaseResource; //In case delete
        BuildResourceFilter;
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

    var
        DescriptionChangeRequest: Text;
        DescriptionSolution: Text;
        InformationURL: Text;
        DynamicEditable: Boolean;
}