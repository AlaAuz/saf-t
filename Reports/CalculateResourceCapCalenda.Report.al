report 50119 "Calculate Resource Cap Calenda"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Resource; Resource)
        {
            RequestFilterFields = "No.", "Resource Group No.";

            trigger OnAfterGetRecord()
            begin
                CalculateCap(Resource);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(WorkTemplateCode; WorkTemplateCode)
                {
                    Caption = 'Work Template Code';
                }
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
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

    trigger OnInitReport()
    begin
        StartDate := 0D;
        EndDate := 0D;
        WorkTemplateCode := 'NORMAL';

        if not WorkTemplateRec.Get(WorkTemplateCode) then
            Clear(WorkTemplateRec);
        SumWeekTotal();
    end;

    var
        Text000: Label 'The starting date is later than the ending date.';
        Text001: Label 'You must select a work-hour template.';
        Text002: Label 'You must fill in the Starting Date field.';
        Text003: Label 'You must fill in the Ending Date field.';
        Text004: Label 'Do you want to change the capacity for %1 %2?';
        Text006: Label 'The capacity for %1 days was changed successfully.';
        Text007: Label 'The capacity for %1 day was changed successfully.';
        Text008: Label 'The capacity change was unsuccessful.';
        TempDate: Date;
        WorkTemplateRec: Record "Work-Hour Template";
        WeekTotal: Decimal;
        CalChange: Record "Customized Calendar Change";
        ResCapacityEntry: Record "Res. Capacity Entry";
        ResCapacityEntry2: Record "Res. Capacity Entry";
        ServMgtSetup: Record "Service Mgt. Setup";
        CalendarMgmt: Codeunit "Calendar Management";
        WorkTemplateCode: Code[10];
        StartDate: Date;
        EndDate: Date;
        TempCapacity: Decimal;
        ChangedDays: Integer;
        LastEntry: Decimal;
        CalendarCustomized: Boolean;
        Holiday: Boolean;
        NewDescription: Text[50];


    procedure CalculateCap(Rec: Record Resource)
    begin
        //ALA
        /*
        with Rec do begin

            if WeekTotal <= 0 then
                Error(Text001);

            if StartDate = 0D then
                Error(Text002);

            if EndDate = 0D then
                Error(Text003);

            ServMgtSetup.Get;
            ServMgtSetup.TestField("Base Calendar Code");

            //IF NOT CONFIRM(Text004,FALSE,TABLECAPTION,"No.") THEN
            //EXIT;

            CalendarCustomized :=
              CalendarMgmt.CustomizedChangesExist(CalChange."Source Type"::Service, '', '', ServMgtSetup."Base Calendar Code");

            ResCapacityEntry.Reset;
            ResCapacityEntry.SetCurrentKey("Resource No.", Date);
            ResCapacityEntry.SetRange(ResCapacityEntry."Resource No.", "No.");
            TempDate := StartDate;
            ChangedDays := 0;
            repeat
                if CalendarCustomized then
                    Holiday :=
                      CalendarMgmt.CheckCustomizedDateStatus(
                        CalChange."Source Type"::Service, '', '', ServMgtSetup."Base Calendar Code", TempDate, NewDescription)
                else
                    Holiday := CalendarMgmt.CheckDateStatus(ServMgtSetup."Base Calendar Code", TempDate, NewDescription);

                if not Holiday then begin
                    ResCapacityEntry.SetRange(Date, TempDate);
                    TempCapacity := 0;
                    if ResCapacityEntry.Find('-') then begin
                        repeat
                            TempCapacity := TempCapacity + ResCapacityEntry.Capacity;
                        until ResCapacityEntry.Next = 0;
                    end;
                    ResCapacityEntry2.Reset;
                    if ResCapacityEntry2.Find('+') then;
                    LastEntry := ResCapacityEntry2."Entry No." + 1;
                    ResCapacityEntry2.Reset;
                    ResCapacityEntry2."Entry No." := LastEntry;
                    ResCapacityEntry2.Capacity := -1 * (TempCapacity - SelectCapacity());
                    ResCapacityEntry2."Resource No." := "No.";
                    ResCapacityEntry2."Resource Group No." := "Resource Group No.";
                    ResCapacityEntry2.Date := TempDate;
                    if ResCapacityEntry2.Insert(true) then;
                    ChangedDays := ChangedDays + 1;
                end;
                TempDate := TempDate + 1;
            until TempDate > EndDate;
            Commit;
        end;
        /*
        IF ChangedDays > 1 THEN
          MESSAGE(Text006,ChangedDays)
        ELSE IF ChangedDays = 1 THEN
          MESSAGE(Text007,ChangedDays)
        ELSE
          MESSAGE(Text008);
        END;
        */

    end;


    procedure SelectCapacity() Hours: Decimal
    begin
        case Date2DWY(TempDate, 1) of
            1:
                Hours := WorkTemplateRec.Monday;
            2:
                Hours := WorkTemplateRec.Tuesday;
            3:
                Hours := WorkTemplateRec.Wednesday;
            4:
                Hours := WorkTemplateRec.Thursday;
            5:
                Hours := WorkTemplateRec.Friday;
            6:
                Hours := WorkTemplateRec.Saturday;
            7:
                Hours := WorkTemplateRec.Sunday;
        end;
    end;


    procedure SumWeekTotal()
    begin
        WeekTotal := WorkTemplateRec.Monday + WorkTemplateRec.Tuesday + WorkTemplateRec.Wednesday +
          WorkTemplateRec.Thursday + WorkTemplateRec.Friday + WorkTemplateRec.Saturday + WorkTemplateRec.Sunday;
    end;
}

