page 50106 "AUZ Std. Solution Changes"
{
    AutoSplitKey = true;
    Caption = 'Changes';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "AUZ Standard Solution Change";

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