pageextension 90026 "AUZ Contact Card" extends "Contact Card"
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
        addafter("Web Sources")
        {
            action(LoginInfo)
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

