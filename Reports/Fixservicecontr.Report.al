report 50007 "Fix service contr"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fixservicecontr.rdlc';

    dataset
    {
        dataitem("Service Contract Header"; "Service Contract Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Service Contract Header"."Next Invoice Date" := DMY2Date(1, 12, 2019);
                "Service Contract Header"."Last Invoice Date" := DMY2Date(1, 11, 2019);
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

