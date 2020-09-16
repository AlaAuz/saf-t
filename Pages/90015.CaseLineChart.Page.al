page 90015 "Case Line Chart"
{
    Caption = 'Case Registrations';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(content)
        {
            field(LastWinText; LastWinText)
            {
                Editable = false;
                ShowCaption = false;
                Style = Favorable;
                StyleExpr = TRUE;
            }
            field(YourWinText; YourWinText)
            {
                Editable = false;
                ShowCaption = false;
            }
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
                    CaseHoursChartMgt.DrillDown(Rec);
                end;

                trigger DataPointDoubleClicked(point: DotNet BusinessChartDataPoint)
                begin
                end; */

                trigger AddInReady()
                begin
                    CaseHoursChartMgt.OnOpenPage(CaseHoursChartSetup);
                    UpdateStatus;
                    NeedsUpdate := true;
                    IsChartAddInReady := true;
                    if IsChartDataReady then
                        UpdateChart;
                end;

                trigger Refresh()
                begin
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Type)
            {
                Caption = 'Type';
                Image = SelectChart;
                action(Default)
                {
                    Caption = 'Default';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetDefault;
                        UpdateChart;
                    end;
                }
                action(Pie)
                {
                    Caption = 'Doughnut';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetPie;
                        UpdateChart;
                    end;
                }
            }
            group(Periode)
            {
                Caption = 'Period';
                Image = Period;
                action(Dag)
                {
                    Caption = 'Day';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetDay(not CaseHoursChartSetup.Day);
                        UpdateChart;
                    end;
                }
                action(Uke)
                {
                    Caption = 'Week';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetWeek(not CaseHoursChartSetup.Week);
                        UpdateChart;
                    end;
                }
                action("Måned")
                {
                    Caption = 'Month';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetMonth(not CaseHoursChartSetup.Month);
                        UpdateChart;
                    end;
                }
                action(Kvartal)
                {
                    Caption = 'Quarter';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetQuarter(not CaseHoursChartSetup.Quarter);
                        UpdateChart;
                    end;
                }
                action("År")
                {
                    Caption = 'Year';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetYear(not CaseHoursChartSetup.Year);
                        UpdateChart;
                    end;
                }
                action(Totalt)
                {
                    Caption = 'Total';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetTotal(not CaseHoursChartSetup.Total);
                        UpdateChart;
                    end;
                }
            }
            group(Belastbar)
            {
                Caption = 'Chargeable';
                Image = Costs;
                action(Ja)
                {
                    Caption = 'Yes';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetChargeable(CaseHoursChartSetup.Chargeable::Yes);
                        UpdateChart;
                    end;
                }
                action(Nei)
                {
                    Caption = 'No';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetChargeable(CaseHoursChartSetup.Chargeable::No);
                        UpdateChart;
                    end;
                }
                action(Begge)
                {
                    Caption = 'Both';

                    trigger OnAction()
                    begin
                        CaseHoursChartSetup.SetChargeable(CaseHoursChartSetup.Chargeable::Both);
                        UpdateChart;
                    end;
                }
            }
            action(Forny)
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

    trigger OnOpenPage()
    var
        CaseHoursChartSetup2: Record "AUZ Case Line Chart Setup";
        UserSetup: Record "User Setup";
        User: Record User;
    begin
        CaseHoursChartSetup2.UpdateLastMonthsWinner;
        CaseHoursChartSetup2.SetRange("Last Months Winner", true);
        if CaseHoursChartSetup2.FindFirst then begin
            UserSetup.Get(CaseHoursChartSetup2."User ID");
            User.SetCurrentKey("User Name");
            User.SetRange("User Name", UserSetup."User ID");
            User.FindFirst;
            LastWinText := StrSubstNo(Text001, User."Full Name", CaseHoursChartSetup2."Last Quantity Won");
        end;

        if (CaseHoursChartSetup2.Get(UserId)) and (CaseHoursChartSetup2."User ID" <> UserSetup."User ID") then
            if CaseHoursChartSetup2."Last Date Won" <> 0D then
                YourWinText := StrSubstNo(Text002, CaseHoursChartSetup2."Last Date Won", CaseHoursChartSetup2."Last Quantity Won");
    end;

    var
        CaseHoursChartSetup: Record "AUZ Case Line Chart Setup";
        OldCaseHoursChartSetup: Record "AUZ Case Line Chart Setup";
        CaseHoursChartMgt: Codeunit "Case Line Chart Mgt.";
        StatusText: Text;
        LastWinText: Text;
        YourWinText: Text;
        IsChartDataReady: Boolean;
        IsChartAddInReady: Boolean;
        NeedsUpdate: Boolean;
        Text001: Label 'Last month''s winner was %1 with %2 hours.';
        Text002: Label 'Your last win was %1 with %2 hours.';

    local procedure UpdateChart()
    begin
        UpdateStatus;
        if not NeedsUpdate then
            exit;
        if not IsChartAddInReady then
            exit;
        CaseHoursChartMgt.UpdateData(Rec);
        Update(CurrPage.BusinessChart);

        NeedsUpdate := false;
    end;

    local procedure UpdateStatus()
    begin
        NeedsUpdate := NeedsUpdate or IsSetupChanged;

        OldCaseHoursChartSetup := CaseHoursChartSetup;

        if NeedsUpdate then
            StatusText := CaseHoursChartSetup.GetCurrentSelectionText;
    end;

    local procedure IsSetupChanged(): Boolean
    begin
        exit(
          (OldCaseHoursChartSetup.Type <> CaseHoursChartSetup.Type) or
          (OldCaseHoursChartSetup.Chargeable <> CaseHoursChartSetup.Chargeable) or
          (OldCaseHoursChartSetup.Day <> CaseHoursChartSetup.Day) or
          (OldCaseHoursChartSetup.Week <> CaseHoursChartSetup.Week) or
          (OldCaseHoursChartSetup.Month <> CaseHoursChartSetup.Month) or
          (OldCaseHoursChartSetup.Quarter <> CaseHoursChartSetup.Quarter) or
          (OldCaseHoursChartSetup.Year <> CaseHoursChartSetup.Year) or
          (OldCaseHoursChartSetup.Total <> CaseHoursChartSetup.Total));
    end;
}

