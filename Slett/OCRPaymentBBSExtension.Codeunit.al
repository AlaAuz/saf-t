codeunit 50008 "OCR Payment - BBS Extension"
{

    trigger OnRun()
    begin
    end;


    procedure GetFirstOCRFileName(var FileName: Text)
    var
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        FileMgt: Codeunit "File Management";
        ClientDirectory: Text;
    begin
        if FileName = '' then exit;
        ClientDirectory := FileMgt.GetDirectoryName(FileName);
        if not FileMgt.ClientDirectoryExists(ClientDirectory) then exit;
        FileMgt.GetClientDirectoryFilesList(TempNameValueBuffer, ClientDirectory);
        TempNameValueBuffer.SetFilter(Name, '<>*~');
        if TempNameValueBuffer.FindFirst then
            FileName := TempNameValueBuffer.Name;
    end;
}

