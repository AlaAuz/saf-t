page 90102 "Standard Solution Release Card"
{
    // *** Auzilium AS File Management ***
    // FM1.1.0 08.10.2017 HHV Added file management code. (AZ99999)

    Caption = 'Standard Solution Release';
    PageType = Card;
    SourceTable = "Standard Solution Release";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Standard Solution No."; "Standard Solution No.")
                {
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                }
                field("Version Code"; "Version Code")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Previous Version Code"; "Previous Version Code")
                {
                }
                field("Date Created"; "Date Created")
                {
                }
                field("Date Modified"; "Date Modified")
                {
                }
            }
            part(Control1000000004; "Standard Solution Contacts")
            {
                SubPageLink = "Standard Solution No." = FIELD ("Standard Solution No."),
                              "Version Code" = FIELD ("Version Code");
            }
            part(Control1000000005; "Standard Solution Objects")
            {
                SubPageLink = "Standard Solution No." = FIELD ("Standard Solution No."),
                              "Version Code" = FIELD ("Version Code");
            }
            part(Control1000000011; "Standard Solution Changes")
            {
                SubPageLink = "Standard Solution No." = FIELD ("Standard Solution No."),
                              "Version Code" = FIELD ("Version Code");
            }
        }
        area(factboxes)
        {
            part(ExtFileMgtFactBox; "External File FactBox")
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        //AZ99999+
        CurrPage.ExtFileMgtFactBox.PAGE.SetRec(Rec);
        //AZ99999-
    end;
}

