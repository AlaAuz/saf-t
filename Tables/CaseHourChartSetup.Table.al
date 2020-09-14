table 90010 "Case Hour Chart Setup"
{
    Caption = 'Case Hour Chart Setup';

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
        }
        field(2; Day; Boolean)
        {
            Caption = 'Day';
        }
        field(3; Week; Boolean)
        {
            Caption = 'Week';
        }
        field(4; Month; Boolean)
        {
            Caption = 'Month';
        }
        field(5; Year; Boolean)
        {
            Caption = 'Year';
        }
        field(6; Total; Boolean)
        {
            Caption = 'Total';
            InitValue = true;
        }
        field(7; Quarter; Boolean)
        {
            Caption = 'Quarter';
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Total,Accumulated,Pie';
            OptionMembers = Total,Accumulated,Pie;
        }
        field(9; Chargeable; Option)
        {
            Caption = 'Chargeable';
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No,Both';
            OptionMembers = Yes,No,Both;
        }
        field(10; "Last Months Winner"; Boolean)
        {
            Caption = 'Last Month''s Winner';
            Editable = false;
        }
        field(11; "Last Date Won"; Date)
        {
            Caption = 'Last Date Won';
            Editable = false;
        }
        field(12; "Last Quantity Won"; Decimal)
        {
            Caption = 'Last Quantity Won';
            Editable = false;
        }
        field(20; "Show in Chart"; Boolean)
        {
            Caption = 'Show in Chart';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PeriodTxt: Label 'Period: ';

    [Scope('Internal')]
    procedure GetCurrentSelectionText() SelectionText: Text[250]
    begin
        if Day then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Day));
        if Week then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Week));
        if Month then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Month));
        if Quarter then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Quarter));
        if Year then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Year));
        if Total then
            AddMeasureTextToSelectionText(SelectionText, FieldCaption(Total));
        if SelectionText <> '' then
            SelectionText := PeriodTxt + SelectionText;

        if Chargeable in [Chargeable::Yes, Chargeable::No] then begin
            if SelectionText <> '' then
                SelectionText += ', ';
            SelectionText += StrSubstNo('%1: %2', FieldCaption(Chargeable), Chargeable);
        end;
    end;

    local procedure AddMeasureTextToSelectionText(var SelectionText: Text; SelectionType: Text)
    begin
        if SelectionText <> '' then
            SelectionText += '|';
        SelectionText += SelectionType;
    end;

    [Scope('Internal')]
    procedure Index2PeriodType(MeasureIndex: Integer): Integer
    var
        MIndex: Integer;
    begin
        if Day then begin
            if MeasureIndex = MIndex then
                exit(0);
            MIndex += 1;
        end;

        if Week then begin
            if MeasureIndex = MIndex then
                exit(1);
            MIndex += 1;
        end;

        if Month then begin
            if MeasureIndex = MIndex then
                exit(2);
            MIndex += 1;
        end;

        if Quarter then begin
            if MeasureIndex = MIndex then
                exit(3);
            MIndex += 1;
        end;

        if Year then begin
            if MeasureIndex = MIndex then
                exit(4);
            MIndex += 1;
        end;

        if Total then begin
            if MeasureIndex = MIndex then
                exit(5);
            MIndex += 1;
        end;
    end;

    [Scope('Internal')]
    procedure SetDefault()
    begin
        SetType(Type::Total);
    end;

    [Scope('Internal')]
    procedure SetPie()
    begin
        SetType(Type::Pie);
    end;

    local procedure SetType(ViewType: Option)
    begin
        if (ViewType <> Type) and (ViewType in [Type::Accumulated, Type::Pie]) then
            InitPeriods;
        Month := true;
        Type := ViewType;
        Modify;
    end;

    [Scope('Internal')]
    procedure SetChargeable(Value: Option)
    begin
        Chargeable := Value;
        Modify;
    end;

    [Scope('Internal')]
    procedure SetDay(Value: Boolean)
    begin
        SetPeriod(Day, Value);
    end;

    [Scope('Internal')]
    procedure SetWeek(Value: Boolean)
    begin
        SetPeriod(Week, Value);
    end;

    [Scope('Internal')]
    procedure SetMonth(Value: Boolean)
    begin
        SetPeriod(Month, Value);
    end;

    [Scope('Internal')]
    procedure SetQuarter(Value: Boolean)
    begin
        SetPeriod(Quarter, Value);
    end;

    [Scope('Internal')]
    procedure SetYear(Value: Boolean)
    begin
        SetPeriod(Year, Value);
    end;

    [Scope('Internal')]
    procedure SetTotal(Value: Boolean)
    begin
        SetPeriod(Total, Value);
    end;

    local procedure SetPeriod(var FromValue: Boolean; ToValue: Boolean)
    begin
        if ToValue and (Type in [Type::Accumulated, Type::Pie]) then
            InitPeriods;
        FromValue := ToValue;
        Modify;
    end;

    local procedure InitPeriods()
    begin
        Day := false;
        Week := false;
        Month := false;
        Quarter := false;
        Year := false;
        Total := false;
    end;

    [Scope('Internal')]
    procedure UpdateLastMonthsWinner()
    var
        Date1: Record Date;
        CaseHoursChartSetup: Record "Case Hour Chart Setup";
        CaseHoursChartSetup2: Record "Case Hour Chart Setup";
        UserSetup: Record "User Setup";
        Quantity: Decimal;
        xQuantity: Decimal;
        ResourceNo: Code[20];
        xUserID: Code[50];
    begin
        Date1.SetRange("Period Type", Date1."Period Type"::Month);
        Date1.SetFilter("Period End", '%1..', CalcDate('<-1M>', Today));
        Date1.FindFirst;

        CaseHoursChartSetup.SetFilter(CaseHoursChartSetup."Last Date Won", '>=%1', Date1."Period Start");
        if not CaseHoursChartSetup.FindFirst then begin
            CaseHoursChartSetup.Reset;
            CaseHoursChartSetup.SetRange("Show in Chart", true);
            if CaseHoursChartSetup.FindSet then
                repeat
                    UserSetup.Get(CaseHoursChartSetup."User ID");
                    ResourceNo := UserSetup."Resource No.";

                    Quantity := CalcQuantity(ResourceNo, Date1."Period Start", NormalDate(Date1."Period End"));
                    if Quantity > xQuantity then begin
                        xQuantity := Quantity;
                        xUserID := UserSetup."User ID";
                    end;
                until CaseHoursChartSetup.Next = 0;

            CaseHoursChartSetup.Get(xUserID);
            if not CaseHoursChartSetup."Last Months Winner" then begin
                CaseHoursChartSetup2.SetRange("Last Months Winner", true);
                if CaseHoursChartSetup2.FindFirst then begin
                    CaseHoursChartSetup2."Last Months Winner" := false;
                    CaseHoursChartSetup2.Modify;
                end;
            end;
            CaseHoursChartSetup."Last Quantity Won" := xQuantity;
            CaseHoursChartSetup."Last Date Won" := NormalDate(Date1."Period End");
            CaseHoursChartSetup."Last Months Winner" := true;
            CaseHoursChartSetup.Modify;
        end;
    end;

    local procedure CalcQuantity(ResourceNo: Code[10]; FromDate: Date; ToDate: Date): Decimal
    var
        CaseHours: Record "Case Line";
    begin
        CaseHours.SetRange("Resource No.", ResourceNo);
        CaseHours.SetRange(Date, FromDate, ToDate);
        CaseHours.CalcSums(Quantity);
        exit(CaseHours.Quantity);
    end;
}

