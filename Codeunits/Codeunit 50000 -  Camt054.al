codeunit 50070 "Camt.054"
{
    procedure Import(var GenJnlLine: Record "Gen. Journal Line")
    var
        FileMgt: Codeunit "File Management";
        TempBlob: Record TempBlob temporary;
        XmlDoc: XmlDocument;
        NtryList: XmlNodeList;
        TxDtlsList: XmlNodeList;
        NtryNode: XmlNode;
        TxDtLsNode: XmlNode;
        IStream: InStream;
        InnerTxt: Text;
    begin
        if FileMgt.BLOBImport(TempBlob, '') = '' then
            Error('');

        LineNo := GetLastLineNo(GenJnlLine);

        TempBlob.blob.CreateInStream(IStream, TEXTENCODING::UTF8);
        XmlDocument.ReadFrom(IStream, XmlDoc);
        Namespace.AddNamespace('n', 'urn:iso:std:iso:20022:tech:xsd:camt.054.001.02');
        if XmlDoc.SelectNodes('//n:BkToCstmrDbtCdtNtfctn/n:Ntfctn/n:Ntry', Namespace, NtryList) then
            foreach NtryNode in NtryList do begin
                if NtryNode.IsXmlElement then begin
                    if NtryNode.SelectNodes('./n:NtryDtls/n:TxDtls', Namespace, TxDtlsList) then
                        foreach TxDtLsNode in TxDtlsList do
                            if TxDtLsNode.IsXmlElement then begin
                                TransfereFieldFromWaitingLine(GenJnlLine, NtryNode, TxDtLsNode, InnerTxt);
                                InsertBankCharge(GenJnlLine, NtryNode, TxDtLsNode, InnerTxt);
                            end;
                    InsertBankDetails(GenJnlLine, NtryNode, InnerTxt);
                end;
            end;
    end;

    local procedure TransfereFieldFromWaitingLine(GenJnlLine: Record "Gen. Journal Line"; EntryNode: XmlNode; TxDtlsNode: XmlNode; var InnerTxt: Text)
    var
        WaitingJournal: Record "Waiting Journal";
        MsgId: Text;
        PmtInfId: Text;
        EndToEndId: Text;
    begin
        CustomExchRateIsConfirmed := false;
        GetTransactionInfo(TxDtlsNode, PmtInfId);

        WaitingJournal.SetRange("SEPA Payment Inf ID", PmtInfId);
        WaitingJournal.FindSet();
        repeat
            IncrementLineNo();
            GenJnlLine.Init();
            GenJnlLine."Line No." := LineNo;
            GenJnlLine.TransferFields(WaitingJournal);
            GenJnlLine."Waiting Journal Reference" := WaitingJournal.Reference; //Sjekk om du trenger denne
            SetCurrencyFactor(GenJnlLine, TxDtlsNode, InnerTxt);
            GenJnlLine.Insert(true);
        until WaitingJournal.Next = 0
    end;

    local procedure InsertBankDetails(GenJnlLine: Record "Gen. Journal Line"; NtryNode: XmlNode; var InnerTxt: Text)
    begin
        IncrementLineNo();
        GenJnlLine.Init();
        GenJnlLine."Line No." := LineNo;
        GenJnlLine.Validate("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"Bank Account");
        GenJnlLine.Validate("Posting Date", ConvertTextToDate(NtryNode, './n:BookgDt/n:Dt', InnerTxt));
        GenJnlLine.Validate(Description, CopyStr(StrSubstNo(VendorRemittanceTxt, GenJnlLine."Posting Date"), 1, MaxStrLen(GenJnlLine.Description)));
        GenJnlLine.Validate("Amount", -ConvertTextToDecimal(NtryNode, './n:Amt', InnerTxt));
        GenJnlLine.Insert(true);
    end;

    local procedure InsertBankCharge(GenJnlLine: Record "Gen. Journal Line"; NtryNode: XmlNode; TxDtlsNode: XmlNode; var InnerTxt: Text)
    begin
        if ConvertTextToDecimal(TxDtlsNode, './n:Chrgs/n:Amt', InnerTxt) = 0 then
            exit;
        IncrementLineNo();
        GenJnlLine.Init();
        GenJnlLine."Line No." := LineNo;
        GenJnlLine.Validate("Document Type", GenJnlLine."Document Type"::Payment);
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Posting Date", ConvertTextToDate(NtryNode, './n:BookgDt/n:Dt', InnerTxt));
        GenJnlLine.Validate(Description, BankchargeTxt);
        GenJnlLine.Validate("Amount", ConvertTextToDecimal(TxDtlsNode, './n:Chrgs/n:Amt', InnerTxt));
        GenJnlLine.Validate("Amount (LCY)", ConvertTextToDecimal(TxDtlsNode, './n:Chrgs/n:Amt', InnerTxt));
        GenJnlLine.Insert(true);
    end;

    local procedure SetCurrencyFactor(GenJnlLine: Record "Gen. Journal Line"; TxDtlsNode: XmlNode; var InnerTxt: Text)
    begin
        if ConvertTextToCode(TxDtlsNode, './n:AmtDtls/n:InstdAmt/n:CcyXchg/n:SrcCcy', InnerTxt) = '' then
            exit;
        GenJnlLine.Validate("Currency Factor", ConvertTextToDecimal(TxDtlsNode, './n:AmtDtls/n:InstdAmt/n:CcyXchg/n:XchgRate', InnerTxt));
    end;

    local procedure GetElementInnerText(var Node: XmlNode; Path: Text; var InnerTxt: Text): Boolean
    var
        Element: XmlElement;
    begin
        InnerTxt := '';
        if Node.SelectSingleNode(Path, Namespace, Node) then begin
            if Node.IsXmlElement then begin
                Element := Node.AsXmlElement();
                InnerTxt := Element.InnerText;
                exit(true);
            end;
        end;
    end;

    local procedure GetLastLineNo(var GenJnlLine: Record "Gen. Journal Line") LineNo: Integer
    var
        GenJournalLine2: Record "Gen. Journal Line";
    begin
        GenJournalLine2.SetRange("Journal Template Name", GenJournalLine2."Journal Template Name");
        GenJournalLine2.SetRange("Journal Batch Name", GenJournalLine2."Journal Batch Name");
        if GenJournalLine2.FindLast then
            LineNo := GenJournalLine2."Line No."
    end;

    local procedure IncrementLineNo()
    begin
        LineNo += 10000;
    end;

    local procedure GetTransactionInfo(Node: XmlNode; var PmtInfId: Text)
    begin
        GetElementInnerText(Node, '../n:PmtInfId', PmtInfId);
    end;

    local procedure ConvertTextToDate(Node: XmlNode; Path: Text; var InnerText: Text) NewDate: Date
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewDate, InnerText)
    end;

    local procedure ConvertTextToDecimal(Node: XmlNode; Path: Text; var InnerText: Text) NewDecimal: Decimal
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewDecimal, InnerText, 9);
    end;

    local procedure ConvertTextToCode(Node: XmlNode; Path: Text; var InnerText: Text) NewCode: Code[20]
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewCode, InnerText, 9);
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterGLFinishPosting', '', true, true)]
    local procedure UpdaeWaitingJournalAfterGLFinishPosting(GenJournalLine: Record "Gen. Journal Line")
    begin
    
    end;

    local procedure UpdateWaitingJournalWithAmtDtls(var WaitingJournal: Record "Waiting Journal"; GenJournalLine: Record "Gen. Journal Line"): Boolean //STD. LOCAL Procedure from ImportCAMT054
    begin
        if (WaitingJournal."Currency Code" = GenJournalLine."Source Currency Code") AND
           (GetCurrencyCode('') = GenJournalLine."Currency Code")
        then
            if (WaitingJournal.Amount <> GenJournalLine.Amount) OR
               (WaitingJournal."Amount (LCY)" <> GenJournalLine."Amount (LCY)")
            then begin
                WaitingJournal.Amount := GenJournalLine.Amount;
                WaitingJournal."Amount (LCY)" := GenJournalLine."Amount (LCY)";
                if GenJournalLine."Currency Factor" <> 0 then
                    WaitingJournal."Currency Factor" := 1 / GenJournalLine."Currency Factor";
                exit(true);
            END;

        exit(false);
    end;

    local procedure GetCurrencyCode(CurrencyCode: Code[10]): Code[10] //STD. LOCAL Procedure from ImportCAMT054
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if CurrencyCode = '' then
            exit(GLSetup."LCY Code");
        exit(CurrencyCode);
    end;

    procedure ConfirmImportExchRateDialog(): Boolean // STD. ONPREM Procedure From ImportSEPACommon
    var
        ConfirmMgt: Codeunit "Confirm Management";
        ConfirmImportExchRateQst: Label 'Return data in the file to be imported has a different currency exchange rate than one in a waiting journal. This may lead to gain/loss detailed ledger entries during application.\\Do you want ConfirmImportExchRateQstto continue?';
        ImportCancelledErr: Label 'Import is cancelled.';
    begin
       // if not ConfirmMgt.GetResponseOrDefault(ConfirmImportExchRateQst, true) then
            Error(ImportCancelledErr);
        exit(true);
    end;
    */
    var
        Namespace: XmlNamespaceManager;
        LineNo: Integer;
        CustomExchRateIsConfirmed: Boolean;
        VendorRemittanceTxt: Label 'Remittance: Vendor %1';
        BankchargeTxt: Label 'Bank charges';

}