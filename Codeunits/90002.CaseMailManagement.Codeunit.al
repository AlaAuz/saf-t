codeunit 90002 "Case Mail Management"
{

//ALA
/*
    trigger OnRun()
    begin
    end;

    var
        SubjectTxt: Label 'Support Case %1 with %2';
        ClickToOpenTxt: Label 'Click to open the case in %1, %2 or %3.';
        WindowsClientTxt: Label 'Windows client';
        CompanyInfo: Record "Company Information";
        CaseSetup: Record "Case Setup";
        UserSetup: Record "User Setup";
        PageMgt: Codeunit "Page Management";
        FileMgt: Codeunit "File Management";
        ToAddress: Text;
        ToDevelopmentAdmin: Boolean;
        BrowserTxt: Label 'browser';
        BusinessCentralAppTxt: Label 'Business Central App';
        OpenInOutlookQst: Label 'Do you want to open the email in Outlook?';
        EmailSentMsg: Label 'The email was sent to %1.';


    procedure SendEmail(CaseHeader: Record "Case Header")
    var
        CaseEmailTemplate: Record "Case E-Mail Template";
        CaseResource: Record "Case Resource";
        Contact: Record Contact;
        EmailItem: Record "Email Item";
        TempBlob: Record TempBlob;
        Mail: Codeunit Mail;
        SMTPMail: Codeunit "SMTP Mail";
        DescriptionSolution: Text;
        DescriptionChangeRequest: Text;
        CharValue: Char;
        MailLayout: Text;
        MailBody: Text;
        Subject: Text;
        TextChar: Text;
        FromAddress: Text[80];
        ServerEmailBodyFilePath: Text;
        String: DotNet String;
        RecRef: RecordRef;
    begin
        if not SelectTemplate(CaseEmailTemplate) then
            exit;

        CompanyInfo.Get;

        CaseEmailTemplate.GetMailLayout(MailLayout);

        CharValue := 13;

        CaseHeader.GetDescriptionChangeRequest(DescriptionChangeRequest);
        String := DescriptionChangeRequest;
        DescriptionChangeRequest := String.Replace(Format(CharValue), '<br>');

        CaseHeader.GetDescriptionSolution(DescriptionSolution);
        String := DescriptionSolution;
        DescriptionSolution := String.Replace(Format(CharValue), '<br>');

        CaseHeader.CalcFields("Resource Name", "Contact Company Name", "Contact Name");

        MailBody := StrSubstNo(
          MailLayout,
          CaseHeader."No.",
          CaseHeader.Description,
          CaseHeader."Resource Name",
          CaseHeader."Contact Company Name",
          CaseHeader."Contact Name",
          Format(CaseHeader."Registered Date"),
          Format(CaseHeader.Status),
          DescriptionChangeRequest,
          DescriptionSolution,
          CaseHeader."Development Status");

        Subject := StrSubstNo(SubjectTxt, CaseHeader."No.", CompanyInfo.Name);

        if CaseEmailTemplate.Subject <> '' then
            Subject += ' - ' + CaseEmailTemplate.Subject;

        if CaseEmailTemplate."Description in Subject" then
            Subject += ' - ' + CaseHeader.Description;

        if CaseEmailTemplate."Company Name in Subject" then
            Subject += ' - ' + CaseHeader."Contact Company Name";

        ToAddress := '';

        if CaseEmailTemplate.Internal then begin
            if ToDevelopmentAdmin or CaseEmailTemplate."To Development Admin." then begin
                UserSetup.Reset;
                UserSetup.SetRange("Development Administrator", true);
                FillEMailString;
            end;

            if CaseEmailTemplate."To Resources" then begin
                CaseResource.SetRange("Case No.", CaseHeader."No.");
                if CaseResource.FindSet then
                    repeat
                        UserSetup.Reset;
                        UserSetup.SetRange("Resource No.", CaseResource."Resource No.");
                        FillEMailString;
                    until CaseResource.Next = 0;
            end;

            if CaseEmailTemplate."To Consultant" then
                if CaseHeader."Consultant ID" <> '' then begin
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", CaseHeader."Consultant ID");
                    FillEMailString;
                end;

            if CaseEmailTemplate."To Developer" then
                if CaseHeader."Developer ID" <> '' then begin
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", CaseHeader."Developer ID");
                    FillEMailString;
                end;

            CaseHeader.SetRecFilter;
            RecRef.GetTable(CaseHeader);
            MailBody += '<br>' + '<br>';
            MailBody += StrSubstNo(
              ClickToOpenTxt,
              GetClientUrl(CLIENTTYPE::Windows, WindowsClientTxt, RecRef),
              GetClientUrl(CLIENTTYPE::Web, BrowserTxt, RecRef),
              GetClientUrl(CLIENTTYPE::Tablet, BusinessCentralAppTxt, RecRef));
        end else begin
            Contact.Get(CaseHeader."Contact No.");
            ToAddress := Contact."E-Mail";
        end;

        /*
        IF FileMgt.IsWindowsClient THEN
          IF CONFIRM(OpenInOutlookQst,TRUE) THEN BEGIN
            Mail.NewMessageAsync(ToAddress,'','',Subject,MailBody,'',TRUE);
            EXIT;
          END;
        
        IF CaseEmailTemplate."Use Default E-Mail" THEN BEGIN
          CaseSetup.GET;
          CaseSetup.TESTFIELD("Default E-Mail");
          FromAddress := CaseSetup."Default E-Mail";
        END ELSE BEGIN
          UserSetup.GET(USERID);
          UserSetup.TESTFIELD("E-Mail");
          FromAddress := UserSetup."E-Mail";
        END;
        
        SMTPMail.CreateMessage('',FromAddress,ToAddress,Subject,MailBody,TRUE);
        SMTPMail.Send;
        MESSAGE(EmailSentToMsg,ToAddress);
        */
        /*

        if MailBody <> '' then begin
            TempBlob.WriteAsText(MailBody, TEXTENCODING::UTF8);
            ServerEmailBodyFilePath := FileMgt.ServerTempFileName('html');
            FileMgt.BLOBExportToServerFile(TempBlob, ServerEmailBodyFilePath);
        end;
        SendEmailInternal(ServerEmailBodyFilePath, Subject, ToAddress, CaseHeader."No.", false);
        FileMgt.DeleteServerFile(ServerEmailBodyFilePath);

    end;

    local procedure SendEmailInternal(HtmlBodyFilePath: Text[250]; EmailSubject: Text[250]; ToEmailAddress: Text[250]; PostedDocNo: Code[20]; HideDialog: Boolean): Boolean
    var
        TempEmailItem: Record "Email Item" temporary;
        OfficeMgt: Codeunit "Office Management";
        EmailSentSuccesfully: Boolean;
    begin
        with TempEmailItem do begin
            "Send to" := ToEmailAddress;

            Subject := EmailSubject;

            if HtmlBodyFilePath <> '' then begin
                Validate("Plaintext Formatted", false);
                Validate("Body File Path", HtmlBodyFilePath);
            end;

            EmailSentSuccesfully := Send(HideDialog);
            exit(EmailSentSuccesfully);
        end;
    end;

    local procedure GetClientUrl(OpenClientType: ClientType; ClientTypeText: Text; RecRef: RecordRef): Text
    var
        Url: Text;
    begin
        Url := GetUrl(OpenClientType, CompanyName, OBJECTTYPE::Page, PageMgt.GetPageID(RecRef), RecRef, true);
        exit(StrSubstNo('<a href="%1">%2</a>', Url, ClientTypeText));
    end;

    local procedure FillEMailString()
    begin
        UserSetup.SetFilter("E-Mail", '<>%1', '');
        if UserSetup.FindSet then
            repeat
                if ToAddress <> '' then
                    ToAddress += ';';
                ToAddress += UserSetup."E-Mail";
            until UserSetup.Next = 0;
    end;


    procedure SelectTemplate(var CasesMailTemplate: Record "Case E-Mail Template"): Boolean
    var
        CaseMailLayoutList: Page "Case E-Mail Templates";
    begin
        if not ToDevelopmentAdmin then begin
            CaseMailLayoutList.LookupMode(true);
            if CaseMailLayoutList.RunModal = ACTION::LookupOK then begin
                CaseMailLayoutList.GetRecord(CasesMailTemplate);
                exit(true);
            end;
        end else begin
            CasesMailTemplate.SetRange("To Development Admin.", true);
            CasesMailTemplate.FindFirst;
            exit(true);
        end;
    end;


    procedure SetToDevelopmentAdmin(Value: Boolean)
    begin
        ToDevelopmentAdmin := Value;
    end;
    */
}

