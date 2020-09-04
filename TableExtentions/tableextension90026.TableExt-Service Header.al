tableextension 90026 tableextension90026 extends "Service Header"
{
    // *** Auzilium AS ***
    // 
    // *** Auzilium AS Service Copy ***
    // AZ12858 19.12.2017 DHG Changed CreateDim local property to No.
    // 
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Added fields "Distribution Type", "Distribution Date" and "Distribution Error".
    // </DD>
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

