page 90001 "Case Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 09.09.2016 HHV Added file management code. (AZ99999)

    Caption = 'Case Card';
    DataCaptionFields = "No.", Description;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Case,Resource,Status';
    RefreshOnActivate = true;
    SourceTable = "Case Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Additional;
                }
                field(Description; Description)
                {
                    Importance = Promoted;
                }
                field(Priority; Priority)
                {
                    Importance = Promoted;
                }
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
                group(Kontakt)
                {
                    Caption = 'Contact';
                    field("Contact No."; "Contact No.")
                    {
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
                        Caption = 'Name';
                        Importance = Promoted;
                    }
                    field("Contact Company No."; "Contact Company No.")
                    {
                        Caption = 'Company No.';
                        Importance = Additional;
                    }
                    field("Contact Company Name"; "Contact Company Name")
                    {
                        Caption = 'Company Name';
                        Importance = Promoted;
                    }
                }
                group(Ansvarlig)
                {
                    Caption = 'Responsible';
                    field("Consultant ID"; "Consultant ID")
                    {
                        Importance = Promoted;
                    }
                    field("Developer ID"; "Developer ID")
                    {
                        Importance = Promoted;
                    }
                }
                group(Ressurs)
                {
                    Caption = 'Resource';
                    field("Resource No."; "Resource No.")
                    {
                        Caption = 'No.';
                        Importance = Promoted;

                        trigger OnAssistEdit()
                        begin
                            LookupCaseResource;
                        end;
                    }
                    field("Resource Name"; "Resource Name")
                    {
                        Caption = 'Name';
                        Importance = Additional;
                    }
                    field("Resource Search Text"; "Resource Search Text")
                    {
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
                        Caption = 'No.';
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Job Task No."; "Job Task No.")
                    {
                        Caption = 'Task No.';
                        ShowMandatory = true;

                        trigger OnValidate()
                        begin
                            CurrPage.Update;
                        end;
                    }
                    field("Reference No. Mandatory"; "Reference No. Mandatory")
                    {

                        trigger OnValidate()
                        begin
                            UpdatePage;
                        end;
                    }
                }
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
            group(Tilleggsinformasjon)
            {
                Caption = 'Additional Information';
                field(Comment; Comment)
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                group(Control100000016)
                {
                    ShowCaption = false;
                    field("Consultant Comment"; "Consultant Comment")
                    {
                    }
                    field("Developer Comment"; "Developer Comment")
                    {
                    }
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
            group("Utførelse")
            {
                Caption = 'Execution';
                field("No. of Related Cases"; "No. of Related Cases")
                {
                    Importance = Additional;
                }
                group(Control1120119010)
                {
                    ShowCaption = false;
                    field("Work Type Code"; "Work Type Code")
                    {
                        Importance = Additional;
                    }
                    field("Agreed Estimate"; "Agreed Estimate")
                    {
                        Importance = Promoted;
                    }
                    field(Estimate; Estimate)
                    {
                        Importance = Promoted;
                    }
                    field("Chargeable Hours"; "Chargeable Hours")
                    {
                        Importance = Promoted;
                    }
                    field("Registered Hours"; "Registered Hours")
                    {
                        Importance = Promoted;
                    }
                }
                group(Control1120119009)
                {
                    ShowCaption = false;
                    field("Registered Date"; "Registered Date")
                    {
                        Importance = Standard;
                    }
                    field("Promised Shipment Date"; "Promised Shipment Date")
                    {
                        Importance = Promoted;
                    }
                    field("Ending Date"; "Ending Date")
                    {
                        Importance = Additional;
                    }
                    field("Last Date Modified"; "Last Date Modified")
                    {
                        Editable = false;
                        Importance = Additional;
                        Visible = false;
                    }
                    field("Last Time Modified"; "Last Time Modified")
                    {
                        Editable = false;
                        Importance = Additional;
                        Visible = false;
                    }
                }
                field("Registered By"; "Registered By")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field("Completed By"; "Completed By")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Canceled; Canceled)
                {
                    Importance = Additional;
                    Visible = false;
                }
            }
            group(Utvikling)
            {
                Caption = 'Developement';
                field("Development Approval Status"; "Development Approval Status")
                {
                    Caption = 'Approval Status';
                    Importance = Promoted;
                }
                field("Development Status"; "Development Status")
                {
                    Caption = 'Status';
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
                field("Update License"; "Update License")
                {
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
            part(CaseObjects; "Case Objects")
            {
                Caption = 'Objects';
                Editable = DynamicEditable;
                SubPageLink = "Case No." = FIELD("No.");
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
            part(Linjebeskrivelser; "Case Line Descriptions FactBox")
            {
                Caption = 'Line Descriptions';
                Provider = CaseLines;
                SubPageLink = "Case No." = FIELD("Case No."),
                              "Case Hour Line No." = FIELD("Line No.");
            }
            part(Control1000000053; "Case Hour Factbox")
            {
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
            group(Ressurser)
            {
                Caption = 'Resources';
                action(GetConsultantResource)
                {
                    Caption = 'Get Consultant Resource';
                    Image = SalesPurchaseTeam;
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
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SaveRecord;
                    PAGE.Run(PAGE::"Case Work Card", Rec);
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
        CaseTools: Codeunit "Case Tools";
        CaseNoteAction: Option ChangeRequest,Solution,Objects;
        DescriptionChangeRequest: Text;
        DescriptionSolution: Text;
        InformationURL: Text;
        DynamicEditable: Boolean;


    procedure LookupCaseResource()
    var
        CaseResource: Record "Case Resource";
        CaseResourceList: Page "Case Resource List";
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
}

