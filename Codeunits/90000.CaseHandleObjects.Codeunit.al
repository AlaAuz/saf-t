codeunit 90000 "AUZ Case Handle Objects"
{
    // Oseberg Solutions by EVA :)
    // 
    // OKS001 JLO 11.03.2013 Init of Comment
    // 
    // AZ99999 26.09.2015 HHV Changed code to check on char 10 instead of 13


    trigger OnRun()
    begin
    end;

    var
        CaseNo: Code[20];
        FileName: Text[250];
        TheCurrentDateTime: DateTime;
        CaseObjects: Record "AUZ Case Object";
        ArrayIndex: Integer;
        LineNumber: Integer;
        InsertRecord: Boolean;


    procedure ReadText(ObjectsCopyPaste: Text)
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
        if ObjectsCopyPaste = '' then
            exit;

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
        CaseObjects.Init;
        CaseObjects."Case No." := CaseNo;

        InsertRecord := false;
        repeat

            Pos += 1;
            CharValue := ObjectsCopyPaste[Pos];

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;
                    case ArrayFieldNumber[ArrayIndex] of
                        4:
                            CaseObjects.Type := GetInteger(TextValue);
                        5:
                            CaseObjects.ID := GetInteger(TextValue);
                        6:
                            CaseObjects.Name := TextValue;
                        7:
                            CaseObjects.Modified := GetBoolean(TextValue);
                        8:
                            CaseObjects.Compiled := GetBoolean(TextValue);
                        9:
                            CaseObjects.Date := GetDate(TextValue);
                        10:
                            CaseObjects.Time := GetTime(TextValue);
                        11:
                            CaseObjects."Version List" := TextValue;
                        12:
                            CaseObjects.Caption := TextValue;
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

//ALA 
/*
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

        CaseObjects.Init;
        CaseObjects."Case No." := CaseNo;

        InsertRecord := false;
        repeat
            MyFile.Read(CharValue);

            if CharValue in [9, 10, 13] then begin
                if CharValue = 9 then begin //TAB
                    ArrayIndex += 1;
                    case ArrayFieldNumber[ArrayIndex] of
                        4:
                            CaseObjects.Type := GetInteger(TextValue);
                        5:
                            CaseObjects.ID := GetInteger(TextValue);
                        6:
                            CaseObjects.Name := TextValue;
                        7:
                            CaseObjects.Modified := GetBoolean(TextValue);
                        8:
                            CaseObjects.Compiled := GetBoolean(TextValue);
                        9:
                            CaseObjects.Date := GetDate(TextValue);
                        10:
                            CaseObjects.Time := GetTime(TextValue);
                        11:
                            CaseObjects."Version List" := TextValue;
                        12:
                            CaseObjects.Caption := TextValue;
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
*/

    procedure InsertNewRecord()
    begin
        LineNumber += 10000;
        CaseObjects."Line No." := LineNumber;
        CaseObjects."Import Datetime" := TheCurrentDateTime;
        CaseObjects.Comment := '';   // OKS001
        CaseObjects.Insert;
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


    procedure SetCaseNo(NewCaseNo: Code[20])
    begin
        CaseNo := NewCaseNo;
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
        CaseObjects.SetRange("Case No.", CaseNo);
        if CaseObjects.FindLast then
            exit(CaseObjects."Line No.")
        else
            exit(0);
    end;
}

