page 50075 "AUZ Case Line Desc. FactBox"
{
    Caption = 'Case Line Descriptions';
    Editable = false;
    PageType = ListPart;
    SourceTable = "AUZ Case Line Description";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
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
            action(Edit)
            {
                Caption = 'Edit';
                Image = Edit;
                ApplicationArea = All;
                RunObject = Page "AUZ Case Line Descriptions";
                RunPageLink = "Case No." = FIELD("Case No."),
                              "Case Line No." = FIELD("Case Line No.");
            }
        }
    }
}

