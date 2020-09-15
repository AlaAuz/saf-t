table 90201 "Remote Access"
{
    Caption = 'Remote Access';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Remote Access List";
    LookupPageID = "Remote Access List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    RemoteLoginSetup.Get;
                    NoSeriesMgt.TestManual(RemoteLoginSetup."Remote Login Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(100; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "No. Series")
        {
        }
    }

    trigger OnDelete()
    begin
        TestDelete();
    end;

    trigger OnInsert()
    begin
        InitInsert;
    end;

    var
        RemoteLoginSetup: Record "Remote Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: Label 'Table %1 is not empty.';

    local procedure InitInsert()
    begin
        if "No." = '' then begin
            RemoteLoginSetup.Get;
            RemoteLoginSetup.TestField("Remote Login Nos.");
            NoSeriesMgt.InitSeries(RemoteLoginSetup."Remote Login Nos.", xRec."No. Series", Today, "No.", "No. Series");
        end;
    end;

    local procedure TestDelete()
    begin
    end;
}

