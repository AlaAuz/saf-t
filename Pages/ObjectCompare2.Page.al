page 70002 "Object Compare 2"
{
    AutoSplitKey = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Object Compare";
    SourceTableView = SORTING (Compare, Type, ID)
                      WHERE (Compare = CONST (Compare2));

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
                    ObjectImport(1);
                    CurrPage.Update(true);
                end;
            }
        }
    }
}

