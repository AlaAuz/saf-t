table 90107 "Standard Solution To-do"
{
    Caption = 'Standard Solution To-do';
    DrillDownPageID = "Standard Solution To-Do List";
    LookupPageID = "Standard Solution To-Do List";

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
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(5; Completed; Boolean)
        {
            Caption = 'Completed';

            trigger OnValidate()
            begin
                if Completed then
                    TestField("Version Code");
            end;
        }
        field(6; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            TableRelation = "Standard Solution Release"."Version Code" WHERE ("Standard Solution No." = FIELD ("Standard Solution No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Version Code" = '' then
                    TestField(Completed, false);
            end;
        }
        field(7; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            TableRelation = "Case Header";
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

