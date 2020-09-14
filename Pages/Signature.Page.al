page 50100 Signature
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

    ApplicationArea = Basic, Suite, Assembly;
    Caption = 'Signature';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ShowFilter = false;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            usercontrol(AddIn; "Signature")
            {

                trigger ControlReady()
                begin
                    Start
                end;

                trigger ControlEvent(data: Variant)
                begin
                    ControlEvent(data);
                end;

                trigger Require(data: Variant)
                begin
                end;

                trigger CloseRequested()
                begin
                end;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Save)
            {
                Caption = 'Save';
                Image = Save;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    fSave;
                end;
            }
            action(Clear)
            {
                Caption = 'Delete';
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    fClear;
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if not gBooCanClose then
            fSave;
        exit(gBooCanClose);
    end;

    var
        TxImgSaved: Label 'Signature saved';
        TxUnknownEvent: Label 'Received unknown event from control:%1';
        gBooCanClose: Boolean;
        TxNoSigContinue: Label 'No signature provided. Close anyway?';
        TxProvideSig: Label 'Please provide a signature';

    local procedure Start()
    var
        JSON: Codeunit "Control Add-in JSON";
        "Object": DotNet Dictionary_Of_T_U;
    begin
        // Send "start" command to AddIn
        JSON.CreateForWriting;
        JSON.Set('method', 'start');
        JSON.GetInnerObject(Object);
        CurrPage.AddIn.MethodCall(Object);
    end;

    local procedure fSave()
    var
        JSON: Codeunit "Control Add-in JSON";
        "Object": DotNet Dictionary_Of_T_U;
    begin
        // Send "save" command to AddIn
        JSON.CreateForWriting;
        JSON.Set('method', 'save');
        JSON.GetInnerObject(Object);
        CurrPage.AddIn.MethodCall(Object);
    end;

    local procedure fClear()
    var
        JSON: Codeunit "Control Add-in JSON";
        "Object": DotNet Dictionary_Of_T_U;
    begin
        // Send "clear" command to AddIn
        JSON.CreateForWriting;
        JSON.Set('method', 'clear');
        JSON.GetInnerObject(Object);
        CurrPage.AddIn.MethodCall(Object);
    end;

    local procedure ControlEvent(Data: Variant)
    var
        JSON: Codeunit "Control Add-in JSON";
        lConstFilter: Label '*.%1|*.%1|All files (*.*)|*.*';
        lTxtEvent: Text;
        lTxtData: Text;
    begin
        // Events generated in the AddIn arrive here

        JSON.CreateForReading(Data);
        lTxtEvent := JSON.GetString('Event', false);
        lTxtData := JSON.GetString('Arguments', false);

        case lTxtEvent of
            'signature':
                begin
                    JSON.Base64Text2File(lTxtData, TemporaryPath + 'signature.png');
                    fProcessSavedSignature(TemporaryPath + 'signature.png');
                end;
            'error':
                begin
                    fProcessError(lTxtData);
                end;
            else
                Message(TxUnknownEvent, lTxtEvent);
        end;
    end;

    local procedure fProcessSavedSignature(pTxtFileName: Text)
    begin
        // MESSAGE(TxImgSaved);
        gBooCanClose := true;
        CurrPage.Close;
    end;

    local procedure fProcessError(pTxtError: Text)
    begin
        case pTxtError of
            'nosignature':
                begin
                    if not Confirm(TxNoSigContinue, true) then
                        gBooCanClose := false
                    else begin
                        gBooCanClose := true;
                        CurrPage.Close;
                    end;
                end
            else
                Error(pTxtError);
        end;
    end;
}

