table 90104 "AUZ Standard Solution Change"
{

    fields
    {
        field(1; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            TableRelation = "AUZ Standard Solution";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Version Code", "Line No.")
        {
            Clustered = true;
        }
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
        ChangeType: Option Insertion,Modification,Deletion;


    procedure CheckChangePermissions(Type: Option)
    var
        StandardSolution: Record "AUZ Standard Solution";
    begin
        StandardSolution.Get("Standard Solution No.");
        StandardSolution.CheckChangePermissions(Type);
    end;
}