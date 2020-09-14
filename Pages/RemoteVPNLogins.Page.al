page 90205 "Remote VPN Logins"
{
    AutoSplitKey = true;
    Caption = 'VPN Logins';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Remote Login";
    SourceTableView = WHERE (Type = CONST (VPN));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
    }
}

