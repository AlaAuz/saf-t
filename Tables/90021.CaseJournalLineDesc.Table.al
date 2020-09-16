table 90021 "AUZ Case Journal Line Desc."
{
    Caption = 'Case Line Description';
    DrillDownPageID = "Case Journal Descriptions";
    LookupPageID = "Case Journal Descriptions";

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(2; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
            TableRelation = "AUZ Case Journal Line"."Line No." WHERE("Resource No." = FIELD("Resource No."));
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Journal Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TestField("Resource No.");
        TestField("Journal Line No.");
    end;

    procedure RestoreDescriptions()
    var
        CaseHourJournalLine: Record "AUZ Case Journal Line";
        CaseHourJournalLineDesc: Record "AUZ Case Journal Line Desc.";
    begin
        TestField("Resource No.");
        TestField("Journal Line No.");

        CaseHourJournalLine.Get("Resource No.", "Journal Line No.");
        CaseHourJournalLine.TestField(Imported);

        if not Confirm(RestoreQst, false) then
            Error('');

        CaseHourJournalLineDesc.SetRange("Resource No.", "Resource No.");
        CaseHourJournalLineDesc.SetRange("Journal Line No.", "Journal Line No.");
        CaseHourJournalLineDesc.DeleteAll(true);

        CaseHourJournalLine.InsertCaseHourJnlDescriptions;
    end;

    var
        RestoreQst: Label 'Do you want to restore imported descriptions?';
}

