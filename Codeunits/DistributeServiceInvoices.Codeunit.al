codeunit 70905 "Distribute Service Invoices"
{
    Permissions = TableData "Service Invoice Header" = rm;
    TableNo = "Service Invoice Header";

    trigger OnRun()
    begin
        TryDistributeServInvoice(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 invoices?';
        Text002: Label 'Do you want to distribute posted service invoice %1?';
        DocTxt: Label 'Invoice';

    local procedure TryDistributeServInvoice(ServInvHeader: Record "Service Invoice Header")
    var
        TempEInvoiceTransferFile: Record "E-Invoice Transfer File" temporary;
        EInvoiceExportServInvoice: Codeunit "E-Invoice Export Serv. Invoice";
        EInvoiceExportCommon: Codeunit "E-Invoice Export Common";
    begin
        with ServInvHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false);
                "Distribution Type"::"E-Mail":
                    DoEmailRecords(ServInvHeader, false);
                "Distribution Type"::EHF:
                    begin
                        EInvoiceExportServInvoice.Run(ServInvHeader);
                        EInvoiceExportServInvoice.GetExportedFileInfo(TempEInvoiceTransferFile);
                        TempEInvoiceTransferFile."Line No." := 1;
                        TempEInvoiceTransferFile.Insert;
                        EInvoiceExportCommon.DownloadEInvoiceFile(TempEInvoiceTransferFile);
                    end;
            end;
        end;
    end;

    [Scope('Internal')]
    procedure DoEmailRecords(var ServInvHeader: Record "Service Invoice Header"; ShowDialog: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
        with ServInvHeader do
            DocumentSendingProfile.TrySendToEMail(
              DummyReportSelections.Usage::"SM.Invoice", ServInvHeader, FieldNo("No."), DocTxt, FieldNo("Bill-to Customer No."), ShowDialog);
    end;

    [Scope('Internal')]
    procedure DistributeServInvoices(var ServInvoiceHeader: Record "Service Invoice Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with ServInvoiceHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeServInvoice(ServInvoiceHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeServInvoice(ServInvoiceHeader: Record "Service Invoice Header") DistributionOK: Boolean
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Service Invoices", ServInvoiceHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::"Service Invoice";
        DistributionLogEntry."Document No." := ServInvoiceHeader."No.";
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
        if not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order, Rec."Document Type"::Invoice]) then exit;
        if Customer.Get(Rec."Bill-to Customer No.") then;
        Rec."Distribution Type" := Customer."Distribution Type";
    end;

    [EventSubscriber(ObjectType::Page, 5978, 'OnAfterActionEvent', 'Disitribute', false, false)]
    local procedure "PostedServiceInvoice.Disitribute"(var Rec: Record "Service Invoice Header")
    begin
        if not Confirm(Text002, true, Rec."No.") then
            Error('');
        if DistributeServInvoice(Rec) then
            DistributionMgt.ShowCompletionMessage(1, 0, 1)
        else
            DistributionMgt.ShowCompletionMessage(0, 1, 1);
        Rec.Find;
    end;

    [EventSubscriber(ObjectType::Page, 5978, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedServiceInvoice.ChangeDistributionType"(var Rec: Record "Service Invoice Header")
    begin
        ChangeServInvoiceDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 5977, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "PostedServiceInvoices.ChangeDistributionType"(var Rec: Record "Service Invoice Header")
    begin
        ChangeServInvoiceDistributionType(Rec);
    end;

    local procedure ChangeServInvoiceDistributionType(var ServInvoiceHeader: Record "Service Invoice Header")
    begin
        if DistributionMgt.SelectDistributionType(ServInvoiceHeader."Distribution Type") then
            ServInvoiceHeader.Modify;
    end;
}

