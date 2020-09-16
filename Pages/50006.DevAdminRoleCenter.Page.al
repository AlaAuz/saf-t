page 50006 "AUZ Dev. Admin. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1901851508; "Case Activities")
            {
                ApplicationArea = All;
            }
            part(Control1000000000; "My Case Lines")
            {
                ApplicationArea = All;
            }
            part(Control1000000018; "AUZ New Cases")
            {
                ApplicationArea = All;
            }
            part(Control1000000017; "Completed Cases")
            {
                ApplicationArea = All;
            }
            part(Control1000000011; "Case Line Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000014; "Sales Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000015; "Accumulated Sales Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000021; "External Files")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Sak - registrerte timer")
            {
                Caption = 'Case - Registered Hours';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Case - Registered Hours";
                ApplicationArea = All;
            }
            action(Saksliste)
            {
                Caption = 'Case List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Case List";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                RunObject = Page "Standard Solution List";
                ApplicationArea = All;
            }
            action(Saker)
            {
                Caption = 'Cases';
                RunObject = Page "Case List";
                ApplicationArea = All;
            }
            action("Saker - åpne")
            {
                Caption = 'Cases - Open';
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply"));
                ApplicationArea = All;
            }
            action("Saker - fullførte")
            {
                Caption = 'Cases - Completed';
                ApplicationArea = All;
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER (Completed | Postponed));
            }
            action("Saker - løpende")
            {
                Caption = 'Cases - Running';
                ApplicationArea = All;
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = CONST (Running));
            }
            action(Sakstimer)
            {
                Caption = 'Case Lines';
                ApplicationArea = All;
                RunObject = Page "Case Line List";
            }
            action(Kunder)
            {
                Caption = 'Customers';
                ApplicationArea = All;
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Kontakter)
            {
                Caption = 'Contacts';
                ApplicationArea = All;
                RunObject = Page "Contact List";
            }
        }
        area(sections)
        {
        }
        area(processing)
        {
            action("Min timeregistrering")
            {
                Caption = 'My Time Sheet';
                ApplicationArea = All;
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Line List";
            }
            action(Sakstimekladd)
            {
                Caption = 'Case Line Journal';
                ApplicationArea = All;
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Journal";
            }
        }
    }
}

