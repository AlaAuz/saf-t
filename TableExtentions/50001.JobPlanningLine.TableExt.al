tableextension 50001 "AUZ Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(50000; "AUZ Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ Case Line No."; Integer)
        {
            Caption = 'Case Line No.';
            Description = 'AZ10001';
            TableRelation = "AUZ Case Line"."Line No." WHERE("Case No." = FIELD("AUZ Case No."));
            DataClassification = CustomerContent;
        }
        field(50002; "AUZ Case Description"; Text[100])
        {
            Caption = 'Case Description';
            DataClassification = CustomerContent;
        }
    }
}

