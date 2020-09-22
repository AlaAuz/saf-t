page 60009 "AUZ Std. Solution Setup"
{
    Caption = 'Standard Solution Setup';
    SourceTable = "AUZ Standard Solution Setup";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Standard Solution Nos."; "Standard Solution Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
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

