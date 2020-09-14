report 90011 "Fix 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fix2.rdlc';

    dataset
    {
        dataitem("Case Line"; "Case Line")
        {

            trigger OnAfterGetRecord()
            begin
                Cases.Get("Case No.");
                "Job No." := Cases."Job No.";
                "Job Task No." := Cases."Job Task No.";
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

    var
        Cases: Record "Case Header";
}

