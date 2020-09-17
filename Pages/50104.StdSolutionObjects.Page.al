page 50104 "AUZ Std. Solution Objects"
{
    AutoSplitKey = true;
    Caption = 'Objects';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "AUZ Standard Solution Object";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Import Datetime"; "Import Datetime")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
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
            action("Importer objekter")
            {
                Caption = 'Import Objects';
                ApplicationArea = All;
                Ellipsis = true;

                trigger OnAction()
                begin
                    ImportObjects;
                    CurrPage.Update(true);
                end;
            }
        }
    }
}