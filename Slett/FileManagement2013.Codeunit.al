codeunit 60000 "File Management 2013"
{

    trigger OnRun()
    begin
    end;

    var
        Text001: Label 'Default';
        Text002: Label 'You must enter a file path.';
        Text003: Label 'You must enter a file name.';
        Text004: Label 'The file %1 does not exist.';
        Text006: Label 'Export';
        Text007: Label 'Import';
        PathHelper: DotNet Path;
        [RunOnClient]
        ClientFileHelper: DotNet File;
        ServerFileHelper: DotNet File;
        [RunOnClient]
        DirectoryHelper: DotNet Directory;
        Text010: Label 'The file %1 has not been uploaded.';
        Text011: Label 'You must specify a source file name.';
        Text012: Label 'You must specify a target file name.';
        Text013: Label 'The file name %1 already exists.';
        CreatePathQst: Label 'The path %1 does not exist. Do you want to add it now?';
        AllFilesFilterTxt: Label '*.*', Locked = true;
        AllFilesDescriptionTxt: Label 'All Files (*.*)|*.*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        XMLFileType: Label 'XML Files (*.xml)|*.xml', Comment = '{Split=r''\|''}{Locked=s''1''}';
        WordFileType: Label 'Word Files (*.doc)|*.doc', Comment = '{Split=r''\|''}{Locked=s''1''}';
        Word2007FileType: Label 'Word Files (*.doc*)|*.doc*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        ExcelFileType: Label 'Excel Files (*.xls)|*.xls', Comment = '{Split=r''\|''}{Locked=s''1''}';
        Excel2007FileType: Label 'Excel Files (*.xls*)|*.xls*', Comment = '{Split=r''\|''}{Locked=s''1''}';
        XSDFileType: Label 'XSD Files (*.xsd)|*.xsd', Comment = '{Split=r''\|''}{Locked=s''1''}';
        HTMFileType: Label 'HTM Files (*.htm)|*.htm', Comment = '{Split=r''\|''}{Locked=s''1''}';
        XSLTFileType: Label 'XSLT Files (*.xslt)|*.xslt', Comment = '{Split=r''\|''}{Locked=s''1''}';
        TXTFileType: Label 'Text Files (*.txt)|*.txt', Comment = '{Split=r''\|''}{Locked=s''1''}';
        UnsupportedFileExtErr: Label 'Unsupported file extension (.%1). The supported file extensions are (%2).';
        SingleFilterErr: Label 'Please specify a file filter and an extension filter when using this function.';
        InvalidWindowsChrStringTxt: Label '"#%&*:<>?\/{|}~', Locked = true;


    procedure BLOBImport(var BLOBRef: Record TempBlob temporary; Name: Text): Text
    begin
        exit(BLOBImportWithFilter(BLOBRef, Text007, Name, AllFilesDescriptionTxt, AllFilesFilterTxt));
    end;


    procedure BLOBImportWithFilter(var TempBlob: Record TempBlob; DialogCaption: Text; Name: Text; FileFilter: Text; ExtFilter: Text): Text
    var
        NVInStream: InStream;
        NVOutStream: OutStream;
        UploadResult: Boolean;
        ErrorMessage: Text;
    begin
        // ExtFilter examples: 'csv,txt' if you only accept *.csv and *.txt or '*.*' if you accept any extensions
        ClearLastError;

        if (FileFilter = '') xor (ExtFilter = '') then
            Error(SingleFilterErr);

        // There is no way to check if NVInStream is null before using it after calling the
        // UPLOADINTOSTREAM therefore if result is false this is the only way we can throw the error.
        UploadResult := UploadIntoStream(DialogCaption, '', FileFilter, Name, NVInStream);
        if UploadResult then
            ValidateFileExtension(Name, ExtFilter);
        if UploadResult then begin
            TempBlob.Blob.CreateOutStream(NVOutStream);
            CopyStream(NVOutStream, NVInStream);
            exit(Name);
        end;
        ErrorMessage := GetLastErrorText;
        if ErrorMessage <> '' then
            Error(ErrorMessage);

        exit('');
    end;


    procedure BLOBExport(var BLOBRef: Record TempBlob temporary; Name: Text; CommonDialog: Boolean): Text
    var
        NVInStream: InStream;
        ToFile: Text;
        Path: Text;
        IsDownloaded: Boolean;
    begin
        BLOBRef.Blob.CreateInStream(NVInStream);
        if CommonDialog then begin
            if StrPos(Name, '*') = 0 then
                ToFile := Name
            else
                ToFile := DelChr(InsStr(Name, Text001, 1), '=', '*');
            ToFile := GetFileName(ToFile);
        end else begin
            ToFile := ClientTempFileName(GetExtension(Name));
            Path := Magicpath;
        end;
        IsDownloaded := DownloadFromStream(NVInStream, Text006, Path, GetToFilterText('', Name), ToFile);
        if IsDownloaded then
            exit(ToFile);
        exit('');
    end;


    procedure ServerTempFileName(FileExtension: Text) FileName: Text
    var
        TempFile: File;
    begin
        TempFile.CreateTempFile;
        FileName := TempFile.Name + '.' + FileExtension;
        TempFile.Close;
    end;


    procedure ClientTempFileName(FileExtension: Text) ClientFileName: Text
    var
        TempFile: File;
        ClientTempPath: Text;
    begin
        if ClientTempPath = '' then begin
            TempFile.CreateTempFile;
            ClientFileName := TempFile.Name + '.' + FileExtension;
            TempFile.Close;
            TempFile.Create(ClientFileName);
            TempFile.Close;
            ClientTempPath := GetDirectoryName(DownloadTempFile(ClientFileName));
        end;
        ClientFileName := ClientTempPath + '\' + Format(CreateGuid) + '.' + FileExtension;
    end;


    procedure DownloadTempFile(ServerFileName: Text): Text
    var
        FileName: Text;
        Path: Text;
    begin
        FileName := ServerFileName;
        Path := Magicpath;
        Download(ServerFileName, '', Path, AllFilesDescriptionTxt, FileName);
        exit(FileName);
    end;


    procedure UploadFileSilent(ClientFilePath: Text): Text
    var
        ClientFileAttributes: DotNet FileAttributes;
        ServerFileName: Text;
        TempClientFile: Text;
        FileName: Text;
        FileExtension: Text;
    begin
        if not ClientFileHelper.Exists(ClientFilePath) then
            Error(Text004, ClientFilePath);
        FileName := GetFileName(ClientFilePath);
        FileExtension := GetExtension(FileName);

        TempClientFile := ClientTempFileName(FileExtension);
        ClientFileHelper.Copy(ClientFilePath, TempClientFile, true);

        ServerFileName := ServerTempFileName(FileExtension);

        if not Upload('', Magicpath, AllFilesDescriptionTxt, GetFileName(TempClientFile), ServerFileName) then
            Error(Text010, ClientFilePath);

        ClientFileHelper.SetAttributes(TempClientFile, ClientFileAttributes.Normal);
        ClientFileHelper.Delete(TempClientFile);
        exit(ServerFileName);
    end;


    procedure UploadFile(WindowTitle: Text[50]; ClientFileName: Text) ServerFileName: Text
    var
        "Filter": Text;
    begin
        Filter := GetToFilterText('', ClientFileName);

        if PathHelper.GetFileNameWithoutExtension(ClientFileName) = '' then
            ClientFileName := '';

        ServerFileName := UploadFileWithFilter(WindowTitle, ClientFileName, Filter, AllFilesFilterTxt);
    end;


    procedure UploadFileWithFilter(WindowTitle: Text[50]; ClientFileName: Text; FileFilter: Text; ExtFilter: Text) ServerFileName: Text
    var
        Uploaded: Boolean;
    begin
        ClearLastError;

        if (FileFilter = '') xor (ExtFilter = '') then
            Error(SingleFilterErr);

        Uploaded := Upload(WindowTitle, '', FileFilter, ClientFileName, ServerFileName);
        if Uploaded then
            ValidateFileExtension(ClientFileName, ExtFilter);
        if Uploaded then
            exit(ServerFileName);

        if GetLastErrorText <> '' then
            Error('%1', GetLastErrorText);

        exit('');
    end;


    procedure Magicpath(): Text
    begin
        exit('<TEMP>');   // MAGIC PATH makes sure we don't get a prompt
    end;


    procedure DownloadHandler(FromFile: Text; DialogTitle: Text; ToFolder: Text; ToFilter: Text; ToFile: Text): Boolean
    var
        Downloaded: Boolean;
    begin
        ClearLastError;
        Downloaded := Download(FromFile, DialogTitle, ToFolder, ToFilter, ToFile);
        if not Downloaded then
            if GetLastErrorText <> '' then
                Error('%1', GetLastErrorText);
        exit(Downloaded);
    end;


    procedure DownloadToFile(ServerFileName: Text; ClientFileName: Text)
    var
        TempClientFileName: Text;
    begin
        ValidateFileNames(ServerFileName, ClientFileName);
        TempClientFileName := DownloadTempFile(ServerFileName);
        MoveFile(TempClientFileName, ClientFileName);
    end;


    procedure AppendAllTextToClientFile(ServerFileName: Text; ClientFileName: Text)
    begin
        ValidateFileNames(ServerFileName, ClientFileName);
        ClientFileHelper.AppendAllText(ClientFileName, ServerFileHelper.ReadAllText(ServerFileName));
    end;


    procedure MoveAndRenameClientFile(OldFilePath: Text; NewFileName: Text; NewSubDirectoryName: Text) NewFilePath: Text
    var
        directory: Text;
    begin
        if OldFilePath = '' then
            Error(Text002);

        if NewFileName = '' then
            Error(Text003);

        if not ClientFileHelper.Exists(OldFilePath) then
            Error(Text004, OldFilePath);

        // Get the directory from the OldFilePath, if directory is empty it will just use the current location.
        directory := GetDirectoryName(OldFilePath);

        // create the sub directory name is name is given
        if NewSubDirectoryName <> '' then begin
            directory := PathHelper.Combine(directory, NewSubDirectoryName);
            DirectoryHelper.CreateDirectory(directory);
        end;

        NewFilePath := PathHelper.Combine(directory, NewFileName);
        MoveFile(OldFilePath, NewFilePath);

        exit(NewFilePath);
    end;


    procedure DeleteClientFile(FilePath: Text): Boolean
    begin
        if not ClientFileHelper.Exists(FilePath) then
            exit(false);

        ClientFileHelper.Delete(FilePath);
        exit(true);
    end;


    procedure CopyClientFile(SourceFileName: Text; DestFileName: Text; OverWrite: Boolean)
    begin
        ClientFileHelper.Copy(SourceFileName, DestFileName, OverWrite);
    end;


    procedure ClientFileExists(FilePath: Text): Boolean
    begin
        exit(ClientFileHelper.Exists(FilePath));
    end;


    procedure ClientDirectoryExists(DirectoryPath: Text): Boolean
    begin
        exit(DirectoryHelper.Exists(DirectoryPath));
    end;


    procedure MoveFile(SourceFileName: Text; TargetFileName: Text)
    begin
        // System.IO.File.Move is not used due to a known issue in KB310316

        if not ClientFileHelper.Exists(SourceFileName) then
            Error(Text004, SourceFileName);

        ValidatePath(GetDirectoryName(TargetFileName));

        DeleteClientFile(TargetFileName);
        ClientFileHelper.Copy(SourceFileName, TargetFileName);
        ClientFileHelper.Delete(SourceFileName);
    end;


    procedure CopyServerFile(SourceFileName: Text; TargetFileName: Text; Overwrite: Boolean)
    begin
        ServerFileHelper.Copy(SourceFileName, TargetFileName, Overwrite);
    end;


    procedure ServerFileExists(FilePath: Text): Boolean
    begin
        exit(Exists(FilePath));
    end;


    procedure DeleteServerFile(FilePath: Text): Boolean
    begin
        if not Exists(FilePath) then
            exit(false);

        ServerFileHelper.Delete(FilePath);
        exit(true);
    end;


    procedure GetFileName(FilePath: Text): Text
    begin
        exit(PathHelper.GetFileName(FilePath));
    end;


    procedure GetDirectoryName(FileName: Text): Text
    begin
        if FileName = '' then
            exit(FileName);

        FileName := DelChr(FileName, '<');
        exit(PathHelper.GetDirectoryName(FileName));
    end;


    procedure BLOBImportFromServerFile(var TempBlob: Record TempBlob; FilePath: Text)
    var
        OutStream: OutStream;
        InStream: InStream;
        InputFile: File;
    begin
        if not FILE.Exists(FilePath) then
            Error(Text004, FilePath);

        InputFile.Open(FilePath);
        InputFile.CreateInStream(InStream);
        TempBlob.Blob.CreateOutStream(OutStream);
        CopyStream(OutStream, InStream);
        InputFile.Close;
    end;


    procedure BLOBExportToServerFile(var TempBlob: Record TempBlob; FilePath: Text)
    var
        OutStream: OutStream;
        InStream: InStream;
        OutputFile: File;
    begin
        if FILE.Exists(FilePath) then
            Error(Text013, FilePath);

        OutputFile.WriteMode(true);
        OutputFile.Create(FilePath);
        OutputFile.CreateOutStream(OutStream);
        TempBlob.Blob.CreateInStream(InStream);
        CopyStream(OutStream, InStream);
        OutputFile.Close;
    end;


    procedure GetToFilterText(FilterString: Text; FileName: Text): Text
    var
        OutExt: Text;
    begin
        if FilterString <> '' then
            exit(FilterString);

        case UpperCase(GetExtension(FileName)) of
            'DOC':
                OutExt := WordFileType;
            'DOCX':
                OutExt := Word2007FileType;
            'XLS':
                OutExt := ExcelFileType;
            'XLSX':
                OutExt := Excel2007FileType;
            'XSLT':
                OutExt := XSLTFileType;
            'XML':
                OutExt := XMLFileType;
            'XSD':
                OutExt := XSDFileType;
            'HTM':
                OutExt := HTMFileType;
            'TXT':
                OutExt := TXTFileType;
        end;
        if OutExt = '' then
            exit(AllFilesDescriptionTxt);
        exit(OutExt + '|' + AllFilesDescriptionTxt);  // Also give the option of the general selection
    end;


    procedure GetExtension(Name: Text): Text
    var
        FileExtension: Text;
    begin
        FileExtension := PathHelper.GetExtension(Name);

        if FileExtension <> '' then
            FileExtension := DelChr(FileExtension, '<', '.');

        exit(FileExtension);
    end;


    procedure OpenFileDialog(WindowTitle: Text[50]; DefaultFileName: Text; FilterString: Text): Text
    var
        [RunOnClient]
        OpenFileDialog: DotNet OpenFileDialog;
        [RunOnClient]
        DialagResult: DotNet DialogResult;
    begin
        OpenFileDialog := OpenFileDialog.OpenFileDialog;
        OpenFileDialog.ShowReadOnly := false;
        OpenFileDialog.FileName := GetFileName(DefaultFileName);
        OpenFileDialog.Title := WindowTitle;
        OpenFileDialog.Filter := GetToFilterText(FilterString, DefaultFileName);
        OpenFileDialog.InitialDirectory := GetDirectoryName(DefaultFileName);

        DialagResult := OpenFileDialog.ShowDialog;
        if DialagResult.CompareTo(DialagResult.OK) = 0 then
            exit(OpenFileDialog.FileName);
        exit('');
    end;


    procedure SaveFileDialog(WindowTitle: Text[50]; DefaultFileName: Text; FilterString: Text): Text
    var
        [RunOnClient]
        SaveFileDialog: DotNet SaveFileDialog;
        [RunOnClient]
        DialagResult: DotNet DialogResult;
    begin
        SaveFileDialog := SaveFileDialog.SaveFileDialog;
        SaveFileDialog.CheckPathExists := true;
        SaveFileDialog.OverwritePrompt := true;
        SaveFileDialog.FileName := GetFileName(DefaultFileName);
        SaveFileDialog.Title := WindowTitle;
        SaveFileDialog.Filter := GetToFilterText(FilterString, DefaultFileName);
        SaveFileDialog.InitialDirectory := GetDirectoryName(DefaultFileName);

        DialagResult := SaveFileDialog.ShowDialog;
        if DialagResult.CompareTo(DialagResult.OK) = 0 then
            exit(SaveFileDialog.FileName);
        exit('');
    end;


    procedure CanRunDotNetOnClient(): Boolean
    var
        ActiveSession: Record "Active Session";
    begin
        if ActiveSession.Get(ServiceInstanceId, SessionId) then
            exit(ActiveSession."Client Type" in [ActiveSession."Client Type"::"Windows Client", ActiveSession."Client Type"::Unknown]);

        exit(false);
    end;


    procedure IsWebClient(): Boolean
    var
        ActiveSession: Record "Active Session";
    begin
        if ActiveSession.Get(ServiceInstanceId, SessionId) then
            exit(ActiveSession."Client Type" = ActiveSession."Client Type"::"Web Client");

        exit(false);
    end;


    procedure IsValidFileName(FileName: Text): Boolean
    var
        String: DotNet String;
    begin
        if FileName = '' then
            exit(false);

        String := GetFileName(FileName);
        if String.IndexOfAny(PathHelper.GetInvalidFileNameChars) <> -1 then
            exit(false);

        String := GetDirectoryName(FileName);
        if String.IndexOfAny(PathHelper.GetInvalidPathChars) <> -1 then
            exit(false);

        exit(true);
    end;

    local procedure ValidateFileNames(ServerFileName: Text; ClientFileName: Text)
    begin
        if not IsValidFileName(ServerFileName) then
            Error(Text011);

        if not IsValidFileName(ClientFileName) then
            Error(Text012);
    end;


    procedure ValidateFileExtension(FilePath: Text; ValidExtensions: Text)
    var
        FileExt: Text;
        LowerValidExts: Text;
    begin
        if StrPos(ValidExtensions, AllFilesFilterTxt) <> 0 then
            exit;

        FileExt := LowerCase(GetExtension(GetFileName(FilePath)));
        LowerValidExts := LowerCase(ValidExtensions);

        if StrPos(LowerValidExts, FileExt) = 0 then
            Error(StrSubstNo(UnsupportedFileExtErr, FileExt, LowerValidExts));
    end;

    local procedure ValidatePath(FilePath: Text)
    begin
        if FilePath = '' then
            exit;
        if DirectoryHelper.Exists(FilePath) then
            exit;

        if Confirm(CreatePathQst, true, FilePath) then
            DirectoryHelper.CreateDirectory(FilePath)
        else
            Error('');
    end;


    procedure Ansi2SystemEncoding(Destination: OutStream; Source: InStream)
    var
        StreamReader: DotNet StreamReader;
        Encoding: DotNet Encoding;
        EncodedTxt: Text;
    begin
        StreamReader := StreamReader.StreamReader(Source, Encoding.Default, true);
        EncodedTxt := StreamReader.ReadToEnd();
        Destination.WriteText(EncodedTxt);
    end;


    procedure Ansi2SystemEncodingTxt(Destination: OutStream; Source: Text)
    var
        StreamWriter: DotNet StreamWriter;
        Encoding: DotNet Encoding;
    begin
        StreamWriter := StreamWriter.StreamWriter(Destination, Encoding.Default);
        StreamWriter.Write(Source);
        StreamWriter.Close();
    end;


    procedure BrowseForFolderDialog(WindowTitle: Text[50]; DefaultFolderName: Text; ShowNewFolderButton: Boolean): Text
    var
        [RunOnClient]
        FolderBrowserDialog: DotNet FolderBrowserDialog;
        [RunOnClient]
        DialagResult: DotNet DialogResult;
    begin
        FolderBrowserDialog := FolderBrowserDialog.FolderBrowserDialog;
        FolderBrowserDialog.Description := WindowTitle;
        FolderBrowserDialog.SelectedPath := DefaultFolderName;
        FolderBrowserDialog.ShowNewFolderButton := ShowNewFolderButton;

        DialagResult := FolderBrowserDialog.ShowDialog;
        if DialagResult.CompareTo(DialagResult.OK) = 0 then
            exit(FolderBrowserDialog.SelectedPath);
        exit(DefaultFolderName);
    end;


    procedure StripNotsupportChrInFileName(InText: Text): Text
    begin
        exit(DelChr(InText, '=', InvalidWindowsChrStringTxt));
    end;


    procedure IsGZip(ServerSideFileName: Text): Boolean
    var
        FileStream: DotNet FileStream;
        FileMode: DotNet FileMode;
        ID: array[2] of Integer;
    begin
        FileStream := FileStream.FileStream(ServerSideFileName, FileMode.Open);
        ID[1] := FileStream.ReadByte();
        ID[2] := FileStream.ReadByte();
        FileStream.Close;

        // from GZIP file format specification version 4.3
        // Member header and trailer
        // ID1 (IDentification 1)
        // ID2 (IDentification 2)
        // These have the fixed values ID1 = 31 (0x1f, \037), ID2 = 139 (0x8b, \213), to identify the file as being in gzip format.

        exit((ID[1] = 31) and (ID[2] = 139));
    end;
}

