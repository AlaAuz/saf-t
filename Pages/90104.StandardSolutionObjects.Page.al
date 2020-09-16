page 90104 "Standard Solution Objects"
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
                    Visible = false;
                }
                field("Import Datetime"; "Import Datetime")
                {
                    Visible = false;
                }
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
            action("Importer objekter")
            {
                Caption = 'Import Objects';
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

