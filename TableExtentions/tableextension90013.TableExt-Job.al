tableextension 90013 tableextension90013 extends Job
{
    fields
    {

        //Unsupported feature: Code Insertion on "Blocked(Field 24)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        //AZ99999+
        if Blocked <> Blocked::" " then
          Validate("Blocked for Time Registration",true);
        //AZ99999-
        */
        //end;
        field(50000; "Blocked for Time Registration"; Boolean)
        {
            Caption = 'Blocked for Time Registration';
            DataClassification = ToBeClassified;
            Description = 'AZ99999';
        }
    }
}

