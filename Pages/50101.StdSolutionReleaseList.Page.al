page 50101 "AUZ Std. Solution Release List"
{
    Caption = 'Standard Solution Releases';
    CardPageID = "AUZ Std. Solution Release Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "AUZ Standard Solution Release";
    SourceTableView = SORTING("Date Created")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Standard Solution No."; "Standard Solution No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Version Code"; "Version Code")
                {
                    ApplicationArea = All;
                }
                field("Previous Version Code"; "Previous Version Code")
                {
                    ApplicationArea = All;
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

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}