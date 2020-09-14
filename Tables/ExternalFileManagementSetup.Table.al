table 70400 "External File Management Setup"
{
    // *** Auzilium AS File Management ***

    Caption = 'External File Management Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(9; "Save to Database"; Boolean)
        {
            Caption = 'Save to Database';
            InitValue = true;

            trigger OnValidate()
            var
                ExternalFile: Record "External File";
            begin
                if not "Save to Database" then
                    TestField("File Directory");

                if "Save to Database" <> xRec."Save to Database" then
                    if not ExternalFile.IsEmpty then
                        Error(Text000, FieldCaption("Save to Database"));
            end;
        }
        field(10; "File Directory"; Text[250])
        {
            Caption = 'File Directory';

            trigger OnValidate()
            begin
                if "File Directory" = '' then
                    TestField("Save to Database");
            end;
        }
        field(11; "Run on Client"; Boolean)
        {
            Caption = 'Run on Client';
        }
        field(20; "Copy Files to Posted Shpt."; Boolean)
        {
            Caption = 'Copy Files to Posted Shipment';
            InitValue = true;
        }
        field(21; "Copy Files to Posted Inv."; Boolean)
        {
            Caption = 'Copy Files to Posted Invoice';
            InitValue = true;
        }
        field(22; "Copy Files to Posted Cr. Memo"; Boolean)
        {
            Caption = 'Copy Files to Posted Credit Memo';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You cannot change %1 when there are saved files.';
}

