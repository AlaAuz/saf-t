page 50105 "AUZ Std. Solution Note"
{
    Caption = 'Object Text';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(Text; Text)
            {
                ApplicationArea = All;
                MultiLine = true;
                ShowCaption = false;
            }
        }
    }

    procedure GetText(): Text
    begin
        exit(Text);
    end;

    var
        Text: Text;
}