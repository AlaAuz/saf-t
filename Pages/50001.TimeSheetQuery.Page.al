page 60001 "AUZ Time Sheet Query"
{
    PageType = Worksheet;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Resource; TimeSheet.Resource_No)
                {
                    Caption = 'Resource No.';
                    ApplicationArea = All;
                }
                field(Description; TimeSheet.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Date; TimeSheet.Date)
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field(Quantity; TimeSheet.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if not TimeSheet.Read then
            exit;
    end;

    trigger OnClosePage()
    begin
        TimeSheet.Close;
    end;

    trigger OnOpenPage()
    begin
        TimeSheet.Open();

        NumberOfRows := 0;

        while TimeSheet.Read do
            NumberOfRows += 1;

        TimeSheet.Close;

        TimeSheet.Open();

        SetRange(Number, 1, NumberOfRows);
    end;

    var
        TimeSheet: Query "AUZ Time Sheet";
        NumberOfRows: Integer;
}