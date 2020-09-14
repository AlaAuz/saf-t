page 70000 "Object Compare"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Integer";
    SourceTableView = SORTING (Number)
                      WHERE (Number = CONST (1));

    layout
    {
        area(content)
        {
            group(Compare)
            {
                part(Control1000000002; "Object Compare 1")
                {
                }
                part(Control1000000003; "Object Compare 2")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RunCompare)
            {

                trigger OnAction()
                begin
                    HandleObjects.Compare(0, 1);
                    HandleObjects.Compare(1, 0);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        HandleObjects: Codeunit "Handle Objects";
}

