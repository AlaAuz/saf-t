codeunit 50001 "AUZ Sales Chart Management"
{
    procedure OnOpenPage(var SalesChartSetup: Record "AUZ Sales Chart Setup"; ChartView: Option Sales,"Accumulated Sales")
    begin
        with SalesChartSetup do
            if not Get(UserId, ChartView) then begin
                "User ID" := UserId;
                "Chart View" := ChartView;
                Insert;
            end;
    end;


    procedure UpdateData(var BusChartBuf: Record "Business Chart Buffer"; ChartView: Option Sales,"Accumulated Sales")
    var
        RoleCenterSetup: Record "AUZ Role Center Setup";
        SalesChartSetup: Record "AUZ Sales Chart Setup";
        BusChartMapColumn: Record "Business Chart Map";
        BusChartMapMeasure: Record "Business Chart Map";
    begin
        RoleCenterSetup.Get;
        SalesChartSetup.Get(UserId, ChartView);

        with BusChartBuf do begin
            Initialize;
            SetXAxis(Text001, "Data Type"::String);

            AddColumns(BusChartBuf);
            AddMeasures(BusChartBuf, ChartView);

            if FindFirstMeasure(BusChartMapMeasure) then
                repeat
                    if FindFirstColumn(BusChartMapColumn) then
                        repeat
                            SetValue(
                              BusChartMapMeasure.Name,
                              BusChartMapColumn.Index,
                              CalcAmount(
                                RoleCenterSetup,
                                SalesChartSetup,
                                BusChartMapColumn.Index,
                                BusChartMapMeasure."Value String",
                                ChartView));
                        until not NextColumn(BusChartMapColumn);

                until not NextMeasure(BusChartMapMeasure);
        end;
    end;

    procedure DrillDown(var BusChartBuf: Record "Business Chart Buffer"; ChartView: Option Sales,"Accumulated Sales")
    var
        RoleCenterSetup: Record "AUZ Role Center Setup";
        SalesChartSetup: Record "AUZ Sales Chart Setup";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLEntry: Record "G/L Entry";
        FromDate: Date;
        ToDate: Date;
        Month: Integer;
    begin
        RoleCenterSetup.Get;
        SalesChartSetup.Get(UserId, ChartView);

        Month := BusChartBuf."Drill-Down X Index";

        MeasureType := BusChartBuf."Drill-Down Measure Index";
        ColumnIndex2Date(FromDate, ToDate, Month, MeasureType = MeasureType::"Sales Last Year", ChartView);

        case MeasureType of
            MeasureType::Budget:
                begin
                    SetBudgetFilter(GLBudgetEntry, RoleCenterSetup, SalesChartSetup, FromDate, ToDate);
                    PAGE.RunModal(0, GLBudgetEntry);
                end;
            MeasureType::Sales, MeasureType::"Sales Last Year":
                begin
                    SetActualFilter(GLEntry, RoleCenterSetup, SalesChartSetup, FromDate, ToDate);
                    PAGE.RunModal(0, GLEntry);
                end;
        end;
    end;

    local procedure AddColumns(var BusChartBuf: Record "Business Chart Buffer")
    var
        Period: Record Date;
        FromDate: Date;
        ToDate: Date;
    begin
        BusChartBuf."Period Length" := BusChartBuf."Period Length"::Month;
        FromDate := CalcDate('<-CY>', WorkDate);
        ToDate := CalcDate('<11M>', FromDate);
        Period.SetRange("Period Type", Period."Period Type"::Month);
        Period.SetRange("Period Start", FromDate, ToDate);
        Period.FindSet;
        repeat
            BusChartBuf.AddColumn(CopyStr(Period."Period Name", 1, 3));
        until Period.Next = 0;
    end;

    local procedure AddMeasures(var BusChartBuf: Record "Business Chart Buffer"; ChartView: Option Sales,"Accumulated Sales")
    var
        Year: Integer;
        LastYear: Integer;
        ChartType: Integer;
    begin
        Year := Date2DMY(WorkDate, 3);
        LastYear := Year - 1;

        with BusChartBuf do begin
            case ChartView of
                ChartView::Sales:
                    ChartType := "Chart Type"::Column;
                ChartView::"Accumulated Sales":
                    ChartType := "Chart Type"::Line;
                else
                    exit;
            end;
            AddMeasure(BudgetText, MeasureType::Budget, "Data Type"::Decimal, ChartType);
            AddMeasure(StrSubstNo(ActualText, Year), MeasureType::Sales, "Data Type"::Decimal, ChartType);
            AddMeasure(StrSubstNo(ActualText, LastYear), MeasureType::"Sales Last Year", "Data Type"::Decimal, ChartType);
        end;
    end;

    procedure CalcAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; SalesChartSetup: Record "AUZ Sales Chart Setup"; Month: Integer; MType: Text; ChartView: Option Sales,"Accumulated Sales"): Decimal
    var
        FromDate: Date;
        ToDate: Date;
    begin
        Evaluate(MeasureType, MType);
        ColumnIndex2Date(FromDate, ToDate, Month, MeasureType = MeasureType::"Sales Last Year", ChartView);

        case MeasureType of
            MeasureType::Budget:
                exit(CalcBudgetAmount(RoleCenterSetup, SalesChartSetup, FromDate, ToDate));
            MeasureType::Sales, MeasureType::"Sales Last Year":
                exit(CalcActualAmount(RoleCenterSetup, SalesChartSetup, FromDate, ToDate));
        end;
    end;

    local procedure CalcBudgetAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; SalesChartSetup: Record "AUZ Sales Chart Setup"; FromDate: Date; ToDate: Date): Decimal
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        SetBudgetFilter(GLBudgetEntry, RoleCenterSetup, SalesChartSetup, FromDate, ToDate);
        GLBudgetEntry.CalcSums(Amount);
        exit(-GLBudgetEntry.Amount);
    end;

    local procedure SetBudgetFilter(var GLBudgetEntry: Record "G/L Budget Entry"; RoleCenterSetup: Record "AUZ Role Center Setup"; SalesChartSetup: Record "AUZ Sales Chart Setup"; FromDate: Date; ToDate: Date)
    begin
        GLBudgetEntry.SetCurrentKey("Budget Name", "G/L Account No.", Date);
        GLBudgetEntry.SetRange("Budget Name", RoleCenterSetup."Sales Chart Budget Name");
        GLBudgetEntry.SetFilter("G/L Account No.", RoleCenterSetup."Sales Chart G/L Acc. Filter");
        GLBudgetEntry.SetRange(Date, FromDate, ToDate);

        GetGLSetup;
        case SalesChartSetup."Dimension Code" of
            GLSetup."Global Dimension 1 Code":
                GLBudgetEntry.SetFilter("Global Dimension 1 Code", SalesChartSetup.GetDimensionFilter);
            GLSetup."Global Dimension 2 Code":
                GLBudgetEntry.SetFilter("Global Dimension 2 Code", SalesChartSetup.GetDimensionFilter);
            else begin
                    GLBudgetEntry.SetRange("Global Dimension 1 Code");
                    GLBudgetEntry.SetRange("Global Dimension 2 Code");
                end;
        end;
    end;

    local procedure CalcActualAmount(RoleCenterSetup: Record "AUZ Role Center Setup"; SalesChartSetup: Record "AUZ Sales Chart Setup"; FromDate: Date; ToDate: Date): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        SetActualFilter(GLEntry, RoleCenterSetup, SalesChartSetup, FromDate, ToDate);
        GLEntry.CalcSums(Amount);
        exit(-GLEntry.Amount);
    end;

    local procedure SetActualFilter(var GLEntry: Record "G/L Entry"; RoleCenterSetup: Record "AUZ Role Center Setup"; SalesChartSetup: Record "AUZ Sales Chart Setup"; FromDate: Date; ToDate: Date)
    begin
        GLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
        GLEntry.SetFilter("G/L Account No.", RoleCenterSetup."Sales Chart G/L Acc. Filter");
        GLEntry.SetRange("Posting Date", FromDate, ToDate);

        GetGLSetup;
        case SalesChartSetup."Dimension Code" of
            GLSetup."Global Dimension 1 Code":
                GLEntry.SetFilter("Global Dimension 1 Code", SalesChartSetup.GetDimensionFilter);
            GLSetup."Global Dimension 2 Code":
                GLEntry.SetFilter("Global Dimension 2 Code", SalesChartSetup.GetDimensionFilter);
            else begin
                    GLEntry.SetRange("Global Dimension 1 Code");
                    GLEntry.SetRange("Global Dimension 2 Code");
                end;
        end;
    end;

    procedure ColumnIndex2Date(var FromDate: Date; var ToDate: Date; ColumnIndex: Integer; LastYear: Boolean; ChartView: Option Sales,"Accumulated Sales")
    var
        SourceDate: Date;
    begin
        SourceDate := WorkDate;
        if LastYear then
            SourceDate := CalcDate('<-1Y>', SourceDate);
        case ChartView of
            ChartView::Sales:
                begin
                    FromDate := CalcDate(StrSubstNo('<%1M>', ColumnIndex), CalcDate('<-CY>', SourceDate));
                    ToDate := CalcDate('<CM>', FromDate);
                end;
            ChartView::"Accumulated Sales":
                begin
                    FromDate := CalcDate('<-CY>', SourceDate);
                    ToDate := CalcDate(StrSubstNo('<CM + %1M>', ColumnIndex), FromDate);
                end;
            else
                exit;
        end;
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then begin
            GLSetup.Get;
            GLSetupRead := true;
        end;
    end;

    var
        Text001: Label 'Turnover';
        GLSetup: Record "General Ledger Setup";
        MeasureType: Option Budget,Sales,"Sales Last Year";
        BudgetText: Label 'Budget';
        ActualText: Label 'Actual %1';
        GLSetupRead: Boolean;
}