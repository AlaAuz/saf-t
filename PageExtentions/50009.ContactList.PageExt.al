pageextension 50009 "AUZ Contact List" extends "Contact List"
{
    layout
    {
        modify("Company Name")
        {
            Visible = true;
            ApplicationArea = All;
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

