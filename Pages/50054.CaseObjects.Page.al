page 50054 "AUZ Case Objects"
{
    AutoSplitKey = true;
    Caption = 'Case Objects';
    LinksAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "AUZ Case Object";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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