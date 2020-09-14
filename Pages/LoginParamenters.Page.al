page 90210 "Login Paramenters"
{
    Caption = 'Login Paramenters';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Login Paramenter";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Login Type"; "Login Type")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field(Sequence; Sequence)
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field(Replace; Replace)
                {
                    ShowMandatory = true;
                }
                field("Value Type"; "Value Type")
                {
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
    }
}

