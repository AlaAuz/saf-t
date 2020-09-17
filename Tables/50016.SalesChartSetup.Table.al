table 50016 "AUZ Sales Chart Setup"
{
    Caption = 'Sales Chart Setup';

    fields
    {
        field(1; "User ID"; Text[132])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(3; "Dimension Filter"; Text[250])
        {
            Caption = 'Dimension Filter';
            DataClassification = CustomerContent;
        }
        field(4; "Dimension Filter 2"; Text[250])
        {
            Caption = 'Dimension Filter 2';
            DataClassification = CustomerContent;
        }
        field(5; "Dimension Filter 3"; Text[250])
        {
            Caption = 'Dimension Filter 3';
            DataClassification = CustomerContent;
        }
        field(6; "Dimension Filter 4"; Text[250])
        {
            Caption = 'Dimension Filter 4';
            DataClassification = CustomerContent;
        }
        field(10; "Chart View"; Option)
        {
            Caption = 'Chart View';
            OptionCaption = 'Sales,Accumulated Sales';
            OptionMembers = Sales,"Accumulated Sales";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "User ID", "Chart View")
        {
            Clustered = true;
        }
    }

    procedure GetCurrentSelectionText(): Text[250]
    var
        Dimension: Record Dimension;
        DimensionTranslation: Record "Dimension Translation";
        Language: Codeunit Language;
        DimensionName: Text[30];
        DimensionFilter: Text[1024];
    begin
        if "Dimension Code" = '' then
            exit;

        if not DimensionTranslation.Get("Dimension Code", Language.GetLanguageID(Language.GetUserLanguageCode())) then begin
            if not Dimension.Get("Dimension Code") then
                DimensionName := "Dimension Code"
            else
                DimensionName := Dimension.Name;
        end else
            DimensionName := DimensionTranslation.Name;

        exit(StrSubstNo('%1: %2', DimensionName, GetDimensionFilter));
    end;

    procedure SetDimensionFilter(DimensionCode: Code[20]; DimensionFilter: Text)
    var
        MaxFilterLength: Integer;
        StringPos: Integer;
    begin
        MaxFilterLength := MaxStrLen("Dimension Filter") + MaxStrLen("Dimension Filter 2") + MaxStrLen("Dimension Filter 3") + MaxStrLen("Dimension Filter 4");
        if StrLen(DimensionFilter) > MaxFilterLength then
            Error(Text000, "Dimension Filter", MaxFilterLength);

        "Dimension Code" := DimensionCode;

        StringPos := 1;
        "Dimension Filter" := CopyStr(DimensionFilter, StringPos);
        StringPos += MaxStrLen("Dimension Filter");
        "Dimension Filter 2" := CopyStr(DimensionFilter, StringPos);
        StringPos += MaxStrLen("Dimension Filter 2");
        "Dimension Filter 3" := CopyStr(DimensionFilter, StringPos);
        StringPos += MaxStrLen("Dimension Filter 3");
        "Dimension Filter 4" := CopyStr(DimensionFilter, StringPos);

        Modify;
    end;

    procedure GetDimensionFilter(): Text
    begin
        exit("Dimension Filter" + "Dimension Filter 2" + "Dimension Filter 3" + "Dimension Filter 4");
    end;

    var
        Text000: Label '%1 cannot contain more in %2 characters.';
}