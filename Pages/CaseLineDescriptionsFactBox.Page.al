page 90025 "Case Line Descriptions FactBox"
{
    Caption = 'Case Line Descriptions';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Case Hour Description";

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
                              "Case Hour Line No." = FIELD ("Case Hour Line No.");
            }
        }
    }
}

