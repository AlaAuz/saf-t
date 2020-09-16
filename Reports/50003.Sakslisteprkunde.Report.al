report 50003 "Saksliste pr. kunde"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sakslisteprkunde.rdlc';

    dataset
    {
        dataitem("Case Header"; "AUZ Case Header")
        {
            column(CasesNo; "Case Header"."No.")
            {
            }
            column(CasesDescription; "Case Header".Description)
            {
            }
            dataitem("Case Line"; "AUZ Case Line")
            {
                DataItemLink = "Case No." = FIELD ("No.");
                DataItemTableView = SORTING ("Case No.", "Line No.") WHERE (Chargeable = CONST (true));
                column(CaseHoursLineNo; "Case Line"."Line No.")
                {
                }
                dataitem("Case Line Description"; "AUZ Case Line Description")
                {
                    DataItemLink = "Case No." = FIELD ("Case No."), "Case Line No." = FIELD ("Line No.");
                    DataItemTableView = SORTING ("Case No.", "Case Line No.", "Line No.") WHERE (Description = FILTER (<> ''));

                    trigger OnAfterGetRecord()
                    begin
                        CaseDescription += ' ' + Description;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CaseDescription := '';
                    end;
                }
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    column(CaseHoursDate; "Case Line".Date)
                    {
                    }
                    column(CaseHoursResourceNo; "Case Line"."Resource No.")
                    {
                    }
                    column(CaseHoursWorkType; "Case Line"."Work Type")
                    {
                    }
                    column(CaseHoursQuantity; "Case Line".Quantity)
                    {
                    }
                    column(CaseHoursChargeable; "Case Line".Chargeable)
                    {
                    }
                    column(CaseDescription; CaseDescription)
                    {
                    }
                    column(SumCasesHours; SumCasesHours)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    SumCasesHours += Quantity;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SumCasesHours := 0;
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
        CaseDescription: Text;
        SumCasesHours: Decimal;
}

