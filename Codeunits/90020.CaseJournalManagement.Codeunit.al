codeunit 90020 "Case Journal Management"
{

    trigger OnRun()
    begin
    end;

    var
        ResourceNoErr: Label 'Resource no. is missing.';
        NothingToInsertErr: Label 'There is nothing to insert.';
        DescriptionExistsQst: Label 'There are already descriptions for the line. You must delete these to continue. Do you want to delete them?';
        InsertCaseHoursQst: Label 'Do you want to insert case lines?';

    procedure InsertXml(Resource: Text; Type: Text; Xml: Text): Text
    begin
        case Type of
            'Registration':
                exit(InsertCaseHourJnlFromXmlWithReturn(Xml));
            else
                exit(StrSubstNo('<error>InsertXml does not support Type %1.</error>', Type));
        end;
    end;

    procedure RetrieveXml(Resource: Text; Type: Text): Text
    begin
        case Type of
            'Todo':
                exit(GetCaseXmlWithType(Resource, Type));
            else
                exit(GetErrorXml(StrSubstNo('RetrieveXml does not support Type %1.', Type)));
        end;
    end;

    local procedure GetErrorXml(ErrorMessage: Text): Text
    begin
        exit(StrSubstNo('<error>%1</error>', ErrorMessage));
    end;

    procedure GetCaseXml(ResourceFilter: Text) CaseXML: Text
    var
        CaseHeader: Record "AUZ Case Header";
        TempBlob: Record TempBlob;
        CaseExport: XMLport "Case Export";
        OStream: OutStream;
    begin
        CaseHeader.SetFilter("Resource Search Text", StrSubstNo('*%1*', ResourceFilter));
        CaseHeader.SetFilter(Status, '<>%1&<>%2', CaseHeader.Status::Completed, CaseHeader.Status::Postponed);

        TempBlob.Blob.CreateOutStream(OStream);
        CaseExport.SetTableView(CaseHeader);
        CaseExport.SetDestination(OStream);
        CaseExport.Export;

        CaseXML := TempBlob.GetXMLAsText;
    end;

    procedure GetCaseXmlWithType(ResourceFilter: Text; TypeFilter: Text) CaseXML: Text
    var
        CaseHeader: Record "AUZ Case Header";
        TempBlob: Record TempBlob;
        CaseExport: XMLport "Case Export";
        OStream: OutStream;
    begin
        //New
        if TypeFilter <> 'Todo' then
            Error('You can only download Todos');

        CaseHeader.SetFilter("Resource Search Text", StrSubstNo('*%1*', ResourceFilter));
        CaseHeader.SetFilter(Status, '<>%1&<>%2', CaseHeader.Status::Completed, CaseHeader.Status::Postponed);

        TempBlob.Blob.CreateOutStream(OStream);
        CaseExport.SetTableView(CaseHeader);
        CaseExport.SetDestination(OStream);
        CaseExport.Export;

        CaseXML := TempBlob.GetXMLAsText;
    end;

    procedure InsertCaseHourJnlFromXml(CaseXML: Text): Text
    var
        CaseHourJnllImport: XMLport "Case Journal Import";
        TempBlob: Record TempBlob;
        IStream: InStream;
    begin
        TempBlob.WriteAsText(CaseXML, TEXTENCODING::UTF8);
        TempBlob.Blob.CreateInStream(IStream, TEXTENCODING::UTF8);

        CaseHourJnllImport.SetSource(IStream);
        CaseHourJnllImport.Import;
    end;

    procedure InsertCaseHourJnlFromXmlWithReturn(CaseXML: Text): Text
    var
        CaseHourJnllImport: XMLport "Case Journal Import";
        TempBlob: Record TempBlob;
        IStream: InStream;
    begin
        //New
        TempBlob.WriteAsText(CaseXML, TEXTENCODING::UTF8);
        TempBlob.Blob.CreateInStream(IStream, TEXTENCODING::UTF8);

        ClearLastError;
        CaseHourJnllImport.SetSource(IStream);
        if not CaseHourJnllImport.Import then
            exit(GetErrorXml(GetLastErrorText));
    end;

    procedure InsertCaseHourJnlDescriptions(CaseHourJnlLine: Record "AUZ Case Journal Line")
    var
        CaseHourJournalLineDesc: Record "AUZ Case Journal Line Desc.";
        TypeHelper: Codeunit "Type Helper";
        Description: Text;
        LineNo: Integer;
        Pos: Integer;
        MaxLength: Integer;
    begin
        CaseHourJournalLineDesc.SetRange("Resource No.", CaseHourJnlLine."Resource No.");
        CaseHourJournalLineDesc.SetRange("Journal Line No.", CaseHourJnlLine."Line No.");
        if not CaseHourJournalLineDesc.IsEmpty then
            if GuiAllowed then
                if not Confirm(DescriptionExistsQst, false) then
                    Error('');
        CaseHourJournalLineDesc.DeleteAll(true);

        Description := CaseHourJnlLine.GetWorkDescription;
        if Description = '' then
            exit;

        Pos := StrPos(Description, NewLine);
        while Pos > 0 do begin
            Description := DelStr(Description, Pos) + ' ' + CopyStr(Description, Pos + StrLen(NewLine));
            Pos := StrPos(Description, NewLine);
        end;

        if Description = '' then
            exit;

        Description := ReplaceString(Description, '&#x0d;&#x0a;', CRLFSeparator);

        MaxLength := MaxStrLen(CaseHourJournalLineDesc.Description);

        repeat
            LineNo += 10000;
            CaseHourJournalLineDesc.Init;
            CaseHourJournalLineDesc."Resource No." := CaseHourJnlLine."Resource No.";
            CaseHourJournalLineDesc."Journal Line No." := CaseHourJnlLine."Line No.";
            CaseHourJournalLineDesc."Line No." := LineNo;

            Pos := StrPos(Description, CRLFSeparator); //Bruk CRLF fra TypeHelper CU etter oppgradering
            if (Pos = 0) or (Pos > MaxLength) then begin
                Pos := 0;
                if StrLen(Description) > MaxLength then begin
                    if Pos < (MaxLength / 2) then
                        Pos := FindPos(Description, MaxLength, 0, '.');
                    if Pos < (MaxLength / 2) then
                        Pos := FindPos(Description, MaxLength, Pos, ',');
                    if Pos < (MaxLength / 2) then
                        Pos := FindPos(Description, MaxLength, Pos, ' ');
                end;
            end;

            if Pos = 0 then
                Pos := MaxLength;

            CaseHourJournalLineDesc.Description := CopyStr(Description, 1, Pos);
            CaseHourJournalLineDesc.Insert(true);

            Description := CopyStr(Description, Pos + 1);
            Description := DelChr(Description, '<', ' ');
        until Description = '';
    end;

    local procedure FindPos(Description: Text; MaxLength: Integer; Pos: Integer; Split: Text): Integer
    var
        NewPos: Integer;
    begin
        repeat
            NewPos := StrPos(CopyStr(Description, Pos + 1), Split);
            if (Pos + NewPos) > MaxLength then
                NewPos := 0
            else
                Pos += NewPos;
        until NewPos = 0;
        exit(Pos);
    end;

    procedure InsertCaseHoursFromJnl(ResourceNo: Code[20])
    var
        CaseHourJnlLine: Record "AUZ Case Journal Line";
        CaseHeader: Record "AUZ Case Header";
        CaseHourLineNo: Integer;
    begin
        if not Confirm(InsertCaseHoursQst) then
            Error('');

        if ResourceNo = '' then
            Error(ResourceNoErr);

        CaseHourJnlLine.SetRange("Resource No.", ResourceNo);
        if not CaseHourJnlLine.FindSet then
            Error(NothingToInsertErr);

        repeat
            CaseHeader.Get(CaseHourJnlLine."Case No.");
            InsertCaseHourFromJnl(CaseHourJnlLine, CaseHourLineNo, CaseHeader);
            InsertCaseHourDescriptions(CaseHourJnlLine, CaseHourLineNo);
            CaseHeader.Find; // CaseHour.Insert updates header
            SetCaseSolution(CaseHourJnlLine, CaseHeader);
            SetModifiedObjectText(CaseHourJnlLine);
        until CaseHourJnlLine.Next = 0;

        CaseHourJnlLine.DeleteAll(true);
    end;

    local procedure InsertCaseHourFromJnl(var CaseHourJnlLine: Record "AUZ Case Journal Line"; var CaseHourLineNo: Integer; CaseHeader: Record "AUZ Case Header")
    var
        CaseHour: Record "AUZ Case Line";
    begin
        CaseHour.SetRange("Case No.", CaseHeader."No.");
        if CaseHour.FindLast then;
        CaseHourLineNo := CaseHour."Line No." + 10000;

        CaseHour.Init;
        CaseHour.Validate("Case No.", CaseHeader."No.");
        CaseHour."Line No." := CaseHourLineNo;
        CaseHour.Validate("Resource No.", CaseHourJnlLine."Resource No.");
        CaseHour.Validate(Date, CaseHourJnlLine.Date);
        CaseHour.Validate("Work Type", CaseHourJnlLine."Work Type");
        CaseHour.Validate(Quantity, CaseHourJnlLine.Quantity);
        CaseHour.Validate(Chargeable, CaseHourJnlLine.Chargeable);
        CaseHour.Validate("Reference No.", CaseHourJnlLine."Reference No.");
        CaseHour.Validate("Job No.", CaseHeader."Job No.");
        CaseHour.Validate("Job Task No.", CaseHeader."Job Task No.");
        CaseHour.Insert(true);
    end;

    local procedure InsertCaseHourDescriptions(CaseHourJnlLine: Record "AUZ Case Journal Line"; CaseHourLineNo: Integer)
    var
        CaseHourJournalLineDesc: Record "AUZ Case Journal Line Desc.";
        CaseHourDescription: Record "AUZ Case Line Description";
        LineNo: Integer;
    begin
        CaseHourJournalLineDesc.SetRange("Resource No.", CaseHourJnlLine."Resource No.");
        CaseHourJournalLineDesc.SetRange("Journal Line No.", CaseHourJnlLine."Line No.");
        if CaseHourJournalLineDesc.FindSet then
            repeat
                LineNo += 10000;
                CaseHourDescription.Init;
                CaseHourDescription."Case No." := CaseHourJnlLine."Case No.";
                CaseHourDescription."Case Line No." := CaseHourLineNo;
                CaseHourDescription."Line No." := LineNo;
                CaseHourDescription.Description := CaseHourJournalLineDesc.Description;
                CaseHourDescription.Insert(true);
            until CaseHourJournalLineDesc.Next = 0;
    end;

    local procedure SetCaseSolution(var CaseHourJnlLine: Record "AUZ Case Journal Line"; var CaseHeader: Record "AUZ Case Header")
    var
        Description: Text;
        Solution: Text;
    begin
        if not CaseHourJnlLine."Add Descriptions to Solution" then
            exit;

        Description := CaseHourJnlLine.GetWorkDescription;
        if Description <> '' then begin
            CaseHeader.GetDescriptionSolution(Solution);
            if Solution <> '' then
                Solution += NewLine;
            Solution += Description;

            CaseHeader.SaveDescriptionSolution(Solution);
            CaseHeader.Modify(true);
        end;
    end;

    local procedure SetModifiedObjectText(var CaseHourJnlLine: Record "AUZ Case Journal Line")
    var
        CaseHandleObjects: Codeunit "AUZ Case Handle Objects";
        NewModifiedObjectText: Text;
        IStream: InStream;
        BText: BigText;
    begin
        CaseHandleObjects.SetCaseNo(CaseHourJnlLine."Case No.");
        CaseHandleObjects.ReadText(CaseHourJnlLine.GetModifiedObjectText);
    end;

    local procedure NewLine(): Text
    var
        Char13: Char;
        Char10: Char;
    begin
        Char13 := 13;
        Char10 := 10;
        exit(Format(Char13) + Format(Char10));
    end;

    local procedure CRLFSeparator(): Text[2]
    var
        CRLF: Text[2];
    begin
        CRLF[1] := 13; // Carriage return, '\r'
        CRLF[2] := 10; // Line feed, '\n'
        exit(CRLF);
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;
    end;
}

