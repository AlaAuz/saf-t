page 50010 "Add-ins Page Test"
{

    layout
    {
        area(content)
        {
            //ALA usercontrol(TestAddIn; "DocumentExplorerControlAddin")
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        TestString := 'Test1,Test2';
    end;

    var
        TestString: Text;
}

