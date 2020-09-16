codeunit 50049 "Role Center Management"
{

    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        GLSetupRead: Boolean;


    procedure GetSalespersPurchCode(): Code[10]
    begin
        GetUserSetup;
        exit(UserSetup."Salespers./Purch. Code");
    end;


    procedure GetGlobalDimension1Code(): Code[20]
    var
        Salesperson: Record "Salesperson/Purchaser";
    begin
        GetUserSetup;
        if Salesperson.Get(UserSetup."Salespers./Purch. Code") then
            exit(Salesperson."Global Dimension 1 Code");
    end;

    local procedure GetUserSetup()
    begin
        if UserSetup."User ID" <> UserId then
            if not UserSetup.Get(UserId) then
                UserSetup.Init;
    end;


    procedure FindDimensionFilter(var DimensionCode: Code[20]; var DimensionFilter: Text)
    var
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        DimensionList: Page "Dimension List";
        DimensionValueList: Page "Dimension Value List";
    begin
        GetGLSetup;
        Dimension.FilterGroup(2);
        Dimension.SetFilter(Code, '%1|%2', GLSetup."Global Dimension 1 Code", GLSetup."Global Dimension 2 Code");
        Dimension.FilterGroup(0);
        DimensionList.SetTableView(Dimension);
        DimensionList.LookupMode(true);
        if DimensionList.RunModal = ACTION::LookupOK then begin
            DimensionList.GetRecord(Dimension);
            DimensionValue.FilterGroup(2);
            DimensionValue.SetRange("Dimension Code", Dimension.Code);
            DimensionValue.FilterGroup(0);
            DimensionValueList.SetTableView(DimensionValue);
            DimensionValueList.LookupMode(true);
            if DimensionValueList.RunModal = ACTION::LookupOK then begin
                DimensionCode := Dimension.Code;
                DimensionFilter := DimensionValueList.GetSelectionFilter;
            end;
        end;
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then begin
            GLSetup.Get;
            GLSetupRead := true;
        end;
    end;
}

