tableextension 50017 "AUZ Service Shipment Header" extends "Service Shipment Header"
{
    fields
    {
        field(50000; "AUZ Serv. Contr. Next Inv. Date"; Date)
        {
            Caption = 'Service Contract Next Invoice Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "AUZ Serv. Contr. Last Inv. Date"; Date)
        {
            Caption = 'Service Contract Last Invoice Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "AUZ SC Next Inv. Period Start"; Date)
        {
            Caption = 'Service Contract Next Invoice Period Start';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ SC Next Inv. Period End"; Date)
        {
            Caption = 'Service Contract Next Invoice Period End';
            DataClassification = CustomerContent;
        }
        field(50004; "AUZ SC Last Inv. Period End"; Date)
        {
            Caption = 'Service Contract Last Invoice Period End';
            DataClassification = CustomerContent;
        }
    }
}