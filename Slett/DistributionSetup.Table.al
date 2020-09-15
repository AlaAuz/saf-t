table 70900 "Distribution Setup"
{
    Caption = 'Distribution Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Job Queue E-Mail"; Text[80])
        {
            Caption = 'Job Queue Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                if "Job Queue E-Mail" <> '' then
                    MailMgt.CheckValidEmailAddress("Job Queue E-Mail");
            end;
        }
        field(3; "BCC E-Mail"; Text[80])
        {
            Caption = 'BCC Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                if "BCC E-Mail" <> '' then
                    MailMgt.CheckValidEmailAddresses("BCC E-Mail");
            end;
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
        MailMgt: Codeunit "Mail Management";
}

