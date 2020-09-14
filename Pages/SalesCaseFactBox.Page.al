page 90026 "Sales Case FactBox"
{
    Caption = 'Case Details';
    PageType = CardPart;
    SourceTable = "Case Header";

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {

                trigger OnDrillDown()
                var
                    CaseHeader: Record "Case Header";
                begin
                    CaseHeader.Get("No.");
                    PAGE.Run(PAGE::"Case Card", CaseHeader);
                end;
            }
            field(Description; Description)
            {
            }
            field("Registered Date"; "Registered Date")
            {
            }
            field("Contact Name"; "Contact Name")
            {
            }
            field("Contact Company Name"; "Contact Company Name")
            {
            }
            field("Resource Name"; "Resource Name")
            {
            }
            field("Consultant ID"; "Consultant ID")
            {
            }
            field("Developer ID"; "Developer ID")
            {
            }
            field("Job No."; "Job No.")
            {
            }
            field("Job Task No."; "Job Task No.")
            {
            }
        }
    }

    actions
    {
    }
}

