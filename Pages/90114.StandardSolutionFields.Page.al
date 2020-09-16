page 90114 "Standard Solution Fields"
{
    AutoSplitKey = true;
    Caption = 'Fields';
    DelayedInsert = true;
    PageType = ListPart;
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

