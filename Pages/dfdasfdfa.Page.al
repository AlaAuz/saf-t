page 60060 dfdasfdfa
{
    PageType = List;
    SourceTable = "Job Task";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job No."; "Job No.")
                {
                }
                field("Job Task No."; "Job Task No.")
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

