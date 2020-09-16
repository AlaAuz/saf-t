page 50007 "Invoicing Periods"
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
                }
                field(Description; Description)
                {
                }
            }
        }
    }
}