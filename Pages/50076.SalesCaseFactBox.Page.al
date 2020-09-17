page 50076 "AUZ Sales Case FactBox"
{
    Caption = 'Case Details';
    PageType = CardPart;
    SourceTable = "AUZ Case Header";

    layout
    {
        area(content)
        {
            field("No."; "No.")
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    CaseHeader: Record "AUZ Case Header";
                begin
                    CaseHeader.Get("No.");
                    PAGE.Run(PAGE::"AUZ Case Card", CaseHeader);
                end;
            }
            field(Description; Description)
            {
                ApplicationArea = All;
            }
            field("Registered Date"; "Registered Date")
            {
                ApplicationArea = All;
            }
            field("Contact Name"; "Contact Name")
            {
                ApplicationArea = All;
            }
            field("Contact Company Name"; "Contact Company Name")
            {
                ApplicationArea = All;
            }
            field("Resource Name"; "Resource Name")
            {
                ApplicationArea = All;
            }
            field("Consultant ID"; "Consultant ID")
            {
                ApplicationArea = All;
            }
            field("Developer ID"; "Developer ID")
            {
                ApplicationArea = All;
            }
            field("Job No."; "Job No.")
            {
                ApplicationArea = All;
            }
            field("Job Task No."; "Job Task No.")
            {
                ApplicationArea = All;
            }
        }
    }
}