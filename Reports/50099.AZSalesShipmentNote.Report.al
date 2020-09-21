report 50099 "AUZ Sales Shipment Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layouts/AZSalesShipmentNote.rdlc';

    dataset
    {
        dataitem(Header; "Sales Shipment Header")
        {
            column(HeaderNo; Header."No.")
            {
            }
            column(HeaderBillToName; Header."Bill-to Name")
            {
            }
            column(HeaderShipToName; Header."Ship-to Name")
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
            column(TxtDocumentHeader; StrSubstNo(TxtDocumentHeader, Header."No."))
            {
            }
            column(TxtPage; TxtPage)
            {
            }
            dataitem(Lines; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD ("No.");
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
                column(LineQtyRemaining; Lines."Qty. Remaining")
                {
                }
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
                column(CompanyInfoGiroNo; "Company Information"."Giro No.")
                {
                }
                column(CompanyInfoBankName; "Company Information"."Bank Name")
                {
                }
                column(CompanyInfoBankAccNo; "Company Information"."Bank Account No.")
                {
                }
                column(CompanyInfoHomePage; "Company Information"."Home Page")
                {
                }
                column(CompanyInfoEMail; "Company Information"."E-Mail")
                {
                }
                column(CompanyInfoIBAN; "Company Information".IBAN)
                {
                }
                column(CompanyInfoSWIFT; "Company Information"."SWIFT Code")
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
                FormatAddress.FormatAddr(FirstAddr, Header."Ship-to Name", Header."Ship-to Name 2", Header."Ship-to Contact", Header."Ship-to Address", Header."Ship-to Address 2",
                                         Header."Ship-to City", Header."Ship-to Post Code", Header."Ship-to County", Header."Ship-to Country/Region Code");
                FormatAddress.FormatAddr(SecondAddr, Header."Sell-to Customer Name", Header."Sell-to Customer Name 2", Header."Sell-to Contact", Header."Sell-to Address", Header."Sell-to Address 2",
                                         Header."Sell-to City", Header."Sell-to Post Code", Header."Sell-to County", Header."Sell-to Country/Region Code");

                Clear(SecondAddr);

                FormatAddress.FormatAddr(ThirdAddr, Header."Bill-to Name", Header."Bill-to Name 2", Header."Bill-to Contact", Header."Bill-to Address", Header."Bill-to Address 2",
                                         Header."Bill-to City", Header."Bill-to Post Code", Header."Bill-to County", Header."Bill-to Country/Region Code");



                CurrReport.Language(1033);
            end;
        }
    }

    var
        CompanyAddr: array[8] of Text[90];
        FirstAddr: array[8] of Text[90];
        SecondAddr: array[8] of Text[90];
        ThirdAddr: array[8] of Text[90];
        FormatAddress: Codeunit "Format Address";
        Text50001: Label 'Language';
        TxtColumnHeaderNo: Label 'Item No.';
        TxtColumnHeaderDesc: Label 'Description';
        TxtColumnHeaderQty: Label 'Quantity';
        TxtColumnHeaderUnit: Label 'Unit';
        TxtColumnHeaderRemQty: Label 'Rem. Qty.';
        CaptCompVATReg: Label 'VAT Registration No.';
        CaptCompPhoneNo: Label 'Phone No.';
        CaptCompHomePage: Label 'Home Page';
        CaptCompEMail: Label 'E-Mail';
        CaptCompBankName: Label 'Bank';
        CaptCompBankAccount: Label 'Bank Account No.';
        CaptCompIBAN: Label 'IBAN';
        CaptCompSWIFT: Label 'SWIFT Code';
        CompCountry: Label 'Norway';
        TxtDocumentHeader: Label 'Shipment Note %1';
        TxtPage: Label 'Page';
        CaptHeaderPaymentTerms: Label 'Payment Terms';
        CaptHeaderShipmentMethod: Label 'Shipment Method';
        CaptTransportMethod: Label 'Transport Method';
        CaptHeaderShippingAgent: Label 'Shipping Agent';
        CaptBillTo: Label 'Bill-to Customer No.';
        CaptCustomerVATRegNo: Label 'VAT Registration No.';
}