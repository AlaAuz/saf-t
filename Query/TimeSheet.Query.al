query 50001 "Time Sheet"
{

    elements
    {
        dataitem(Time_Sheet_Header; "Time Sheet Header")
        {
            column(Resource_No; "Resource No.")
            {
            }
            filter(Starting_Date; "Starting Date")
            {
            }
            filter(Ending_Date; "Ending Date")
            {
            }
            dataitem(Time_Sheet_Line; "Time Sheet Line")
            {
                DataItemLink = "Time Sheet No." = Time_Sheet_Header."No.";
                column(Description; Description)
                {
                }
                dataitem(Time_Sheet_Detail; "Time Sheet Detail")
                {
                    DataItemLink = "Time Sheet No." = Time_Sheet_Line."Time Sheet No.", "Time Sheet Line No." = Time_Sheet_Line."Line No.";
                    column(Date; Date)
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                }
            }
        }
    }
}

