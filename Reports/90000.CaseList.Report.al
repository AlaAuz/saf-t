report 90000 "Case List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CaseList.rdlc';
    Caption = 'Case List';

    dataset
    {
        dataitem(CaseHeader; "AUZ Case Header")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Resource Search Text", "Completed Date";
            column(ResourceNo_CaseHeader; CaseHeader."Resource No.")
            {
                IncludeCaption = true;
            }
            column(ResourceName_CaseHeader; CaseHeader."Resource Name")
            {
                IncludeCaption = true;
            }
            column(ContactCompanyNo_CaseHeader; CaseHeader."Contact Company No.")
            {
                IncludeCaption = true;
            }
            column(ContactCompanyName_CaseHeader; CaseHeader."Contact Company Name")
            {
                IncludeCaption = true;
            }
            column(CaseNo_CaseHeader; CaseHour."Case No.")
            {
                IncludeCaption = true;
            }
            column(DateClosed_CaseHeader; CaseHeader."Completed Date")
            {
                IncludeCaption = true;
            }
            column(Status_CaseHeader; CaseHeader.Status)
            {
                IncludeCaption = true;
            }
            column(Comment_CaseHeader; CaseHeader.Comment)
            {
                IncludeCaption = true;
            }
            column(Description_CaseHeader; CaseHeader.Description)
            {
                IncludeCaption = true;
            }
            column(StatusDevelopment_CaseHeader; CaseHeader."Development Status")
            {
                IncludeCaption = true;
            }
            column(StandardSolutionNo_CaseHeader; CaseHeader."Standard Solution No.")
            {
                IncludeCaption = true;
            }
            column(CaptDate; CaptDate)
            {
            }
            column(CaptType; CaptType)
            {
            }
            dataitem(CaseHour; "AUZ Case Line")
            {
                DataItemLink = "Case No." = FIELD ("No.");
                RequestFilterFields = Date, "Resource No.";
                column(LineNo_CaseHour; CaseHour."Line No.")
                {
                    IncludeCaption = true;
                }
                column(Date_CaseHour; CaseHour.Date)
                {
                    IncludeCaption = true;
                }
                column(Description_CaseHour; CaseHour.Description)
                {
                    IncludeCaption = true;
                }
                column(WorkType_CaseHour; CaseHour."Work Type")
                {
                    IncludeCaption = true;
                }
                dataitem(CaseHourDescription; "AUZ Case Line Description")
                {
                    DataItemLink = "Case No." = FIELD ("Case No."), "Case Line No." = FIELD ("Line No.");
                    column(LineNo_CaseHourDescription; CaseHourDescription."Line No.")
                    {
                    }
                    column(Description_CaseHourDescription; CaseHourDescription.Description)
                    {
                    }
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

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

    var
        CaptDate: Label 'Date';
        CaptType: Label 'Type';
}

