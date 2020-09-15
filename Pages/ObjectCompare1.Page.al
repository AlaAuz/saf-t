//page 70001 "Object Compare 1"
page 50015 "Object Compare 1"
{
    AutoSplitKey = true;
    LinksAllowed = false;
    PageType = ListPart;
    ShowFilter = true;
    SourceTable = "Object Compare";
    SourceTableView = SORTING (Compare, Type, ID)
                      WHERE (Compare = CONST (Compare1));

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
                field(Status; Status)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Object Import")
            {
                Caption = 'Object Import...';

                trigger OnAction()
                begin
                    ObjectImport(0);
                    CurrPage.Update(true);
                end;
            }
        }
    }
}

