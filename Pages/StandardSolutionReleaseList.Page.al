page 90101 "Standard Solution Release List"
{
    Caption = 'Standard Solution Releases';
    CardPageID = "Standard Solution Release Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Standard Solution Release";
    SourceTableView = SORTING ("Date Created")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Standard Solution No."; "Standard Solution No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Version Code"; "Version Code")
                {
                }
                field("Previous Version Code"; "Previous Version Code")
                {
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
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}

