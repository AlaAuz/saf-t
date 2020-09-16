tableextension 50007 "AUZ Customer" extends Customer
{
    fields
    {
        field(50000; "AUZ Invoicing Period Code"; Code[10])
        {
            Caption = 'Invoicing Period Code';
            TableRelation = "AUZ Invoicing Period";
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ Developer ID"; Code[50])
        {
            Caption = 'Developer ID';
            DataClassification = CustomerContent;
            Description = 'AZ99999';
            TableRelation = "User Setup"."User ID" WHERE("AUZ Developer" = CONST(true));
        }
        field(50002; "AUZ Consultant ID"; Code[50])
        {
            Caption = 'Consultant ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID" WHERE("AUZ Consultant" = CONST(true));
        }
    }
}