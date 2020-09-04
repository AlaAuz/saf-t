tableextension 90039 tableextension90039 extends "CDC Template Field Upg."
{
    Caption = 'Template Field Upg.';
    fields
    {
        modify("Template No.")
        {
            Caption = 'Template No.';
        }
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = 'Header,Line';
        }
        modify("Code")
        {
            Caption = 'Code';
        }
        modify("Data Type")
        {
            Caption = 'Data Type';
            OptionCaption = 'Text,Number,Date,Boolean,,,,,Lookup';
        }
        modify("Field Name")
        {
            Caption = 'Field Name';
        }
        modify("G/L Account Field Code")
        {
            Caption = 'G/L Account Field Code';
        }
        modify("Transfer Amount to Document")
        {
            Caption = 'Transfer Amount to Document';
            OptionCaption = ' ,If lines are not recognised,Always';
        }
        modify("Subtract from Amount Field")
        {
            Caption = 'Subtract from Amount Field (on registration)';
        }
        modify("New G/L Account Field Code")
        {
            Caption = 'New G/L Account Field Code';
        }
        modify("New Transfer Amt. to Document")
        {
            Caption = 'New Transfer Amount to Document';
            OptionCaption = ' ,If lines are not recognised,Always';
        }
        modify("New Subtract from Amount Field")
        {
            TableRelation = "CDC Template Field".Code WHERE ("Template No." = FIELD ("Template No."),
                                                             Type = FIELD (Type),
                                                             "Data Type" = FILTER (Number));
            Caption = 'New Subtract from Amount Field (on registration)';
        }
    }

    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CDCTemplateUpg.Get(Rec."Template No.");
    CDCTemplateUpg.TestField(CDCTemplateUpg."New field config (manual)",false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CDCTemplateUpg.Get(Rec."Template No.");
    CDCTemplateUpg.TestField(CDCTemplateUpg."New field config (manual)",false);
    CDCTemplateUpg.TestField(CDCTemplateUpg.Upgraded,false);
    */
    //end;


    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1000000000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=It is not recommended to use space as a seperator in Date Validation Rules as they will be deleted before evaluation. Use a seperator line - or / instead.;NOR=Det frarådes og bruke mellemrom som seperator i dato-valideringsregler, da de vil bli slettet før validering. Bruk evt. en seperator som - eller / i stedet for.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : DAN=Det frarådes at anvende mellemrum som seperator i dato-valideringsregler, da de vil blive slettet før validering. Brug evt. en seperator som - eller / i stedet for.;DEU=Es ist nicht ratsam, Leerzeichen als Trennzeichen für Datumsvalidierungsregeln zu benutzen, da sie vor der Verarbeitung gelöscht werden. Benutzen Sie stattdessen einen Bindestrich - oder einen Schrägstrich /.;ENU=It is not recommended to use space as a seperator in Date Validation Rules as they will be deleted before evaluation. Use a seperator line - or / instead.;ESP=No es recomendable usar espacio como separador en reglas de validación de fechas, se eliminarán antes de la evaluación. Use un separador de línea - o / en su lugar.;FRA=Il n'est pas recommandé d'utiliser un espace comme séparateur dans les règles de validation sur date, car il seront supprimé avant évaluation. Utiliser une séparateur ligne - ou / au lieu.;NLD="Het is niet aan te bevelen om een spatie te gebruiken als scheidingsteken in Date Validation Rules want deze worden verwijderd. Gebruik een scheidingslijn - of / . ";NOR=Det frarådes og bruke mellemrom som seperator i dato-valideringsregler, da de vil bli slettet før validering. Bruk evt. en seperator som - eller / i stedet for.;SVE=Det rekommenderas inte att använda blanksteg som avdelare i datumvalideringsregler då dem raderas före validering. Använd en annan avdelare som - eller / istället.;DES=Es ist nicht ratsam, Leerzeichen als Trennzeichen für Datumsvalidierungsregeln zu benutzen, da sie vor der Verarbeitung gelöscht werden. Benutzen Sie stattdessen einen Bindestrich - oder einen Schrägstrich /.;FRB=Il n'est pas recommandé d'utiliser un espace comme séparateur dans les règles de validation sur date, car il seront supprimé avant évaluation. Utiliser une séparateur ligne - ou / au lieu.;NLB="Het is niet aan te bevelen om een spatie te gebruiken als scheidingsteken in Date Validation Rules want deze worden verwijderd. Gebruik een scheidingslijn - of / . ";DEA=Es ist nicht ratsam, Leerzeichen als Trennzeichen für Datumsvalidierungsregeln zu benutzen, da sie vor der Verarbeitung gelöscht werden. Benutzen Sie stattdessen einen Bindestrich - oder einen Schrägstrich /.;ENA=It is not recommended to use space as a seperator in Date Validation Rules as they will be deleted before evaluation. Use a seperator line - or / instead.;ENZ=It is not recommended to use space as a seperator in Date Validation Rules as they will be deleted before evaluation. Use a seperator line - or / instead.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 161024012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Do you also want to delete the field '%1'?;NOR=Vil du også slette feltet '%1'?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : DAN=Vil du også slette feltet '%1'.;DEU=Möchten Sie auch das Feld '%1' löschen?;ENU=Do you also want to delete the field '%1'?;ESP=¿Desea eliminar también el campo '%1'?;FRA=Est-ce que vous voulez supprimer le champ '%1'?;NLD=Wilt u ook veld '%1' verwijderen?;NOR=Vil du også slette feltet '%1'?;SVE=Vill du även radera fältet '%1'?;DES=Möchten Sie auch das Feld '%1' löschen?;FRB=Est-ce que vous voulez supprimer le champ '%1'?;NLB=Wilt u ook veld '%1' verwijderen?;DEA=Möchten Sie auch das Feld '%1' löschen?;ENA=Do you also want to delete the field '%1'?;ENZ=Do you also want to delete the field '%1'?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 161024013)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The field cannot be subtracted from itself;NOR=Feltet kan ikke trekke fra seg selv;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : DAN=Feltet kan ikke fratrækkes fra sig selv;DEU=Das Feld kann nicht aus sich selbst erzeugt werden.;ENU=The field cannot be subtracted from itself;ESP=El campo no puede ser sustraído de sí mismo.;FRA=Ce champ ne pourra pas être soustraite de lui-même.;NLD=Het veld kan niet zichzelf worden afgetrokken.;NOR=Feltet kan ikke trekke fra seg selv;SVE=Fältet kan inte subtraheras från sig själv;DES=Das Feld kann nicht aus sich selbst erzeugt werden.;FRB=Ce champ ne pourra pas être soustraite de lui-même.;NLB=Het veld kan niet zichzelf worden afgetrokken.;DEA=Das Feld kann nicht aus sich selbst erzeugt werden.;ENA=The field cannot be subtracted from itself;ENZ=The field cannot be subtracted from itself;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text004(Variable 1160040000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=The record is not within the filters of the %1.;NOR=Posten er ikke innenfor filterene på %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : DAN=Posten er ikke iden for filterne på %1.;DEU=Der Datensatz ist nicht in den Filtern von %1 enthalten.;ENU=The record is not within the filters of the %1.;ESP=El registro no está dentro de los filtros de %1.;FRA=L'enregistrement n'est pas dans le filtre de %1;NLD=Het record voldoet niet aan de filters van %1.;NOR=Posten er ikke innenfor filterene på %1.;SVE=Posten är inte inom filtren för %1.;DES=Der Datensatz ist nicht in den Filtern von %1 enthalten.;FRB=L'enregistrement n'est pas dans le filtre de %1;NLB=Het record voldoet niet aan de filters van %1.;DEA=Der Datensatz ist nicht in den Filtern von %1 enthalten.;ENA=The record is not within the filters of the %1.;ENZ=The record is not within the filters of the %1.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text005(Variable 1160040001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The %1 is not part of the primary key of the %2.;NOR=%1 er ikke en del av primærnøkkel på %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : DAN=%1 er ikke en del af primærnøglen på %2.;DEU=%1 ist kein Teil des Primärschlüssels von %2.;ENU=The %1 is not part of the primary key of the %2.;ESP=%1 no es parte de la clave primaria de %2.;FRA=Le %1 n'est pas partie de la clé primaire %2.;NLD=%1 is geen onderdeel van de primaire sleutel van %2.;NOR=%1 er ikke en del av primærnøkkel på %2.;SVE=%1 är inte en del av primärnyckeln för %2.;DES=%1 ist kein Teil des Primärschlüssels von %2.;FRB=Le %1 n'est pas partie de la clé primaire %2.;NLB=%1 is geen onderdeel van de primaire sleutel van %2.;DEA=%1 ist kein Teil des Primärschlüssels von %2.;ENA=The %1 is not part of the primary key of the %2.;ENZ=The %1 is not part of the primary key of the %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text006(Variable 1160040002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Field in %1;NOR=Felt i %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : DAN=Felt på %1;DEU=Feld in %1;ENU=Field in %1;ESP=Campo en %1;FRA=Champ en %1;NLD=Veld in %1;NOR=Felt i %1;SVE=Fält i %1;DES=Feld in %1;FRB=Champ en %1;NLB=Veld in %1;DEA=Feld in %1;ENA=Field in %1;ENZ=Field in %1;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 1160040011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=Destination Header Field;NOR=Mottaker Hodefelt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : DAN=Overfør til felt på hovedtabel;DEU=Feld Zielkopf;ENU=Destination Header Field;ESP=Campo cabecera destino;FRA=Champ en-tête de destination;NLD=Doelveld (kop);NOR=Mottaker Hodefelt;SVE=Huvud destinationsfält;DES=Feld Zielkopf;FRB=Champ en-tête de destination;NLB=Doelveld (kop);DEA=Feld Zielkopf;ENA=Destination Header Field;ENZ=Destination Header Field;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text008(Variable 1160040010)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Destination Line Field;NOR=Mottaker Linjefelt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : DAN=Overfør til felt på linjetabel;DEU=Feld Zielzeile;ENU=Destination Line Field;ESP=Campo línea destino;FRA=Champ ligne de destination;NLD=Doelveld (regel);NOR=Mottaker Linjefelt;SVE=Rad destinationsfält;DES=Feld Zielzeile;FRB=Champ ligne de destination;NLB=Doelveld (regel);DEA=Feld Zielzeile;ENA=Destination Line Field;ENZ=Destination Line Field;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "EnableRuleActivateErr(Variable 6085573)".

    //var
    //>>>> ORIGINAL VALUE:
    //EnableRuleActivateErr : ENU=%1 can only be activated for Date Type %2 or %3.;NOR=%1 kan bare aktiveres for dato type %2 eller %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //EnableRuleActivateErr : DAN=%1 kan kun aktiveres for Datatype %2 eller %3.;DEU=%1 kann nur für Datumstyp %2 oder %3 aktiviert werden.;ENU=%1 can only be activated for Date Type %2 or %3.;ESP=%1 solo se puede activar para el tipo fecha %2 o %3.;FRA=%1 ne peut être activé uniquement pour type de date %2 ou %3.;NLD=%1 kan alleen worden geactiveerd voor datumtype %2 of %3.;NOR=%1 kan bare aktiveres for dato type %2 eller %3.;SVE=%1 kan bara aktiveras för datumtyp %2 eller %3.;DES=%1 kann nur für Datumstyp %2 oder %3 aktiviert werden.;FRB=%1 ne peut être activé uniquement pour type de date %2 ou %3.;NLB=%1 kan alleen worden geactiveerd voor datumtype %2 of %3.;DEA=%1 kann nur für Datumstyp %2 oder %3 aktiviert werden.;ENA=%1 can only be activated for Date Type %2 or %3.;ENZ=%1 can only be activated for Date Type %2 or %3.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "AlwaysOneDecimal(Variable 6085574)".

    //var
    //>>>> ORIGINAL VALUE:
    //AlwaysOneDecimal : ENU=Always 1 decimal;NOR=Alltid 1 desimal;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AlwaysOneDecimal : DAN=Altid 1 decimal;ENU=Always 1 decimal;ESP=Siempre 1 decimal;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "AlwaysNoDecimals(Variable 6085575)".

    //var
    //>>>> ORIGINAL VALUE:
    //AlwaysNoDecimals : ENU=Always %1 decimals;NOR=Alltid %1 desimaler;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AlwaysNoDecimals : DAN=Altid %1 decimaler;ENU=Always %1 decimals;ESP=Siempre %1 decimales;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "RangeOfDecimals(Variable 6085576)".

    //var
    //>>>> ORIGINAL VALUE:
    //RangeOfDecimals : ENU=%1-%2 decimals;NOR=%1-%2 desimaler;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RangeOfDecimals : DAN=%1-%2 decimaler;ENU=%1-%2 decimals;ESP=%1-%2 decimales;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "WrongExpressionFormat(Variable 6085577)".

    //var
    //>>>> ORIGINAL VALUE:
    //WrongExpressionFormat : ENU=Enter one number or two numbers separated by a colon. The first number must be less or equal to the second number. Numbers must be between 0 and 9.;NOR=Tast inn ett eller to tall atskilt med en kolonne. Det første tallet må være mindre eller lik det andre tallet. Tallene må være mellom 0 og 9.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //WrongExpressionFormat : DAN=Indtast et tal eller to tal adskilt af et kolon. Det første tal skal være mindre eller lig med det andet tal. Tallene skal være mellem 0 og 9.;ENU=Enter one number or two numbers separated by a colon. The first number must be less or equal to the second number. Numbers must be between 0 and 9.;ESP=Introduzca un número o dos números separados por 2 puntos. El primer número debe ser menor o igual al segundo número. Los números deben ser entre 0 y 9.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "UnableToParseDecimalExpression(Variable 6085578)".

    //var
    //>>>> ORIGINAL VALUE:
    //UnableToParseDecimalExpression : ENU=Unable to translate typed expression.;NOR=Kan ikke oversette uttrykket.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UnableToParseDecimalExpression : DAN=Det indtastede udtryk kan ikke oversætte.;ENU=Unable to translate typed expression.;ESP=No es posible traducir la expresión introducida.;
    //Variable type has not been exported.
}

