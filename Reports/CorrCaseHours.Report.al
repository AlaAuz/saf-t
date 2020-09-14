report 60005 "Corr Case Hours"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CorrCaseHours.rdlc';

    dataset
    {
        dataitem("Case Line"; "Case Line")
        {

            trigger OnAfterGetRecord()
            begin
                "Case Line".Transferred := false;
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

