page 50006 "AUZ Dev. Admin. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1901851508; "AUZ Case Activities")
            {
                ApplicationArea = All;
            }
            part(Control1000000000; "AUZ My Case Lines")
            {
                ApplicationArea = All;
            }
            part(Control1000000018; "AUZ New Cases")
            {
                ApplicationArea = All;
            }
            part(Control1000000017; "AUZ Completed Cases")
            {
                ApplicationArea = All;
            }
            part(Control1000000011; "AUZ Case Line Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000014; "AUZ Sales Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000015; "AUZ Accumulated Sales Chart")
            {
                ApplicationArea = All;
            }
            part(Control1000000021; "AUZ External Files")
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
                RunObject = Report "AUZ Case - Registered Hours";
                ApplicationArea = All;
            }
            action(Saksliste)
            {
                Caption = 'Case List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "AUZCase List";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                RunObject = Page "AUZ Std. Solution List";
                ApplicationArea = All;
            }
            action(Saker)
            {
                Caption = 'Cases';
                RunObject = Page "AUZ Case List";
                ApplicationArea = All;
            }
            action("Saker - åpne")
            {
                Caption = 'Cases - Open';
                RunObject = Page "AUZ Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER ("Not Started" | "In Progress" | "Waiting for Reply"));
                ApplicationArea = All;
            }
            action("Saker - fullførte")
            {
                Caption = 'Cases - Completed';
                ApplicationArea = All;
                RunObject = Page "AUZ Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = FILTER (Completed | Postponed));
            }
            action("Saker - løpende")
            {
                Caption = 'Cases - Running';
                ApplicationArea = All;
                RunObject = Page "AUZ Case List";
                RunPageView = SORTING ("No.")
                              WHERE (Status = CONST (Running));
            }
            action(Sakstimer)
            {
                Caption = 'Case Lines';
                ApplicationArea = All;
                RunObject = Page "AUZ Case Line List";
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
                RunObject = Page "AUZ Case Line List";
            }
            action(Sakstimekladd)
            {
                Caption = 'Case Line Journal';
                ApplicationArea = All;
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "AUZ Case Journal";
            }
        }
    }
}