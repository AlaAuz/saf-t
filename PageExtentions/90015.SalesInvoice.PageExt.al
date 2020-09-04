pageextension 90015 pageextension90015 extends "Sales Invoice"
{
    // *** Auzilium AS ***
    // 
    // 
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Added field "Distribution Type".
    // </DD>
    layout
    {
        addafter("EU 3-Party Trade")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
        addafter(Control1900316107)
        {
            part(Control100000000; "Sales Case FactBox")
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD ("Case No.");
            }
        }
    }
}

