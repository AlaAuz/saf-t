report 70900 "Initialize Distribution Setup"
{
    Caption = 'Initialize Distribution Setup';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Company; Company)
        {

            trigger OnAfterGetRecord()
            begin
                with DistributionSetup do begin
                    ChangeCompany(Name);
                    if not FindFirst then begin
                        Init;
                        Insert;
                        Counter += 1;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message(Test000, Counter);
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
        DistributionSetup: Record "Distribution Setup";
        Counter: Integer;
        Test000: Label 'Distribution setup was initialized in %1 companies.';
}

