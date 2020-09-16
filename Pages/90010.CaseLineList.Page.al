page 90010 "Case Line List"
{
    Caption = 'Case Lines';
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "AUZ Case Line";
    SourceTableView = SORTING ("Case No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                }
                field("Case Description"; "Case Description")
                {
                }
                field("Contact Company No."; "Contact Company No.")
                {
                }
                field("Contact.Name"; Contact.Name)
                {
                    Caption = 'Contact Company Name';
                }
                field("Resource No."; "Resource No.")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Description; Description)
                {
                    Style = Attention;
                    StyleExpr = ShowAttention;
                }
                field("Reference No."; "Reference No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Work Type"; "Work Type")
                {
                }
                field(Chargeable; Chargeable)
                {
                }
                field(Transferred; Transferred)
                {
                }
                field(Posted; Posted)
                {
                }
                field("Date/Time Created"; "Date/Time Created")
                {
                }
                field("Date/Time Modified"; "Date/Time Modified")
                {
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(ShowCase)
            {
                Caption = 'Case';
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Case Card";
                RunPageLink = "No." = FIELD ("Case No.");
            }
            action(Expenses)
            {
                Caption = 'Expenses';
                Image = InsertTravelFee;
                RunObject = Page "Case Lines Expenses";
                RunPageLink = "Case No." = FIELD ("Case No."),
                              "Case Line No." = FIELD ("Line No.");
                RunPageView = SORTING ("Case No.", "Case Line No.");
            }
            action(Comments_Line)
            {
                Caption = 'Description';
                Image = ViewComments;
                RunObject = Page "Case Line Descriptions";
                RunPageLink = "Case No." = FIELD ("Case No."),
                              "Case Line No." = FIELD ("Line No.");
                RunPageView = SORTING ("Case No.", "Case Line No.", "Line No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields(Description);
    end;

    trigger OnAfterGetRecord()
    begin
        /*
        IF "Expense Entry No." = 0 THEN
          ShowAttention := FALSE
        ELSE
          ShowAttention := TRUE;
        */
        CalcFields(Description, "Contact Company No.");

        if not Contact.Get("Contact Company No.") then
            Contact.Init;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewLine();
    end;

    var
        ShowAttention: Boolean;
        Contact: Record Contact;
}

