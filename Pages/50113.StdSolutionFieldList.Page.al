page 50113 "AUZ Std. Solution Field List"
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
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Table No."; "Table No.")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; "Table Name")
                {
                    ApplicationArea = All;
                }
                field("Field No."; "Field No.")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}