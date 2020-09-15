codeunit 90001 "Case Tools"
{

    trigger OnRun()
    begin
    end;


    procedure FindJob(ContactNo: Code[20]): Code[10]
    var
        ContactPerson: Record Contact;
        ContactBusRelation: Record "Contact Business Relation";
        Customer: Record Customer;
        JobList: Page "Job List";
        Job: Record Job;
    begin
        ContactPerson.Get(ContactNo);

        ContactBusRelation.SetRange("Contact No.", ContactPerson."Company No.");
        ContactBusRelation.SetRange("Link to Table", ContactBusRelation."Link to Table"::Customer);

        if ContactBusRelation.FindFirst then begin
            Customer.Get(ContactBusRelation."No.");
            //IF (Customer."Bill-to Customer No." <> '') AND (Customer."Bill-to Customer No." <> Customer."No.") THEN BEGIN
            //Customer.GET(Customer."Bill-to Customer No.");
            //END;

            Job.SetRange("Bill-to Customer No.", Customer."No.");
            Job.SetRange(Blocked, Job.Blocked::" ");
            JobList.SetTableView(Job);
            JobList.LookupMode(true);
            if JobList.RunModal = ACTION::LookupOK then begin
                JobList.GetRecord(Job);
                exit(Job."No.");
            end;
        end;
    end;


    procedure EnterCaseHoursIntoTimeSheet(var Rec: Record "Time Sheet Header")
    begin
    end;
}

