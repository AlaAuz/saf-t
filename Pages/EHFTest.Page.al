page 70005 "EHF Test"
{
    PageType = Card;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                field(InputFile; InputFile)
                {
                    Caption = 'Input File';
                }
                field(OutputFile; OutputFile)
                {
                    Caption = 'Output File';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                Caption = 'Import';

                trigger OnAction()
                var
                    EHFTOols: Codeunit "EHF Tools";
                begin
                    EHFTOols.StreamDecodePDF(InputFile, OutputFile);
                end;
            }
        }
    }

    var
        InputFile: Text;
        OutputFile: Text;
}

