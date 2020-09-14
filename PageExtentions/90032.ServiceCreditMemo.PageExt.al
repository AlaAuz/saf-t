pageextension 90032 "AUZ Service Credit Memo" extends "Service Credit Memo"
{
    actions
    {
        addafter("Get Prepaid Contract E&ntries")
        {
            action(CopyDocument)
            {
                Caption = 'Copy Document';
                Ellipsis = true;
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}

