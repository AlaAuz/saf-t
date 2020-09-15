codeunit 50004 "Posted Service-Create Accrual"
{
    // *** Auzilium AS ***


    trigger OnRun()
    begin
    end;

    var
        AccrualMgt: Codeunit "Accrual Management";
        Item: Record Item;


    procedure Invoice(var ServInvHeader: Record "Service Invoice Header")
    var
        ServInvLine: Record "Service Invoice Line";
        ServiceContractHeader: Record "Service Contract Header";
        AZSetup: Record "AZ Setup";
    begin
        Clear(AccrualMgt);
        if not AccrualMgt.CheckServicePosting then
            exit;

        AZSetup.Get;

        with ServInvHeader do begin
            TestField("Contract No.");

            ServiceContractHeader.Get(ServiceContractHeader."Contract Type"::Contract, "Contract No.");

            ServInvLine.SetRange("Document No.", "No.");
            ServInvLine.SetRange(Type, ServInvLine.Type::Item);
            ServInvLine.SetFilter("No.", '<>%1', '');
            ServInvLine.SetFilter(Quantity, '>%1', 0);
            ServInvLine.SetFilter(Amount, '<>%1', 0);
            ServInvLine.SetFilter("Serv. Contract Line To Date", '<>%1', 0D);
            if ServInvLine.FindSet then begin
                repeat
                    AccrualMgt.InitValues(
                      "Posting Date", ServInvLine."Serv. Contract Line To Date", "No.", ServInvLine."Shortcut Dimension 1 Code",
                      ServInvLine."Shortcut Dimension 2 Code", ServInvLine."Dimension Set ID",
                      "Currency Code", "Currency Factor", ServInvLine.Amount, AZSetup."Service To Accrual Account No.", AZSetup."Serv. From Accrual Account No.");
                    AccrualMgt.Post;
                until ServInvLine.Next = 0;
            end;
        end;
    end;


    procedure CrMemo(var ServCrMemoHeader: Record "Service Cr.Memo Header")
    var
        ServCrMemoLine: Record "Service Cr.Memo Line";
        ServCrMemoLine2: Record "Service Cr.Memo Line";
        AZSetup: Record "AZ Setup";
    begin

        Clear(AccrualMgt);
        if not AccrualMgt.CheckServicePosting then
            exit;

        AZSetup.Get;

        with ServCrMemoHeader do begin
            TestField("Contract No.");

            ServCrMemoLine.SetRange("Document No.", "No.");
            ServCrMemoLine.SetRange(Type, ServCrMemoLine.Type::Item);
            ServCrMemoLine.SetFilter("No.", '<>%1', '');
            ServCrMemoLine.SetFilter(Quantity, '>%1', 0);
            ServCrMemoLine.SetFilter(Amount, '<>%1', 0);
            ServCrMemoLine.SetFilter("Serv. Contract Line To Date", '<>%1', 0D);
            if ServCrMemoLine.FindSet then begin
                repeat
                    AccrualMgt.InitValues(
                      "Posting Date", ServCrMemoLine."Serv. Contract Line To Date", "No.", ServCrMemoLine."Shortcut Dimension 1 Code", ServCrMemoLine."Shortcut Dimension 2 Code", ServCrMemoLine."Dimension Set ID",
                      "Currency Code", "Currency Factor", -ServCrMemoLine.Amount, AZSetup."Service To Accrual Account No.", AZSetup."Serv. From Accrual Account No.");
                    AccrualMgt.Post;
                until ServCrMemoLine.Next = 0;
            end;
        end;
    end;
}

