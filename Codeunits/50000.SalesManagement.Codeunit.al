codeunit 50000 "AUZ Sales Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeInsertInvoiceLine', '', false, false)]
    local procedure SetCaseHoursPosted(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header")
    var
        CaseHoursExpenses: Record "Case Hour Expense";
    begin
        with SalesLine do begin
            if "Expense Line No." <> 0 then
                if CaseHoursExpenses.Get("Case No.", "Case Hour Line No.", "Expense Line No.") then begin
                    CaseHoursExpenses.Posted := true;
                    CaseHoursExpenses.Modify;
                end;
        end;
    end;
}