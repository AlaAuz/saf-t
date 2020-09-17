//page 71100 "Service Copy Setup"
page 50009 "AUZ Service Copy Setup"
{
    Caption = 'Service Copy Setup';
    SourceTable = "AUZ Service Copy Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exact Cost Reversing Mandatory"; "Exact Cost Reversing Mandatory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}