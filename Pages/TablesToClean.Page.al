page 50016 "Tables To Clean"
{
    PageType = List;
    SourceTable = "Tables To Clean";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                }
                field("Table Name"; "Table Name")
                {
                }
                field("Table Caption"; "Table Caption")
                {
                }
                field("Number of Records"; "Number of Records")
                {
                }
                field(Delete; Delete)
                {
                }
                field("Delete 2"; "Delete 2")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Records")
            {

                trigger OnAction()
                begin
                    GetAllTables();
                    CurrPage.Update;
                end;
            }
            action("Get Number Of Records")
            {

                trigger OnAction()
                begin
                    GetNumberOfRecords();
                    CurrPage.Update;
                end;
            }
            action("Mark Delete On")
            {

                trigger OnAction()
                begin
                    MarkON();
                    CurrPage.Update;
                end;
            }
            action("Mark Delete Off")
            {

                trigger OnAction()
                begin
                    MarkOff();
                    CurrPage.Update;
                end;
            }
            action("Delet Data")
            {

                trigger OnAction()
                begin
                    DeleteData();
                end;
            }
            action("Delet Data 2")
            {

                trigger OnAction()
                begin
                    DeleteData2();
                end;
            }
        }
    }
}

