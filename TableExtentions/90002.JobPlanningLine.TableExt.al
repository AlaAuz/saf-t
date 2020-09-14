tableextension 90002 "AUZ Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(50001; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            Description = 'AZ10001';
            TableRelation = "Case Header";
        }
        field(50002; "Case Hour Line No."; Integer)
        {
            Caption = 'Case Line No.';
            Description = 'AZ10001';
            TableRelation = "Case Line"."Line No." WHERE ("Case No." = FIELD ("Case No."));
        }
        field(50004; "Case Description"; Text[50])
        {
            Caption = 'Case Description';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
        }
    }
}

