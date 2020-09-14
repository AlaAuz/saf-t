report 50010 Test
{
    DefaultLayout = RDLC;
    RDLCLayout = './Test.rdlc';

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            column(TimeSheetResourceNo; TimeSheet.Resource_No)
            {
            }
            column(TimeSheetDescription; TimeSheet.Description)
            {
            }
            column(TimeSheetDate; TimeSheet.Date)
            {
            }
            column(TimeSheetQuantity; TimeSheet.Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TimeSheet.Read;
            end;

            trigger OnPreDataItem()
            begin
                TimeSheet.Open;
                while TimeSheet.Read do
                    NumberOfRows += 1;
                TimeSheet.Close;

                SetRange(Number, 1, NumberOfRows);
                TimeSheet.Open;
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

    var
        TimeSheet: Query "Time Sheet";
        NumberOfRows: Integer;
}

