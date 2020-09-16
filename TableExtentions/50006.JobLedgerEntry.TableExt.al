tableextension 50006 "AUZ Job Ledger Entry" extends "Job Ledger Entry"
{
    fields
    {
        field(50000; "AUZ Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = CustomerContent;
            TableRelation = "AUZ Case Header";
        }
        field(50001; "AUZ Case Line No."; Integer)
        {
            Caption = 'Case Line No.';
            DataClassification = CustomerContent;
            Description = 'AZ10001';
            TableRelation = "AUZ Case Line"."Line No." WHERE("Case No." = FIELD("AUZ Case No."));
        }
        field(50002; "AUZ Case Description"; Text[100])
        {
            Caption = 'Case Description';
            DataClassification = CustomerContent;
        }
    }
}