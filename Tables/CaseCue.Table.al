table 90008 "Case Cue"
{
    Caption = 'Case Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; Open; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply" | "See Comment")));
            Caption = 'Open';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(3; Running; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = CONST (Running)));
            Caption = 'Running';
            FieldClass = FlowField;
        }
        field(4; Due; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = FIELD ("Status Filter"),
                                                     "Promised Shipment Date" = FIELD ("Due Date Filter")));
            Caption = 'Due';
            FieldClass = FlowField;
        }
        field(5; Postponed; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = CONST (Postponed)));
            Caption = 'Postponed';
            FieldClass = FlowField;
        }
        field(6; "Not Started"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = CONST ("Not Started")));
            Caption = 'Not Started';
            FieldClass = FlowField;
        }
        field(7; "In Progress"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = CONST ("In Progress")));
            Caption = 'In Progress';
            FieldClass = FlowField;
        }
        field(8; "Waiting for Reply"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Resource Search Text" = FIELD ("Resource Filter"),
                                                     Status = CONST ("Waiting for Reply")));
            Caption = 'Waiting for Reply';
            FieldClass = FlowField;
        }
        field(9; "Promised Delivery"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Promised Shipment Date" = FIELD ("Promised Delivery Date Filter"),
                                                     Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply"),
                                                     "Consultant ID" = FIELD ("Consultant Filter"),
                                                     "Developer ID" = FIELD ("Developer Filter")));
            Caption = 'Promised Delivery';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(10; "High Priority"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE (Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply"),
                                                     Priority = CONST (High),
                                                     "Consultant ID" = FIELD ("Consultant Filter"),
                                                     "Developer ID" = FIELD ("Developer Filter")));
            Caption = 'High Priority';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(11; "Registered by Me"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Registered By" = FIELD ("Resource Filter"),
                                                     Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply" | "See Comment")));
            Caption = 'Registered by Me';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(12; "Waiting for Me"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE (Status = CONST ("Waiting for Reply"),
                                                     "Waiting for" = FIELD ("Waiting for Filter"),
                                                     "Consultant ID" = FIELD ("Consultant Filter"),
                                                     "Developer ID" = FIELD ("Developer Filter")));
            Caption = 'Waiting for Me';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(13; "Ready for Testing"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Development Status" = CONST ("Ready for Testing"),
                                                     Status = CONST ("Waiting for Reply"),
                                                     "Waiting for" = FIELD ("Waiting for Filter"),
                                                     "Consultant ID" = FIELD ("Consultant Filter"),
                                                     "Developer ID" = FIELD ("Developer Filter")));
            Caption = 'Ready for Test';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(14; "Ready for Installation"; Integer)
        {
            CalcFormula = Count ("Case Header" WHERE ("Development Status" = CONST ("Ready for Installation"),
                                                     Status = CONST ("Waiting for Reply"),
                                                     "Waiting for" = FIELD ("Waiting for Filter"),
                                                     "Consultant ID" = FIELD ("Consultant Filter"),
                                                     "Developer ID" = FIELD ("Developer Filter")));
            Caption = 'Ready for Installation';
            Description = 'Open';
            FieldClass = FlowField;
        }
        field(100; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
        }
        field(101; "Status Filter"; Option)
        {
            Caption = 'Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting for Reply,Postponed,See Comment,,Running';
            OptionMembers = "Not Started","In Progress",Completed,"Waiting for Reply",Postponed,"See Comment",,Running;
        }
        field(102; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            FieldClass = FlowFilter;
        }
        field(103; "Promised Delivery Date Filter"; Date)
        {
            Caption = 'Promised Delivery Date Filter';
            FieldClass = FlowFilter;
        }
        field(104; "Waiting for Filter"; Option)
        {
            Caption = 'Waiting for Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Customer,Consultant,Developer';
            OptionMembers = " ",Customer,Consultant,Developer;
        }
        field(105; "Consultant Filter"; Code[50])
        {
            Caption = 'Consultant Filter';
            FieldClass = FlowFilter;
            TableRelation = "User Setup" WHERE (Consultant = CONST (true));
        }
        field(106; "Developer Filter"; Code[50])
        {
            Caption = 'Developer Filter';
            FieldClass = FlowFilter;
            TableRelation = "User Setup" WHERE ("Development Administrator" = CONST (true));
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

