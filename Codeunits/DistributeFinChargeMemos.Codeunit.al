codeunit 70904 "Distribute Fin. Charge Memos"
{
    Permissions = TableData "Issued Fin. Charge Memo Header" = rm;
    TableNo = "Issued Fin. Charge Memo Header";

    trigger OnRun()
    begin
        TryDistributeIssuedFinChargeMemo(Rec);
    end;

    var
        DistributionMgt: Codeunit "Distribution Management";
        Window: Dialog;
        TotalRecNo: Integer;
        NoOfDistributions: Integer;
        NoOfErrors: Integer;
        Text000: Label 'Distributing @1@@@@@';
        Text001: Label 'Do you want to distribute %1 fin. charge memos?';

    local procedure TryDistributeIssuedFinChargeMemo(IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header")
    begin
        with IssuedFinChargeMemoHeader do begin
            SetRecFilter;
            case "Distribution Type" of
                "Distribution Type"::Print:
                    PrintRecords(false, false, true);
                "Distribution Type"::"E-Mail":
                    PrintRecords(false, true, true);
            end;
        end;
    end;

    [Scope('Internal')]
    procedure DistributeIssuedFinChargeMemos(var IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header")
    var
        RecNo: Integer;
    begin
        InitValues;
        with IssuedFinChargeMemoHeader do begin
            FindSet;
            TotalRecNo := Count;
            if not Confirm(Text001, true, TotalRecNo) then
                exit;
            Window.Open(Text000, RecNo);
            repeat
                RecNo += 1;
                Window.Update(1, Round((RecNo / TotalRecNo * 10000), 1));
                DistributeIssuedFinChargeMemo(IssuedFinChargeMemoHeader);
                Commit;
            until Next = 0;
            Window.Close;
        end;
        DistributionMgt.ShowCompletionMessage(NoOfDistributions, NoOfErrors, TotalRecNo);
    end;

    local procedure DistributeIssuedFinChargeMemo(IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header")
    var
        DistributionLogEntry: Record "Distribution Log Entry";
        DistributionOK: Boolean;
    begin
        DistributionOK := CODEUNIT.Run(CODEUNIT::"Distribute Fin. Charge Memos", IssuedFinChargeMemoHeader);

        DistributionLogEntry.Init;
        DistributionLogEntry."Document Type" := DistributionLogEntry."Document Type"::"Fin. Charge Memo";
        DistributionLogEntry."Document No." := IssuedFinChargeMemoHeader."No.";
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

    [EventSubscriber(ObjectType::Table, 302, 'OnAfterValidateEvent', 'Customer No.', true, true)]
    local procedure SetDistributionTypeOnAfterValidateCustomerNo(var Rec: Record "Finance Charge Memo Header"; var xRec: Record "Finance Charge Memo Header"; CurrFieldNo: Integer)
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

    [EventSubscriber(ObjectType::Page, 450, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "IssuedFinanceChargeMemo.ChangeDistributionType"(var Rec: Record "Issued Fin. Charge Memo Header")
    begin
        ChangeIssuedFinChargeMemoDistributionType(Rec);
    end;

    [EventSubscriber(ObjectType::Page, 452, 'OnAfterActionEvent', 'ChangeDistributionType', false, false)]
    local procedure "IssuedFinChargeMemoList.ChangeDistributionType"(var Rec: Record "Issued Fin. Charge Memo Header")
    begin
        ChangeIssuedFinChargeMemoDistributionType(Rec);
    end;

    local procedure ChangeIssuedFinChargeMemoDistributionType(var IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header")
    begin
        if DistributionMgt.SelectDistributionTypeWithoutEHF(IssuedFinChargeMemoHeader."Distribution Type") then
            IssuedFinChargeMemoHeader.Modify;
    end;
}

