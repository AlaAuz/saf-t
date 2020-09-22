page 60008 "AUZ Invoicing Periods"
{
    Caption = 'Invoicing Periods';
    PageType = List;
    SourceTable = "AUZ Invoicing Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}