pageextension 90025 pageextension90025 extends "Sales Invoice Subform"
{
    // *** Auzilium AS ***
    // AZ99999 02.10.2015 HHV Added field "Case No.".
    // 
    // *** Auzilium AS Accounting ***
    // AZ10189 26.08.2015 HHV Added fields for accrual. (AC1.0)
    layout
    {
        addafter("No.")
        {
            field("Shipment Date"; "Shipment Date")
            {
            }
        }
        addafter("Account Code")
        {
            field("Case No."; "Case No.")
            {
            }
            field("Case Description"; "Case Description")
            {
            }
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

