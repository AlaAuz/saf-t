tableextension 50013 "AUZ Service Header" extends "Service Header"
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

    //FIX
    //Sjekk gammel STD kode for SetDefaultSalesPerson
    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ServSetup.Get ;
    if "No." = '' then begin
      TestNoSeries;
    #4..14
    Clear(ServLogMgt);
    ServLogMgt.ServHeaderCreate(Rec);

    if "Salesperson Code" = '' then
      SetDefaultSalesperson;

    if GetFilter("Customer No.") <> '' then begin
      Clear(xRec."Ship-to Code");
    #23..26
    if GetFilter("Contact No.") <> '' then
      if GetRangeMin("Contact No.") = GetRangeMax("Contact No.") then
        Validate("Contact No.",GetRangeMin("Contact No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    //IF "Salesperson Code" = '' THEN //AZ99999 Fix, not valid
      //SetDefaultSalesperson;
    #20..29
    */
    //end;
}