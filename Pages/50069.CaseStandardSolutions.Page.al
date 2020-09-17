page 50069 "AUZ Case Standard Solutions"
{
    Caption = 'Case Standard Solultions';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "AUZ Case Standard Solultion";

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
                field("Standard Solution No."; "Standard Solution No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        ShowStandardSolutionLastRelease;
                    end;

                    trigger OnValidate()
                    begin
                        CalcFields("Standard Solution Description");
                    end;
                }
                field("Standard Solution Description"; "Standard Solution Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}