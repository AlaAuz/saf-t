page 50109 "AUZ Std. Solution Releases"
{
    Caption = 'Releases';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "AUZ Standard Solution Release";
    SourceTableView = SORTING("Date Created")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Version Code"; "Version Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Previous Version Code"; "Previous Version Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                }
                field("Date Modified"; "Date Modified")
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
            action(Kort)
            {
                Caption = 'Card';
                Image = Document;
                ApplicationArea = All;
                RunObject = Page "AUZ Std. Solution Release Card";
                RunPageLink = "Standard Solution No." = FIELD("Standard Solution No."),
                              "Version Code" = FIELD("Version Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}

