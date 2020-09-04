tableextension 90036 tableextension90036 extends "CDC Document"
{

    //Unsupported feature: Code Modification on "BuildTempLinesTable2(PROCEDURE 6085605)".

    //procedure BuildTempLinesTable2();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Template No." = '' then
      exit;

    #4..83
            end;
        end;

        if (DocumentLine."Translate to Type" = DocumentLine."Translate to Type"::" ") and
          (DocumentLine."Translate to No." = '')
        then
          DocumentLine.OK := false;

    #92..94
    end;

    if DocumentLine.FindFirst then;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..86
        if not PurchDocMgt.IsDocMatched(Rec) then //AZ99999 Temp Fix, Continia sak 50454
        if (DocumentLine."Translate to Type" = DocumentLine."Translate to Type"::" ") and
          //(DocumentLine."Translate to No." = '')
          (DocumentLine."Translate to No." = '') and (PurchDocMgt.GetLineAccountNo(Rec,i) <> '') //AZ99999 Temp Fix, Continia sak 50454
    #89..97
    */
    //end;
}

