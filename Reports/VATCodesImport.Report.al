report 50045 "VAT Codes Import"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));

            trigger OnAfterGetRecord()
            var
                VATCode: Record "VAT Code";
            begin
                Window.Open('Importerer mva-koder:\' + '#1');
                InsertRec('0', VATCode."Gen. Posting Type"::Purchase, 'Ingen mva-behandling (anskaffelser)', VATCode."Trade Settlement 2017 Box No."::"11", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('1', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innenlands inngående mva, 25%', VATCode."Trade Settlement 2017 Box No."::"14", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('11', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innenlands inngående mva, 15 %', VATCode."Trade Settlement 2017 Box No."::"15", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('12', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innenlands inngående mva, 11,11 %', VATCode."Trade Settlement 2017 Box No."::"15", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('13', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innenlands inngående mva, 10 %', VATCode."Trade Settlement 2017 Box No."::"16", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('14', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innførselsavgift, 25 %', VATCode."Trade Settlement 2017 Box No."::"17", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('15', VATCode."Gen. Posting Type"::Purchase, 'Fradragsberettiget innførselsavgift, 15 %', VATCode."Trade Settlement 2017 Box No."::"18", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('21', VATCode."Gen. Posting Type"::Purchase, 'Grunnlag ved innførsel av varer, 25 %', VATCode."Trade Settlement 2017 Box No."::" ", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('22', VATCode."Gen. Posting Type"::Purchase, 'Grunnlag ved innførsel av varer, 15 %', VATCode."Trade Settlement 2017 Box No."::" ", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('23', VATCode."Gen. Posting Type"::Purchase, 'Grunnlag ved innførsel av varer, 0 %', VATCode."Trade Settlement 2017 Box No."::" ", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('3', VATCode."Gen. Posting Type"::Sale, 'Utgående merverdiavgift, 25 %', VATCode."Trade Settlement 2017 Box No."::"3", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('31', VATCode."Gen. Posting Type"::Sale, 'Utgående merverdiavgift, 15 %', VATCode."Trade Settlement 2017 Box No."::"4", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('32', VATCode."Gen. Posting Type"::Sale, 'Utgående merverdiavgift, 11,11 %', VATCode."Trade Settlement 2017 Box No."::"4", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('33', VATCode."Gen. Posting Type"::Sale, 'Utgående merverdiavgift, 10 %', VATCode."Trade Settlement 2017 Box No."::"5", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('5', VATCode."Gen. Posting Type"::Sale, 'Innenlands omsetning og uttak fritatt for merverdiavgift, 0 %', VATCode."Trade Settlement 2017 Box No."::"6", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('51', VATCode."Gen. Posting Type"::Sale, 'Innenlands omsetning med omvendt avgiftsplikt, 0 %', VATCode."Trade Settlement 2017 Box No."::"7", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('52', VATCode."Gen. Posting Type"::Sale, 'Utførsel av varer og tjenester, 0 %', VATCode."Trade Settlement 2017 Box No."::"8", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('6', VATCode."Gen. Posting Type"::Sale, 'Omsetning utenfor merverdiavgiftsloven', VATCode."Trade Settlement 2017 Box No."::"1", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('7', VATCode."Gen. Posting Type"::Sale, 'Ingen mva-behandling (inntekter)', VATCode."Trade Settlement 2017 Box No."::" ", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('81', VATCode."Gen. Posting Type"::Purchase, 'Innførsel av varer med omvendt avgiftsplikt med fradragsrett, 25 %', VATCode."Trade Settlement 2017 Box No."::"9", VATCode."Reverse Charge Report Box No."::"17");
                InsertRec('82', VATCode."Gen. Posting Type"::Purchase, 'Innførsel av varer med omvendt avgiftsplikt uten fradragsrett, 25 %', VATCode."Trade Settlement 2017 Box No."::"9", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('83', VATCode."Gen. Posting Type"::Purchase, 'Innførsel av varer med omvendt avgiftsplikt med fradragsrett, 15 %', VATCode."Trade Settlement 2017 Box No."::"10", VATCode."Reverse Charge Report Box No."::"18");
                InsertRec('84', VATCode."Gen. Posting Type"::Purchase, 'Innførsel av varer med omvendt avgiftsplikt uten fradragsrett, 15 %', VATCode."Trade Settlement 2017 Box No."::"10", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('85', VATCode."Gen. Posting Type"::Purchase, 'Innførsel av varer med omvendt avgiftsplikt som er fritatt for innførselsavgift, 0%', VATCode."Trade Settlement 2017 Box No."::"11", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('86', VATCode."Gen. Posting Type"::Purchase, 'Tjenester kjøpt fra utlandet med omvendt avgiftsplikt med fradragsrett, 25 %', VATCode."Trade Settlement 2017 Box No."::"12", VATCode."Reverse Charge Report Box No."::"17");
                InsertRec('87', VATCode."Gen. Posting Type"::Purchase, 'Tjenester kjøpt fra utlandet med omvendt avgiftsplikt uten fradragsrett, 25 %', VATCode."Trade Settlement 2017 Box No."::"12", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('88', VATCode."Gen. Posting Type"::Purchase, 'Tjenester kjøpt fra utlandet med omvendt avgiftsplikt med fradragsrett, 10 %', VATCode."Trade Settlement 2017 Box No."::"12", VATCode."Reverse Charge Report Box No."::"17");
                InsertRec('89', VATCode."Gen. Posting Type"::Purchase, 'Tjenester kjøpt fra utlandet med omvendt avgiftsplikt uten fradragsrett, 10 %', VATCode."Trade Settlement 2017 Box No."::"12", VATCode."Reverse Charge Report Box No."::" ");
                InsertRec('91', VATCode."Gen. Posting Type"::Purchase, 'Innenlands kjøp av varer og tjenester med omvendt avgiftsplikt med fradragsrett, 25%', VATCode."Trade Settlement 2017 Box No."::"13", VATCode."Reverse Charge Report Box No."::"14");
                InsertRec('92', VATCode."Gen. Posting Type"::Purchase, 'Innenlands kjøp av varer og tjenester med omvendt avgiftsplikt uten fradragsrett, 25%', VATCode."Trade Settlement 2017 Box No."::"13", VATCode."Reverse Charge Report Box No."::" ");
            end;

            trigger OnPostDataItem()
            begin
                Window.Close;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Window: Dialog;
        Counter: Integer;

    local procedure InsertRec("Code": Code[10]; GenPostingType: Option; Description2: Text[250]; TradeSettlement2017BoxNo: Option; ReverseChargeReportBoxNo: Option)
    var
        VATCode: Record "VAT Code";
    begin
        if VATCode.Get(Code) then begin
            SetVATCodeValues(VATCode, Code, GenPostingType, Description2, TradeSettlement2017BoxNo, ReverseChargeReportBoxNo);
            VATCode.Modify(true);
        end else begin
            SetVATCodeValues(VATCode, Code, GenPostingType, Description2, TradeSettlement2017BoxNo, ReverseChargeReportBoxNo);
            VATCode.Insert(true);
        end;
        Counter += 1;
        Window.Update(1, Counter);
    end;

    local procedure SplitDescription(var Description: Text[30]): Text[30]
    var
        Description2: Text[30];
    begin
        if StrLen(Description) > 30 then begin
            Description2 := CopyStr(Description, 1, 30);
            Description := DelStr(Description, 1, 30);
            exit(Description2);
        end;
    end;

    local procedure SetVATCodeValues(var VATCode: Record "VAT Code"; "Code": Code[10]; GenPostingType: Option; Description2: Text[250]; TradeSettlement2017BoxNo: Option; ReverseChargeReportBoxNo: Option)
    begin
        VATCode.Init;
        VATCode.Code := Code;
        VATCode."Gen. Posting Type" := GenPostingType;
        VATCode.Description := '';
        VATCode."Description 2" := Description2;
        VATCode."Trade Settlement 2017 Box No." := TradeSettlement2017BoxNo;
        VATCode."Reverse Charge Report Box No." := ReverseChargeReportBoxNo;
    end;
}

