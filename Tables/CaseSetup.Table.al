table 90011 "Case Setup"
{
    Caption = 'Case Setup';
    DrillDownPageID = "Case Setup";
    LookupPageID = "Case Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Default Work Type"; Code[10])
        {
            Caption = 'Default Work Type';
            TableRelation = "Work Type";
        }
        field(3; "Default E-Mail"; Text[80])
        {
            Caption = 'Default Email';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

