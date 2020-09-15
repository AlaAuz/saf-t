tableextension 90030 "AUZ Service Shipment Header" extends "Service Shipment Header"
{
    fields
    {
        field(50000; "Serv. Contr. Next Inv. Date"; Date)
        {
            Caption = 'Service Contract Next Invoice Date';
            Editable = false;
        }
        field(50001; "Serv. Contr. Last Inv. Date"; Date)
        {
            Caption = 'Service Contract Last Invoice Date';
            Editable = false;
        }
        field(50002; "SC Next Inv. Period Start"; Date)
        {
            Caption = 'Service Contract Next Invoice Period Start';
        }
        field(50003; "SC Next Inv. Period End"; Date)
        {
            Caption = 'Service Contract Next Invoice Period End';
        }
        field(50004; "SC Last Inv. Period End"; Date)
        {
            Caption = 'Service Contract Last Invoice Period End';
        }
    }
}

