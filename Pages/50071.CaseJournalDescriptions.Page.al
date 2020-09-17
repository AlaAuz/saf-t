page 50071 "AUZ Case Journal Descriptions"
{
    AutoSplitKey = true;
    Caption = 'Case Journal Descriptions';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "AUZ Case Journal Line Desc.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
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

