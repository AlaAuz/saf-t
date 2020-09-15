codeunit 50011 "AUZ Purchase Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePurchaseHeaderPayToVendorNo', '', false, false)]
    local procedure MyProcedure(Vendor: Record Vendor; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader."Recipient Bank Account No." := Vendor."Recipient Bank Account No.";
    end;
}