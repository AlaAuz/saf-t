codeunit 50010 "AUZ Job Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeInsertSalesLine', '', false, false)]
    local procedure GetJobPlanningLinesOnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        SalesLine.Validate("Shipment Date", JobPlanningLine."Planning Date");
        SalesLine."AUZ Case No." := JobPlanningLine."AUZ Case No.";
        SalesLine."AUZ Case Line No." := JobPlanningLine."AUZ Case Line No.";
        SalesLine."AUZ Case Description" := JobPlanningLine."AUZ Case Description";
        if SalesLine.Type = SalesLine.Type::Resource then
            if SalesLine."No." <> '' then
                SalesLine.Validate("Shortcut Dimension 1 Code", SalesLine."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnAfterCreateSalesLine', '', false, false)]
    local procedure InsertCaseHoursAndExpensesOnafterCreateSalesLine(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; Job: Record Job; var JobPlanningLine: Record "Job Planning Line")
    begin
        if JobPlanningLine."AUZ Case No." <> '' then begin
            InsertCaseHoursText(SalesLine, JobPlanningLine."AUZ Case No.", JobPlanningLine."AUZ Case Line No.");

            InsertCaseExpenses(SalesLine, JobPlanningLine."AUZ Case No.", JobPlanningLine."AUZ Case Line No.");
        end;
    end;

    procedure InsertCaseHoursText(var SalesLine: Record "Sales Line"; CaseNo: Code[20]; CaseHourLineNo: Integer);
    var
        ToSalesLine: Record "Sales Line";
        CaseHoursDescription: Record "AUZ Case Line Description";
        LineSpacing: Integer;
        NextLineNo: Integer;
        MakeUpdateRequired: Boolean;
    begin
        CaseHoursDescription.Reset;
        CaseHoursDescription.SetRange("Case No.", CaseNo);
        CaseHoursDescription.SetRange("Case Line No.", CaseHourLineNo);
        if (CaseHoursDescription.IsEmpty) or (CaseHoursDescription.Count = 1) then
            exit;

        ToSalesLine.Reset;
        ToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        ToSalesLine.SetRange("Document No.", SalesLine."Document No.");
        ToSalesLine := SalesLine;
        if ToSalesLine.Find('>') then begin
            LineSpacing :=
              (ToSalesLine."Line No." - SalesLine."Line No.") div
              (1 + CaseHoursDescription.Count);
            if LineSpacing = 0 then
                Error(Text000);
        end else
            LineSpacing := 10000;

        NextLineNo := SalesLine."Line No." + LineSpacing;

        if CaseHoursDescription.Find('-') then begin
            CaseHoursDescription.Next;
            repeat
                ToSalesLine.Init;
                ToSalesLine."Document Type" := SalesLine."Document Type";
                ToSalesLine."Document No." := SalesLine."Document No.";
                ToSalesLine."Line No." := NextLineNo;
                NextLineNo := NextLineNo + LineSpacing;
                ToSalesLine.Description := CaseHoursDescription.Description;
                ToSalesLine."Attached to Line No." := SalesLine."Line No.";
                ToSalesLine.Insert;
            until CaseHoursDescription.Next = 0;
            MakeUpdateRequired := true;
        end;
    end;

    procedure InsertCaseExpenses(var SalesLine: Record "Sales Line"; CaseNo: Code[20]; CaseHourLineNo: Integer);
    VAR
        ToSalesLine: Record "Sales Line";
        CaseHoursExpenses: Record "AUZ Case Line Expense";
        ExpenseCode: Record "AUZ Expense Code";
        LineSpacing: Integer;
        NextLineNo: Integer;
    BEGIN
        CaseHoursExpenses.Reset;
        CaseHoursExpenses.SetRange("Case No.", CaseNo);
        CaseHoursExpenses.SetRange("Case Line No.", CaseHourLineNo);
        CaseHoursExpenses.SetRange(Posted, false);

        if (CaseHoursExpenses.IsEmpty) then
            exit;

        ToSalesLine.Reset;
        ToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        ToSalesLine.SetRange("Document No.", SalesLine."Document No.");
        ToSalesLine := SalesLine;
        if ToSalesLine.Find('>') then begin
            LineSpacing :=
              (ToSalesLine."Line No." - SalesLine."Line No.") div
              (1 + CaseHoursExpenses.Count);
            if LineSpacing = 0 then
                Error(Text000);
        end else
            LineSpacing := 10000;

        NextLineNo := SalesLine."Line No." + LineSpacing;

        if CaseHoursExpenses.Find('-') then begin
            repeat
                ToSalesLine.Init;
                ToSalesLine."Document Type" := SalesLine."Document Type";
                ToSalesLine."Document No." := SalesLine."Document No.";
                ToSalesLine."Line No." := NextLineNo;
                ToSalesLine.Validate(Type, ToSalesLine.Type::"G/L Account");
                ExpenseCode.Get(CaseHoursExpenses."Expense Code");
                ToSalesLine.Validate("No.", ExpenseCode."G/L Account No.");
                NextLineNo := NextLineNo + LineSpacing;
                ToSalesLine.Description := '- ' + CaseHoursExpenses.Description;
                ToSalesLine.Validate("Unit of Measure Code", CaseHoursExpenses."Unit of Measure Code");
                ToSalesLine.Validate(Quantity, CaseHoursExpenses.Quantity);
                ToSalesLine.Validate("Unit Price", CaseHoursExpenses.Price);
                ToSalesLine."AUZ Case No." := CaseNo;
                ToSalesLine."AUZ Case Line No." := CaseHourLineNo;
                ToSalesLine."AUZ Expense Line No." := CaseHoursExpenses."Line No.";
                ToSalesLine."Shipment Date" := SalesLine."Shipment Date";
                ToSalesLine.Validate("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
                ToSalesLine.Validate("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                ToSalesLine.Insert;
            until CaseHoursExpenses.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlLineToLedgEntry', '', false, false)]
    local procedure GetJobJournalLinesOnAfterFromJnlLineToLedgEntry(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    begin
        JobLedgerEntry."AUZ Case No." := JobJournalLine."AUZ Case No.";
        JobLedgerEntry."AUZ Case Line No." := JobJournalLine."AUZ Case Line No.";
        JobLedgerEntry."AUZ Case Description" := JobJournalLine."AUZ Case Description";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJnlToPlanningLine', '', false, false)]
    local procedure GetJobJournalLinesOnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; JobJournalLine: Record "Job Journal Line")
    begin
        JobPlanningLine."AUZ Case No." := JobJournalLine."AUZ Case No.";
        JobPlanningLine."AUZ Case Line No." := JobJournalLine."AUZ Case Line No.";
        JobPlanningLine."AUZ Case Description" := JobJournalLine."AUZ Case Description";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Transfer Line", 'OnAfterFromJobLedgEntryToPlanningLine', '', false, false)]
    local procedure GetJobJournalLinesOnAfterFromJobLedgEntryToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; JobLedgEntry: Record "Job Ledger Entry")
    begin
        JobPlanningLine."AUZ Case No." := JobLedgEntry."AUZ Case No.";
        JobPlanningLine."AUZ Case Line No." := JobLedgEntry."AUZ Case Line No.";
        JobPlanningLine."AUZ Case Description" := JobLedgEntry."AUZ Case Description";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnBeforeJobLedgEntryInsert', '', false, false)]
    local procedure SetCaseLinePostedOnBeforeJobLedgEntryInsert(var JobLedgerEntry: Record "Job Ledger Entry"; JobJournalLine: Record "Job Journal Line")
    var
        CaseLine: Record "AUZ Case Line";
    begin
        if JobLedgerEntry."AUZ Case No." <> '' then begin
            CaseLine.Get(JobLedgerEntry."AUZ Case No.", JobLedgerEntry."AUZ Case Line No.");
            CaseLine.Posted := true;
            CaseLine.Modify;
        end;
    end;

    var
        Text000: Label 'There is not enough space to insert extended text lines.';
}