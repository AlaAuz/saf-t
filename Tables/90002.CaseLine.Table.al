table 90002 "AUZ Case Line"
{
    Caption = 'Case Line';
    DrillDownPageID = "Case Line List";
    LookupPageID = "Case Line List";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Resource No."; Code[10])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[100])
        {
            CalcFormula = Lookup ("AUZ Case Line Description".Description WHERE("Case No." = FIELD("Case No."),
                                                                            "Case Line No." = FIELD("Line No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Work Type"; Code[10])
        {
            Caption = 'Work Type';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(8; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = CustomerContent;
        }
        field(10; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = CustomerContent;
        }
        field(11; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(12; "Contact Company No."; Code[20])
        {
            CalcFormula = Lookup ("AUZ Case Header"."Contact Company No." WHERE("No." = FIELD("Case No.")));
            Caption = 'Contact Company No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(13; "Contact Company Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE("No." = FIELD("Contact Company No.")));
            Caption = 'Contact Company Name';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact.Name WHERE(Type = CONST(Company));
        }
        field(14; "Date/Time Modified"; DateTime)
        {
            Caption = 'Date/Time Modified';
            DataClassification = SystemMetadata;
        }
        field(15; "Date/Time Created"; DateTime)
        {
            Caption = 'Date/Time Created';
            DataClassification = SystemMetadata;
        }
        field(16; "Reference No."; Code[10])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CaseHeader: Record "AUZ Case Header";
            begin
                if "Reference No." = '' then begin
                    CaseHeader.Get("Case No.");
                    CaseHeader.TestField("Reference No. Mandatory", false);
                end;
            end;
        }
        field(50001; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Job No." <> xRec."Job No." then begin
                    CheckJob;
                    "Job Task No." := '';
                end;
            end;
        }
        field(50002; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."),
                                                             "Job Task Type" = CONST(Posting));
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            var
                Job: Record Job;
                Cust: Record Customer;
            begin
            end;
        }
        field(50004; "Case Description"; Text[100])
        {
            CalcFormula = Lookup ("AUZ Case Header".Description WHERE("No." = FIELD("Case No.")));
            Caption = 'Case Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity;
        }
        key(Key2; "Job No.", "Job Task No.", "Resource No.")
        {
        }
    }

    trigger OnDelete()
    var
        CaseHoursDescription: Record "AUZ Case Line Description";
        CaseHoursExpenses: Record "AUZ Case Line Expense";
    begin
        CheckTransferred;

        CaseHoursDescription.DeleteDescription("Case No.", "Line No.");
        CaseHoursExpenses.DeleteExpenses("Case No.", "Line No.");

        SetLastDateTimeModified;
    end;

    trigger OnInsert()
    var
        CaseHeader: Record "AUZ Case Header";
    begin
        TestField("Job No.");
        CheckJob;
        TestField("Job Task No.");

        CheckReferenceNo;

        CaseHeader.Get("Case No.");
        if "Work Type" = '' then
            "Work Type" := CaseHeader."Work Type Code";

        if CaseHeader.Status = CaseHeader.Status::"Not Started" then begin
            CaseHeader.Validate(Status, CaseHeader.Status::"In Progress");
            CaseHeader.Modify(true);
        end;

        "Date/Time Created" := CurrentDateTime;
        SetLastDateTimeModified;
    end;

    trigger OnModify()
    begin
        CheckReferenceNo;
        SetLastDateTimeModified;
    end;

    trigger OnRename()
    begin
        Error(Text003, TableCaption);
    end;



    procedure CheckTransferred()
    begin
        if Transferred then
            Error(Text90001);
    end;


    procedure SetupNewLine()
    var
        UserSetup: Record "User Setup";
        CaseHeader: Record "AUZ Case Header";
    begin
        Date := Today;

        if UserSetup.Get(UserId) then
            "Resource No." := UserSetup."AUZ Resource No.";

        if "Case No." <> '' then begin
            CaseHeader.Get("Case No.");
            "Work Type" := CaseHeader."Work Type Code";
            "Job No." := CaseHeader."Job No.";
            "Job Task No." := CaseHeader."Job Task No.";
        end;

        Chargeable := true;
    end;


    procedure GetDefaultJobExpenses()
    begin
    end;

    local procedure CheckFields()
    begin
        TestField("Case No.");
        TestField("Line No.");
    end;

    local procedure SetCaseHoursDescriptionFilter(var CaseHoursDescription: Record "AUZ Case Line Description")
    begin
        CaseHoursDescription.SetRange("Case No.", "Case No.");
        CaseHoursDescription.SetRange("Case Line No.", "Line No.");
    end;


    procedure SetFirstDescription(NewDescription: Text[50])
    var
        CaseHoursDescription: Record "AUZ Case Line Description";
    begin
        //ToDo: Use function in journal to split lines
        CheckFields;
        Commit;
        SetCaseHoursDescriptionFilter(CaseHoursDescription);
        if CaseHoursDescription.FindFirst then begin
            CaseHoursDescription.Validate(Description, NewDescription);
            CaseHoursDescription.Modify(true);
        end else begin
            CaseHoursDescription.Init;
            CaseHoursDescription.Validate("Case No.", "Case No.");
            CaseHoursDescription.Validate("Case Line No.", "Line No.");
            CaseHoursDescription.Validate("Line No.", 10000);
            CaseHoursDescription.Validate(Description, NewDescription);
            CaseHoursDescription.Insert(true);
        end;
    end;


    procedure GetFirstDescription(): Text[50]
    var
        CaseHoursDescription: Record "AUZ Case Line Description";
    begin
        SetCaseHoursDescriptionFilter(CaseHoursDescription);
        if CaseHoursDescription.FindFirst then
            exit(CaseHoursDescription.Description);
    end;


    procedure ShowDescriptions()
    var
        CaseHoursDescription: Record "AUZ Case Line Description";
    begin
        CheckFields;
        Commit;
        SetCaseHoursDescriptionFilter(CaseHoursDescription);
        PAGE.RunModal(0, CaseHoursDescription);
    end;


    procedure GenerateDescription()
    var
        Cases: Record "AUZ Case Header";
        CaseHoursDescription: Record "AUZ Case Line Description";
    begin
        CheckFields;
        Cases.Get("Case No.");
        Cases.TestField(Description);
        SetCaseHoursDescriptionFilter(CaseHoursDescription);
        if CaseHoursDescription.IsEmpty then
            SetFirstDescription(CopyStr(StrSubstNo(Text001, LowerCase(Cases.Description)), 1, 50));
    end;


    procedure GetNextLineNo(CaseHourSource: Record "AUZ Case Line"; BelowxRec: Boolean): Integer
    var
        CaseHour: Record "AUZ Case Line";
        LowLineNo: Integer;
        HighLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        LowLineNo := 0;
        HighLineNo := 0;
        NextLineNo := 0;
        LineStep := 10000;
        CaseHour.SetRange("Case No.", "Case No.");

        if CaseHour.Find('+') then
            if not CaseHour.Get(CaseHourSource."Case No.", CaseHourSource."Line No.") then
                NextLineNo := CaseHour."Line No." + LineStep
            else
                if BelowxRec then begin
                    CaseHour.FindLast;
                    NextLineNo := CaseHour."Line No." + LineStep;
                end else
                    if CaseHour.Next(-1) = 0 then begin
                        LowLineNo := 0;
                        HighLineNo := CaseHourSource."Line No.";
                    end else begin
                        CaseHour := CaseHourSource;
                        CaseHour.Next(-1);
                        LowLineNo := CaseHour."Line No.";
                        HighLineNo := CaseHourSource."Line No.";
                    end
        else
            NextLineNo := LineStep;

        if NextLineNo = 0 then
            NextLineNo := Round((LowLineNo + HighLineNo) / 2, 1, '<');

        if CaseHour.Get("Case No.", NextLineNo) then
            exit(0);
        exit(NextLineNo);
    end;

    local procedure SetLastDateTimeModified()
    begin
        "Date/Time Modified" := CurrentDateTime;
    end;

    local procedure CheckJob()
    var
        Job: Record Job;
    begin
        if "Job No." = '' then
            exit;
        Job.Get("Job No.");
        Job.TestField("AUZ Blocked for Time Registration", false);
    end;

    local procedure CheckReferenceNo()
    var
        CaseHeader: Record "AUZ Case Header";
    begin
        CaseHeader.Get("Case No.");
        if CaseHeader."Reference No. Mandatory" then
            TestField("Reference No.");
    end;

    var
        Text90001: Label 'The hours is transferred. Modify or delete is not allowed.';
        Text50001: Label 'Expenses doesn''t exist. Do you want to copy standard values from Job No. %1 ?';
        Text001: Label 'Work iaw. %1';
        Text003: Label 'You cannot rename a %1.';
}

