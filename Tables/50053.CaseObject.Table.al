table 50053 "AUZ Case Object"
{
    Caption = 'Case Object';
    DrillDownPageID = "AUZ Case Object List";
    LookupPageID = "AUZ Case Object List";

    fields
    {
        field(1; "Case No."; Code[20])
        {
            Caption = 'Case No.';
            TableRelation = "AUZ Case Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Import Datetime"; DateTime)
        {
            Caption = 'Import Datetime';
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Tabledata,"Table",Form,"Report",Dataport,"Codeunit","XMLPort",Menusuite,"Page",System,Fieldnumber;
            DataClassification = CustomerContent;
        }
        field(5; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(7; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = CustomerContent;
        }
        field(8; Compiled; Boolean)
        {
            Caption = 'Compiled';
            DataClassification = CustomerContent;
        }
        field(9; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(10; Time; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(11; "Version List"; Text[80])
        {
            Caption = 'Version List';
            DataClassification = CustomerContent;
        }
        field(12; Caption; Text[50])
        {
            Caption = 'Caption';
            DataClassification = CustomerContent;
        }
        field(13; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Case No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure ObjectImport()
    var
        CaseNote: Page "AUZ Case Note";
        MyNote: Text;
        CaseNoHandleObjects: Codeunit "AUZ Case Handle Objects";
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