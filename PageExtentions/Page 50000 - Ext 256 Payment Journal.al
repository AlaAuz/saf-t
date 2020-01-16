pageextension 50000 "Payment Journal" extends "Payment Journal"
{
    actions
    {
        addlast(processing)
        {
            action(ImportCamt054)
            {
                Caption = 'Import Camt.054';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Camt054: Codeunit "Camt.054";
                begin
                    Camt054.Import(Rec)
                end;
                //test
            }
        }
    }
}