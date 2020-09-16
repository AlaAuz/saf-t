page 50004 "Contact Login Information"
{
    Caption = 'Login Information';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = StandardDialog;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            grid("Contact Login Information")
            {
                Caption = 'Contact Login Information';
                field(LoginInformation; LoginInformation)
                {
                    Caption = 'Login Information';
                    Editable = DynamicEditable;
                    MultiLine = true;
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        SaveLoginInformation(LoginInformation);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        DynamicEditable := CurrPage.Editable;
    end;

    trigger OnAfterGetRecord()
    begin
        GetLoginInformation(LoginInformation);
    end;

    var
        LoginInformation: Text;
        DynamicEditable: Boolean;
}
