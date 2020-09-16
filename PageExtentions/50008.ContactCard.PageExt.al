pageextension 50008 "AUZ Contact Card" extends "Contact Card"
{
    layout
    {
        addafter("Next Task Date")
        {
            field("AUZ Default Job No."; "AUZ Default Job No.")
            {
                ApplicationArea = All;
            }
            field("AUZ Default Job Task No."; "AUZ Default Job Task No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Exclude from Segment")
        {
            field("AUZ Login Company No."; "AUZ Login Company No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Web Sources")
        {
            action(AUZLoginInfo)
            {
                Caption = 'Login Information';
                Image = Database;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ShowLoginInformation;
                end;
            }
        }
    }
}

