pageextension 90055 "AUZ Service Contracts" extends "Service Contracts"
{
    // *** Auzilium AS ***
    // AZ99999 02.07.2018 EVA Added fields.
    // AZ99999 03.07.2018 DHG Added code.
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
            field("Last Invoice Date"; "Last Invoice Date")
            {
            }
            field("Next Invoice Date"; "Next Invoice Date")
            {
            }
            field("Calcd. Annual Amount"; "Calcd. Annual Amount")
            {
            }
            field("Annual Amount"; "Annual Amount")
            {
            }
            field("Amount per Period"; "Amount per Period")
            {
            }
            field("Next Invoice Period"; "Next Invoice Period")
            {
            }
            field("Contract Cost Amount"; "Contract Cost Amount")
            {
            }
            field("Contract Gain/Loss Amount"; "Contract Gain/Loss Amount")
            {
            }
            field(TotalLineCostPerPeriod; TotalLineCostPerPeriod)
            {
                Caption = 'Total Line Cost Per Period';
            }
        }
    }

    var
        TotalLineCostPerPeriod: Decimal;
}