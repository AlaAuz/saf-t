codeunit 50013 WSUpdate
{

    trigger OnRun()
    begin
    end;


    procedure UpdateCaseDescription(CaseNo: Code[20]; CaseDescription: Text)
    var
        Cases: Record "Case Header";
    begin
        Cases.Get(CaseNo);
        Cases.SaveDescriptionSolution(CaseDescription);
        Cases.Modify;
    end;
}

