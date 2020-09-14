pageextension 90003 "AUZ VAT Codes" extends "VAT Codes"
{
    // *** Auzilium AS ***
    // AZ11649 16.12.2016 ERI Added field Description 2.
    layout
    {
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
            }
        }
    }
}

