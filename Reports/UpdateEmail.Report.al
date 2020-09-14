report 50999 UpdateEmail
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdateEmail.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                if Customer."E-Mail" <> '' then begin
                    Customer.Validate("Bill-to E-Mail", Customer."E-Mail");
                    Customer.Validate("Distribution Type", Customer."Distribution Type"::"E-Mail");
                    Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Error('test');
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

