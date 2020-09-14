page 90004 "Case Objects"
{
    AutoSplitKey = true;
    Caption = 'Case Objects';
    LinksAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Case Object";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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

