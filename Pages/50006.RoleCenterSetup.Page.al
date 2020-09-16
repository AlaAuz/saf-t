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
            group("Key Performance Indicators")
            {
                Caption = 'Key Performance Indicators';
                group("So far this year")
                {
                    Caption = 'So Far This Year';
                    field("KPI Rev. G/L Acc. No. Filt."; "KPI Rev. G/L Acc. Filter")
                    {
                        ApplicationArea = All;
                    }
                    field("KPI Budget Name"; "KPI Budget Name")
                    {
                        ApplicationArea = All;
                    }
                    field("KPI Budg. G/L Acc. No. Filt."; "KPI Budg. G/L Acc. Filter")
                    {
                        ApplicationArea = All;
                    }
                }
                group("This year")
                {
                    Caption = 'This Year';
                    field("KPI Whse. G/L Acc. No. Filt."; "KPI Whse. G/L Acc. Filter")
                    {
                        ApplicationArea = All;
                    }
                    field("KPI Total Budget Name"; "KPI Total Budget Name")
                    {
                        ApplicationArea = All;
                    }
                    field("KPI TBudg. G/L Acc. No. Filt."; "KPI Tot. Budg. G/L Acc. Filter")
                    {
                        ApplicationArea = All;
                    }
                }
            }
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
                field("Dim. Chart G/L Acc. No. Filt."; "Turnover G/L Account Filter")
                {
                    ApplicationArea = All;
                }
                field("Dim. Chart Dimension Code"; "Salesperson Dimension Code")
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