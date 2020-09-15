xmlport 50001 "Imp Case Desc"
{
    //Encoding = UTF8;  ALA
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

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
                            Cases.GetDescriptionChangeRequest(MyText);

                            LineFeed[1] := 13;
                            LineFeed[2] := 10;

                            MyText += CaseDesc + LineFeed;

                            Cases.SaveDescriptionChangeRequest(MyText);
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
        Cases: Record "Case Header";
        MyText: Text;
        LineFeed: Text[2];
}

