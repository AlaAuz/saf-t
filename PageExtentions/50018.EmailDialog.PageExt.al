pageextension 50018 "AUZ Email Dialog" extends "Email Dialog"
{
    // *** Auzilium AS ***
    // AZ99999 09.11.2018 HHV Commented out code to keep html text.
    layout
    {


        //Unsupported feature: Code Modification on "MessageContents(Control 5).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UpdatePlainTextVisible;

        case EmailItem."Message Type" of
        #4..8
            end;
          EmailItem."Message Type"::"Custom Message":
            begin
              BodyText := PreviousBodyText;
              EmailItem.SetBodyText(BodyText);
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
              //AZ99999+
              //BodyText := PreviousBodyText;
              //AZ99999-
        #13..15
        */
        //end;
    }
}

