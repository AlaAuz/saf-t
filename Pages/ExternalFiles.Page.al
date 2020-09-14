page 50008 "External Files"
{
    Caption = 'Applications';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "External File";
    SourceTableView = SORTING ("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; "File Name")
                {

                    trigger OnAssistEdit()
                    begin
                        ExtFileMgt.DownloadFileAndOpenFile("Entry No.");
                    end;
                }
                field(Description; Description)
                {
                }
                field("File Extension"; "File Extension")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
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
        }
    }

    trigger OnOpenPage()
    begin
        if StandardSolution.Get('APP') then;
        FilterGroup(2);
        SetRange("Record ID", StandardSolution.RecordId);
        FilterGroup(0);
        if FindFirst then;
    end;

    var
        StandardSolution: Record "Standard Solution";
        ExtFileMgt: Codeunit "External File Management";
}

