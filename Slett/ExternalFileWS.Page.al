page 70403 "External File WS"
{
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
                }
                field("FORMAT(""Record ID"")"; Format("Record ID"))
                {
                    Caption = 'Record ID';
                }
                field("File Name"; "File Name")
                {
                }
                field("File Extension"; "File Extension")
                {
                }
            }
        }
    }

    actions
    {
    }
}

