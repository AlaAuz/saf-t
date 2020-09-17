table 50107 "AUZ Standard Solution Field"
{
    Caption = 'Standard Solution Field';
    DrillDownPageID = "AUZ Std. Solution Field List";
    LookupPageID = "AUZ Std. Solution Field List";

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
        field(4; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(5; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
        field(6; "Field No."; Integer)
        {
            Caption = 'Field No.';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name';
            DataClassification = CustomerContent;
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