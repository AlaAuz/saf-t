table 50101 "AUZ Standard Solution Release"
{
    // // Sett inn forrige versjonskode og oppdaterer siste versjonskode i Std. solutions-tabellen.

    Caption = 'Standard Solution Release';
    DataCaptionFields = "Standard Solution No.", Description, "Version Code";
    DrillDownPageID = "AUZ Std. Solution Release List";
    LookupPageID = "AUZ Std. Solution Release List";

    fields
    {
        field(1; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            NotBlank = true;
            TableRelation = "AUZ Standard Solution";
            DataClassification = CustomerContent;
        }
        field(2; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            CalcFormula = Lookup ("AUZ Standard Solution".Name WHERE("No." = FIELD("Standard Solution No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Previous Version Code"; Code[10])
        {
            Caption = 'Previous Version Code';
            TableRelation = "AUZ Standard Solution Release"."Version Code" WHERE("Standard Solution No." = FIELD("Standard Solution No."));
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Version Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Standard Solution No.", "Version Code", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        CheckChangePermissions(ChangeType::Deletion);
        DeleteSubRecords;
    end;

    trigger OnInsert()
    begin
        CheckChangePermissions(ChangeType::Insertion);
        InitInsert;
    end;

    trigger OnModify()
    begin
        CheckChangePermissions(ChangeType::Modification);
        "Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        CheckChangePermissions(ChangeType::Modification);
        UpdateSubRecords;
    end;

    local procedure InitInsert()
    var
        StandardSolutionRelease: Record "AUZ Standard Solution Release";
    begin
        "Date Modified" := Today;
        "Date Created" := Today;

        StandardSolutionRelease.SetCurrentKey("Date Created");
        StandardSolutionRelease.SetRange("Standard Solution No.", "Standard Solution No.");
        if StandardSolutionRelease.FindLast then
            "Previous Version Code" := StandardSolutionRelease."Version Code";
    end;

    local procedure DeleteSubRecords()
    var
        StandardSolutionContact: Record "AUZ Standard Solution Contact";
        StandardSolutionObject: Record "AUZ Standard Solution Object";
        StandardSolutionChange: Record "AUZ Standard Solution Change";
    begin
        StandardSolutionContact.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionContact.SetRange("Version Code", "Version Code");
        StandardSolutionContact.DeleteAll(true);

        StandardSolutionObject.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionObject.SetRange("Version Code", "Version Code");
        StandardSolutionObject.DeleteAll(true);

        StandardSolutionChange.SetRange("Standard Solution No.", "Standard Solution No.");
        StandardSolutionChange.SetRange("Version Code", "Version Code");
        StandardSolutionChange.DeleteAll(true);
    end;

    local procedure UpdateSubRecords()
    var
        StandardSolutionContact: Record "AUZ Standard Solution Contact";
        StandardSolutionObject: Record "AUZ Standard Solution Object";
        StandardSolutionChange: Record "AUZ Standard Solution Change";
        StandardSolutionContact2: Record "AUZ Standard Solution Contact";
        StandardSolutionObject2: Record "AUZ Standard Solution Object";
        StandardSolutionChange2: Record "AUZ Standard Solution Change";
    begin
        StandardSolutionContact.SetRange("Standard Solution No.", xRec."Standard Solution No.");
        StandardSolutionContact.SetRange("Version Code", xRec."Version Code");
        if StandardSolutionContact.FindSet then
            repeat
                StandardSolutionContact2 := StandardSolutionContact;
                StandardSolutionContact2.Rename("Standard Solution No.", "Version Code", StandardSolutionContact."Contact No.");
            until StandardSolutionContact.Next = 0;

        StandardSolutionObject.SetRange("Standard Solution No.", xRec."Standard Solution No.");
        StandardSolutionObject.SetRange("Version Code", xRec."Version Code");
        if StandardSolutionObject.FindSet then
            repeat
                StandardSolutionObject2 := StandardSolutionObject;
                StandardSolutionObject2.Rename("Standard Solution No.", "Version Code", StandardSolutionObject."Line No.");
            until StandardSolutionObject.Next = 0;

        StandardSolutionChange.SetRange("Standard Solution No.", xRec."Standard Solution No.");
        StandardSolutionChange.SetRange("Version Code", xRec."Version Code");
        if StandardSolutionChange.FindSet then
            repeat
                StandardSolutionChange2 := StandardSolutionChange;
                StandardSolutionChange2.Rename("Standard Solution No.", "Version Code", StandardSolutionChange."Line No.");
            until StandardSolutionChange.Next = 0;
    end;

    procedure CheckChangePermissions(Type: Option)
    var
        StandardSolution: Record "AUZ Standard Solution";
    begin
        StandardSolution.Get("Standard Solution No.");
        StandardSolution.CheckChangePermissions(Type);
    end;

    var
        ChangeType: Option Insertion,Modification,Deletion;
}