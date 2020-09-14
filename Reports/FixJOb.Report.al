report 60011 "Fix JOb"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FixJOb.rdlc';

    dataset
    {
        dataitem("Case Line"; "Case Line")
        {

            trigger OnAfterGetRecord()
            begin
                if (not Posted) and ("Job No." = 'P1000') then begin
                    "Job No." := 'P1015';
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
}

