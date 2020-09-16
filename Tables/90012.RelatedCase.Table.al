table 90012 "AUZ Related Case"
{
    Caption = 'Related Case';
    DrillDownPageID = "Related Cases";
    LookupPageID = "Related Cases";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            NotBlank = true;
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(2; "Related Case No."; Code[20])
        {
            Caption = 'Related Case No.';
            NotBlank = true;
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Related Case No." = "Case No." then
                    FieldError("Related Case No.", StrSubstNo(SameCaseErr, FieldCaption("Case No.")));
            end;
        }
        field(3; "Related Case Description"; Text[100])
        {
            CalcFormula = Lookup ("AUZ Case Header".Description WHERE ("No." = FIELD ("Related Case No.")));
            Caption = 'Related Case Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Related Case Description");
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Related Case No.")
        {
            Clustered = true;
        }
    }

    var
        SameCaseErr: Label 'cannot be the same as %1';
}