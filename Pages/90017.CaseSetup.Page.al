page 90017 "Case Setup"
{
    Caption = 'Case Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "AUZ Case Setup";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Default Work Type"; "Default Work Type")
                {
                }
                field("Default E-Mail"; "Default E-Mail")
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

