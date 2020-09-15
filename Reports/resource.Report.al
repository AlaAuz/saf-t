report 50018 resource
{
    DefaultLayout = RDLC;
    RDLCLayout = './resource.rdlc';

    dataset
    {
        dataitem("Case Header"; "Case Header")
        {

            trigger OnAfterGetRecord()
            begin
                if Resource.Get("Resource No.") then begin
                    Validate("Resource No.");
                    Modify;
                end;
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
        Resource: Record Resource;
}

