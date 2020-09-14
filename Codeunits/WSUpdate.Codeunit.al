codeunit 60001 WSUpdate
{

    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure UpdateCaseDescription(CaseNo: Code[20]; CaseDescription: Text)
    var
        Cases: Record "Case Header";
    begin
        Cases.Get(CaseNo);
        Cases.SaveDescriptionSolution(CaseDescription);
        Cases.Modify;
    end;
}

