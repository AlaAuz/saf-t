tableextension 50012 "AUZ Contact" extends Contact
{
    fields
    {
        field(50000; "AUZ Default Job No."; Code[20])
        {
            Caption = 'Default Job No.';
            DataClassification = CustomerContent;
            TableRelation = Job;

            trigger OnLookup()
            begin
                "AUZ Default Job No." := CaseTools.FindJob("Company No.");
            end;
        }
        field(50001; "AUZ Default Job Task No."; Code[20])
        {
            Caption = 'Default Job Task No.';
            DataClassification = CustomerContent;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("AUZ Default Job No."),
                                                             "Job Task Type" = CONST(Posting));
        }
        field(50002; "AUZ Login Information"; BLOB)
        {
            Caption = 'Login Information';
            DataClassification = CustomerContent;
        }
        field(50003; "AUZ Login Company No."; Code[20])
        {
            Caption = 'Login Company No.';
            DataClassification = CustomerContent;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
    }

    procedure SaveLoginInformation(DescriptionText: Text)
    var
        oStream: OutStream;
        xDescriptionText: Text;
    begin
        GetLoginInformation(xDescriptionText);
        if xDescriptionText <> DescriptionText then
            if not Confirm(Text50001, true) then
                exit;

        CalcFields("AUZ Login Information");
        Clear("AUZ Login Information");
        "AUZ Login Information".CreateOutStream(oStream);
        oStream.WriteText(DescriptionText);
    end;

    procedure GetLoginInformation(var DescriptionText: Text)
    var
        iStream: InStream;
        MyBigText: BigText;
    begin
        CalcFields("AUZ Login Information");
        if "AUZ Login Information".HasValue then begin
            "AUZ Login Information".CreateInStream(iStream);
            MyBigText.Read(iStream);
            MyBigText.GetSubText(DescriptionText, 1);
        end else
            DescriptionText := '';
    end;

    procedure ShowLoginInformation()
    var
        ContactCompany: Record Contact;
        ContactLoginInformation: Page "Contact Login Information";
    begin
        if "AUZ Login Company No." <> '' then
            ContactCompany.Get("AUZ Login Company No.")
        else
            ContactCompany.Get("Company No.");
        ContactLoginInformation.SetRecord(ContactCompany);
        ContactLoginInformation.Run;
    end;

    procedure GetLoginInformation2() LoginInformation: Text
    var
        ContactCompany: Record Contact;
    begin
        if "AUZ Login Company No." <> '' then
            ContactCompany.Get("AUZ Login Company No.")
        else
            ContactCompany.Get("Company No.");
        ContactCompany.GetLoginInformation(LoginInformation);
    end;

    var
        CaseTools: Codeunit "AUZ Case Management";
        Text50001: Label 'Do you want to save the changes?';
}