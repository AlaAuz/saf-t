tableextension 50015 "AUZ Service Ledger Entry" extends "Service Ledger Entry"
{
    fields
    {
        field(50000; "AUZ SCL Invoiced to Date"; Date)
        {
            Caption = 'Service Contract Line Invoiced to Date';
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ SCL Quantity"; Decimal)
        {
            Caption = 'Service Contract Line Quantity';
            DataClassification = CustomerContent;
        }
        field(50002; "AUZ SCL Line No."; Integer)
        {
            Caption = 'Service Contract Line Line No.';
            DataClassification = SystemMetadata;
        }
        field(50003; "AUZ SCL New Line"; Boolean)
        {
            Caption = 'Service Contract Line New Line';
            DataClassification = CustomerContent;
        }
    }
}

