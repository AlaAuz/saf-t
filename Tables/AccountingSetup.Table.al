table 70300 "Accounting Setup"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 29.12.2015 HHV Added fields for accrual.

    Caption = 'Accounting Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Sales Accrual Enabled"; Boolean)
        {
            Caption = 'Sales Accrual Enabled';
            Description = 'AZ10189';
        }
        field(3; "Purchase Accrual Enabled"; Boolean)
        {
            Caption = 'Purchase Accrual Enabled';
            Description = 'AZ10189';
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

