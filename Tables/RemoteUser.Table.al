table 90202 "Remote User"
{
    Caption = 'Remote User';

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
        field(4; Domain; Text[250])
        {
            Caption = 'Domain';
        }
        field(5; Username; Text[250])
        {
            Caption = 'Username';
        }
        field(6; Password; Text[250])
        {
            Caption = 'Password';
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
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure InitRecord()
    begin
        if GetFilter(Domain) <> '' then
            if GetRangeMin(Domain) = GetRangeMax(Domain) then
                Domain := GetFilter(Domain);
    end;
}

