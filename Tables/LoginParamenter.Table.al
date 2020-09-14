table 90207 "Login Paramenter"
{
    Caption = 'Login Paramenter';
    DrillDownPageID = "Login Paramenters";
    LookupPageID = "Login Paramenters";

    fields
    {
        field(1; "Login Type"; Code[10])
        {
            Caption = 'Login Type';
            NotBlank = true;
            TableRelation = "Login Type";
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence';
            Numeric = true;
        }
        field(3; Replace; Text[50])
        {
            Caption = 'Replace';
            NotBlank = true;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Value Type"; Option)
        {
            Caption = 'Value Type';
            OptionCaption = 'Domain,Username,Password,Login ID';
            OptionMembers = Domain,Username,Password,"Login ID";
        }
    }

    keys
    {
        key(Key1; "Login Type", Sequence, Replace)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Login Type", Sequence, Replace, Description)
        {
        }
    }

    trigger OnInsert()
    begin
        if Description = '' then
            Description := Format("Value Type");
    end;

    trigger OnRename()
    begin
        Error(RenameErr, TableCaption);
    end;

    var
        RenameErr: Label 'You cannot rename a %1.';
}

