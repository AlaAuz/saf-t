page 70900 "Distribution Setup"
{
    Caption = 'Distribution Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Distribution Setup";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Job Queue E-Mail"; "Job Queue E-Mail")
                {
                }
                field("BCC E-Mail"; "BCC E-Mail")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Initialiser distribusjonsoppsett")
            {
                Caption = 'Initialize Distribution Setup';
                Image = Setup;
                RunObject = Report "Initialize Distribution Setup";
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

