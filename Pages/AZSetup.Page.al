page 50000 "AZ Setup"
{
    // *** Auzilium AS ***
    // AZ10039 04.06.2014 EVA New field, Deviation Nos.
    // AZ10040 04.06.2014 EVA New field, ECO Nos.
    // AZ10009 03.07.2014 EVA New fields, SalesTab
    // AZ10065 08.07.2014 EVA Added, Cage Code
    // AZ10058 16.07.2014 EVA Added "Item Label Report No."
    // AZ10081 06.08.2014 EVA Added "Use Workdate For Shipment"
    // AZ10082 06.08.2014 EVA Added "Use Workdate For Receipt"
    // AZ10023 07.08.2014 EVA New fields Item Drawing Path and "Serial No. Documentation Path"
    // AZ10403 04.06.2015 HHV Added production improvement (PI) nos. field.
    // AZ10383 11.06.2015 HHV Added field "Rep. Purch. Order Deliv. Text".
    // AZ10414 15.06.2015 HHV Added group JobQueueTab.
    // AZFD1.0 25.06.2015 HHV Added field "Use Fixed Lead Time" (AZ10437).
    // AZFD1.0 09.09.2015 HHV Moved fields "Fixed Lead Time" to "Future Demand Setup".
    // AZ10557 10.09.2015 HHV Added field "Has Expiration Date".
    // AZ10606 02.10.2015 HHV Added field "Customer Dimension" and created a group for customized solutions (Prox).
    // AZ10684 30.10.2015 HHV Added changes from Neo
    // -->
    // AZ10639 09.10.2015 HHV Added field "Fault Area Warranty Code".
    // AZ10577 09.10.2015 HHV Added field "Serial No. Files Path".
    // AZ10650 13.10.2015 HHV Added field "Use Workdate when Pick".
    // AZ10579 14.10.2015 HHV Added field "Report Output Show SN Info.".
    // <--
    // AZ10724 02.11.2015 HHV Code from AZ10639 is not in use. Set "Fault Area Warranty Code" property Visible to false.
    // AZ99999 29.12.2015 HHV Changed object name to AZ Setup from AZ Solutions Setup.
    // AZ11001 22.03.2016 HHV Added fields for Consumption Scanning.
    // AZ11009 23.03.2016 HHV Added field "Use Workdate in Line when Pick".
    // AZ11092 18.04.2016 HHV Added field "Use Workdate in Hdr when Con." and "Use Workdate in Line when Con.".
    // AZ11196 30.05.2016 HHV Added field "Show Comment Text".
    // AZ11201 31.05.2016 HHV Added field "Turn Around Time".
    // AZ11312 26.07.2016 HHV Added field "Software Item Nos.".
    // AZ11312 23.08.2016 HHV Added field "Create Software Item when Ship".
    // AZ11595 15.11.2016 HHV Removed template and batch field and replaced it with "Cons. Scanning No. Series".
    // AZ99999 30.01.2017 HHV Added fields "Company Language Code" and "Serv. Order Proforma Inv. No.".

    Caption = 'AZ Setup';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "AZ Setup";

    layout
    {
        area(content)
        {
            group("Økonomistyring")
            {
                Caption = 'Financial Management';
            }
            group("Salg og markedsføring")
            {
                Caption = 'Sales & Marketing';
                group(Periodisering)
                {
                    Caption = 'Accrual';
                    field("Sales Accrual Enabled"; "Sales Accrual Enabled")
                    {
                    }
                    field("Sales Accrual Bal. Account No."; "Sales Accrual Bal. Account No.")
                    {
                    }
                    field("Sales To Accrual Account No."; "Sales To Accrual Account No.")
                    {
                    }
                    field("Sales From Accrual Account No."; "Sales From Accrual Account No.")
                    {
                    }
                }
            }
            group("Kjøp")
            {
                Caption = 'Purchase';
            }
            group(Lager)
            {
                Caption = 'Warehouse';
            }
            group(Produksjon)
            {
                Caption = 'Manufacturing';
            }
            group(Ressursplanlegging)
            {
                Caption = 'Resource Planning';
            }
            group(Service)
            {
                Caption = 'Service';
                group(Control1000000008)
                {
                    Caption = 'Accrual';
                    field("Service Accrual Enabled"; "Service Accrual Enabled")
                    {
                    }
                    field("Serv. Accrual Bal. Account No."; "Serv. Accrual Bal. Account No.")
                    {
                    }
                    field("Service To Accrual Account No."; "Service To Accrual Account No.")
                    {
                    }
                    field("Serv. From Accrual Account No."; "Serv. From Accrual Account No.")
                    {
                    }
                }
            }
            group(AdministrationTab)
            {
                Caption = 'Administration';
            }
            group("AZ-løsninger")
            {
                Caption = 'AZ Solutions';
            }
            group("Jobbkø")
            {
                Caption = 'Job Queue';
            }
            group(Rollesenter)
            {
                Caption = 'Role Center';
                group(Salgsgraf)
                {
                    Caption = 'Sales Chart';
                    field("Sales Chart G/L Account Filter"; "Sales Chart G/L Account Filter")
                    {
                        Caption = 'G/L Account Filter';
                    }
                    field("Sales Chart Budget Name"; "Sales Chart Budget Name")
                    {
                        Caption = 'Budget Name';
                    }
                    field("Check Service Period"; "Check Service Period")
                    {
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

