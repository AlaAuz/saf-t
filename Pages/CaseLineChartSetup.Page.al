page 90016 "Case Line Chart Setup"
{
    Caption = 'Case Hour Chart Setup';
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Case Hour Chart Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                }
                field(Type; Type)
                {
                }
                field(Chargeable; Chargeable)
                {
                }
                field(Day; Day)
                {
                }
                field(Week; Week)
                {
                }
                field(Month; Month)
                {
                }
                field(Quarter; Quarter)
                {
                }
                field(Year; Year)
                {
                }
                field(Total; Total)
                {
                }
                field("Last Months Winner"; "Last Months Winner")
                {
                }
                field("Last Date Won"; "Last Date Won")
                {
                }
                field("Last Quantity Won"; "Last Quantity Won")
                {
                }
                field("Show in Chart"; "Show in Chart")
                {
                }
            }
        }
    }

    actions
    {
    }
}

