table 90007 "Job Expense"
{
    Caption = 'Job Expense';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Prosjektnr.';
            TableRelation = Job;
        }
        field(2; "Expense Code"; Code[20])
        {
            Caption = 'Expense Code';
            TableRelation = "Expense Code";

            trigger OnValidate()
            begin
                GetExpenseDefaults();
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Beskrivelse';
        }
        field(5; "Unit of Measure"; Code[10])
        {
            Caption = 'Enhet';
            TableRelation = "Unit of Measure";
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Antall';
        }
        field(7; Price; Decimal)
        {
            Caption = 'Pris';
        }
    }

    keys
    {
        key(Key1; "Job No.", "Expense Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

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
    procedure InsertJobExpenseDefaults(JobNo: Code[20]; EntryNo: Integer; var ExpenseEntries: Record "Case Hour Expense")
    begin
        /*
        SETRANGE("Job No.",JobNo);
        
        IF FINDSET THEN REPEAT
          ExpenseEntries."Case No." := EntryNo;
          ExpenseEntries."Case Hour Line No." := ExpenseEntries."Case Hour Line No." + 10000;
          ExpenseEntries."Line No." := "Expense Code";
          ExpenseEntries.Description := Description;
          ExpenseEntries."Unit of Measure" := "Unit of Measure";
          ExpenseEntries.Quantity := Quantity;
          ExpenseEntries.Price := Price;
          ExpenseEntries.INSERT;
        UNTIL NEXT = 0;
        */

    end;
}

