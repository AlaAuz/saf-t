tableextension 50002 "AUZ VAT Code" extends "VAT Code"
{
    fields
    {
        field(50000; "AUZ Description 2"; Text[250])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
    }
}

