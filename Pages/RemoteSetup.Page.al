page 90200 "Remote Setup"
{
    Caption = 'Remote Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Remote Setup";

    layout
    {
        area(content)
        {
            group(Nummerering)
            {
                Caption = 'Numbering';
                field("Remote Login Nos."; "Remote Login Nos.")
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

