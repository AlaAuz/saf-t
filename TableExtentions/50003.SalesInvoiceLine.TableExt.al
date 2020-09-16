tableextension 50003 "AUZ Sales Invoice Line" extends "Sales Invoice Line"
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
            TableRelation = "AUZ Case Line"."Line No." WHERE("Case No." = FIELD("AUZ Case No."));
        }
        field(50002; "AUZ Expense Line No."; Integer)
        {
            Caption = 'Expense Line No.';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Case Description"; Text[100])
        {
            Caption = 'Case Description';
            DataClassification = CustomerContent;
        }
    }
}