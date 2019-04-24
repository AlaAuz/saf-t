page 50101 MyPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MyTable;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(MyField; MyField)
                {
                    Caption = 'test 1';
                    ApplicationArea = All;
                }

                field(MyField4; MyField4)
                {
                    Caption = 'test 4';
                    ApplicationArea = All;
                }

                field(MyField5; MyField5)
                {
                    Caption = 'test 5';
                    ApplicationArea = All;
                }

                field(MyField2; MyField2)
                {
                    ApplicationArea = All;
                }
                field(MyField3; MyField3)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}