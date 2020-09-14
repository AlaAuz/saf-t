tableextension 90001 "AUZ Job Task" extends "Job Task"
{
    fields
    {
        field(50000; "Budgeted Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum ("Job Planning Line".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  "Job Task No." = FIELD (FILTER (Totaling)),
                                                                  "Contract Line" = CONST (true),
                                                                  "Planning Date" = FIELD ("Planning Date Filter")));
            Caption = 'Budgeted Quantity';
            Description = 'AZ99999';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Invoiced Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Invoiced Amount';
            Description = 'AZ99999';
        }
        field(50002; "Line Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Line Amount';
            Description = 'AZ99999';
        }
        field(90000; "Non-Transferred Case Hours"; Decimal)
        {
            CalcFormula = Sum ("Case Line".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                          "Job Task No." = FIELD ("Job Task No."),
                                                          Transferred = CONST (false)));
            Caption = 'Non-Transferred Case Hours';
            Description = 'AZ99999';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90001; "Non-Posted Case Hours"; Decimal)
        {
            CalcFormula = Sum ("Case Line".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                          "Job Task No." = FIELD ("Job Task No."),
                                                          Posted = CONST (false)));
            Caption = 'Non-Posted Case Hours';
            Description = 'AZ99999';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

