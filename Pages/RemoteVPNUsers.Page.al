page 90203 "Remote VPN Users"
{
    AutoSplitKey = true;
    Caption = 'VPN Users';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Remote User";
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
                field(Username; Username)
                {
                }
                field(Password; Password)
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitRecord;
    end;
}

