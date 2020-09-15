table 90001 "Case E-Mail Template"
{
    Caption = 'Case E-mail Template';

    fields
    {
        field(1; "Code"; Code[25])
        {
            Caption = 'Code';
        }
        field(2; Body; BLOB)
        {
            Caption = 'Body';
        }
        field(3; Subject; Text[250])
        {
            Caption = 'Subject';
        }
        field(4; "Description in Subject"; Boolean)
        {
            Caption = 'Description in Subject';
        }
        field(5; Internal; Boolean)
        {
            Caption = 'Internal';

            trigger OnValidate()
            begin
                if not Internal then begin
                    "To Development Admin." := false;
                    "To Resources" := false;
                    "To Consultant" := false;
                    "To Developer" := false;
                end;
            end;
        }
        field(6; "To Development Admin."; Boolean)
        {
            Caption = 'To Development Admin.';

            trigger OnValidate()
            var
                CaseEMailTemplate: Record "Case E-Mail Template";
            begin
                if "To Development Admin." then begin
                    CaseEMailTemplate.SetFilter(Code, '<>%1', Code);
                    CaseEMailTemplate.ModifyAll("To Development Admin.", false);

                    Internal := true;
                end;
            end;
        }
        field(7; "Company Name in Subject"; Boolean)
        {
            Caption = 'Company Name in Subject';
        }
        field(8; "To Resources"; Boolean)
        {
            Caption = 'To Resources';

            trigger OnValidate()
            begin
                if "To Resources" then
                    Internal := true;
            end;
        }
        field(9; "To Consultant"; Boolean)
        {
            Caption = 'To Consultant';

            trigger OnValidate()
            begin
                if "To Consultant" then
                    Internal := true;
            end;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "To Developer"; Boolean)
        {
            Caption = 'To Developer';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "To Developer" then
                    Internal := true;
            end;
        }
        field(12; "Use Default E-Mail"; Boolean)
        {
            Caption = 'Use Default E-Mail';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SaveMailLayout(DescriptionText: Text)
    var
        oStream: OutStream;
    begin
        CalcFields(Body);
        Clear(Body);
        Body.CreateOutStream(oStream);
        oStream.WriteText(DescriptionText);
    end;


    procedure GetMailLayout(var DescriptionText: Text)
    var
        iStream: InStream;
        MyBigText: BigText;
    begin
        CalcFields(Body);
        if Body.HasValue then begin
            Body.CreateInStream(iStream);
            MyBigText.Read(iStream);
            MyBigText.GetSubText(DescriptionText, 1);
        end else
            DescriptionText := '';
    end;
}

