pageextension 90027 "AUZ Contact List" extends "Contact List"
{
    layout
    {
        modify("Company Name")
        {
            Visible = true;
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

