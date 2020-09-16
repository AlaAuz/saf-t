page 90106 "Standard Solution Changes"
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
                }
            }
        }
    }

    actions
    {
    }
}

