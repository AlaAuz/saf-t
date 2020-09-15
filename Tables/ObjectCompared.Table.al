//table 70001 "Object Compared" //ALA
table 50006 "Object Compared"
{
    Caption = 'Case - Objects';

    fields
    {
        field(1; "Line No."; Integer)
        {
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
        field(70004; "Type 2"; Option)
        {
            Caption = 'Type';
            OptionMembers = Tabledata,"Table",Form,"Report",Dataport,"Codeunit","XMLPort",Menusuite,"Page",System,Fieldnumber;
        }
        field(70005; "ID 2"; Integer)
        {
            Caption = 'ID';
        }
        field(70006; "Name 2"; Text[50])
        {
            Caption = 'Name';
        }
        field(70007; "Modified 2"; Boolean)
        {
            Caption = 'Modified';
        }
        field(70008; "Compiled 2"; Boolean)
        {
            Caption = 'Compiled';
        }
        field(70009; "Date 2"; Date)
        {
            Caption = 'Date';
        }
        field(70010; "Time 2"; Time)
        {
            Caption = 'Time';
        }
        field(70011; "Version List 2"; Text[80])
        {
            Caption = 'Version List';
        }
        field(70012; "Caption 2"; Text[50])
        {
            Caption = 'Caption';
        }
        field(80000; Status; Option)
        {
            OptionMembers = " ",Identical,Mismatch,Create;
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
            //CaseNoHandleObjects.SetToDoEntryNo("Case No.");
            CaseNoHandleObjects.ReadText(MyNote);
        end;
    end;
}

