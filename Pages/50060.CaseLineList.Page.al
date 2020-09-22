page 600020 "AUZ Case Line List"
{
    Caption = 'Case Lines';
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "AUZ Case Line";
    SourceTableView = SORTING("Case No.", "Line No.");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
                }
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = All;
                }
                field("Contact Company No."; "Contact Company No.")
                {
                    ApplicationArea = All;
                }
                field("Contact.Name"; Contact.Name)
                {
                    Caption = 'Contact Company Name';
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Style = Attention;
                    StyleExpr = ShowAttention;
                }
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Work Type"; "Work Type")
                {
                    ApplicationArea = All;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                }
                field(Transferred; Transferred)
                {
                    ApplicationArea = All;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
                field("Date/Time Created"; "Date/Time Created")
                {
                    ApplicationArea = All;
                }
                field("Date/Time Modified"; "Date/Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case Card";
                RunPageLink = "No." = FIELD("Case No.");
            }
            action(Expenses)
            {
                Caption = 'Expenses';
                Image = InsertTravelFee;
                ApplicationArea = All;
                RunObject = Page "AUZ Case Lines Expenses";
                RunPageLink = "Case No." = FIELD("Case No."),
                              "Case Line No." = FIELD("Line No.");
                RunPageView = SORTING("Case No.", "Case Line No.");
            }
            action(Comments_Line)
            {
                Caption = 'Description';
                Image = ViewComments;
                ApplicationArea = All;
                RunObject = Page "AUZ Case Line Descriptions";
                RunPageLink = "Case No." = FIELD("Case No."),
                              "Case Line No." = FIELD("Line No.");
                RunPageView = SORTING("Case No.", "Case Line No.", "Line No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields(Description);
    end;

    trigger OnAfterGetRecord()
    begin
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