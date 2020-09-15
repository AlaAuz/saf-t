codeunit 70903 "Distribute Reminders"
{
    Permissions = TableData "Issued Reminder Header" = rm;
    TableNo = "Issued Reminder Header";

    trigger OnRun()
    begin
        TryDistributeReminder(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 reminders?';

    local procedure TryDistributeReminder(IssuedReminderHeader: Record "Issued Reminder Header")
    begin
        with IssuedReminderHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false, false, true);
                "Distribution Type"::"E-Mail":
                    PrintRecords(false, true, true);
            end;
        end;
    end;


    procedure DistributeReminders(var IssuedReminderHeader: Record "Issued Reminder Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with IssuedReminderHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeReminder(IssuedReminderHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeReminder(IssuedReminderHeader: Record "Issued Reminder Header")
    var
        DistributionLogEntry: Record "Distribution Log Entry";
        DistributionOK: Boolean;
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Reminders", IssuedReminderHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::Reminder;
        DistributionLogEntry."Document No." := IssuedReminderHeader."No.";
        DistributionLogEntry.Date := Today;
        if DistributionOK then
            NoOfDistributions += 1
        else begin
            DistributionLogEntry.SetErrorMessage(GetLastErrorText);
            NoOfErrors += 1;
        end;
        DistributionLogEntry.Insert(true);
    end;

    local procedure InitValues()
    begin
        NoOfDistributions := 0;
        NoOfErrors := 0;
    end;

    [EventSubscriber(ObjectType::Table, 295, 'OnAfterValidateEvent', 'Customer No.', true, true)]
    local procedure SetDistributionTypeOnAfterValidateCustomerNo(var Rec: Record "Reminder Header"; var xRec: Record "Reminder Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        if Customer.Get(Rec."Customer No.") then;
        if Customer."Distribution Type" = Customer."Distribution Type"::EHF then
            Rec."Distribution Type" := Customer."Distribution Type"::"E-Mail"
        else
            Rec."Distribution Type" := Customer."Distribution Type";
        Rec."E-Invoice" := false;
    end;

    [EventSubscriber(ObjectType::Page, 438, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "IssuedReminder.ChangeDistributionType"(var Rec: Record "Issued Reminder Header")
    begin
        ChangeIssuedReminderDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 440, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "IssuedReminderList.ChangeDistributionType"(var Rec: Record "Issued Reminder Header")
    begin
        ChangeIssuedReminderDistributionType(Rec);
    end;

    local procedure ChangeIssuedReminderDistributionType(var IssuedReminderHeader: Record "Issued Reminder Header")
    begin
        if DistributionMgt.SelectDistributionTypeWithoutEHF(IssuedReminderHeader."Distribution Type") then
            IssuedReminderHeader.Modify;
    end;
}

