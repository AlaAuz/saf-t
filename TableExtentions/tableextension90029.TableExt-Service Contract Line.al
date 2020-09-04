tableextension 90029 tableextension90029 extends "Service Contract Line"
{
    fields
    {
        field(50000; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
        field(50001; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
        field(50002; "Sales Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
    }

    local procedure Calculate()
    begin
        Validate("Line Value", Quantity * "Sales Price" * 12);
        Validate("Line Cost", Quantity * "Unit Cost" * 12);
        Modify;
    end;
}

