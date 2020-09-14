page 90013 "Job Expense List"
{
    PageType = List;
    SourceTable = "Job Expense";

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
            }
        }
    }

    actions
    {
    }
}

