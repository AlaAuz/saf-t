page 90208 "Login Types"
{
    Caption = 'Login Types';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Login Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ShowMandatory = true;
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Paths)
            {
                Caption = 'Paths';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Login Paths";
                RunPageLink = "Login Type" = FIELD (Code);
            }
        }
    }
}

