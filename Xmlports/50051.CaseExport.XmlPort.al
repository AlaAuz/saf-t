xmlport 50051 "AUZ Case Export"
{
    Direction = Export;
    Encoding = UTF8;
    FileName = '*.xml';
    FormatEvaluate = Xml;

    schema
    {
        textelement(timereg)
        {
            textattribute(version)
            {
            }
            textelement(resource)
            {
            }
            textelement(timeitems)
            {
                textelement(timeitem)
                {
                    textattribute(type)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            type := 'Case';
                        end;
                    }
                    textattribute(name)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            name := 'Cases';
                        end;
                    }
                    textattribute(defaultParent)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            defaultParent := 'true';
                        end;
                    }
                    tableelement("Case Header"; "AUZ Case Header")
                    {
                        XmlName = 'subtimeitem';
                        fieldelement(number; "Case Header"."No.")
                        {
                        }
                        fieldelement(type; "Case Header"."Work Type Code")
                        {
                        }
                        textelement(workdescription)
                        {
                            MinOccurs = Zero;

                            trigger OnBeforePassVariable()
                            var
                                WorkDesc: Text;
                            begin
                                "Case Header".GetDescriptionChangeRequest(WorkDesc);
                                if StrLen(WorkDesc) > MaxStrLen(workdescription) then
                                    workdescription := CopyStr(WorkDesc, 1, MaxStrLen(workdescription) - 3) + '...'
                                else
                                    workdescription := WorkDesc;
                            end;
                        }
                        fieldelement(description; "Case Header".Description)
                        {
                        }
                        fieldelement(fromdatetime; "Case Header"."Registered Date")
                        {
                        }
                        fieldelement(todatetime; "Case Header"."Completed Date")
                        {
                        }
                    }
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
}

