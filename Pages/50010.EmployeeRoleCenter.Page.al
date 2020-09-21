page 50010 "AUZ Employee Role Center"
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
            part(Control1000000010; "AUZ Bookkeeper Activities")
            {
                ApplicationArea = All;
            }
            part(Control1000000000; "AUZ My Case Lines")
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
            /*part(Control1000000020; "AUZ External Files")
            {
                ApplicationArea = All;
            } */
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = All;
            }
            part(Control1907692008; "My Customers")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Kun&de - ti på topp-liste")
            {
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ApplicationArea = All;
            }
            action("Sak - tegistrerte timer")
            {
                Caption = 'Case - Registered Hours';
                Image = "Report";
                RunObject = Report "AUZ Case - Registered Hours";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
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
                RunPageView = SORTING("No.")
                              WHERE(Status = FILTER("Not Started" | "In Progress" | "Waiting for Reply"));
                ApplicationArea = All;
            }
            action("Saker - fullførte")
            {
                Caption = 'Cases - Completed';
                RunObject = Page "AUZ Case List";
                RunPageView = SORTING("No.")
                              WHERE(Status = FILTER(Completed | Postponed));
                ApplicationArea = All;
            }
            action("Saker - løpende")
            {
                Caption = 'Cases - Running';
                RunObject = Page "AUZ Case List";
                RunPageView = SORTING("No.")
                              WHERE(Status = CONST(Running));
                ApplicationArea = All;
            }
            action(Kontakter)
            {
                Caption = 'Contacts';
                RunObject = Page "Contact List";
                ApplicationArea = All;
            }
            action(Kunder)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action(Ordrer)
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action(Salgsfakturaer)
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action(Salgskreditnotaer)
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ApplicationArea = All;
            }
            action(Varer)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action(Sakstimer)
            {
                Caption = 'Case Lines';
                RunObject = Page "AUZ Case Line List";
                ApplicationArea = All;
            }
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                RunObject = Page "AUZ Std. Solution List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Prosjekt)
            {
                Caption = 'Job';
                action(Prosjekter)
                {
                    Caption = 'Jobs';
                    RunObject = Page "Job List";
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            separator(Oppgaver)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action(Prosjektkladd)
            {
                Caption = 'Job Journal';
                Image = OpenJournal;
                RunObject = Page "Job Journal";
                ApplicationArea = All;
            }
            action("Min timeregistrering")
            {
                Caption = 'My Time Sheet';
                Image = Timesheet;
                RunObject = Page "AUZ Case Line List";
                ApplicationArea = All;
            }
            action("&Naviger")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
            action(Sakstimekladd)
            {
                Caption = 'Case Line Journal';
                Image = OpenJournal;
                RunObject = Page "AUZ Case Journal";
                ApplicationArea = All;
            }
        }
    }
}