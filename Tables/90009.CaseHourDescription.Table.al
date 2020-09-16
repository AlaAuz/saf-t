table 90009 "AUZ Case Line Description"
{
    Caption = 'Case Line Description';
    DrillDownPageID = "Case Line Descriptions";
    LookupPageID = "Case Line Descriptions";
    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Case Line No."; Integer)
        {
            Caption = 'Case Line No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(100; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = CustomerContent;
        }
        field(101; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Case Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        CheckTransferred;
    end;

    trigger OnInsert()
    begin
        TestField("Case No.");
        TestField("Case Line No.");
    end;

    trigger OnModify()
    begin
        CheckTransferred;
    end;

    trigger OnRename()
    begin
        Error(Text003, TableCaption);
    end;

    procedure DeleteDescription(CaseNo: Code[20]; LineNo: Integer)
    begin
        if CaseNo = '' then
            Error('Case No. is missing, not able to delete description!');

        SetRange("Case No.", CaseNo);
        SetRange("Case Line No.", LineNo);

        DeleteAll;
    end;

    procedure CheckTransferred()
    begin
        if Transferred then
            Error(Text90001);
    end;

    var
        Text003: Label 'You cannot rename a %1.';
        Text90001: Label 'The hours is transferred. Modify or delete is not allowed.';
}