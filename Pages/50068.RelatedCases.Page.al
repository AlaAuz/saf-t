page 50068 "AUZ Related Cases"
{
    Caption = 'Related Cases';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "AUZ Related Case";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Related Case No."; "Related Case No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalcFields("Related Case Description");
                    end;
                }
                field("Related Case Description"; "Related Case Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
        area(navigation)
        {
            action(ShowCase)
            {
                Caption = 'Case';
                Image = Timesheet;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case Card";
                RunPageLink = "No." = FIELD("Related Case No.");
            }
        }
    }
}