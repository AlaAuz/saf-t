table 50056 "AUZ Case Line Expense"
{
    Caption = 'Case Line Expense';
    DrillDownPageID = "AUZ Case Lines Expenses";
    LookupPageID = "AUZ Case Lines Expenses";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(2; "Case Line No."; Integer)
        {
            Caption = 'Case Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Expense Code"; Code[20])
        {
            Caption = 'Expense Code';
            TableRelation = "AUZ Expense Code";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Expense Code" <> xRec."Expense Code" then
                    GetExpenseDefaults;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(8; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
        }
        field(100; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = CustomerContent;
        }
        field(101; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Case No.", "Case Line No.", "Line No.")
        {
            Clustered = true;
        }
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

    procedure DeleteExpenses(CaseNo: Code[20]; LineNo: Integer)
    begin
        if CaseNo = '' then
            Error(BlankCaseNoErr);

        SetRange("Case No.", CaseNo);
        SetRange("Case Line No.", LineNo);

        DeleteAll;
    end;

    procedure CheckTransferred()
    begin
        if Transferred then
            Error(Text90001);
    end;

    var
        Text003: Label 'You cannot rename a %1.';
        Text90001: Label 'The hours is transferred. Modify or delete is not allowed.';
        BlankCaseNoErr: Label 'Case No. is missing, not able to delete description!';
}