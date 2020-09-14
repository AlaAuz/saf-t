report 50090 "Save Daniel"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SaveDaniel.rdlc';

    dataset
    {
        dataitem("Service Contract Header"; "Service Contract Header")
        {
            dataitem("Service Contract Line"; "Service Contract Line")
            {
                DataItemLink = "Contract No." = FIELD ("Contract No.");

                trigger OnAfterGetRecord()
                begin
                    "Service Contract Line"."Invoiced to Date" := 0D;
                    Modify;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Service Contract Header".Status := "Service Contract Header".Status::" ";
                "Service Contract Header"."Last Invoice Date" := 0D;
                "Service Contract Header"."Next Invoice Date" := DMY2Date(1, 7, 2018);
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

