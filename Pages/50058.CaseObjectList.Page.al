page 50058 "AUZ Case Object List"
{
    Caption = 'Case Objects';
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "AUZ Case Object";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Modified; Modified)
                {
                    ApplicationArea = All;
                }
                field(Compiled; Compiled)
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Time)
                {
                    ApplicationArea = All;
                }
                field("Version List"; "Version List")
                {
                    ApplicationArea = All;
                }
                field(Caption; Caption)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
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
                RunPageLink = "No." = FIELD("Case No.");
            }
        }
        area(processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ObjectImport;
                    CurrPage.Update(true);
                end;
            }
        }
    }
}