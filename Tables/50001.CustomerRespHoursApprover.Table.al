table 50001 "AUZ Cust. Resp. Hours Approver" //FIX sjekke
{
    fields
    {
        field(1; "Customer Responsible"; Code[10])
        {
            Caption = 'Customer Responsible';
            DataClassification = CustomerContent;
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(3; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
            DataClassification = CustomerContent;
        }
        field(4; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = CustomerContent;
        }
        field(5; "Quantity Submitted"; Decimal)
        {
            CalcFormula = Sum ("Time Sheet Detail".Quantity WHERE("Job No." = FIELD("Job No."),
                                                                  "Job Task No." = FIELD("Job Task No."),
                                                                  Posted = FILTER(false),
                                                                  Status = FILTER(Submitted)));
            Caption = 'Quantity Submitted';
            FieldClass = FlowField;
        }
        field(6; "Job Description"; Text[100])
        {
            Caption = 'Job Description';
            DataClassification = CustomerContent;
        }
        field(7; "Job Task Description"; Text[100])
        {
            Caption = 'Job Task Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Customer Responsible", "Job No.", "Job Task No.")
        {
            Clustered = true;
        }
    }
}