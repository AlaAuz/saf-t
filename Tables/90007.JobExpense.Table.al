table 90007 "AUZ Job Expense"
{
    Caption = 'Job Expense';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(2; "Expense Code"; Code[20])
        {
            Caption = 'Expense Code';
            TableRelation = "AUZ Expense Code";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetExpenseDefaults();
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; Price; Decimal)
        {
            Caption = 'Price';
            AutoFormatType = 2;
            DataClassification = CustomerContent;
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


    procedure GetExpenseDefaults()
    var
        Expenses: Record "AUZ Expense Code";
    begin
        Expenses.Get("Expense Code");
        Description := Expenses.Description;
        "Unit of Measure Code" := Expenses."Unit of Measure Code";
        Quantity := Expenses.Quantity;
        Price := Expenses.Price;
    end;
}