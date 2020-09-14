page 90105 "Standard Solution Note"
{
    Caption = 'Object Text';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(Text; Text)
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
        Text: Text;

    [Scope('Internal')]
    procedure GetText(): Text
    begin
        exit(Text);
    end;
}

