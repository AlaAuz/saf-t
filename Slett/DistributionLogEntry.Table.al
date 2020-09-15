table 70901 "Distribution Log Entry"
{
    Caption = 'Distribution Log Entry';
    DrillDownPageID = "Distribution Log";
    LookupPageID = "Distribution Log";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Sales Invoice,Sales Credit Memo,Reminder,Fin. Charge Memo,Service Invoice,Service Credit Memo';
            OptionMembers = "Sales Invoice","Sales Credit Memo",Reminder,"Fin. Charge Memo","Service Invoice","Service Credit Memo";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = IF ("Document Type" = CONST("Sales Invoice")) "Sales Invoice Header"
            ELSE
            IF ("Document Type" = CONST("Sales Credit Memo")) "Sales Comment Line";
        }
        field(4; "Last Document Entry"; Boolean)
        {
            Caption = 'Last Document Entry';
            InitValue = true;
        }
        field(10; Date; Date)
        {
            Caption = 'Date';
        }
        field(11; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(12; "Error Message 2"; Text[250])
        {
            Caption = 'Error Message 2';
        }
        field(13; "Error Message 3"; Text[250])
        {
            Caption = 'Error Message 3';
        }
        field(14; "Error Message 4"; Text[250])
        {
            Caption = 'Error Message 4';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        if "Last Document Entry" then begin
            DistributionLogEntry.SetCurrentKey("Document Type", "Document No.", Date);
            DistributionLogEntry.SetRange("Document Type", "Document Type");
            DistributionLogEntry.SetRange("Document No.", "Document No.");
            DistributionLogEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
            if DistributionLogEntry.FindLast then begin
                DistributionLogEntry."Last Document Entry" := true;
                DistributionLogEntry.Modify;
            end;
        end;
    end;

    trigger OnInsert()
    var
        DistributionLogEntry: Record "Distribution Log Entry";
    begin
        DistributionLogEntry.SetCurrentKey("Document Type", "Document No.", Date);
        DistributionLogEntry.SetRange("Document Type", "Document Type");
        DistributionLogEntry.SetRange("Document No.", "Document No.");
        if DistributionLogEntry.FindLast then begin
            DistributionLogEntry."Last Document Entry" := false;
            DistributionLogEntry.Modify;
        end;
    end;


    procedure SetErrorMessage(ErrorMessage: Text)
    begin
        "Error Message" := CopyStr(ErrorMessage, 1, 250);
        "Error Message 2" := CopyStr(ErrorMessage, 251, 250);
        "Error Message 3" := CopyStr(ErrorMessage, 501, 250);
        "Error Message 4" := CopyStr(ErrorMessage, 751, 250);
    end;


    procedure GetErrorMessage(): Text
    begin
        exit("Error Message" + "Error Message 2" + "Error Message 3" + "Error Message 4");
    end;
}

