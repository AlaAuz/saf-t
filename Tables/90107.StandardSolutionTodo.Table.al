table 90107 "AUZ Standard Solution To-do"
{
    Caption = 'Standard Solution To-do';
    DrillDownPageID = "Standard Solution To-Do List";
    LookupPageID = "Standard Solution To-Do List";

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
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(5; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Completed then
                    TestField("Version Code");
            end;
        }
        field(6; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
            TableRelation = "AUZ Standard Solution Release"."Version Code" WHERE("Standard Solution No." = FIELD("Standard Solution No."));
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
            DataClassification = CustomerContent;
            TableRelation = "AUZ Case Header";
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Line No.")
        {
            Clustered = true;
        }
    }
}