page 90109 "Standard Solution Releases"
{
    Caption = 'Releases';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "AUZ Standard Solution Release";
    SourceTableView = SORTING ("Date Created")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Version Code"; "Version Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Previous Version Code"; "Previous Version Code")
                {
                    Visible = false;
                }
                field("Date Created"; "Date Created")
                {
                }
                field("Date Modified"; "Date Modified")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Kort)
            {
                Caption = 'Card';
                Image = Document;
                RunObject = Page "Standard Solution Release Card";
                RunPageLink = "Standard Solution No." = FIELD ("Standard Solution No."),
                              "Version Code" = FIELD ("Version Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}

