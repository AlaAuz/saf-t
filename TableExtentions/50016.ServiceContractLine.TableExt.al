tableextension 50016 "AUZ Service Contract Line" extends "Service Contract Line"
{
    fields
    {
        field(50000; "AUZ Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
        field(50001; "AUZ Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
        field(50002; "AUZ Sales Price"; Decimal)
        {
            Caption = 'Sales Price';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Calculate;
            end;
        }
    }

    local procedure Calculate()
    begin
        Validate("Line Value", "AUZ Quantity" * "AUZ Sales Price" * 12);
        Validate("Line Cost", "AUZ Quantity" * "AUZ Unit Cost" * 12);
        Modify;
    end;
}