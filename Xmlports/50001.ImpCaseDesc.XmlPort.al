xmlport 50001 "AUZ Imp Case Desc"
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

    var
        Cases: Record "AUZ Case Header";
        MyText: Text;
        LineFeed: Text[2];
}