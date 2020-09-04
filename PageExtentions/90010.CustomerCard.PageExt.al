pageextension 90010 pageextension90010 extends "Customer Card"
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
        addafter("Invoice Copies")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
    }
}

