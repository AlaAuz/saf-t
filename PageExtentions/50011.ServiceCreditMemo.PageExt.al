pageextension 50011 "AUZ Service Credit Memo" extends "Service Credit Memo"
{
    actions
    {
        addafter("Get Prepaid Contract E&ntries")
        {
            action(AUZCopyDocument)
            {
                Caption = 'Copy Document';
                Ellipsis = true;
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
        }
    }
}

