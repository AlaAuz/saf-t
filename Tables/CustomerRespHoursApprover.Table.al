table 50001 "Customer Resp. Hours Approver"
{

    fields
    {
        field(1; "Customer Responsible"; Code[10])
        {
            Caption = 'Kundeansvarlig';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(3; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Job No."));
        }
        field(4; "Case No."; Code[20])
        {
            Caption = 'Saksnr.';
        }
        field(5; "Quantity Submitted"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE ("Job No." = FIELD ("Job No."),
                                                                  "Job Task No." = FIELD ("Job Task No."),
                                                                  Posted = FILTER (false),
                                                                  Status = FILTER (Submitted)));
            Caption = 'Sendt antall';
            FieldClass = FlowField;
        }
        field(6; "Job Description"; Text[50])
        {
            Caption = 'Prosjektbeskrivelse';
        }
        field(7; "Job Task Description"; Text[50])
        {
            Caption = 'Prosjektoppgavebeskrivelse';
        }
    }

    keys
    {
        key(Key1; "Customer Responsible", "Job No.", "Job Task No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

