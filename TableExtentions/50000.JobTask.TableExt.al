tableextension 50000 "AUZ Job Task" extends "Job Task"
{
    fields
    {
        field(50000; "AUZ Budgeted Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum ("Job Planning Line".Quantity WHERE("Job No." = FIELD("Job No."),
                                                                  "Job Task No." = FIELD("Job Task No."),
                                                                  "Job Task No." = FIELD(FILTER(Totaling)),
                                                                  "Contract Line" = CONST(true),
                                                                  "Planning Date" = FIELD("Planning Date Filter")));
            Caption = 'Budgeted Quantity';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "AUZ Invoiced Amount"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Invoiced Amount';
        }
        field(50002; "AUZ Line Amount"; Decimal)
        {
            BlankZero = true;
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Non-Transferred Case Lines"; Decimal)
        {
            CalcFormula = Sum ("AUZ Case Line".Quantity WHERE("Job No." = FIELD("Job No."),
                                                          "Job Task No." = FIELD("Job Task No."),
                                                          Transferred = CONST(false)));
            Caption = 'Non-Transferred Case Lines';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "AUZ Non-Posted Case Lines"; Decimal)
        {
            CalcFormula = Sum ("AUZ Case Line".Quantity WHERE("Job No." = FIELD("Job No."),
                                                          "Job Task No." = FIELD("Job Task No."),
                                                          Posted = CONST(false)));
            Caption = 'Non-Posted Case Lines';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}