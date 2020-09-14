table 90005 "Expense Code"
{
    Caption = 'Expense Code';
    DrillDownPageID = "Expense Code List";
    LookupPageID = "Expense Code List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(3; Description; Text[50])
        {
            Caption = 'Beskrivelse';
        }
        field(4; "Unit of Measure"; Code[10])
        {
            Caption = 'Enhet';
            TableRelation = "Unit of Measure";
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Antall';
        }
        field(6; Price; Decimal)
        {
            Caption = 'Pris';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

