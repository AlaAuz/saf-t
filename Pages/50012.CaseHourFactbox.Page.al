page 50012 "AUZ Case Line Factbox"
{
    Caption = 'Posted Hours';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "AUZ Case Line";
    SourceTableView = SORTING("Case No.", "Line No.")
                      WHERE(Posted = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DescriptionOnLookup;
                    end;
                }
                field("Work Type"; "Work Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Transferred; Transferred)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                group("Relatert informasjon")
                {
                    Caption = 'Related Information';
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
                    action(Descriptions)
                    {
                        Caption = 'Descriptions';
                        Image = ViewComments;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            DescriptionOnLookup;
                        end;
                    }
                }
            }
        }
    }

    local procedure DescriptionOnLookup()
    begin
        CurrPage.SaveRecord;
        ShowDescriptions;
        CurrPage.Update;
    end;
}