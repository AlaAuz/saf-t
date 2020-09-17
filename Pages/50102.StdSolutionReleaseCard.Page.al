page 50102 "AUZ Std. Solution Release Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 08.10.2017 HHV Added file management code. (AZ99999)

    Caption = 'Standard Solution Release';
    PageType = Card;
    SourceTable = "AUZ Standard Solution Release";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Standard Solution No."; "Standard Solution No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Version Code"; "Version Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Previous Version Code"; "Previous Version Code")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = All;
                }
                field("Date Modified"; "Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000004; "AUZ Std. Solution Contacts")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("Standard Solution No."),
                              "Version Code" = FIELD("Version Code");
            }
            part(Control1000000005; "AUZ Std. Solution Objects")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("Standard Solution No."),
                              "Version Code" = FIELD("Version Code");
            }
            part(Control1000000011; "AUZ Std. Solution Changes")
            {
                ApplicationArea = All;
                SubPageLink = "Standard Solution No." = FIELD("Standard Solution No."),
                              "Version Code" = FIELD("Version Code");
            }
        }
        area(factboxes)
        {
            part(AFMFileFactBox; "AFM File FactBox")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //AZ99999+
        CurrPage.AFMFileFactBox.PAGE.SetRecordVariant(Rec);
        //AZ99999-
    end;
}