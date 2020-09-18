page 50074 "AUZ Login Info. FactBox"
{
    Caption = 'Login Info.';
    Editable = false;
    PageType = ListPart;
    SourceTable = "Name/Value Buffer";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control100000000)
            {
                ShowCaption = false;
                field(Value; Value)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        HyperLink(Value);
                    end;
                }
            }
            field(ActionText; ActionText)
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    LoginInfo: Text;
                    TempString: Text;
                    Separator: Text;
                    Values: List of [Text];
                    LineValue: Text;
                    String: Text;
                    CR: Char;
                    LF: Char;
                begin
                    Reset;
                    DeleteAll;
                    if ActionText = ClickToShowTxt then begin
                        LoginInfo := CaseHeader.GetLoginInformation;
                        CR := 13;
                        LF := 10;
                        String := LoginInfo;
                        Separator := Format(LF);
                        Values := String.Split(Separator);
                        foreach LineValue in Values do begin
                            TempString := LineValue;
                            TempString := DelChr(TempString, '=', Format(CR));
                            AddNewEntry('', CopyStr(TempString, 1, 250));
                        end;
                        if FindFirst then;
                        ActionText := ClickToHideTxt;
                    end else
                        ActionText := ClickToShowTxt;

                    CurrPage.Update(false);
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Show)
            {
                Caption = 'Show';
                Image = Database;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CaseHeader.ShowLoginInformation;
                end;
            }
            //ALA
            //FIX
            /*
            action(Save)
            {
                Caption = 'Save';
                Image = ExportDatabase;

                trigger OnAction()
                var
                    File: File;
                    ServerFileName: Text;
                begin
                    ServerFileName := FileMgt.ServerTempFileName('txt');
                    File.TextMode(true);
                    File.WriteMode(true);
                    File.Create(ServerFileName);
                    File.Write(CaseHeader.GetLoginInformation);
                    File.Close;
                    CaseHeader.CalcFields("Contact Company Name");
                    FileMgt.DownloadHandler(ServerFileName, '', '', FileMgt.GetToFilterText('', '.txt'), StrSubstNo('%1.txt', CaseHeader."Contact Company Name"));
                    FileMgt.DeleteServerFile(ServerFileName);
                end;
            } */
        }
    }

    procedure SetCaseHeader(NewCaseHeader: Record "AUZ Case Header")
    begin
        CaseHeader := NewCaseHeader;
    end;

    trigger OnOpenPage()
    begin
        ActionText := ClickToShowTxt
    end;

    var
        ClickToShowTxt: Label 'Click here to show login info.';
        CaseHeader: Record "AUZ Case Header";
        FileMgt: Codeunit "File Management";
        ClickToHideTxt: Label 'Click here to hide login info.';
        ActionText: Text;
}
