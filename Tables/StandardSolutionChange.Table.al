table 90104 "Standard Solution Change"
{

    fields
    {
        field(1; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            TableRelation = "Standard Solution";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Version Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckChangePermissions(ChangeType::Deletion);
    end;

    trigger OnInsert()
    begin
        CheckChangePermissions(ChangeType::Insertion);
    end;

    trigger OnModify()
    begin
        CheckChangePermissions(ChangeType::Modification);
    end;

    trigger OnRename()
    begin
        CheckChangePermissions(ChangeType::Modification);
    end;

    var
        StandardSolutionMgt: Codeunit "Standard Solution Management";
        ChangeType: Option Insertion,Modification,Deletion;

    [Scope('Internal')]
    procedure CheckChangePermissions(Type: Option)
    var
        StandardSolution: Record "Standard Solution";
    begin
        StandardSolution.Get("Standard Solution No.");
        StandardSolution.CheckChangePermissions(Type);
    end;
}

