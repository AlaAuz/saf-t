report 50015 Fix
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fix.rdlc';

    dataset
    {
        dataitem("Case Line"; "Case Line")
        {

            trigger OnAfterGetRecord()
            begin
                CaseHoursDesc.Init;
                CaseHoursDesc."Case No." := "Case No.";
                CaseHoursDesc."Case Hour Line No." := "Line No.";
                CaseHoursDesc."Line No." := 10000;
                CaseHoursDesc.Description := Description;
                CaseHoursDesc.Insert;

                Description := '';
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
        CaseHoursDesc: Record "Case Hour Description";
}

