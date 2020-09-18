codeunit 50000 "AUZ Sales Chart Mgt."
{
    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        RoleCenterSetup: Record "AUZ Role Center Setup";
        BusChartMapColumn: Record "Business Chart Map";
        BusChartMapMeasure: Record "Business Chart Map";
    begin
        RoleCenterSetup.Get();
        RoleCenterSetup.TestField("Sales Chart Budget Name");
        RoleCenterSetup.TestField("Sales Chart G/L Acc. Filter");

        with BusChartBuf do begin
            Initialize;
            SetXAxis(TurnoverText, "Data Type"::String);

            AddColumns(BusChartBuf);
            AddMeasures(BusChartBuf);

            if FindFirstMeasure(BusChartMapMeasure) then
                repeat
                    if FindFirstColumn(BusChartMapColumn) then
                        repeat
                            SetValue(
                              BusChartMapMeasure.Name,
                              BusChartMapColumn.Index,
                              CalcAmount(
                                RoleCenterSetup,
                                BusChartMapColumn.Index,
                                BusChartMapColumn.Name,
                                BusChartMapMeasure."Value String",
                                BusChartMapMeasure.Name));
                        until not NextColumn(BusChartMapColumn);

                until not NextMeasure(BusChartMapMeasure);
        end;
    end;

    local procedure AddColumns(var BusChartBuf: Record "Business Chart Buffer")
    var
        Date: Record Date;
        Month: Integer;
        "Count": Integer;
    begin
        Month := Date2DMY(GetFirstMonthDate(), 2);

        for Count := 0 to 11 do begin
            BusChartBuf.AddColumn(GetMonthName(Month));
            Month += 1;
            if Month > 12 then
                Month := 1;
        end;
    end;

    local procedure GetFirstMonthDate(): Date
    var
        CalcExpr: Text;
    begin
        exit(DMY2Date(1, 1, Date2DMY(WorkDate, 3)));
    end;

    local procedure GetMonthName(MonthNo: Integer): Text
    var
        Date: Record Date;
    begin
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetRange("Period No.", MonthNo);
        Date.FindFirst();
        exit(CopyStr(Date."Period Name", 1, 3));
    end;

    local procedure AddMeasures(var BusChartBuf: Record "Business Chart Buffer")
    var
        DimensionValue: Record "Dimension Value";
    begin
        with BusChartBuf do begin
            AddMeasure(BudgetText, 'Budget', "Data Type"::Decimal, "Chart Type"::Column);
            AddMeasure(StrSubstNo(ActualText, Date2DMY(WorkDate, 3)), 'Actual', "Data Type"::Decimal, "Chart Type"::Column);
            AddMeasure(StrSubstNo(ActualText, (Date2DMY(WorkDate, 3) - 1)), 'ActualLastYear', "Data Type"::Decimal, "Chart Type"::Column);
        end;
    end;

    procedure CalcAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; MonthNo: Integer; MonthCaption: Text; TypeValue: Text; TypeCaption: Text): Decimal
    var
        Date: Record Date;
        Value: Integer;
    begin
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetRange("Period Start", GetFirstMonthDate());
        Date.FindSet;

        Date.SetRange("Period Start");
        Date.Next(+MonthNo);

        case TypeValue of
            'Budget':
                exit(CalcBudgetAmount(RoleCenterSetup, Date));
            'Actual':
                exit(CalcActualAmount(RoleCenterSetup, Date));
            'ActualLastYear':
                begin
                    Date.Next(-12);
                    exit(CalcActualAmount(RoleCenterSetup, Date));
                end;
        end;
    end;

    local procedure CalcBudgetAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; var Date: Record Date): Decimal
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetEntry.SetCurrentKey("Budget Name", "G/L Account No.", Date);
        GLBudgetEntry.SetRange("Budget Name", RoleCenterSetup."Sales Chart Budget Name");
        GLBudgetEntry.SetFilter("G/L Account No.", RoleCenterSetup."Sales Chart G/L Acc. Filter");
        GLBudgetEntry.SetRange(Date, Date."Period Start", Date."Period End");
        GLBudgetEntry.CalcSums(Amount);
        exit(-GLBudgetEntry.Amount);
    end;

    local procedure CalcActualAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; var Date: Record Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetFilter("G/L Account No.", RoleCenterSetup."Sales Chart G/L Acc. Filter");
        GLEntry.SetRange("Posting Date", Date."Period Start", Date."Period End");
        GLEntry.CalcSums(Amount);
        exit(-GLEntry.Amount);
    end;

    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        Value: Variant;
    begin
        BusChartBuf.GetXValue(BusChartBuf."Drill-Down X Index", Value);
    end;

    var
        TurnoverText: Label 'Turnover';
        BudgetText: Label 'Budget';
        ActualText: Label 'Actual %1';
}