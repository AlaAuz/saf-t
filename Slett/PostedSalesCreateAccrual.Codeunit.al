codeunit 50006 "Posted Sales-Create Accrual"
{
    // *** Auzilium AS ***
    // AZ99999 18.04.2017 HHV Added filter.


    trigger OnRun()
    begin
    end;

    var
        AccrualMgt: Codeunit "Accrual Management";
        AmountExclVAT: Decimal;


    procedure Invoice(var SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesInvLine: Record "Sales Invoice Line";
        AZSetup: Record "Object Compare";
        Item: Record Item;
    begin
        if not InvoiceQualifyForAccrual(SalesInvHeader) then
            exit;

        Clear(AccrualMgt);
        if not AccrualMgt.CheckSalesPosting then
            exit;

        AZSetup.Get;
        /*
        WITH SalesInvHeader DO BEGIN
          //TESTFIELD("Service Contract No.");
        
          SalesInvLine.SETRANGE("Document No.","No.");
          SalesInvLine.SETFILTER(Quantity,'>%1',0);
          SalesInvLine.SETRANGE(Type,SalesInvLine.Type::Item);
          //AZ99999+
          SalesInvLine.SETFILTER("Amount Including VAT",'<>%1',0);
          //AZ99999-
          IF SalesInvLine.FINDSET THEN BEGIN
            REPEAT
        
              IF Item.GET(SalesInvLine."No.") THEN
                IF Item."Service Item Group" <> '' THEN BEGIN
                  AmountExclVAT := SalesInvLine."Amount Including VAT" * (1 - (SalesInvLine."VAT %" / 125));
        
                  AccrualMgt.InitValues(
                    "Posting Date","Posting Date","No.",SalesInvLine."Shortcut Dimension 1 Code",SalesInvLine."Shortcut Dimension 2 Code",SalesInvLine."Dimension Set ID",
                    "Currency Code","Currency Factor",AmountExclVAT,SalesInvLine."Number of Days",AZSetup."Sales To Accrual Account No.",AZSetup."Sales From Accrual Account No.");
                  AccrualMgt.CalcNoOfDays("Service Contract No.",SalesInvLine."No.");
                  AccrualMgt.Post;
                END;
        
            UNTIL SalesInvLine.NEXT = 0;
          END;
        END;
        */

    end;

    local procedure InvoiceQualifyForAccrual(SalesInvHeader: Record "Sales Invoice Header"): Boolean
    var
        SalesInvLine: Record "Sales Invoice Line";
        Item: Record Item;
        Qualify: Boolean;
    begin
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        SalesInvLine.SetFilter(Quantity, '>%1', 0);
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);

        Qualify := false;

        if SalesInvLine.FindSet then
            repeat
                if Item.Get(SalesInvLine."No.") then
                    if Item."Service Item Group" <> '' then begin
                        Qualify := true;
                        exit(Qualify);
                    end;
            until SalesInvLine.Next = 0;

        exit(Qualify);
    end;


    procedure CrMemo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        AZSetup: Record "Object Compare";
        Item: Record Item;
    begin
        if not CrMemoQualifyForAccrual(SalesCrMemoHeader) then
            exit;

        Clear(AccrualMgt);
        if not AccrualMgt.CheckSalesPosting then
            exit;

        AZSetup.Get;
        /*
        WITH SalesCrMemoHeader DO BEGIN
          //TESTFIELD("Service Contract No.");
        
          SalesCrMemoLine.SETRANGE("Document No.","No.");
          SalesCrMemoLine.SETFILTER(Quantity,'>%1',0);
          SalesCrMemoLine.SETRANGE(Type,SalesCrMemoLine.Type::Item);
          //AZ99999+
          SalesCrMemoLine.SETFILTER("Amount Including VAT",'<>%1',0);
          //AZ99999-
          IF SalesCrMemoLine.FINDSET THEN BEGIN
            REPEAT
              IF Item.GET(SalesCrMemoLine."No.") THEN
                IF Item."Service Item Group" <> '' THEN BEGIN
        
                  AmountExclVAT := -(SalesCrMemoLine."Amount Including VAT" * (1 - (SalesCrMemoLine."VAT %" / 125)));
        
                  AccrualMgt.InitValues(
                    "Posting Date","Posting Date","No.",SalesCrMemoLine."Shortcut Dimension 1 Code",SalesCrMemoLine."Shortcut Dimension 2 Code",SalesCrMemoLine."Dimension Set ID",
                    "Currency Code","Currency Factor",AmountExclVAT,0,AZSetup."Sales To Accrual Account No.",AZSetup."Sales From Accrual Account No.");
                  AccrualMgt.CalcNoOfDays("Service Contract No.",SalesCrMemoLine."No.");
                  AccrualMgt.Post;
                END;
            UNTIL SalesCrMemoLine.NEXT = 0;
          END;
        END;
        */

    end;

    local procedure CrMemoQualifyForAccrual(SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Item: Record Item;
        Qualify: Boolean;
    begin
        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        SalesCrMemoLine.SetFilter(Quantity, '>%1', 0);
        SalesCrMemoLine.SetRange(Type, SalesCrMemoLine.Type::Item);

        Qualify := false;

        if SalesCrMemoLine.FindSet then
            repeat
                if Item.Get(SalesCrMemoLine."No.") then
                    if Item."Service Item Group" <> '' then begin
                        exit(true);
                    end;
            until SalesCrMemoLine.Next = 0;

        exit(Qualify);
    end;
}

