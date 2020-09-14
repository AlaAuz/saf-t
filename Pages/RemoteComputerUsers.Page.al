page 90204 "Remote Computer Users"
{
    AutoSplitKey = true;
    Caption = 'Computer Users';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Remote User";
    SourceTableView = WHERE (Type = CONST (Computer));

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

