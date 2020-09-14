report 50000 "FIX Resource Search String"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FIXResourceSearchString.rdlc';

    dataset
    {
        dataitem("Case Header"; "Case Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Case Header".BuildResourceFilter;
                Modify;
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

