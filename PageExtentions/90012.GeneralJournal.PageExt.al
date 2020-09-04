pageextension 90012 pageextension90012 extends "General Journal"
{
    actions
    {
        //Unsupported feature: Property Deletion (Visible) on "ImportPayrollFile(Action 29)".

        addfirst("F&unksjoner")
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
