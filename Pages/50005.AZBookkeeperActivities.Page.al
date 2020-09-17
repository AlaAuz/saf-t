page 50005 "AUZ Bookkeeper Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup("Leverandørkonto")
            {
                Caption = 'Payables';
                field("Purchase Documents Due Today"; "Purchase Documents Due Today")
                {
                    DrillDownPageID = "Vendor Ledger Entries";
                    ApplicationArea = All;
                }

                actions
                {
                    action("Rediger utbetalingskladd")
                    {
                        Caption = 'Edit Payment Journal';
                        RunObject = Page "Payment Journal";
                        ApplicationArea = All;
                    }
                }
            }
            cuegroup(Kundekonto)
            {
                Caption = 'Receivables';
                field("Overdue Sales Documents"; "Overdue Sales Documents")
                {
                    DrillDownPageID = "Customer Ledger Entries";
                    ApplicationArea = All;
                }

                actions
                {
                    action("Rediger innbetalingskladd")
                    {
                        Caption = 'Edit Cash Receipt Journal';
                        RunObject = Page "Cash Receipt Journal";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

        SetFilter("Due Date Filter", '<=%1', WorkDate);
        SetFilter("Overdue Date Filter", '<%1', WorkDate);
    end;
}