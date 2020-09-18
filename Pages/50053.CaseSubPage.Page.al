page 50053 "AUZ Case SubPage"
{
    Caption = 'Case Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "AUZ Case Line";
    SourceTableView = SORTING("Case No.", "Line No.")
                      WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
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
                field(FirstDescription; FirstDescription)
                {
                    Caption = 'Description';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        ShowDescriptions;
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SetFirstDescription(FirstDescription);
                        CurrPage.Update(false);
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        ShowDescriptions;
                    end;
                }
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = ShowMandatoryReference;
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
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = All;
                }
                field("Contact Company No."; "Contact Company No.")
                {
                    ApplicationArea = All;
                }
                field("Contact Company Name"; "Contact Company Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Linje")
            {
                Caption = '&Line';
                Image = Line;
                group("F&unksjoner")
                {
                    Caption = 'F&unctions';
                    Image = "Action";
                    action("Generate Description")
                    {
                        Caption = 'Generate Description';
                        Image = UpdateDescription;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SaveRecord;
                            GenerateDescription;
                            CurrPage.Update;
                        end;
                    }
                }
                group("Relatert informasjon")
                {
                    Caption = 'Related Information';
                    action(Expenses)
                    {
                        Caption = '&Expenses';
                        Image = InsertTravelFee;
                        ApplicationArea = All;
                        RunObject = Page "AUZ Case Lines Expenses";
                        RunPageLink = "Case No." = FIELD("Case No."),
                                      "Case Line No." = FIELD("Line No.");
                        RunPageView = SORTING("Case No.", "Case Line No.");
                        ShortCutKey = 'Shift+Ctrl+e';
                    }
                    action(Descriptions)
                    {
                        Caption = '&Descriptions';
                        Image = ViewComments;
                        ApplicationArea = All;
                        ShortCutKey = 'Shift+Ctrl+d';

                        trigger OnAction()
                        begin
                            ShowDescriptions;
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcFields(Description);
    end;

    trigger OnAfterGetRecord()
    begin
        FirstDescription := GetFirstDescription;
        CaseHeader.Get("Case No.");
        ShowMandatoryReference := CaseHeader."Reference No. Mandatory";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Line No." := GetNextLineNo(xRec, BelowxRec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewLine;
        FirstDescription := '';
    end;


    local procedure ShowDescriptions()
    begin
        CurrPage.SaveRecord;
        ShowDescriptions;
        CurrPage.Update(false);
    end;

    var
        CaseHeader: Record "AUZ Case Header";
        FirstDescription: Text[50];
        ShowMandatoryReference: Boolean;
}