table 90004 "AUZ Case Resource"
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
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(2; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            NotBlank = true;
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Resource No.")
        {
            Clustered = true;
        }
    }
}