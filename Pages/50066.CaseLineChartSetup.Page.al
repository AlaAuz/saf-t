page 50066 "AUZ Case Line Chart Setup"
{
    Caption = 'Case Line Chart Setup';
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "AUZ Case Line Chart Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                }
                field(Day; Day)
                {
                    ApplicationArea = All;
                }
                field(Week; Week)
                {
                    ApplicationArea = All;
                }
                field(Month; Month)
                {
                    ApplicationArea = All;
                }
                field(Quarter; Quarter)
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field(Total; Total)
                {
                    ApplicationArea = All;
                }
                field("Last Months Winner"; "Last Months Winner")
                {
                    ApplicationArea = All;
                }
                field("Last Date Won"; "Last Date Won")
                {
                    ApplicationArea = All;
                }
                field("Last Quantity Won"; "Last Quantity Won")
                {
                    ApplicationArea = All;
                }
                field("Show in Chart"; "Show in Chart")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}