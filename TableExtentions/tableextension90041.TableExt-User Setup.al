tableextension 90041 tableextension90041 extends "User Setup"
{
    // *** Auzilium AS ***
    // AZ99999 11.11.2016 HHV Added field "Show in Case Hours Chart".
    fields
    {
        field(50000; "Development Administrator"; Boolean)
        {
            Caption = 'Development Administrator';
            Description = 'AZ99999';
        }
        field(50001; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            Description = 'AZ10001';
            TableRelation = Resource;
        }
        field(50002; Developer; Boolean)
        {
            Caption = 'Developer';
            Description = 'AZ99999';
        }
        field(50003; Consultant; Boolean)
        {
            Caption = 'Consultant';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
        }
    }
}

