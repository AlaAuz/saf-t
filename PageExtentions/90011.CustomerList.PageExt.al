pageextension 90011 "AUZ Customer List" extends "Customer List"
{
    // *** Auzilium AS ***
    // 
    // 
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Added fields "Distribution Type" and "Bill-to E-Mail".
    // </DD>
    layout
    {
        addafter("Salesperson Code")
        {
            field("Consultant ID"; "Consultant ID")
            {
            }
            field("Developer ID"; "Developer ID")
            {
            }
        }
        addafter("Sales (LCY)")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
    }
}

