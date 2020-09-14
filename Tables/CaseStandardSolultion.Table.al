table 90013 "Case Standard Solultion"
{
    Caption = 'Case Standard Solultion';
    DrillDownPageID = "Case Standard Solutions";
    LookupPageID = "Case Standard Solutions";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Case Header";
        }
        field(2; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Standard Solution";
        }
        field(3; "Standard Solution Description"; Text[50])
        {
            CalcFormula = Lookup ("Standard Solution".Description WHERE ("No." = FIELD ("Standard Solution No.")));
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

    fieldgroups
    {
    }

    [Scope('Internal')]
    procedure ShowStandardSolutionLastRelease()
    var
        StandardSolutionRelease: Record "Standard Solution Release";
        PageMgt: Codeunit "Page Management";
    begin
        TestField("Standard Solution No.");
        StandardSolutionRelease.SetCurrentKey("Date Created");
        StandardSolutionRelease.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionRelease.FindLast;
        PageMgt.PageRunModal(StandardSolutionRelease);
    end;
}

