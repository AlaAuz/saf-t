codeunit 70001 "Handle Objects"
{
    // Oseberg Solutions by EVA :)
    // 
    // OKS001 JLO 11.03.2013 Init of Comment


    trigger OnRun()
    begin
    end;

    var
        ToDoCode: Code[20];
        FileName: Text[250];
        TheCurrentDateTime: DateTime;
        ObjectCompare: Record "Object Compare";
        ArrayIndex: Integer;
        LineNumber: Integer;
        InsertRecord: Boolean;

    [Scope('Internal')]
    procedure ReadText(var ObjectsCopyPaste: Text; CompareType: Option Compare1,Compare2)
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

        ObjectCompare.Init;
        ObjectCompare.Compare := CompareType;

        InsertRecord := false;
        repeat

            Pos += 1;
            CharValue := ObjectsCopyPaste[Pos];

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;
                    case ArrayFieldNumber[ArrayIndex] of
                        4:
                            ObjectCompare.Type := GetInteger(TextValue);
                        5:
                            ObjectCompare.ID := GetInteger(TextValue);
                        6:
                            ObjectCompare.Name := TextValue;
                        7:
                            ObjectCompare.Modified := GetBoolean(TextValue);
                        8:
                            ObjectCompare.Compiled := GetBoolean(TextValue);
                        9:
                            ObjectCompare.Date := GetDate(TextValue);
                        10:
                            ObjectCompare.Time := GetTime(TextValue);
                        11:
                            ObjectCompare."Version List" := TextValue;
                        12:
                            ObjectCompare.Caption := TextValue;
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

        until (Pos >= StrLen(ObjectsCopyPaste));

        if InsertRecord then begin
            InsertNewRecord();
        end;
    end;

    [Scope('Internal')]
    procedure ReadFile(CompareType: Option Compare1,Compare2)
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

        MyFile.Open(FileName);

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

        ObjectCompare.Init;
        ObjectCompare.Compare := CompareType;

        InsertRecord := false;
        repeat
            MyFile.Read(CharValue);

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;
                    case ArrayFieldNumber[ArrayIndex] of
                        4:
                            ObjectCompare.Type := GetInteger(TextValue);
                        5:
                            ObjectCompare.ID := GetInteger(TextValue);
                        6:
                            ObjectCompare.Name := TextValue;
                        7:
                            ObjectCompare.Modified := GetBoolean(TextValue);
                        8:
                            ObjectCompare.Compiled := GetBoolean(TextValue);
                        9:
                            ObjectCompare.Date := GetDate(TextValue);
                        10:
                            ObjectCompare.Time := GetTime(TextValue);
                        11:
                            ObjectCompare."Version List" := TextValue;
                        12:
                            ObjectCompare.Caption := TextValue;
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

        MyFile.Close;

        if InsertRecord then begin
            InsertNewRecord();
        end;
    end;

    [Scope('Internal')]
    procedure InsertNewRecord()
    begin
        ObjectCompare.Insert;
        ArrayIndex := 0;
        InsertRecord := false;
    end;

    [Scope('Internal')]
    procedure GetInteger(TextValue: Text[100]) IntValue: Integer
    begin
        Evaluate(IntValue, TextValue);
        exit(IntValue);
    end;

    [Scope('Internal')]
    procedure GetBoolean(TextValue: Text[100]) BoolValue: Boolean
    begin
        if UpperCase(TextValue) in ['YES', 'JA'] then
            TextValue := '1'
        else
            TextValue := '0';

        Evaluate(BoolValue, TextValue);
        exit(BoolValue);
    end;

    [Scope('Internal')]
    procedure GetDate(TextValue: Text[100]) DateValue: Date
    begin
        Evaluate(DateValue, TextValue);
        exit(DateValue);
    end;

    [Scope('Internal')]
    procedure GetTime(TextValue: Text[100]) TimeValue: Time
    begin
        Evaluate(TimeValue, TextValue);
        exit(TimeValue);
    end;

    [Scope('Internal')]
    procedure SetToDoEntryNo(pTodoCode: Code[20])
    begin
        ToDoCode := pTodoCode;
    end;

    [Scope('Internal')]
    procedure SetFileName(pFileName: Text[250])
    begin
        FileName := pFileName;
    end;

    [Scope('Internal')]
    procedure SetDateTime(pDateTime: DateTime)
    begin
        TheCurrentDateTime := pDateTime;
    end;

    [Scope('Internal')]
    procedure Compare(CompareType1: Option Compare1,Compare2; CompareType2: Option Compare1,Compare2)
    var
        Compare1: Record "Object Compare";
        Compare2: Record "Object Compare";
        LineNo: Integer;
        RecRef1: RecordRef;
        RecRef2: RecordRef;
        Text1: Text;
        Text2: Text;
    begin
        Compare1.SetRange(Compare, CompareType1);
        Compare2.SetRange(Compare, CompareType2);

        if Compare1.FindSet then
            repeat

                Compare2.SetRange(Type, Compare1.Type);
                Compare2.SetRange(ID, Compare1.ID);

                if not Compare2.FindFirst then
                    Compare1.Status := Compare1.Status::Create
                else begin
                    Text1 := StrSubstNo('%1-%2-%3-%4-%5-%6', Compare1.Name, Compare1.Modified, Compare1.Compiled, Compare1.Date, Compare1.Time, Compare1."Version List");
                    Text2 := StrSubstNo('%1-%2-%3-%4-%5-%6', Compare2.Name, Compare2.Modified, Compare2.Compiled, Compare2.Date, Compare2.Time, Compare2."Version List");
                    if Text1 = Text2 then
                        Compare1.Status := Compare1.Status::Identical
                    else
                        Compare1.Status := Compare1.Status::Mismatch;
                end;

                Compare1.Modify;

            until Compare1.Next = 0;
    end;
}

