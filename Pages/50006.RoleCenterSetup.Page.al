page 50008 "AUZ Role Center Setup"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Role Center Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "AUZ Role Center Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Chart")
            {
                Caption = 'Chart';
                field("Sales Chart G/L Acc. No. Filt."; "Sales Chart G/L Acc. Filter")
                {
                    ApplicationArea = All;
                }
                field("Sales Chart Budget Name"; "Sales Chart Budget Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset;
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}