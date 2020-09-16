//table 70000 "Object Compare" //ALA
table 50005 "AUZ Object Compare"
{
    Caption = 'Case - Objects';

    fields
    {
        field(1; Compare; Option)
        {
            OptionMembers = Compare1,Compare2;
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
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Identical,Mismatch,Create;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Compare, Type, ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ObjectImport(CompareType: Option Compare1,Compare2)
    var
        CaseNote: Page "Case Note";
        MyNote: Text;
    //ALA
    //HandleObjects: Codeunit "Handle Objects";
    begin
        MyNote := '';
        CaseNote.LookupMode(true);
        if ACTION::LookupOK = CaseNote.RunModal then begin
            CaseNote.GetNote(MyNote);
        end;

        Clear(CaseNote);

        if MyNote <> '' then begin
            //CaseNoHandleObjects.SetToDoEntryNo("Case No.");
            SetRange(Compare, CompareType);
            DeleteAll;

            //ALA
            //HandleObjects.SetFileName('C:\Temp\Compare' + Format(CompareType) + '.txt');
            //HandleObjects.ReadText(MyNote, CompareType);
        end;
    end;
}

