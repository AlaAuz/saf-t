pageextension 90012 "AUZ General Journal" extends "General Journal"
{
    actions
    {
        addfirst("F&unctions")
        {
            action(ImportPayroll)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import &Payroll';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Import payroll transactions from one of two external payroll solutions: Huldt & Lillevik or Hogia. You can then post the imported payroll transactions to general ledger accounts or bank accounts. To import payroll transactions, you must first set up payroll integration.';

                trigger OnAction()
                var
                    PaymentSetup: Record "Payroll Integration Setup";
                    ImportHLRep: Report "Import Huldt & Lillevik Std";
                begin
                    PaymentSetup.Get;
                    ImportHLRep.Initialize(Rec);
                    ImportHLRep.RunModal;
                    CurrPage.Update;
                end;
            }
        }
    }
}

