page 90103 "Standard Solution Contacts"
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

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Contact Name"; "Contact Name")
                {
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
                    RunObject = Page "Case List";
                    RunPageLink = "Standard Solution No." = FIELD ("Standard Solution No."),
                                  "Contact Company No." = FIELD ("Contact No.");
                }
            }
        }
    }
}

