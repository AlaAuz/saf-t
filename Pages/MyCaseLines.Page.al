page 90009 "My Case Lines"
{
    Caption = 'Hours';
    PageType = CardPart;

    layout
    {
        area(content)
        {
            field("STRSUBSTNO(Text006,ResourceNo,CurrentWeek)"; StrSubstNo(Text006, ResourceNo, CurrentWeek))
            {
                ShowCaption = false;
            }
            field("DateQuantity[1]"; DateQuantity[1])
            {
                CaptionClass = '3,' + DateDescription[1];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(1);
                end;
            }
            field("DateQuantity[2]"; DateQuantity[2])
            {
                CaptionClass = '3,' + DateDescription[2];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(2);
                end;
            }
            field("DateQuantity[3]"; DateQuantity[3])
            {
                CaptionClass = '3,' + DateDescription[3];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(3);
                end;
            }
            field("DateQuantity[4]"; DateQuantity[4])
            {
                CaptionClass = '3,' + DateDescription[4];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(4);
                end;
            }
            field("DateQuantity[5]"; DateQuantity[5])
            {
                CaptionClass = '3,' + DateDescription[5];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(5);
                end;
            }
            field("DateQuantity[6]"; DateQuantity[6])
            {
                CaptionClass = '3,' + DateDescription[6];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(6);
                end;
            }
            field("DateQuantity[7]"; DateQuantity[7])
            {
                CaptionClass = '3,' + DateDescription[7];
                Editable = false;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    ShowCaseHours(7);
                end;
            }
            field(TotalQuantity; TotalQuantity)
            {
                Caption = 'Total';
                Editable = false;
                Style = Strong;
                StyleExpr = TRUE;

                trigger OnDrillDown()
                begin
                    ShowTotalCaseHours();
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PreviousPeriod)
            {
                Caption = 'Previous';
                Image = PreviousSet;
                ShortCutKey = 'Ctrl+PgUp';

                trigger OnAction()
                begin
                    SetPreviousPeriod(Calendar);
                    UpdateData(Calendar);
                end;
            }
            action(NextPeriod)
            {
                Caption = 'Next';
                Image = NextSet;
                ShortCutKey = 'Ctrl+PgDn';

                trigger OnAction()
                begin
                    SetNextPeriod(Calendar);
                    UpdateData(Calendar);
                end;
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;

                trigger OnAction()
                begin
                    SetCurrentPeriod(Calendar);
                    UpdateData(Calendar);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetCurrentPeriod(Calendar);
        UpdateData(Calendar);
    end;

    var
        TimeSheetMgt: Codeunit "Time Sheet Management";
        DateDescription: array[7] of Text[30];
        DateQuantity: array[7] of Text;
        TotalQuantity: Text;
        PresenceQty: Decimal;
        AbsenceQty: Decimal;
        Text001: Label 'Mon,Tue,Wed,Thu,Fri,Sat,Sun';
        Text002: Label '%1 is already defined as Time Sheet Owner User ID for Resource No. %2 with type %3.', Comment = 'User1 is already defined as Resources for Resource No. LIFT with type Machine.';
        Text003: Label 'Time Sheet Header %1 is not found.', Comment = 'Time Sheet Header Archive 10 is not found.';
        Text004: Label 'cannot be greater than %1 %2.', Comment = '%1 - Quantity, %2 - Unit of measure. Example: Quantity cannot be greater than 8 HOUR.';
        Text005: Label 'Time Sheet Header Archive %1 is not found.', Comment = 'Time Sheet Header Archive 10 is not found.';
        Text006: Label '%1 Week %2';
        CurrentWeek: Integer;
        Calendar: Record Date;
        ResourceNo: Code[20];
        DatePeriod: array[7] of Date;


    procedure UpdateData(var Calendar: Record Date)
    var
        CalendarDate: Record Date;
        i: Integer;
        CaseHours: Record "Case Line";
        Cases: Record "Case Header";
        HoursChargeable: Decimal;
        Hours: Decimal;
        TotalQuantityChargeable: Decimal;
        TotalQuantityHours: Decimal;
        UserSetup: Record "User Setup";
    begin
        TotalQuantity := '0';
        TotalQuantityHours := 0;
        TotalQuantityChargeable := 0;

        Clear(DateQuantity);
        Clear(DatePeriod);

        CalendarDate.SetRange("Period Type", Calendar."Period Type"::Date);
        CalendarDate.SetRange("Period Start", Calendar."Period Start", Calendar."Period End");

        UserSetup.Get(UserId);

        CaseHours.SetRange("Resource No.", UserSetup."Resource No.");

        if CalendarDate.FindSet then
            repeat
                i += 1;
                Hours := 0;
                HoursChargeable := 0;
                DateDescription[i] := FormatDate(CalendarDate."Period Start", 0);
                CaseHours.SetFilter(CaseHours.Date, '%1', CalendarDate."Period Start");
                DatePeriod[i] := CalendarDate."Period Start";

                if CaseHours.FindSet then
                    repeat
                        Hours += CaseHours.Quantity;
                        if CaseHours.Chargeable then
                            HoursChargeable += CaseHours.Quantity;
                    until CaseHours.Next = 0;

                DateQuantity[i] := Format(Hours, 0, '<Precision,2:2><Standard Format,0>') + '/' + Format(HoursChargeable, 0, '<Precision,2:2><Standard Format,0>'
                                         + '/' + Format(Hours - HoursChargeable, 0, '<Precision,2:2><Standard Format,0>'));

                TotalQuantityHours += Hours;
                TotalQuantityChargeable += HoursChargeable;
                TotalQuantity := Format(TotalQuantityHours, 0, '<Precision,2:2><Standard Format,0>') + '/' + Format(TotalQuantityChargeable, 0, '<Precision,2:2><Standard Format,0>'
                                         + '/' + Format(TotalQuantityHours - TotalQuantityChargeable, 0, '<Precision,2:2><Standard Format,0>'));

            until CalendarDate.Next = 0;

        CurrentWeek := Calendar."Period No.";
        ResourceNo := UserSetup."Resource No.";

        CurrPage.Update(false);
    end;


    procedure FormatDate(Date: Date; DOWFormatType: Option Full,Short): Text[30]
    begin
        case DOWFormatType of
            DOWFormatType::Full:
                exit(StrSubstNo('%1 %2', Date2DMY(Date, 1), Format(Date, 0, '<Weekday Text>')));
            DOWFormatType::Short:
                exit(StrSubstNo('%1 %2', Date2DMY(Date, 1), SelectStr(Date2DWY(Date, 1), Text001)));
        end;
    end;


    procedure SetCurrentPeriod(var Calendar: Record Date)
    begin
        Calendar.Reset;
        Calendar.SetRange("Period Type", Calendar."Period Type"::Week);
        Calendar.SetFilter("Period Start", '<=%1', WorkDate);
        Calendar.FindLast;
    end;


    procedure SetNextPeriod(var Calendar: Record Date)
    begin
        Calendar.SetRange("Period Type", Calendar."Period Type"::Week);
        Calendar.SetFilter("Period Start", '<=%1', CalcDate('+7D', Calendar."Period Start"));
        Calendar.FindLast;
    end;


    procedure SetPreviousPeriod(var Calendar: Record Date)
    begin
        Calendar.SetRange("Period Type", Calendar."Period Type"::Week);
        Calendar.SetFilter("Period Start", '<=%1', CalcDate('-7D', Calendar."Period Start"));
        Calendar.FindLast;
    end;


    procedure ShowCaseHours(Period: Integer)
    var
        UserSetup: Record "User Setup";
        CaseHours: Record "Case Line";
        CaseHoursList: Page "Case Line List";
    begin
        UserSetup.Get(UserId);

        CaseHours.SetRange("Resource No.", UserSetup."Resource No.");
        CaseHours.SetFilter(CaseHours.Date, '%1', DatePeriod[Period]);

        CaseHoursList.SetTableView(CaseHours);
        CaseHoursList.RunModal;
    end;


    procedure ShowTotalCaseHours()
    var
        UserSetup: Record "User Setup";
        CaseHours: Record "Case Line";
        CaseHoursList: Page "Case Line List";
    begin
        UserSetup.Get(UserId);

        CaseHours.SetRange("Resource No.", UserSetup."Resource No.");
        CaseHours.SetFilter(CaseHours.Date, '%1..%2', Calendar."Period Start", Calendar."Period End");

        CaseHoursList.SetTableView(CaseHours);
        CaseHoursList.RunModal;
    end;
}

