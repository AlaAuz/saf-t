tableextension 90025 "AUZ Contact" extends Contact
{
    // *** Oseberg Solutions AS ***
    // AZ10001 17.03.2014 EVA New fields.
    // AZ99999 17.12.2017 HHV Added field "DropDown Company Name" to be used in DropDown because of bug.
    // AZ99999 06.02.2018 HHV Changed code to be able to add multiple e-mails.
    fields
    {
        field(50008; "Default Job No."; Code[20])
        {
            Caption = 'Default Job No.';
            Description = 'AZ10001';
            TableRelation = Job;

            trigger OnLookup()
            begin
                "Default Job No." := CaseTools.FindJob("Company No.");
            end;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(50009; "Default Job Task No."; Code[20])
        {
            Caption = 'Default Job Task No.';
            Description = 'AZ10001';
            TableRelation = "Job Task"."Job Task No." WHERE ("Job No." = FIELD ("Default Job No."),
                                                             "Job Task Type" = CONST (Posting));
        }
        field(50010; "Login Information"; BLOB)
        {
            Caption = 'Login Information';
        }
        field(50011; "Login Company No."; Code[20])
        {
            Caption = 'Login Company No.';
            TableRelation = Contact WHERE (Type = CONST (Company));
        }
    }

    procedure SaveLoginInformation(DescriptionText: Text)
    var
        oStream: OutStream;
        xDescriptionText: Text;
    begin
        //AZ99999+
        GetLoginInformation(xDescriptionText);
        if xDescriptionText <> DescriptionText then
            if not Confirm(Text50001, true) then
                exit;

        CalcFields("Login Information");
        Clear("Login Information");
        "Login Information".CreateOutStream(oStream);
        oStream.WriteText(DescriptionText);
        //AZ99999-
    end;

    procedure GetLoginInformation(var DescriptionText: Text)
    var
        iStream: InStream;
        MyBigText: BigText;
    begin
        //AZ99999+
        CalcFields("Login Information");
        if "Login Information".HasValue then begin
            "Login Information".CreateInStream(iStream);
            MyBigText.Read(iStream);
            MyBigText.GetSubText(DescriptionText, 1);
        end else
            DescriptionText := '';
        //AZ99999-
    end;

    procedure ShowLoginInformation()
    var
        ContactCompany: Record Contact;
        ContactLoginInformation: Page "Contact Login Information";
    begin
        //AZ99999+
        if "Login Company No." <> '' then
            ContactCompany.Get("Login Company No.")
        else
            ContactCompany.Get("Company No.");
        ContactLoginInformation.SetRecord(ContactCompany);
        ContactLoginInformation.Run;
        //AZ99999-
    end;

    procedure GetLoginInformation2() LoginInformation: Text
    var
        ContactCompany: Record Contact;
    begin
        //AZ99999+
        if "Login Company No." <> '' then
            ContactCompany.Get("Login Company No.")
        else
            ContactCompany.Get("Company No.");
        ContactCompany.GetLoginInformation(LoginInformation);
        //AZ99999-
    end;


    var
        CaseTools: Codeunit "Case Tools";
        Text50001: Label 'Do you want to save the changes?';
}

