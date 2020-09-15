report 50016 "fix contact"
{
    DefaultLayout = RDLC;
    RDLCLayout = './fixcontact.rdlc';

    dataset
    {
        dataitem(Contact; Contact)
        {
            DataItemTableView = SORTING ("No.") WHERE (Type = CONST (Person));

            trigger OnAfterGetRecord()
            begin
                if Contact."Salutation Code" = '' then begin
                    Contact."Salutation Code" := 'CONT';
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

