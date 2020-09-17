table 50050 "AUZ Case Header"
{
    Caption = 'Case Header';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "AUZ Case List";
    LookupPageID = "AUZ Case List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    RMSetup.Get;
                    RMSetup.TestField("To-do Nos.");
                    NoSeriesMgt.TestManual(RMSetup."To-do Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Resource No."; Code[10])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                InsertCaseResource;
                CalcFields("Resource Name");
            end;
        }
        field(5; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            NotBlank = true;
            TableRelation = Contact WHERE(Type = CONST(Person));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                if Cont.Get("Contact No.") then begin
                    Validate("Contact Company No.", Cont."Company No.");
                    if (Cont."AUZ Default Job No." = '') and (Cont."AUZ Default Job Task No." = '') then
                        if Cont.Get("Contact Company No.") then;
                    Validate("Job No.", Cont."AUZ Default Job No.");
                    Validate("Job Task No.", Cont."AUZ Default Job Task No.");
                end else
                    Validate("Contact Company No.", '');

                CalcFields("Contact Name");
            end;
        }
        field(9; "Registered Date"; Date)
        {
            Caption = 'Registered Date';
            DataClassification = CustomerContent;
            Editable = false;
            NotBlank = true;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Started,In Progress,Completed,Waiting for Reply,Postponed,See Comment,,Running';
            OptionMembers = "Not Started","In Progress",Completed,"Waiting for Reply",Postponed,"See Comment",,Running;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CaseLine: Record "AUZ Case Line";
            begin
                case Status of
                    Status::"Not Started":
                        begin
                            CaseLine.SetRange("Case No.", "No.");
                            if not CaseLine.IsEmpty then
                                Error(Text001, Status);
                        end;
                    Status::"See Comment":
                        TestField(Comment);
                    Status::Completed:
                        begin
                            if "Update License" then begin
                                CalcFields("Contact Company Name");
                                ShowUpdateLicenseNotification(GetUpdateLicenseNotificationId,
                                UpdateLicenseNotificationMsg,
                                "Contact Company Name", "No.");
                            end;
                            Validate(Closed, true);
                        end;
                    else begin
                            RecallUpdateLicenseNotification(GetUpdateLicenseNotificationId);
                            Validate(Closed, false);
                        end;
                end;

                if Status <> Status::"Waiting for Reply" then
                    "Waiting for" := "Waiting for"::" ";
            end;
        }
        field(11; Priority; Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
            DataClassification = CustomerContent;
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(13; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if Closed then begin
                    if "Development Status" <> "Development Status"::Installed then begin
                        UserSetup.SetRange("AUZ Resource No.", "Resource No.");
                        if UserSetup.FindFirst and UserSetup."AUZ Developer" then
                            Validate("Development Status", "Development Status"::Installed);
                    end;
                    "Completed Date" := Today;
                    Status := Status::Completed;
                    "Completed By" := GetResourceNo();
                end else begin
                    Canceled := false;
                    "Completed Date" := 0D;
                    if Status = Status::Completed then
                        Status := Status::"In Progress";
                    if "Completed By" <> '' then
                        "Completed By" := ''
                end;
                if CurrFieldNo <> 0 then
                    Modify(true);
            end;
        }
        field(14; "Completed Date"; Date)
        {
            Caption = 'Completed Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; Comment; Text[50])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if (Comment = '') and (Status = Status::"See Comment") then
                    Error(Text002, Status);
            end;
        }
        field(17; Canceled; Boolean)
        {
            Caption = 'Canceled';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Canceled and not Closed then
                    Validate(Closed, true);
                if (not Canceled) and Closed then
                    Validate(Closed, false);
            end;
        }
        field(18; "Contact Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE("No." = FIELD("Contact No.")));
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "No. of Related Cases"; Integer)
        {
            CalcFormula = Count ("AUZ Related Case" WHERE("Case No." = FIELD("No.")));
            Caption = 'No. of Related Cases';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Resource Name"; Text[50])
        {
            CalcFormula = Lookup (Resource.Name WHERE("No." = FIELD("Resource No.")));
            Caption = 'Resource Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Waiting for"; Option)
        {
            Caption = 'Waiting for';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Customer,Consultant,Developer';
            OptionMembers = " ",Customer,Consultant,Developer;
        }
        field(22; "Contact Company No."; Code[20])
        {
            Caption = 'Contact Company No.';
            Editable = false;
            TableRelation = Contact WHERE(Type = CONST(Company));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cust: Record Customer;
            begin
                if "Contact Company No." <> '' then
                    if ContBusinessRelation.FindByContact(ContBusinessRelation."Link to Table"::Customer, "Contact Company No.") then begin
                        Cust.Get(ContBusinessRelation."No.");
                        Validate("Consultant ID", Cust."AUZ Consultant ID");
                        Validate("Developer ID", Cust."AUZ Developer ID");
                    end else begin
                        Validate("Consultant ID", '');
                        Validate("Developer ID", '');
                    end;

                CalcFields("Contact Company Name");
            end;
        }
        field(23; "Contact Company Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE("No." = FIELD("Contact Company No."),
                                                     Type = CONST(Company)));
            Caption = 'Contact Company Name';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact.Name WHERE(Type = CONST(Company));
        }
        field(24; "Chargeable Hours"; Decimal)
        {
            CalcFormula = Sum ("AUZ Case Line".Quantity WHERE("Case No." = FIELD("No."),
                                                          Chargeable = CONST(true)));
            Caption = 'Chargeable';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Consultant ID"; Code[50])
        {
            Caption = 'Consultant ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup" WHERE("AUZ Consultant" = CONST(true));
        }
        field(26; "Developer ID"; Code[50])
        {
            Caption = 'Developer ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID" WHERE("AUZ Developer" = CONST(true));
        }
        field(27; "No. of Standard Solutions"; Integer)
        {
            CalcFormula = Count ("AUZ Case Standard Solultion" WHERE("Case No." = FIELD("No.")));
            Caption = 'No. of Standard Solutions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Consultant Comment"; Text[50])
        {
            Caption = 'Consultant Comment';
            DataClassification = CustomerContent;
        }
        field(29; "Developer Comment"; Text[50])
        {
            Caption = 'Developer Comment';
            DataClassification = CustomerContent;
        }
        field(30; "Information URL"; BLOB)
        {
            Caption = 'Information URL';
            DataClassification = CustomerContent;
        }
        field(31; "Update License"; Boolean)
        {
            Caption = 'Update License';
            DataClassification = CustomerContent;
        }
        field(32; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(33; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(34; "Reference No. Mandatory"; Boolean)
        {
            Caption = 'Reference No. Mandatory';
            DataClassification = CustomerContent;
        }
        field(46; "Completed By"; Code[10])
        {
            Caption = 'Completed By';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
        }
        field(47; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(50; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;
            TableRelation = Job WHERE(Blocked = CONST(" "));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                JobNoOnValidate;
            end;
        }
        field(51; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."),
                                                             "Job Task Type" = CONST(Posting));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Job: Record Job;
                Cust: Record Customer;
            begin
            end;
        }
        field(52; "Registered By"; Code[10])
        {
            Caption = 'Registered By';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(53; "Desc. Change Request"; BLOB)
        {
            Caption = 'Endringsbeskrivelse';
            DataClassification = CustomerContent;
        }
        field(54; "Desc. Solution"; BLOB)
        {
            Caption = 'Description Solution';
            DataClassification = CustomerContent;
        }
        field(55; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(56; Estimate; Decimal)
        {
            Caption = 'Estimat';
            DataClassification = CustomerContent;
        }
        field(57; "Agreed Estimate"; Boolean)
        {
            Caption = 'Agreed Estimate';
            DataClassification = CustomerContent;
        }
        field(58; "Promised Shipment Date"; Date)
        {
            Caption = 'Promised Shipment Date';
            DataClassification = CustomerContent;
        }
        field(59; "Resource Search Text"; Text[250])
        {
            Caption = 'Resource Search Text';
            DataClassification = CustomerContent;
        }
        field(60; "Registered Hours"; Decimal)
        {
            CalcFormula = Sum ("AUZ Case Line".Quantity WHERE("Case No." = FIELD("No.")));
            Caption = 'Registered Hours';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; Datefilter; Date)
        {
            Caption = 'Datofilter';
            DataClassification = CustomerContent;
        }
        field(62; "Development Approval Status"; Option)
        {
            Caption = 'Development Approval Status';
            OptionCaption = ' ,Must be reviewed,OK to Install';
            OptionMembers = " ","Must be reviewed","OK to Install";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if "Development Approval Status" <> xRec."Development Approval Status" then
                    if (not UserSetup.Get(UserId)) or (not UserSetup."AUZ Development Administrator") then
                        Error(Text003);
            end;
        }
        field(63; "Development Status"; Option)
        {
            Caption = 'Status Development';
            OptionCaption = ' ,Ordered,Specifikation Approved,Installed,Approved,Quote wanted,Quote sent,Ready for testing,Test OK,Waiting Review,Reviewed,Ready for Installation';
            OptionMembers = " ",Ordered,"Specifikation Approved",Installed,Approved,"Quote Wanted","Quote Sent","Ready for Testing","Test OK","Waiting Review",Reviewed,"Ready for Installation";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CaseMailMgt: Codeunit "AUZ Case Mail Management";
            begin
                case "Development Status" of
                    "Development Status"::"Ready for Testing", "Development Status"::"Ready for Installation":
                        if Status <> Status::"Waiting for Reply" then
                            UpdateWaitingFor("Waiting for"::Developer);
                    "Development Status"::Installed:
                        begin
                            if "Development Approval Status" = "Development Approval Status"::"Must be reviewed" then
                                if Confirm(Text004) then begin
                                    //ALA
                                    //CaseMailMgt.SetToDevelopmentAdmin(true);
                                    //CaseMailMgt.SendEmail(Rec);
                                end;

                            if Status in [Status::"Not Started", Status::"Waiting for Reply"] then
                                Validate(Status, Status::"In Progress");
                        end;
                end;
            end;
        }
        field(64; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            TableRelation = "AUZ Standard Solution";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
        key(Key3; "Registered Date")
        {
        }
    }

    trigger OnDelete()
    var
        CaseHour: Record "AUZ Case Line";
        CaseObject: Record "AUZ Case Object";
        CaseResource: Record "AUZ Case Resource";
        RelatedCase: Record "AUZ Related Case";
        CaseStandardSolultion: Record "AUZ Case Standard Solultion";
    begin
        CaseHour.SetRange("Case No.", "No.");
        if not CaseHour.IsEmpty then
            Error(Text000, "No.");

        CaseObject.SetRange("Case No.", "No.");
        CaseObject.DeleteAll(true);

        CaseResource.SetRange("Case No.", "No.");
        CaseResource.DeleteAll(true);

        RelatedCase.SetRange("Case No.", "No.");
        RelatedCase.DeleteAll(true);

        CaseStandardSolultion.SetRange("Case No.", "No.");
        CaseStandardSolultion.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            RMSetup.Get;
            RMSetup.TestField("To-do Nos.");
            NoSeriesMgt.InitSeries(RMSetup."To-do Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        SetLastDateTimeModified;
        "Registered Date" := Today;
        "Registered By" := GetResourceNo;

        if "Work Type Code" = '' then begin
            CaseSetup.Get;
            "Work Type Code" := CaseSetup."Default Work Type";
        end;
    end;

    trigger OnModify()
    begin
        SetLastDateTimeModified;
    end;

    trigger OnRename()
    begin
        Error(RenameErr, TableCaption);
    end;

    local procedure JobNoOnValidate()
    begin
        if "Job No." <> xRec."Job No." then
            "Job Task No." := '';
    end;

    procedure GetResourceNo(): Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        exit(UserSetup."AUZ Resource No.");
    end;

    procedure SaveDescriptionChangeRequest(DescriptionText: Text)
    var
        oStream: OutStream;
    begin
        CalcFields("Desc. Change Request");
        Clear("Desc. Change Request");
        "Desc. Change Request".CreateOutStream(oStream);
        oStream.WriteText(DescriptionText);
    end;

    procedure SaveDescriptionSolution(DescriptionText: Text)
    var
        oStream: OutStream;
    begin
        CalcFields("Desc. Solution");
        Clear("Desc. Solution");
        "Desc. Solution".CreateOutStream(oStream);
        oStream.WriteText(DescriptionText);
    end;

    procedure GetDescriptionChangeRequest(var DescriptionText: Text)
    var
        iStream: InStream;
        MyBigText: BigText;
    begin
        CalcFields("Desc. Change Request");
        if "Desc. Change Request".HasValue then begin
            "Desc. Change Request".CreateInStream(iStream);
            MyBigText.Read(iStream);
            MyBigText.GetSubText(DescriptionText, 1);
        end else
            DescriptionText := '';
    end;

    procedure GetDescriptionSolution(var DescriptionText: Text)
    var
        iStream: InStream;
        MyBigText: BigText;
    begin
        CalcFields("Desc. Solution");
        if "Desc. Solution".HasValue then begin
            "Desc. Solution".CreateInStream(iStream);
            MyBigText.Read(iStream);
            MyBigText.GetSubText(DescriptionText, 1);
        end else
            DescriptionText := '';
    end;

    procedure SendMail()
    var
        CaseMailHandle: Codeunit "AUZ Case Mail Management";
    begin
        CaseMailHandle.SendEmail(Rec);
    end;

    procedure InsertCaseResource()
    var
        CaseResource: Record "AUZ Case Resource";
    begin
        if ("Resource No." <> xRec."Resource No.") and ("Resource No." = '') then
            if CaseResource.Get("No.", xRec."Resource No.") then
                CaseResource.Delete;

        if (not CaseResource.Get("No.", "Resource No.")) and ("Resource No." <> '') then begin
            CaseResource.Init;
            CaseResource."Case No." := "No.";
            CaseResource."Resource No." := "Resource No.";
            CaseResource.Insert;
            Commit;
        end;

        BuildResourceFilter;
    end;

    procedure BuildResourceFilter()
    var
        CaseResource: Record "AUZ Case Resource";
    begin
        CaseResource.SetRange("Case No.", "No.");
        "Resource Search Text" := '';
        if CaseResource.FindSet then
            repeat
                if "Resource Search Text" <> '' then
                    "Resource Search Text" += ',';
                "Resource Search Text" += CaseResource."Resource No.";
            until CaseResource.Next = 0;
    end;

    procedure GetMyUserFilter(): Text
    begin
        exit('@*' + GetResourceNo + '*');
    end;

    procedure ShowContactCompanyCard()
    var
        ContactCompany: Record Contact;
        ContactCard: Page "Contact Card";
    begin
        ContactCompany.Get("Contact Company No.");
        ContactCard.SetRecord(ContactCompany);
        ContactCard.Run;
    end;

    procedure ShowLoginInformation()
    var
        ContactCompany: Record Contact;
    begin
        ContactCompany.Get("Contact Company No.");
        ContactCompany.ShowLoginInformation;
    end;

    procedure GetLoginInformation(): Text
    var
        ContactCompany: Record Contact;
    begin
        ContactCompany.Get("Contact Company No.");
        exit(ContactCompany.GetLoginInformation2);
    end;

    procedure ConfirmCompleted(): Boolean
    begin
        if Confirm(Text007, true) then begin
            Validate(Status, Status::Completed);
            exit(true);
        end;
    end;

    local procedure SetLastDateTimeModified()
    begin
        "Last Date Modified" := Today;
        "Last Time Modified" := Time;
    end;

    procedure SetConsultantResource()
    var
        UserSetup: Record "User Setup";
    begin
        TestField("Consultant ID");
        UserSetup.Get("Consultant ID");
        UserSetup.TestField("AUZ Resource No.");
        Validate("Resource No.", UserSetup."AUZ Resource No.");
    end;

    procedure SetDeveloperResource()
    var
        UserSetup: Record "User Setup";
    begin
        TestField("Developer ID");
        UserSetup.Get("Developer ID");
        UserSetup.TestField("AUZ Resource No.");
        Validate("Resource No.", UserSetup."AUZ Resource No.");
    end;

    procedure GetInformationURL(var ServiceURL: Text): Text
    var
        InStream: InStream;
    begin
        CalcFields("Information URL");
        if "Information URL".HasValue then begin
            "Information URL".CreateInStream(InStream);
            InStream.Read(ServiceURL);
        end;
    end;

    procedure SetInformationURL(ServiceURL: Text)
    var
        WebRequestHelper: Codeunit "Web Request Helper";
        OutStream: OutStream;
    begin
        WebRequestHelper.IsValidUri(ServiceURL);
        WebRequestHelper.IsHttpUrl(ServiceURL);

        "Information URL".CreateOutStream(OutStream);
        OutStream.Write(ServiceURL);
        Modify;
    end;

    procedure OpenInformationURL()
    var
        ServiceURL: Text;
    begin
        TestField("Information URL");
        GetInformationURL(ServiceURL);
        HyperLink(ServiceURL);
    end;

    procedure ShowStandardSolutionLastRelease()
    var
        StandardSolutionRelease: Record "AUZ Standard Solution Release";
        PageMgt: Codeunit "Page Management";
    begin
        TestField("Standard Solution No.");
        StandardSolutionRelease.SetCurrentKey("Date Created");
        StandardSolutionRelease.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionRelease.FindLast;
        PageMgt.PageRunModal(StandardSolutionRelease);
    end;

    procedure SelectStatus()
    var
        Selection: Integer;
    begin
        if SelectOption(Selection, FieldNo(Status), Status + 1) then
            Validate(Status, Selection);
    end;

    procedure SelectDevelopmentStatus()
    var
        Selection: Integer;
    begin
        if SelectOption(Selection, FieldNo("Development Status"), "Development Status" + 1) then
            Validate("Development Status", Selection);
    end;

    procedure SelectDevelopmentApprovalStatus()
    var
        Selection: Integer;
    begin
        if SelectOption(Selection, FieldNo("Development Approval Status"), "Development Approval Status" + 1) then
            Validate("Development Approval Status", Selection);
    end;

    procedure SelectWaitingFor()
    var
        Selection: Integer;
    begin
        if SelectOption(Selection, FieldNo("Waiting for"), "Waiting for" + 1) then
            UpdateWaitingFor(Selection);
    end;

    procedure UpdateWaitingFor(WaitingFor: Option)
    begin
        Validate(Status, Status::"Waiting for Reply");
        Validate("Waiting for", WaitingFor);
    end;

    local procedure SelectOption(var Selection: Integer; FieldNumber: Integer; DefaultOption: Integer): Boolean
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecordRef.Open(DATABASE::"AUZ Case Header");
        FieldRef := RecordRef.Field(FieldNumber);
        Selection := StrMenu(FieldRef.OptionCaption, DefaultOption) - 1;
        exit(Selection > -1);
    end;

    local procedure ShowUpdateLicenseNotification(NotificationID: Guid; NotificationMsg: Text; ContactName: Text[50]; CaseNumber: Code[20])
    var
        MyNotifications: Record "My Notifications";
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        PageMyNotifications: Page "My Notifications";
        UpdateLicenseNotification: Notification;
    begin
        if not MyNotifications.Get(UserId, NotificationID) then
            PageMyNotifications.InitializeNotificationsWithDefaultState;

        if not MyNotifications.IsEnabled(NotificationID) then
            exit;

        UpdateLicenseNotification.Id := NotificationID;
        UpdateLicenseNotification.Message :=
          StrSubstNo(NotificationMsg, ContactName, CaseNumber);
        UpdateLicenseNotification.AddAction(
          DontShowAgainActionLbl, CODEUNIT::"Document Notifications", 'HideNotificationForCurrentUser');
        UpdateLicenseNotification.Scope := NOTIFICATIONSCOPE::LocalScope;
        NotificationLifecycleMgt.SendNotification(UpdateLicenseNotification, RecordId);
    end;

    local procedure RecallUpdateLicenseNotification(NotificationID: Guid)
    var
        MyNotifications: Record "My Notifications";
        UpdateLicenseNotification: Notification;
    begin
        if not MyNotifications.IsEnabled(NotificationID) then
            exit;

        UpdateLicenseNotification.Id := NotificationID;
        UpdateLicenseNotification.Recall;
    end;

    local procedure GetUpdateLicenseNotificationId(): Guid
    begin
        exit('6d4983b5-fab1-44fa-ab56-b79e5a88908b');
    end;

    var
        RenameErr: Label 'You cannot rename a %1.';
        Text000: Label 'You cannot delete case %1 as there are registered hours.';
        Text001: Label 'You cannot change status to %1 as there are registered hours.';
        Text002: Label 'Status cannot be %1 when comment is empty.';
        Text003: Label 'You do not have permission to change approval status for development.';
        Text004: Label 'This case must be reviewed with the development administrator. \Do you want to send email to the development administrator now?';
        Text006: Label 'The valid range of dates is from %1 to %2. Please enter a date within this range.';
        CaseSetup: Record "AUZ Case Setup";
        RMSetup: Record "Marketing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text007: Label 'Is the case completed?';
        DontShowAgainActionLbl: Label 'Don''t show again';
        UpdateLicenseNotificationMsg: Label 'The license for %1 must be updated when the solution in case %2 is installed.';
}