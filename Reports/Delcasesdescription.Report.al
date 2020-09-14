report 60002 "Del cases description"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Delcasesdescription.rdlc';

    dataset
    {
        dataitem("Case Header"; "Case Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Case Header".SaveDescriptionChangeRequest('');
                "Case Header".SaveDescriptionSolution('');
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

