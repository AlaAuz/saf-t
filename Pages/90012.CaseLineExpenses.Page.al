page 90012 "Case Lines Expenses"
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
                }
                field(Description; Description)
                {
                }
                field("Unit of Measure"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Price; Price)
                {
                }
                field(Transferred; Transferred)
                {
                    Visible = false;
                }
                field(Posted; Posted)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

