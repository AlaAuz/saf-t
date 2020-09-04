tableextension 90024 tableextension90024 extends "Purchase Line"
{
    // *** Auzilium AS Accounting ***
    // AZ10189 29.12.2015 HHV Added fields and code for accrual. (AC1.0)
    fields
    {


        //Unsupported feature: Code Modification on "Type(Field 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetPurchHeader;
        TestStatusOpen;

        #4..61
          "Allow Item Charge Assignment" := true
        else
          "Allow Item Charge Assignment" := false;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..64

        //AZ10189+
        if Type <> Type::"G/L Account" then
          ClearAccrualValues();
        //AZ10189-
        */
        //end;
    }

    local procedure ClearAccrualValues()
    begin
        //AZ10189+
        "Accrual Starting Date" := 0D;
        "Accrual Bal. Account No." := '';
        "Accrual No. of Months" := 0;
        //AZ10189-
    end;
}

