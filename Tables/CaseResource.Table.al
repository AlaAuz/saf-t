table 90004 "Case Resource"
{
    Caption = 'Case Resource';
    DrillDownPageID = "Case Resource List";
    LookupPageID = "Case Resource List";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            NotBlank = true;
            TableRelation = "Case Header";
        }
        field(2; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            NotBlank = true;
            TableRelation = Resource;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Resource No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

