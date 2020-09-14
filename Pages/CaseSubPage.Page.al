page 90003 "Case SubPage"
{
    Caption = 'Case Hours';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "Case Line";
    SourceTableView = SORTING ("Case No.", "Line No.")
                      WHERE (Posted = CONST (false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Resource No."; "Resource No.")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(FirstDescription; FirstDescription)
                {
                    Caption = 'Description';

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
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        ShowDescriptions;
                    end;
                }
                field("Reference No."; "Reference No.")
                {
                    ShowMandatory = ShowMandatoryReference;
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
                field("Case Description"; "Case Description")
                {
                }
                field("Contact Company No."; "Contact Company No.")
                {
                }
                field("Contact Company Name"; "Contact Company Name")
                {
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
                        RunObject = Page "Case Line Expenses";
                        RunPageLink = "Case No." = FIELD ("Case No."),
                                      "Case Hour Line No." = FIELD ("Line No.");
                        RunPageView = SORTING ("Case No.", "Case Hour Line No.");
                        ShortCutKey = 'Shift+Ctrl+e';
                    }
                    action(Descriptions)
                    {
                        Caption = '&Descriptions';
                        Image = ViewComments;
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

    var
        CaseHeader: Record "Case Header";
        FirstDescription: Text[50];
        ShowMandatoryReference: Boolean;

    local procedure ShowDescriptions()
    begin
        CurrPage.SaveRecord;
        ShowDescriptions;
        CurrPage.Update(false);
    end;
}

