page 50062 "AUZ Case Lines Expenses"
{
    AutoSplitKey = true;
    Caption = 'Case Lines - Expenses';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "AUZ Case Line Expense";
    SourceTableView = SORTING ("Case No.", "Case Line No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; "Expense Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                }
                field(Transferred; Transferred)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
}