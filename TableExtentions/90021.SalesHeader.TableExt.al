tableextension 90021 "AUZ Sales Header" extends "Sales Header"
{
    // *** Auzilium AS ***
    fields
    {
        field(50000; "Invoicing Period Code"; Code[10])
        {
            CalcFormula = Lookup (Customer."Invoicing Period Code" WHERE ("No." = FIELD ("Bill-to Customer No.")));
            Caption = 'Invoicing Period Code';
            Description = 'AZ99999';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Invoicing Period";
        }
    }
    keys
    {

        //Unsupported feature: Property Insertion (Enabled) on ""No.","Document Type"(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Type","Sell-to Customer No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Type","Bill-to Customer No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Type","Combine Shipments","Bill-to Customer No.","Currency Code","EU 3-Party Trade","Dimension Set ID"(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Sell-to Customer No.","External Document No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Type","Sell-to Contact No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Bill-to Contact No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Incoming Document Entry No."(Key)".


        //Unsupported feature: Property Insertion (Enabled) on ""Document Date"(Key)".

    }
}

