page 50001 "Time Sheet Query"
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
                    Caption = 'Ressurs nr.';
                }
                field(Description; TimeSheet.Description)
                {
                    Caption = 'Beskrivelse';
                }
                field(Date; TimeSheet.Date)
                {
                    Caption = 'Dato';
                }
                field(Quantity; TimeSheet.Quantity)
                {
                    Caption = 'Antall';
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

