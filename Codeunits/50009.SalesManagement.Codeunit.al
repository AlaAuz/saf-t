codeunit 50009 "AUZ Sales Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeInsertInvoiceLine', '', false, false)]
    local procedure SetCaseHoursPosted(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header")
    var
        CaseLineExpenses: Record "AUZ Case Line Expense";
    begin
        with SalesLine do begin
            if "AUZ Expense Line No." <> 0 then
                if CaseLineExpenses.Get("AUZ Case No.", "AUZ Case Line No.", "AUZ Expense Line No.") then begin
                    CaseLineExpenses.Posted := true;
                    CaseLineExpenses.Modify;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeTestJobPlanningLine', '', false, false)]
    local procedure OnBeforeTestJobPlanningLineIsHandled(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; CallingFieldNo: Integer)
    begin
       IsHandled := true;
    end;
}