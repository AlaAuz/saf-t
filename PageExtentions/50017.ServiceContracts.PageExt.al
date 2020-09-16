pageextension 50017 "AUZ Service Contracts" extends "Service Contracts"
{
    layout
    {
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("First Service Date")
        {
            Visible = false;
        }
        modify("Service Order Type")
        {
            Visible = false;
        }
        modify("Invoice Period")
        {
            Visible = false;
        }
        modify("Expiration Date")
        {
            Visible = false;
        }


        moveafter("Last Price Update Date"; "Invoice Period", "Expiration Date")

        addafter("Last Price Update Date")
        {
            field("AUZ Last Invoice Date"; "Last Invoice Date")
            {
                ApplicationArea = All;
            }
            field("AUZ Next Invoice Date"; "Next Invoice Date")
            {
                ApplicationArea = All;
            }
            field("AUZ Calcd. Annual Amount"; "Calcd. Annual Amount")
            {
                ApplicationArea = All;
            }
            field("AUZ Annual Amount"; "Annual Amount")
            {
                ApplicationArea = All;
            }
            field("AUZ Amount per Period"; "Amount per Period")
            {
                ApplicationArea = All;
            }
            field("AUZ Next Invoice Period"; "Next Invoice Period")
            {
                ApplicationArea = All;
            }
            field("AUZ Contract Cost Amount"; "Contract Cost Amount")
            {
                ApplicationArea = All;
            }
            field("AUZ Contract Gain/Loss Amount"; "Contract Gain/Loss Amount")
            {
                ApplicationArea = All;
            }
            field(AUZTotalLineCostPerPeriod; TotalLineCostPerPeriod)
            {
                Caption = 'Total Line Cost Per Period';
                ApplicationArea = All;
            }
        }
    }

    var
        TotalLineCostPerPeriod: Decimal;
}