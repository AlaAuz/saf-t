page 70901 "Distribution Log"
{
    Caption = 'Distribution Log';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Distribution Log Entry";
    SourceTableView = ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(Date; Date)
                {
                }
                field(GetErrorMessage; GetErrorMessage)
                {
                    Caption = 'Error Message';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if FindFirst then;
    end;
}

