page 50073 "AUZ Completed Cases"
{
    Caption = 'Completed Cases (Last 3 Days)';
    Editable = false;
    PageType = ListPart;
    SourceTable = "AUZ Case Header";
    SourceTableView = SORTING("Completed Date")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Completed Date"; "Completed Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Resource Search Text"; "Resource Search Text")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Developer ID"; "Developer ID")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Contact Company Name"; "Contact Company Name")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field(Control1000000006; Status)
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                    Visible = false;
                }
                field("Development Approval Status"; "Development Approval Status")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Development Status"; "Development Status")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowCase)
            {
                Caption = 'Case';
                Image = Timesheet;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case Card";
                RunPageLink = "No." = FIELD("No.");
            }
            group(Status)
            {
                Caption = 'Status';
                Image = ChangeStatus;
                action(Standard)
                {
                    Caption = 'Default';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateDevelopementApprovalStatus("Development Approval Status"::" ");
                    end;
                }
                action("Må gjennomgås")
                {
                    Caption = 'Must be reviewed';
                    Image = Error;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateDevelopementApprovalStatus("Development Approval Status"::"Must be reviewed");
                    end;
                }
                action("Kan installeres")
                {
                    Caption = 'OK to Install';
                    Image = Completed;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateDevelopementApprovalStatus("Development Approval Status"::"OK to Install");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetUnfavorable;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUnfavorable;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        ResourceFilter: Text;
    begin
        UserSetup.SetRange("AUZ Developer", true);
        UserSetup.SetRange("AUZ Development Administrator", false);
        UserSetup.SetFilter("AUZ Resource No.", '<>%1', '');
        if UserSetup.FindSet then
            repeat
                if ResourceFilter <> '' then
                    ResourceFilter += '|';
                ResourceFilter += StrSubstNo('*%1*', UserSetup."AUZ Resource No.");
            until UserSetup.Next = 0;
        SetFilter("Resource Search Text", ResourceFilter);
        SetRange("Completed Date", CalcDate('<-3D>', WorkDate), WorkDate);
        if FindFirst then;
    end;

    var
        IsUnfavorable: Boolean;

    local procedure UpdateDevelopementApprovalStatus(NewStatus: Option)
    begin
        Validate("Development Approval Status", NewStatus);
        CurrPage.Update;
    end;

    local procedure SetUnfavorable()
    begin
        IsUnfavorable := "Development Approval Status" in ["Development Approval Status"::" ", "Development Approval Status"::"Must be reviewed"];
    end;
}

