//ALA
//tableextension 90037 "AUZ Temp. Document Line" extends "CDC Temp. Document Line"
//{

    //Unsupported feature: Code Modification on "UpdateTranslInfo(PROCEDURE 1160040001)".

    //procedure UpdateTranslInfo();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ("Document No." = '') or ("Template No." = '') then
      exit;

    #4..13
        end;
      DATABASE::Vendor:
        if not PurchDocMgt.GetLineTranslation2(Document,"Line No.",LineTransl) then begin
          OK := false;
          exit;
        end;
    #20..22

    "Translate to Type" := LineTransl."Translate to Type";
    "Translate to No." := LineTransl."Translate to No.";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
          if not PurchDocMgt.IsDocMatched(Document) then //AZ99999 Temp Fix, Continia sak 50454
    #17..25
    */
    //end;
//}

