page 90008 "Case Object List"
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
                }
                field("Line No."; "Line No.")
                {
                }
                field(Type; Type)
                {
                }
                field(ID; ID)
                {
                }
                field(Name; Name)
                {
                }
                field(Modified; Modified)
                {
                }
                field(Compiled; Compiled)
                {
                }
                field(Date; Date)
                {
                }
                field(Time; Time)
                {
                }
                field("Version List"; "Version List")
                {
                }
                field(Caption; Caption)
                {
                }
                field(Comment; Comment)
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
                RunPageLink = "No." = FIELD ("Case No.");
            }
        }
        area(processing)
        {
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;

                trigger OnAction()
                begin
                    ObjectImport;
                    CurrPage.Update(true);
                end;
            }
        }
    }
}

