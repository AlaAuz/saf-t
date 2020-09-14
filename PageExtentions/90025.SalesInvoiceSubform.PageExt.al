pageextension 90025 "AUZ Sales Invoice Subform" extends "Sales Invoice Subform"
{
    // *** Auzilium AS ***
    // AZ99999 02.10.2015 HHV Added field "Case No.".
    // 
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
        }
    }
}

