codeunit 50013 WSUpdate
{
    procedure UpdateCaseDescription(CaseNo: Code[20]; CaseDescription: Text)
    var
        Cases: Record "AUZ Case Header";
    begin
        Cases.Get(CaseNo);
        Cases.SaveDescriptionSolution(CaseDescription);
        Cases.Modify;
    end;
}