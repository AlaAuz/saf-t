codeunit 50007 "Delete Service Invoice"
{
    // AZ99999 18.12.2017 DHG Change code to set filter on type item.

    [EventSubscriber(ObjectType::Table, 5900, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure "ServHeader.OnBeforeDelete"(var Rec: Record "Service Header"; RunTrigger: Boolean)
    begin
        if not RunTrigger then exit;
        if Rec."Last Posting No." <> '' then exit;
        if Rec."Document Type" <> Rec."Document Type"::Invoice then exit;
        if IsApplyToServiceEntryNoZero(Rec) then begin
            DeleteServLedgerEntry(Rec);
            UpdateInvoicedToDate(Rec);
            UpdateServContractHeader(Rec);
            UpdateNewLine(Rec);
        end;
    end;

    local procedure IsApplyToServiceEntryNoZero(ServiceHeader: Record "Service Header"): Boolean
    var
        ServiceLine: Record "Service Line";
    begin
        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        ServiceLine.SetFilter("Appl.-to Service Entry", '<>%1', 0);
        exit(not ServiceLine.IsEmpty);
    end;

    local procedure DeleteServLedgerEntry(ServHeader: Record "Service Header")
    var
        ServLine: Record "Service Line";
        ServLedgerEntry: Record "Service Ledger Entry";
    begin
        ServLine.SetRange("Document Type", ServHeader."Document Type");
        ServLine.SetRange("Document No.", ServHeader."No.");
        ServLine.SetRange(Type, ServLine.Type::Item);
        if ServLine.FindSet then
            repeat
                if ServLedgerEntry.Get(ServLine."Appl.-to Service Entry") then
                    ServLedgerEntry.Delete(true);
                ServLine.Validate("Appl.-to Service Entry", 0);
                ServLine.Modify(true);
            until ServLine.Next = 0;
    end;

    local procedure UpdateInvoicedToDate(ServiceHeader: Record "Service Header")
    var
        ServiceContractLine: Record "Service Contract Line";
        ServiceLine: Record "Service Line";
        xServiceLine: Record "Service Line";
        LastInvoicedtoDate: Date;
        IsFirst: Boolean;
    begin
        ServiceLine.SetCurrentKey("Document Type", "Document No.", "No.");
        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        ServiceLine.SetRange(Type, ServiceLine.Type::Item);
        if ServiceLine.FindSet then begin
            IsFirst := true;
            repeat
                if ServiceLine."No." <> xServiceLine."No." then begin
                    if not IsFirst then
                        UpdateServiceContractLine(xServiceLine, LastInvoicedtoDate);
                    LastInvoicedtoDate := ServiceLine."AUZ SCL Invoiced to Date";
                end else
                    if LastInvoicedtoDate > ServiceLine."AUZ SCL Invoiced to Date" then
                        LastInvoicedtoDate := ServiceLine."AUZ SCL Invoiced to Date";
                xServiceLine := ServiceLine;
                IsFirst := false;
            until ServiceLine.Next = 0;
        end;
        UpdateServiceContractLine(xServiceLine, LastInvoicedtoDate);
    end;

    local procedure UpdateServContractHeader(var ServHeader: Record "Service Header")
    var
        ServContractHeader: Record "Service Contract Header";
        LockOpenServContract: Codeunit "Lock-OpenServContract";
        OldStatus: Integer;
    begin
        if ServContractHeader.Get(ServContractHeader."Contract Type"::Contract, ServHeader."Contract No.") then begin
            OldStatus := ServContractHeader."Change Status";
            ServContractHeader."Change Status" := ServContractHeader."Change Status"::Open;
            ServContractHeader."Next Invoice Date" := ServHeader."AUZ Serv. Contr. Next Inv. Date";
            ServContractHeader."Last Invoice Date" := ServHeader."AUZ Serv. Contr. Last Inv. Date";
            ServContractHeader."Next Invoice Period Start" := ServHeader."AUZ SC Next Inv. Period Start";
            ServContractHeader."Next Invoice Period End" := ServHeader."AUZ SC Next Inv. Period End";
            ServContractHeader."Last Invoice Period End" := ServHeader."AUZ SC Last Inv. Period End";
            ServContractHeader."Change Status" := OldStatus;
            ServContractHeader.Modify;
        end;
    end;

    local procedure UpdateServiceContractLine(ServiceLine: Record "Service Line"; LastInvoicedtoDate: Date)
    var
        ServiceContractLine: Record "Service Contract Line";
    begin
        ServiceContractLine.SetRange("Contract Type", ServiceContractLine."Contract Type"::Contract);
        ServiceContractLine.SetRange("Contract No.", ServiceLine."Contract No.");
        ServiceContractLine.SetRange("Item No.", ServiceLine."No.");
        if ServiceContractLine.FindFirst then begin
            ServiceContractLine.Validate("Invoiced to Date", LastInvoicedtoDate);
            ServiceContractLine.Modify(true);
        end;
    end;

    local procedure UpdateNewLine(ServiceHeader: Record "Service Header")
    var
        ServiceContractHeader: Record "Service Contract Header";
        ServiceContractLine: Record "Service Contract Line";
        ServiceLine: Record "Service Line";
    begin
        if not ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, ServiceHeader."Contract No.") then exit;
        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        if ServiceLine.FindSet then
            repeat
                if ServiceContractLine.Get(ServiceContractHeader."Contract Type", ServiceContractHeader."Contract No.", ServiceLine."AUZ SCL Line No.") then begin
                    ServiceContractLine.Validate("New Line", ServiceLine."AUZ SCL New Line");
                    ServiceContractLine.Modify(true);
                end;
            until ServiceLine.Next = 0;
    end;
}