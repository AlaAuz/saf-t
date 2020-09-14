table 50007 "Tables To Clean"
{

    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; "Table Name"; Text[50])
        {
        }
        field(3; "Table Caption"; Text[50])
        {
        }
        field(4; "Number of Records"; Integer)
        {
        }
        field(5; Delete; Boolean)
        {
        }
        field(6; "Delete 2"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('Internal')]
    procedure GetAllTables()
    var
        TableObject: Record "Object";
    begin
        TableObject.SetRange(Type, TableObject.Type::Table);
        if TableObject.FindSet then
            repeat
                Init;
                ID := TableObject.ID;
                "Table Name" := TableObject.Name;
                "Table Caption" := TableObject.Caption;
                Insert;
            until TableObject.Next = 0;
    end;

    [Scope('Internal')]
    procedure GetNumberOfRecords()
    var
        RecRef: RecordRef;
    begin
        if FindSet then
            repeat
                RecRef.Open(ID);
                "Number of Records" := RecRef.Count;
                Modify;
                RecRef.Close;
            until Next = 0;
    end;

    [Scope('Internal')]
    procedure MarkON()
    begin
        if FindSet then
            repeat
                Delete := true;
                Modify;
            until Next = 0;
    end;

    [Scope('Internal')]
    procedure MarkOff()
    begin
        if FindSet then
            repeat
                Delete := false;
                Modify;
            until Next = 0;
    end;

    [Scope('Internal')]
    procedure DeleteData()
    var
        RecRef: RecordRef;
    begin
        if Confirm('Dette vil slette absolutt alle data i de merkede tabellene. Fortsette?') then
            if Confirm('Helt sikker?') then begin
                SetRange(Delete, true);
                if FindSet then
                    repeat
                        RecRef.Open(ID);
                        RecRef.DeleteAll;
                        RecRef.Close;
                    until Next = 0;
            end;
    end;

    [Scope('Internal')]
    procedure DeleteData2()
    var
        RecRef: RecordRef;
    begin
        if Confirm('Dette vil slette absolutt alle data i de merkede tabellene. Fortsette?') then
            if Confirm('Helt sikker?') then begin
                SetRange("Delete 2", true);
                if FindSet then
                    repeat
                        RecRef.Open(ID);
                        RecRef.DeleteAll;
                        RecRef.Close;
                    until Next = 0;
            end;
    end;
}

