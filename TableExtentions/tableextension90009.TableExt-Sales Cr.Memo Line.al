tableextension 90009 tableextension90009 extends "Sales Cr.Memo Line"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 29.12.2015 HHV Added fields and code for accrual. (AC1.0)
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
        field(50003; "Expense Line No."; Integer)
        {
            Caption = 'Expense Line No.';
            Description = 'AZ10001';
        }
        field(50004; "Case Description"; Text[50])
        {
            Caption = 'Case Description';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
        }
    }
}

