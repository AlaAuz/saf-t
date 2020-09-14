page 90206 "Remote Computer Logins"
{
    AutoSplitKey = true;
    Caption = 'Computer Logins';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Remote Login";
    SourceTableView = WHERE (Type = CONST (Computer));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Comuter Type"; "Comuter Type")
                {
                }
                field(Domain; Domain)
                {
                }
                field(Name; Name)
                {
                }
                field("Login Type"; "Login Type")
                {
                }
                field("Login ID"; "Login ID")
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
            action(Connect)
            {
                Caption = 'Connect';
                Image = Start;

                trigger OnAction()
                begin
                    ConnectToComputer;
                end;
            }
        }
    }
}

