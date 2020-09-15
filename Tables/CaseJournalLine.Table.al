table 90020 "Case Journal Line"
{
    Caption = 'Case Hour Line';
    DrillDownPageID = "Case Journal";
    LookupPageID = "Case Journal";

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "Case Header";
        }
        field(4; Description; Text[50])
        {
            CalcFormula = Lookup ("Case Journal Line Description".Description WHERE("Resource No." = FIELD("Resource No."),
                                                                                    "Journal Line No." = FIELD("Line No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
        }
        field(6; Imported; Boolean)
        {
            Caption = 'Imported';
            Editable = false;
        }
        field(7; "Work Type"; Code[10])
        {
            Caption = 'Work Type';
            TableRelation = "Work Type";
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
        }
        field(9; "Work Description"; BLOB)
        {
            Caption = 'Work Description';
        }
        field(10; "No. of Descriptions"; Integer)
        {
            CalcFormula = Count ("Case Journal Line Description" WHERE("Resource No." = FIELD("Resource No."),
                                                                       "Journal Line No." = FIELD("Line No.")));
            Caption = 'No. of Descriptions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Modified Object Text"; BLOB)
        {
            Caption = 'Modified Object Text';
        }
        field(12; "Add Descriptions to Solution"; Boolean)
        {
            Caption = 'Add Descriptions to Solution';
            InitValue = true;
        }
        field(13; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
        field(14; "Reference No."; Code[10])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(100; "Case Description"; Text[50])
        {
            CalcFormula = Lookup ("Case Header".Description WHERE("No." = FIELD("Case No.")));
            Caption = 'Case Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Case Company No."; Code[20])
        {
            CalcFormula = Lookup ("Case Header"."Contact Company No." WHERE("No." = FIELD("Case No.")));
            Caption = 'Case Company No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Contact;
        }
        field(102; "Case Company Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE("No." = FIELD("Case Company No.")));
            Caption = 'Case Company Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CaseHourJournalLineDesc: Record "Case Journal Line Description";
    begin
        CaseHourJournalLineDesc.SetRange("Resource No.", "Resource No.");
        CaseHourJournalLineDesc.SetRange("Journal Line No.", "Line No.");
        CaseHourJournalLineDesc.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        TestField("Resource No.");
    end;

    trigger OnModify()
    begin
        TestField("Resource No.");
    end;

    var
        CaseSetup: Record "Case Setup";


    procedure SetupNewLine(CaseHourJournalLine: Record "Case Journal Line")
    begin
        if CaseHourJournalLine."Line No." = 0 then begin
            CaseSetup.Get;
            Validate("Work Type", CaseSetup."Default Work Type");
            Validate(Date, WorkDate);
        end else begin
            Validate("Work Type", CaseHourJournalLine."Work Type");
            Validate(Date, CaseHourJournalLine.Date);
        end;
    end;

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear("Work Description");
        if NewWorkDescription = '' then
            exit;
        TempBlob.Blob := "Work Description";
        TempBlob.WriteAsText(NewWorkDescription, TEXTENCODING::Windows);
        "Work Description" := TempBlob.Blob;
        Modify;
    end;

    procedure GetWorkDescription(): Text
    var
        TempBlob: Record TempBlob temporary;
        CR: Text[1];
    begin
        CalcFields("Work Description");
        if not "Work Description".HasValue then
            exit('');
        CR[1] := 10;
        TempBlob.Blob := "Work Description";
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;

    procedure SetModifiedObjectText(NewModifiedObjectText: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear("Modified Object Text");
        if NewModifiedObjectText = '' then
            exit;
        TempBlob.Blob := "Modified Object Text";
        TempBlob.WriteAsText(NewModifiedObjectText, TEXTENCODING::Windows);
        "Modified Object Text" := TempBlob.Blob;
        Modify;
    end;

    procedure GetModifiedObjectText(): Text
    var
        TempBlob: Record TempBlob temporary;
        CR: Text[1];
    begin
        CalcFields("Modified Object Text");
        if not "Modified Object Text".HasValue then
            exit('');
        CR[1] := 10;
        TempBlob.Blob := "Modified Object Text";
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;


    procedure InsertCaseHourJnlDescriptions()
    var
        CaseHourJnlMgt: Codeunit "Case Journal Management";
    begin
        CaseHourJnlMgt.InsertCaseHourJnlDescriptions(Rec);
    end;


    procedure InsertCaseHours(ResourceNo: Code[20])
    var
        CaseHourJnlMgt: Codeunit "Case Journal Management";
    begin
        CaseHourJnlMgt.InsertCaseHoursFromJnl(ResourceNo);
    end;


    procedure ImportCaseHours()
    var
        CaseHourJnlImport: XMLport "Case Journal Import";
    begin
        CaseHourJnlImport.Run;
    end;
}

