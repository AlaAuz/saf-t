page 90013 "Job Expense List"
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
            }
        }
    }

    actions
    {
    }
}

