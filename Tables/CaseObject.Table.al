table 90003 "Case Object"
{
    Caption = 'Case Object';
    DrillDownPageID = "Case Object List";
    LookupPageID = "Case Object List";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "Case Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Import Datetime"; DateTime)
        {
            Caption = 'Import Datetime';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Tabledata,"Table",Form,"Report",Dataport,"Codeunit","XMLPort",Menusuite,"Page",System,Fieldnumber;
        }
        field(5; ID; Integer)
        {
            Caption = 'ID';
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(7; Modified; Boolean)
        {
            Caption = 'Modified';
        }
        field(8; Compiled; Boolean)
        {
            Caption = 'Compiled';
        }
        field(9; Date; Date)
        {
            Caption = 'Date';
        }
        field(10; Time; Time)
        {
            Caption = 'Time';
        }
        field(11; "Version List"; Text[80])
        {
            Caption = 'Version List';
        }
        field(12; Caption; Text[50])
        {
            Caption = 'Caption';
        }
        field(50001; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Case No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ObjectImport()
    var
        CaseNote: Page "Case Note";
        MyNote: Text;
        CaseNoHandleObjects: Codeunit "Case Handle Objects";
    begin
        MyNote := '';
        CaseNote.LookupMode(true);
        if ACTION::LookupOK = CaseNote.RunModal then begin
            CaseNote.GetNote(MyNote);
        end;

        Clear(CaseNote);

        if MyNote <> '' then begin
            CaseNoHandleObjects.SetCaseNo("Case No.");
            CaseNoHandleObjects.ReadText(MyNote);
        end;
    end;
}

