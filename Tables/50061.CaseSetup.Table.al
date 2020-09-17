table 50061 "AUZ Case Setup"
{
    Caption = 'Case Setup';
    DrillDownPageID = "AUZ Case Setup";
    LookupPageID = "AUZ Case Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Default Work Type"; Code[10])
        {
            Caption = 'Default Work Type';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(3; "Default E-Mail"; Text[80])
        {
            Caption = 'Default Email';
            DataClassification = CustomerContent;
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
}