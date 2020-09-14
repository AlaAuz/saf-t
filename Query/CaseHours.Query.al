query 50002 "Case Hours"
{
    Caption = 'Case Hours';

    elements
    {
        dataitem(Case_Line; "Case Line")
        {
            column(Case_No; "Case No.")
            {
            }
            column(Resource_No; "Resource No.")
            {
            }
            column(Date; Date)
            {
            }
            column(Work_Type; "Work Type")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Transferred; Transferred)
            {
            }
            column(Chargeable; Chargeable)
            {
            }
            column(Posted; Posted)
            {
            }
            column(Reference_No; "Reference No.")
            {
            }
            dataitem(Job; Job)
            {
                DataItemLink = "No." = Case_Line."Job No.";
                column(JobNo; "No.")
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = Job."Bill-to Customer No.";
                    column(CustomerName; Name)
                    {
                    }
                }
            }
        }
    }
}

