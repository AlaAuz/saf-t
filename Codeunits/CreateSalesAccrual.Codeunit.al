codeunit 70301 "Create Sales Accrual"
{
    TableNo = "Sales Invoice Header";

    trigger OnRun()
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        AccountingSetup.Get;
        if not AccountingSetup."Sales Accrual Enabled" then
            exit;

        SalesInvLine.SetRange("Document No.", "No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::"G/L Account");
        SalesInvLine.SetFilter("Accrual Starting Date", '<>%1', 0D);
        SalesInvLine.SetFilter("Accrual Bal. Account No.", '<>%1', '');
        SalesInvLine.SetFilter("Accrual No. of Months", '>%1', 1);

        if SalesInvLine.FindSet then begin
            repeat
                PostGenJournalLines(Rec, SalesInvLine);
            until SalesInvLine.Next = 0;
        end;
    end;

    var
        AccountingSetup: Record "Accounting Setup";

    local procedure PostGenJournalLines(var SalesInvHeader: Record "Sales Invoice Header"; var SalesInvLine: Record "Sales Invoice Line")
    var
        AmountPerMonth: Decimal;
        i: Integer;
        NewDate: Date;
        Month: Integer;
        Year: Integer;
        AmountExclVAT: Decimal;
    begin
        AmountExclVAT := SalesInvLine."Amount Including VAT" / (1 + SalesInvLine."VAT %" / 100);

        PostGenJournalLine(SalesInvHeader, SalesInvLine, -AmountExclVAT, SalesInvHeader."Posting Date");

        AmountPerMonth := AmountExclVAT / SalesInvLine."Accrual No. of Months";

        Month := Date2DMY(SalesInvLine."Accrual Starting Date", 2);
        Year := Date2DMY(SalesInvLine."Accrual Starting Date", 3);

        NewDate := SalesInvLine."Accrual Starting Date";
        for i := 1 to SalesInvLine."Accrual No. of Months" do begin
            PostGenJournalLine(SalesInvHeader, SalesInvLine, AmountPerMonth, NewDate);

            if Month = 12 then begin
                Month := 0;
                Year += 1;
            end;
            Month += 1;

            NewDate := DMY2Date(1, Month, Year);
        end;
    end;

    local procedure PostGenJournalLine(var SalesInvHeader: Record "Sales Invoice Header"; var SalesInvLine: Record "Sales Invoice Line"; Amount: Decimal; PostingDate: Date)
    var
        AccrualText: Label 'Accural';
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJournalLine.Init;
        GenJournalLine.Validate("Document No.", SalesInvLine."Document No.");
        GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.Validate("Account No.", SalesInvLine."No.");
        GenJournalLine.Description := StrSubstNo('%1 - %2', GenJournalLine.Description, AccrualText);
        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.Validate("Bal. Account No.", SalesInvLine."Accrual Bal. Account No.");
        GenJournalLine.Validate(Amount, -Amount);
        GenJournalLine.Validate("Posting Date", PostingDate);
        GenJournalLine.Validate("Shortcut Dimension 1 Code", SalesInvLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate("Shortcut Dimension 2 Code", SalesInvLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate("Currency Code", SalesInvHeader."Currency Code");
        GenJournalLine.Validate("Currency Factor", SalesInvHeader."Currency Factor");

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

        GenJournalLine."Dimension Set ID" := SalesInvLine."Dimension Set ID";
        //2009R2+
        //TempJnlLineDim.DELETEALL;
        //TempDocDim.RESET;
        //TempDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        //DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
        //2009R2-

        GenJnlPostLine.RunWithCheck(GenJournalLine);
    end;
}

