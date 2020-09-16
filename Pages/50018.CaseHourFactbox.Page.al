page 50018 "Case Line Factbox"
{
    Caption = 'Posted Hours';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "AUZ Case Line";
    SourceTableView = SORTING ("Case No.", "Line No.")
                      WHERE (Posted = CONST (true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Visible = false;
                }
                field(Date; Date)
                {
                }
                field("Resource No."; "Resource No.")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                }
                field(Description; Description)
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        DescriptionOnLookup;
                    end;
                }
                field("Work Type"; "Work Type")
                {
                    Visible = false;
                }
                field(Chargeable; Chargeable)
                {
                    Visible = false;
                }
                field(Transferred; Transferred)
                {
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
                        RunObject = Page "Case Lines Expenses";
                        RunPageLink = "Case No." = FIELD ("Case No."),
                                      "Case Line No." = FIELD ("Line No.");
                        RunPageView = SORTING ("Case No.", "Case Line No.");
                    }
                    action(Descriptions)
                    {
                        Caption = 'Descriptions';
                        Image = ViewComments;

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

