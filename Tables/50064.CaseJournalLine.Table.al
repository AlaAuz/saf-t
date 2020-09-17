table 50064 "AUZ Case Journal Line"
{
    Caption = 'Case Journal Line';
    DrillDownPageID = "AUZ Case Journal";
    LookupPageID = "AUZ Case Journal";

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[100])
        {
            CalcFormula = Lookup ("AUZ Case Journal Line Desc.".Description WHERE("Resource No." = FIELD("Resource No."),
                                                                                    "Journal Line No." = FIELD("Line No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(6; Imported; Boolean)
        {
            Caption = 'Imported';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Work Type"; Code[10])
        {
            Caption = 'Work Type';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(9; "Work Description"; BLOB)
        {
            Caption = 'Work Description';
            DataClassification = CustomerContent;
        }
        field(10; "No. of Descriptions"; Integer)
        {
            CalcFormula = Count ("AUZ Case Journal Line Desc." WHERE("Resource No." = FIELD("Resource No."),
                                                                       "Journal Line No." = FIELD("Line No.")));
            Caption = 'No. of Descriptions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Modified Object Text"; BLOB)
        {
            Caption = 'Modified Object Text';
            DataClassification = CustomerContent;
        }
        field(12; "Add Descriptions to Solution"; Boolean)
        {
            Caption = 'Add Descriptions to Solution';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(13; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(14; "Reference No."; Code[10])
        {
            Caption = 'Reference No.';
            DataClassification = CustomerContent;
        }
        field(100; "Case Description"; Text[100])
        {
            CalcFormula = Lookup ("AUZ Case Header".Description WHERE("No." = FIELD("Case No.")));
            Caption = 'Case Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Case Company No."; Code[20])
        {
            CalcFormula = Lookup ("AUZ Case Header"."Contact Company No." WHERE("No." = FIELD("Case No.")));
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

    trigger OnDelete()
    var
        CaseHourJournalLineDesc: Record "AUZ Case Journal Line Desc.";
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

    procedure SetupNewLine(CaseHourJournalLine: Record "AUZ Case Journal Line")
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
        CaseHourJnlMgt: Codeunit "AUZ Case Journal Management";
    begin
        CaseHourJnlMgt.InsertCaseHourJnlDescriptions(Rec);
    end;

    procedure InsertCaseHours(ResourceNo: Code[20])
    var
        CaseHourJnlMgt: Codeunit "AUZ Case Journal Management";
    begin
        CaseHourJnlMgt.InsertCaseHoursFromJnl(ResourceNo);
    end;

    procedure ImportCaseHours()
    var
        CaseHourJnlImport: XMLport "AUZ Case Journal Import";
    begin
        CaseHourJnlImport.Run;
    end;

    var
        CaseSetup: Record "AUZ Case Setup";
}