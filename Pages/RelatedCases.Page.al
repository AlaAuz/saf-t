page 90018 "Related Cases"
{
    Caption = 'Related Cases';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Related Case";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Related Case No."; "Related Case No.")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalcFields("Related Case Description");
                    end;
                }
                field("Related Case Description"; "Related Case Description")
                {
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Case Card";
                RunPageLink = "No." = FIELD ("Related Case No.");
            }
        }
    }
}

