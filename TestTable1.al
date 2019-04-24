table 50100 MyTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; MyField2; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(3; MyField3; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(4; MyField4; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(5; MyField5; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; MyField)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}