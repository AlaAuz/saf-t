page 50002 "Employee Role Center"
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
            part(Control1000000010; "AZ Bookkeeper Activities")
            {
            }
            part(Control1000000000; "My Case Lines")
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
            part(Control1000000020; "External Files")
            {
            }
            systempart(Control1901377608; MyNotes)
            {
            }
            part(Control1907692008; "My Customers")
            {
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
            }
            action("Sak - tegistrerte timer")
            {
                Caption = 'Case - Registered Hours';
                Image = "Report";
                RunObject = Report "Case - Registered Hours";
            }
        }
        area(embedding)
        {
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
            action(Kontakter)
            {
                Caption = 'Contacts';
                RunObject = Page "Contact List";
            }
            action(Kunder)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Ordrer)
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Salgsfakturaer)
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }
            action(Salgskreditnotaer)
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
            }
            action(Varer)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Sakstimer)
            {
                Caption = 'Case Hours';
                RunObject = Page "Case Line List";
            }
            action("Standardløsninger")
            {
                Caption = 'Standard Solutions';
                RunObject = Page "Standard Solution List";
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
            }
            action("Min timeregistrering")
            {
                Caption = 'My Time Sheet';
                Image = Timesheet;
                RunObject = Page "Case Line List";
            }
            action("&Naviger")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
            }
            action(Sakstimekladd)
            {
                Caption = 'Case Hour Journal';
                Image = OpenJournal;
                RunObject = Page "Case Journal";
            }
        }
    }
}

