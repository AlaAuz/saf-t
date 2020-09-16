tableextension 50022 "AUZ Service Cr.Memo Line" extends "Service Cr.Memo Line"
{
    fields
    {
        field(50000; "AUZ Serv. Contract Line From Date"; Date)
        {
            Caption = 'Serv. Contract Line From Date';
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ Serv. Contract Line To Date"; Date)
        {
            Caption = 'Serv. Contract Line To Date';
            DataClassification = CustomerContent;
        }
        field(50002; "AUZ SCL Invoiced to Date"; Date)
        {
            Caption = 'Service Contract Line Invoiced to Date';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Show on Print"; Boolean)
        {
            Caption = 'Show on Print';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(50004; "AUZ SCL Quantity"; Decimal)
        {
            Caption = 'Service Contract Line Quantity';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(50005; "AUZ SCL Line No."; Integer)
        {
            Caption = 'Service Contract Line Line No.';
            DataClassification = CustomerContent;
        }
        field(50006; "AUZ SCL New Line"; Boolean)
        {
            Caption = 'Service Contract Line New Line';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}

