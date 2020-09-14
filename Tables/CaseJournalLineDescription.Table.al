table 90021 "Case Journal Line Description"
{
    Caption = 'Case Hour Line Description';
    DrillDownPageID = "Case Journal Descriptions";
    LookupPageID = "Case Journal Descriptions";

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;
        }
        field(2; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
            NotBlank = true;
            TableRelation = "Case Journal Line"."Line No." WHERE ("Resource No." = FIELD ("Resource No."));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Journal Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestField("Resource No.");
        TestField("Journal Line No.");
    end;

    var
        RestoreQst: Label 'Do you want to restore imported descriptions?';

    [Scope('Internal')]
    procedure RestoreDescriptions()
    var
        CaseHourJournalLine: Record "Case Journal Line";
        CaseHourJournalLineDesc: Record "Case Journal Line Description";
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
}

