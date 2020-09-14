codeunit 50002 "Service Contract Management"
{
    Permissions = TableData "Service Ledger Entry" = rm;

    trigger OnRun()
    begin
    end;

    var
        AZSetup: Record "AZ Setup";
        AZSetupRead: Boolean;
        Text000: Label '%1 cannot be less than %2';

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

    [Scope('Internal')]
    procedure CreateRemainingPeriodInvoice(SkipDialog: Boolean; ConfirmationText: Text; InvFrom: Date; InvTo: Date): Boolean
    begin
        if SkipDialog then
            exit(true);

        exit(Confirm(ConfirmationText, true, InvFrom, InvTo));
    end;

    [Scope('Internal')]
    procedure SkipServicePeriodCheck(var ServiceContractHeader: Record "Service Contract Header"): Boolean
    begin
        GetAZSetup;
        if AZSetup."Check Service Period" then
            ServiceContractHeader.TestField("Service Period");
    end;

    [Scope('Internal')]
    procedure SetServLedgEntryValues(var ServLedgerEntry: Record "Service Ledger Entry"; ContractType: Integer; ContractNo: Code[20]; LineNo: Integer)
    var
        ServiceContractLine: Record "Service Contract Line";
    begin
        if ServiceContractLine.Get(ContractType, ContractNo, LineNo) then begin
            ServLedgerEntry."SCL Invoiced to Date" := ServiceContractLine."Invoiced to Date";
            ServLedgerEntry."SCL Quantity" := ServiceContractLine.Quantity;
            ServLedgerEntry."SCL Line No." := ServiceContractLine."Line No.";
            ServLedgerEntry."SCL New Line" := ServiceContractLine."New Line";
        end;
    end;

    [Scope('Internal')]
    procedure SetContractDatesOnServHeader(var ServiceContractHeader: Record "Service Contract Header"; var ServiceHeader: Record "Service Header")
    begin
        ServiceHeader."Serv. Contr. Next Inv. Date" := ServiceContractHeader."Next Invoice Date";
        ServiceHeader."Serv. Contr. Last Inv. Date" := ServiceContractHeader."Last Invoice Date";
        ServiceHeader."SC Next Inv. Period Start" := ServiceContractHeader."Next Invoice Period Start";
        ServiceHeader."SC Next Inv. Period End" := ServiceContractHeader."Next Invoice Period End";
        ServiceHeader."SC Last Inv. Period End" := ServiceContractHeader."Last Invoice Period End";
    end;

    [Scope('Internal')]
    procedure SetItem(var ServiceLine: Record "Service Line"; ServiceLedgerEntry: Record "Service Ledger Entry")
    begin
        ServiceLine.Type := ServiceLine.Type::Item;
        ServiceLine.Validate("No.", ServiceLedgerEntry."Item No. (Serviced)");
    end;

    [Scope('Internal')]
    procedure SetServiceLineValues(var ServiceLine: Record "Service Line"; InvFrom: Date; InvTo: Date; ServiceLedgerEntry: Record "Service Ledger Entry")
    begin
        ServiceLine."Serv. Contract Line From Date" := InvFrom;
        ServiceLine."Serv. Contract Line To Date" := InvTo;
        ServiceLine."SCL Invoiced to Date" := ServiceLedgerEntry."SCL Invoiced to Date";
        ServiceLine."SCL Quantity" := ServiceLedgerEntry."SCL Quantity";
        ServiceLine."SCL Line No." := ServiceLedgerEntry."SCL Line No.";
        ServiceLine."SCL New Line" := ServiceLedgerEntry."SCL New Line";
    end;

    [Scope('Internal')]
    procedure SetNextInvDate(var NextInvDate: Date; ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
    begin
        if ServiceContractLine."New Line" then
            NextInvDate := ServiceContractLine."Starting Date";
    end;

    [Scope('Internal')]
    procedure SetInvFrom(var InvFrom: Date; ServiceContractLine: Record "Service Contract Line")
    begin
        if ServiceContractLine."New Line" then
            InvFrom := ServiceContractLine."Starting Date";
    end;

    [Scope('Internal')]
    procedure SetNewLineOnServiceContractLines(var ServiceContractLine: Record "Service Contract Line"; ServiceContractHeader: Record "Service Contract Header")
    begin
        ServiceContractLine.ModifyAll("New Line", false, true);
    end;

    [Scope('Internal')]
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

    local procedure GetAZSetup()
    begin
        if not AZSetupRead then begin
            AZSetup.Get;
            AZSetupRead := true;
        end;
    end;
}

