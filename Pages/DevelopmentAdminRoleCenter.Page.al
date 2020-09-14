page 50006 "Development Admin. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1901851508; "Case Activities")
            {
            }
            part(Control1000000000; "My Case Lines")
            {
            }
            part(Control1000000018; "New Cases")
            {
            }
            part(Control1000000017; "Completed Cases")
            {
            }
            part(Control1000000011; "Case Line Chart")
            {
            }
            part(Control1000000014; "Sales Chart")
            {
            }
            part(Control1000000015; "Accumulated Sales Chart")
            {
            }
            part(Control1000000021; "External Files")
            {
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
            }
            action(Saksliste)
            {
                Caption = 'Case List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Case List";
            }
        }
        area(embedding)
        {
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                RunObject = Page "Standard Solution List";
            }
            action(Saker)
            {
                Caption = 'Cases';
                RunObject = Page "Case List";
            }
            action("Saker - åpne")
            {
                Caption = 'Cases - Open';
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply"));
            }
            action("Saker - fullførte")
            {
                Caption = 'Cases - Completed';
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER (Completed | Postponed));
            }
            action("Saker - løpende")
            {
                Caption = 'Cases - Running';
                RunObject = Page "Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = CONST (Running));
            }
            action(Sakstimer)
            {
                Caption = 'Case Hours';
                RunObject = Page "Case Line List";
            }
            action(Kunder)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Kontakter)
            {
                Caption = 'Contacts';
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
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Line List";
            }
            action(Sakstimekladd)
            {
                Caption = 'Case Hour Journal';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Journal";
            }
        }
    }
}

