xmlport 50002 "AUZ Imp Case Desc solution"
{
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'MyCases';
                UseTemporary = true;
                textelement(CaseNo)
                {
                }
                textelement(CaseDesc)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        if Cases.Get(CaseNo) then begin
                            MyText := '';
                            Cases.GetDescriptionSolution(MyText);

                            LineFeed[1] := 13;
                            LineFeed[2] := 10;

                            MyText += CaseDesc + LineFeed;

                            Cases.SaveDescriptionSolution(MyText);
                            Cases.Modify;
                        end;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Cases: Record "AUZ Case Header";
        MyText: Text;
        LineFeed: Text[2];
}

