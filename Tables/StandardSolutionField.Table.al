table 90108 "Standard Solution Field"
{
    Caption = 'Standard Solution Field';
    DrillDownPageID = "Standard Solution Field List";
    LookupPageID = "Standard Solution Field List";

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
        field(4; "Table No."; Integer)
        {
            Caption = 'Table No.';
            MinValue = 0;
        }
        field(5; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
        }
        field(6; "Field No."; Integer)
        {
            Caption = 'Field No.';
            MinValue = 0;
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
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

