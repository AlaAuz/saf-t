table 90200 "Remote Setup"
{
    Caption = 'Remote Setup';
    DrillDownPageID = "Remote Setup";
    LookupPageID = "Remote Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Remote Login Nos."; Code[10])
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Remote Login Nos.';
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

