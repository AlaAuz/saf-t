pageextension 50002 "AUZ VAT Codes" extends "VAT Codes"
{
    // *** Auzilium AS ***
    // AZ11649 16.12.2016 ERI Added field Description 2.
    layout
    {
        addafter(Description)
        {
            field("AUZ Description 2"; "AUZ Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}