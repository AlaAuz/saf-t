table 90105 "Standard Solution"
{
    Caption = 'Standard Solution';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Standard Solution List";
    LookupPageID = "Standard Solution List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                "Solution No." := "No.";
            end;
        }
        field(2; "No of Versions"; Integer)
        {
            CalcFormula = Count ("Standard Solution Release" WHERE("Standard Solution No." = FIELD("No.")));
            Caption = 'No of Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
        }
        field(5; "Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Version Tag"; Code[10])
        {
            Caption = 'Version Tag';
        }
        field(8; "Solution No."; Code[20])
        {
            Caption = 'Solution No.';
            TableRelation = "Standard Solution";

            trigger OnValidate()
            begin
                if Type = Type::Solution then
                    TestField("Solution No.", "No.")
                else
                    TestField("Solution No.");
            end;
        }
        field(9; "3. Part Integration"; Boolean)
        {
            Caption = '3. Part Integration';
        }
        field(10; "Responsible Resource No."; Code[20])
        {
            Caption = 'Responsible Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));
        }
        field(11; "Responsible Resource Name"; Text[50])
        {
            CalcFormula = Lookup (Resource.Name WHERE("No." = FIELD("Responsible Resource No.")));
            Caption = 'Responsible Resource Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Start ID"; Integer)
        {
            Caption = 'Start ID';
        }
        field(13; "End ID"; Integer)
        {
            Caption = 'End ID';
        }
        field(14; "Last Version Code"; Code[10])
        {
            CalcFormula = Max ("Standard Solution Release"."Version Code" WHERE("Standard Solution No." = FIELD("No.")));
            Caption = 'Last Version Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Helper,Solution';
            OptionMembers = " ",Helper,Solution;

            trigger OnValidate()
            var
                StandardSolution: Record "Standard Solution";
            begin
                if (xRec.Type = Type::Solution) and (Type <> Type::Solution) then begin
                    StandardSolution.SetCurrentKey("Solution No.");
                    StandardSolution.SetRange("Solution No.", "No.");
                    if not StandardSolution.IsEmpty then
                        Error(Text001, StandardSolution.FieldCaption("Solution No."), "Solution No.");
                end;

                if (Type = Type::Solution) and (xRec.Type <> Type::Solution) then
                    "Solution No." := "No."
            end;
        }
        field(16; "Extended Description"; BLOB)
        {
            Caption = 'Extended Description';
        }
        field(17; Importance; Option)
        {
            Caption = 'Importance';
            OptionCaption = ' ,Low,High';
            OptionMembers = " ",Low,High;
        }
        field(18; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionCaption = ' ,Table,Page/Form,Report,Codeunit,Query,XMLport';
            OptionMembers = " ","Table","Page/Form","Report","Codeunit","Query","XMLport";
        }
        field(19; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(20; "AppSource Prefix / Suffix"; Code[10])
        {
            Caption = 'AppSource Prefix / Suffix';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ("AppSource Prefix / Suffix" <> '') and ("Prefix / Suffix" = '') then
                    "Prefix / Suffix" := "AppSource Prefix / Suffix" + 'P';
            end;
        }
        field(21; "Prefix / Suffix"; Code[10])
        {
            Caption = 'Prefix / Suffix';
            DataClassification = ToBeClassified;
        }
        field(22; "AppSource Start ID"; Integer)
        {
            Caption = 'AppSource Start ID';
            DataClassification = ToBeClassified;
        }
        field(23; "AppSource End ID"; Integer)
        {
            Caption = 'AppSource End ID';
            DataClassification = ToBeClassified;
        }
        field(24; "Obsolete State"; Option)
        {
            Caption = 'Obsolete State';
            DataClassification = ToBeClassified;
            OptionCaption = 'No,Pending,Removed';
            OptionMembers = No,Pending,Removed;
        }
        field(25; "Obsolete Reason"; Text[100])
        {
            Caption = 'Obsolete Reason';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Solution No.")
        {
        }
        key(Key3; Type, "Start ID", "End ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "No of Versions", Name)
        {
        }
    }

    trigger OnDelete()
    var
        StandardSolutionRelease: Record "Standard Solution Release";
        StandardSolutionTodo: Record "Standard Solution To-do";
    begin
        CheckChangePermissions(ChangeType::Deletion);

        StandardSolutionRelease.SetRange("Standard Solution No.", "No.");
        StandardSolutionRelease.DeleteAll(true);

        StandardSolutionTodo.SetRange("Standard Solution No.", "No.");
        StandardSolutionTodo.DeleteAll(true);
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
    end;

    var
        StandardSolutionSetup: Record "Standard Solution Setup";
        StandardSolutionMgt: Codeunit "Standard Solution Management";
        ChangeType: Option Insertion,Modification,Deletion;
        Text001: Label 'There are standard solutions with %1 %2.';

    local procedure InitInsert()
    begin
        TestField("No.");
        "Date Modified" := Today;
        "Date Created" := Today;
    end;


    procedure SetExtededDescription(NewExtendedDescription: Text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear("Extended Description");
        if NewExtendedDescription = '' then
            exit;
        TempBlob.Blob := "Extended Description";
        TempBlob.WriteAsText(NewExtendedDescription, TEXTENCODING::Windows);
        "Extended Description" := TempBlob.Blob;
        Modify;
    end;


    procedure GetExtededDescription(): Text
    var
        TempBlob: Record TempBlob temporary;
        CR: Text[1];
    begin
        CalcFields("Extended Description");
        if not "Extended Description".HasValue then
            exit('');
        CR[1] := 10;
        TempBlob.Blob := "Extended Description";
        exit(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;


    procedure CheckChangePermissions(Type: Option)
    begin
        StandardSolutionMgt.CheckChangePermissions(Rec, Type);
    end;


    procedure ShowSubSolutions()
    var
        StandardSolution: Record "Standard Solution";
    begin
        StandardSolution.FilterGroup(2);
        StandardSolution.SetRange("Solution No.", "No.");
        StandardSolution.FilterGroup(0);
        PAGE.RunModal(PAGE::"Standard Solution List", StandardSolution);
    end;


    procedure ShowFileEntries()
    var
        ExternalFileEntry: Record "External File";
    begin
        ExternalFileEntry.SetRange("Record ID", RecordId);
        PAGE.Run(0, ExternalFileEntry);
    end;
}

