table 90006 "Case Hour Expense"
{
    Caption = 'Case Hour Expense';
    DrillDownPageID = "Case Line Expenses";
    LookupPageID = "Case Line Expenses";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "Case Header";
        }
        field(2; "Case Hour Line No."; Integer)
        {
            Caption = 'Case Hour Line No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Linjenr.';
        }
        field(4; "Expense Code"; Code[20])
        {
            Caption = 'Omkostningskode';
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                if "Expense Code" <> xRec."Expense Code" then
                    GetExpenseDefaults;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Beskrivelse';
        }
        field(6; "Unit of Measure"; Code[10])
        {
            Caption = 'Enhet';
            TableRelation = "Unit of Measure";
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Antall';
        }
        field(8; Price; Decimal)
        {
            Caption = 'Pris';
        }
        field(100; Transferred; Boolean)
        {
            Caption = 'Overført';
        }
        field(101; Posted; Boolean)
        {
            Caption = 'Bokført';
        }
    }

    keys
    {
        key(Key1; "Case No.", "Case Hour Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        CheckTransferred;
    end;

    trigger OnModify()
    begin
        CheckTransferred;
    end;

    trigger OnRename()
    begin
        Error(Text003, TableCaption);
    end;

    var
        Text003: Label 'You cannot rename a %1.';
        Text90001: Label 'The hours is transferred. Modify or delete is not allowed.';

    [Scope('Internal')]
    procedure GetExpenseDefaults()
    var
        Expenses: Record "Expense Code";
    begin
        Expenses.Get("Expense Code");
        Description := Expenses.Description;
        "Unit of Measure" := Expenses."Unit of Measure";
        Quantity := Expenses.Quantity;
        Price := Expenses.Price;
    end;

    [Scope('Internal')]
    procedure DeleteExpenses(CaseNo: Code[20]; LineNo: Integer)
    begin
        if CaseNo = '' then
            Error('Case No. is missing, not able to delete description!');

        SetRange("Case No.", CaseNo);
        SetRange("Case Hour Line No.", LineNo);

        DeleteAll;
    end;

    [Scope('Internal')]
    procedure CheckTransferred()
    begin
        if Transferred then
            Error(Text90001);
    end;
}

