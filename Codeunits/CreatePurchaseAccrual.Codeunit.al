codeunit 70302 "Create Purchase Accrual"
{
    TableNo = "Purch. Inv. Header";

    trigger OnRun()
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        AccountingSetup.Get;
        if not AccountingSetup."Purchase Accrual Enabled" then
            exit;

        PurchInvLine.SetRange("Document No.", "No.");
        PurchInvLine.SetRange(Type, PurchInvLine.Type::"G/L Account");
        PurchInvLine.SetFilter("Accrual Starting Date", '<>%1', 0D);
        PurchInvLine.SetFilter("Accrual Bal. Account No.", '<>%1', '');
        PurchInvLine.SetFilter("Accrual No. of Months", '>%1', 1);

        if PurchInvLine.FindSet then begin
            repeat
                PostGenJournalLines(Rec, PurchInvLine);
            until PurchInvLine.Next = 0;
        end;
    end;

    var
        AccountingSetup: Record "Accounting Setup";

    local procedure PostGenJournalLines(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchInvLine: Record "Purch. Inv. Line")
    var
        AmountPerMonth: Decimal;
        i: Integer;
        NewDate: Date;
        Month: Integer;
        Year: Integer;
        AmountExclVAT: Decimal;
    begin
        AmountExclVAT := PurchInvLine."Amount Including VAT" / (1 + PurchInvLine."VAT %" / 100);

        PostGenJournalLine(PurchInvHeader, PurchInvLine, -AmountExclVAT, PurchInvHeader."Posting Date");

        AmountPerMonth := AmountExclVAT / PurchInvLine."Accrual No. of Months";

        Month := Date2DMY(PurchInvLine."Accrual Starting Date", 2);
        Year := Date2DMY(PurchInvLine."Accrual Starting Date", 3);

        NewDate := PurchInvLine."Accrual Starting Date";
        for i := 1 to PurchInvLine."Accrual No. of Months" do begin
            PostGenJournalLine(PurchInvHeader, PurchInvLine, AmountPerMonth, NewDate);

            if Month = 12 then begin
                Month := 0;
                Year += 1;
            end;
            Month += 1;

            NewDate := DMY2Date(1, Month, Year);
        end;
    end;

    local procedure PostGenJournalLine(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchInvLine: Record "Purch. Inv. Line"; Amount: Decimal; PostingDate: Date)
    var
        AccrualText: Label 'Accural';
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJournalLine.Init;
        GenJournalLine.Validate("Document No.", PurchInvLine."Document No.");
        GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.Validate("Account No.", PurchInvLine."No.");
        GenJournalLine.Description := StrSubstNo('%1 - %2', GenJournalLine.Description, AccrualText);
        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.Validate("Bal. Account No.", PurchInvLine."Accrual Bal. Account No.");
        GenJournalLine.Validate(Amount, Amount);
        GenJournalLine.Validate("Posting Date", PostingDate);
        GenJournalLine.Validate("Shortcut Dimension 1 Code", PurchInvLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate("Shortcut Dimension 2 Code", PurchInvLine."Shortcut Dimension 2 Code");
        GenJournalLine.Validate("Currency Code", PurchInvHeader."Currency Code");
        GenJournalLine.Validate("Currency Factor", PurchInvHeader."Currency Factor");

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

        GenJournalLine."Dimension Set ID" := PurchInvLine."Dimension Set ID";
        //2009R2+
        //TempJnlLineDim.DELETEALL;
        //TempDocDim.RESET;
        //TempDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        //DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
        //2009R2-

        GenJnlPostLine.RunWithCheck(GenJournalLine);
    end;
}

