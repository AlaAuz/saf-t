table 90206 "Login Path"
{
    Caption = 'Login Path';
    DrillDownPageID = "Login Paths";
    LookupPageID = "Login Paths";

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
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Path; Text[250])
        {
            Caption = 'Path';
            NotBlank = true;
        }
        field(5; Parameters; Text[250])
        {
            Caption = 'Parameters';
        }
    }

    keys
    {
        key(Key1; "Login Type", Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Login Type", Sequence, Description)
        {
        }
    }

    trigger OnDelete()
    var
        LoginParamenter: Record "Login Paramenter";
    begin
        LoginParamenter.SetRange("Login Type", "Login Type");
        LoginParamenter.SetRange(Sequence, Sequence);
        LoginParamenter.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        CheckFields;
    end;

    trigger OnModify()
    begin
        CheckFields;
    end;

    trigger OnRename()
    var
        LoginParamenter: Record "Login Paramenter";
        LoginParamenter2: Record "Login Paramenter";
    begin
        LoginParamenter.SetRange("Login Type", xRec."Login Type");
        LoginParamenter.SetRange(Sequence, xRec.Sequence);
        if LoginParamenter.FindSet(true, true) then
            repeat
                LoginParamenter2 := LoginParamenter;
                LoginParamenter2.Rename("Login Type", Sequence);
            until LoginParamenter.Next = 0;
    end;

    local procedure CheckFields()
    begin
        TestField(Path);
    end;
}

