report 50005 Fix3
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fix3.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                Customer."Consultant ID" := Customer."Salesperson Code";
                Customer.Modify;
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
}

