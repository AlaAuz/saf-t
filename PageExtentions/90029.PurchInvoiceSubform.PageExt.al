pageextension 90029 pageextension90029 extends "Purch. Invoice Subform"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 26.08.2015 HHV Added fields for accrual. (AC1.0)
    layout
    {
        addafter(ShortcutDimCode8)
        {
            field("Accrual Starting Date"; "Accrual Starting Date")
            {
            }
            field("Accrual Bal. Account No."; "Accrual Bal. Account No.")
            {
            }
            field("Accrual No. of Months"; "Accrual No. of Months")
            {
            }
        }
    }
}

