codeunit 50100 "AUZ Standard Solution Mgt."
{
    procedure CheckChangePermissions(StandardSolution: Record "AUZ Standard Solution"; ChangeType: Option Insertion,Modification,Deletion)
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then;
        if UserSetup."AUZ Development Administrator" then
            exit;

        if ChangeType = ChangeType::Modification then
            if StandardSolution."Responsible Resource No." = UserSetup."AUZ Resource No." then
                exit;

        Error(Text000, StandardSolution."No.");
    end;

    var
        Text000: Label 'You do not have permission to make changes to standard solution %1.';
}