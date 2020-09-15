report 50002 "Import Huldt & Lillevik Std"
{
    Caption = 'Import Huldt & Lillevik';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Alternativer)
                {
                    Caption = 'Options';
                    field(PostDate; PostDate)
                    {
                        Caption = 'Posting date';
                    }
                    field(DocumentText; DocumentText)
                    {
                        Caption = 'Document text';
                    }
                    field(FileName; Filename)
                    {
                        AssistEdit = true;
                        Caption = 'File Name';

                        trigger OnAssistEdit()
                        begin
                            Filename := FileMgt.OpenFileDialog(Text15000003, Filename, Text15000004);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PostDate := WorkDate;
            if DocumentText = '' then
                DocumentText := Text15000002;
            Filename := PayrollSetup."File Name";
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        PayrollSetup.Get;
    end;

    trigger OnPostReport()
    begin
        TxtFile.Close;
        if PayrollSetup."Save Payroll File" then
            NewFilename;
    end;

    trigger OnPreReport()
    var
        TextArray: array[12] of Text;
        TextValue: Text;
        i: Integer;
        Column: Integer;
    begin
        ServerTempFile := FileMgt.UploadFileSilent(Filename);

        TxtFile.TextMode := true;
        TxtFile.Open(ServerTempFile);
        if PostDate = 0D then
            Error(Text15000000);
        if Filename = '' then
            Error(Text15000001);

        Commit;
        PayrollTools.CheckJournal(NextLine, DefGenJnlLine);
        NextLine := 10000;

        while TxtFile.Len <> TxtFile.Pos do begin
            TxtFile.Read(FileData);
            //AZ10001+
            /*
            ImportAccountNo := DELCHR(COPYSTR(FileData,1,7),'<','0');
            ImportGlDimCode1 := DELCHR(COPYSTR(FileData,8,7),'<','0');
            ImportGlDimCode2 := DELCHR(COPYSTR(FileData,15,8),'<','0');
            EVALUATE(ImportNumber,COPYSTR(FileData,60,10));
            ImportSign := COPYSTR(FileData,80,1);
            EVALUATE(ImportAmount,COPYSTR(FileData,81,9));
            IF ImportSign = '-' THEN
              ImportAmount := -ImportAmount / 100
            ELSE
              ImportAmount := ImportAmount / 100;
            */

            i := 0;
            Column := 0;
            repeat
                i += 1;
                if FileData[i] = ';' then begin
                    Column += 1;
                    TextValue := DelChr(TextValue, '<', ' ');
                    TextValue := DelChr(TextValue, '<', '0');
                    TextArray[Column] := TextValue;
                    TextValue := '';
                end else
                    TextValue += Format(FileData[i]);
            until i = StrLen(FileData);
            TextArray[12] := TextValue;
            TextValue := '';

            ImportAccountNo := TextArray[1];
            ImportGlDimCode1 := TextArray[2];
            ImportGlDimCode2 := TextArray[3];

            ImportSign := CopyStr(TextArray[12], 1, 1);
            Evaluate(ImportAmount, DelChr(TextArray[12], '=', '-'));
            if ImportSign = '-' then
                ImportAmount := -ImportAmount / 100
            else
                ImportAmount := ImportAmount / 100;
            //AZ10001-
            InsertJournalLine;
        end;

    end;

    var
        PayrollSetup: Record "Payroll Integration Setup";
        GenJnlLine: Record "Gen. Journal Line";
        DefGenJnlLine: Record "Gen. Journal Line";
        PrevGenJnlLine: Record "Gen. Journal Line";
        PayrollTools: Codeunit Codeunit15000200;
        FileMgt: Codeunit "File Management";
        TxtFile: File;
        DocumentText: Text[50];
        Filename: Text[250];
        FileData: Text[250];
        ServerTempFile: Text[1024];
        file1: Text[250];
        file2: Text[250];
        NextLine: Integer;
        ImportNumber: Integer;
        ImportAccountNo: Code[20];
        ImportGlDimCode1: Code[10];
        ImportGlDimCode2: Code[10];
        ImportSign: Code[1];
        ImportAmount: Decimal;
        Text15000000: Label 'Please specify Posting Date.';
        Text15000001: Label 'Please specify File Name.';
        Text15000002: Label 'Payroll';
        Text15000003: Label 'Import from Payroll File.';
        Text15000004: Label 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*';
        PostDate: Date;


    procedure Initialize(SetGenJnlLine: Record "Gen. Journal Line")
    begin
        DefGenJnlLine := SetGenJnlLine;
    end;

    local procedure InsertJournalLine()
    var
        BankAccount: Record "Bank Account";
        BankAccountPostingGroup: Record "Bank Account Posting Group";
    begin
        PrevGenJnlLine := GenJnlLine;
        Clear(GenJnlLine);
        GenJnlLine.Validate("Journal Template Name", DefGenJnlLine."Journal Template Name");
        GenJnlLine.Validate("Journal Batch Name", DefGenJnlLine."Journal Batch Name");
        GenJnlLine.SetUpNewLine(PrevGenJnlLine, 0, false);
        GenJnlLine.Validate("Line No.", NextLine);
        NextLine := NextLine + 10000;

        case PayrollSetup."Post to" of
            PayrollSetup."Post to"::"G/L Account":
                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"G/L Account");
            PayrollSetup."Post to"::"Bank Account":
                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"Bank Account");
        end;

        //AZ10001+
        BankAccountPostingGroup.SetRange("G/L Bank Account No.", ImportAccountNo);
        if BankAccountPostingGroup.FindFirst then begin
            BankAccount.SetRange("Bank Acc. Posting Group", BankAccountPostingGroup.Code);
            if BankAccount.FindFirst then begin
                GenJnlLine.Validate("Account Type", GenJnlLine."Account Type"::"Bank Account");
                ImportAccountNo := BankAccount."No.";
            end;
        end;
        //AZ10001-

        GenJnlLine.Validate("Posting Date", PostDate);
        GenJnlLine.Validate("Account No.", ImportAccountNo);
        GenJnlLine.Validate(Quantity, ImportNumber);
        GenJnlLine.Validate(Amount, ImportAmount);
        GenJnlLine.Validate(Description, DocumentText);
        if PayrollSetup."Import Department and Project" then begin
            GenJnlLine.Validate("Shortcut Dimension 1 Code", ImportGlDimCode1);
            GenJnlLine.Validate("Shortcut Dimension 2 Code", ImportGlDimCode2);
        end;
        GenJnlLine.Insert;
    end;


    procedure NewFilename()
    begin
        if FileMgt.ClientFileExists(Filename) then begin
            if (Filename[StrLen(Filename)] = '~') or
               (Filename[StrLen(Filename) - 1] = '~')
            then
                exit;

            file1 := CopyStr(Filename, 1, StrLen(Filename) - 1) + '~';
            file2 := CopyStr(Filename, 1, StrLen(Filename) - 2) + '~~';
            if FileMgt.ClientFileExists(file2) then
                FileMgt.DeleteClientFile(file2);
            if FileMgt.ClientFileExists(file1) then
                FileMgt.MoveFile(file1, file2);
            FileMgt.MoveFile(Filename, file1);
        end;
    end;
}

