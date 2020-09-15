codeunit 90200 "Remote Management"
{
    //ALA
    /*

    trigger OnRun()
    begin
    end;

    var
        NotSupportedErr: Label 'This function does not support login type %1..';
        RemoteUser: Record "Remote User";
        FileManagement: Codeunit "File Management";
        Environment: DotNet Environment;
        Process: DotNet Process;
        CouldNotFindErr: Label 'Could not not find %1 on your computer.';
        TeamViewerCap: Label 'Team Viewer';
        VMwareCap: ;


    procedure ConnectToComputer(RemoteLogin: Record "Remote Login")
    var
        LoginType: Record "Login Type";
        LoginPath: Record "Login Path";
        LoginParamenter: Record "Login Paramenter";
        ParamenterValue: Text;
        Paramenters: Text;
    begin
        RemoteLogin.TestField("Login Type");
        LoginType.Get(RemoteLogin."Login Type");

        RemoteUser.FilterGroup(2);
        RemoteUser.SetRange("Remote Access No.", RemoteLogin."Remote Access No.");
        RemoteUser.SetRange(Type, RemoteUser.Type::Computer);
        RemoteUser.SetFilter(Domain, RemoteLogin.Domain);
        RemoteUser.FilterGroup(0);
        if PAGE.RunModal(PAGE::"Remote Computer Users", RemoteUser) <> ACTION::LookupOK then
            exit;

        LoginPath.SetRange("Login Type", LoginType.Code);
        LoginPath.FindSet;
        repeat
            if LoginPath.Parameters <> '' then begin
                Paramenters := LoginPath.Parameters;
                LoginParamenter.SetRange("Login Type", LoginPath."Login Type");
                LoginParamenter.SetRange(Sequence, LoginPath.Sequence);
                if LoginParamenter.FindSet then
                    repeat
                        case LoginParamenter."Value Type" of
                            LoginParamenter."Value Type"::Domain:
                                ParamenterValue := RemoteUser.Domain;
                            LoginParamenter."Value Type"::Username:
                                ParamenterValue := RemoteUser.Username;
                            LoginParamenter."Value Type"::Password:
                                ParamenterValue := RemoteUser.Password;
                            LoginParamenter."Value Type"::"Login ID":
                                ParamenterValue := RemoteLogin."Login ID";
                        end;
                        Paramenters := StringReplace(Paramenters, LoginParamenter.Replace, ParamenterValue);
                    until LoginParamenter.Next = 0;
            end;

            StartProcess(Environment.ExpandEnvironmentVariables(LoginPath.Path), Paramenters);
        until LoginPath.Next = 0;
    end;

    local procedure StringReplace(StringToReplace: Text; OldValue: Text; NewValue: Text): Text
    var
        DotNetString: DotNet String;
        NewString: Text;
    begin
        DotNetString := StringToReplace;
        NewString := DotNetString.Replace(OldValue, NewValue);
        exit(NewString);
    end;

    local procedure StartProcess(FileName: Text; Arguments: Text)
    begin
        if IsNull(Process) then
            Process := Process.Process;
        Process.StartInfo.FileName := FileName;
        Process.StartInfo.Arguments := Arguments;
        Process.Start();
    end;

    trigger Process::OutputDataReceived(sender: Variant; e: DotNet DataReceivedEventArgs)
    begin
    end;

    trigger Process::ErrorDataReceived(sender: Variant; e: DotNet DataReceivedEventArgs)
    begin
    end;

    trigger Process::Exited(sender: Variant; e: DotNet EventArgs)
    begin
    end;

    trigger Process::Disposed(sender: Variant; e: DotNet EventArgs)
    begin
    end;
    */
}

