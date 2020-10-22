page 50064 "AUZ Case Line Descriptions"
{
    AutoSplitKey = true;
    Caption = 'Case Line Descriptions';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "AUZ Case Line Description";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}