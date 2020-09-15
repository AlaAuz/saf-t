//ALA
/*
codeunit 70000 "EHF Tools"
{
    // *** EHF Solution by Auzilium AS ***
    // AZ99999 02.02.2015 EVA Handle PDF Attachment

    trigger OnRun()
    begin
    end;


    procedure GenerateSalesInvoicePDF(DocNo: Code[20]): Text
    var
        SalesInvHeader: Record "Sales Invoice Header";
        ReportSelection: Record "Report Selections";
        ServerFile: Text;
        FileMgt: Codeunit "File Management";
        Text64BaseEncoded: Text;
    begin
        //AZ99999+
        SalesInvHeader.SetRange("No.", DocNo);

        if not SalesInvHeader.FindFirst then
            exit('');

        ServerFile := FileMgt.ServerTempFileName('pdf');

        ReportSelection.SetRange(Usage, ReportSelection.Usage::"S.Invoice");
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Find('-');
        repeat
            REPORT.SaveAsPdf(ReportSelection."Report ID", ServerFile, SalesInvHeader);
        until ReportSelection.Next = 0;

        Text64BaseEncoded := StreamEncodePDF(ServerFile);

        FileMgt.DeleteServerFile(ServerFile);

        exit(Text64BaseEncoded);
        //AZ99999-
    end;


    procedure GenerateSalesCrMemoPDF(DocNo: Code[20]): Text
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReportSelection: Record "Report Selections";
        ServerFile: Text;
        FileMgt: Codeunit "File Management";
        Text64BaseEncoded: Text;
    begin
        //AZ99999+
        SalesCrMemoHeader.SetRange("No.", DocNo);

        if not SalesCrMemoHeader.FindFirst then
            exit('');

        ServerFile := FileMgt.ServerTempFileName('pdf');

        ReportSelection.SetRange(Usage, ReportSelection.Usage::"S.Cr.Memo");
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Find('-');
        repeat
            REPORT.SaveAsPdf(ReportSelection."Report ID", ServerFile, SalesCrMemoHeader);
        until ReportSelection.Next = 0;

        Text64BaseEncoded := StreamEncodePDF(ServerFile);

        FileMgt.DeleteServerFile(ServerFile);

        exit(Text64BaseEncoded);
        //AZ99999-
    end;

    local procedure StreamEncodePDF(_ServerFile: Text): Text
    var
        Text64BaseEncoded: Text;
        Byte: DotNet Array;
        Byte1: DotNet Array;
        Convert: DotNet Convert;
        MemoryStream: DotNet MemoryStream;
        SysFile: File;
        iStream: InStream;
    begin
        //AZ99999+
        Text64BaseEncoded := '';

        SysFile.Open(_ServerFile);
        SysFile.CreateInStream(iStream);

        MemoryStream := MemoryStream.MemoryStream();
        CopyStream(MemoryStream, iStream);
        Byte := MemoryStream.ToArray();

        MemoryStream.Dispose();
        MemoryStream := MemoryStream.MemoryStream();
        MemoryStream.Write(Byte, 0, Byte.Length);
        MemoryStream.Close();

        Clear(iStream);

        Text64BaseEncoded := Convert.ToBase64String(Byte);

        exit(Text64BaseEncoded);
        //AZ99999-
    end;


    procedure StreamDecodePDF(InputFile: Text[250]; OutputFile: Text[250]): Text
    var
        Text64BaseDecoded: Text;
        Byte: DotNet Array;
        Byte1: DotNet Array;
        Convert: DotNet Convert;
        MemoryStream: DotNet MemoryStream;
        SysFile: File;
        oStream: OutStream;
        ASCIIEncoding: DotNet ASCIIEncoding;
        InStream: InStream;
        FileMgt: Codeunit "File Management";
        ServerFile: Text;
        ClientFile: Text;
    begin
        //AZ99999+
        ServerFile := FileMgt.UploadFileSilent(InputFile);

        SysFile.Open(ServerFile);
        SysFile.CreateInStream(InStream);

        MemoryStream := MemoryStream.MemoryStream();
        CopyStream(MemoryStream, InStream);
        Byte1 := MemoryStream.ToArray();

        MemoryStream.Dispose();
        MemoryStream := MemoryStream.MemoryStream();
        MemoryStream.Write(Byte1, 0, Byte1.Length);
        MemoryStream.Close();
        SysFile.Close;

        //Convert --->
        ASCIIEncoding := ASCIIEncoding.ASCIIEncoding();
        Byte := Convert.FromBase64String(ASCIIEncoding.GetString(Byte1));

        FileMgt.DeleteServerFile(ServerFile);
        ServerFile := FileMgt.ServerTempFileName('pdf');

        SysFile.Create(ServerFile);
        SysFile.CreateOutStream(oStream);

        Clear(MemoryStream);
        MemoryStream := MemoryStream.MemoryStream(Byte);
        CopyStream(oStream, MemoryStream);
        SysFile.Close;

        ClientFile := FileMgt.DownloadTempFile(ServerFile);
        FileMgt.CopyClientFile(ClientFile, OutputFile, true);
        FileMgt.DeleteClientFile(ClientFile);

        ClearAll;
        //AZ99999-
    end;
}

    */

