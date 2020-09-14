page 90014 "Case Line Descriptions"
{
    AutoSplitKey = true;
    Caption = 'Case Line Descriptions';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Case Hour Description";

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

