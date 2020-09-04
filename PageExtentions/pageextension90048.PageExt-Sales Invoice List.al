pageextension 90048 pageextension90048 extends "Sales Invoice List"
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
        addafter("Sell-to Customer Name")
        {
            field("Invoicing Period Code"; "Invoicing Period Code")
            {
            }
        }
    }
}

