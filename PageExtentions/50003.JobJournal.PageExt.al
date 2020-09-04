pageextension 90009 pageextension90009 extends "Job Journal"
{
    // *** Auzilium AS ***
    // AZ99999 17.04.2017 EVA New Action - SuggestLinesFromCaseHours
    actions
    {
        addafter(SuggestLinesFromTimeSheets)
        {
            action(SuggestLinesFromCaseHours)
            {
                Caption = 'Suggest Lines from Case Hours';
                Ellipsis = true;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;

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

