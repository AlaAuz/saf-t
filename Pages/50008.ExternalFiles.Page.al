/*
page 50008 "AUZ External Files"
{
    Caption = 'Applications';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "AFM File Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; "File Name")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //ALA
                        //FileMgt.DownloadFileAndOpenFile("Entry No.");
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("File Extension"; "File Extension")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;

                trigger OnAction()
                var
                    ExternalFile: Record "AFM File Entry";
                begin
                    CurrPage.SetSelectionFilter(ExternalFile);
                    if ExternalFile.FindSet then
                        repeat
                        //ALA
                        //FileMgt.DownloadFileWithDialog(ExternalFile."Entry No.");
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
        StandardSolution: Record "AUZ Standard Solution";
        FileMgt: Codeunit "AFM File Management";
} */

