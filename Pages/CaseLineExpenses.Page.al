page 90012 "Case Line Expenses"
{
    AutoSplitKey = true;
    Caption = 'Case Hours - Expenses';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Case Hour Expense";
    SourceTableView = SORTING ("Case No.", "Case Hour Line No.");

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
                field("Unit of Measure"; "Unit of Measure")
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

