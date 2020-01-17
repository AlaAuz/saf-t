codeunit 50070 "Camt.054"
{
    procedure Import(var GenJnlLine: Record "Gen. Journal Line")
    var
        TempBlob: Record TempBlob temporary;
        GenJnlBatch: Record "Gen. Journal Batch";
        FileMgt: Codeunit "File Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
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
        GenJnlBatch.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        FindLastLineNo(GenJnlLine);
        TempBlob.blob.CreateInStream(IStream, TEXTENCODING::UTF8);
        XmlDocument.ReadFrom(IStream, XmlDoc);
        Namespace.AddNamespace('n', 'urn:iso:std:iso:20022:tech:xsd:camt.054.001.02');
        if XmlDoc.SelectNodes('//n:BkToCstmrDbtCdtNtfctn/n:Ntfctn/n:Ntry', Namespace, NtryList) then
            foreach NtryNode in NtryList do
                if NtryNode.IsXmlElement then begin
                    PostingDate := ConvertTextToDate(NtryNode, './n:BookgDt/n:Dt', InnerTxt);
                    if GenJnlBatch."No. Series" <> '' then begin
                        Clear(NoSeriesManagement);
                        DocumentNo := NoSeriesManagement.GetNextNo(GenJnlBatch."No. Series", PostingDate, true);
                    end;
                    if NtryNode.SelectNodes('./n:NtryDtls/n:TxDtls', Namespace, TxDtlsList) then
                        foreach TxDtLsNode in TxDtlsList do
                            if TxDtLsNode.IsXmlElement then begin
                                TransfereFieldFromWaitingLine(GenJnlLine, NtryNode, TxDtLsNode, InnerTxt);
                                InsertBankCharge(GenJnlLine, NtryNode, TxDtLsNode, InnerTxt);
                            end;
                    InsertBankDetails(GenJnlLine, NtryNode, InnerTxt);
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
        GetTransactionInfo(TxDtlsNode, MsgId, PmtInfId, EndToEndId);
        WaitingJournal.SetRange("SEPA End To End ID", EndToEndId);
        WaitingJournal.FindSet();
        repeat
            IncrementLineNo();
            GenJnlLine.Init();
            GenJnlLine.TransferFields(WaitingJournal);
            GenJnlLine."Line No." := LineNo;
            GenJnlLine.Validate("Posting Date", PostingDate);
            GenJnlLine.Validate("Document No.", DocumentNo);
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
        GenJnlLine.Validate("Document No.", DocumentNo);
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
        GenJnlLine.Validate("Document No.", DocumentNo);
        GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.Validate("Posting Date", ConvertTextToDate(NtryNode, './n:BookgDt/n:Dt', InnerTxt));
        GenJnlLine.Validate(Description, BankchargeTxt);
        GenJnlLine.Validate("Amount", ConvertTextToDecimal(TxDtlsNode, './n:Chrgs/n:Amt', InnerTxt));
        GenJnlLine.Validate("Amount (LCY)", ConvertTextToDecimal(TxDtlsNode, './n:Chrgs/n:Amt', InnerTxt));
        GenJnlLine.Insert(true);
    end;

    local procedure SetCurrencyFactor(GenJnlLine: Record "Gen. Journal Line"; TxDtlsNode: XmlNode; var InnerTxt: Text)
    begin
        if GenJnlLine."Currency Code" = '' then
            exit;
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

    local procedure FindLastLineNo(var GenJnlLine: Record "Gen. Journal Line")
    var
        GenJnlLine2: Record "Gen. Journal Line";
    begin
        GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
        if GenJnlLine2.FindLast then
            LineNo := GenJnlLine2."Line No."
    end;

    local procedure IncrementLineNo()
    begin
        LineNo += 10000;
    end;

    local procedure GetTransactionInfo(Node: XmlNode; var MsgId: Text; var PmtInfId: Text; var EndToEndId: Text)
    begin
        GetElementInnerText(Node, './n:Refs/n:MsgId', MsgId);
        GetElementInnerText(Node, '../n:PmtInfId', PmtInfId);
        GetElementInnerText(Node, '../n:EndToEndId', EndToEndId);
    end;

    local procedure ConvertTextToDate(Node: XmlNode; Path: Text; InnerText: Text) NewDate: Date
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewDate, InnerText, 9);
    end;

    local procedure ConvertTextToDecimal(Node: XmlNode; Path: Text; InnerText: Text) NewDecimal: Decimal
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewDecimal, InnerText, 9);
    end;

    local procedure ConvertTextToCode(Node: XmlNode; Path: Text; InnerText: Text) NewCode: Code[20]
    begin
        if GetElementInnerText(Node, Path, InnerText) then
            if InnerText <> '' then
                Evaluate(NewCode, InnerText, 9);
    end;


    procedure UpdateWaitingJournal(GenJnlLine: Record "Gen. Journal Line")
    var
        WaitingJournal: Record "Waiting Journal";
        RemittanceAccount: Record "Remittance Account";
        RemittanceAgreement: Record "Remittance Agreement";
    begin
        if GenJnlLine."Waiting Journal Reference" = 0 then
            exit;
        WaitingJournal.Get(GenJnlLine."Waiting Journal Reference");
        RemittanceAgreement.Get(RemittanceAccount."Remittance Agreement Code");
        CheckBeforeSettle(WaitingJournal, RemittanceAgreement);
        WaitingJournal.Validate("Remittance Status", WaitingJournal."Remittance Status"::Settled);
        WaitingJournal.Modify;
    end;

    local procedure CheckBeforeSettle(WaitingJournal: Record "Waiting Journal"; RemittanceAgreement: Record "Remittance Agreement")
    begin
        // If the status is not sent or approved, it will not be changed to settled.
        if (WaitingJournal."Remittance Status" <> WaitingJournal."Remittance Status"::Sent) and
           (WaitingJournal."Remittance Status" <> WaitingJournal."Remittance Status"::Approved)
        then
            WaitingJournal.FieldError(
              "Remittance Status", StrSubstNo(CannotBeWhenSettlingErr, WaitingJournal."Remittance Status"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnAfterCheckGenJnlLine', '', true, true)]
    local procedure UpdaeWaitingJournalAfterGLFinishPosting(var GenJournalLine: Record "Gen. Journal Line")
    begin
        UpdateWaitingJournal(GenJournalLine);
    end;

    var
        Namespace: XmlNamespaceManager;
        LineNo: Integer;
        PostingDate: Date;
        DocumentNo: Code[20];
        CustomExchRateIsConfirmed: Boolean;
        VendorRemittanceTxt: Label 'Remittance: Vendor %1';
        BankchargeTxt: Label 'Bank charges';
        CannotBeWhenSettlingErr: Label 'cannot be %1 when settling', Comment = '%1 is the value of the remittance status';
}