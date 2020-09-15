report 90001 "Suggest Case Job Jnl. Lines"
{
    Caption = 'Suggest Job Jnl. Lines';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Alternativer)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                    }
                    field(ResourceNoFilter; ResourceNoFilter)
                    {
                        Caption = 'Resource No. Filter';
                        TableRelation = Resource;
                    }
                    field(JobNoFilter; JobNoFilter)
                    {
                        Caption = 'Job No. Filter';
                        TableRelation = Job;
                    }
                    field(JobTaskNoFilter; JobTaskNoFilter)
                    {
                        Caption = 'Job Task No. Filter';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            JobTask: Record "Job Task";
                        begin
                            JobTask.FilterGroup(2);
                            if JobNoFilter <> '' then
                                JobTask.SetFilter("Job No.", JobNoFilter);
                            JobTask.FilterGroup(0);
                            if PAGE.RunModal(PAGE::"Job Task List", JobTask) = ACTION::LookupOK then
                                JobTask.TestField("Job Task Type", JobTask."Job Task Type"::Posting);
                            JobTaskNoFilter := JobTask."Job Task No.";
                        end;
                    }
                    field(TransferredYesNo; TransferredYesNo)
                    {
                        Caption = 'Transferred, not posted';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        NextDocNo: Code[20];
        LineNo: Integer;
        QtyToPost: Decimal;
        TempCaseHours: Record "Case Line" temporary;
        CaseHours: Record "Case Line";
    begin
        DateFilter := TimeSheetMgt.GetDateFilter(StartingDate, EndingDate);
        FillTimeSheetLineBuffer(TempCaseHours);
        ;

        TempCaseHours.Reset;
        TempCaseHours.SetCurrentKey("Job No.", "Job Task No.", "Resource No.");
        TempCaseHours.SetAutoCalcFields("Case Description");
        if TempCaseHours.FindSet then begin
            JobJnlLine.LockTable;
            JobJnlTemplate.Get(JobJnlLine."Journal Template Name");
            JobJnlBatch.Get(JobJnlLine."Journal Template Name", JobJnlLine."Journal Batch Name");
            if JobJnlBatch."No. Series" = '' then
                NextDocNo := ''
            else
                NextDocNo := NoSeriesMgt.GetNextNo(JobJnlBatch."No. Series", TempCaseHours.Date, false);

            JobJnlLine.SetRange("Journal Template Name", JobJnlLine."Journal Template Name");
            JobJnlLine.SetRange("Journal Batch Name", JobJnlLine."Journal Batch Name");
            if JobJnlLine.FindLast then;
            LineNo := JobJnlLine."Line No.";

            repeat
                QtyToPost := TempCaseHours.Quantity;
                if QtyToPost <> 0 then begin
                    JobJnlLine.Init;
                    LineNo := LineNo + 10000;
                    JobJnlLine."Line No." := LineNo;
                    JobJnlLine."Case No." := TempCaseHours."Case No.";
                    JobJnlLine."Case Hour Line No." := TempCaseHours."Line No.";
                    JobJnlLine."Case Description" := TempCaseHours."Case Description";

                    JobJnlLine.Validate("Job No.", TempCaseHours."Job No.");
                    if TempCaseHours."Job Task No." <> '' then
                        JobJnlLine.Validate("Job Task No.", TempCaseHours."Job Task No.");
                    JobJnlLine.Validate(Type, JobJnlLine.Type::Resource);
                    JobJnlLine.Validate("No.", TempCaseHours."Resource No.");
                    JobJnlLine.Validate("Work Type Code", TempCaseHours."Work Type");
                    JobJnlLine.Validate("Posting Date", TempCaseHours.Date);
                    JobJnlLine."Document No." := NextDocNo;
                    NextDocNo := IncStr(NextDocNo);
                    JobJnlLine."Posting No. Series" := JobJnlBatch."Posting No. Series";
                    TempCaseHours.CalcFields(Description);
                    JobJnlLine.Description := TempCaseHours.Description;
                    JobJnlLine.Validate(Quantity, QtyToPost);
                    JobJnlLine.Validate(Chargeable, TempCaseHours.Chargeable);
                    JobJnlLine."Source Code" := JobJnlTemplate."Source Code";
                    JobJnlLine."Reason Code" := JobJnlBatch."Reason Code";
                    if JobJnlLine.Chargeable then
                        JobJnlLine."Line Type" := JobJnlLine."Line Type"::Billable;
                    JobJnlLine.Insert;

                    CaseHours.Get(TempCaseHours."Case No.", TempCaseHours."Line No.");
                    CaseHours.Transferred := true;
                    CaseHours.Modify;
                end;
            until TempCaseHours.Next = 0;
        end;
    end;

    var
        JobJnlLine: Record "Job Journal Line";
        JobJnlBatch: Record "Job Journal Batch";
        JobJnlTemplate: Record "Job Journal Template";
        ResourceNoFilter: Code[1024];
        JobNoFilter: Code[1024];
        JobTaskNoFilter: Code[1024];
        StartingDate: Date;
        EndingDate: Date;
        DateFilter: Text[30];
        TransferredYesNo: Boolean;


    procedure SetJobJnlLine(NewJobJnlLine: Record "Job Journal Line")
    begin
        JobJnlLine := NewJobJnlLine;
    end;


    procedure InitParameters(NewJobJnlLine: Record "Job Journal Line"; NewResourceNoFilter: Code[1024]; NewJobNoFilter: Code[1024]; NewJobTaskNoFilter: Code[1024]; NewStartingDate: Date; NewEndingDate: Date; NewTransferred: Boolean)
    begin
        JobJnlLine := NewJobJnlLine;
        ResourceNoFilter := NewResourceNoFilter;
        JobNoFilter := NewJobNoFilter;
        JobTaskNoFilter := NewJobTaskNoFilter;
        StartingDate := NewStartingDate;
        EndingDate := NewEndingDate;
        TransferredYesNo := NewTransferred;
    end;

    local procedure FillTimeSheetLineBuffer(var TempCaseHours: Record "Case Line" temporary)
    var
        CaseHours: Record "Case Line";
    begin
        TempCaseHours.Reset;
        TempCaseHours.DeleteAll;

        CaseHours.SetCurrentKey("Job No.", "Job Task No.", "Resource No.");

        if JobNoFilter <> '' then
            CaseHours.SetFilter("Job No.", JobNoFilter);
        if JobTaskNoFilter <> '' then
            CaseHours.SetFilter("Job Task No.", JobTaskNoFilter);
        if ResourceNoFilter <> '' then
            CaseHours.SetFilter("Resource No.", ResourceNoFilter);
        if DateFilter <> '' then
            CaseHours.SetFilter(Date, DateFilter);

        CaseHours.SetRange(Transferred, TransferredYesNo);
        CaseHours.SetRange(Posted, false);

        if CaseHours.FindSet then
            repeat
                TempCaseHours := CaseHours;
                TempCaseHours.Insert;
            until CaseHours.Next = 0;
    end;
}

