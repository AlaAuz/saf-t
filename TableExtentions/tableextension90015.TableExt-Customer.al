tableextension 90015 tableextension90015 extends Customer
{
    // *** Auzilium AS ***
    // AZ99999 06.02.2018 HHV Changed code to be able to add multiple e-mails.
    // 
    // *** Auzilium AS Document Distribution ***
    // <DD>
    //   Added fields "Distribution Type" and "Invoice E-Mail".
    // </DD>
    fields
    {


        //Unsupported feature: Code Modification on ""E-Mail"(Field 102).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        MailManagement.ValidateEmailAddressField("E-Mail");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //AZ99999+
        //MailManagement.ValidateEmailAddressField("E-Mail");
        if "E-Mail" <> '' then
          MailManagement.CheckValidEmailAddresses("E-Mail");
        //AZ99999-
        */
        //end;
        field(50000; "Invoicing Period Code"; Code[10])
        {
            Caption = 'Invoicing Period Code';
            Description = 'AZ99999';
            TableRelation = "Invoicing Period";
        }
        field(50001; "Developer ID"; Code[50])
        {
            Caption = 'Developer ID';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
            TableRelation = "User Setup"."User ID" WHERE (Developer = CONST (true));
        }
        field(50002; "Consultant ID"; Code[50])
        {
            Caption = 'Consultant ID';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
            TableRelation = "User Setup"."User ID" WHERE (Consultant = CONST (true));
        }
    }
}

