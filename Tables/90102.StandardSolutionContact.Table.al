table 90102 "AUZ Standard Solution Contact"
{
    Caption = 'Standard Solution Contact';

    fields
    {
        field(1; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            TableRelation = "AUZ Standard Solution";
            DataClassification = CustomerContent;
        }
        field(2; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact WHERE(Type = CONST(Company));
            DataClassification = CustomerContent;
        }
        field(3; "Contact Name"; Text[50])
        {
            CalcFormula = Lookup (Contact.Name WHERE("No." = FIELD("Contact No.")));
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Version Code", "Contact No.")
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
        StandardSolutionMgt: Codeunit "Standard Solution Management";
        ChangeType: Option Insertion,Modification,Deletion;


    procedure CheckChangePermissions(Type: Option)
    var
        StandardSolution: Record "AUZ Standard Solution";
    begin
        StandardSolution.Get("Standard Solution No.");
        StandardSolution.CheckChangePermissions(Type);
    end;
}