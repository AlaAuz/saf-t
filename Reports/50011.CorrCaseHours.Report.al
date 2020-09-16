report 50011 "Corr Case Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CorrCaseHours.rdlc';

    dataset
    {
        dataitem("Case Line"; "AUZ Case Line")
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

