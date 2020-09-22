page 60006 "AUZ Case Note"
{
    Caption = 'Case Note';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(MyNotes; MyNotes)
            {
                ApplicationArea = All;
                MultiLine = true;
                ShowCaption = false;
            }
        }
    }

    procedure GetNote(var Note: Text)
    begin
        Note := MyNotes;
    end;

    var
        MyNotes: Text;
}