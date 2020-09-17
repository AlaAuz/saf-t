page 50103 "AUZ Std. Solution Contacts"
{
    Caption = 'Contacts';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "AUZ Standard Solution Contact";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Contact Name"; "Contact Name")
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
            group(Line)
            {
                Caption = 'Line';
                action(Cases)
                {
                    Caption = 'Cases';
                    Image = Timesheet;
                    ApplicationArea = All;
                    RunObject = Page "AUZ Case List";
                    RunPageLink = "Standard Solution No." = FIELD("Standard Solution No."),
                                  "Contact Company No." = FIELD("Contact No.");
                }
            }
        }
    }
}

