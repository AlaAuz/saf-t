codeunit 70400 "External File Management"
{
    // *** Auzilium AS File Management ***


    trigger OnRun()
    begin
    end;

    var
        ExtFileMgtSetup: Record "External File Management Setup";
        FileMgt: Codeunit "File Management";
        ExtFileMgtSetupRead: Boolean;
        Text001: Label 'Save file.';
        Text002: Label 'Download File.';
        SourceTable: Integer;
        SourceType: Integer;
        SourceNo: Code[20];
        SourceLineNo: Integer;
        Text003: Label 'You cannot change primary key fields when the line have files associated to it.';


    procedure UploadFileWithDialog(RecID: RecordID)
    var
        ClientFilename: Text;
    begin
        ClientFilename := FileMgt.OpenFileDialog(Text001, '', '');
        if ClientFilename = '' then
            exit;

        UploadFile(ClientFilename, RecID);
    end;


    procedure UploadFile(ClientFileName: Text; RecID: RecordID)
    var
        ExternalFile: Record "External File";
        FileName: Text;
        TempServerFileName: Text;
        FileExtension: Text[10];
    begin
        ReadExtFileMgtSetup;

        FileExtension := FileMgt.GetExtension(ClientFileName);

        InsertExternalFile(ExternalFile);

        if ExtFileMgtSetup."Save to Database" then begin
            TempServerFileName := FileMgt.UploadFileSilent(ClientFileName);
            ExternalFile.File.Import(TempServerFileName);
            FileMgt.DeleteServerFile(TempServerFileName);
        end else begin
            FileName := GetFileDirectory;

            if ExtFileMgtSetup."Run on Client" then
                FileMgt.CreateClientDirectory(FileName)
            else begin
                FileMgt.ServerCreateDirectory(FileName);
                TempServerFileName := FileMgt.UploadFileSilent(ClientFileName);
            end;
            FileName += Format(ExternalFile."Entry No.") + '.' + FileExtension;

            if ExtFileMgtSetup."Run on Client" then
                FileMgt.CopyClientFile(ClientFileName, FileName, true)
            else begin
                FileMgt.CopyServerFile(TempServerFileName, FileName, true);
                FileMgt.DeleteServerFile(TempServerFileName);
            end;
        end;

        SetExternalFileValues(
          ExternalFile,
          RecID,
          FileMgt.GetFileNameWithoutExtension(ClientFileName),
          FileExtension);
    end;

    local procedure InsertExternalFile(var ExternalFile: Record "External File")
    begin
        ExternalFile.Init;
        ExternalFile.Insert;
    end;


    procedure SetSubpageValues(NewSourceTable: Integer; NewSourceType: Integer; NewSourceNo: Code[20]; NewSourceLineNo: Integer)
    begin
        SourceTable := NewSourceTable;
        SourceType := NewSourceType;
        SourceNo := NewSourceNo;
        SourceLineNo := NewSourceLineNo;
    end;

    local procedure SetExternalFileValues(var ExternalFile: Record "External File"; RecID: RecordID; Filename: Text; FileExtension: Text)
    begin
        ExternalFile."Record ID" := RecID;
        ExternalFile."File Name" := Filename;
        ExternalFile."File Extension" := FileExtension;
        ExternalFile."Uploaded by User" := UserId;
        ExternalFile."Uploaded Date" := Today;

        ExternalFile."Source Table" := SourceTable;
        ExternalFile."Source Type" := SourceType;
        ExternalFile."Soruce No." := SourceNo;
        ExternalFile."Source Line No." := SourceLineNo;

        ExternalFile.Modify;
    end;


    procedure DownloadAllFiles(RecID: RecordID)
    var
        ExternalFile: Record "External File";
        ClientFilePath: Text;
    begin
        ClientFilePath := SelectFolder;

        if ClientFilePath = '' then
            exit;

        ExternalFile.SetCurrentKey("Record ID");
        ExternalFile.SetRange("Record ID", RecID);
        if ExternalFile.FindSet then
            repeat
                DownloadFile(ExternalFile, ClientFilePath + '\' + ExternalFile."File Name" + '.' + ExternalFile."File Extension");
            until ExternalFile.Next = 0;
    end;


    procedure DownloadFileWithDialog(EntryNo: Integer) ClientFileName: Text
    var
        ExternalFile: Record "External File";
        FileName: Text;
    begin
        if EntryNo = 0 then
            exit;

        ExternalFile.Get(EntryNo);

        if not FileMgt.CanRunDotNetOnClient then begin
            ReadExtFileMgtSetup;
            if ExtFileMgtSetup."Save to Database" then
                Error('Denne funksjonen er kun støttet i Windows-klienten.');
            FileName := GetFileName(Format(ExternalFile."Entry No.") + '.' + ExternalFile."File Extension");
            FileMgt.DownloadHandler(FileName, Text002, '', '', ExternalFile."File Name" + '.' + ExternalFile."File Extension");
            exit;
        end;

        ClientFileName := FileMgt.SaveFileDialog(Text002, ExternalFile."File Name" + '.' + ExternalFile."File Extension", '');
        if ClientFileName = '' then
            exit;

        DownloadFile(ExternalFile, ClientFileName);
    end;


    procedure DownloadFileAndOpenFile(EntryNo: Integer) ClientFileName: Text
    begin
        if EntryNo = 0 then
            exit;

        HyperLink(DownloadFileOnly(EntryNo));
    end;


    procedure DownloadFileOnly(EntryNo: Integer) ClientFileName: Text
    var
        ExternalFile: Record "External File";
    begin
        if EntryNo = 0 then
            exit;

        ExternalFile.Get(EntryNo);
        ClientFileName := FileMgt.ClientTempFileName(ExternalFile."File Extension");
        DownloadFile(ExternalFile, ClientFileName);
    end;

    local procedure DownloadFile(var ExternalFile: Record "External File"; ClientFileName: Text)
    var
        FileName: Text;
    begin
        ReadExtFileMgtSetup;

        if ExtFileMgtSetup."Save to Database" then begin
            FileName := FileMgt.ServerTempFileName(ExternalFile."File Extension");
            ExternalFile.CalcFields(File);
            ExternalFile.File.Export(FileName);
            FileMgt.DownloadToFile(FileName, ClientFileName);
            FileMgt.DeleteServerFile(FileName);
        end else begin
            FileName := GetFileName(Format(ExternalFile."Entry No.") + '.' + ExternalFile."File Extension");

            if ExtFileMgtSetup."Run on Client" then
                FileMgt.CopyClientFile(FileName, ClientFileName, true)
            else
                FileMgt.DownloadToFile(FileName, ClientFileName);
        end;
    end;


    procedure MoveFiles(FromRecID: RecordID; ToRecID: RecordID)
    begin
        CopyFiles(FromRecID, ToRecID);
        DeleteFiles(FromRecID);
    end;


    procedure CopyFiles(FromRecID: RecordID; ToRecID: RecordID)
    var
        ExternalFile: Record "External File";
        NewExternalFile: Record "External File";
        FromFileName: Text;
        ToFileName: Text;
    begin
        ReadExtFileMgtSetup;

        ExternalFile.SetCurrentKey("Record ID");
        ExternalFile.SetRange("Record ID", FromRecID);
        if ExternalFile.FindSet then
            repeat
                Clear(NewExternalFile);
                InsertExternalFile(NewExternalFile);

                if ExtFileMgtSetup."Save to Database" then begin
                    ExternalFile.CalcFields(File);
                    NewExternalFile.File := ExternalFile.File;
                end else begin
                    FromFileName := GetFileDirectory + Format(ExternalFile."Entry No.") + '.' + ExternalFile."File Extension";
                    ToFileName := GetFileDirectory + Format(NewExternalFile."Entry No.") + '.' + ExternalFile."File Extension";

                    if ExtFileMgtSetup."Run on Client" then
                        FileMgt.CopyClientFile(FromFileName, ToFileName, true)
                    else
                        FileMgt.CopyServerFile(FromFileName, ToFileName, true);
                end;

                SetExternalFileValues(
                  NewExternalFile,
                  ToRecID,
                  ExternalFile."File Name",
                  ExternalFile."File Extension");
            until ExternalFile.Next = 0;
    end;


    procedure DeleteFiles(RecID: RecordID)
    var
        ExternalFile: Record "External File";
    begin
        ExternalFile.SetCurrentKey("Record ID");
        ExternalFile.SetRange("Record ID", RecID);
        if ExternalFile.FindSet then
            repeat
                DeleteFile(ExternalFile."Entry No.");
            until ExternalFile.Next = 0;
    end;


    procedure DeleteFile(EntryNo: Integer)
    var
        ExternalFile: Record "External File";
        FileName: Text;
        FileIsDeleted: Boolean;
        FileExists: Boolean;
    begin
        if EntryNo = 0 then
            exit;

        ReadExtFileMgtSetup;
        ExternalFile.Get(EntryNo);

        if not ExtFileMgtSetup."Save to Database" then begin
            FileName := GetFileName(Format(ExternalFile."Entry No.") + '.' + ExternalFile."File Extension");

            if ExtFileMgtSetup."Run on Client" then begin
                FileExists := FileMgt.ClientFileExists(FileName);
                FileIsDeleted := FileMgt.DeleteClientFile(FileName)
            end else begin
                FileExists := FileMgt.ServerFileExists(FileName);
                FileIsDeleted := FileMgt.DeleteServerFile(FileName);
            end;
        end;

        if FileIsDeleted or (not FileExists) then
            ExternalFile.Delete;
    end;

    local procedure ChangeRecIDs(FromRecID: RecordID; ToRecID: RecordID)
    var
        ExternalFile: Record "External File";
        ExternalFile2: Record "External File";
    begin
        ExternalFile.SetCurrentKey("Record ID");
        ExternalFile.SetRange("Record ID", FromRecID);
        if ExternalFile.FindSet then
            repeat
                if ExternalFile."Source Table" = 0 then begin
                    ExternalFile2.Get(ExternalFile."Entry No.");
                    ExternalFile2."Record ID" := ToRecID;
                    ExternalFile2.Modify;
                end else
                    Error(Text003);
            until ExternalFile.Next = 0;
    end;

    local procedure GetFileDirectory(): Text
    begin
        ReadExtFileMgtSetup;
        ExtFileMgtSetup.TestField("File Directory");
        exit(CheckPath(ExtFileMgtSetup."File Directory"));
    end;

    local procedure GetFileName(FileNameWithExtension: Text): Text
    begin
        exit(GetFileDirectory + FileNameWithExtension);
    end;

    local procedure CheckPath(FileDirectory: Text): Text
    begin
        if FileDirectory[StrLen(FileDirectory)] <> '\' then
            FileDirectory += '\';

        exit(FileDirectory);
    end;

    local procedure ReadExtFileMgtSetup()
    begin
        if not ExtFileMgtSetupRead then begin
            ExtFileMgtSetup.Get;
            ExtFileMgtSetupRead := true;
        end;
    end;

    local procedure GetServerFileNameFromRecord(var ExternalFile: Record "External File"): Text
    begin
        exit(GetFileName(Format(ExternalFile."Entry No.") + '.' + ExternalFile."File Extension"));
    end;

    local procedure SelectFolder(): Text
    var
        [RunOnClient]
        FolderBrowser: DotNet FolderBrowserDialog;
        WindowTitle: Label 'Choose Folder';
        DialogResult: DotNet DialogResult;
    begin
        FolderBrowser := FolderBrowser.FolderBrowserDialog;
        FolderBrowser.ShowNewFolderButton := true;
        FolderBrowser.Description := WindowTitle;
        DialogResult := FolderBrowser.ShowDialog;

        if DialogResult.CompareTo(DialogResult.OK) = 0 then
            exit(FolderBrowser.SelectedPath);
    end;


    procedure GetDatabaseTableTriggerSetup(TableID: Integer; var Insert: Boolean; var Modify: Boolean; var Delete: Boolean; var Rename: Boolean)
    var
        MarketingSetup: Record "Marketing Setup";
    begin
        if CompanyName = '' then
            exit;

        if CheckTableID(TableID) then begin
            Delete := true;
            Rename := true;
        end;
    end;

    local procedure CheckTableID(TableID: Integer): Boolean
    begin
        exit(TableID in [
          DATABASE::"Sales Header",
          DATABASE::"Sales Line",
          DATABASE::"Sales Shipment Header",
          DATABASE::"Sales Shipment Line",
          DATABASE::"Sales Invoice Header",
          DATABASE::"Sales Invoice Line",
          DATABASE::"Sales Cr.Memo Header",
          DATABASE::"Sales Cr.Memo Line",
          DATABASE::"Case Header", // Auzilium Internal
                                   //SS1.0.0+
          DATABASE::"Standard Solution",
          DATABASE::"Standard Solution Release"
          //SS1.0.0-
          ]);
    end;


    procedure OnDatabaseDelete(RecRef: RecordRef)
    begin
        DeleteFiles(RecRef.RecordId);
    end;


    procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    begin
        ChangeRecIDs(xRecRef.RecordId, RecRef.RecordId);
    end;
}

