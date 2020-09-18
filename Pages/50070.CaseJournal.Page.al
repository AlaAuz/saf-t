page 50070 "AUZ Case Journal"
{
    AutoSplitKey = true;
    Caption = 'Case Journal';
    DelayedInsert = true;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = "AUZ Case Journal Line";

    layout
    {
        area(content)
        {
            field(ResourceNo; ResourceNo)
            {
                Caption = 'Resource No.';
                TableRelation = Resource;
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Case No."; "Case No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalcFields("Case Description", "Case Company No.", "Case Company Name");
                    end;
                }
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = All;
                }
                field("Case Company No."; "Case Company No.")
                {
                    ApplicationArea = All;
                }
                field("Case Company Name"; "Case Company Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("No. of Descriptions"; "No. of Descriptions")
                {
                    ApplicationArea = All;
                }
                field("Add Descriptions to Solution"; "Add Descriptions to Solution")
                {
                    ApplicationArea = All;
                }
                field(WorkDescription; WorkDescription)
                {
                    Caption = 'Work Description';
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SetWorkDescription(WorkDescription);
                    end;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Work Type"; "Work Type")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalcTotalQty;
                    end;
                }
                field(Chargeable; Chargeable)
                {
                    ApplicationArea = All;
                }
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1000000012)
            {
                ShowCaption = false;
                field(TotalQuantity; TotalQuantity)
                {
                    Caption = 'Total Quantity';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Webtjeneste - tilgang")
            {
                Caption = 'Web Service Access';
                field(USERID; UserId)
                {
                    Caption = 'User';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(WebServiceID; WebServiceID)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Key';
                    Editable = false;
                    ToolTip = 'Specifies a generated key that Dynamics NAV web service applications can use to authenticate to Dynamics NAV services. Choose the AssistEdit button to generate a key.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Insert Hours")
            {
                Caption = 'Insert Hours';
                Ellipsis = true;
                Image = TransferToLines;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TimeTrackerTools: Codeunit "AUZ Case Journal Management";
                begin
                    InsertCaseHours(ResourceNo);
                end;
            }
            action("Import Hours")
            {
                Caption = 'Import Hours';
                Ellipsis = true;
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImportCaseHours;
                end;
            }
        }
        area(navigation)
        {
            action(Sak)
            {
                Caption = 'Case';
                Image = Timesheet;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "AUZ Case Card";
                RunPageLink = "No." = FIELD("Case No.");
            }
            action(Beskrivelser)
            {
                Caption = 'Descriptions';
                Image = Text;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "AUZ Case Journal Descriptions";
                RunPageLink = "Resource No." = FIELD("Resource No."),
                              "Journal Line No." = FIELD("Line No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalcTotalQty;
    end;

    trigger OnAfterGetRecord()
    begin
        WorkDescription := GetWorkDescription;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewLine(xRec);
        WorkDescription := '';
    end;

    trigger OnOpenPage()
    begin
        GetWebServiceID;
        GetRecFilters;
        GetResourceNo;
        SetRecFilters;
        CalcTotalQty;
    end;

    var
        UserSetup: Record "User Setup";
        TotalQuantity: Decimal;
        ResourceNo: Code[20];
        WorkDescription: Text;
        WebServiceID: Text;

    local procedure GetRecFilters()
    begin
        FilterGroup(2);
        if GetFilters <> '' then
            ResourceNo := GetFilter("Resource No.");
        FilterGroup(0);
    end;

    local procedure SetRecFilters()
    begin
        FilterGroup(2);
        SetRange("Resource No.", ResourceNo);
        FilterGroup(0);
    end;

    local procedure GetResourceNo()
    begin
        if ResourceNo = '' then
            if UserSetup.Get(UserId) then
                ResourceNo := UserSetup."AUZ Resource No.";
    end;

    local procedure GetWebServiceID()
    var
        User: Record User;
        IdentityManagement: Codeunit "Identity Management";
    begin
        //ALA
        //FIX
        /*
        User.SetRange("User Name", UserId);
        User.FindFirst;
        WebServiceID := IdentityManagement.GetWebServicesKey(User."User Security ID");
        */
    end;

    local procedure CalcTotalQty()
    var
        CaseHourJnlLine: Record "AUZ Case Journal Line";
    begin
        CaseHourJnlLine.Copy(Rec);
        CaseHourJnlLine.SetFilter("Line No.", '<>%1', "Line No.");
        CaseHourJnlLine.CalcSums(Quantity);
        TotalQuantity := CaseHourJnlLine.Quantity + Quantity;
    end;
}