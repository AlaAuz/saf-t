pageextension 90026 pageextension90026 extends "Contact Card"
{
    layout
    {
        addafter("Next Task Date")
        {
            field("Default Job No."; "Default Job No.")
            {
            }
            field("Default Job Task No."; "Default Job Task No.")
            {
            }
        }
        addafter("Exclude from Segment")
        {
            field("Login Company No."; "Login Company No.")
            {
            }
        }
    }
    actions
    {
        addafter(Webkilder)
        {
            action("Påloggingsinfo.")
            {
                Caption = 'Login Information';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ShowLoginInformation;
                end;
            }
        }
    }
}

