table 90205 "Login Type"
{
    Caption = 'Login Type';
    DrillDownPageID = "Login Types";
    LookupPageID = "Login Types";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        LoginPath: Record "Login Path";
    begin
        LoginPath.SetRange("Login Type", Code);
        LoginPath.DeleteAll(true);
    end;
}

