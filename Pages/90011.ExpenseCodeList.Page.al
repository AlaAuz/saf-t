page 90011 "Expense Code List"
{
    Caption = 'Expense Code List';
    PageType = List;
    SourceTable = "AUZ Expense Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("G/L Account No."; "G/L Account No.")
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
