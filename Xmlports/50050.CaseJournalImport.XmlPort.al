xmlport 50050 "AUZ Case Journal Import"
{
    Caption = 'Case Journal Import';
    Direction = Import;
    Encoding = UTF8;
    FileName = '*.xml';
    FormatEvaluate = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(timereg)
        {
            textattribute(version)
            {

                trigger OnAfterAssignVariable()
                begin
                    if (version in ['1.0.0.0', '1.1.0.1']) or (StrPos(version, '1.2') <> 1) then
                        Error(Text000, '1.0.0.0, 1.1.0.1 or greater than 1.2.3.0', version);
                end;
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
                        Occurrence = Optional;

                        trigger OnAfterAssignVariable()
                        begin
                            if not (type in ['Registration', 'Default', 'Transfer']) then
                                Error('You can only insert with type Registration, Default or Transfer.');
                        end;
                    }
                    textattribute(name)
                    {
                    }
                    textattribute(defaultParent)
                    {
                        Occurrence = Optional;
                    }
                    textelement(subtimeitem)
                    {
                        textelement(number)
                        {

                            trigger OnAfterAssignVariable()
                            begin
                                CaseHourJnlLine.SetRange("Resource No.", resource);
                                if CaseHourJnlLine.FindLast then;
                                LineNo := CaseHourJnlLine."Line No." + 10000;

                                CaseHourJnlLine.Init;
                                CaseHourJnlLine.Validate("Resource No.", resource);
                                CaseHourJnlLine."Line No." := LineNo;
                                CaseHourJnlLine.Imported := true;
                                CaseHourJnlLine."Case No." := number;
                                CaseHourJnlLine.Insert(true);
                            end;
                        }
                        textelement(subtype)
                        {
                            MinOccurs = Zero;
                            XmlName = 'type';

                            trigger OnAfterAssignVariable()
                            begin
                                if subtype <> '' then
                                    CaseHourJnlLine."Work Type" := subtype
                                else
                                    CaseHourJnlLine."Work Type" := CaseSetup."Default Work Type";
                            end;
                        }
                        textelement(workdescription)
                        {
                            MinOccurs = Zero;

                            trigger OnAfterAssignVariable()
                            begin
                                if not IsPreMicrosoftStoreRelease then begin
                                    CaseHourJnlLine.SetWorkDescription(workdescription);
                                    CaseHourJnlLine.InsertCaseHourJnlDescriptions;
                                end;
                            end;
                        }
                        textelement(description)
                        {

                            trigger OnAfterAssignVariable()
                            begin
                                if IsPreMicrosoftStoreRelease then begin
                                    CaseHourJnlLine.SetWorkDescription(description);
                                    CaseHourJnlLine.InsertCaseHourJnlDescriptions;
                                end;
                            end;
                        }
                        textelement(fromdatetime)
                        {

                            trigger OnAfterAssignVariable()
                            var
                                Year: Integer;
                                Month: Integer;
                                Day: Integer;
                            begin
                                if fromdatetime <> '' then begin
                                    Evaluate(Year, CopyStr(fromdatetime, 1, 4));
                                    Evaluate(Month, CopyStr(fromdatetime, 6, 2));
                                    Evaluate(Day, CopyStr(fromdatetime, 9, 2));
                                    CaseHourJnlLine.Date := DMY2Date(Day, Month, Year);
                                end;
                            end;
                        }
                        textelement(todatetime)
                        {
                        }
                        textelement(manualtime)
                        {
                        }
                        textelement(totaltimespan)
                        {
                        }
                        textelement(roundedtimespan)
                        {

                            trigger OnAfterAssignVariable()
                            var
                                Hours: Integer;
                                Minutes: Integer;
                                Seconds: Integer;
                            begin
                                if totaltimespan <> '' then begin
                                    Evaluate(Hours, CopyStr(roundedtimespan, 1, 2));
                                    Evaluate(Minutes, CopyStr(roundedtimespan, 4, 2));
                                    Evaluate(Seconds, CopyStr(roundedtimespan, 7, 2));

                                    CaseHourJnlLine.Quantity := Hours + (Minutes / 60) + (Seconds / 3600);
                                end;
                            end;
                        }

                        trigger OnAfterAssignVariable()
                        begin
                            CaseHourJnlLine.Modify(true);
                        end;
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

    trigger OnInitXmlPort()
    begin
        CaseSetup.Get;
    end;

    var
        CaseSetup: Record "AUZ Case Setup";
        CaseHourJnlLine: Record "AUZ Case Journal Line";
        EntryNo: Integer;
        TempBT: BigText;
        OStream: OutStream;
        LineNo: Integer;
        Text000: Label 'You need version %1 of Time Registration to be able to upload hours. You have version %2.';

    local procedure IsPreMicrosoftStoreRelease(): Boolean
    begin
        exit(version in ['1.0.0.0', '1.1.0.1']);
    end;
}

