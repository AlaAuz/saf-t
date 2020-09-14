codeunit 70902 "Distribute Sales Cr. Memos"
{
    Permissions = TableData "Sales Cr.Memo Header" = rm;
    TableNo = "Sales Cr.Memo Header";

    trigger OnRun()
    begin
        TryDistributeSalesCrMemo(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 credit memos?';
        Text002: Label 'Do you want to distribute posted sales credit memo %1?';

    local procedure TryDistributeSalesCrMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        TempEInvoiceTransferFile: Record "E-Invoice Transfer File" temporary;
        EInvoiceExpSalesCrMemo: Codeunit "E-Invoice Exp. Sales Cr. Memo";
        EInvoiceExportCommon: Codeunit "E-Invoice Export Common";
    begin
        with SalesCrMemoHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false);
                "Distribution Type"::"E-Mail":
                    EmailRecords(false);
                "Distribution Type"::EHF:
                    begin
                        EInvoiceExpSalesCrMemo.Run(SalesCrMemoHeader);
                        EInvoiceExpSalesCrMemo.GetExportedFileInfo(TempEInvoiceTransferFile);
                        TempEInvoiceTransferFile."Line No." := 1;
                        TempEInvoiceTransferFile.Insert;
                        EInvoiceExportCommon.DownloadEInvoiceFile(TempEInvoiceTransferFile);
                    end;
            end;
        end;
    end;

    [Scope('Internal')]
    procedure DistributeSalesCrMemosOnAfterPosting(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        Commit;
        if not DistributeSalesCrMemo(SalesCrMemoHeader) then
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
    end;

    [Scope('Internal')]
    procedure DistributeSalesCrMemos(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with SalesCrMemoHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeSalesCrMemo(SalesCrMemoHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeSalesCrMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header") DistributionOK: Boolean
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Sales Cr. Memos", SalesCrMemoHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::"Sales Credit Memo";
        DistributionLogEntry."Document No." := SalesCrMemoHeader."No.";
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

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Bill-to Customer No.', true, true)]
    local procedure SetDistributionTypeOnAfterValidateBilllToCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if Rec."Document Type" <> Rec."Document Type"::"Credit Memo" then exit;
        if Customer.Get(Rec."Bill-to Customer No.") then;
        Rec."Distribution Type" := Customer."Distribution Type";
    end;

    [EventSubscriber(ObjectType::Page, 134, 'OnAfterActionEvent', 'Disitribute', false, false)]
    local procedure "PostedSalesCreditMemo.Disitribute"(var Rec: Record "Sales Cr.Memo Header")
    begin
        if not Confirm(Text002, true, Rec."No.") then
            Error('');
        if DistributeSalesCrMemo(Rec) then
            DistributionMgt.ShowCompletionMessage(1, 0, 1)
        else
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
        Rec.Find;
    end;

    [EventSubscriber(ObjectType::Page, 134, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedSalesCreditMemo.ChangeDistributionType"(var Rec: Record "Sales Cr.Memo Header")
    begin
        ChangeSalesCrMemoDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 144, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedSalesCreditMemos.ChangeDistributionType"(var Rec: Record "Sales Cr.Memo Header")
    begin
        ChangeSalesCrMemoDistributionType(Rec);
    end;

    local procedure ChangeSalesCrMemoDistributionType(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        if DistributionMgt.SelectDistributionType(SalesCrMemoHeader."Distribution Type") then
            SalesCrMemoHeader.Modify;
    end;
}

