page 50002 "AUZ Sales Chart"
{
    Caption = 'Sales Chart';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            label(StatusText)
            {
                Caption = 'Status Text';
                ShowCaption = false;
                ApplicationArea = All;
            }

            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;
                trigger DataPointClicked(point: JsonObject)
                var
                    TmpJsonToken: JsonToken;
                    MeasuresText: Text;
                    XValText: Text;
                    YValText: Text;
                    YVal: Decimal;

                begin
                    MeasuresText := GetFirstJsonArrayKey(point, 'Measures');
                    XValText := SelectJsonToken(point, 'XValueString');
                    YValText := GetFirstJsonArrayKey(point, 'YValues');
                    Evaluate(YVal, YValText);

                    SetDrillDownIndexesByCoordinate(MeasuresText, XValText, YVal);
                    SalesChartMgt.DrillDown(Rec);
                end;

                trigger AddInReady()
                begin
                    NeedsUpdate := true;
                    IsChartAddInReady := true;
                    if IsChartDataReady then
                        UpdateChart();
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    NeedsUpdate := true;
                    UpdateChart();
                end;
            }
        }
    }

    local procedure UpdateChart()
    var
        SalesChartMgt: Codeunit "AUZ Sales Chart Mgt.";
    begin
        if not NeedsUpdate then
            exit;
        if not IsChartAddInReady then
            exit;
        SalesChartMgt.UpdateData(Rec);
        Update(CurrPage.BusinessChart);

        NeedsUpdate := false;
    end;

    local procedure GetFirstJsonArrayKey(ObjectJson: JsonObject; TextKey: Text) ReturnText: Text
    var
        TempToken: JsonToken;
        ReturnToken: JsonToken;
    begin
        if ObjectJson.Get(TextKey, TempToken) then begin
            TempToken.AsArray().Get(0, ReturnToken);
            ReturnText := ReturnToken.AsValue().AsText();
        end;
    end;

    local procedure SelectJsonToken(JsonObject: JsonObject; Path: text): text
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            exit('');
        if JsonToken.AsValue.IsNull() then
            exit('');
        exit(JsonToken.AsValue.AsText());
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateChart();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        UpdateChart();
        IsChartDataReady := true;
    end;

    var
        SalesChartMgt: Codeunit "AUZ Sales Chart Mgt.";
        NeedsUpdate: Boolean;
        IsChartDataReady: Boolean;
        IsChartAddInReady: Boolean;
}