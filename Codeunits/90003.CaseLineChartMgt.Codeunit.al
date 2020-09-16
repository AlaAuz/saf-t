codeunit 90003 "Case Line Chart Mgt."
{
    // TODO:
    // - Lage knapper for akkumulert.
    // - Nullstille dag, uke.. ved akkumulert. (kun velge en), bruk i koden under for å vise hver dag, hver uke..
    // - Visningstekst for akkumuert.
    // - Ikke total når akkululert


    trigger OnRun()
    begin
    end;

    var
        ResourceTxt: Label 'Resource';
        TodayTxt: Label 'Today';
        ThisWeekTxt: Label 'This Week';
        ThisQuarterTxt: Label 'This Quarter';
        ThisMonthTxt: Label 'This Month';
        ThisYearTxt: Label 'This Year';
        TotalTxt: Label 'Total';
        CaseSetup: Record "AUZ Case Setup";
        PeriodType: Option Day,Week,Month,Quarter,Year;


    procedure OnOpenPage(var CaseHoursChartSetup: Record "AUZ Case Line Chart Setup")
    begin
        with CaseHoursChartSetup do
            if not Get(UserId) then begin
                "User ID" := UserId;
                Insert;
            end;
    end;


    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer")
    var
        CaseHoursChartSetup: Record "AUZ Case Line Chart Setup";
        BusChartMapColumn: Record "Business Chart Map";
        BusChartMapMeasure: Record "Business Chart Map";
        ResourceNo: Code[20];
        PType: Integer;
        PDate: Date;
    begin
        CaseSetup.Get;
        CaseHoursChartSetup.Get(UserId);

        with BusChartBuf do begin
            Initialize;
            SetXAxis(ResourceTxt, "Data Type"::String);

            AddColumns(BusChartBuf, CaseHoursChartSetup);
            AddMeasures(BusChartBuf, CaseHoursChartSetup);

            if FindFirstMeasure(BusChartMapMeasure) then
                repeat
                    if FindFirstColumn(BusChartMapColumn) then
                        repeat
                            SetValue(
                              BusChartMapMeasure.Name,
                              BusChartMapColumn.Index,
                              CalcQuantity(
                                CaseHoursChartSetup,
                                BusChartMapMeasure.Index,
                                BusChartMapMeasure.Name,
                                BusChartMapColumn.Name,
                                BusChartMapColumn.GetValueAsDate));
                        until not NextColumn(BusChartMapColumn);

                until not NextMeasure(BusChartMapMeasure);
        end;
    end;

    local procedure AddColumns(var BusChartBuf: Record "Business Chart Buffer"; CaseHoursChartSetup: Record "AUZ Case Line Chart Setup")
    var
        UserSetup: Record "User Setup";
        CaseHoursChartSetup2: Record "AUZ Case Line Chart Setup";
        Period: Record Date;
    begin
        if CaseHoursChartSetup.Type in [CaseHoursChartSetup.Type::Total, CaseHoursChartSetup.Type::Pie] then begin
            UserSetup.SetFilter("AUZ Resource No.", '<>%1', '');
            if UserSetup.FindSet then
                repeat
                    if CaseHoursChartSetup2.Get(UserSetup."User ID") and CaseHoursChartSetup2."Show in Chart" then
                        BusChartBuf.AddColumn(UserSetup."AUZ Resource No.");
                until UserSetup.Next = 0;
        end else begin
            if CaseHoursChartSetup.Day then
                BusChartBuf."Period Length" := BusChartBuf."Period Length"::Day;
            if CaseHoursChartSetup.Week then
                BusChartBuf."Period Length" := BusChartBuf."Period Length"::Week;
            if CaseHoursChartSetup.Month then
                BusChartBuf."Period Length" := BusChartBuf."Period Length"::Month;
            if CaseHoursChartSetup.Quarter then
                BusChartBuf."Period Length" := BusChartBuf."Period Length"::Quarter;
            if CaseHoursChartSetup.Year then
                BusChartBuf."Period Length" := BusChartBuf."Period Length"::Year;

            BusChartBuf.AddPeriods(CalcDate('<-CY>', WorkDate), CalcDate('<CY>', WorkDate));
        end;
    end;

    local procedure AddMeasures(var BusChartBuf: Record "Business Chart Buffer"; CaseHoursChartSetup: Record "AUZ Case Line Chart Setup")
    var
        UserSetup: Record "User Setup";
        CaseHoursChartSetup2: Record "AUZ Case Line Chart Setup";
        ChartType: Option;
    begin
        if CaseHoursChartSetup.Type in [CaseHoursChartSetup.Type::Total, CaseHoursChartSetup.Type::Pie] then begin
            with BusChartBuf do begin
                if CaseHoursChartSetup.Type = CaseHoursChartSetup.Type::Total then
                    ChartType := "Chart Type"::Column
                else
                    ChartType := "Chart Type"::Doughnut;

                if CaseHoursChartSetup.Day then
                    AddMeasure(TodayTxt, '', "Data Type"::Decimal, ChartType);
                if CaseHoursChartSetup.Week then
                    AddMeasure(ThisWeekTxt, '', "Data Type"::Decimal, ChartType);
                if CaseHoursChartSetup.Month then
                    AddMeasure(ThisMonthTxt, '', "Data Type"::Decimal, ChartType);
                if CaseHoursChartSetup.Quarter then
                    AddMeasure(ThisQuarterTxt, '', "Data Type"::Decimal, ChartType);
                if CaseHoursChartSetup.Year then
                    AddMeasure(ThisYearTxt, '', "Data Type"::Decimal, ChartType);
                if CaseHoursChartSetup.Total then
                    AddMeasure(TotalTxt, '', "Data Type"::Decimal, ChartType);
            end;
        end else begin
            UserSetup.SetFilter("AUZ Resource No.", '<>%1', '');
            if UserSetup.FindSet then
                repeat
                    if CaseHoursChartSetup2.Get(UserSetup."User ID") and CaseHoursChartSetup2."Show in Chart" then
                        with BusChartBuf do
                            BusChartBuf.AddMeasure(UserSetup."AUZ Resource No.", '', "Data Type"::Decimal, "Chart Type"::Line);
                until UserSetup.Next = 0;
        end;
    end;


    procedure CalcQuantity(CaseHourChartSetup: Record "AUZ Case Line Chart Setup"; MIndex: Integer; MName: Text; CName: Text; CDate: Date): Decimal
    var
        CaseHour: Record "AUZ Case Line";
    begin
        if CaseHourChartSetup.Type in [CaseHourChartSetup.Type::Total, CaseHourChartSetup.Type::Pie] then
            SetCaseLineTotalFilter(CaseHourChartSetup, CaseHour, CName, CaseHourChartSetup.Index2PeriodType(MIndex))
        else
            SetCaseLineAccumulatedFilter(CaseHour, MName, CDate);
        CaseHour.CalcSums(Quantity);
        exit(CaseHour.Quantity);
    end;

    local procedure SetCaseLineTotalFilter(CaseHourChartSetup: Record "AUZ Case Line Chart Setup"; var CaseLine: Record "AUZ Case Line"; ResourceNo: Code[20]; PType: Integer)
    var
        Expr: Text[1];
    begin
        SetCaseLineFilter(CaseLine, ResourceNo, CaseHourChartSetup.Chargeable);
        case PType of
            PeriodType::Day:
                begin
                    CaseLine.SetRange(Date, WorkDate);
                    exit;
                end;
            PeriodType::Week:
                Expr := 'W';
            PeriodType::Month:
                Expr := 'M';
            PeriodType::Quarter:
                Expr := 'Q';
            PeriodType::Year:
                Expr := 'Y';
            else
                exit;
        end;
        CaseLine.SetRange(Date, CalcDate(StrSubstNo('<-C%1>', Expr), WorkDate), CalcDate(StrSubstNo('<C%1>', Expr), WorkDate));
    end;

    local procedure SetCaseLineAccumulatedFilter(var CaseLine: Record "AUZ Case Line"; ResourceNo: Code[20]; PDate: Date)
    begin
        SetCaseLineFilter(CaseLine, ResourceNo, 0);
        CaseLine.SetRange(Date, CalcDate('<-CY>', PDate), PDate);
    end;

    local procedure SetCaseLineFilter(var CaseLine: Record "AUZ Case Line"; ResourceNo: Code[20]; Chargeable: Option Yes,No,Both)
    begin
        CaseLine.SetRange("Resource No.", ResourceNo);
        if Chargeable in [Chargeable::Yes, Chargeable::No] then
            CaseLine.SetRange(Chargeable, Chargeable = Chargeable::Yes);
    end;


    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer")
    var
        CaseHoursChartSetup: Record "AUZ Case Line Chart Setup";
        CaseHour: Record "AUZ Case Line";
        Value: Variant;
        ResourceNo: Code[20];
        PDate: Date;
    begin
        CaseSetup.Get;
        CaseHoursChartSetup.Get(UserId);
        if CaseHoursChartSetup.Type in [CaseHoursChartSetup.Type::Total, CaseHoursChartSetup.Type::Pie] then begin
            BusChartBuf.GetXValue(BusChartBuf."Drill-Down X Index", Value);
            ResourceNo := Value;
            SetCaseLineTotalFilter(CaseHoursChartSetup, CaseHour, ResourceNo, CaseHoursChartSetup.Index2PeriodType(BusChartBuf."Drill-Down Measure Index"));
        end else begin
            PDate := BusChartBuf.GetXValueAsDate(BusChartBuf."Drill-Down X Index");
            ResourceNo := BusChartBuf.GetMeasureName(BusChartBuf."Drill-Down Measure Index");
            SetCaseLineAccumulatedFilter(CaseHour, ResourceNo, PDate);
        end;
        PAGE.Run(0, CaseHour);
    end;
}

