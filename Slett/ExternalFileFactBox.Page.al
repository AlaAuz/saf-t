page 70401 "External File FactBox"
{
    // *** Auzilium AS File Management ***

    Caption = 'Files';
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "External File";
    SourceTableView = SORTING("Record ID");

    layout
    {
        area(content)
        {
            repeater(Control1000000002)
            {
                ShowCaption = false;
                field("File Name"; "File Name")
                {

                    trigger OnAssistEdit()
                    begin
                        OnBeforeAction;
                        ExtFileMgt.DownloadFileAndOpenFile("Entry No.");
                    end;
                }
                field("File Extension"; "File Extension")
                {
                }
                field("Uploaded by User"; "Uploaded by User")
                {
                    Visible = false;
                }
                field("Uploaded Date"; "Uploaded Date")
                {
                    Visible = false;
                }
            }
            field(StatusText; StatusText)
            {
                Editable = false;
                RowSpan = 2;
                ShowCaption = false;
                Style = Attention;
                StyleExpr = TRUE;
            }
            usercontrol(DragAndDrop; "Auzilium.DragAndDrop")
            {

                trigger ControlAddInReady()
                begin
                    ControlAddInReady := true;
                    SetText;
                end;

                trigger TransferReady()
                begin
                end;

                trigger OnDragAndDrop(data: Variant)
                begin
                    OnBeforeAction;
                    if ControlAddInReady then begin
                        ExtFileMgt.UploadFile(data, RecID);
                        UpdatePage;
                    end;
                end;

                trigger TransferCompleted()
                begin
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Action")
            {
                Caption = 'Actions';
                Image = "Action";
                action(Upload)
                {
                    Caption = 'Add';
                    Ellipsis = true;
                    Image = Add;

                    trigger OnAction()
                    begin
                        OnBeforeAction;
                        ExtFileMgt.UploadFileWithDialog(RecID);
                        UpdatePage;
                    end;
                }
                action(Download)
                {
                    Caption = 'Save';
                    Ellipsis = true;
                    Image = Save;

                    trigger OnAction()
                    var
                        ExternalFile: Record "External File";
                    begin
                        OnBeforeAction;
                        CurrPage.SetSelectionFilter(ExternalFile);
                        if ExternalFile.FindSet then
                            repeat
                                ExtFileMgt.DownloadFileWithDialog(ExternalFile."Entry No.");
                            until ExternalFile.Next = 0;
                    end;
                }
                action("Download All")
                {
                    Caption = 'Save All';
                    Ellipsis = true;
                    Image = Save;

                    trigger OnAction()
                    begin
                        OnBeforeAction;
                        ExtFileMgt.DownloadAllFiles(RecID);
                    end;
                }
                separator(Action1000000009)
                {
                }
                action(Delete)
                {
                    Caption = 'Delete';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        DeleteRecords;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        ExtFileMgt.DeleteFile("Entry No.");
        exit(false);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        if not CheckRecID then
            exit(false);
        exit(Find(Which));
    end;

    trigger OnInit()
    begin
        IsWindowsClient := FileMgt.CanRunDotNetOnClient;
    end;

    trigger OnOpenPage()
    begin
        if not CheckRecID then
            StatusText := CheckText;
    end;

    var
        FileMgt: Codeunit "File Management";
        ExtFileMgt: Codeunit "External File Management";
        RecID: RecordID;
        Text001: Label 'Drag and drop files or e-mails here!';
        StatusText: Text;
        CheckText: Text;
        ControlAddInReady: Boolean;
        Text002: Label 'Refresh the page after the record is inserted.';
        Text003: Label 'Then try again.';
        Text004: Label 'Control add-in is missing.';
        RecIDIsSet: Boolean;
        Text005: Label 'Insert a line.';
        IsWindowsClient: Boolean;


    procedure SetRec(NewRec: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(NewRec);
        if not RecRef.Get(RecRef.RecordId) then
            exit;

        RecID := RecRef.RecordId;
        RecIDIsSet := true;
        SetRange("Record ID", RecID);
        SetText;
        UpdatePage;
    end;

    local procedure SetText()
    begin
        if HasRecID then
            StatusText := ''
        else
            StatusText := CheckText;

        if IsWindowsClient then
            if ControlAddInReady then begin
                if HasRecID then
                    CurrPage.DragAndDrop.LabelText := Text001
                else
                    CurrPage.DragAndDrop.LabelText := StatusText;
            end else
                StatusText := Text004;
    end;

    local procedure UpdatePage()
    begin
        CurrPage.Update(false);
    end;

    local procedure HasRecID(): Boolean
    begin
        exit(Format(RecID) <> '');
    end;

    local procedure OnBeforeAction()
    begin
        if not CheckRecID then
            Error(CheckText + ' ' + Text003);
    end;

    local procedure CheckRecID() OK: Boolean
    begin
        CheckText := Text002;

        if RecIDIsSet then
            OK := true
        else
            if CheckFilter then begin
                CheckText := Text005;
            end;

        SetText;
    end;

    local procedure CheckFilter() FilterIsSet: Boolean
    begin
        FilterGroup(4);
        FilterIsSet := GetFilters <> '';
        FilterGroup(0);
    end;

    local procedure DeleteRecords()
    var
        ExternalFile: Record "External File";
    begin
        OnBeforeAction;
        CurrPage.SetSelectionFilter(ExternalFile);
        if ExternalFile.FindSet then
            repeat
                ExtFileMgt.DeleteFile(ExternalFile."Entry No.");
            until ExternalFile.Next = 0;
        UpdatePage;
    end;
}

