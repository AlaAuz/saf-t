codeunit 50002 "AUZ Service Contract Mgt"
{
    Permissions = TableData "Service Ledger Entry" = rm;

    [EventSubscriber(ObjectType::Table, 5965, 'OnAfterInsertEvent', '', true, true)]
    local procedure "ServiceContractHeader.OnAfterInsertEvent"(var Rec: Record "Service Contract Header"; RunTrigger: Boolean)
    begin
        SetPrepaid(Rec);
        SetContractLinesOnInvoice(Rec);
        ModifyServiceContractHeader(Rec);
    end;

    local procedure SetPrepaid(var ServiceContractHeader: Record "Service Contract Header")
    begin
        ServiceContractHeader.Validate(Prepaid, true);
    end;

    local procedure SetContractLinesOnInvoice(var ServiceContractHeader: Record "Service Contract Header")
    begin
        ServiceContractHeader.Validate("Contract Lines on Invoice", true);
    end;

    local procedure ModifyServiceContractHeader(var ServiceContractHeader: Record "Service Contract Header")
    begin
        ServiceContractHeader.Modify(true);
    end;

    procedure CreateRemainingPeriodInvoice(SkipDialog: Boolean; ConfirmationText: Text; InvFrom: Date; InvTo: Date): Boolean
    begin
        if SkipDialog then
            exit(true);

        exit(Confirm(ConfirmationText, true, InvFrom, InvTo));
    end;


    procedure SetServLedgEntryValues(var ServLedgerEntry: Record "Service Ledger Entry"; ContractType: Integer; ContractNo: Code[20]; LineNo: Integer)
    var
        ServiceContractLine: Record "Service Contract Line";
    begin
        if ServiceContractLine.Get(ContractType, ContractNo, LineNo) then begin
            ServLedgerEntry."AUZ SCL Invoiced to Date" := ServiceContractLine."Invoiced to Date";
            ServLedgerEntry."AUZ SCL Quantity" := ServiceContractLine."AUZ Quantity";
            ServLedgerEntry."AUZ SCL Line No." := ServiceContractLine."Line No.";
            ServLedgerEntry."AUZ SCL New Line" := ServiceContractLine."New Line";
        end;
    end;

    procedure SetContractDatesOnServHeader(var ServiceContractHeader: Record "Service Contract Header"; var ServiceHeader: Record "Service Header")
    begin
        ServiceHeader."AUZ Serv. Contr. Next Inv. Date" := ServiceContractHeader."Next Invoice Date";
        ServiceHeader."AUZ Serv. Contr. Last Inv. Date" := ServiceContractHeader."Last Invoice Date";
        ServiceHeader."AUZ SC Next Inv. Period Start" := ServiceContractHeader."Next Invoice Period Start";
        ServiceHeader."AUZ SC Next Inv. Period End" := ServiceContractHeader."Next Invoice Period End";
        ServiceHeader."AUZ SC Last Inv. Period End" := ServiceContractHeader."Last Invoice Period End";
    end;

    procedure SetItem(var ServiceLine: Record "Service Line"; ServiceLedgerEntry: Record "Service Ledger Entry")
    begin
        ServiceLine.Type := ServiceLine.Type::Item;
        ServiceLine.Validate("No.", ServiceLedgerEntry."Item No. (Serviced)");
    end;

    procedure SetServiceLineValues(var ServiceLine: Record "Service Line"; InvFrom: Date; InvTo: Date; ServiceLedgerEntry: Record "Service Ledger Entry")
    begin
        ServiceLine."AUZ Serv. Contract Line From Date" := InvFrom;
        ServiceLine."AUZ Serv. Contract Line To Date" := InvTo;
        ServiceLine."AUZ SCL Invoiced to Date" := ServiceLedgerEntry."AUZ SCL Invoiced to Date";
        ServiceLine."AUZ SCL Quantity" := ServiceLedgerEntry."AUZ SCL Quantity";
        ServiceLine."AUZ SCL Line No." := ServiceLedgerEntry."AUZ SCL Line No.";
        ServiceLine."AUZ SCL New Line" := ServiceLedgerEntry."AUZ SCL New Line";
    end;

    procedure SetNextInvDate(var NextInvDate: Date; ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
    begin
        if ServiceContractLine."New Line" then
            NextInvDate := ServiceContractLine."Starting Date";
    end;

    procedure SetInvFrom(var InvFrom: Date; ServiceContractLine: Record "Service Contract Line")
    begin
        if ServiceContractLine."New Line" then
            InvFrom := ServiceContractLine."Starting Date";
    end;

    procedure SetNewLineOnServiceContractLines(var ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
    begin
        ServiceContractLine.ModifyAll("New Line", false, true);
    end;

    procedure GetTotalLineCostPerPeriod(ServiceContractHeader: Record "Service Contract Header"): Decimal
    var
        ServiceContractLine: Record "Service Contract Line";
        Currency: Record Currency;
        InvFrom: Date;
        InvTo: Date;
        DaysInThisInvPeriod: Integer;
    begin
        if ServiceContractHeader."Invoice Period" = ServiceContractHeader."Invoice Period"::None then exit;
        ServiceContractLine.SetRange("Contract No.", ServiceContractHeader."Contract No.");
        ServiceContractLine.SetRange("Contract Type", ServiceContractHeader."Contract Type");
        ServiceContractLine.CalcSums("Line Cost");
        if ServiceContractLine."Line Cost" > 0 then
            exit(ServiceContractLine."Line Cost" / ReturnNoOfPer(ServiceContractHeader."Invoice Period"));
    end;

    procedure ReturnNoOfPer(InvoicePeriod: Option Month,"Two Months",Quarter,"Half Year",Year) RetPer: Integer
    begin
        case InvoicePeriod of
            InvoicePeriod::Month:
                RetPer := 12;
            InvoicePeriod::"Two Months":
                RetPer := 6;
            InvoicePeriod::Quarter:
                RetPer := 4;
            InvoicePeriod::"Half Year":
                RetPer := 2;
            InvoicePeriod::Year:
                RetPer := 1;
            else
                RetPer := 0;
        end;
    end;


    //ALA
    //FIX Delta files events
    /*

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"AUZ Service Contract Mgt", 'OnCreateServiceLedgerEntryOnBeforeServLedgEntryInsert', '', false, false)]
        local procedure MyProcedure(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceContractHeader: Record "Service Contract Header"; ServiceContractLine: Record "Service Contract Line")
        var
            ServContractLine2: Record "Service Contract Line";
        begin
            SetServLedgEntryValues(ServiceLedgerEntry, ContractType, ContractNo, LineNo);
            if ServiceContractLine.Get(ContractType, ContractNo, LineNo) then
                if ServiceContractLine."New Line" then
                    ServiceContractHeader.Prepaid := false;

            //Fortsett i COD5940.Delta
        end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'OnAddendumToContractOnAfterSetStartingDate', '', false, false)]
        local procedure test(FromServContractHeader: Record "Service Contract Header"; var StartingDate: Date)
        begin
            //Trenger Event her COD5944

        end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnBeforeAddendumToContract', '', false, false)]
        local procedure test1(var ServiceContractHeader: Record "Service Contract Header")
        begin

        end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'SetContractDatesOnServHeader', '', false, false)]
        local procedure SetContractDatesOnServHeaderSetContractDatesOnServHeader(var ServiceHeader: Record "Service Header"; ServiceContractHeader: Record "Service Contract Header")
        begin
            SetContractDatesOnServHeader(ServiceContractHeader, ServiceHeader);
        end;


        [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'OnCreateAllServLinesOnAfterServContractLineSetFilters', '', false, false)]
        local procedure ServiceContractLineOnCreateAllServLinesOnAfterServContractLineSetFilters(var ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
        var
            ServContractManagement: Codeunit "ServContractManagement";
        begin
            ServiceContractLine.SetFilter("Starting Date", '<%1', ServiceContractHeader."Next Invoice Period End");

            if (ServiceContractLine."New Line") then
                InvoiceFrom := ServContractLine."Starting Date"
            else
                InvoiceFrom := ServContractToInvoice."Next Invoice Period Start";


            if (ServiceContractLine."New Line") and (ServiceContractLine."Starting Date" > ServiceContractHeader."Next Invoice Date") then
                ServContractManagement.CreateDetailedServLine(ServHeader, ServContractLine, "Contract Type", "Contract No.");


            if ServiceApplyEntry <> 0 then
                ServiceContractLine.Mark(true);
        end;


        [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'SetContractDatesOnServHeader', '', false, false)]
        local procedure SetContractDatesOnServHeaderSetContractDatesOnServHeader(var ServiceHeader: Record "Service Header"; ServiceContractHeader: Record "Service Contract Header")
        begin
            SetContractDatesOnServHeader(ServiceContractHeader, ServiceHeader);
        end;


        [EventSubscriber(ObjectType::Codeunit, Codeunit::ServContractManagement, 'OnBeforeServLedgEntryToServiceLine', '', false, false)]
        local procedure OnBeforeServLedgEntryToServiceLine(var TotalServiceLine: Record "Service Line"; var TotalServiceLineLCY: Record "Service Line"; ServiceHeader: Record "Service Header"; ServiceLedgerEntry: Record "Service Ledger Entry"; var IsHandled: Boolean; ServiceLedgerEntryParm: Record "Service Ledger Entry")
        var
            ServLine: Record "Service Line";
        begin
            ServLineNo := ServLineNo + 10000;
            with ServLine do begin
                Reset;
                Init;
                "Document Type" := ServiceHeader."Document Type";
                "Document No." := ServiceHeader."No.";
                "Line No." := ServLineNo;
                "Customer No." := ServiceHeader."Customer No.";
                "Location Code" := ServiceHeader."Location Code";
                "Gen. Bus. Posting Group" := ServiceHeader."Gen. Bus. Posting Group";
                "Transaction Specification" := ServiceHeader."Transaction Specification";
                "Transport Method" := ServiceHeader."Transport Method";
                "Exit Point" := ServiceHeader."Exit Point";
                Area := ServiceHeader.Area;
                "Transaction Specification" := ServiceHeader."Transaction Specification";
                Type := Type::"G/L Account";
                Validate("No.", AppliedGLAccount);
                Validate(Quantity, 1);
                if ServMgtSetup."Contract Inv. Period Text Code" <> '' then begin
                    StdText.Get(ServMgtSetup."Contract Inv. Period Text Code");
                    TempServLineDescription := StrSubstNo('%1 %2 - %3', StdText.Description, Format(InvFrom), Format(InvTo));
                    if StrLen(TempServLineDescription) > MaxStrLen(Description) then
                        Error(
                          Text013,
                          TableCaption, FieldCaption(Description),
                          StdText.TableCaption, StdText.Code, StdText.FieldCaption(Description),
                          Format(StrLen(TempServLineDescription) - MaxStrLen(Description)));
                    Description := CopyStr(TempServLineDescription, 1, MaxStrLen(Description));
                end else
                    Description :=
                      StrSubstNo('%1 - %2', Format(InvFrom), Format(InvTo));
                "Contract No." := ContractNo;
                "Appl.-to Service Entry" := ServiceLedgerEntry."Entry No.";
                "Service Item No." := ServiceLedgerEntry."Service Item No. (Serviced)";
                "Unit Cost (LCY)" := ServiceLedgerEntry."Unit Cost";
                "Unit Price" := -ServiceLedgerEntry."Unit Price";

                TotalServiceLine."Unit Price" += "Unit Price";
                TotalServiceLine."Line Amount" += -ServiceLedgerEntry."Amount (LCY)";
                if (ServiceLedgerEntry."Amount (LCY)" <> 0) or (ServiceLedgerEntry."Discount %" > 0) then
                    if ServiceHeader."Currency Code" <> '' then begin
                        Validate("Unit Price",
                          AmountToFCY(TotalServLine."Unit Price", ServiceHeader) - TotalServLineLCY."Unit Price");
                        Validate("Line Amount",
                          AmountToFCY(TotalServLine."Line Amount", ServiceHeader) - TotalServLineLCY."Line Amount");
                    end else begin
                        Validate("Unit Price");
                        Validate("Line Amount", -ServiceLedgerEntry."Amount (LCY)");
                    end;
                TotalServLineLCY."Unit Price" += "Unit Price";
                TotalServLineLCY."Line Amount" += "Line Amount";

                "Shortcut Dimension 1 Code" := ServiceLedgerEntry."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := ServiceLedgerEntry."Global Dimension 2 Code";
                "Dimension Set ID" := ServiceLedgerEntry."Dimension Set ID";

                Insert;
                CreateDim(
                  DimMgt.TypeToTableID5(Type), "No.",
                  DATABASE::Job, "Job No.",
                  DATABASE::"Responsibility Center", "Responsibility Center");
            end;
            IsHandled := true;
        end;

            */
}