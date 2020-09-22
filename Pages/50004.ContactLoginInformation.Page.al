page 60002 "AUZ Contact Login Information"
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
                    ApplicationArea = All;
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