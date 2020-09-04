tableextension 90027 tableextension90027 extends "Service Line"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on ""Appl.-to Service Entry"(Field 5903)".

        field(50000; "Serv. Contract Line From Date"; Date)
        {
            Caption = 'Serv. Contract Line From Date';
        }
        field(50001; "Serv. Contract Line To Date"; Date)
        {
            Caption = 'Serv. Contract Line To Date';
        }
        field(50002; "SCL Invoiced to Date"; Date)
        {
            Caption = 'Service Contract Line Invoiced to Date';
        }
        field(50003; "Show on Print"; Boolean)
        {
            Caption = 'Show on Print';
            InitValue = true;
        }
        field(50004; "SCL Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Service Contract Line Quantity';
        }
        field(50005; "Accrual From Date"; Date)
        {
            Caption = 'Accrual From Date';
        }
        field(50006; "Accrual to Date"; Date)
        {
            Caption = 'Accrual to Date';
        }
        field(50007; "SCL Line No."; Integer)
        {
            Caption = 'Service Contract Line Line No.';
        }
        field(50008; "SCL New Line"; Boolean)
        {
            Caption = 'Service Contract Line New Line';
            Editable = false;
        }
    }
}

