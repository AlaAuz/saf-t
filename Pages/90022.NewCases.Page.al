page 90022 "AUZ New Cases"
{
    Caption = 'New Cases (Last 3 Days)';
    Editable = false;
    PageType = ListPart;
    SourceTable = "AUZ Case Header";
    SourceTableView = SORTING ("Registered Date") 
                      ORDER(Descending)
                      WHERE (Status = FILTER (<> Completed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Registered Date"; "Registered Date")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Resource Search Text"; "Resource Search Text")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Developer ID"; "Developer ID")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("No."; "No.")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Contact Company Name"; "Contact Company Name")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field(Description; Description)
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field(Control1000000006; Status)
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                    Visible = false;
                }
                field("Development Approval Status"; "Development Approval Status")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
                }
                field("Development Status"; "Development Status")
                {
                    Style = Unfavorable;
                    StyleExpr = IsUnfavorable;
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Case Card";
                RunPageLink = "No." = FIELD ("No.");
            }
            group(Status)
            {
                Caption = 'Status';
                Image = ChangeStatus;
                action(Standard)
                {
                    Caption = 'Default';

                    trigger OnAction()
                    begin
                        UpdateDevelopementApprovalStatus("Development Approval Status"::" ");
                    end;
                }
                action("Må gjennomgås")
                {
                    Caption = 'Must be reviewed';
                    Image = Error;

                    trigger OnAction()
                    begin
                        UpdateDevelopementApprovalStatus("Development Approval Status"::"Must be reviewed");
                    end;
                }
                action("Kan installeres")
                {
                    Caption = 'OK to Install';
                    Image = Completed;

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
        SetRange("Registered Date", CalcDate('<-3D>', WorkDate), WorkDate);
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
        IsUnfavorable := "Development Approval Status" in ["Development Approval Status"::" "];
    end;
}

