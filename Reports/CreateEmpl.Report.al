report 50013 "Create Empl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Resource; Resource)
        {

            trigger OnAfterGetRecord()
            begin
                Empl.Init;
                Empl."No." := "No.";
                Empl."First Name" := Name;
                Empl."Job Title" := "Job Title";
                Empl."Resource No." := "No.";
                Empl.Insert(true);
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
        Empl: Record Employee;
}

