page 90202 "Remote Access Card"
{
    Caption = 'Remote Access Card';
    PageType = Card;
    SourceTable = "Remote Access";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                field("No."; "No.")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Description; Description)
                {
                }
            }
            part(Control1000000010; "Remote VPN Logins")
            {
                SubPageLink = "Remote Access No." = FIELD ("No.");
                SubPageView = WHERE (Type = CONST (VPN));
            }
            part(Control1000000011; "Remote Computer Logins")
            {
                SubPageLink = "Remote Access No." = FIELD ("No.");
                SubPageView = WHERE (Type = CONST (Computer));
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("VPN-brukere")
            {
                Caption = 'VPN Users';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Remote VPN Users";
                RunPageLink = "Remote Access No." = FIELD ("No.");
            }
            action("Datamaskin-brukere")
            {
                Caption = 'Computer Users';
                Image = Server;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Remote Computer Users";
                RunPageLink = "Remote Access No." = FIELD ("No.");
            }
        }
    }
}

