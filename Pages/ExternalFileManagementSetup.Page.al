page 70400 "External File Management Setup"
{
    // *** Auzilium AS File Management ***

    Caption = 'External File Management Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "External File Management Setup";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Save to Database"; "Save to Database")
                {
                }
                field("File Directory"; "File Directory")
                {
                }
                field("Run on Client"; "Run on Client")
                {
                }
            }
            group("Bokføring")
            {
                Caption = 'Posting';
                field("Copy Files to Posted Shpt."; "Copy Files to Posted Shpt.")
                {
                }
                field("Copy Files to Posted Inv."; "Copy Files to Posted Inv.")
                {
                }
                field("Copy Files to Posted Cr. Memo"; "Copy Files to Posted Cr. Memo")
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
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

