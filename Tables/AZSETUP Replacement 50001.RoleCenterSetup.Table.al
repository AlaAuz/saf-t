table 50003 "AUZ Role Center Setup"
{
    Caption = 'Role Center Setup';
    DrillDownPageID = "AUZ Role Center Setup";
    LookupPageID = "AUZ Role Center Setup";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(8; "Sales Chart G/L Acc. Filter"; Text[100])
        {
            Caption = 'Sales Chart G/L Account Filter';
            DataClassification = CustomerContent;
        }
        field(9; "Sales Chart Budget Name"; Code[10])
        {
            Caption = 'Sales Chart Budget Name';
            TableRelation = "G/L Budget Name";
            DataClassification = CustomerContent;
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