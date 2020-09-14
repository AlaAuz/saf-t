table 90100 "Standard Solution Setup"
{
    Caption = 'Standard Solution Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Standard Solution Nos."; Code[10])
        {
            Caption = 'Standard Solution Nos.';
            TableRelation = "No. Series";
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

