codeunit 70401 "External File Sales Management"
{

    trigger OnRun()
    begin
    end;

    var
        ExtFileMgtSetup: Record "External File Management Setup";


    procedure CopyFilesToPostedDocuments(SalesHeader: Record "Sales Header"; SalesShptHeaderNo: Code[20]; SalesInvHeaderNo: Code[20]; SalesCrMemoHeaderNo: Code[20])
    begin
        if not CheckSetup then
            exit;

        CopyFilesToPostedShipment(SalesHeader, SalesShptHeaderNo);
        CopyFilesToPostedInvoice(SalesHeader, SalesInvHeaderNo);
        CopyFilesToPostedCrMemo(SalesHeader, SalesCrMemoHeaderNo);
    end;

    local procedure CopyFilesToPostedShipment(SalesHeader: Record "Sales Header"; SalesShptHeaderNo: Code[20])
    var
        SalesLine: Record "Sales Line";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesShptLine: Record "Sales Shipment Line";
        ExtFileMgt: Codeunit "External File Management";
    begin
        if ExtFileMgtSetup."Copy Files to Posted Shpt." and (SalesShptHeaderNo <> '') then begin
            // Header
            SalesShptHeader.Get(SalesShptHeaderNo);
            CopyExternalFile(ExtFileMgt, SalesHeader, SalesShptHeader);

            // Lines
            SalesShptLine.SetRange("Document No.", SalesShptHeader."No.");
            if SalesShptLine.FindSet then
                repeat
                    if SalesLine.Get(SalesHeader."Document Type", SalesHeader."No.", SalesShptLine."Line No.") then begin
                        ExtFileMgt.SetSubpageValues(DATABASE::"Sales Shipment Line", 0, SalesShptLine."Document No.", SalesShptLine."Line No.");
                        CopyExternalFile(ExtFileMgt, SalesLine, SalesShptLine);
                    end;
                until SalesShptLine.Next = 0;
        end;
    end;

    local procedure CopyFilesToPostedInvoice(SalesHeader: Record "Sales Header"; SalesInvHeaderNo: Code[20])
    var
        SalesLine: Record "Sales Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        ExtFileMgt: Codeunit "External File Management";
    begin
        if ExtFileMgtSetup."Copy Files to Posted Inv." and (SalesInvHeaderNo <> '') then begin
            // Header
            SalesInvHeader.Get(SalesInvHeaderNo);
            CopyExternalFile(ExtFileMgt, SalesHeader, SalesInvHeader);

            // Lines
            SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
            if SalesInvLine.FindSet then
                repeat
                    if SalesLine.Get(SalesHeader."Document Type", SalesHeader."No.", SalesInvLine."Line No.") then begin
                        ExtFileMgt.SetSubpageValues(DATABASE::"Sales Invoice Line", 0, SalesInvLine."Document No.", SalesInvLine."Line No.");
                        CopyExternalFile(ExtFileMgt, SalesLine, SalesInvLine);
                    end;
                until SalesInvLine.Next = 0;
        end;
    end;

    local procedure CopyFilesToPostedCrMemo(SalesHeader: Record "Sales Header"; SalesCrMemoHeaderNo: Code[20])
    var
        SalesLine: Record "Sales Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ExtFileMgt: Codeunit "External File Management";
    begin
        if ExtFileMgtSetup."Copy Files to Posted Cr. Memo" and (SalesCrMemoHeaderNo <> '') then begin
            // Header
            SalesCrMemoHeader.Get(SalesCrMemoHeaderNo);
            CopyExternalFile(ExtFileMgt, SalesHeader, SalesCrMemoHeader);

            // Lines
            SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
            if SalesCrMemoLine.FindSet then
                repeat
                    if SalesLine.Get(SalesHeader."Document Type", SalesHeader."No.", SalesCrMemoLine."Line No.") then begin
                        ExtFileMgt.SetSubpageValues(DATABASE::"Sales Cr.Memo Line", 0, SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.");
                        CopyExternalFile(ExtFileMgt, SalesLine, SalesCrMemoLine);
                    end;
                until SalesCrMemoLine.Next = 0;
        end;
    end;


    procedure CopyFilesFromOrderToQuote(SalesQuoteHeader: Record "Sales Header"; SalesOrderHeader: Record "Sales Header")
    var
        ExtFileMgtSetup: Record "External File Management Setup";
        SalesOrderLine: Record "Sales Line";
        SalesQuoteLine: Record "Sales Line";
        ExtFileMgt: Codeunit "External File Management";
    begin
        if not CheckSetup then
            exit;

        // Header
        CopyExternalFile(ExtFileMgt, SalesQuoteHeader, SalesOrderHeader);

        // Lines
        SalesOrderLine.SetRange("Document Type", SalesOrderLine."Document Type"::Order);
        SalesOrderLine.SetRange("Document No.", SalesOrderHeader."No.");
        if SalesOrderLine.FindSet then
            repeat
                if SalesQuoteLine.Get(SalesQuoteHeader."Document Type", SalesQuoteHeader."No.", SalesOrderLine."Line No.") then begin
                    ExtFileMgt.SetSubpageValues(DATABASE::"Sales Line", SalesOrderLine."Document Type", SalesOrderLine."Document No.", SalesOrderLine."Line No.");
                    CopyExternalFile(ExtFileMgt, SalesQuoteLine, SalesOrderLine);
                end;
            until SalesOrderLine.Next = 0;
    end;

    local procedure CheckSetup(): Boolean
    begin
        if not ExtFileMgtSetup.Get then
            exit(false);

        if (not ExtFileMgtSetup."Save to Database") and (ExtFileMgtSetup."File Directory" = '') then
            exit(false);

        exit(true);
    end;

    local procedure CopyExternalFile(var ExtFileMgt: Codeunit "External File Management"; FromVar: Variant; ToVar: Variant): Boolean
    var
        FromRecRef: RecordRef;
        ToRecRef: RecordRef;
    begin
        FromRecRef.GetTable(FromVar);
        ToRecRef.GetTable(ToVar);

        ExtFileMgt.CopyFiles(FromRecRef.RecordId, ToRecRef.RecordId);
    end;
}

