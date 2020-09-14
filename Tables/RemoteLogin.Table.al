table 90203 "Remote Login"
{
    Caption = 'Remote Login';

    fields
    {
        field(1; "Remote Access No."; Code[20])
        {
            Caption = 'Remote Access No.';
            TableRelation = "Remote Access";
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'VPN,Computer';
            OptionMembers = VPN,Computer;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Comuter Type"; Code[10])
        {
            Caption = 'Computer Type';
            TableRelation = "Computer Type";
        }
        field(5; Domain; Text[250])
        {
            Caption = 'Domain';
        }
        field(6; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(7; "Login Type"; Code[10])
        {
            Caption = 'Login Type';
            TableRelation = "Login Type";
        }
        field(8; "Login ID"; Text[250])
        {
            Caption = 'Login ID';
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Remote Access No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Remote Access No.", Type, "Line No.")
        {
        }
    }

    var
        RemoteLoginSetup: Record "Remote Setup";
        RemoteManagement: Codeunit "Remote Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure ConnectToComputer()
    begin
        RemoteManagement.ConnectToComputer(Rec);
    end;
}

