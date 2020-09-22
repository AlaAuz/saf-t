//codeunit 71101 "Service Item-Check Avail."
/*
codeunit 50014 "AUZ Service Item-Check Avail."
{
    procedure ServiceLineCheck(ServiceLine: Record "Service Line"; Recalculate: Boolean) Rollback: Boolean
    begin
    end;

    procedure ServiceLineShowWarning(ServiceLine: Record "Service Line"; Recalculate: Boolean): Boolean
    var
        OldServiceLine: Record "Service Line";
    begin
        if not ItemCheckAvail.ShowWarningForThisItem(ServiceLine."No.") then
            exit(false);

        OldItemNetChange := 0;
        OldServiceLine := ServiceLine;
        if OldServiceLine.Find then begin // Find previous quantity
            if (OldServiceLine."Document Type" = OldServiceLine."Document Type"::Order) and
               (OldServiceLine."No." = ServiceLine."No.") and
               (OldServiceLine."Variant Code" = ServiceLine."Variant Code") and
               (OldServiceLine."Location Code" = ServiceLine."Location Code") and
               (OldServiceLine."Bin Code" = ServiceLine."Bin Code")
            then begin
                OldItemNetChange := -OldServiceLine."Outstanding Qty. (Base)";
                OldServiceLine.CalcFields("Reserved Qty. (Base)");
                OldItemNetResChange := -OldServiceLine."Reserved Qty. (Base)";
            end;
        end;

        if ServiceLine."Document Type" = ServiceLine."Document Type"::Order then
            UseOrderPromise := true;
        exit(
          ShowWarning(
            ServiceLine."No.",
            ServiceLine."Variant Code",
            ServiceLine."Location Code",
            ServiceLine."Unit of Measure Code",
            ServiceLine."Qty. per Unit of Measure",
            -ServiceLine."Outstanding Quantity",
            OldItemNetChange,
            ServiceLine."Needed by Date",
            OldServiceLine."Needed by Date"));
    end;

    local procedure ShowWarning(ItemNo2: Code[20]; ItemVariantCode: Code[10]; ItemLocationCode: Code[10]; UnitOfMeasureCode2: Code[10]; QtyPerUnitOfMeasure2: Decimal; NewItemNetChange2: Decimal; OldItemNetChange2: Decimal; ShipmentDate: Date; OldShipmentDate: Date): Boolean
    var
        Item: Record Item;
    begin
        ItemNo := ItemNo2;
        UnitOfMeasureCode := UnitOfMeasureCode2;
        QtyPerUnitOfMeasure := QtyPerUnitOfMeasure2;
        NewItemNetChange := NewItemNetChange2;
        OldItemNetChange := ConvertQty(OldItemNetChange2);
        OldItemShipmentDate := OldShipmentDate;

        if NewItemNetChange >= 0 then
            exit(false);

        SetFilterOnItem(Item, ItemNo, ItemVariantCode, ItemLocationCode, ShipmentDate);
        Calculate(Item);
        exit(InitialQtyAvailable + ItemNetChange - OldItemNetResChange < 0);
    end;

    local procedure ConvertQty(Qty: Decimal): Decimal
    begin
        if QtyPerUnitOfMeasure = 0 then
            QtyPerUnitOfMeasure := 1;
        exit(Round(Qty / QtyPerUnitOfMeasure, 0.00001));
    end;

    local procedure SetFilterOnItem(var Item: Record Item; ItemNo: Code[20]; ItemVariantCode: Code[10]; ItemLocationCode: Code[10]; ShipmentDate: Date)
    begin
        Item.Get(ItemNo);
        Item.SetRange("No.", ItemNo);
        Item.SetRange("Variant Filter", ItemVariantCode);
        Item.SetRange("Location Filter", ItemLocationCode);
        Item.SetRange("Drop Shipment Filter", false);

        if UseOrderPromise then
            Item.SetRange("Date Filter", 0D, ShipmentDate)
        else
            Item.SetRange("Date Filter", 0D, WorkDate);
    end;

    local procedure Calculate(var Item: Record Item)
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get;
        QtyAvailToPromise(Item, CompanyInfo);
        EarliestAvailDate := EarliestAvailabilityDate(Item, CompanyInfo);

        if not UseOrderPromise then
            SchedRcpt := 0;

        OldItemNetResChange := ConvertQty(OldItemNetResChange);
        NewItemNetResChange := ConvertQty(NewItemNetResChange);

        ItemNetChange := 0;
        if Item."No." = ItemNo then begin
            ItemNetChange := NewItemNetChange;
            if GrossReq + OldItemNetChange >= 0 then
                GrossReq := GrossReq + OldItemNetChange;
        end;

        InitialQtyAvailable :=
          InventoryQty +
          (SchedRcpt - ReservedRcpt) - (GrossReq - ReservedReq) -
          NewItemNetResChange;
    end;

    local procedure QtyAvailToPromise(var Item: Record Item; CompanyInfo: Record "Company Information")
    begin
        AvailableToPromise.QtyAvailabletoPromise(
          Item, GrossReq, SchedRcpt, Item.GetRangeMax("Date Filter"),
          CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");
        InventoryQty := ConvertQty(AvailableToPromise.CalcAvailableInventory(Item));
        GrossReq := ConvertQty(GrossReq);
        ReservedReq := ConvertQty(AvailableToPromise.CalcReservedRequirement(Item) + OldItemNetResChange);
        SchedRcpt := ConvertQty(SchedRcpt);
        ReservedRcpt := ConvertQty(AvailableToPromise.CalcReservedReceipt(Item));
    end;

    local procedure EarliestAvailabilityDate(var Item: Record Item; CompanyInfo: Record "Company Information"): Date
    var
        AvailableQty: Decimal;
        NewItemNetChangeBase: Decimal;
        OldItemNetChangeBase: Decimal;
    begin
        NewItemNetChangeBase := ConvertQtyToBaseQty(NewItemNetChange);
        OldItemNetChangeBase := ConvertQtyToBaseQty(OldItemNetChange);
        exit(
          AvailableToPromise.EarliestAvailabilityDate(
            Item, -NewItemNetChangeBase, Item.GetRangeMax("Date Filter"), -OldItemNetChangeBase, OldItemShipmentDate, AvailableQty,
            CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc."));
    end;

    local procedure ConvertQtyToBaseQty(Qty: Decimal): Decimal
    begin
        if QtyPerUnitOfMeasure = 0 then
            QtyPerUnitOfMeasure := 1;
        exit(Round(Qty * QtyPerUnitOfMeasure, 0.00001));
    end;

    procedure RaiseUpdateInterruptedError()
    begin
        Error(Text000);
    end;

    var
        AvailableToPromise: Codeunit "Available to Promise";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ItemNo: Code[20];
        UnitOfMeasureCode: Code[10];
        QtyPerUnitOfMeasure: Decimal;
        OldItemNetChange: Decimal;
        OldItemNetResChange: Decimal;
        InitialQtyAvailable: Decimal;
        NewItemNetChange: Decimal;
        NewItemNetResChange: Decimal;
        ItemNetChange: Decimal;
        SchedRcpt: Decimal;
        GrossReq: Decimal;
        OldItemShipmentDate: Date;
        UseOrderPromise: Boolean;
        EarliestAvailDate: Date;
        InventoryQty: Decimal;
        ReservedRcpt: Decimal;
        ReservedReq: Decimal;
        Text000: Label 'The update has been interrupted to respect the warning.';
} */