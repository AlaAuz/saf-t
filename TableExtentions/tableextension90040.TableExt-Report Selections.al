tableextension 90040 tableextension90040 extends "Report Selections"
{
    // *** Auzilium AS ***
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Changed code to check email.
    //   Added code to initialize codeunit.
    // </DD>


    //Unsupported feature: Code Modification on "SendEmailToCust(PROCEDURE 9)".

    //procedure SendEmailToCust();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeSendEmailToCust(ReportUsage,RecordVariant,DocNo,DocName,ShowDialog,CustNo,Handled);
    if Handled then
      exit;
    #4..15
      exit;
    end;

    if ShowDialog or
       (not SMTPMail.IsEnabled) or
       (GetEmailAddressIgnoringLayout(ReportUsage,RecordVariant,CustNo) = '') or
       OfficeMgt.IsAvailable
    then begin
      SendEmailToCustDirectly(ReportUsage,RecordVariant,DocNo,DocName,true,CustNo);
      exit;
    end;

    RecRef.GetTable(RecordVariant);
    if RecordsCanBeSent(RecRef) then
      EnqueueMailingJob(RecRef.RecordId,StrSubstNo('%1|%2|%3|%4|',ReportUsage,DocNo,DocName,CustNo),DocName);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..18
    // <DD>
    {
    IF ShowDialog OR
       (NOT SMTPMail.IsEnabled) OR
       (GetEmailAddressIgnoringLayout(ReportUsage,RecordVariant,CustNo) = '') OR
       OfficeMgt.IsAvailable
    THEN BEGIN
    }
    if ShowDialog or (not SMTPMail.IsEnabled) or (DistributionMgt.GetCustEmailAddress(RecordVariant,CustNo) = '') or OfficeMgt.IsAvailable then begin
    // </DD>
    #24..30
    */
    //end;


    //Unsupported feature: Code Modification on "SendEmailDirectly(PROCEDURE 50)".

    //procedure SendEmailDirectly();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AllEmailsWereSuccessful := true;

    ShowNoBodyNoAttachmentError(ReportUsage,FoundBody,FoundAttachment);

    if FoundBody and not FoundAttachment then
      AllEmailsWereSuccessful :=
        DocumentMailing.EmailFile('','',ServerEmailBodyFilePath,DocNo,EmailAddress,DocName,not ShowDialog,ReportUsage);
    #8..38

    OnAfterSendEmailDirectly(ReportUsage,RecordVariant,AllEmailsWereSuccessful);
    exit(AllEmailsWereSuccessful);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <DD>
    DocumentMailing.Initialize(RecordVariant,CustomReportSelection);
    // </DD>
    #5..41
    */
    //end;

    var
        "<DD>": Boolean;
        DistributionMgt: Codeunit "Distribution Management";
        "</DD>": Boolean;
}

