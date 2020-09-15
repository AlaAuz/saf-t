codeunit 90100 "Standard Solution Management"
{

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'You do not have permission to make changes to standard solution %1.';


    procedure CheckChangePermissions(StandardSolution: Record "Standard Solution"; ChangeType: Option Insertion,Modification,Deletion)
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then;
        if UserSetup."Development Administrator" then
            exit;

        if ChangeType = ChangeType::Modification then
            if StandardSolution."Responsible Resource No." = UserSetup."Resource No." then
                exit;

        Error(Text000, StandardSolution."No.");
    end;
}

