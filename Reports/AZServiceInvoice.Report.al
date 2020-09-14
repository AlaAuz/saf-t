report 50004 "AZ Service Invoice"
{
    // *** Auzilium AS ***
    // AZ12786 03.01.2018 DHG Added code to merge lines.
    DefaultLayout = RDLC;
    RDLCLayout = './AZServiceInvoice.rdlc';

    Caption = 'Invoice';

    dataset
    {
        dataitem(Header; "Service Invoice Header")
        {
            RequestFilterFields = "No.", "Customer No.";
            column(HeaderNo; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(HeaderDueDate; "Due Date")
            {
            }
            column(HeaderPaymentTerms; "Payment Terms Code")
            {
            }
            column(HeaderShipmentMethod; '')
            {
            }
            column(HeaderShippingAgent; ShippingAgent.Name)
            {
            }
            column(HeaderExternalDocumentNo; "External Document No.")
            {
            }
            column(HeaderYourReference; "Your Reference")
            {
            }
            column(HeaderOrderNo; "Order No.")
            {
            }
            column(HeaderQuoteNo; '')
            {
            }
            column(HeaderSellToCustomerNo; "Customer No.")
            {
            }
            column(HeaderSellToContactNo; "Contact No.")
            {
            }
            column(HeaderSellToContact; "Contact Name")
            {
            }
            column(HeaderWorkDescription; '')
            {
            }
            column(KID; KID)
            {
            }
            column(SalespersonName; Salesperson.Name)
            {
            }
            column(HeaderDocumentDate; "Posting Date")
            {
            }
            column(CaptDocument; CaptDocument)
            {
            }
            column(CaptPaymentTerms; CaptPaymentTerms)
            {
            }
            column(CaptShipmentMethod; CaptShipmentMethod)
            {
            }
            column(CaptShippingAgent; CaptShippingAgent)
            {
            }
            column(CaptShippingService; CaptShippingService)
            {
            }
            column(CaptDueDate; CaptDueDate)
            {
            }
            column(CaptCustomerNo; CaptCustomerNo)
            {
            }
            column(CaptContact; CaptContact)
            {
            }
            column(CaptOurRef; CaptOurRef)
            {
            }
            column(CaptYourRef; CaptYourRef)
            {
            }
            column(CaptBasedOn; CaptBasedOn)
            {
            }
            column(CaptOrder; CaptOrder)
            {
            }
            column(CaptQuote; CaptQuote)
            {
            }
            column(CaptShpt; CaptShpt)
            {
            }
            column(CaptExternalDocumentNo; CaptExternalDocumentNo)
            {
            }
            column(CaptDate; CaptPostingDate)
            {
            }
            column(CaptGLN; CaptGLN)
            {
            }
            column(CaptWorkDescription; CaptWorkDescription)
            {
            }
            column(CaptReference; CaptReference)
            {
            }
            column(CaptDocumentDate; CaptDocumentDate)
            {
            }
            column(CaptPeriod; CaptPeriod)
            {
            }
            column(FirstAddrCapt; FirstAddrCapt)
            {
            }
            column(FirstAddr1; FirstAddr[1])
            {
            }
            column(FirstAddr2; FirstAddr[2])
            {
            }
            column(FirstAddr3; FirstAddr[3])
            {
            }
            column(FirstAddr4; FirstAddr[4])
            {
            }
            column(FirstAddr5; FirstAddr[5])
            {
            }
            column(FirstAddr6; FirstAddr[6])
            {
            }
            column(FirstAddr7; FirstAddr[7])
            {
            }
            column(FirstAddr8; FirstAddr[8])
            {
            }
            column(FirstAddrPhoneNo; FirstAddrPhoneNo)
            {
            }
            column(FirstAddrEMail; FirstAddrEMail)
            {
            }
            column(FirstAddrVATRegNo; FirstAddrVATRegNo)
            {
            }
            column(ShowSecondAddr; ShowSecondAddr)
            {
            }
            column(SecondAddrCapt; SecondAddrCapt)
            {
            }
            column(SecondAddr1; SecondAddr[1])
            {
            }
            column(SecondAddr2; SecondAddr[2])
            {
            }
            column(SecondAddr3; SecondAddr[3])
            {
            }
            column(SecondAddr4; SecondAddr[4])
            {
            }
            column(SecondAddr5; SecondAddr[5])
            {
            }
            column(SecondAddr6; SecondAddr[6])
            {
            }
            column(SecondAddr7; SecondAddr[7])
            {
            }
            column(SecondAddr8; SecondAddr[8])
            {
            }
            column(SecondAddrPhoneNo; SecondAddrPhoneNo)
            {
            }
            column(SecondAddrEMail; SecondAddrEMail)
            {
            }
            column(SecondAddrVATRegNo; SecondAddrVATRegNo)
            {
            }
            column(ShowThirdAddr; ShowThirdAddr)
            {
            }
            column(ThirdAddrCapt; ThirdAddrCapt)
            {
            }
            column(ThirdAddr1; ThirdAddr[1])
            {
            }
            column(ThirdAddr2; ThirdAddr[2])
            {
            }
            column(ThirdAddr3; ThirdAddr[3])
            {
            }
            column(ThirdAddr4; ThirdAddr[4])
            {
            }
            column(ThirdAddr5; ThirdAddr[5])
            {
            }
            column(ThirdAddr6; ThirdAddr[6])
            {
            }
            column(ThirdAddr7; ThirdAddr[7])
            {
            }
            column(ThirdAddr8; ThirdAddr[8])
            {
            }
            column(ThirdAddrPhoneNo; ThirdAddrPhoneNo)
            {
            }
            column(ThirdAddrEMail; ThirdAddrEMail)
            {
            }
            column(ThirdAddrVATRegNo; ThirdAddrVATRegNo)
            {
            }
            column(ShptDocumentNo; SalesShptHeader."No.")
            {
            }
            column(FooterText; FooterText)
            {
            }
            column(CaptItemNo; CaptItemNo)
            {
            }
            column(CaptDesc; CaptDesc)
            {
            }
            column(CaptQty; CaptQty)
            {
            }
            column(CaptUnitOfMeasure; CaptUnitOfMeasure)
            {
            }
            column(CaptUnitPrice; CaptUnitPriceText)
            {
            }
            column(CaptDiscount; CaptDiscountText)
            {
            }
            column(CaptLineAmountPer; CaptLineAmountPer)
            {
            }
            column(CaptLineAmount; CaptLineAmount)
            {
            }
            column(CaptServItemNo; CaptServItemNo)
            {
            }
            column(CaptSerialNo; CaptSerialNo)
            {
            }
            column(CaptServiceItemSerialNo; CaptServiceItemSerialNo)
            {
            }
            column(TxtDocumentHeader; StrSubstNo(TxtDocumentHeader, Header."No."))
            {
            }
            column(TxtPage; TxtPage)
            {
            }
            dataitem(TempLine; "Service Invoice Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                DataItemTableView = SORTING ("Document No.", "Line No.") WHERE ("Show on Print" = CONST (true));
                UseTemporary = true;
                column(LineLineNo; "Line No.")
                {
                }
                column(LineType; Type)
                {
                }
                column(LineNo; "No.")
                {
                }
                column(LineDescription; Description)
                {
                }
                column(LineDescription2; "Description 2")
                {
                }
                column(LineUnitOfMeasureCode; "Unit of Measure Code")
                {
                }
                column(LineQuantity; Quantity)
                {
                }
                column(LineUnitPrice; "Unit Price")
                {
                    AutoFormatExpression = '<precision,2:2><standard format,0>';
                    AutoFormatType = 10;
                }
                column(LineDiscountPct; "Line Discount %")
                {
                }
                column(LineLineAmountPer; LineAmountPer)
                {
                }
                column(LineLineAmount; "Line Amount")
                {
                    AutoFormatExpression = '<precision,2:2><standard format,0>';
                    AutoFormatType = 10;
                }
                column(LineTariffCountryOfOrigin; TariffCountryOfOrigin)
                {
                }
                column(ShowDiscountOnLine; ShowDiscountOnLine)
                {
                }
                column(LineServiceItemSerialNo; "Service Item Serial No.")
                {
                }
                column(LineServiceItemNo; "Service Item No.")
                {
                }
                column(ShowPeriod; ShowPeriod)
                {
                }
                dataitem(ExtendedTextHeader; "Extended Text Header")
                {
                    DataItemLink = "No." = FIELD ("No.");
                    DataItemTableView = SORTING ("Table Name", "No.", "Language Code", "Text No.") WHERE ("Table Name" = CONST (Item));
                    dataitem(ExtendedTextLine; "Extended Text Line")
                    {
                        DataItemLink = "Table Name" = FIELD ("Table Name"), "No." = FIELD ("No."), "Language Code" = FIELD ("Language Code"), "Text No." = FIELD ("Text No.");
                        DataItemTableView = SORTING ("Table Name", "No.", "Language Code", "Text No.", "Line No.");
                        column(ExtendedTextLineLineNo; "Line No.")
                        {
                        }
                        column(ExtendedTextLineTextNo; "Text No.")
                        {
                        }
                        column(ExtendedTextLineText; Text)
                        {
                        }
                    }
                }
                dataitem(ValueEntry; "Value Entry")
                {
                    DataItemLink = "Document No." = FIELD ("Document No.");
                    DataItemTableView = SORTING ("Document No.") WHERE ("Document Type" = CONST ("Sales Invoice"));
                    dataitem(ItemLedgEntry; "Item Ledger Entry")
                    {
                        DataItemLink = "Entry Type" = FIELD ("Item Ledger Entry Type"), "Entry No." = FIELD ("Item Ledger Entry No.");
                        DataItemTableView = SORTING ("Entry No.") WHERE ("Document Type" = CONST ("Sales Shipment"));
                        column(ItemLedgEntryEntryNo; ItemLedgEntry."Entry No.")
                        {
                        }
                        column(ItemLedgEntryDocumentNo; ItemLedgEntry."Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            BasedOnExists := true;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ShowPeriod := false;
                    VATAmountLine.Init;
                    VATAmountLine."VAT Identifier" := "VAT Identifier";
                    VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    VATAmountLine."Tax Group Code" := "Tax Group Code";
                    VATAmountLine."VAT %" := "VAT %";
                    VATAmountLine."VAT Base" := Amount;
                    VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    VATAmountLine."Line Amount" := "Line Amount";
                    if "Allow Invoice Disc." then
                        VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    //VATAmountLine.InsertLine2;

                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                    if Quantity <> 0 then
                        LineAmountPer := "Line Amount" / Quantity
                    else
                        LineAmountPer := "Line Amount";

                    Item.Init;
                    if Type = Type::Item then
                        if Item.Get("No.") then;

                    TariffCountryOfOrigin := '';
                    if (Item."No." <> '') and (Item."Tariff No." <> '') then begin
                        if Item."Country/Region of Origin Code" = '' then
                            Item."Country/Region of Origin Code" := CompanyInfo."Country/Region Code";

                        if not CountryRegion.Get(Item."Country/Region of Origin Code") then
                            CountryRegion.Init;

                        if CountryRegion.Name <> '' then
                            TariffCountryOfOrigin := StrSubstNo(TxtTariffCountryOfOrigin, Item."Tariff No.", CountryRegion.Name);
                    end;

                    if Type = Type::"G/L Account" then
                        "No." := '';

                    if Type = Type::" " then
                        "Service Item Serial No." := '';

                    if "Service Item No." <> '' then
                        ServiceItem.Get("Service Item No.")
                    else
                        ServiceItem.Init;

                    if not ShowExtendedText then
                        if TempLine."Serv. Contract Line From Date" <> 0D then
                            if TempLine."Serv. Contract Line From Date" <> CalcDate('<-CM>', TempLine."Serv. Contract Line From Date") then
                                ShowExtendedText := true;

                    if TempLine."No." = '' then begin
                        if DescriptionText = TempLine.Description then
                            ShowPeriod := false
                        else
                            ShowPeriod := true;

                        DescriptionText := TempLine.Description
                    end else begin
                        ShowPeriod := true;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll;

                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;
                end;
            }
            dataitem(TotalLine; "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                column(TotalLineYesNo; TotalLineYesNo)
                {
                }
                column(TotalSubTotal; TotalSubTotal)
                {
                }
                column(TotalInvDiscAmount; TotalInvDiscAmount)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(TotalAmountVAT; TotalAmountVAT)
                {
                }
                column(TotalAmountInclVAT; TotalAmountInclVAT)
                {
                }
                column(TotalInvDiscText; TotalInvDiscText)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalAfterInvDiscExclVATText; TotalAfterInvDiscExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATAmountText; VATAmountLine.VATAmountText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalLineYesNo := true;
                end;

                trigger OnPostDataItem()
                begin
                    TotalLineYesNo := false;
                end;

                trigger OnPreDataItem()
                begin
                    TotalLineYesNo := false;
                end;
            }
            dataitem(FirstInvoiceExtendedTextHeader; "Extended Text Header")
            {
                DataItemTableView = SORTING ("Table Name", "No.", "Language Code", "Text No.");
                dataitem(FirstInvoiceExtendedTextLine; "Extended Text Line")
                {
                    DataItemLink = "Table Name" = FIELD ("Table Name"), "No." = FIELD ("No."), "Language Code" = FIELD ("Language Code"), "Text No." = FIELD ("Text No.");
                    DataItemTableView = SORTING ("Table Name", "No.", "Language Code", "Text No.", "Line No.");
                    column(FirstInvoiceExtendedTextLineNo; "No.")
                    {
                    }
                    column(FirstInvoiceExtendedTextLineLanguageCode; "Language Code")
                    {
                    }
                    column(FirstInvoiceExtendedTextLineTableName; "Table Name")
                    {
                    }
                    column(FirstInvoiceExtendedTextLineLineNo; "Line No.")
                    {
                    }
                    column(FirstInvoiceExtendedTextLineTextNo; "Text No.")
                    {
                    }
                    column(FirstInvoiceExtendedTextLineText; Text)
                    {
                    }
                }
            }
            dataitem(CompanyInfo; "Company Information")
            {
                DataItemTableView = SORTING ("Primary Key");
                column(BasedOnExists; BasedOnExists)
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyInfoBankName; BankAccount.Name)
                {
                }
                column(CompanyInfoBankAccNo; BankAccount."Bank Account No.")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoEMail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoIBAN; BankAccount.IBAN)
                {
                }
                column(CompanyInfoSWIFT; BankAccount."SWIFT Code")
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CaptCompVATReg; CaptCompVATReg)
                {
                }
                column(CaptCompPhoneNo; CaptCompPhoneNo)
                {
                }
                column(CaptCompHomePage; CaptCompHomePage)
                {
                }
                column(CaptCompEMail; CaptCompEMail)
                {
                }
                column(CaptCompBankName; CaptCompBankName)
                {
                }
                column(CaptCompBankAccount; CaptCompBankAccount)
                {
                }
                column(CaptCompIBAN; CaptCompIBAN)
                {
                }
                column(CaptCompSWIFT; CaptCompSWIFT)
                {
                }
                column(CompCountry; CompCountry)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Picture);
                    FormatAddress.Company(CompanyAddr, CompanyInfo);
                end;
            }

            trigger OnAfterGetRecord()
            var
                i: Integer;
                SellToNotEqualToBillTo: Boolean;
                SellToNotEqualToShipTo: Boolean;
            begin
                SellToCustomer.Get("Customer No.");
                BillToCustomer.Get("Bill-to Customer No.");

                CurrReport.Language(Language.GetLanguageID("Language Code"));

                //FirstAddrCapt := CaptBill;
                Header."Bill-to Contact" := '';
                FormatAddress.ServiceInvBillTo(FirstAddr, Header);

                FirstAddrPhoneNo := BillToCustomer."Phone No.";
                FirstAddrEMail := BillToCustomer."E-Mail";
                FirstAddrVATRegNo := BillToCustomer."VAT Registration No.";

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalExclVATText := StrSubstNo(TotalExclVAT, GLSetup."LCY Code");
                    TotalAfterInvDiscExclVATText := StrSubstNo(TotalAfterInvDiscExclVAT, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(TotalInclVAT, GLSetup."LCY Code");
                end else begin
                    TotalExclVATText := StrSubstNo(TotalExclVAT, "Currency Code");
                    TotalAfterInvDiscExclVATText := StrSubstNo(TotalAfterInvDiscExclVAT, "Currency Code");
                    TotalInclVATText := StrSubstNo(TotalInclVAT, "Currency Code");
                end;

                BankAccount.SetRange("Currency Code", "Currency Code");
                if not BankAccount.FindFirst then
                    BankAccount.SetRange("Currency Code");

                KID := '';
                DocumentTools.SetupGiro(true, 1, "No.", "Bill-to Customer No.", GiroAmount, "Currency Code", GiroAmtKr, GiroAmtre, ChkDigit, KID, KIDError);

                if not CurrReport.Preview then
                    DocumentPrinted.Run(Header);

                if not Salesperson.Get("Salesperson Code") then
                    Salesperson.Init;

                CaptUnitPriceText := CaptUnitPrice;
                CaptDiscountText := '%';

                SalesShptHeader.SetCurrentKey("Order No.");
                SalesShptHeader.SetRange("Order No.", "Order No.");
                if not SalesShptHeader.FindLast then
                    SalesShptHeader.Init;

                BasedOnExists := "Order No." <> '';

                //AZ12786+
                MergeServiceInvoiceLines.MergeServiceInvoiceLines(TempLine, Header);
                //AZ12786-
                //FooterText := CustomExtendedTextMgt.GetCustomExtendedText(2,3,"Language Code","Document Date");
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

    trigger OnInitReport()
    begin
        GLSetup.Get;
        AZSetup.Get;
        CompanyInfo.Get;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        AZSetup: Record "AZ Setup";
        Language: Record Language;
        BankAccount: Record "Bank Account";
        Salesperson: Record "Salesperson/Purchaser";
        ShippingAgent: Record "Shipping Agent";
        BillToCustomer: Record Customer;
        SellToCustomer: Record Customer;
        SellToContact: Record Contact;
        Item: Record Item;
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesShptHeader: Record "Sales Shipment Header";
        CountryRegion: Record "Country/Region";
        ServiceItem: Record "Service Item";
        AZTools: Codeunit "EHF Tools";
        FormatAddress: Codeunit "Format Address";
        DocumentTools: Codeunit DocumentTools;
        DocumentPrinted: Codeunit "Service Inv.-Printed";
        CaptDocument: Label 'Invoice';
        CaptItemNo: Label 'No.';
        CaptDesc: Label 'Description';
        CaptQty: Label 'Qty.';
        CaptUnitOfMeasure: Label 'Unit';
        CaptUnitPrice: Label 'Price';
        CaptLineAmountPer: Label 'Price';
        CaptLineAmount: Label 'Amount';
        CaptPostingDate: Label 'Date';
        CaptCompVATReg: Label 'VAT Registration No.';
        CaptCustomerNo: Label 'Customer No';
        CaptContact: Label 'Contact';
        CaptOurRef: Label 'Our Ref';
        CaptYourRef: Label 'Your Ref';
        CaptPaymentTerms: Label 'Payment Terms';
        CaptShipmentMethod: Label 'Delivery Terms';
        CaptShippingAgent: Label 'Shipping Agent';
        CaptShippingService: Label 'Shipping Type';
        CaptDocumentDate: Label 'Invoice Date';
        EInvoiceDocumentEncode: Codeunit "E-Invoice Document Encode";
        MergeServiceInvoiceLines: Codeunit "Merge Service Invoice Lines";
        CompanyAddr: array[8] of Text[90];
        FirstAddr: array[8] of Text[90];
        SecondAddr: array[8] of Text[90];
        ThirdAddr: array[8] of Text[90];
        TotalExclVATText: Text[50];
        TotalAfterInvDiscExclVATText: Text;
        TotalInclVATText: Text[50];
        KID: Text;
        GiroAmtKr: Text[30];
        GiroAmtre: Text[30];
        ChkDigit: Text[1];
        GiroKID1: Text[25];
        ExtDocNo: Text;
        CaptPurch: Label 'Purchaser';
        CaptShip: Label 'Shipment';
        CaptBill: Label 'Invoice';
        CaptExternalDocumentNo: Label 'Purchase Order No.';
        FooterText: Text;
        FirstAddrCapt: Text;
        FirstAddrPhoneNo: Text[30];
        FirstAddrEMail: Text[80];
        FirstAddrVATRegNo: Text[20];
        SecondAddrCapt: Text;
        SecondAddrPhoneNo: Text[30];
        SecondAddrEMail: Text[80];
        SecondAddrVATRegNo: Text[20];
        ThirdAddrCapt: Text;
        ThirdAddrPhoneNo: Text[30];
        ThirdAddrEMail: Text[80];
        ThirdAddrVATRegNo: Text[20];
        CaptUnitPriceText: Text;
        CaptDiscountText: Text;
        TariffCountryOfOrigin: Text;
        GiroAmount: Decimal;
        CaptDueDate: Label 'Due';
        CaptOurOrderNo: Label 'Our Order No.';
        CaptBasedOn: Label 'Based On';
        CaptOrder: Label 'Order';
        CaptQuote: Label 'Quote';
        CaptShpt: Label 'Shipment';
        CaptGLN: Label 'GLN';
        CaptWorkDescription: Label 'Work Description';
        LineAmountPer: Decimal;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        KIDError: Boolean;
        TotalLineYesNo: Boolean;
        BasedOnExists: Boolean;
        ShowSecondAddr: Boolean;
        ShowThirdAddr: Boolean;
        ShowContact: Boolean;
        CaptServItemNo: Label 'Service Item';
        CaptSerialNo: Label 'Serial No.';
        CaptReturnHook: Label 'Return Hook';
        CaptExchangeHook: Label 'Exchange Hook';
        CaptBank: Label 'Bank %1';
        CaptServiceItemSerialNo: Label 'Serv. Item S. No.';
        TotalInclVAT: Label 'Total %1 Incl. VAT';
        TotalExclVAT: Label 'Total %1 Excl. VAT';
        TotalAfterInvDiscExclVAT: Label 'Total %1 After Discount Excl. VAT';
        TotalText: Label 'Total %1';
        TotalInvDiscText: Label 'Invoice Discount';
        TxtTariffCountryOfOrigin: Label 'HS Code: %1 Country Of Origin: %2';
        ShowDiscountOnLine: Boolean;
        ShowExtendedText: Boolean;
        CaptReference: Label 'Reference';
        CaptCompPhoneNo: Label 'Phone No.';
        CaptCompHomePage: Label 'Home Page';
        CaptCompEMail: Label 'E-Mail';
        CaptCompBankName: Label 'Bank';
        CaptCompBankAccount: Label 'Bank Account No.';
        CaptCompIBAN: Label 'IBAN';
        CaptCompSWIFT: Label 'SWIFT Code';
        CompCountry: Label 'Norway';
        TxtDocumentHeader: Label 'Invoice %1';
        TxtPage: Label 'Page %1 of %2';
        CaptPeriod: Label 'Period';
        ShowPeriod: Boolean;
        DescriptionText: Text;
}

