pageextension 50007 "AUZ Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("AUZ Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Account Code")
        {
            field("AUZ Case No."; "AUZ Case No.")
            {
                ApplicationArea = All;
            }
            field("AUZ Case Description"; "AUZ Case Description")
            {
                ApplicationArea = All;
            }
        }
    }
}

