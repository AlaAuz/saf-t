table 70401 "External File"
{
    // *** Auzilium AS File Management ***

    Caption = 'External File';
    DrillDownPageID = "External File List";
    LookupPageID = "External File List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
        }
        field(3; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(4; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
        }
        field(5; "Uploaded by User"; Code[50])
        {
            Caption = 'Uploaded by User';
        }
        field(6; "Uploaded Date"; Date)
        {
            Caption = 'Uploaded Date';
        }
        field(9; File; BLOB)
        {
            Caption = 'File';
        }
        field(10; "Source Table"; Integer)
        {
            Caption = 'Source Table';
        }
        field(11; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(12; "Soruce No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(13; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.';
        }
        field(50000; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Record ID")
        {
        }
        key(Key3; "Source Table", "Source Type", "Soruce No.", "Source Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

