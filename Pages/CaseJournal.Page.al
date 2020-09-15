page 90020 "Case Journal"
{
    AutoSplitKey = true;
    Caption = 'Case Journal';
    DelayedInsert = true;
    PageType = Worksheet;
    RefreshOnActivate = true;
    SaveValues = true;
    ShowFilter = false;
    SourceTable = "Case Journal Line";

    layout
    {
        area(content)
        {
            field(ResourceNo; ResourceNo)
            {
                Caption = 'Resource No.';
                TableRelation = Resource;
            }
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("Case No."; "Case No.")
                {
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CalcFields("Case Description", "Case Company No.", "Case Company Name");
                    end;
                }
                field("Case Description"; "Case Description")
                {
                }
                field("Case Company No."; "Case Company No.")
                {
                }
                field("Case Company Name"; "Case Company Name")
                {
                }
                field(Description; Description)
                {
                }
                field("No. of Descriptions"; "No. of Descriptions")
                {
                }
                field("Add Descriptions to Solution"; "Add Descriptions to Solution")
                {
                }
                field(WorkDescription; WorkDescription)
                {
                    Caption = 'Work Description';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        SetWorkDescription(WorkDescription);
                    end;
                }
                field(Date; Date)
                {
                }
                field("Work Type"; "Work Type")
                {
                }
                field(Quantity; Quantity)
                {

                    trigger OnValidate()
                    begin
                        CalcTotalQty;
                    end;
                }
                field(Chargeable; Chargeable)
                {
                }
                field("Reference No."; "Reference No.")
                {
                }
            }
            group(Control1000000012)
            {
                ShowCaption = false;
                field(TotalQuantity; TotalQuantity)
                {
                    Caption = 'Total Quantity';
                    Editable = false;
                }
            }
            group("Webtjeneste - tilgang")
            {
                Caption = 'Web Service Access';
                field(USERID; UserId)
                {
                    Caption = 'User';
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TimeTrackerTools: Codeunit "Case Journal Management";
                begin
                    InsertCaseHours(ResourceNo);
                end;
            }
            action("Import Hours")
            {
                Caption = 'Import Hours';
                Ellipsis = true;
                Image = Import;
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Case Card";
                RunPageLink = "No." = FIELD ("Case No.");
            }
            action(Beskrivelser)
            {
                Caption = 'Descriptions';
                Image = Text;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Case Journal Descriptions";
                RunPageLink = "Resource No." = FIELD ("Resource No."),
                              "Journal Line No." = FIELD ("Line No.");
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
                ResourceNo := UserSetup."Resource No.";
    end;

    local procedure GetWebServiceID()
    var
        User: Record User;
        IdentityManagement: Codeunit "Identity Management";
    begin
        User.SetRange("User Name", UserId);
        User.FindFirst;
        //ALA WebServiceID := IdentityManagement.GetWebServicesKey(User."User Security ID");
    end;

    local procedure CalcTotalQty()
    var
        CaseHourJnlLine: Record "Case Journal Line";
    begin
        CaseHourJnlLine.Copy(Rec);
        CaseHourJnlLine.SetFilter("Line No.", '<>%1', "Line No.");
        CaseHourJnlLine.CalcSums(Quantity);
        TotalQuantity := CaseHourJnlLine.Quantity + Quantity;
    end;
}

