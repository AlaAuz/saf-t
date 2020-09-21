report 50096 "AUZ Order Confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layouts/AZOrderConfirmation.rdlc';

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            column(HeaderNo; Header."No.")
            {
            }
            column(HeaderPaymentTerms; Header."Payment Terms Code")
            {
            }
            column(HeaderShipmentMethod; Header."Shipment Method Code")
            {
            }
            column(HeaderTransportMethod; Header."Transport Method")
            {
            }
            column(HeaderShippingAgent; Header."Shipping Agent Code")
            {
            }
            column(HeaderBillToCustomerNo; Header."Bill-to Customer No.")
            {
            }
            column(HeaderVATRegistrationNo; Header."VAT Registration No.")
            {
            }
            column(HeaderDocumentDate; Header."Document Date")
            {
            }
            column(HeaderYourReference; Header."Your Reference")
            {
            }
            column(HeaderExternalDocumentNo; Header."External Document No.")
            {
            }
            column(CaptHeaderPaymentTerms; CaptHeaderPaymentTerms)
            {
            }
            column(CaptHeaderShipmentMethod; CaptHeaderShipmentMethod)
            {
            }
            column(CaptTransportMethod; CaptTransportMethod)
            {
            }
            column(CaptHeaderShippingAgent; CaptHeaderShippingAgent)
            {
            }
            column(CaptBillTo; CaptBillTo)
            {
            }
            column(CaptCustomerVATRegNo; CaptCustomerVATRegNo)
            {
            }
            column(CaptYourReferecene; CaptYourReferecene)
            {
            }
            column(CaptDocumentDate; CaptDocumentDate)
            {
            }
            column(CaptShipTo; CaptShipTo)
            {
            }
            column(CaptExternalDocumentNo; CaptExternalDocumentNo)
            {
            }
            column(CaptExportLicenseNo; CaptExportLicenseNo)
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
            column(TxtColumnHeaderNo; TxtColumnHeaderNo)
            {
            }
            column(TxtColumnHeaderDesc; TxtColumnHeaderDesc)
            {
            }
            column(TxtColumnHeaderQty; TxtColumnHeaderQty)
            {
            }
            column(TxtColumnHeaderUnit; TxtColumnHeaderUnit)
            {
            }
            column(TxtColumnHeaderRemQty; TxtColumnHeaderRemQty)
            {
            }
            column(TxtColumnDeliveryDate; TxtColumnDeliveryDate)
            {
            }
            column(TxtColumnHeaderPos; TxtColumnHeaderPos)
            {
            }
            column(TxtColumnUnitPrice; TxtColumnUnitPrice)
            {
            }
            column(TxtColumnAmount; TxtColumnAmount)
            {
            }
            column(TxtDocumentHeader; StrSubstNo(TxtDocumentHeader, Header."No."))
            {
            }
            column(TxtPage; TxtPage)
            {
            }
            dataitem(Lines; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
                column(LineLineNo; Lines."Line No.")
                {
                }
                column(LinePosition; Lines."AUZ Case No.")
                {
                }
                column(LineDocumentNo; Lines."Document No.")
                {
                }
                column(LineType; Lines.Type)
                {
                }
                column(LineNo; Lines."No.")
                {
                }
                column(LineDescription; Lines.Description)
                {
                }
                column(LineQuantity; Lines.Quantity)
                {
                }
                column(LineUnitOfMeasure; Lines."Unit of Measure")
                {
                }
                column(LineUnitPrice; Lines."Unit Price")
                {
                }
                column(LineLineAmount; Lines."Line Amount")
                {
                }
                column(LinePlannedDeliveryDate; Lines."Shipment Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
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
                    VATAmountLine.InsertLine;

                    NNCSalesLineLineAmt += "Line Amount";
                    NNCSalesLineInvDiscAmt += "Inv. Discount Amount";

                    NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                    NNCSalesLineLineAmt += "Line Amount";
                    NNCSalesLineInvDiscAmt += "Inv. Discount Amount";

                    NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                    VATAmount := "Amount Including VAT" - Amount;

                    NNCTotalExclVAT := NNCTotalLCY;
                    NNCVATAmt := VATAmount;
                    NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                    NNCPmtDiscOnVAT := -VATDiscountAmount;

                    NNCTotalInclVAT2 := TotalAmountInclVAT;

                    NNCVATAmt2 := VATAmount;
                    NNCTotalExclVAT2 := VATBaseAmount;

                    if Type = Type::"G/L Account" then
                        "No." := '';
                end;

                trigger OnPreDataItem()
                begin
                    VATAmountLine.DeleteAll;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                end;
            }
            dataitem(TotalLines; "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                column(TotalLineYesNo; TotalLineYesNo)
                {
                }
                column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                {
                }
                column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                {
                }
                column(NNCTotalLCY; NNCTotalLCY)
                {
                }
                column(NNCTotalExclVAT; NNCTotalExclVAT)
                {
                }
                column(NNCVATAmt; NNCVATAmt)
                {
                }
                column(NNCTotalInclVAT; NNCTotalInclVAT)
                {
                }
                column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT)
                {
                }
                column(NNCTotalInclVAT2; NNCTotalInclVAT2)
                {
                }
                column(NNCVATAmt2; NNCVATAmt2)
                {
                }
                column(NNCTotalExclVAT2; NNCTotalExclVAT2)
                {
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATAmountText; VATAmountLine.VATAmountText())
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalLineYesNo := 1;
                end;
            }
            dataitem("Company Information"; "Company Information")
            {
                column(CompanyInfoPicture; "Company Information".Picture)
                {
                }
                column(CompanyInfoPhoneNo; "Company Information"."Phone No.")
                {
                }
                column(CompanyInfoFaxNo; "Company Information"."Fax No.")
                {
                }
                column(CompanyInfoVATRegNo; "Company Information"."VAT Registration No.")
                {
                }
                column(CompanyInfoBankName; BankAccount.Name)
                {
                }
                column(CompanyInfoBankAccNo; BankAccount."Bank Account No.")
                {
                }
                column(CompanyInfoHomePage; "Company Information"."Home Page")
                {
                }
                column(CompanyInfoEMail; "Company Information"."E-Mail")
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
                    FormatAddress.Company(CompanyAddr, "Company Information");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Language.Get("Language Code") then
                    CurrReport.Language(Language."Windows Language ID");

                FormatAddress.FormatAddr(FirstAddr, Header."Sell-to Customer Name", Header."Sell-to Customer Name 2", Header."Sell-to Contact", Header."Sell-to Address", Header."Sell-to Address 2",
                                         Header."Sell-to City", Header."Sell-to Post Code", Header."Sell-to County", Header."Sell-to Country/Region Code");

                FormatAddress.FormatAddr(SecondAddr, Header."Ship-to Name", Header."Ship-to Name 2", Header."Ship-to Contact", Header."Ship-to Address", Header."Ship-to Address 2",
                                         Header."Ship-to City", Header."Ship-to Post Code", Header."Ship-to County", Header."Ship-to Country/Region Code");

                FormatAddress.FormatAddr(ThirdAddr, Header."Bill-to Name", Header."Bill-to Name 2", Header."Bill-to Contact", Header."Bill-to Address", Header."Bill-to Address 2",
                                         Header."Bill-to City", Header."Bill-to Post Code", Header."Bill-to County", Header."Bill-to Country/Region Code");

                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                end;

                BankAccount.SetRange("Currency Code", "Currency Code");
                if not BankAccount.FindFirst then
                    BankAccount.SetRange("Currency Code");

                TotalLineYesNo := 0;
            end;

            trigger OnPreDataItem()
            begin
                GLSetup.Get;
            end;
        }
    }

    var
        CompanyAddr: array[8] of Text[90];
        FirstAddr: array[8] of Text[90];
        SecondAddr: array[8] of Text[90];
        ThirdAddr: array[8] of Text[90];
        Text50001: Label 'Language';
        TxtColumnHeaderPos: Label 'Pos';
        TxtColumnHeaderNo: Label 'Part No.';
        TxtColumnHeaderDesc: Label 'Description';
        TxtColumnHeaderQty: Label 'Quantity';
        TxtColumnHeaderUnit: Label 'Unit';
        TxtColumnHeaderRemQty: Label 'Rem. Qty.';
        TxtColumnDeliveryDate: Label 'Delivery Date';
        TxtColumnUnitPrice: Label 'Unit Price';
        TxtColumnAmount: Label 'Amount';
        CaptCompVATReg: Label 'VAT Registration No.';
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
        CaptHeaderPaymentTerms: Label 'Payment Terms';
        CaptHeaderShipmentMethod: Label 'Delivery Terms';
        CaptTransportMethod: Label 'Transport Method';
        CaptHeaderShippingAgent: Label 'Shipping Agent';
        CaptBillTo: Label 'Bill-to Customer No.';
        CaptCustomerVATRegNo: Label 'VAT Registration No.';
        CaptYourReferecene: Label 'Your reference';
        CaptDocumentDate: Label 'Document Date';
        FormatAddress: Codeunit "Format Address";
        LanguageCode: Code[10];
        Language: Record Language;
        CaptShipTo: Label 'Ship-to:';
        CaptExternalDocumentNo: Label 'External Doc. No.';
        CaptExportLicenseNo: Label 'Export License No.';
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        GLSetup: Record "General Ledger Setup";
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text006: Label 'Total %1';
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalLineYesNo: Integer;
        BankAccount: Record "Bank Account";
}