tableextension 50050 "AUZ Template Upg." extends "CDC Template Upg."
{
    Caption = 'Template Upg.';
    fields
    {
        modify("No.")
        {
            Caption = 'No.';
        }
        modify("Category Code")
        {
            Caption = 'Category Code';
        }
        modify("Source Record ID Tree ID")
        {
            Caption = 'Source Record ID Tree ID';
        }
        modify(Default)
        {
            Caption = 'Default';
        }
        modify(Type)
        {
            Caption = 'Type';
            OptionCaption = ' ,Identification,Master';
        }
        modify("Recognize Lines")
        {
            Caption = 'Recognize Lines';
            OptionCaption = 'No,Yes';
        }
        modify(Description)
        {
            Caption = 'Description';
        }
        modify("Search Text")
        {
            Caption = 'Search Text';
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including VAT';
        }
        modify("Source Record Table ID")
        {
            Caption = 'Source Record Table ID';
        }
        modify("Source Record No.")
        {
            Caption = 'Source Record No.';
        }
        modify("Source Record Name")
        {
            Caption = 'Source Record Name';
        }
        modify("New field config (manual)")
        {
            Caption = 'New field config (manual)';
        }
        modify("New field config (auto)")
        {
            Caption = 'New field config (auto)';
        }
        modify(Ignore)
        {
            Caption = 'Ignore';
        }
        modify(Upgraded)
        {
            Caption = 'Upgraded';
        }
    }

    //ALA Oversettelser
    //Unsupported feature: Property Modification (TextConstString) on "Text001(Variable 1000000001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=This template cannot be deleted because it has been used on one or more registered or rejected documents.;NOR=Malen kan ikke slettes da den er brukt på en eller flere registrerte eller avviste dokumenter.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : DAN=Skabelonen kan ikke slettes da den er anvendt på et eller flere registrerede eller afviste dokument.;DEU=Diese Vorlage kann nicht gelöscht werden. Sie wurde in einem oder mehreren registrierten oder abgelehnten Belegen verwendet.;ENU=This template cannot be deleted because it has been used on one or more registered or rejected documents.;ESP=Esta plantilla no se puede eliminar porque está siendo utilizada por uno o más documentos registrados o rechazados.;FRA=Ce modèle ne peut pas être supprimé car il a été utilisé sur un ou plusieurs documents enregistrés ou rejetés.;NLD=Dit sjabloon kan niet worden verwijderd omdat deze wordt gebruikt op een of meer geregistreerde of geweigerde documenten.;NOR=Malen kan ikke slettes da den er brukt på en eller flere registrerte eller avviste dokumenter.;SVE=Mallen kan inte tas bort då den har använts på ett eller flera avvisade dokument.;DES=Diese Vorlage kann nicht gelöscht werden. Sie wurde in einem oder mehreren registrierten oder abgelehnten Belegen verwendet.;FRB=Ce modèle ne peut pas être supprimé car il a été utilisé sur un ou plusieurs documents enregistrés ou rejetés.;NLB=Dit sjabloon kan niet worden verwijderd omdat deze wordt gebruikt op een of meer geregistreerde of geweigerde documenten.;DEA=Diese Vorlage kann nicht gelöscht werden. Sie wurde in einem oder mehreren registrierten oder abgelehnten Belegen verwendet.;ENA=This template cannot be deleted because it has been used on one or more registered or rejected documents.;ENZ=This template cannot be deleted because it has been used on one or more registered or rejected documents.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text002(Variable 1000000002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=This template is used on %1 open documents.\\If you delete this template it will be removed from these documents and you must manually select another template.\\Do you want to continue?;NOR=Malen er benyttet på %1 åpent dokument.\\Hvis du sletter malen vil den bli fjernet fra disse dokumentene og det skal manuelt velges en annen mal.\\Vil du fortsette?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : DAN="Skabelonen er anvendt på %1 åbne dokument.\\Hvis du slette skabelonen vil den blive fjernet fra disse dokumenter og der skal manuelt vælges en anden skabelon.\\Vil du fortsætte? ";DEU=Diese Vorlagen wird in %1 offenen Belegen benutzt.\\Wenn Sie diese Vorlage löschen, wwird sie aus diesen Belegen entfernt und Sie müssen manuell neue Vorlagen zuordnen.\\Möchten Sie fortfahren?;ENU=This template is used on %1 open documents.\\If you delete this template it will be removed from these documents and you must manually select another template.\\Do you want to continue?;ESP=Esta plantilla está siendo usada en %1 documentos abiertos.\\Si la borra será eliminada de estos documentos y deberá seleccionar manualmente otra plantilla.\\¿Desea continuar?;FRA=Ce modèle est utilisé dans %1 documents ouverts.\\Si vous supprimez ce modèle, il sera retiré des documents et vous devez selectionnez un autre modèle manuellement.\\Voulez-vous continuer?;NLD=Dit sjabloon wordt gebruikt op %1 open documenten.\\Als u dit sjabloon verwijderd wordt deze van deze documenten gewist en moet u handmatig een ander sjabloon kiezen.\\Wilt u doorgaan?;NOR=Malen er benyttet på %1 åpent dokument.\\Hvis du sletter malen vil den bli fjernet fra disse dokumentene og det skal manuelt velges en annen mal.\\Vil du fortsette?;SVE=Mallen har använts på %1 öppna dokument.\\Om du tar bort mallen försvinner den från dokumenten och du behöver välja en ny mall manuellt.\\Vill du fortsätta?;DES=Diese Vorlagen wird in %1 offenen Belegen benutzt.\\Wenn Sie diese Vorlage löschen, wwird sie aus diesen Belegen entfernt und Sie müssen manuell neue Vorlagen zuordnen.\\Möchten Sie fortfahren?;FRB=Ce modèle est utilisé dans %1 documents ouverts.\\Si vous supprimez ce modèle, il sera retiré des documents et vous devez selectionnez un autre modèle manuellement.\\Voulez-vous continuer?;NLB=Dit sjabloon wordt gebruikt op %1 open documenten.\\Als u dit sjabloon verwijderd wordt deze van deze documenten gewist en moet u handmatig een ander sjabloon kiezen.\\Wilt u doorgaan?;DEA=Diese Vorlagen wird in %1 offenen Belegen benutzt.\\Wenn Sie diese Vorlage löschen, wwird sie aus diesen Belegen entfernt und Sie müssen manuell neue Vorlagen zuordnen.\\Möchten Sie fortfahren?;ENA=This template is used on %1 open documents.\\If you delete this template it will be removed from these documents and you must manually select another template.\\Do you want to continue?;ENZ=This template is used on %1 open documents.\\If you delete this template it will be removed from these documents and you must manually select another template.\\Do you want to continue?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1000000003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=&Create New;NOR=&Oprett ny;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : DAN=&Opret ny;DEU=&Neue erstellen;ENU=&Create New;ESP=Crear nuevo;FRA=&Créer nouveau;NLD=&Maak nieuwe;NOR=&Oprett ny;SVE=&Skapa ny;DES=&Neue erstellen;FRB=&Créer nouveau;NLB=&Maak nieuwe;DEA=&Neue erstellen;ENA=&Create New;ENZ=&Create New;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text004(Variable 1000000005)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Do you want to update %1 on all fields?;NOR=Vil du oppdatere %1 på alle felter?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : DAN=Vil du opdatere %1 på alle felter?;DEU=Möchten Sie in allen Feldern %1 aktualisieren?;ENU=Do you want to update %1 on all fields?;ESP=¿Desea actualizar %1 en todos los campos?;FRA=Voulez-vous mettre à jour %1 sur tous les champs?;NLD=Wilt u %1 bijwerken op alle velden?;NOR=Vil du oppdatere %1 på alle felter?;SVE=Vill du uppdatera %1 på alla fält?;DES=Möchten Sie in allen Feldern %1 aktualisieren?;FRB=Voulez-vous mettre à jour %1 sur tous les champs?;NLB=Wilt u %1 bijwerken op alle velden?;DEA=Möchten Sie in allen Feldern %1 aktualisieren?;ENA=Do you want to update %1 on all fields?;ENZ=Do you want to update %1 on all fields?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text005(Variable 1000000006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=WARNING\\Your are about to delete system template %1.\\Do you want to continue?;NOR=ADVARSEL\\Du sletter nå systemmal %1.\\Vil du fortsette?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : DAN=ADVARSEL\\Du er ved at slette systemskabelon %1.\\Vil du fortsætte?;DEU=ACHTUNG\\Sie sind im Begriff Systemvorlage %1 zu löschen.\\Möchten Sie fortfahren?;ENU=WARNING\\Your are about to delete system template %1.\\Do you want to continue?;ESP=ATENCIÓN\\Va a eliminar plantilla del sistema %1.\\¿Desea continuar?;FRA=ATTENTION\\Vous êtes sur le point d'éffacer modèle système %1.\\Voulez-vous continuer?;NLD=WAARSCHUWING\\U gaat systeemsjabloon verwijderen %1.\\Wilt u doorgaan?;NOR=ADVARSEL\\Du sletter nå systemmal %1.\\Vil du fortsette?;SVE=VARNING\\Du är på väg att ta bort systemmall %1.\\Vill du fortsätta?;DES=ACHTUNG\\Sie sind im Begriff Systemvorlage %1 zu löschen.\\Möchten Sie fortfahren?;FRB=ATTENTION\\Vous êtes sur le point d'éffacer modèle système %1.\\Voulez-vous continuer?;NLB=WAARSCHUWING\\U gaat systeemsjabloon verwijderen %1.\\Wilt u doorgaan?;DEA=ACHTUNG\\Sie sind im Begriff Systemvorlage %1 zu löschen.\\Möchten Sie fortfahren?;ENA=WARNING\\Your are about to delete system template %1.\\Do you want to continue?;ENZ=WARNING\\Your are about to delete system template %1.\\Do you want to continue?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text006(Variable 161024012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=N/A;NOR=N/A;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : DAN=N/A;DEU=N/A;ENU=N/A;ESP=N/A;FRA=N/A;NLD=N/A;NOR=N/A;SVE=N/A;DES=N/A;FRB=N/A;NLB=N/A;DEA=N/A;ENA=N/A;ENZ=N/A;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text007(Variable 161024013)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You must specify Source ID.;NOR=Du må angi Kildenr.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : DAN=Du skal angive Kilde-ID.;DEU=Sie müssen die Herkunfts-ID angeben.;ENU=You must specify Source ID.;ESP=Debe especificar Id. origen.;FRA=Vous devez spécifier Id Source;NLD=U moet Bron-id invullen.;NOR=Du må angi Kildenr.;SVE=Du måste ange ett Källnr.;DES=Sie müssen die Herkunfts-ID angeben.;FRB=Vous devez spécifier Id Source;NLB=U moet Bron-id invullen.;DEA=Sie müssen die Herkunfts-ID angeben.;ENA=You must specify Source ID.;ENZ=You must specify Source ID.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text008(Variable 1160040000)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Source ID;NOR=Kilde-ID;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : DAN=Kilde-id;DEU=Herkunfts-ID;ENU=Source ID;ESP=Id. origen;FRA=ID source;NLD=Bron-id;NOR=Kilde-ID;SVE=Källnr.;DES=Herkunfts-ID;FRB=ID source;NLB=Bron-id;DEA=Herkunfts-ID;ENA=Source ID;ENZ=Source ID;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "UpdateTemplateQst(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //UpdateTemplateQst : ENU="Do you want to update %1 on all templates created from %2 = %3 for the document category %4?";NOR="Vil du oppdatere %1 på alle maler som er opprettet fra %2 = %3 for dokumentet kategori %4?";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdateTemplateQst : DAN="Vil du opdatere %1 på alle skabeloner oprettet udfra %2 = %3 for dokumentkategori %4?";DEU=Möchten Sie für die Belegkategorie %4 %1 in allen Vorlagen von %2 auf %3 aktualisieren?;ENU="Do you want to update %1 on all templates created from %2 = %3 for the document category %4?";ESP="¿Desea actualizar %1 en todas las plantillas creadas desde %2 = %3 para la categoría de documento %4?";FRA="Mettre à jour %1 sur tout les modèles crée à partir de %2 = %3 pour catégorie de documents %4?";NLD="Wil je %1 updaten op alle sjablonen gemaakt van %2 = %3 voor de documentcategorie %4?";NOR="Vil du oppdatere %1 på alle maler som er opprettet fra %2 = %3 for dokumentet kategori %4?";SVE="Vill du uppdatera %1 på alla mallar som skapats från %2 = %3 för dokumentkategorin %4?";DES=Möchten Sie für die Belegkategorie %4 %1 in allen Vorlagen von %2 auf %3 aktualisieren?;FRB="Mettre à jour %1 sur tout les modèles crée à partir de %2 = %3 pour catégorie de documents %4?";NLB="Wil je %1 updaten op alle sjablonen gemaakt van %2 = %3 voor de documentcategorie %4?";DEA=Möchten Sie für die Belegkategorie %4 %1 in allen Vorlagen von %2 auf %3 aktualisieren?;ENA="Do you want to update %1 on all templates created from %2 = %3 for the document category %4?";ENZ="Do you want to update %1 on all templates created from %2 = %3 for the document category %4?";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text010(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=Updating templates\#1####################\@2@@@@@@@@@@@@@@@@@@@@;NOR=Oppdatere maler\#1####################\@2@@@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : DAN=Skabeloner opdateres\#1####################\@2@@@@@@@@@@@@@@@@@@@@;DEU=Aktualisiere Vorlagen\#1####################\@2@@@@@@@@@@@@@@@@@@@@;ENU=Updating templates\#1####################\@2@@@@@@@@@@@@@@@@@@@@;ESP=Actualización plantillas\#1####################\@2@@@@@@@@@@@@@@@@@@@@;FRA=Mettre à jour Modèles\#1####################\@2@@@@@@@@@@@@@@@@@@@@;NLD=Bijwerken sjablonen\#1####################\@2@@@@@@@@@@@@@@@@@@@@;NOR=Oppdatere maler\#1####################\@2@@@@@@@@@@@@@@@@@@@@;SVE=Mallar uppdateras\#1####################\@2@@@@@@@@@@@@@@@@@@@@;DES=Aktualisiere Vorlagen\#1####################\@2@@@@@@@@@@@@@@@@@@@@;FRB=Mettre à jour Modèles\#1####################\@2@@@@@@@@@@@@@@@@@@@@;NLB=Bijwerken sjablonen\#1####################\@2@@@@@@@@@@@@@@@@@@@@;DEA=Aktualisiere Vorlagen\#1####################\@2@@@@@@@@@@@@@@@@@@@@;ENA=Updating templates\#1####################\@2@@@@@@@@@@@@@@@@@@@@;ENZ=Updating templates\#1####################\@2@@@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text011(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=%1 of %2;NOR=%1 av %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : DAN=%1 af %2;DEU=%1 von %2;ENU=%1 of %2;ESP=%1 de %2;FRA=%1 de %2;NLD=%1 van %2;NOR=%1 av %2;SVE=%1 av %2;DES=%1 von %2;FRB=%1 de %2;NLB=%1 van %2;DEA=%1 von %2;ENA=%1 of %2;ENZ=%1 of %2;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=Templates updated: %1;NOR=Maler oppdatert: %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : DAN=%1 skabeloner blev opdateret;DEU=Vorlagen aktualisiert: %1;ENU=Templates updated: %1;ESP=Plantillas actualizadas: %1;FRA=Modèles Mis-à-jour: %1;NLD=Sjablonen bijgewerkt: %1;NOR=Maler oppdatert: %1;SVE=%1 mallar uppdaterades.;DES=Vorlagen aktualisiert: %1;FRB=Modèles Mis-à-jour: %1;NLB=Sjablonen bijgewerkt: %1;DEA=Vorlagen aktualisiert: %1;ENA=Templates updated: %1;ENZ=Templates updated: %1;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text013(Variable 1160040001)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=Do you want to set %1 to only check amounts including VAT and not amounts excluding VAT?;NOR=Vil du angi %1 til bare kontroller beløp med Mva. og ikke beløp uten Mva.?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : DAN=Vil du ændre %1 til kun at kontrollere beløb inkl. moms og ikke beløb ekskl. moms?;DEU=Möchten Sie in %1 aktivieren das nur der Bruttobetrag und nicht der Nettobetrag geprüft wird?;ENU=Do you want to set %1 to only check amounts including VAT and not amounts excluding VAT?;ESP=¿Desa establecer %1 a que sólo debe controlar montos incluyendo IVA y no montos excluyendo IVA?;FRA=Voulez-vous mettre %1 à contrôler seulement montants inclus TVA et non les montants HTVA?;NLD=Wilt u de %1 zo instellen dat alleen bedragen inclusief btw en niet bedragen exclusief btw gecontroleerd worden?;NOR=Vil du angi %1 til bare kontroller beløp med Mva. og ikke beløp uten Mva.?;SVE=Vill du ändra %1 till att endast kontrollera belopp inkl. moms och ej belopp exkl. moms?;DES=Möchten Sie in %1 aktivieren das nur der Bruttobetrag und nicht der Nettobetrag geprüft wird?;FRB=Voulez-vous mettre %1 à contrôler seulement montants inclus TVA et non les montants HTVA?;NLB=Wilt u de %1 zo instellen dat alleen bedragen inclusief btw en niet bedragen exclusief btw gecontroleerd worden?;DEA=Möchten Sie in %1 aktivieren das nur der Bruttobetrag und nicht der Nettobetrag geprüft wird?;ENA=Do you want to set %1 to only check amounts including GST and not amounts excluding VAT?;ENZ=Do you want to set %1 to only check amounts including GST and not amounts excluding VAT?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text014(Variable 1160040002)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=Do you want to remove the field '%1' from this template?;NOR=Ønsker du å fjerne feltet '%1' fra denne malen?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : DAN=Vil du fjerne feltet '%1' fra skabelonen?;DEU=Möchten Sie das Feld '%1' aus dieser Vorlage entfernen?;ENU=Do you want to remove the field '%1' from this template?;ESP=¿Desea eliminar el campo '%1' de esta plantilla?;FRA=Est-ce que vous voulez supprimer le champ %1 de ce modèle ?;NLD=Wilt u het veld '%1' uit dit sjabloon verwijderen?;NOR=Ønsker du å fjerne feltet '%1' fra denne malen?;SVE=Vill du ta bort fältet '%1' från mallen?;DES=Möchten Sie das Feld '%1' aus dieser Vorlage entfernen?;FRB=Est-ce que vous voulez supprimer le champ %1 de ce modèle ?;NLB=Wilt u het veld '%1' uit dit sjabloon verwijderen?;DEA=Möchten Sie das Feld '%1' aus dieser Vorlage entfernen?;ENA=Do you want to remove the field '%1' from this template?;ENZ=Do you want to remove the field '%1' from this template?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text015(Variable 1160040003)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=When a new template is created, %1 is automatically set to the same values as on the %2.;NOR=Når en ny mal er opprettet, er %1 automatisk satt til de samme verdiene som på %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : DAN=%1 bliver automatisk sat til værdien på %2, når en ny skabelon oprettes.;DEU=Wenn eine neue Vorlage erstellt wird, wird %1 automatisch auf die gleichen Werte eingestellt, wie auf der %2.;ENU=When a new template is created, %1 is automatically set to the same values as on the %2.;ESP=Cuando se crea una nueva plantilla, %1 se establece automáticamente en los mismos valores como en el caso de %2.;FRA=Lorsqu'un nouveau modèle est créé, %1 est automatiquement réglé sur les mêmes valeurs que sur le %2.;NLD=Wanneer een nieuw sjabloon is aangemaakt wordt %1 automatisch op dezelfde waarden gezet als op de %2.;NOR=Når en ny mal er opprettet, er %1 automatisk satt til de samme verdiene som på %2.;SVE=När en ny mall skapas, anges automatiskt %1 till samma värden som på %2.;DES=Wenn eine neue Vorlage erstellt wird, wird %1 automatisch auf die gleichen Werte eingestellt, wie auf der %2.;FRB=Lorsqu'un nouveau modèle est créé, %1 est automatiquement réglé sur les mêmes valeurs que sur le %2.;NLB=Wanneer een nieuw sjabloon is aangemaakt wordt %1 automatisch op dezelfde waarden gezet als op de %2.;DEA=Wenn eine neue Vorlage erstellt wird, wird %1 automatisch auf die gleichen Werte eingestellt, wie auf der %2.;ENA=When a new template is created, %1 is automatically set to the same values as on the %2.;ENZ=When a new template is created, %1 is automatically set to the same values as on the %2.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "PurchAutoAppErr(Variable 6085573)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchAutoAppErr : ENU='%1' must be %2 when '%3' is %4 in %5 %6;NOR='%1' må være %2 når '%3' er %4 i %5 %6;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchAutoAppErr : DAN='%1' skal være %2 når '%3' er %4.;DEU='%1' muss %2 sein, wenn in %5 %6 '%3' den Wert %4 hat;ENU='%1' must be %2 when '%3' is %4 in %5 %6;ESP='%1' debe ser %2 cuando '%3' es %4 en %5 %6;FRA='%1' doit être %2 lorsque '%3' est %4 dans %5 %6;NLD='%1' moet %2 zijn wanneer '%3' is %4 in %5 %6;NOR='%1' må være %2 når '%3' er %4 i %5 %6;SVE='%1' måste vara %2 när '%3' är %4 i %5 %6;DES='%1' muss %2 sein, wenn in %5 %6 '%3' den Wert %4 hat;FRB='%1' doit être %2 lorsque '%3' est %4 dans %5 %6;NLB='%1' moet %2 zijn wanneer '%3' is %4 in %5 %6;DEA='%1' muss %2 sein, wenn in %5 %6 '%3' den Wert %4 hat;ENA='%1' must be %2 when '%3' is %4 in %5 %6;ENZ='%1' must be %2 when '%3' is %4 in %5 %6;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ChangeSourceIDErr(Variable 6085574)".

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeSourceIDErr : ENU=You cannot change %1 because this template has been used on one or more documents.;NOR=Du kan ikke endre %1 fordi denne malen har blitt brukt på ett eller flere dokumenter.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeSourceIDErr : DAN=Du kan ikke ændre %1 da denne skabelon er brugt på et eller flere dokumenter.;DEU=Sie können %1 nicht ändern, da diese Vorlage auf einem oder mehreren Dokumenten verwendet wurde.;ENU=You cannot change %1 because this template has been used on one or more documents.;ESP=No puede modificar %1 porque esta plantilla se ha usado en al menos un documento.;FRA=Vous ne pouvez pas modifier %1 car ce modèle a été utilisé sur un ou plusieurs documents.;NLD=U kunt %1 niet wijzigen omdat deze sjabloon is gebruikt voor één of meer documenten.;NOR=Du kan ikke endre %1 fordi denne malen har blitt brukt på ett eller flere dokumenter.;SVE=Du kan inte ändra %1 eftersom den här mallen har använts i ett eller flera dokument.;DES=Sie können %1 nicht ändern, da diese Vorlage auf einem oder mehreren Dokumenten verwendet wurde.;FRB=Vous ne pouvez pas modifier %1 car ce modèle a été utilisé sur un ou plusieurs documents.;NLB=U kunt %1 niet wijzigen omdat deze sjabloon is gebruikt voor één of meer documenten.;DEA=Sie können %1 nicht ändern, da diese Vorlage auf einem oder mehreren Dokumenten verwendet wurde.;ENA=You cannot change %1 because this template has been used on one or more documents.;ENZ=You cannot change %1 because this template has been used on one or more documents.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SourceIDText(Variable 6085576)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceIDText : ENU=Source ID;NOR=Kilde-ID;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceIDText : DAN=Kilde-id;DEU=Herkunfts-ID;ENU=Source ID;ESP=Id. origen;FRA=ID source;NLD=Bron-id;NOR=Kilde-ID;SVE=Källnr.;DES=Herkunfts-ID;FRB=ID source;NLB=Bron-id;DEA=Herkunfts-ID;ENA=Source ID;ENZ=Source ID;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SourceNameText(Variable 6085575)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceNameText : ENU=Source Name;NOR=Kildenavn;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceNameText : DAN=Kildenavn;DEU=Herkunftsname;ENU=Source Name;ESP=Nombre origen;FRA=Nom orgine;NLD=Bronnaam;NOR=Kildenavn;SVE=Källnamn;DES=Herkunftsname;FRB=Nom orgine;NLB=Bronnaam;DEA=Herkunftsname;ENA=Source Name;ENZ=Source Name;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SourceIDNotExistErr(Variable 6085577)".

    //var
    //>>>> ORIGINAL VALUE:
    //SourceIDNotExistErr : ENU=%1 %2 does not exist.;NOR=%1 %2 eksisterer ikke.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SourceIDNotExistErr : DAN=%1 %2 findes ikke.;DEU=%1 %2 existiert nicht.;ENU=%1 %2 does not exist.;ESP=%1 %2 no existe.;FRA=%1 %2 n'existe pas.;NLD=% 1% 2 bestaat niet.;NOR=%1 %2 eksisterer ikke.;SVE=%1 %2 existerar inte.;DES=%1 %2 existiert nicht.;FRB=%1 %2 n'existe pas.;NLB=% 1% 2 bestaat niet.;DEA=%1 %2 existiert nicht.;ENA=%1 %2 does not exist.;ENZ=%1 %2 does not exist.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DuplicIdentTempErr(Variable 6085578)".

    //var
    //>>>> ORIGINAL VALUE:
    //DuplicIdentTempErr : ENU=You can only have one identification template for a document category.;NOR=Du kan bare ha en identifikasjonsmal for en dokumentkategori.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DuplicIdentTempErr : DAN=Du kan kun have en identifikationsskabelon til en dokumentkategori.;DEU=Sie können nur eine Identifikationsvorlage je Belegkategorie verwenden.;ENU=You can only have one identification template for a document category.;ESP=Solo puede haber una plantilla de tipo identificación por categoría de documento.;FRA=On ne peut avoir qu'un seul modèle identifiant pour une catégorie de documents.;NLD=U kunt slechts één identificatiesjabloon voor een documentcategorie hebben.;NOR=Du kan bare ha en identifikasjonsmal for en dokumentkategori.;SVE=Du kan bara ha en identifieringsmall för en dokumentkategori.;DES=Sie können nur eine Identifikationsvorlage je Belegkategorie verwenden.;FRB=On ne peut avoir qu'un seul modèle identifiant pour une catégorie de documents.;NLB=U kunt slechts één identificatiesjabloon voor een documentcategorie hebben.;DEA=Sie können nur eine Identifikationsvorlage je Belegkategorie verwenden.;ENA=You can only have one identification template for a document category.;ENZ=You can only have one identification template for a document category.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "HeaderText(Variable 6085579)".

    //var
    //>>>> ORIGINAL VALUE:
    //HeaderText : ENU=Header Fields;NOR=Hodefelt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //HeaderText : DAN=Hovedfelter;DEU=Kopffelder;ENU=Header Fields;ESP=Campos cabecera;FRA=Champs en-tête;NLD=Kopvelden;NOR=Hodefelt;SVE=Rubrikfält;DES=Kopffelder;FRB=Champs en-tête;NLB=Kopvelden;DEA=Kopffelder;ENA=Header Fields;ENZ=Header Fields;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "LineText(Variable 6085580)".

    //var
    //>>>> ORIGINAL VALUE:
    //LineText : ENU=Line Fields;NOR=Linjefelt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LineText : DAN=Linjefelter;DEU=Zeilenfelder;ENU=Line Fields;ESP=Campos línea;FRA=Champs de ligne;NLD=Regelvelden;NOR=Linjefelt;SVE=Radfält;DES=Zeilenfelder;FRB=Champs de ligne;NLB=Regelvelden;DEA=Zeilenfelder;ENA=Line Fields;ENZ=Line Fields;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "LineTextHidden(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //LineTextHidden : ENU=Line Fields (Currently Hidden);NOR=Linjefelt (for øyeblikket skjult);
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LineTextHidden : DAN=Linjefelter (p.t. skjult);ENU=Line Fields (Currently Hidden);ESP=Campos de línea (actualmente ocultos);ENA=Line Fields (Currently Hidden);ENZ=Line Fields (Currently Hidden);
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "NoMasterOnMasterErr(Variable 6085581)".

    //var
    //>>>> ORIGINAL VALUE:
    //NoMasterOnMasterErr : ENU="You cannot set a Master Template to be its own XML Master Template. ";NOR="Du kan ikke sette en hovedmal til å være sin egen XML-mal. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoMasterOnMasterErr : DAN="Du kan ikke opsætte en masterskabelon til at være dens egen XML-masterskabelon. ";ENU="You cannot set a Master Template to be its own XML Master Template. ";ESP=No puedo configurar una plantilla principal para que sea su propia plantilla principal XML.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "OverwriteStylesheetQst(Variable 6085582)".

    //var
    //>>>> ORIGINAL VALUE:
    //OverwriteStylesheetQst : ENU=There is already an XML Stylesheet file imported for this Template. Do you want to replace it?;NOR=Det er allerede importert en XML stilark-fil for denne malen. Vil du erstatte det?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OverwriteStylesheetQst : DAN=Der er allerede importeret et XML-stylesheet på denne skabelon. Vil du erstatte det?;ENU=There is already an XML Stylesheet file imported for this Template. Do you want to replace it?;ESP=Ya existe un archivo de hoja de estilo XML importado para esta plantilla, ¿desea sobreescribirlo?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "NoStylesheetMsg(Variable 6085583)".

    //var
    //>>>> ORIGINAL VALUE:
    //NoStylesheetMsg : ENU=There is no XML Stylesheet file imported for this Template.;NOR=Det er ingen XML-stilarkfil importert for denne malen.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NoStylesheetMsg : DAN=Der er ikke importeret et XML-stylesheet for denne skabelon.;ENU=There is no XML Stylesheet file imported for this Template.;ESP=No hay ningún archivo de hoja de estilo XML importado para esta plantilla.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "RefreshHtmlQst(Variable 6085584)".

    //var
    //>>>> ORIGINAL VALUE:
    //RefreshHtmlQst : ENU=All Open Documents using this Template must be refreshed to reflect the new XML Stylesheet. This process might take a while, depending on the number of Documents. Do you want continue?;NOR=Alle åpne dokumenter som bruker denne malen, må oppdateres for å gjenspeile den nye XML-stilarket. Denne prosessen kan ta en stund, avhengig av antall dokumenter. Vil du fortsette?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RefreshHtmlQst : DAN=Alle åbne dokumenter, der bruger denne skabelon, skal opdateres for at afspejle det nye XML styelsheet. Denne proces kan tage et stykke tid afhængigt af antallet af dokumenter. Vil du fortsætte?;ENU=All Open Documents using this Template must be refreshed to reflect the new XML Stylesheet. This process might take a while, depending on the number of Documents. Do you want continue?;ESP=Todos los documentos abiertos que usan esta plantilla se han de actualizar para reflejar el nuevo XML Stylesheet. Este proceso podría tardar un rato, dependiendo del número de documentos. ¿Desea continuar?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "UpdStylesheetMsg(Variable 6085587)".

    //var
    //>>>> ORIGINAL VALUE:
    //UpdStylesheetMsg : ENU=Updating Stylesheets\#1####################\@2@@@@@@@@@@@@@@@@@@@@;NOR=Oppdatere maler\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdStylesheetMsg : DAN=Skabeloner opdateres\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;DEU=Aktualisiere Vorlagen\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;ENU=Updating Stylesheets\#1####################\@2@@@@@@@@@@@@@@@@@@@@;ESP=Actualización plantillas\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;FRA=Mettre à jour Modèles\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;NLD=Bijwerken sjablonen\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;NOR=Oppdatere maler\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;SVE=Mallar uppdateras\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;DES=Aktualisiere Vorlagen\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;FRB=Mettre à jour Modèles\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;NLB=Bijwerken sjablonen\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;DEA=Aktualisiere Vorlagen\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;ENA=Updating templates\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;ENZ=Updating templates\#1####################\#2####################\@3@@@@@@@@@@@@@@@@@@@@;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "UpdStylesheetMsg2(Variable 6085588)".

    //var
    //>>>> ORIGINAL VALUE:
    //UpdStylesheetMsg2 : ENU=%1 %2 of %3;NOR=%1 av %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UpdStylesheetMsg2 : DAN=%1 af %2;DEU=%1 von %2;ENU=%1 %2 of %3;ESP=%1 de %2;FRA=%1 de %2;NLD=%1 van %2;NOR=%1 av %2;SVE=%1 av %2;DES=%1 von %2;FRB=%1 de %2;NLB=%1 van %2;DEA=%1 von %2;ENA=%1 of %2;ENZ=%1 of %2;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "StylesheetUpdatedMsg(Variable 6085589)".

    //var
    //>>>> ORIGINAL VALUE:
    //StylesheetUpdatedMsg : ENU=Stylesheet updated.;NOR=Stilark oppdatert.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //StylesheetUpdatedMsg : DAN=Stylesheet opdateret.;ENU=Stylesheet updated.;ESP=Stylesheet actualizado.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ImportStylesheetMsg(Variable 6085586)".

    //var
    //>>>> ORIGINAL VALUE:
    //ImportStylesheetMsg : ENU=Import Template Stylesheet file;NOR=Importer stilark mal;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ImportStylesheetMsg : DAN=Import skabelon stylesheet fil;ENU=Import Template Stylesheet file;ESP=Importar archivo Stylesheet;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ExportStylesheetMsg(Variable 6085590)".

    //var
    //>>>> ORIGINAL VALUE:
    //ExportStylesheetMsg : ENU=Export Template Stylesheet file;NOR=Eksporter stilark mal;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ExportStylesheetMsg : DAN=Eksporter skabelon stylesheet fil;ENU=Export Template Stylesheet file;ESP=Exportar archivo Stylesheet;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "SelectMainFileMsg(Variable 6085591)".

    //var
    //>>>> ORIGINAL VALUE:
    //SelectMainFileMsg : ENU=You must select a Stylesheet file from the Zip file.;NOR=Du må velge en stilark fil fra zip filen.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectMainFileMsg : DAN=Du skal vælge en stylesheet fil fra Zip filen.;ENU=You must select a Stylesheet file from the Zip file.;ESP=Debe seleccionar un archivo de hoja de estilo principal del archivo Zip.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ReviewDiscChrgQst(Variable 6086200)".

    //var
    //>>>> ORIGINAL VALUE:
    //ReviewDiscChrgQst : ENU="There are %1 in the XML document that are not mapped in the Template.\\Would you like to review and add them now? ";NOR="Det er %1 i XML-dokumentet som ikke er kartlagt i malen.\\Vil du gå gjennom de og legge de til nå? ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReviewDiscChrgQst : DAN="Der er %1 i XML-dokumentet, der ikke er matchet i skabelonen. Vil du gerne gennemgå dem nu? ";ENU="There are %1 in the XML document that are not mapped in the Template.\\Would you like to review and add them now? ";ESP="Hay %1 en el documento XML que no están asignados en la plantilla. \\¿Desea revisarlos y agregarlos ahora? ";
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DiscountsTxt(Variable 6086203)".

    //var
    //>>>> ORIGINAL VALUE:
    //DiscountsTxt : ENU=discounts;NOR=rabatter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DiscountsTxt : DAN=rabatter;ENU=discounts;ESP=descuentos;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "ChargesTxt(Variable 6086202)".

    //var
    //>>>> ORIGINAL VALUE:
    //ChargesTxt : ENU=charges;NOR=kostnader;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChargesTxt : DAN=gebyrer;ENU=charges;ESP=cargos;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "DiscAndChargesTxt(Variable 6086201)".

    //var
    //>>>> ORIGINAL VALUE:
    //DiscAndChargesTxt : ENU=discounts and charges;NOR=rabatter og avgifter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DiscAndChargesTxt : DAN=rabatter og gebyrer;ENU=discounts and charges;ESP=descuentos y cargos;
    //Variable type has not been exported.
}