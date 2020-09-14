codeunit 50000 "Test Functions"
{

    trigger OnRun()
    begin
        PrintPDF;
    end;

    local procedure PrintPDF()
    var
        [RunOnClient]
        ProcessStartInfo: DotNet ProcessStartInfo;
        [RunOnClient]
        Process: DotNet Process;
        ProcessWindowStyle: DotNet ProcessWindowStyle;
    begin
        if IsNull(ProcessStartInfo) then
            ProcessStartInfo := ProcessStartInfo.ProcessStartInfo;
        ProcessStartInfo.Verb := 'Print';
        //ProcessStartInfo.Verb := 'PrintTo';
        ProcessStartInfo.CreateNoWindow := false;
        ProcessStartInfo.WindowStyle := ProcessWindowStyle.Hidden;
        ProcessStartInfo.FileName := 'C:\Auzilium\Resources\DHG\Test.pdf';
        Process := Process.Process;
        Process.Start(ProcessStartInfo);
        Message('ok');
    end;
}

