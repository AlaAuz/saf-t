table 90103 "AUZ Standard Solution Object"
{
    Caption = 'Standard Solution Object';

    fields
    {
        field(1; "Standard Solution No."; Code[20])
        {
            Caption = 'Standard Solution No.';
            TableRelation = "AUZ Standard Solution";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Import Datetime"; DateTime)
        {
            Caption = 'Import Date and Time';
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
        field(13; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
        field(14; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Standard Solution No.", "Version Code", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        CheckChangePermissions(ChangeType::Deletion);
    end;

    trigger OnInsert()
    begin
        CheckChangePermissions(ChangeType::Insertion);
    end;

    trigger OnModify()
    begin
        CheckChangePermissions(ChangeType::Modification);
    end;

    trigger OnRename()
    begin
        CheckChangePermissions(ChangeType::Modification);
    end;

    procedure ImportObjects()
    var
        StandardSolutionNote: Page "Standard Solution Note";
        ObjectString: Text;
    begin
        ObjectString := '';
        StandardSolutionNote.LookupMode(true);
        if StandardSolutionNote.RunModal = ACTION::LookupOK then begin
            ObjectString := StandardSolutionNote.GetText;

            Clear(StandardSolutionNote);

            if ObjectString <> '' then begin
                SetPrimaryKey("Standard Solution No.", "Version Code");
                ReadText(ObjectString);
            end;
        end;
    end;

    procedure ReadText(var ObjectsCopyPaste: Text)
    var
        MyFile: File;
        LineOfText: Char;
        i: Integer;
        CharValue: Char;
        IntegerValue: Integer;
        ArrayHeader: array[15] of Text[100];
        ArrayTableFieldName: array[15] of Integer;
        ArrayTextValue: array[20] of Text[200];
        ArrayFieldNumber: array[15] of Integer;
        TextValue: Text[200];
        MyRecRef: RecordRef;
        MyFieldRef: FieldRef;
        FirstLineRead: Boolean;
        Pos: Integer;
    begin
        ArrayIndex := 0;
        TextValue := '';

        FirstLineRead := false;
        Pos := 0;

        repeat
            Pos += 1;
            CharValue := ObjectsCopyPaste[Pos];

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;

                    TextValue := UpperCase(TextValue);
                    if TextValue in ['TYPE'] then
                        ArrayFieldNumber[ArrayIndex] := 4;
                    if TextValue in ['ID'] then
                        ArrayFieldNumber[ArrayIndex] := 5;
                    if TextValue in ['NAME'] then
                        ArrayFieldNumber[ArrayIndex] := 6;
                    if TextValue in ['MODIFIED', 'ENDRET'] then
                        ArrayFieldNumber[ArrayIndex] := 7;
                    if TextValue in ['COMPILED'] then
                        ArrayFieldNumber[ArrayIndex] := 8;
                    if TextValue in ['DATE', 'DATO'] then
                        ArrayFieldNumber[ArrayIndex] := 9;
                    if TextValue in ['TIME', 'KLOKKESLETT'] then
                        ArrayFieldNumber[ArrayIndex] := 10;
                    if TextValue in ['VERSION LIST', 'VERSONSOVERSIKT'] then
                        ArrayFieldNumber[ArrayIndex] := 11;
                    if TextValue in ['CAPTION'] then
                        ArrayFieldNumber[ArrayIndex] := 12;

                    TextValue := '';
                end;

                if CharValue in [10] then
                    FirstLineRead := true;
            end else begin
                TextValue += Format(CharValue);
            end;

        until (StrLen(ObjectsCopyPaste) = Pos) or (FirstLineRead);

        TextValue := '';
        ArrayIndex := 0;

        LineNumber := FindLineNumber();
        StandardSolutionObject.Init;
        StandardSolutionObject."Standard Solution No." := StdSolutionNo;
        StandardSolutionObject."Version Code" := VersionCode;

        InsertRecord := false;
        repeat

            Pos += 1;
            CharValue := ObjectsCopyPaste[Pos];

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;
                    case ArrayFieldNumber[ArrayIndex] of
                        4:
                            StandardSolutionObject.Type := GetInteger(TextValue);
                        5:
                            StandardSolutionObject.ID := GetInteger(TextValue);
                        6:
                            StandardSolutionObject.Name := TextValue;
                        7:
                            StandardSolutionObject.Modified := GetBoolean(TextValue);
                        8:
                            StandardSolutionObject.Compiled := GetBoolean(TextValue);
                        9:
                            StandardSolutionObject.Date := GetDate(TextValue);
                        10:
                            StandardSolutionObject.Time := GetTime(TextValue);
                        11:
                            StandardSolutionObject."Version List" := TextValue;
                        12:
                            StandardSolutionObject.Caption := TextValue;
                    end;
                end;
                TextValue := '';
                //AZ99999+
                //IF CharValue = 13 THEN BEGIN
                if CharValue = 10 then begin
                    //AZ99999-
                    InsertNewRecord();
                end;
            end else begin
                InsertRecord := true;
                TextValue += Format(CharValue);
            end;

        until (Pos >= StrLen(ObjectsCopyPaste));

        if InsertRecord then begin
            InsertNewRecord();
        end;
    end;

        procedure ReadFile(var ObjectsCopyPaste: Text)
        var
            MyFile: File;
            LineOfText: Char;
            i: Integer;
            CharValue: Char;
            IntegerValue: Integer;
            ArrayHeader: array[15] of Text[100];
            ArrayTableFieldName: array[15] of Integer;
            ArrayTextValue: array[20] of Text[200];
            ArrayFieldNumber: array[15] of Integer;
            TextValue: Text[200];
            MyRecRef: RecordRef;
            MyFieldRef: FieldRef;
            FirstLineRead: Boolean;
        begin
            ArrayIndex := 0;
            TextValue := '';

            FirstLineRead := false;

            repeat
                MyFile.Read(CharValue);

                if CharValue in [9, 10, 13] then begin
                    if CharValue = 9 then begin //TAB
                        ArrayIndex += 1;

                        TextValue := UpperCase(TextValue);
                        if TextValue in ['TYPE'] then
                            ArrayFieldNumber[ArrayIndex] := 4;
                        if TextValue in ['ID'] then
                            ArrayFieldNumber[ArrayIndex] := 5;
                        if TextValue in ['NAME'] then
                            ArrayFieldNumber[ArrayIndex] := 6;
                        if TextValue in ['MODIFIED', 'ENDRET'] then
                            ArrayFieldNumber[ArrayIndex] := 7;
                        if TextValue in ['COMPILED'] then
                            ArrayFieldNumber[ArrayIndex] := 8;
                        if TextValue in ['DATE', 'DATO'] then
                            ArrayFieldNumber[ArrayIndex] := 9;
                        if TextValue in ['TIME', 'KLOKKESLETT'] then
                            ArrayFieldNumber[ArrayIndex] := 10;
                        if TextValue in ['VERSION LIST', 'VERSONSOVERSIKT'] then
                            ArrayFieldNumber[ArrayIndex] := 11;
                        if TextValue in ['CAPTION'] then
                            ArrayFieldNumber[ArrayIndex] := 12;

                        TextValue := '';
                    end;

                    if CharValue in [10] then
                        FirstLineRead := true;
                end else begin
                    TextValue += Format(CharValue);
                end;

            until (MyFile.Pos >= MyFile.Len) or (FirstLineRead);

            TextValue := '';
            ArrayIndex := 0;

            StandardSolutionObject.Init;
            StandardSolutionObject."Standard Solution No." := StdSolutionNo;
            StandardSolutionObject."Version Code" := VersionCode;

            InsertRecord := false;
            repeat
                MyFile.Read(CharValue);

                if CharValue in [9, 10, 13] then begin
                    if CharValue = 9 then begin //TAB
                        ArrayIndex += 1;
                        case ArrayFieldNumber[ArrayIndex] of
                            4:
                                StandardSolutionObject.Type := GetInteger(TextValue);
                            5:
                                StandardSolutionObject.ID := GetInteger(TextValue);
                            6:
                                StandardSolutionObject.Name := TextValue;
                            7:
                                StandardSolutionObject.Modified := GetBoolean(TextValue);
                            8:
                                StandardSolutionObject.Compiled := GetBoolean(TextValue);
                            9:
                                StandardSolutionObject.Date := GetDate(TextValue);
                            10:
                                StandardSolutionObject.Time := GetTime(TextValue);
                            11:
                                StandardSolutionObject."Version List" := TextValue;
                            12:
                                StandardSolutionObject.Caption := TextValue;
                        end;
                    end;
                    TextValue := '';
                    if CharValue = 13 then begin
                        InsertNewRecord();
                    end;
                end else begin
                    InsertRecord := true;
                    TextValue += Format(CharValue);
                end;

            until (MyFile.Pos >= MyFile.Len);

            if InsertRecord then begin
                InsertNewRecord();
            end;
        end;


    procedure InsertNewRecord()
    begin
        LineNumber += 10000;
        StandardSolutionObject."Line No." := LineNumber;
        StandardSolutionObject."Import Datetime" := TheCurrentDateTime;
        StandardSolutionObject.Comment := '';
        StandardSolutionObject.Insert;
        ArrayIndex := 0;
        InsertRecord := false;
    end;

    procedure GetInteger(TextValue: Text[100]) IntValue: Integer
    begin
        Evaluate(IntValue, TextValue);
        exit(IntValue);
    end;

    procedure GetBoolean(TextValue: Text[100]) BoolValue: Boolean
    begin
        if UpperCase(TextValue) in ['YES', 'JA'] then
            TextValue := '1'
        else
            TextValue := '0';

        Evaluate(BoolValue, TextValue);
        exit(BoolValue);
    end;

    procedure GetDate(TextValue: Text[100]) DateValue: Date
    begin
        Evaluate(DateValue, TextValue);
        exit(DateValue);
    end;

    procedure GetTime(TextValue: Text[100]) TimeValue: Time
    begin
        Evaluate(TimeValue, TextValue);
        exit(TimeValue);
    end;

    procedure SetPrimaryKey(NewStdSolutionNo: Code[20]; NewVersionCode: Code[10])
    begin
        StdSolutionNo := NewStdSolutionNo;
        VersionCode := NewVersionCode;
    end;

    procedure SetFileName(pFileName: Text[250])
    begin
        FileName := pFileName;
    end;

    procedure SetDateTime(pDateTime: DateTime)
    begin
        TheCurrentDateTime := pDateTime;
    end;


    procedure FindLineNumber(): Integer
    begin
        StandardSolutionObject.SetRange("Standard Solution No.", StdSolutionNo);
        StandardSolutionObject.SetRange("Version Code", VersionCode);
        if StandardSolutionObject.FindLast then
            exit(StandardSolutionObject."Line No.")
    end;


    procedure CheckChangePermissions(Type: Option)
    var
        StandardSolution: Record "AUZ Standard Solution";
    begin
        StandardSolution.Get("Standard Solution No.");
        StandardSolution.CheckChangePermissions(Type);
    end;

    var
        StdSolutionNo: Code[20];
        VersionCode: Code[10];
        FileName: Text[250];
        TheCurrentDateTime: DateTime;
        StandardSolutionObject: Record "AUZ Standard Solution Object";
        ArrayIndex: Integer;
        LineNumber: Integer;
        InsertRecord: Boolean;
        ChangeType: Option Insertion,Modification,Deletion;
}