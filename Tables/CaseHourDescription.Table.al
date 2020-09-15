table 90009 "Case Hour Description"
{
    Caption = 'Case Hour Description';
    DrillDownPageID = "Case Line Descriptions";
    LookupPageID = "Case Line Descriptions";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            NotBlank = true;
            TableRelation = "Case Header";
        }
        field(2; "Case Hour Line No."; Integer)
        {
            Caption = 'Case Hour Line No.';
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(100; Transferred; Boolean)
        {
            Caption = 'Overført';
        }
        field(101; Posted; Boolean)
        {
            Caption = 'Bokført';
        }
    }

    keys
    {
        key(Key1; "Case No.", "Case Hour Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckTransferred;
    end;

    trigger OnInsert()
    begin
        TestField("Case No.");
        TestField("Case Hour Line No.");
    end;

    trigger OnModify()
    begin
        CheckTransferred;
    end;

    trigger OnRename()
    begin
        Error(Text003, TableCaption);
    end;

    var
        Text003: Label 'You cannot rename a %1.';
        Text90001: Label 'The hours is transferred. Modify or delete is not allowed.';


    procedure DeleteDescription(CaseNo: Code[20]; LineNo: Integer)
    begin
        if CaseNo = '' then
            Error('Case No. is missing, not able to delete description!');

        SetRange("Case No.", CaseNo);
        SetRange("Case Hour Line No.", LineNo);

        DeleteAll;
    end;


    procedure CheckTransferred()
    begin
        if Transferred then
            Error(Text90001);
    end;
}

