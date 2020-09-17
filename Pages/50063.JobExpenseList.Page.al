page 50063 "AUZ Job Expense List"
{
    PageType = List;
    SourceTable = "AUZ Job Expense";

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
            }
        }
    }
}