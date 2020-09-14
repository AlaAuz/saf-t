report 60006 "Corr Resource"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CorrResource.rdlc';

    dataset
    {
        dataitem("Case Header"; "Case Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Case Header".Validate("Resource No.");
                "Case Header".Modify;
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

