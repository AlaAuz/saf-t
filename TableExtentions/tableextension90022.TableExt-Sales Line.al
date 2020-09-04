tableextension 90022 tableextension90022 extends "Sales Line"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 29.12.2015 HHV Added fields and code for accrual. (AC1.0)
    fields
    {


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
        field(50001; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            Description = 'AZ10001';
            TableRelation = "Case Header";
        }
        field(50002; "Case Hour Line No."; Integer)
        {
            Caption = 'Case Line No.';
            Description = 'AZ10001';
            TableRelation = "Case Line"."Line No." WHERE ("Case No." = FIELD ("Case No."));
        }
        field(50003; "Expense Line No."; Integer)
        {
            Caption = 'Expense Line No.';
            Description = 'AZ10001';
        }
        field(50004; "Case Description"; Text[50])
        {
            Caption = 'Case Description';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
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

