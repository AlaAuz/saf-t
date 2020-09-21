codeunit 50016 "AUZ CDC. Management"
{
  /*
    [EventSubscriber(ObjectType::Table, Database::"CDC Template Upg.", '', '', false, false)]
    local procedure MyProcedure()
    begin
    end;
 */
    //Unsupported feature: Code Modification on "RefreshUpgTables(PROCEDURE 1)".

    //procedure RefreshUpgTables();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CDCTemplate.SetRange("Prices Including VAT",true);
    if CDCTemplate.FindSet then
      repeat
        InsertUpdateTemplateHeader(CDCTemplate);
        InsertUpdateTemplateFields(CDCTemplate);
      until CDCTemplate.Next = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CDCTemplate.SetRange("Source Record Table ID",DATABASE::Vendor);
    CDCTemplate.SetRange("Prices Including VAT",true);

    if CDCTemplate.FindSet then
      repeat
        if InsertUpdateTemplateHeader(CDCTemplate) then
          InsertUpdateTemplateFields(CDCTemplate);
      until CDCTemplate.Next = 0;
    */
    //end;

    //Unsupported feature: ReturnValue Insertion (ReturnValue: TemplateInserted) (ReturnValueCollection) on "InsertUpdateTemplateHeader(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "InsertUpdateTemplateHeader(PROCEDURE 3)".

    //procedure InsertUpdateTemplateHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Init;
    "No." := TemplateRec."No.";
    "Source Record ID Tree ID" := TemplateRec."Source Record ID Tree ID";
    #4..10
    Type := TemplateRec.Type;

    //Only templates, not already in the upgrade table, are added.
    if Insert then;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    if Insert then
      exit(true)
    else
      exit(false);
    */
    //end;


    //Unsupported feature: Code Modification on "GetConfigurationType(PROCEDURE 5)".

    //procedure GetConfigurationType();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CDCTemplateFieldUpg.Count = 2 then begin
      //Ensure the amount field configuration is as expected - only AMOUNTEXCLVAT and AMOUNTINCLVAT are setup on the template
      CDCTemplateFieldUpg.SetFilter(Code,'<>%1&<>%2','AMOUNTEXCLVAT','AMOUNTINCLVAT');
    #4..6
      exit('EXVAT');
    end;
    if CDCTemplateFieldUpg.Count = 3 then begin
      //Ensure amount field configuration is as expected - only AMOUNTEXCLVAT, AMOUNTINCLVAT and FREIGHTAMOUNT are setup on the template
      CDCTemplateFieldUpg.SetFilter(Code,'<>%1&<>%2&<>%3','AMOUNTEXCLVAT','AMOUNTINCLVAT','FREIGHTAMOUNT');
      if CDCTemplateFieldUpg.Count <> 0 then
        exit('');
      CDCTemplateFieldUpg.SetRange(Code);
      exit('EXVATFREIGHT');
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    //Ensure amount field configuration is as expected - only AMOUNTEXCLVAT, AMOUNTINCLVAT and FREIGHTAMOUNT are setup on the template
    #11..16
    */
    //end;


    //Unsupported feature: Code Modification on "SetUpgradeStatus(PROCEDURE 11)".

    //procedure SetUpgradeStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CDCTemplateFieldUpg.FindFirst;
    case ConfigType of
      'EXVATFREIGHT':
        begin
          repeat
            if CDCTemplateFieldUpg.Code = 'AMOUNTINCLVAT' then
              DoModify := (CDCTemplateFieldUpg."New G/L Account Field Code" <> '') and
                (CDCTemplateFieldUpg."New Transfer Amt. to Document" = CDCTemplateFieldUpg."New Transfer Amt. to Document"::"If lines are not recognised");
            if CDCTemplateFieldUpg.Code = 'FREIGHTAMOUNT' then
              DoModify := DoModify and (CDCTemplateFieldUpg."New Subtract from Amount Field" <> '') and
                (CDCTemplateFieldUpg."New Transfer Amt. to Document" = CDCTemplateFieldUpg."New Transfer Amt. to Document"::Always);
    #12..15
          repeat
            if CDCTemplateFieldUpg.Code = 'AMOUNTINCLVAT' then
              DoModify := (CDCTemplateFieldUpg."New G/L Account Field Code" <> '') and
                (CDCTemplateFieldUpg."New Transfer Amt. to Document" = CDCTemplateFieldUpg."New Transfer Amt. to Document"::"If lines are not recognised");
          until CDCTemplateFieldUpg.Next = 0;
        end;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
                (CDCTemplateFieldUpg."New Transfer Amt. to Document" = CDCTemplateFieldUpg."New Transfer Amt. to Document"::
    "If lines are not recognised");
    #9..18
                (CDCTemplateFieldUpg."New Transfer Amt. to Document" = CDCTemplateFieldUpg."New Transfer Amt. to Document"::
    "If lines are not recognised");
    #20..22
    */
    //end;


    
  /*
    [EventSubscriber(ObjectType::Table, Database::"CDC Template Upg.", '', '', false, false)]
    local procedure MyProcedure()
    begin
    end;
 */

}
