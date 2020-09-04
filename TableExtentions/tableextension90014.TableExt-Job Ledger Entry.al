tableextension 90014 tableextension90014 extends "Job Ledger Entry"
{
    fields
    {
        field(50001; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            Description = 'AZ10001';
            TableRelation = "Case Header";
        }
        field(50002; "Case Hour Line No."; Integer)
        {
            Caption = 'Case Line No.';
            DataClassification = ToBeClassified;
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
