//table 70001 "Object Compared" //ALA
table 50006 "AUZ Object Compared"
{
    Caption = 'Case - Objects';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Tabledata,"Table",Form,"Report",Dataport,"Codeunit","XMLPort",Menusuite,"Page",System,Fieldnumber;
            DataClassification = CustomerContent;
        }
        field(3; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(4; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(5; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = CustomerContent;
        }
        field(6; Compiled; Boolean)
        {
            Caption = 'Compiled';
            DataClassification = CustomerContent;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; Time; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(9; "Version List"; Text[80])
        {
            Caption = 'Version List';
            DataClassification = CustomerContent;
        }
        field(10; Caption; Text[50])
        {
            Caption = 'Caption';
            DataClassification = CustomerContent;
        }
        field(11; "Type 2"; Option)
        {
            Caption = 'Type 2';
            OptionMembers = Tabledata,"Table",Form,"Report",Dataport,"Codeunit","XMLPort",Menusuite,"Page",System,Fieldnumber;
            DataClassification = CustomerContent;
        }
        field(12; "ID 2"; Integer)
        {
            Caption = 'ID 2';
            DataClassification = CustomerContent;
        }
        field(13; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(14; "Modified 2"; Boolean)
        {
            Caption = 'Modified 2';
            DataClassification = CustomerContent;
        }
        field(15; "Compiled 2"; Boolean)
        {
            Caption = 'Compiled';
            DataClassification = CustomerContent;
        }
        field(16; "Date 2"; Date)
        {
            Caption = 'Date 2';
            DataClassification = CustomerContent;
        }
        field(17; "Time 2"; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(18; "Version List 2"; Text[80])
        {
            Caption = 'Version List 2';
            DataClassification = CustomerContent;
        }
        field(19; "Caption 2"; Text[50])
        {
            Caption = 'Caption 2';
            DataClassification = CustomerContent;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Identical,Mismatch,Create;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, ID)
        {
        }
        key(Key3; "Type 2", "ID 2")
        {
        }
    }

    procedure ObjectImport()
    var
        CaseNote: Page "Case Note";
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
            //CaseNoHandleObjects.SetToDoEntryNo("Case No.");
            CaseNoHandleObjects.ReadText(MyNote);
        end;
    end;
}