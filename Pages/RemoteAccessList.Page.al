page 90201 "Remote Access List"
{
    Caption = 'Remote Access List';
    CardPageID = "Remote Access Card";
    Editable = false;
    PageType = List;
    SourceTable = "Remote Access";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
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

