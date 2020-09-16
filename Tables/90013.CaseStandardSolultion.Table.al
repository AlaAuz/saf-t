table 90013 "AUZ Case Standard Solultion"
{
    Caption = 'Case Standard Solultion';
    DrillDownPageID = "Case Standard Solutions";
    LookupPageID = "Case Standard Solutions";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "AUZ Case Header";
        }
        field(2; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "AUZ Standard Solution";
        }
        field(3; "Standard Solution Description"; Text[100])
        {
            CalcFormula = Lookup ("AUZ Standard Solution".Description WHERE("No." = FIELD("Standard Solution No.")));
            Caption = 'Standard Solution Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Standard Solution No.")
        {
            Clustered = true;
        }
    }

    procedure ShowStandardSolutionLastRelease()
    var
        StandardSolutionRelease: Record "AUZ Standard Solution Release";
        PageMgt: Codeunit "Page Management";
    begin
        TestField("Standard Solution No.");
        StandardSolutionRelease.SetCurrentKey("Date Created");
        StandardSolutionRelease.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionRelease.FindLast;
        PageMgt.PageRunModal(StandardSolutionRelease);
    end;
}