table 90012 "Related Case"
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
            TableRelation = "Case Header";
        }
        field(2; "Related Case No."; Code[20])
        {
            Caption = 'Related Case No.';
            NotBlank = true;
            TableRelation = "Case Header";

            trigger OnValidate()
            begin
                if "Related Case No." = "Case No." then
                    FieldError("Related Case No.", StrSubstNo(SameCaseErr, FieldCaption("Case No.")));
            end;
        }
        field(3; "Related Case Description"; Text[50])
        {
            CalcFormula = Lookup ("Case Header".Description WHERE ("No." = FIELD ("Related Case No.")));
            Caption = 'Related Case Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                CalcFields("Related Case Description");
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Case No.", "Related Case No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SameCaseErr: Label 'cannot be the same as %1';
}

