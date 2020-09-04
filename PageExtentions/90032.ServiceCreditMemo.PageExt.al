pageextension 90032 pageextension90032 extends "Service Credit Memo"
{
    // *** Auzilium AS ***
    // 
    // 
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Added field "Distribution Type".
    // </DD>
    actions
    {
        addafter("H&ent forh.bet. kontraktposter")
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

