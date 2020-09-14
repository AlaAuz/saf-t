codeunit 50100 "Control Add-in JSON"
{
    //  * signature ControlAddIn v1.0
    //  *
    //  * Copyright 2018 Geert Rozendom, Newminds
    //  *
    //  * General method for creating a control AddIn is from Vjeko. Thanks, Vjeko!:
    //  * http://vjeko.com/tags/control-add-in/
    //  *
    //  * Javascript lib for creating a nice signature is from Szymon Nowak
    //  * https://github.com/szimek/signature_pad
    //  *
    //  * http://newminds.nl/
    //  *
    //  * Want your own addIn? contact us at support@newminds.nl


    trigger OnRun()
    begin
    end;

    var
        JDict: DotNet Dictionary_Of_T_U;
        TextCodeunitNotInitializedForWriting: Label 'You have attempted to write to a JSON object before having initialized it. It''s not the brightest idea human kind has ever got.';
        JObject: DotNet JObject;
        TextCodeunitNotInitializedForReading: Label 'You have attempted to read from a JSON object before having initialized it. It''s not the brightest idea human kind has ever got.';
        TextPropertyDoesNotExist: Label 'Property "%1" does not exist in JSON object.\\%2.';
        JRoot: DotNet JObject;

    [Scope('Internal')]
    procedure CreateForWriting()
    begin
        ClearAll;
        JDict := JDict.Dictionary;
    end;

    local procedure MakeSureCodeunitIsInitializedForWriting()
    begin
        if IsNull(JDict) then
            Error(TextCodeunitNotInitializedForWriting);
    end;

    [Scope('Internal')]
    procedure Set("Key": Text; Data: Variant)
    var
        JSON: Codeunit "Control Add-in JSON";
        JDict2: DotNet Dictionary_Of_T_U;
    begin
        MakeSureCodeunitIsInitializedForWriting;
        MakeSureKeyIsAvailable(Key);
        if Data.IsCodeunit then begin
            JSON := Data;
            JSON.GetInnerObject(JDict2);
            JDict.Add(Key, JDict2);
            exit;
        end;
        JDict.Add(Key, Data);
    end;

    [Scope('Internal')]
    procedure GetInnerObject(var InnerObject: DotNet Dictionary_Of_T_U)
    begin
        InnerObject := JDict;
    end;

    local procedure MakeSureKeyIsAvailable("Key": Text)
    begin
        if JDict.ContainsKey(Key) then
            JDict.Remove(Key);
    end;

    [Scope('Internal')]
    procedure CreateForReading(JObjectIn: DotNet JObject)
    begin
        Clear(JDict);
        JObject := JObjectIn;
        JRoot := JObject;
    end;

    local procedure MakeSureCodeunitIsInitializedForReading()
    begin
        if IsNull(JObject) then
            Error(TextCodeunitNotInitializedForReading);
    end;

    local procedure ObjectToVariant("Object": DotNet Object; var Variant: Variant)
    begin
        Variant := Object;
    end;

    [Scope('Internal')]
    procedure GetJToken(var JToken: DotNet JToken; Property: Text; WithError: Boolean)
    begin
        MakeSureCodeunitIsInitializedForReading;
        JToken := JObject.Item(Property);
        if IsNull(JToken) and WithError then
            Error(TextPropertyDoesNotExist, Property, JObject.ToString);
    end;

    [Scope('Internal')]
    procedure GetObject(Property: Text; var "Object": DotNet Object; WithError: Boolean): Boolean
    var
        JToken: DotNet JToken;
    begin
        Clear(Object);
        GetJToken(JToken, Property, WithError);
        if IsNull(JToken) then
            exit(false);
        Object := JToken.ToObject(GetDotNetType(Object));
        exit(true);
    end;

    [Scope('Internal')]
    procedure GetString(Property: Text; WithError: Boolean): Text
    var
        JToken: DotNet JToken;
    begin
        GetJToken(JToken, Property, WithError);
        if not IsNull(JToken) then
            exit(JToken.ToString);
    end;

    [Scope('Internal')]
    procedure GetBoolean(Property: Text; WithError: Boolean) Bool: Boolean
    var
        String: Text;
    begin
        String := GetString(Property, WithError);
        case true of
            String = '1':
                exit(true);
            String in ['0', '']:
                exit(false);
            else
                Evaluate(Bool, String);
        end;
    end;

    [Scope('Internal')]
    procedure GetDecimal(Property: Text; WithError: Boolean) Dec: Decimal
    var
        DotNetDecimal: DotNet Decimal;
        Variant: Variant;
    begin
        GetObject(Property, DotNetDecimal, WithError);
        ObjectToVariant(DotNetDecimal, Variant);
        Dec := Variant;
    end;

    [Scope('Internal')]
    procedure GetInteger(Property: Text; WithError: Boolean) Int: Integer
    var
        DotNetInt32: DotNet Int32;
        Variant: Variant;
    begin
        GetObject(Property, DotNetInt32, WithError);
        ObjectToVariant(DotNetInt32, Variant);
        Int := Variant;
    end;

    [Scope('Internal')]
    procedure GetDate(Property: Text; WithError: Boolean) Date: Date
    var
        DotNetDateTime: DotNet DateTime;
    begin
        GetObject(Property, DotNetDateTime, WithError);
        Date := DT2Date(DotNetDateTime);
    end;

    [Scope('Internal')]
    procedure SetScope(Name: Text; WithError: Boolean): Boolean
    begin
        MakeSureCodeunitIsInitializedForReading;
        if Name in ['', '{}', '/'] then
            JObject := JRoot
        else
            GetJToken(JObject, Name, WithError);
        exit(not IsNull(JObject));
    end;

    [Scope('Internal')]
    procedure SetScopeRoot(WithError: Boolean): Boolean
    begin
        exit(SetScope('/', WithError));
    end;

    [Scope('Internal')]
    procedure Base64Text2File(pTxtData: Text; pTxtFileName: Text): Boolean
    var
        dnFile: DotNet File;
        dnConvert: DotNet Convert;
        lCduFileMgt: Codeunit "File Management";
        lTxtType: Text;
    begin
        if pTxtData = '' then
            exit(false);
        // Bevat pTxt eerst deze definitie: data:application/jpeg;base64;
        if StrPos(pTxtData, ',') > 0 then begin
            lTxtType := CopyStr(pTxtData, 1, StrPos(pTxtData, ',') - 1);
            pTxtData := CopyStr(pTxtData, StrLen(lTxtType) + 2);
        end;
        dnFile.WriteAllBytes(pTxtFileName, dnConvert.FromBase64String(pTxtData));
        exit(true);
    end;

    trigger JObject::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
    begin
    end;

    trigger JObject::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
    begin
    end;

    trigger JObject::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    begin
    end;

    trigger JObject::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    begin
    end;

    trigger JObject::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    begin
    end;

    trigger JRoot::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
    begin
    end;

    trigger JRoot::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
    begin
    end;

    trigger JRoot::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    begin
    end;

    trigger JRoot::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    begin
    end;

    trigger JRoot::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    begin
    end;
}

