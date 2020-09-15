page 50009 "Accounting Setup"
{
    Caption = 'Accounting Setup';
    PageType = Card;
    SourceTable = "Accounting Setup";

    layout
    {
        area(content)
        {
            group(Periodisering)
            {
                Caption = 'Accrual';
                field("Sales Accrual Enabled"; "Sales Accrual Enabled")
                {
                }
                field("Purchase Accrual Enabled"; "Purchase Accrual Enabled")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

