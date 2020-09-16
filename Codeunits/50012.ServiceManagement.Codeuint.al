codeunit 50012 "AUZ Service Management"
{
    /* ALA
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service Contract Management", 'OnCreateServiceLedgerEntryOnBeforeServLedgEntryInsert', '', false, false)]
    local procedure MyProcedure(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceContractHeader: Record "Service Contract Header"; ServiceContractLine: Record "Service Contract Line")
    var
        ServContractLine2: Record "Service Contract Line";
    begin
        ServiceContractMgt.SetServLedgEntryValues(ServiceLedgerEntry, ContractType, ContractNo, LineNo);
        if ServiceContractLine.Get(ContractType, ContractNo, LineNo) then
            if ServiceContractLine."New Line" then
                ServiceContractHeader.Prepaid := false;

        //Fortsett i COD5940.Delta
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnAddendumToContractOnAfterSetStartingDate', '', false, false)]
    local procedure test(FromServContractHeader: Record "Service Contract Header"; var StartingDate: Date)
    begin
        //Trenger Event her COD5944

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::SignServContractDoc, 'OnBeforeAddendumToContract', '', false, false)]
    local procedure test1(var ServiceContractHeader: Record "Service Contract Header")
    begin

    end;
*/
}