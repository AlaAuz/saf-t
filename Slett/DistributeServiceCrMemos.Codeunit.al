codeunit 70906 "Distribute Service Cr. Memos"
{
    Permissions = TableData "Service Cr.Memo Header" = rm;
    TableNo = "Service Cr.Memo Header";

    trigger OnRun()
    begin
        TryDistributeServCrMemo(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 credit memos?';
        Text002: Label 'Do you want to distribute posted service credit memo %1?';
        DocTxt: Label 'Credit Memo';

    local procedure TryDistributeServCrMemo(ServCrMemoHeader: Record "Service Cr.Memo Header")
    var
        TempEInvoiceTransferFile: Record "E-Invoice Transfer File" temporary;
        EInvoiceExpServCrMemo: Codeunit "E-Invoice Exp. Serv. Cr. Memo";
        EInvoiceExportCommon: Codeunit "E-Invoice Export Common";
    begin
        with ServCrMemoHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false);
                "Distribution Type"::"E-Mail":
                    DoEmailRecords(ServCrMemoHeader, false);
                "Distribution Type"::EHF:
                    begin
                        EInvoiceExpServCrMemo.Run(ServCrMemoHeader);
                        EInvoiceExpServCrMemo.GetExportedFileInfo(TempEInvoiceTransferFile);
                        TempEInvoiceTransferFile."Line No." := 1;
                        TempEInvoiceTransferFile.Insert;
                        EInvoiceExportCommon.DownloadEInvoiceFile(TempEInvoiceTransferFile);
                    end;
            end;
        end;
    end;


    procedure DoEmailRecords(var ServCrMemoHeader: Record "Service Cr.Memo Header"; ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
        with ServCrMemoHeader do
            DocumentSendingProfile.TrySendToEMail(
              DummyReportSelections.Usage::"SM.Credit Memo", ServCrMemoHeader, FieldNo("No."), DocTxt, FieldNo("Bill-to Customer No."), ShowRequestForm);
    end;


    procedure DistributeServCrMemos(var ServCrMemoHeader: Record "Service Cr.Memo Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with ServCrMemoHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeServCrMemo(ServCrMemoHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeServCrMemo(ServCrMemoHeader: Record "Service Cr.Memo Header") DistributionOK: Boolean
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Service Cr. Memos", ServCrMemoHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::"Service Credit Memo";
        DistributionLogEntry."Document No." := ServCrMemoHeader."No.";
        DistributionLogEntry.Date := Today;
        if DistributionOK then
            NoOfDistributions += 1
        else begin
            DistributionLogEntry.SetErrorMessage(GetLastErrorText);
            NoOfErrors += 1;
        end;
        DistributionLogEntry.Insert(true);
    end;

    local procedure InitValues()
    begin
        NoOfDistributions := 0;
        NoOfErrors := 0;
    end;

    [EventSubscriber(ObjectType::Table, 5900, 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure SetDistributionTypeOnAfterValidateBilllToCustomerNo(var Rec: Record "Service Header"; var xRec: Record "Service Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if Rec."Document Type" <> Rec."Document Type"::"Credit Memo" then exit;
        if Customer.Get(Rec."Bill-to Customer No.") then;
        Rec."Distribution Type" := Customer."Distribution Type";
    end;

    [EventSubscriber(ObjectType::Page, 5972, 'OnAfterActionEvent', 'Disitribute', false, false)]
    local procedure "PostedServiceCreditMemo.Disitribute"(var Rec: Record "Service Cr.Memo Header")
    begin
        if not Confirm(Text002, true, Rec."No.") then
            Error('');
        if DistributeServCrMemo(Rec) then
            DistributionMgt.ShowCompletionMessage(1, 0, 1)
        else
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
        Rec.Find;
    end;

    [EventSubscriber(ObjectType::Page, 5972, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedServiceCreditMemo.ChangeDistributionType"(var Rec: Record "Service Cr.Memo Header")
    begin
        ChangeServCrMemoDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 5971, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedServiceCreditMemos.ChangeDistributionType"(var Rec: Record "Service Cr.Memo Header")
    begin
        ChangeServCrMemoDistributionType(Rec);
    end;

    local procedure ChangeServCrMemoDistributionType(var ServCrMemoHeader: Record "Service Cr.Memo Header")
    begin
        if DistributionMgt.SelectDistributionType(ServCrMemoHeader."Distribution Type") then
            ServCrMemoHeader.Modify;
    end;
}

