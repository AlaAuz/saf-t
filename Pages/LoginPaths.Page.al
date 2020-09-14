page 90209 "Login Paths"
{
    Caption = 'Login Paths';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Login Path";

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
                }
                field(Description; Description)
                {
                }
                field(Path; Path)
                {
                    ShowMandatory = true;
                }
                field(Parameters; Parameters)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Paramenter Setup")
            {
                Caption = 'Paramenter Setup';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Login Paramenters";
                RunPageLink = "Login Type" = FIELD ("Login Type"),
                              Sequence = FIELD (Sequence);
            }
        }
    }
}

