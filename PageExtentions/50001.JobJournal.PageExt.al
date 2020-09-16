pageextension 50001 "AUZ Job Journal" extends "Job Journal"
{
    actions
    {
        addafter(SuggestLinesFromTimeSheets)
        {
            action(AUZSuggestLinesFromCaseLines)
            {
                Caption = 'Suggest Lines from Case Lines';
                Ellipsis = true;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SuggestCaseJobJnlLines: Report "Suggest Case Job Jnl. Lines";
                begin
                    SuggestCaseJobJnlLines.SetJobJnlLine(Rec);
                    SuggestCaseJobJnlLines.RunModal;
                end;
            }
        }
    }
}

