//ALA report 71100 "Copy Service Document 2"
report 50009 "Copy Service Document 2"
{
    Caption = 'Copy Service Document';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Alternativer)
                {
                    Caption = 'Options';
                    field(DocumentType; DocType)
                    {
                        Caption = 'Document Type';
                        OptionCaption = 'Quote,Order,Invoice,Credit Memo,Posted Shipment,Posted Invoice,Posted Credit Memo';

                        trigger OnValidate()
                        begin
                            DocNo := '';
                            ValidateDocNo;
                        end;
                    }
                    field(DocumentNo; DocNo)
                    {
                        Caption = 'Document No.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo;
                        end;
                    }
                    field(CustNo; FromServiceHeader."Customer No.")
                    {
                        Caption = 'Bill-to Customer No.';
                        Editable = false;
                    }
                    field(Name; FromServiceHeader.Name)
                    {
                        Caption = 'Bill-to Name';
                        Editable = false;
                    }
                    field(IncludeHeader_Options; IncludeHeader)
                    {
                        Caption = 'Include Header';

                        trigger OnValidate()
                        begin
                            ValidateIncludeHeader;
                        end;
                    }
                    field(RecalculateLines; RecalculateLines)
                    {
                        Caption = 'Recalculate Lines';

                        trigger OnValidate()
                        begin
                            if DocType = DocType::"Posted Shipment" then
                                RecalculateLines := true;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if DocNo <> '' then begin
                case DocType of
                    DocType::Quote:
                        if FromServiceHeader.Get(FromServiceHeader."Document Type"::Quote, DocNo) then
                            ;
                    DocType::Order:
                        if FromServiceHeader.Get(FromServiceHeader."Document Type"::Order, DocNo) then
                            ;
                    DocType::Invoice:
                        if FromServiceHeader.Get(FromServiceHeader."Document Type"::Invoice, DocNo) then
                            ;
                    DocType::"Credit Memo":
                        if FromServiceHeader.Get(FromServiceHeader."Document Type"::"Credit Memo", DocNo) then
                            ;
                    DocType::"Posted Shipment":
                        if FromServiceShptHeader.Get(DocNo) then
                            FromServiceHeader.TransferFields(FromServiceShptHeader);
                    DocType::"Posted Invoice":
                        if FromServiceInvHeader.Get(DocNo) then
                            FromServiceHeader.TransferFields(FromServiceInvHeader);
                    DocType::"Posted Credit Memo":
                        if FromServiceCrMemoHeader.Get(DocNo) then
                            FromServiceHeader.TransferFields(FromServiceCrMemoHeader);
                end;
                if FromServiceHeader."No." = '' then
                    DocNo := '';
            end;
            ValidateDocNo;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ServiceSetup.Get;
        ServiceCopySetup.Get;
        ServCopyMgt.SetProperties(
          IncludeHeader, RecalculateLines, false, false, false, ServiceCopySetup."Exact Cost Reversing Mandatory", false);
        ServCopyMgt.CopyServiceDoc(DocType, DocNo, ServiceHeader)
    end;

    var
        ServiceHeader: Record "Service Header";
        FromServiceHeader: Record "Service Header";
        FromServiceShptHeader: Record "Service Shipment Header";
        FromServiceInvHeader: Record "Service Invoice Header";
        FromServiceCrMemoHeader: Record "Service Cr.Memo Header";
        ServiceSetup: Record "Service Mgt. Setup";
        ServiceCopySetup: Record "Service Copy Setup";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        ServCopyMgt: Codeunit "Service Copy Management";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Posted Shipment","Posted Invoice","Posted Credit Memo";
        DocNo: Code[20];
        IncludeHeader: Boolean;
        RecalculateLines: Boolean;
        Text000: Label 'The price information may not be reversed correctly, if you copy a %1. If possible copy a %2 instead or use %3 functionality.';
        Text001: Label 'Undo Shipment';
        Text002: Label 'Undo Return Receipt';
        Text003: Label 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Posted Shipment,Posted Invoice,Posted Return Receipt,Posted Credit Memo';


    procedure SetServiceHeader(var NewServiceHeader: Record "Service Header")
    begin
        NewServiceHeader.TestField("No.");
        ServiceHeader := NewServiceHeader;
    end;

    local procedure ValidateDocNo()
    var
        DocType2: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo";
    begin
        if DocNo = '' then
            FromServiceHeader.Init
        else
            if FromServiceHeader."No." = '' then begin
                FromServiceHeader.Init;
                case DocType of
                    DocType::Quote,
                  DocType::Order,
                  DocType::Invoice,
                  DocType::"Credit Memo":
                        FromServiceHeader.Get(ServCopyMgt.ServiceHeaderDocType(ServiceHeader, DocType), DocNo);
                    DocType::"Posted Shipment":
                        begin
                            FromServiceShptHeader.Get(DocNo);
                            FromServiceHeader.TransferFields(FromServiceShptHeader);
                            if ServiceHeader."Document Type" in
                               [ServiceHeader."Document Type"::"Credit Memo"]
                            then begin
                                DocType2 := DocType2::"Posted Invoice";
                                Message(Text000, SelectStr(1 + DocType, Text003), SelectStr(1 + DocType2, Text003), Text001);
                            end;
                        end;
                    DocType::"Posted Invoice":
                        begin
                            FromServiceInvHeader.Get(DocNo);
                            FromServiceHeader.TransferFields(FromServiceInvHeader);
                        end;
                    DocType::"Posted Credit Memo":
                        begin
                            FromServiceCrMemoHeader.Get(DocNo);
                            FromServiceHeader.TransferFields(FromServiceCrMemoHeader);
                        end;
                end;
            end;
        FromServiceHeader."No." := '';

        IncludeHeader :=
          (DocType in [DocType::"Posted Invoice", DocType::"Posted Credit Memo"]) and
          ((DocType = DocType::"Posted Credit Memo") <>
           (ServiceHeader."Document Type" in
            [ServiceHeader."Document Type"::"Credit Memo"])) and
          (ServiceHeader."Bill-to Customer No." in [FromServiceHeader."Bill-to Customer No.", '']);
        ValidateIncludeHeader;
    end;

    local procedure LookupDocNo()
    begin
        case DocType of
            DocType::Quote,
            DocType::Order,
            DocType::Invoice,
            DocType::"Credit Memo":
                begin
                    FromServiceHeader.FilterGroup := 0;
                    FromServiceHeader.SetRange("Document Type", ServCopyMgt.ServiceHeaderDocType(ServiceHeader, DocType));
                    if ServiceHeader."Document Type" = ServCopyMgt.ServiceHeaderDocType(ServiceHeader, DocType) then
                        FromServiceHeader.SetFilter("No.", '<>%1', ServiceHeader."No.");
                    FromServiceHeader.FilterGroup := 2;
                    FromServiceHeader."Document Type" := ServCopyMgt.ServiceHeaderDocType(ServiceHeader, DocType);
                    FromServiceHeader."No." := DocNo;
                    if (DocNo = '') and (ServiceHeader."Customer No." <> '') then
                        if FromServiceHeader.SetCurrentKey("Document Type", "Customer No.") then begin
                            FromServiceHeader."Customer No." := ServiceHeader."Customer No.";
                            if FromServiceHeader.Find('=><') then;
                        end;
                    if PAGE.RunModal(0, FromServiceHeader) = ACTION::LookupOK then
                        DocNo := FromServiceHeader."No.";
                end;
            DocType::"Posted Shipment":
                begin
                    FromServiceShptHeader."No." := DocNo;
                    if (DocNo = '') and (ServiceHeader."Customer No." <> '') then
                        if FromServiceShptHeader.SetCurrentKey("Customer No.") then begin
                            FromServiceShptHeader."Customer No." := ServiceHeader."Customer No.";
                            if FromServiceShptHeader.Find('=><') then;
                        end;
                    if PAGE.RunModal(0, FromServiceShptHeader) = ACTION::LookupOK then
                        DocNo := FromServiceShptHeader."No.";
                end;
            DocType::"Posted Invoice":
                begin
                    FromServiceInvHeader."No." := DocNo;
                    if (DocNo = '') and (ServiceHeader."Customer No." <> '') then
                        if FromServiceInvHeader.SetCurrentKey("Customer No.") then begin
                            FromServiceInvHeader."Customer No." := ServiceHeader."Customer No.";
                            if FromServiceInvHeader.Find('=><') then;
                        end;
                    if PAGE.RunModal(0, FromServiceInvHeader) = ACTION::LookupOK then
                        DocNo := FromServiceInvHeader."No.";
                end;
            DocType::"Posted Credit Memo":
                begin
                    FromServiceCrMemoHeader."No." := DocNo;
                    if (DocNo = '') and (ServiceHeader."Customer No." <> '') then
                        if FromServiceCrMemoHeader.SetCurrentKey("Customer No.") then begin
                            FromServiceCrMemoHeader."Customer No." := ServiceHeader."Customer No.";
                            if FromServiceCrMemoHeader.Find('=><') then;
                        end;
                    if PAGE.RunModal(0, FromServiceCrMemoHeader) = ACTION::LookupOK then
                        DocNo := FromServiceCrMemoHeader."No.";
                end;
        end;
        ValidateDocNo;
    end;

    local procedure ValidateIncludeHeader()
    begin
        RecalculateLines := not IncludeHeader;
    end;


    procedure InitializeRequest(NewDocType: Option; NewDocNo: Code[20]; NewIncludeHeader: Boolean; NewRecalcLines: Boolean)
    begin
        DocType := NewDocType;
        DocNo := NewDocNo;
        IncludeHeader := NewIncludeHeader;
        RecalculateLines := NewRecalcLines;
    end;
}

