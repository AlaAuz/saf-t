page 90021 "Case Journal Descriptions"
{
    AutoSplitKey = true;
    Caption = 'Case Journal Descriptions';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Case Journal Line Description";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RestoreDescriptions)
            {
                Caption = 'Restore Descriptions';
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RestoreDescriptions;
                end;
            }
        }
    }
}

