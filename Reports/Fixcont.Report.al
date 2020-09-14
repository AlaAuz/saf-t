report 50055 "Fix cont"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Fixcont.rdlc';

    dataset
    {
        dataitem("Service Contract Line"; "Service Contract Line")
        {

            trigger OnAfterGetRecord()
            begin
                //"Unit Cost" := "Line Cost" / 12 / Quantity;
                //"Sales Price" := "Line Value" / 12 / Quantity;

                "Line Cost" := "Unit Cost" * 12 * Quantity;
                Validate("Line Cost");
                "Line Value" := "Sales Price" * 12 * Quantity;
                Validate("Line Value");
                Modify(true);
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

