report 50001 "AUZ Case - Registered Hours"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layouts/CaseRegisteredHours.rdlc';
    Caption = 'Case - Registered Hours';

    dataset
    {
        dataitem("Case Header"; "AUZ Case Header")
        {
            RequestFilterFields = "No.", "Contact No.", "Resource No.", "Contact Company No.";
            column(CasesNo; "Case Header"."No.")
            {
            }
            column(CaseDescription; "Case Header".Description)
            {
            }
            dataitem("Case Line"; "AUZ Case Line")
            {
                DataItemLink = "Case No." = FIELD("No.");
                DataItemTableView = SORTING("Case No.", "Line No.");
                column(CaseHours_ResourceNo; "Case Line"."Resource No.")
                {
                }
                column(CaseHours_Quantity; "Case Line".Quantity)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Date, StartDate, EndDate);
                    SetFilter(Quantity, '<>0');
                end;
            }

            trigger OnPreDataItem()
            begin
                //Heading := STRSUBSTNO(text001,StartDate,EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
            }
        }
    }

    labels
    {
        LblCaseNo = 'Saksnr.';
        LblDescription = 'Description';
        LblResource = 'Ressursnr.';
        LblQty = 'Antall';
    }

    trigger OnInitReport()
    begin
        if CalcDate('<-WD1>', WorkDate) = WorkDate then
            StartDate := CalcDate('<-WD1>', WorkDate)
        else
            StartDate := CalcDate('<-2W+WD1>', WorkDate);
        EndDate := CalcDate('<-WD7>', WorkDate);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        Heading: Text[50];
        text001: Label 'Hour report from %1 to %2';
}