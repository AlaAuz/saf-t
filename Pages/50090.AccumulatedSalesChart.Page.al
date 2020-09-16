page 50090 "Accumulated Sales Chart"
{
    Caption = 'Accumulated Sales';
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(StatusText; StatusText)
            {
                Caption = 'Status Text';
                Editable = false;
                ShowCaption = false;
            }
            usercontrol(BusinessChart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                //ALA
                /*
                trigger DataPointClicked(point: DotNet BusinessChartDataPoint)
                begin
                    SetDrillDownIndexes(point);
                    SalesChartMgt.DrillDown(Rec, SalesChartSetup."Chart View"::"Accumulated Sales");
                end;

                trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                begin
                end; */

                trigger AddInReady()
                begin
                    SalesChartMgt.OnOpenPage(SalesChartSetup, SalesChartSetup."Chart View"::"Accumulated Sales");
                    NeedsUpdate := true;
                    UpdateStatus;
                    IsChartAddInReady := true;
                    if IsChartDataReady then
                        UpdateChart;
                end;

                trigger Refresh()
                begin
                    if IsChartDataReady and IsChartAddInReady then begin
                        NeedsUpdate := true;
                        UpdateChart;
                    end;
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DimensionFilter)
            {
                Caption = 'Dimension Filter';
                Image = Dimensions;

                trigger OnAction()
                var
                    DimensionCode: Code[20];
                    DimensionFilter: Text;
                begin
                    RoleCenterMgt.FindDimensionFilter(DimensionCode, DimensionFilter);
                    if DimensionCode = '' then exit;
                    SalesChartSetup.SetDimensionFilter(DimensionCode, DimensionFilter);
                    UpdateStatus;
                end;
            }
            action(ClearFilter)
            {
                Caption = 'Clear Filter';
                Image = ClearFilter;

                trigger OnAction()
                begin
                    SalesChartSetup.SetDimensionFilter('', '');
                    UpdateStatus;
                end;
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    NeedsUpdate := true;
                    UpdateChart;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateChart;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        UpdateChart;
        IsChartDataReady := true;
    end;

    var
        SalesChartSetup: Record "AUZ Sales Chart Setup";
        OldSalesChartSetup: Record "AUZ Sales Chart Setup";
        SalesChartMgt: Codeunit "Sales Chart Management";
        RoleCenterMgt: Codeunit "Role Center Management";
        StatusText: Text;
        NeedsUpdate: Boolean;
        IsChartDataReady: Boolean;
        IsChartAddInReady: Boolean;

    local procedure UpdateChart()
    begin
        if not NeedsUpdate then
            exit;
        if not IsChartAddInReady then
            exit;
        SalesChartMgt.UpdateData(Rec, SalesChartSetup."Chart View"::"Accumulated Sales");
        Update(CurrPage.BusinessChart);
        UpdateStatus;

        NeedsUpdate := false;
    end;

    local procedure UpdateStatus()
    begin
        NeedsUpdate := NeedsUpdate or IsSetupChanged;

        OldSalesChartSetup := SalesChartSetup;

        if NeedsUpdate then
            StatusText := SalesChartSetup.GetCurrentSelectionText;
    end;

    local procedure IsSetupChanged(): Boolean
    begin
        exit(
          (OldSalesChartSetup."Dimension Code" <> SalesChartSetup."Dimension Code") or
          (OldSalesChartSetup."Dimension Filter" <> SalesChartSetup."Dimension Filter") or
          (OldSalesChartSetup."Dimension Filter 2" <> SalesChartSetup."Dimension Filter 2") or
          (OldSalesChartSetup."Dimension Filter 3" <> SalesChartSetup."Dimension Filter 3"));
    end;
}

