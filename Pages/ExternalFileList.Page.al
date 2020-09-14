page 70402 "External File List"
{
    Caption = 'Files';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "External File";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                }
                field("Record ID"; "Record ID")
                {
                    Editable = false;
                }
                field("File Name"; "File Name")
                {
                    Editable = false;
                }
                field("File Extension"; "File Extension")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                }
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
                        ExtFileMgt.UploadFileWithDialog("Record ID");
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
                        ExtFileMgt.DownloadAllFiles("Record ID");
                    end;
                }
                separator(Action1000000008)
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

    var
        ExtFileMgt: Codeunit "External File Management";

    local procedure DeleteRecords()
    var
        ExternalFile: Record "External File";
    begin
        CurrPage.SetSelectionFilter(ExternalFile);
        if ExternalFile.FindSet then
            repeat
                ExtFileMgt.DeleteFile(ExternalFile."Entry No.");
            until ExternalFile.Next = 0;
    end;
}

