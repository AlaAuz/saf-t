codeunit 70900 "Distribution Management"
{

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Distribution completed.';
        Text002: Label 'Distribution completed with following message(s):';
        Text003: Label 'The following error occurred: %1.';
        Text004: Label '%1 of %2 was distributed.';
        Text005: Label '%1 could not be distributed due to error.';
        Text006: Label 'Select Distribution Type.';
        Text007: Label 'Print,E-Mail,EHF';
        Text008: Label 'Print,E-Mail';
        DistributionSetup: Record "Distribution Setup";
        EmailBuffer: Record "Name/Value Buffer" temporary;
        DataTypeMgt: Codeunit "Data Type Management";

    [EventSubscriber(ObjectType::Codeunit, 2, 'OnCompanyInitialize', '', true, true)]
    local procedure InitSetupTable()
    begin
        with DistributionSetup do
            if not FindFirst then begin
                Init;
                Insert;
            end;
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'Distribution Type', false, false)]
    local procedure "Customer.OnAfterValidateDistributionType"(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        SetEInvoice(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterValidateEvent', 'E-Invoice', false, false)]
    local procedure "Customer.OnAfterValidateEInvoice"(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        SetDistributionType(Rec);
    end;

    local procedure SetEInvoice(var Customer: Record Customer)
    begin
        if Customer."Distribution Type" <> Customer."Distribution Type"::EHF then exit;
        Customer."E-Invoice" := true;
    end;

    local procedure SetDistributionType(var Customer: Record Customer)
    begin
        if not Customer."E-Invoice" then exit;
        Customer."Distribution Type" := Customer."Distribution Type"::EHF;
    end;


    procedure SelectDistributionType(var DistributionType: Option Print,"E-Mail",EHF): Boolean
    begin
        exit(DoSelectDistributionType(Text007, DistributionType));
    end;


    procedure SelectDistributionTypeWithoutEHF(var DistributionType: Option Print,"E-Mail"): Boolean
    begin
        exit(DoSelectDistributionType(Text008, DistributionType));
    end;

    local procedure DoSelectDistributionType(OptionString: Text; var DistributionType: Option Print,"E-Mail",EHF): Boolean
    var
        Selection: Integer;
    begin
        Selection := StrMenu(OptionString, DistributionType + 1, Text006);
        if Selection <> 0 then begin
            DistributionType := Selection - 1;
            exit(true);
        end;
    end;


    procedure ShowCompletionMessage(NoOfDistributions: Integer; NoOfErrors: Integer; TotalRecNo: Integer)
    var
        MessageText: Text;
    begin
        if NoOfDistributions = TotalRecNo then
            MessageText := Text001
        else begin
            MessageText := Text002;
            if (TotalRecNo = 1) then
                MessageText += '\' + StrSubstNo(Text003, GetLastErrorText)
            else begin
                if NoOfErrors > 0 then
                    MessageText += '\' + StrSubstNo(Text005, NoOfErrors);
                MessageText += '\' + StrSubstNo(Text004, NoOfDistributions, TotalRecNo);
            end;
        end;
        Message(MessageText);
    end;


    procedure FindEmailAddresses(RecordVariant: Variant; var CustomReportSelection: Record "Custom Report Selection"): Boolean
    var
        Customer: Record Customer;
        SellToCustAddress: Text;
    begin
        EmailBuffer.Reset;
        EmailBuffer.DeleteAll;

        if CustomReportSelection.GetFilter("Source Type") <> Format(DATABASE::Customer) then
            exit;

        if not IsPostedDoc(RecordVariant) then
            exit;

        if Customer.Get(CustomReportSelection.GetFilter("Source No.")) then;
        SellToCustAddress := GetSellToCustEmailAddress(RecordVariant, Customer."No.");

        if Customer."Bill-to E-Mail" <> '' then begin
            EmailBuffer.AddNewEntry('SendTo', Customer."Bill-to E-Mail");
            EmailBuffer.AddNewEntry('SendCC', SellToCustAddress);
        end else
            EmailBuffer.AddNewEntry('SendTo', SellToCustAddress);

        if CurrentClientType = CLIENTTYPE::Background then begin
            DistributionSetup.Get;
            EmailBuffer.AddNewEntry('FromAddress', DistributionSetup."Job Queue E-Mail");
            EmailBuffer.AddNewEntry('SendBCC', DistributionSetup."BCC E-Mail");
        end;
    end;


    procedure AddValuesToEmailItem(var TempEmailItem: Record "Email Item" temporary)
    begin
        if EmailBuffer.IsEmpty then exit;
        SetValue(TempEmailItem."From Address", 'FromAddress', true);
        SetValue(TempEmailItem."Send to", 'SendTo', true);
        SetValue(TempEmailItem."Send CC", 'SendCC', false);
        SetValue(TempEmailItem."Send BCC", 'SendBCC', false);
    end;

    local procedure SetValue(var Value: Text[250]; Name: Text[250]; Replace: Boolean): Text[250]
    begin
        EmailBuffer.SetRange(Name, Name);
        if EmailBuffer.FindFirst and (EmailBuffer.Value <> '') then begin
            if Replace then
                Value := '';
            if Value <> '' then
                Value += ';';
            Value += EmailBuffer.Value;
        end;
    end;

    local procedure GetSellToCustEmailAddress(RecordVariant: Variant; BillToCustomerNo: Code[20]): Text
    var
        Customer: Record Customer;
        RecRef: RecordRef;
        SelllToCustomerNo: Code[20];
    begin
        DataTypeMgt.GetRecordRef(RecordVariant, RecRef);
        SelllToCustomerNo := RecRef.Field(2).Value;
        if BillToCustomerNo <> SelllToCustomerNo then
            if Customer.Get(SelllToCustomerNo) then
                exit(Customer."Bill-to E-Mail");
    end;


    procedure GetCustEmailAddress(RecordVariant: Variant; BillToCustomerNo: Code[20]): Text[250]
    var
        Customer: Record Customer;
        ReportSelections: Record "Report Selections";
        ToAddress: Text;
    begin
        if not IsPostedDoc(RecordVariant) then
            ToAddress := ReportSelections.GetCustEmailAddress(BillToCustomerNo, ReportSelections.Usage::"S.Invoice")
        else begin
            if Customer.Get(BillToCustomerNo) then
                ToAddress := Customer."Bill-to E-Mail";

            if ToAddress = '' then
                ToAddress := GetSellToCustEmailAddress(RecordVariant, BillToCustomerNo);
        end;
        exit(ToAddress);
    end;

    local procedure IsPostedDoc(RecordVariant: Variant): Boolean
    var
        RecRef: RecordRef;
    begin
        if DataTypeMgt.GetRecordRef(RecordVariant, RecRef) then
            if RecRef.Number in [
              DATABASE::"Sales Invoice Header", DATABASE::"Sales Cr.Memo Header",
              DATABASE::"Service Invoice Header", DATABASE::"Service Cr.Memo Header",
              DATABASE::"Issued Reminder Header", DATABASE::"Issued Fin. Charge Memo Header"]
            then
                exit(true);

        exit(false);
    end;
}

