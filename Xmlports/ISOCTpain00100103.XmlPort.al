xmlport 50000 "ISO CT pain.001.001.03"
{
    Caption = 'ISO CT pain.001.001.03';
    DefaultNamespace = 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03';
    Direction = Export;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    UseDefaultNamespace = true;

    schema
    {
        tableelement("Gen. Journal Line"; "Gen. Journal Line")
        {
            XmlName = 'Document';
            UseTemporary = true;
            tableelement(companyinformation; "Company Information")
            {
                XmlName = 'CstmrCdtTrfInitn';
                textelement(GrpHdr)
                {
                    textelement(messageid)
                    {
                        XmlName = 'MsgId';
                    }
                    textelement(createddatetime)
                    {
                        XmlName = 'CreDtTm';
                    }
                    textelement(nooftransfers)
                    {
                        XmlName = 'NbOfTxs';
                    }
                    textelement(controlsum)
                    {
                        XmlName = 'CtrlSum';
                    }
                    textelement(InitgPty)
                    {
                        fieldelement(Nm; CompanyInformation.Name)
                        {
                        }
                        textelement(initgptypstladr)
                        {
                            XmlName = 'PstlAdr';
                            fieldelement(StrtNm; CompanyInformation.Address)
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation.Address = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(PstCd; CompanyInformation."Post Code")
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation."Post Code" = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(TwnNm; CompanyInformation.City)
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation.City = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(Ctry; CompanyInformation."Country/Region Code")
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation."Country/Region Code" = '' then
                                        currXMLport.Skip;
                                end;
                            }
                        }
                        textelement(initgptyid)
                        {
                            XmlName = 'Id';
                            textelement(initgptyorgid)
                            {
                                XmlName = 'OrgId';
                                textelement(initgptyothrinitgpty)
                                {
                                    XmlName = 'Othr';
                                    fieldelement(Id; CompanyInformation."VAT Registration No.")
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
                tableelement(paymentexportdatagroup; "Payment Export Data")
                {
                    XmlName = 'PmtInf';
                    UseTemporary = true;
                    fieldelement(PmtInfId; PaymentExportDataGroup."Payment Information ID")
                    {
                    }
                    fieldelement(PmtMtd; PaymentExportDataGroup."SEPA Payment Method Text")
                    {
                    }
                    fieldelement(BtchBookg; PaymentExportDataGroup."SEPA Batch Booking")
                    {
                    }
                    fieldelement(NbOfTxs; PaymentExportDataGroup."Line No.")
                    {
                    }
                    fieldelement(CtrlSum; PaymentExportDataGroup.Amount)
                    {
                    }
                    textelement(PmtTpInf)
                    {
                        fieldelement(InstrPrty; PaymentExportDataGroup."SEPA Instruction Priority Text")
                        {
                        }
                    }
                    fieldelement(ReqdExctnDt; PaymentExportDataGroup."Transfer Date")
                    {
                    }
                    textelement(Dbtr)
                    {
                        fieldelement(Nm; CompanyInformation.Name)
                        {
                        }
                        textelement(dbtrpstladr)
                        {
                            XmlName = 'PstlAdr';
                            fieldelement(StrtNm; CompanyInformation.Address)
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation.Address = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(PstCd; CompanyInformation."Post Code")
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation."Post Code" = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(TwnNm; CompanyInformation.City)
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation.City = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            fieldelement(Ctry; CompanyInformation."Country/Region Code")
                            {

                                trigger OnBeforePassField()
                                begin
                                    if CompanyInformation."Country/Region Code" = '' then
                                        currXMLport.Skip;
                                end;
                            }
                        }
                        textelement(dbtrid)
                        {
                            XmlName = 'Id';
                            textelement(dbtrorgid)
                            {
                                XmlName = 'OrgId';
                                fieldelement(BICOrBEI; PaymentExportDataGroup."Sender Bank BIC")
                                {
                                }
                            }

                            trigger OnBeforePassVariable()
                            begin
                                if PaymentExportDataGroup."Sender Bank BIC" = '' then
                                    currXMLport.Skip;
                            end;
                        }
                    }
                    textelement(DbtrAcct)
                    {
                        textelement(dbtracctid)
                        {
                            XmlName = 'Id';
                            textelement(Othr)
                            {
                                fieldelement(Id; PaymentExportDataGroup."Sender Bank Account No.")
                                {
                                    MaxOccurs = Once;
                                    MinOccurs = Once;
                                }
                                textelement(SchmeNm)
                                {
                                    textelement(dbtracctbban)
                                    {
                                        XmlName = 'Cd';

                                        trigger OnBeforePassVariable()
                                        begin
                                            DbtrAcctBBAN := 'BBAN';
                                        end;
                                    }
                                }
                            }
                        }
                    }
                    textelement(DbtrAgt)
                    {
                        textelement(dbtragtfininstnid)
                        {
                            XmlName = 'FinInstnId';
                            fieldelement(BIC; PaymentExportDataGroup."Sender Bank BIC")
                            {
                                MaxOccurs = Once;
                                MinOccurs = Once;
                            }
                        }

                        trigger OnBeforePassVariable()
                        begin
                            if PaymentExportDataGroup."Sender Bank BIC" = '' then
                                currXMLport.Skip;
                        end;
                    }
                    fieldelement(ChrgBr; PaymentExportDataGroup."SEPA Charge Bearer Text")
                    {
                    }
                    tableelement(paymentexportdata; "Payment Export Data")
                    {
                        LinkFields = "Sender Bank BIC" = FIELD ("Sender Bank BIC"), Urgent = FIELD (Urgent), "Transfer Date" = FIELD ("Transfer Date"), "SEPA Batch Booking" = FIELD ("SEPA Batch Booking"), "SEPA Charge Bearer Text" = FIELD ("SEPA Charge Bearer Text");
                        LinkTable = PaymentExportDataGroup;
                        XmlName = 'CdtTrfTxInf';
                        UseTemporary = true;
                        textelement(PmtId)
                        {
                            fieldelement(InstrId; PaymentExportData."End-to-End ID")
                            {
                            }
                            fieldelement(EndToEndId; PaymentExportData."End-to-End ID")
                            {
                            }
                        }
                        textelement(Amt)
                        {
                            fieldelement(InstdAmt; PaymentExportData.Amount)
                            {
                                fieldattribute(Ccy; PaymentExportData."Currency Code")
                                {
                                }
                            }
                        }
                        textelement(CdtrAgt)
                        {
                            textelement(cdtragtfininstnid)
                            {
                                XmlName = 'FinInstnId';
                                fieldelement(BIC; PaymentExportData."Recipient Bank BIC")
                                {
                                    FieldValidate = yes;
                                }
                                textelement(PstlAdr)
                                {
                                    fieldelement(Ctry; PaymentExportData."Recipient Bank Country/Region")
                                    {
                                    }
                                }
                            }

                            trigger OnBeforePassVariable()
                            begin
                                if PaymentExportData."Recipient Bank BIC" = '' then
                                    currXMLport.Skip;
                            end;
                        }
                        textelement(Cdtr)
                        {
                            fieldelement(Nm; PaymentExportData."Recipient Name")
                            {
                            }
                            textelement(cdtrpstladr)
                            {
                                XmlName = 'PstlAdr';
                                fieldelement(StrtNm; PaymentExportData."Recipient Address")
                                {

                                    trigger OnBeforePassField()
                                    begin
                                        if PaymentExportData."Recipient Address" = '' then
                                            currXMLport.Skip;
                                    end;
                                }
                                fieldelement(PstCd; PaymentExportData."Recipient Post Code")
                                {

                                    trigger OnBeforePassField()
                                    begin
                                        if PaymentExportData."Recipient Post Code" = '' then
                                            currXMLport.Skip;
                                    end;
                                }
                                fieldelement(TwnNm; PaymentExportData."Recipient City")
                                {

                                    trigger OnBeforePassField()
                                    begin
                                        if PaymentExportData."Recipient City" = '' then
                                            currXMLport.Skip;
                                    end;
                                }
                                fieldelement(Ctry; PaymentExportData."Recipient Country/Region Code")
                                {

                                    trigger OnBeforePassField()
                                    begin
                                        if PaymentExportData."Recipient Country/Region Code" = '' then
                                            currXMLport.Skip;
                                    end;
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    if (PaymentExportData."Recipient Address" = '') and
                                       (PaymentExportData."Recipient Post Code" = '') and
                                       (PaymentExportData."Recipient City" = '') and
                                       (PaymentExportData."Recipient Country/Region Code" = '')
                                    then
                                        currXMLport.Skip;
                                end;
                            }
                        }
                        textelement(CdtrAcct)
                        {
                            textelement(cdtracctid)
                            {
                                XmlName = 'Id';
                                fieldelement(IBAN; PaymentExportData."Recipient Bank Acc. No.")
                                {
                                    FieldValidate = yes;
                                    MaxOccurs = Once;
                                    MinOccurs = Once;

                                    trigger OnBeforePassField()
                                    begin
                                        //AZ99999+
                                        if PaymentExportData."Recipient Bank Country/Region" <> CopyStr(PaymentExportData."Recipient Bank Acc. No.", 1, 2) then
                                            currXMLport.Skip;
                                        ///AZ99999-
                                    end;
                                }
                                textelement(cdtracctidothr)
                                {
                                    XmlName = 'Othr';
                                    fieldelement(Id; PaymentExportData."Recipient Bank Acc. No.")
                                    {
                                        FieldValidate = yes;
                                        MaxOccurs = Once;
                                        MinOccurs = Once;
                                    }
                                    textelement(cdtracctidothrschemenm)
                                    {
                                        XmlName = 'SchmeNm';
                                        textelement(cdtracctbban)
                                        {
                                            XmlName = 'Cd';

                                            trigger OnBeforePassVariable()
                                            begin
                                                CdtrAcctBBAN := 'BBAN';
                                            end;
                                        }
                                    }

                                    trigger OnBeforePassVariable()
                                    begin
                                        //AZ99999+
                                        if PaymentExportData."Recipient Bank Country/Region" = CopyStr(PaymentExportData."Recipient Bank Acc. No.", 1, 2) then
                                            currXMLport.Skip;
                                        ///AZ99999-
                                    end;
                                }
                            }
                        }
                        textelement(Purp)
                        {
                            fieldelement(Prtry; PaymentExportData."Document No.")
                            {
                            }

                            trigger OnBeforePassVariable()
                            begin
                                //AZ99999+
                                if CompanyInformation."Country/Region Code" <> 'GB' then
                                    currXMLport.Skip;
                                //AZ99999-
                            end;
                        }
                        tableelement(genjnllineregrepcode; "Gen. Jnl. Line Reg. Rep. Code")
                        {
                            LinkFields = "Journal Template Name" = FIELD ("General Journal Template"), "Journal Batch Name" = FIELD ("General Journal Batch Name"), "Line No." = FIELD ("General Journal Line No.");
                            LinkTable = PaymentExportData;
                            MinOccurs = Zero;
                            XmlName = 'RgltryRptg';
                            textelement(Dtls)
                            {
                                fieldelement(Cd; GenJnlLineRegRepCode."Reg. Code")
                                {
                                }
                                fieldelement(Inf; GenJnlLineRegRepCode."Reg. Code Description")
                                {
                                }
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if not (IsNorgeExport and PaymentExportData."Reg.Rep. Thresh.Amt Exceeded") then
                                    currXMLport.Skip;
                            end;
                        }
                        textelement(RmtInf)
                        {
                            textelement(remittancetext1)
                            {
                                MinOccurs = Zero;
                                XmlName = 'Ustrd';

                                trigger OnBeforePassVariable()
                                begin
                                    //AZ99999+
                                    if RemittanceText1 = '' then
                                        currXMLport.Skip;
                                    //AZ99999-
                                end;
                            }
                            textelement(remittancetext2)
                            {
                                MinOccurs = Zero;
                                XmlName = 'Ustrd';

                                trigger OnBeforePassVariable()
                                begin
                                    if RemittanceText2 = '' then
                                        currXMLport.Skip;
                                end;
                            }
                            textelement(Strd)
                            {
                                textelement(CdtrRefInf)
                                {
                                    textelement(Tp)
                                    {
                                        textelement(CdOrPrtry)
                                        {
                                            textelement(scor)
                                            {
                                                XmlName = 'Cd';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    SCOR := 'SCOR';
                                                end;
                                            }
                                        }
                                    }
                                    fieldelement(Ref; PaymentExportData.KID)
                                    {
                                    }
                                }

                                trigger OnBeforePassVariable()
                                begin
                                    //AZ99999+
                                    if (PaymentExportData.KID = '') then
                                        currXMLport.Skip;
                                    //AZ99999-
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                RemittanceText1 := '';
                                RemittanceText2 := '';
                                //AZ99999+

                                if (PaymentExportData.KID = '') then begin
                                    //AZ99999-
                                    TempPaymentExportRemittanceText.SetRange("Pmt. Export Data Entry No.", PaymentExportData."Entry No.");
                                    if not TempPaymentExportRemittanceText.FindSet then begin
                                        if PaymentExportData."Document No." <> '' then
                                            RemittanceText1 := StrSubstNo(PaymentInfo, PaymentExportData."Document No.")
                                        else
                                            currXMLport.Skip;
                                    end else
                                        RemittanceText1 := TempPaymentExportRemittanceText.Text;

                                    if TempPaymentExportRemittanceText.Next = 0 then
                                        exit;
                                    RemittanceText2 := TempPaymentExportRemittanceText.Text;
                                    //AZ99999+
                                end;
                                //AZ99999-
                            end;
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if not PaymentExportData.GetPreserveNonLatinCharacters then
                        PaymentExportData.CompanyInformationConvertToLatin(CompanyInformation);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        InitData;
    end;

    var
        TempPaymentExportRemittanceText: Record "Payment Export Remittance Text" temporary;
        NoDataToExportErr: Label 'There is no data to export.', Comment = '%1=Field;%2=Value;%3=Value';
        IsNorgeExport: Boolean;
        PaymentInfo: Label 'Pay Inv %1';

    local procedure InitData()
    var
        WaitingJournal: Record "Waiting Journal";
        GenJournalLine: Record "Gen. Journal Line";
        SEPACTFillExportBuffer: Codeunit "SEPA CT-Fill Export Buffer";
        DocumentTools: Codeunit DocumentTools;
        PaymentGroupNo: Integer;
    begin
        GenJournalLine.Copy("Gen. Journal Line");
        if GenJournalLine.FindFirst then
            IsNorgeExport := DocumentTools.IsNorgeSEPACT(GenJournalLine);
        SEPACTFillExportBuffer.FillExportBuffer("Gen. Journal Line", PaymentExportData);
        //AZ99999+
        MergeEqualPayments();
        //AZ99999-
        PaymentExportData.GetRemittanceTexts(TempPaymentExportRemittanceText);

        NoOfTransfers := Format(PaymentExportData.Count);
        MessageID := PaymentExportData."Message ID";
        CreatedDateTime := Format(CurrentDateTime, 19, 9);
        PaymentExportData.CalcSums(Amount);
        ControlSum := Format(PaymentExportData.Amount, 0, 9);

        PaymentExportData.SetCurrentKey(
          "Sender Bank BIC", "Transfer Date", "SEPA Batch Booking",
          "SEPA Charge Bearer Text", Urgent);

        if not PaymentExportData.FindSet then
            Error(NoDataToExportErr);

        InitPmtGroup;
        repeat
            if IsNewGroup then begin
                InsertPmtGroup(PaymentGroupNo);
                InitPmtGroup;
            end;

            WaitingJournal.Reset;
            WaitingJournal.SetFilter("SEPA Msg. ID", PaymentExportData."Message ID");
            WaitingJournal.SetFilter("SEPA Payment Inf ID", PaymentExportData."Payment Information ID");
            WaitingJournal.SetFilter("SEPA End To End ID", PaymentExportData."End-to-End ID");
            WaitingJournal.SetFilter("SEPA Instr. ID", PaymentExportData."Document No.");
            if WaitingJournal.FindFirst then
                WaitingJournal.ModifyAll("SEPA Payment Inf ID", PaymentExportDataGroup."Payment Information ID", true);

            PaymentExportDataGroup."Line No." += 1;
            PaymentExportDataGroup.Amount += PaymentExportData.Amount;
        until PaymentExportData.Next = 0;
        InsertPmtGroup(PaymentGroupNo);
    end;

    local procedure IsNewGroup(): Boolean
    begin
        exit(
          (PaymentExportData."Sender Bank BIC" <> PaymentExportDataGroup."Sender Bank BIC") or
          (PaymentExportData.Urgent <> PaymentExportDataGroup.Urgent) or
          (PaymentExportData."Transfer Date" <> PaymentExportDataGroup."Transfer Date") or
          (PaymentExportData."SEPA Batch Booking" <> PaymentExportDataGroup."SEPA Batch Booking") or
          (PaymentExportData."SEPA Charge Bearer Text" <> PaymentExportDataGroup."SEPA Charge Bearer Text"));
    end;

    local procedure InitPmtGroup()
    begin
        PaymentExportDataGroup := PaymentExportData;
        PaymentExportDataGroup."Line No." := 0; // used for counting transactions within group
        PaymentExportDataGroup.Amount := 0; // used for summarizing transactions within group
    end;

    local procedure InsertPmtGroup(var PaymentGroupNo: Integer)
    begin
        PaymentGroupNo += 1;
        PaymentExportDataGroup."Entry No." := PaymentGroupNo;
        PaymentExportDataGroup."Payment Information ID" :=
          CopyStr(
            StrSubstNo('%1/%2', PaymentExportData."Message ID", PaymentGroupNo),
            1, MaxStrLen(PaymentExportDataGroup."Payment Information ID"));
        PaymentExportDataGroup.Insert;
    end;

    local procedure MergeEqualPayments()
    var
        PaymentExportDataMerge: Record "Payment Export Data" temporary;
        PaymentReference: Text;
        WaitingJournal: Record "Waiting Journal";
    begin
        PaymentExportData.Reset;
        PaymentExportData.SetFilter(KID, '%1', '');

        if PaymentExportData.FindSet(true, false) then
            repeat
                PaymentExportDataMerge := PaymentExportData;
                PaymentExportData.SetFilter("Entry No.", '<>%1', PaymentExportDataMerge."Entry No.");
                PaymentExportData.SetFilter("Sender Bank BIC", PaymentExportDataMerge."Sender Bank BIC");
                PaymentExportData.SetRange(Urgent, PaymentExportDataMerge.Urgent);
                PaymentExportData.SetRange("Transfer Date", PaymentExportDataMerge."Transfer Date");
                PaymentExportData.SetRange("SEPA Batch Booking", PaymentExportDataMerge."SEPA Batch Booking");
                PaymentExportData.SetFilter("SEPA Charge Bearer Text", PaymentExportDataMerge."SEPA Charge Bearer Text");
                PaymentExportData.SetFilter("Currency Code", PaymentExportDataMerge."Currency Code");
                PaymentExportData.SetFilter("Recipient Bank Acc. No.", PaymentExportDataMerge."Recipient Bank Acc. No.");
                PaymentExportData.SetFilter(KID, '%1', '');
                PaymentReference := '';
                if PaymentExportData.FindSet(true, false) then
                    repeat
                        if PaymentExportData."Document No." <> '' then
                            PaymentReference += PaymentExportData."Document No." + ',';
                        PaymentExportDataMerge.Amount += PaymentExportData.Amount;

                        WaitingJournal.SetFilter("SEPA End To End ID", PaymentExportData."End-to-End ID");
                        if WaitingJournal.FindSet(true, false) then
                            repeat
                                WaitingJournal."SEPA End To End ID" := PaymentExportDataMerge."End-to-End ID";
                                WaitingJournal.Modify;
                            until WaitingJournal.Next = 0;

                        PaymentExportData.Delete;
                    until PaymentExportData.Next = 0;
                if PaymentReference <> '' then
                    PaymentReference := CopyStr(PaymentReference, 1, StrLen(PaymentReference) - 1); //Remove last ,

                PaymentExportData.Reset;
                PaymentExportData.SetFilter(KID, '%1', '');
                PaymentExportData := PaymentExportDataMerge;

                if PaymentExportData.Amount > 100000 then begin
                    PaymentExportData."Reg.Rep. Thresh.Amt Exceeded" := true;
                    GenJnlLineRegRepCode.Init;
                    GenJnlLineRegRepCode."Journal Batch Name" := PaymentExportData."General Journal Batch Name";
                    GenJnlLineRegRepCode."Journal Template Name" := PaymentExportData."General Journal Template";
                    GenJnlLineRegRepCode."Line No." := PaymentExportData."General Journal Line No.";
                    GenJnlLineRegRepCode."Reg. Code" := '14';
                    GenJnlLineRegRepCode."Reg. Code Description" := 'PURCHASE OF GOODS';
                    GenJnlLineRegRepCode.Insert;
                end;

                PaymentExportData.Modify;

                if PaymentReference <> '' then
                    PaymentExportData.AddRemittanceText(CopyStr(StrSubstNo('%1,%2', PaymentExportDataMerge."Document No.", PaymentReference), 1, 140));

            until PaymentExportData.Next = 0;

        PaymentExportData.Reset;
    end;
}

