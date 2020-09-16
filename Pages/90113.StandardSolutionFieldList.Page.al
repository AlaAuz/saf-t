page 90113 "Standard Solution Field List"
{
    AutoSplitKey = true;
    Caption = 'Standard Solution Fields';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "AUZ Standard Solution Field";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Table No."; "Table No.")
                {
                }
                field("Table Name"; "Table Name")
                {
                }
                field("Field No."; "Field No.")
                {
                }
                field("Field Name"; "Field Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

