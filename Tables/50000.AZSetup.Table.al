table 50000 "AZ Setup"
{
    Caption = 'AZ Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(1000; "Financial Management"; Boolean)
        {
            Caption = 'Financial Management';
            Enabled = false;
        }
        field(2000; "Sales & Marketing"; Boolean)
        {
            Caption = 'Sales & Marketing';
            Enabled = false;
        }
        field(2001; "Sales Accrual Enabled"; Boolean)
        {
            Caption = 'Sales Accrual Enabled';
            Description = 'AZ99999';
        }
        field(2002; "Sales Accrual Bal. Account No."; Code[20])
        {
            Caption = 'Sales Accrual Bal. Account No.';
            Description = 'AZ99999';
        }
        field(2003; "Sales To Accrual Account No."; Code[20])
        {
            Caption = 'Sales To Accrual Account No.';
            Description = 'AZ99999';
        }
        field(2004; "Sales From Accrual Account No."; Code[20])
        {
            Caption = 'Sales From Accrual Account No.';
            Description = 'AZ99999';
        }
        field(3000; Purchase; Boolean)
        {
            Caption = 'Purchase';
            Enabled = false;
        }
        field(4000; Warehouse; Boolean)
        {
            Caption = 'Warehouse';
            Enabled = false;
        }
        field(5000; Manufacturing; Boolean)
        {
            Caption = 'Manufacturing';
            Enabled = false;
        }
        field(6000; Jobs; Boolean)
        {
            Caption = 'Jobs';
            Enabled = false;
        }
        field(7000; "Resource Planning"; Boolean)
        {
            Caption = 'Resource Planning';
            Enabled = false;
        }
        field(8000; Service; Boolean)
        {
            Caption = 'Service';
            Enabled = false;
        }
        field(8001; "Check Service Period"; Boolean)
        {
            Caption = 'Check Service Period';
            InitValue = true;
        }
        field(8002; "Service Accrual Enabled"; Boolean)
        {
            Caption = 'Service Accrual Enabled';
            Description = 'AZ99999';
        }
        field(8003; "Serv. Accrual Bal. Account No."; Code[20])
        {
            Caption = 'Service Accrual Bal. Account No.';
            Description = 'AZ99999';
        }
        field(8004; "Service To Accrual Account No."; Code[20])
        {
            Caption = 'Service To Accrual Account No.';
            Description = 'AZ99999';
        }
        field(8005; "Serv. From Accrual Account No."; Code[20])
        {
            Caption = 'Service From Accrual Account No.';
            Description = 'AZ99999';
        }
        field(9000; "Human Resource"; Boolean)
        {
            Caption = 'Human Resources';
            Enabled = false;
        }
        field(10000; Administration; Boolean)
        {
            Caption = 'Administration';
            Enabled = false;
        }
        field(11000; "AZ Solutions"; Boolean)
        {
            Caption = 'AZ Solutions';
        }
        field(12000; "3. Part Integrations"; Boolean)
        {
            Caption = '3. Part Integrations';
            Enabled = false;
        }
        field(13000; "Job Queue"; Boolean)
        {
            Caption = 'Job Queue';
            Description = 'AZ10414';
            Enabled = false;
        }
        field(14000; "Role Center"; Boolean)
        {
            Caption = 'Role Center';
            Enabled = false;
        }
        //FIX - se på dargan hvor disse ligger nå
        field(14001; "Sales Chart G/L Account Filter"; Text[100])
        {
            Caption = 'Sales Chart G/L Account Filter';
            Description = 'AZ12384';

            trigger OnLookup()
            var
                GLAccountList: Page "G/L Account List";
            begin
                GLAccountList.LookupMode(true);
                if GLAccountList.RunModal = ACTION::LookupOK then
                    "Sales Chart G/L Account Filter" := GLAccountList.GetSelectionFilter;
            end;
        }
        field(14002; "Sales Chart Budget Name"; Code[10])
        {
            Caption = 'Sales Chart Budget Name';
            Description = 'AZ12384';
            TableRelation = "G/L Budget Name";
        }
        field(90000; "Expenses Entries No. Series"; Code[10])
        {
            Caption = 'Omkostningsløpenummer serie';
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

