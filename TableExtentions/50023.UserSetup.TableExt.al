tableextension 50023 "AUZ User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "AUZ Development Administrator"; Boolean)
        {
            Caption = 'Development Administrator';
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource;
        }
        field(50002; "AUZ Developer"; Boolean)
        {
            Caption = 'Developer';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Consultant"; Boolean)
        {
            Caption = 'Consultant';
            DataClassification = CustomerContent;
        }
    }
}

