tableextension 50009 "AUZ Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "AUZ Invoicing Period Code"; Code[10])
        {
            CalcFormula = Lookup (Customer."AUZ Invoicing Period Code" WHERE ("No." = FIELD ("Bill-to Customer No.")));
            Caption = 'Invoicing Period Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "AUZ Invoicing Period";
        }
    }
}

