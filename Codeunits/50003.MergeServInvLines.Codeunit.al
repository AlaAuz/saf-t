codeunit 50003 "AUZ Merge Serv. Inv. Lines"
{
    procedure MergeServiceInvoiceLines(var TempLine: Record "Service Invoice Line" temporary; ServiceInvoiceHeader: Record "Service Invoice Header")
    var
        ServInvLine: Record "Service Invoice Line";
        ServInvLine2: Record "Service Invoice Line";
        CommenLineNo: Integer;
        LineNo: Integer;
        LineAmount: Decimal;
        UnitPrice: Decimal;
        NewGroup: Boolean;
    begin
        ServInvLine.SetRange("Document No.", ServiceInvoiceHeader."No.");
        ServInvLine.FindSet;

        repeat
            if NewGroup then
                if (TempLine."No." <> ServInvLine."No.") or (TempLine."VAT %" <> ServInvLine."VAT %") then begin
                    InsertDescriptionLineIntoTempLine(TempLine, InvFromDate, InvToDate);
                    NewGroup := false;
                    InvFromDate := 0D;
                end;

            if not NewGroup then begin
                InitTempLine(TempLine, ServInvLine, LineNo);

                if IsNewGroup(ServInvLine, TempLine) then begin
                    SetQuantity(TempLine);
                    SetDates(ServInvLine, InvFromDate, InvToDate);
                    SetItemDescription(TempLine);
                    LineNo += 10000;
                    NewGroup := true;
                end else
                    NewGroup := false;
                InsertTempLine(TempLine, LineNo);
            end else begin
                UpdateTempLineValues(TempLine, ServInvLine);
                InvToDate := ServInvLine."AUZ Serv. Contract Line To Date";
            end;
        until ServInvLine.Next = 0;

        if NewGroup then
            InsertDescriptionLineIntoTempLine(TempLine, InvFromDate, InvToDate);
    end;

    local procedure InsertDescriptionLineIntoTempLine(var TempLine: Record "Service Invoice Line"; InvFromDate: Date; InvToDate: Date)
    begin
        TempLine.Init;
        TempLine."Line No." -= 10000;
        TempLine.Description := StrSubstNo('%1 - %2', InvFromDate, InvToDate);
        TempLine.Insert;
    end;

    local procedure InitTempLine(var TempLine: Record "Service Invoice Line"; var ServInvLine: Record "Service Invoice Line"; var LineNo: Integer)
    begin
        LineNo += 10000;
        TempLine.Init;
        TempLine := ServInvLine;
    end;

    local procedure IsNewGroup(var ServInvLine: Record "Service Invoice Line"; TempLine: Record "Service Invoice Line"): Boolean
    begin
        if (ServInvLine."AUZ Serv. Contract Line From Date" <> 0D) and
          (ServInvLine."AUZ Serv. Contract Line To Date" <> 0D) and
          (ServInvLine."Contract No." <> '') and
          (ServInvLine."No." <> '')
        then
            exit(true);
    end;

    local procedure SetQuantity(var TempLine: Record "Service Invoice Line")
    begin
        TempLine.Quantity := TempLine."AUZ SCL Quantity";
    end;

    local procedure SetDates(ServInvLine: Record "Service Invoice Line"; var InvFromDate: Date; var InvToDate: Date)
    begin
        InvFromDate := ServInvLine."AUZ Serv. Contract Line From Date";
        InvToDate := ServInvLine."AUZ Serv. Contract Line To Date";
    end;

    local procedure SetItemDescription(var ServInvLine: Record "Service Invoice Line")
    begin
        Item.Get(ServInvLine."No.");
        ServInvLine.Description := Item.Description;
    end;

    local procedure InsertTempLine(var TempLine: Record "Service Invoice Line"; LineNo: Integer)
    begin
        TempLine."Line No." := LineNo;
        TempLine.Insert;
    end;

    local procedure UpdateTempLineValues(var TempLine: Record "Service Invoice Line"; var ServInvLine: Record "Service Invoice Line")
    begin
        TempLine."Line Amount" += ServInvLine."Line Amount";
        TempLine."Unit Price" += ServInvLine."Unit Price";
        TempLine.Amount += ServInvLine.Amount;
        TempLine."VAT Base Amount" += ServInvLine."VAT Base Amount";
        TempLine."Amount Including VAT" += ServInvLine."Amount Including VAT";
        TempLine."Inv. Discount Amount" += ServInvLine."Inv. Discount Amount";
        TempLine."Description 2" := StrSubstNo('%1 - %2', ServInvLine."AUZ Serv. Contract Line From Date", ServInvLine."AUZ Serv. Contract Line To Date");
        TempLine.Modify;
    end;

    var
        Item: Record Item;
        InvFromDate: Date;
        InvToDate: Date;
}