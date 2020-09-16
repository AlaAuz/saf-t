tableextension 50010 "AUZ Sales Line" extends "Sales Line"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 29.12.2015 HHV Added fields and code for accrual. (AC1.0)
    fields
    {

        //FIX
        //Unsupported feature: Code Modification on ""Shipment Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        if CurrFieldNo <> 0 then
        #4..13
          then
            CheckItemAvailable(FieldNo("Shipment Date"));

          if ("Shipment Date" < WorkDate) and HasTypeToFillMandatoryFields then
            if not (GetHideValidationDialog or HasBeenShown) and GuiAllowed then begin
              Message(
                Text014,
                FieldCaption("Shipment Date"),"Shipment Date",WorkDate);
              HasBeenShown := true;
            end;
        end;

        AutoAsmToOrder;
        #27..33
          "Planned Shipment Date" := CalcPlannedShptDate(FieldNo("Shipment Date"));
        if not PlannedDeliveryDateCalculated then
          "Planned Delivery Date" := CalcPlannedDeliveryDate(FieldNo("Shipment Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..16
          {
          IF ("Shipment Date" < WORKDATE) AND HasTypeToFillMandatoryFields THEN
            IF NOT (GetHideValidationDialog OR HasBeenShown) AND GUIALLOWED THEN BEGIN
              MESSAGE(
                Text014,
                FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);
              HasBeenShown := TRUE;
            END;
          }
        #24..36
        */
        //end;
        field(50000; "AUZ Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(50001; "AUZ Case Line No."; Integer)
        {
            Caption = 'Case Line No.';
            TableRelation = "AUZ Case Line"."Line No." WHERE("Case No." = FIELD("AUZ Case No."));
            DataClassification = CustomerContent;
        }
        field(50002; "AUZ Expense Line No."; Integer)
        {
            Caption = 'Expense Line No.';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Case Description"; Text[100])
        {
            Caption = 'Case Description';
            DataClassification = CustomerContent;
        }
    }


    //Unsupported feature: Code Modification on "TestJobPlanningLine(PROCEDURE 60)".

    //procedure TestJobPlanningLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := false;
    OnBeforeTestJobPlanningLine(Rec,IsHandled);
    if IsHandled then
    #4..6
      exit;

    JobPostLine.TestSalesLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //AZ99999+
    exit;
    //AZ99999-

    #1..9
    */
    //end;
}

