page 90005 "Case Note"
{
    Caption = 'Case Note';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(MyNotes; MyNotes)
            {
                MultiLine = true;
                ShowCaption = false;
            }
        }
    }

    actions
    {
    }

    var
        MyNotes: Text;

    [Scope('Internal')]
    procedure GetNote(var Note: Text)
    begin
        Note := MyNotes;
    end;
}

