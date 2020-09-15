codeunit 50005 "Accrual Management"
{
    // *** Auzilium AS ***
    // AZ11579 02.11.2016 HHV Changed code to handle rounded amounts.
    // AZ99999 18.04.2017 HHV Changed Text004.


    trigger OnRun()
    begin
    end;

    var
        AZSetup: Record "AZ Setup";
        ServiceContractHeader: Record "Service Contract Header";
        FirstDate: Date;
        LastInvoiceDate: Date;
        DocumentNo: Code[20];
        ShortcutDim1Code: Code[20];
        ShortcutDim2Code: Code[20];
        DimSetID: Integer;
        CurrencyCode: Code[10];
        CurrencyFactor: Decimal;
        Amount: Decimal;
        Text001: Label 'Accrual';
        Text002: Label 'Accrual Error: %1 cannot be greater or equal to %2. in %3';
        Text003: Label 'Posting Date';
        ToAccountNo: Code[20];
        FromAccountNo: Code[20];
        Module: Option Sales,Service;
        SourceCodeSetup: Record "Source Code Setup";
        Text004: Label 'Amount 0 cannot be accrued.';


    procedure CheckSalesPosting(): Boolean
    begin
        exit(CheckPosting(0));
    end;


    procedure CheckServicePosting(): Boolean
    begin
        exit(CheckPosting(1));
    end;

    local procedure CheckPosting(NewModule: Option Sales,Service): Boolean
    begin
        Module := NewModule;

        GetAZSetup;
        if Module = Module::Sales then begin
            if not AZSetup."Sales Accrual Enabled" then
                exit(false);

            AZSetup.TestField("Sales Accrual Bal. Account No.");
        end else begin
            if not AZSetup."Service Accrual Enabled" then
                exit(false);

            AZSetup.TestField("Serv. Accrual Bal. Account No.");
        end;

        exit(true);
    end;


    procedure InitValues(NewFirstDate: Date; NewLastInvoiceDate: Date; NewDocumentNo: Code[20]; NewShortcutDim1Code: Code[20]; NewShortcutDim2Code: Code[20]; NewDimSetID: Integer; NewCurrencyCode: Code[10]; NewCurrencyFactor: Decimal; NewAmount: Decimal; NewToAccountNo: Code[20]; NewFromAccountNo: Code[20])
    begin
        FirstDate := NewFirstDate;
        LastInvoiceDate := NewLastInvoiceDate;
        DocumentNo := NewDocumentNo;
        ShortcutDim1Code := NewShortcutDim1Code;
        ShortcutDim2Code := NewShortcutDim2Code;
        DimSetID := NewDimSetID;
        CurrencyCode := NewCurrencyCode;
        CurrencyFactor := NewCurrencyFactor;
        Amount := NewAmount;
        ToAccountNo := NewToAccountNo;
        FromAccountNo := NewFromAccountNo;
    end;


    procedure Post()
    begin
        SourceCodeSetup.Get;
        PostGenJournalLines;
    end;

    local procedure PostGenJournalLines()
    var
        NewDate: Date;
        AmountPerDay: Decimal;
        AmountPerMonth: Decimal;
        AmountPerMonthBeforeRounding: Decimal;
        Month: Integer;
        Year: Integer;
    begin
        PostGenJournalLine(Amount, FirstDate, FirstDate, ToAccountNo);
        GetAZSetup;
        PostGenJournalLine(-Amount, LastInvoiceDate, FirstDate, FromAccountNo);
    end;

    local procedure PostGenJournalLine(Amount: Decimal; PostingDate: Date; DocumentDate: Date; AccountNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJournalLine.Init;
        GenJournalLine.Validate("Document No.", DocumentNo);
        GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.Validate("Account No.", AccountNo);
        GenJournalLine.Description := StrSubstNo('%1 - %2', GenJournalLine.Description, Text001);
        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");

        if Module = Module::Sales then begin
            GenJournalLine.Validate("Bal. Account No.", AZSetup."Sales Accrual Bal. Account No.");
            GenJournalLine."Source Code" := SourceCodeSetup.Sales;
        end else begin
            GenJournalLine.Validate("Bal. Account No.", AZSetup."Serv. Accrual Bal. Account No.");
            GenJournalLine."Source Code" := SourceCodeSetup."Service Management";
        end;

        GenJournalLine.Validate(Amount, Amount);
        GenJournalLine.Validate("Posting Date", PostingDate);
        GenJournalLine.Validate("Document Date", DocumentDate);
        GenJournalLine.Validate("Shortcut Dimension 1 Code", ShortcutDim1Code);
        GenJournalLine.Validate("Shortcut Dimension 2 Code", ShortcutDim2Code);
        GenJournalLine."Dimension Set ID" := DimSetID;
        GenJournalLine."Gen. Posting Type" := 0;
        GenJournalLine."Gen. Bus. Posting Group" := '';
        GenJournalLine."Gen. Prod. Posting Group" := '';
        GenJournalLine."VAT Bus. Posting Group" := '';
        GenJournalLine."VAT Prod. Posting Group" := '';
        GenJournalLine."Bal. Gen. Posting Type" := 0;
        GenJournalLine."Bal. Gen. Bus. Posting Group" := '';
        GenJournalLine."Bal. Gen. Prod. Posting Group" := '';
        GenJournalLine."Bal. VAT Bus. Posting Group" := '';
        GenJournalLine."Bal. VAT Prod. Posting Group" := '';
        GenJnlPostLine.RunWithCheck(GenJournalLine);
    end;

    local procedure GetAZSetup()
    begin
        AZSetup.Get;
    end;

    local procedure CalcNoOfDaysInMonth(PeriodeStart: Date): Decimal
    var
        Date: Record Date;
    begin
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetFilter("Period Start", '..%1', PeriodeStart);
        Date.FindLast;
        exit(NormalDate(Date."Period End") - PeriodeStart + 1);
    end;

    local procedure GetServiceContract(ContractNo: Code[20])
    begin
        if ServiceContractHeader."Contract No." <> ContractNo then
            ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, ContractNo);
    end;
}

