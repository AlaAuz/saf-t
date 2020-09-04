pageextension 90027 pageextension90027 extends "Contact List"
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

