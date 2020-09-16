tableextension 50005 "AUZ Job" extends Job
{
    fields
    {
        field(50000; "AUZ Blocked for Time Registration"; Boolean)
        {
            Caption = 'Blocked for Time Registration';
            DataClassification = CustomerContent;
            Description = 'AZ99999';
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                if Blocked <> Blocked::" " then
                    Validate("AUZ Blocked for Time Registration", true);
            end;
        }
    }
}

