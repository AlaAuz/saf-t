tableextension 90028 tableextension90028 extends "Service Ledger Entry"
{
    fields
    {
        field(50000; "SCL Invoiced to Date"; Date)
        {
            Caption = 'Service Contract Line Invoiced to Date';
        }
        field(50001; "SCL Quantity"; Decimal)
        {
            Caption = 'Service Contract Line Quantity';
        }
        field(50002; "SCL Line No."; Integer)
        {
            Caption = 'Service Contract Line Line No.';
        }
        field(50003; "SCL New Line"; Boolean)
        {
            Caption = 'Service Contract Line New Line';
        }
    }
}

