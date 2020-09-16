page 90025 "Case Line Descriptions FactBox"
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
                RunObject = Page "Case Line Descriptions";
                RunPageLink = "Case No." = FIELD ("Case No."),
                              "Case Line No." = FIELD ("Case Line No.");
            }
        }
    }
}

