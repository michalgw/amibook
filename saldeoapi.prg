/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2023  GM Systems Michaˆ Gawrycki (gmsystems.pl)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

************************************************************************/

#require "xhb"
#include "hbxml.ch"
#include "inkey.ch"
#include "saldeoapi.ch"

FUNCTION xmlDodajWezel( oElement, aTablica, aSalLists )

   LOCAL oEl, oListEl, aListEl, oIter, cLstName, lLstSimple, nElIdx
   LOCAL xSalEl

   oEl := oElement

   DO WHILE oEl != NIL
      IF oEl:nType == HBXML_TYPE_TAG
         IF oEl:oChild != NIL
            IF hb_HHasKey( aSalLists, oEl:cName )
               xSalEl := aSalLists[ oEl:cName ]
               cLstName := ""
               IF HB_ISARRAY( xSalEl )
                  IF HB_ISCHAR( xSalEl[ 1 ] )
                     cLstName := xSalEl[ 1 ]
                     lLstSimple := xSalEl[ 2 ]
                  ELSEIF HB_ISARRAY( xSalEl[ 1 ] )
                     nElIdx := AScan( xSalEl, { | aEl | aEl[ 1 ] == oEl:Path() } )
                     IF nElIdx > 0
                        cLstName := xSalEl[ nElIdx ][ 2 ]
                        lLstSimple := xSalEl[ nElIdx ][ 3 ]
                     ENDIF
                  ENDIF
               ELSEIF HB_ISCHAR( xSalEl )
                  cLstName := xSalEl
                  lLstSimple := .F.
               ENDIF
               IF cLstName <> ""
                  aTablica[ oEl:cName ] := {}
                  oIter := TXmlIteratorScan():New( oEl )
                  oListEl := oIter:Find( cLstName )
                  DO WHILE oListEl != NIL .AND. oListEl:nType == HBXML_TYPE_TAG  .AND. ( lLstSimple .OR. oListEl:oChild != NIL )
                     aListEl := {=>}
                     IF lLstSimple
                        aListEl[ cLstName ] := oListEl:cData
                     ELSE
                        xmlDodajWezel( oListEl:oChild, @aListEl, aSalLists )
                     ENDIF
                     AAdd( aTablica[ oEl:cName ], aListEl )
                     oListEl := oIter:Next()
                  ENDDO
                  oIter := NIL
               ELSE
                  aTablica[ oEl:cName ] := {=>}
                  xmlDodajWezel( oEl:oChild, @aTablica[ oEl:cName ], aSalLists )
               ENDIF
            ELSE
               aTablica[ oEl:cName ] := {=>}
               xmlDodajWezel( oEl:oChild, @aTablica[ oEl:cName ], aSalLists )
            ENDIF
            /*
            nElIdx := hb_HPos( aSalLists, oEl:cName )
            IF nElIdx == 0
               nElIdx := hb_HPos( aSalLists, oEl:Path() )
            ENDIF
            IF nElIdx > 0
               IF HB_ISARRAY( hb_HValueAt( aSalLists, nElIdx ) )
                  cLstName := hb_HValueAt( aSalLists, nElIdx )[ 1 ]
                  lLstSimple := hb_HValueAt( aSalLists, nElIdx )[ 2 ]
               ELSE
                  cLstName := hb_HValueAt( aSalLists, nElIdx )
                  lLstSimple := .F.
               ENDIF
               aTablica[ oEl:cName ] := {}
               oIter := TXmlIteratorScan():New( oEl )
               oListEl := oIter:Find( cLstName )
               DO WHILE oListEl != NIL .AND. oListEl:nType == HBXML_TYPE_TAG  .AND. ( lLstSimple .OR. oListEl:oChild != NIL )
                  aListEl := {=>}
                  IF lLstSimple
                     aListEl[ cLstName ] := oListEl:cData
                  ELSE
                     xmlDodajWezel( oListEl:oChild, @aListEl, aSalLists )
                  ENDIF
                  AAdd( aTablica[ oEl:cName ], aListEl )
                  oListEl := oIter:Next()
               ENDDO
               oIter := NIL
            ELSE
               aTablica[ oEl:cName ] := {=>}
               xmlDodajWezel( oEl:oChild, @aTablica[ oEl:cName ], aSalLists )
            ENDIF
            */
         ELSE
            aTablica[ oEl:cName ] := oEl:cData
         ENDIF
      ENDIF
      oEl := oEl:oNext
   ENDDO

   RETURN aTablica

/*----------------------------------------------------------------------*/

FUNCTION xmlWczytaj( oXML, aSalLists )

   LOCAL aRes := {=>}, oEl

   hb_default( @aSalLists, { => } )
   aSalLists := hb_HMerge( aSalLists, { 'PARAMETERS' => 'PARAMETER' } )

   oEl := oXML:FindFirst( "RESPONSE" )
   IF oEl != NIL .AND. oEl:oChild != NIL
      xmlDodajWezel( oEl:oChild, @aRes, aSalLists )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION SalGetPost( lGet, cAkcja, cParametry, cDane, oXML )

   LOCAL nRes, cKolor, cResponse, oEl, lRes := .F., cKom, cDmpFN

   cKolor := ColInf()
   @ 24, 0 SAY PadC( 'Komunikacja z Saldeo... prosz© czeka†...', 80 )

   IF trybSerwisowy
      cDmpFN := 'sal' + DToS( Date() ) + hb_TToS( hb_DateTime() )
      IF HB_ISCHAR( cDane ) .AND. Len( cDane ) > 0
         MemoWrit( cDmpFN + '.req.xml', cDane )
      ENDIF
   ENDIF

   IF lGet
      nRes := amiSalGet( cAkcja, cParametry )
   ELSE
      nRes := amiSalPost( cAkcja, cParametry, cDane )
   ENDIF

   SET COLOR TO
   @ 24, 0
   SetColor( cKolor )

   IF nRes < 200 .OR. nRes > 299
      Komunikat( "Bˆ¥d poˆ¥czenia z usˆug¥ SaldeoSMART:;" + amiEdekBladTekst() )
   ELSE
      cResponse := amiRestResponse()
      IF trybSerwisowy
         MemoWrit( cDmpFN + '.res.xml', cResponse )
      ENDIF
      IF ! Empty( cResponse ) .AND. HB_ISCHAR( cResponse )
         oXML := TXMLDocument():New( cResponse )
         IF oXML:nError == HBXML_ERROR_NONE
            oEl := oXML:FindFirst( "STATUS" )
            IF oEl <> NIL
               IF HB_ISCHAR( oEl:cData ) .AND. oEl:cData == "OK"
                  lRes := .T.
               ELSE
                  cKom := ""
                  oEl := oXML:FindFirst( "ERROR_CODE" )
                  IF oEl <> NIL
                     cKom := "(" + oEl:cData + ") "
                  ENDIF
                  oEl := oXML:FindFirst( "ERROR_MESSAGE" )
                  IF oEl <> NIL
                     cKom := cKom + oEl:cData
                  ENDIF
                  Komunikat( "Bˆ¥d komunikacji z SaldeoSMART;" + cKom )
               ENDIF
            ENDIF
         ENDIF
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION SalRobID( nRodzaj, nID )

   LOCAL aRodzaj := { "FI", "KN", "TR", "KS", "KZ", "RS", "RZ" }

   RETURN amiSalPobProgID() + "-" + aRodzaj[ nRodzaj ] + "-" ;
      + StrTran( iif( nRodzaj == SAL_TYP_FIRMA, Str( nID, 3 ), ident_fir ), " ", "0" ) ;
      + iif( nRodzaj == SAL_TYP_FIRMA, "", "-" + StrTran( Str( nID, 6 ), " ", "0" ) )

/*----------------------------------------------------------------------*/

FUNCTION SalDekID( cSalID, nRodzaj, nID, nFirma )

   LOCAL aRodzaj := { "FI", "KN", "TR", "KS", "KZ", "RS", "RZ" }
   LOCAL lRes := .F.
   LOCAL nPos, cFirma, cRodzaj, cID

   IF At( amiSalPobProgID() + "-", cSalID ) == 1
      nPos := Len( amiSalPobProgID() )
      cRodzaj := SubStr( cSalID, nPos + 1, 2 )
      nRodzaj := AScan( aRodzaj, cRodzaj )
      IF nRodzaj > 0
         cFirma := SubStr( cSalID, nPos + 4, 3 )
         cFirma := StrTran( cFirma, "0", " " )
         nFirma := Val( cFirma )
         IF nRodzaj > SAL_TYP_FIRMA .AND. Len( cSalID ) > nPos + 8
            cID := SubStr( cSalID, nPos + 8, 8 )
            nID := Val( cSalID )
         ENDIF
         IF cFirma == ident_fir .AND. ( nRodzaj == SAL_TYP_FIRMA .OR. nID > 0 )
            lRes := .T.
         ENDIF
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION SalSprawdz( lPokazKomunikat )

   LOCAL lRes := ! Empty( SalCompanyProgramId ) .AND. amiSalGotowe() == 1

   hb_default( @lPokazKomunikat, .T. )

   IF ! lRes .AND. lPokazKomunikat
      Komun( "Firma nie jest poˆ¥czona z SaldeoSMART" )
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION SalCompanyList( cCompanyProgID )

   LOCAL cAkcja := '/api/xml/1.17/company/list'
   LOCAL cParametry := '', oXML, aRes
   LOCAL aSalLists := { ;
      'COMPANIES' => 'COMPANY', ;
      'BANK_ACCOUNTS' => 'BANK_ACCOUNT' }

   IF ! Empty( cCompanyProgID )
      cParametry := 'company_program_id=' + cCompanyProgID
   ENDIF

   IF SalGetPost( .T., cAkcja, cParametry, , @oXML )
      aRes := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION SalCompanySynchronize( cCompanyID, cCompanyProgID )

   LOCAL cAkcja := '/api/xml/1.0/company/synchronize'
   LOCAL cDane := '<?xml version="1.0" encoding="UTF-8"?><ROOT><COMPANIES>' ;
      + '<COMPANY><COMPANY_ID>' + cCompanyID + '</COMPANY_ID>' ;
      + '<COMPANY_PROGRAM_ID>' + cCompanyProgID + '</COMPANY_PROGRAM_ID>' ;
      + '</COMPANY></COMPANIES></ROOT>'
   LOCAL oXML, aRes
   LOCAL aSalLists := { ;
      'RESULTS' => 'COMPANY', ;
      'ERRORS' => 'ERROR' }

   IF SalGetPost( .F., cAkcja, '', cDane, @oXML )
      aRes := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION SalContractorMerge( aDane, cCompanyProgID )

   LOCAL cAkcja := '/api/xml/1.23/contractor/merge'
   LOCAL cParametry := 'company_program_id=' + cCompanyProgID
   LOCAL cDane, aDaneWyj, nI, oXML
   LOCAL aSalLists := { ;
      'RESULTS' => 'CONTRACTOR', ;
      'ERRORS' => 'ERROR', ;
      'BANK_ACCOUNTS' => 'BANK_ACCOUNT', ;
      'EMAILS' => { 'EMAIL', .T. } }

   cDane := '<?xml version="1.0" encoding="UTF-8"?><ROOT><CONTRACTORS>'

   FOR nI := 1 TO Len( aDane )
      cDane += '<CONTRACTOR><CONTRACTOR_PROGRAM_ID>' + aDane[ nI ][ 'salprgid' ] + '</CONTRACTOR_PROGRAM_ID>'
      cDane += '<SHORT_NAME>' + str2sxml( SubStr( aDane[ nI ][ 'nazwa' ], 1, 40 ) + StrTran( Str( aDane[ nI ][ 'id' ], 6 ), " ", "0" ), .F. ) + '</SHORT_NAME>'
      cDane += '<FULL_NAME>' + str2sxml( aDane[ nI ][ 'nazwa' ], .F. ) + '</FULL_NAME>'
      IF hb_HHasKey( aDane[ nI ], 'nip' ) .AND. ! Empty( aDane[ nI ][ 'nip' ] )
         cDane += '<VAT_NUMBER>' + aDane[ nI ][ 'nip' ] + '</VAT_NUMBER>'
      ENDIF
      cDane += '<CITY>' + str2sxml( aDane[ nI ][ 'miasto' ], .F. ) + '</CITY>'
      cDane += '<POSTCODE>' + str2sxml( aDane[ nI ][ 'kodpoczt' ], .F. ) + '</POSTCODE>'
      cDane += '<STREET>' + str2sxml( aDane[ nI ][ 'ulica' ] + iif( ! Empty( aDane[ nI ][ 'nrbud' ] ), ' ' + aDane[ nI ][ 'nrbud' ], '' ) + iif( ! Empty( aDane[ nI ][ 'nrlok' ] ), '/' + aDane[ nI ][ 'nrlok' ], '' ), .F. ) + '</STREET>'
      IF ! Empty( aDane[ nI ][ 'kraj' ] )
         cDane += '<COUNTRY_ISO3166A2>' + aDane[ nI ][ 'kraj' ] + '</COUNTRY_ISO3166A2>'
      ENDIF
      cDane += '</CONTRACTOR>'
   NEXT
   cDane += '</CONTRACTORS></ROOT>'

   IF SalGetPost( .F., cAkcja, cParametry, cDane, @oXML )
      aDaneWyj := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aDaneWyj

/*----------------------------------------------------------------------*/

FUNCTION SalDescriptionMerge( aDane, cCompanyProgID )

   LOCAL cAkcja := '/api/xml/1.13/description/merge'
   LOCAL cParametry := 'company_program_id=' + cCompanyProgID
   LOCAL cDane, aDaneWyj, nI, oXML
   LOCAL aSalLists := { ;
      'RESULTS' => 'DESCRIPTION', ;
      'ERRORS' => 'ERROR' }

   cDane := '<?xml version="1.0" encoding="UTF-8"?><ROOT><DESCRIPTIONS>'

   FOR nI := 1 TO Len( aDane )
      cDane += '<DESCRIPTION><PROGRAM_ID>' + aDane[ nI ][ 'salprgid' ] + '</PROGRAM_ID>'
      cDane += '<VALUE>' + str2sxml( aDane[ nI ][ 'tresc' ], .F. ) + '</VALUE></DESCRIPTION>'
   NEXT
   cDane += '</DESCRIPTIONS></ROOT>'

   IF SalGetPost( .F., cAkcja, cParametry, cDane, @oXML )
      aDaneWyj := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aDaneWyj

/*----------------------------------------------------------------------*/

FUNCTION SalRegisterMerge( aDane, cCompanyProgID )

   LOCAL cAkcja := '/api/xml/1.0/register/merge'
   LOCAL cParametry := 'company_program_id=' + cCompanyProgID
   LOCAL cDane, aDaneWyj, nI, oXML
   LOCAL aSalLists := { ;
      'RESULTS' => 'REGISTER', ;
      'ERRORS' => 'ERROR' }

   cDane := '<?xml version="1.0" encoding="UTF-8"?><ROOT><REGISTERS>'

   FOR nI := 1 TO Len( aDane )
      cDane += '<REGISTER><REGISTER_PROGRAM_ID>' + aDane[ nI ][ 'salprgid' ] + '</REGISTER_PROGRAM_ID>'
      cDane += '<NAME>' + str2sxml( aDane[ nI ][ 'nazwa' ], .F. ) + '</NAME></REGISTER>'
   NEXT
   cDane += '</REGISTERS></ROOT>'

   IF SalGetPost( .F., cAkcja, cParametry, cDane, @oXML )
      aDaneWyj := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aDaneWyj

/*----------------------------------------------------------------------*/

FUNCTION SalDocumentList( cCompanyProgID, cPolicy )

   LOCAL cAkcja := '/api/xml/2.12/document/list'
   LOCAL cParametry := 'company_program_id=' + cCompanyProgID + '&policy=' + cPolicy
   LOCAL aDaneWyj, nI, oXML
   LOCAL aSalLists := { ;
      'ARTICLES' => 'ARTICLE', ;
      'FOREIGN_CODES' => 'FOREIGN_CODE', ;
      'CONTRACTORS' => 'CONTRACTOR', ;
      'BANK_ACCOUNTS' => 'BANK_ACCOUNT', ;
      'EMAILS' => { 'EMAIL', .T. }, ;
      'DOCUMENTS' => 'DOCUMENT', ;
      'VAT_REGISTRIES' => 'VAT_REGISTRY', ;
      'ITEMS' => 'ITEM', ;
      'DIMENSIONS' => 'DIMENSION', ;
      'DIMENSION_VALUES' => 'DIMENSION_VALUE', ;
      'PREVIEWS' => { 'PREVIEW_URL', .T. }, ;
      'REGISTRATION_NUMBERS' => 'REGISTRATION_NUMBER', ;
      'SALDEO_SYNC_DOCUMENTS' => 'SALDEO_SYNC_DOCUMENT', ;
      'ATTACHMENTS' => 'ATTACHMENT', ;
      'DOCUMENT_ITEMS' => 'DOCUMENT_ITEM', ;
      'JPK_CODES' => 'JPK_CODE', ;
      'ERRORS' => 'ERROR' }

   IF SalGetPost( .T., cAkcja, cParametry, '', @oXML )
      aDaneWyj := xmlWczytaj( oXML, aSalLists )
   ENDIF

   RETURN aDaneWyj

/*----------------------------------------------------------------------*/

FUNCTION SalCompanyListPokaz( aDane, bAkcja, nElem )

   LOCAL aNaglowki := { ;
      "Akt", ;
      "Nazwa skr¢cona", ;
      "NIP", ;
      "Peˆna nazwa", ;
      "Miejscowo˜†", ;
      "Kod poczt", ;
      "Ulica", ;
      "Telefon", ;
      "E-mail", ;
      "Nazwa u¾ytk." }
   LOCAL aBlokiKolumn := { ;
      { || iif( hb_HHasKey( aDane[ nElem ], "COMPANY_PROGRAM_ID" ) .AND. ! Empty( aDane[ nElem ][ "COMPANY_PROGRAM_ID" ] ) .AND. At( amiSalPobProgID(), aDane[ nElem ][ "COMPANY_PROGRAM_ID" ] ) == 1, "TAK", "   " ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "SHORT_NAME" ) .AND. ! Empty( aDane[ nElem ][ "SHORT_NAME" ] ), Pad( SubStr( aDane[ nElem ][ "SHORT_NAME" ], 1, 20 ), 20 ), Replicate( " ", 20 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "VAT_NUMBER" ) .AND. ! Empty( aDane[ nElem ][ "VAT_NUMBER" ] ), Pad( SubStr( aDane[ nElem ][ "VAT_NUMBER" ], 1, 16 ), 16 ), Replicate( " ", 16 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "FULL_NAME" ) .AND. ! Empty( aDane[ nElem ][ "FULL_NAME" ] ), Pad( SubStr( aDane[ nElem ][ "FULL_NAME" ], 1, 40 ), 40 ), Replicate( " ", 40 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "CITY" ) .AND. ! Empty( aDane[ nElem ][ "CITY" ] ), Pad( SubStr( aDane[ nElem ][ "CITY" ], 1, 20 ), 20 ), Replicate( " ", 20 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "POSTCODE" ) .AND. ! Empty( aDane[ nElem ][ "POSTCODE" ] ), Pad( SubStr( aDane[ nElem ][ "POSTCODE" ], 1, 8 ), 8 ), Replicate( " ", 8 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "STREET" ) .AND. ! Empty( aDane[ nElem ][ "STREET" ] ), Pad( SubStr( aDane[ nElem ][ "STREET" ], 1, 20 ), 20 ), Replicate( " ", 20 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "TELEPHONE" ) .AND. ! Empty( aDane[ nElem ][ "TELEPHONE" ] ), Pad( SubStr( aDane[ nElem ][ "TELEPHONE" ], 1, 16 ), 16 ), Replicate( " ", 16 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "EMAIL" ) .AND. ! Empty( aDane[ nElem ][ "EMAIL" ] ), Pad( SubStr( aDane[ nElem ][ "EMAIL" ], 1, 40 ), 40 ), Replicate( " ", 40 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "USERNAME" ) .AND. ! Empty( aDane[ nElem ][ "USERNAME" ] ), Pad( SubStr( aDane[ nElem ][ "USERNAME" ], 1, 20 ), 20 ), Replicate( " ", 20 ) ) } }
   LOCAL aKlawisze

   hb_default( @nElem, 1 )
   IF HB_ISBLOCK( bAkcja )
      aKlawisze := { { K_ENTER, bAkcja } }
   ENDIF

   GM_ArEdit( 4, 0, 21, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", NIL, NIL )

   IF LastKey() == K_ESC
      nElem := 0
   ENDIF

   RETURN nElem

/*----------------------------------------------------------------------*/

FUNCTION SalPolaczFirme( aFirma )

   LOCAL aSalFirmy, nFirma, nE, cEkran, cKolor
   LOCAL bAkcja := { | nElem, ar, b, exit_requested |
      LOCAL aRes, cCompanyProgID
      IF nElem > 0
         IF NormalizujNipPl( ar[ nElem ][ 'VAT_NUMBER' ] ) <> NormalizujNipPl( firma->nip )
            IF Alert( "Nr NIP wybranej firmy r¢¾ni si© od nr NIP firmy w programie.;" ;
               + "Nr NIP z Saldeo:   " + ar[ nElem ][ 'VAT_NUMBER' ] + ";" ;
               + "Nr NIP z programu: " + AllTrim( firma->nip ) + ";;" ;
               + "Czy chcesz przypisa† wybran¥ firm©?", { "Nie", "Tak" } ) <> 2
               RETURN NIL
            ENDIF
         ELSE
            IF ! TNEsc( , "Czy poˆ¥czy† wybran¥ firm©? (Tak/Nie)" )
               RETURN NIL
            ENDIF
         ENDIF
         cCompanyProgID := SalRobID( SAL_TYP_FIRMA, firma->( RecNo() ) )
         aRes := SalCompanySynchronize( ar[ nElem ][ 'COMPANY_ID' ], cCompanyProgID )
         IF HB_ISHASH( aRes ) .AND. hb_HHasKey( aRes, 'RESULTS' ) .AND. HB_ISARRAY( aRes[ 'RESULTS' ] ) ;
            .AND. Len( aRes[ 'RESULTS' ] ) > 0

            IF aRes[ 'RESULTS' ][ 1 ][ 'STATUS' ] == 'MERGED'
               firma->( BlokadaR() )
               firma->salsalid := aRes[ 'RESULTS' ][ 1 ][ 'COMPANY_ID' ]
               firma->salprgid := cCompanyProgID
               firma->( dbCommit() )
               firma->( dbUnlock() )
               Komun( "Firma zostaˆa poˆ¥czona" )
               exit_requested := .T.
            ELSE
               Alert( "Nie udaˆo si© poˆ¥czy† firmy.;Status: " + aRes[ 'RESULTS' ][ 1 ][ 'STATUS' ], { "OK" } )
            ENDIF

         ENDIF
      ENDIF
      RETURN NIL
   }

   aSalFirmy := SalCompanyList()
   IF HB_ISHASH( aSalFirmy ) .AND. hb_HHasKey( aSalFirmy, "COMPANIES" ) .AND. HB_ISARRAY( aSalFirmy[ 'COMPANIES' ] ) .AND. Len( aSalFirmy[ 'COMPANIES' ] ) > 0
      cKolor := ColStd()
      cEkran := SaveScreen()
      @ 2, 0 SAY PadC( "¤CZENIE FIRMY Z SALDEO SMART", 80 )
      @ 3, 0 SAY PadC( "Firma: " + AllTrim( firma->symbol ) + "     NIP: " + AllTrim( firma->nip ), 80 )
      @ 22, 0 SAY PadC( "Enter - wybierz i poˆ¥cz     Esc - anuluj", 80 )
      nE := AScan( aSalFirmy[ 'COMPANIES' ], { | xEl | hb_HHasKey( xEl, "VAT_NUMBER" ) .AND. NormalizujNipPl( xEl[ 'VAT_NUMBER' ] ) == NormalizujNipPl( firma->nip ) } )
      IF nE = 0
         nE := 1
      ENDIF
      nFirma := SalCompanyListPokaz( aSalFirmy[ 'COMPANIES' ], bAkcja, nE )
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalKontrahenciWyslij()

   LOCAL aDaneDo := {}, aDaneOd, nLicz := 0, aKontr, nI, aNipyGus := {}
   LOCAL aDaneRegon, aDaneWys := {}, nJ, nK, nPrevOrd, nPrevRecNo, nGusCnt := 0

   nPrevRecNo := kontr->( RecNo() )
   kontr->( dbGoTop() )
   kontr->( dbSeek( "+" + ident_fir ) )
   DO WHILE kontr->del == "+" .AND. kontr->firma == ident_fir .AND. ! kontr->( Eof() )
      IF ( kontr->zrodlo == "R" .AND. ( Empty( kontr->salsalid ) .OR. Empty( kontr->salprgid ) ) ) ;
         .OR. ( kontr->zrodlo == "S" .AND. ! Empty( kontr->salsalid ) .AND. Empty( kontr->salprgid ) )
         aKontr := { ;
            'id' => kontr->id, ;
            'nip' => AllTrim( NormalizujNipPL( kontr->nr_ident ) ), ;
            'nazwa' => AllTrim( kontr->nazwa ), ;
            'kraj' => iif( Empty( kontr->kraj ), "PL", AllTrim( kontr->kraj ) ), ;
            'kodpoczt' => AllTrim( kontr->kodpoczt ), ;
            'miasto' => AllTrim( kontr->miasto ), ;
            'ulica' => AllTrim( kontr->ulica ), ;
            'nrbud' => AllTrim( kontr->nrbud ), ;
            'nrlok' => AllTrim( kontr->nrlok ), ;
            'salprgid' => SalRobID( SAL_TYP_KONTR, kontr->( RecNo() ) ), ;
            'gus' => Empty( kontr-> kodpoczt ) .OR. Empty( kontr->miasto ) .OR. Empty( kontr->ulica ) }
         IF aKontr[ 'gus' ]
            nLicz++
         ENDIF
         AAdd( aDaneDo, aKontr )
      ENDIF
      kontr->( dbSkip() )
   ENDDO

   nPrevOrd := kontr->( ordSetFocus( 3 ) )

   FOR nI := 1 TO Len( aDaneDo )
      IF aDaneDo[ nI ][ 'gus' ]
         IF nGusCnt < 500
            AAdd( aNipyGus, aDaneDo[ nI ][ 'nip' ] )
            AAdd( aDaneWys, aDaneDo[ nI ] )
            nGusCnt++
         ENDIF
      ELSE
         AAdd( aDaneWys, aDaneDo[ nI ] )
      ENDIF
      IF ( Len( aDaneWys ) > 0 .AND. Len( aDaneWys ) % 20 == 0 ) .OR. ( nI == Len( aDaneDo ) .AND. Len( aDaneWys ) > 0 )
         IF Len( aNipyGus ) > 0
            aDaneRegon := KontrahZnajdzRegonNip( aNipyGus )
            FOR nJ := 1 TO Len( aDaneRegon )
               nK := AScan( aDaneWys, { | aPoz | aPoz[ 'nip' ] == aDaneRegon[ nJ ][ 'nip' ] } )
               IF hb_HHasKey( aDaneRegon[ nJ ], 'zipCode' )
                  aDaneWys[ nK ][ 'kodpoczt' ] := aDaneRegon[ nJ ][ 'zipCode' ]
               ENDIF
               IF hb_HHasKey( aDaneRegon[ nJ ], 'city' )
                  aDaneWys[ nK ][ 'miasto' ] := aDaneRegon[ nJ ][ 'city' ]
               ENDIF
               IF hb_HHasKey( aDaneRegon[ nJ ], 'street' )
                  aDaneWys[ nK ][ 'ulica' ] := aDaneRegon[ nJ ][ 'street' ]
               ENDIF
               IF hb_HHasKey( aDaneRegon[ nJ ], 'propertyNumber' )
                  aDaneWys[ nK ][ 'nrbud' ] := aDaneRegon[ nJ ][ 'propertyNumber' ]
               ENDIF
               IF hb_HHasKey( aDaneRegon[ nJ ], 'apartmentNumber' )
                  aDaneWys[ nK ][ 'nrlok' ] := aDaneRegon[ nJ ][ 'apartmentNumber' ]
               ENDIF
               IF kontr->( dbSeek( Str( aDaneWys[ nK ][ 'id' ], 6 ) ) ) .AND. kontr->id == aDaneWys[ nK ][ 'id' ]
                  kontr->( BlokadaR() )
                  kontr->kodpoczt := aDaneRegon[ nJ ][ 'zipCode' ]
                  kontr->miasto := aDaneRegon[ nJ ][ 'city' ]
                  kontr->ulica := aDaneRegon[ nJ ][ 'street' ]
                  kontr->nrbud := aDaneRegon[ nJ ][ 'propertyNumber' ]
                  kontr->nrlok := aDaneRegon[ nJ ][ 'apartmentNumber' ]
                  kontr->( dbCommit() )
                  kontr->( dbUnlock() )
               ENDIF
            NEXT
            aNipyGus := {}
            //hb_idleSleep( 3 )
         ENDIF
         aDaneOd := SalContractorMerge( aDaneWys, SalCompanyProgramId )
         IF HB_ISHASH( aDaneOd ) .AND. hb_HHasKey( aDaneOd, 'RESULTS' ) ;
            .AND. HB_ISARRAY( aDaneOd[ 'RESULTS' ] ) .AND. Len( aDaneOd[ 'RESULTS' ] ) > 0

            FOR nJ := 1 TO Len( aDaneOd[ 'RESULTS' ] )
               IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nJ ], 'STATUS' ) .AND. AScan( { "CREATED", "MERGED", "RECREATED" }, aDaneOd[ 'RESULTS' ][ nJ ][ 'STATUS' ] ) > 0
                  nK := AScan( aDaneWys, { | aPoz | hb_HHasKey( aDaneOd[ 'RESULTS' ][ nJ ], 'VAT_NUMBER' ) .AND. aPoz[ 'nip' ] == aDaneOd[ 'RESULTS' ][ nJ ][ 'VAT_NUMBER' ] } )
                  IF nK > 0 .AND. kontr->( dbSeek( Str( aDaneWys[ nK ][ 'id' ], 6 ) ) ) .AND. kontr->id == aDaneWys[ nK ][ 'id' ]
                     kontr->( BlokadaR() )
                     IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nJ ], 'CONTRACTOR_PROGRAM_ID' )
                        kontr->salprgid := aDaneOd[ 'RESULTS' ][ nJ ][ 'CONTRACTOR_PROGRAM_ID' ]
                     ENDIF
                     IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nJ ], 'CONTRACTOR_ID' )
                        kontr->salsalid := aDaneOd[ 'RESULTS' ][ nJ ][ 'CONTRACTOR_ID' ]
                     ENDIF
                     kontr->( dbCommit() )
                     kontr->( dbUnlock() )
                  ENDIF
               ENDIF
            NEXT

         ENDIF
         aDaneWys := {}
      ENDIF
   NEXT

   kontr->( ordSetFocus( nPrevOrd ) )
   kontr->( dbGoto( nPrevRecNo ) )

   Komun( "Zakoäczono wysyˆanie kontrahent¢w" )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalTresciWyslij()

   LOCAL aDaneDo := {}, aDaneOd, aTresc, nI
   LOCAL nJ, nPrevOrd, nPrevRecNo

   nPrevRecNo := tresc->( RecNo() )
   tresc->( dbGoTop() )
   tresc->( dbSeek( "+" + ident_fir ) )
   DO WHILE ! tresc->( Eof() ) .AND. tresc->del == "+" .AND. tresc->firma == ident_fir
      aTresc := { ;
         'id' => tresc->id, ;
         'tresc' => AllTrim( tresc->tresc ), ;
         'salprgid' => iif( Empty( tresc->salprgid ), SalRobID( SAL_TYP_TRESC, tresc->id ), AllTrim( tresc->salprgid ) ) }
      AAdd( aDaneDo, aTresc )
      tresc->( dbSkip() )
   ENDDO

   aDaneOd := SalDescriptionMerge( aDaneDo, SalCompanyProgramId )

   IF HB_ISHASH( aDaneOd ) .AND. hb_HHasKey( aDaneOd, 'RESULTS' ) .AND. Len( aDaneOd[ 'RESULTS' ] ) > 0
      nPrevOrd := tresc->( ordSetFocus( 2 ) )
      FOR nI := 1 TO Len( aDaneOd[ 'RESULTS' ] )
         IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nI ], 'STATUS' ) .AND. aDaneOd[ 'RESULTS' ][ nI ][ 'STATUS' ] == 'MERGED'
            nJ := AScan( aDaneDo, { | aPoz | hb_HHasKey( aDaneOd[ 'RESULTS' ][ nI ], 'PROGRAM_ID' ) .AND. aPoz[ 'salprgid' ] == aDaneOd[ 'RESULTS' ][ nI ][ 'PROGRAM_ID' ] } )
            IF nJ > 0 .AND. tresc->( dbSeek( Str( aDaneDo[ nJ ][ 'id' ], 6 ) ) ) .AND. tresc->id == aDaneDo[ nJ ][ 'id' ] .AND. aDaneDo[ nJ ][ 'salprgid' ] <> AllTrim( tresc->salprgid )
               tresc->( BlokadaR() )
               tresc->salprgid := aDaneDo[ nJ ][ 'salprgid' ]
               tresc->( dbCommit() )
               tresc->( dbUnlock() )
            ENDIF
         ENDIF
      NEXT
   ENDIF

   tresc->( ordSetFocus( nPrevOrd ) )
   tresc->( dbGoto( nPrevRecNo ) )

   Komun( "Zakoäczono wysyˆanie tre˜ci" )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalRejVatWyslij( cRejestr )

   LOCAL aDaneDo := {}, aDaneOd, aRej, nI
   LOCAL nJ, nPrevOrd, nPrevRecNo, nANo

   nANo := Select( cRejestr )

   nPrevRecNo := ( nANo )->( RecNo() )
   ( nANo )->( dbGoTop() )
   ( nANo )->( dbSeek( "+" + ident_fir ) )
   DO WHILE ! ( nANo )->( Eof() ) .AND. ( nANo )->del == "+" .AND. ( nANo )->firma == ident_fir
      aTresc := { ;
         'id' => ( nANo )->id, ;
         'symb_rej' => ( nANo )->symb_rej, ;
         'opis' => AllTrim( ( nANo )->opis ), ;
         'nazwa' => iif( Upper( cRejestr ) == "KAT_ZAK", "KZ", "KS" ) + "-" + ( nANo )->symb_rej + " - " + AllTrim( ( nANo )->opis ), ;
         'salprgid' => iif( Empty( ( nANo )->salprgid ), SalRobID( iif( Upper( cRejestr ) == "KAT_ZAK", SAL_TYP_KATZ, SAL_TYP_KATS ), ( nANo )->id ), AllTrim( ( nANo )->salprgid ) ) }
      AAdd( aDaneDo, aTresc )
      ( nANo )->( dbSkip() )
   ENDDO

   aDaneOd := SalRegisterMerge( aDaneDo, SalCompanyProgramId )

   IF HB_ISHASH( aDaneOd ) .AND. hb_HHasKey( aDaneOd, 'RESULTS' ) .AND. Len( aDaneOd[ 'RESULTS' ] ) > 0
      nPrevOrd := ( nANo )->( ordSetFocus( 2 ) )
      FOR nI := 1 TO Len( aDaneOd[ 'RESULTS' ] )
         IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nI ], 'STATUS' ) .AND. AScan( { 'MERGED', 'CREATED' }, aDaneOd[ 'RESULTS' ][ nI ][ 'STATUS' ] ) > 0
            nJ := AScan( aDaneDo, { | aPoz | hb_HHasKey( aDaneOd[ 'RESULTS' ][ nI ], 'PROGRAM_ID' ) .AND. aPoz[ 'salprgid' ] == aDaneOd[ 'RESULTS' ][ nI ][ 'PROGRAM_ID' ] } )
            IF nJ > 0 .AND. ( nANo )->( dbSeek( Str( aDaneDo[ nJ ][ 'id' ], 6 ) ) ) .AND. ( nANo )->id == aDaneDo[ nJ ][ 'id' ] .AND. aDaneDo[ nJ ][ 'salprgid' ] <> AllTrim( ( nANo )->salprgid )
               ( nANo )->( BlokadaR() )
               ( nANo )->salprgid := aDaneDo[ nJ ][ 'salprgid' ]
               IF hb_HHasKey( aDaneOd[ 'RESULTS' ][ nI ], 'REGISTER_ID' )
                  ( nANo )->salsalid := aDaneOd[ 'RESULTS' ][ nI ][ 'REGISTER_ID' ]
               ENDIF
               ( nANo )->( dbCommit() )
               ( nANo )->( dbUnlock() )
            ENDIF
         ENDIF
      NEXT
   ENDIF

   ( nANo )->( ordSetFocus( nPrevOrd ) )
   ( nANo )->( dbGoto( nPrevRecNo ) )

   Komun( "Zakoäczono wysyˆanie rejestr¢w" )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalListaDokumentow( nDokTyp )

   LOCAL aRes
   LOCAL aDokTyp := { "SALDEO", "LAST_10_DAYS", "LAST_10_DAYS_OCRED" }

   aRes := SalDocumentList( SalCompanyProgramId, aDokTyp[ nDokTyp ] )

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION SalKontrahentAdres( aDane )

   LOCAL cRes := HGetDefault( aDane, 'STREET', '' )
   LOCAL cX

   cX := HGetDefault( aDane, 'POSTCODE', '' )
   IF cX <> ''
      IF cRes <> ''
         cRes := cRes + ', '
      ENDIF
      cRes := cRes + cX
   ENDIF

   cX := HGetDefault( aDane, 'CITY', '' )
   IF cX <> ''
      IF cRes <> ''
         cRes := cRes + ' '
      ENDIF
      cRes := cRes + cX
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DokZnajdzKontr( aDaneWej, cContractorID )

   LOCAL aDaneWyj, nI

   IF hb_HHasKey( aDaneWej, 'CONTRACTORS' )
      nI := AScan( aDaneWej[ 'CONTRACTORS' ], { | aPoz | aPoz[ 'CONTRACTOR_ID' ] == cContractorID } )
      IF nI > 0
         aDaneWyj := aDaneWej[ 'CONTRACTORS' ][ nI ]
      ENDIF
   ENDIF

   RETURN aDaneWyj

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DokTrans( aDaneWej )

   LOCAL aDane := {}, nI, aDokWej, aDokWyj, aKontrah

   FOR nI := 1 TO Len( aDaneWej[ 'DOCUMENTS' ] )
      aDokWej := aDaneWej[ 'DOCUMENTS' ][ nI ]
      aDokWyj := {=>}
      aKontrah := NIL
      IF hb_HHasKey( aDokWej, 'CONTRACTOR' )
         IF hb_HHasKey( aDokWej[ 'CONTRACTOR' ], 'CONTRACTOR_ID' )
            aDokWyj[ 'CONTRACTOR_ID' ] := aDokWej[ 'CONTRACTOR' ][ 'CONTRACTOR_ID' ]
            aKontrah := SalImp_DokZnajdzKontr( aDaneWej, aDokWej[ 'CONTRACTOR' ][ 'CONTRACTOR_ID' ] )
            IF HB_ISHASH( aKontrah )
               aDokWyj[ 'CONTRACTOR' ] := aKontrah
            ENDIF
         ENDIF
         IF hb_HHasKey( aDokWej[ 'CONTRACTOR' ], 'CONTRACTOR_PROGRAM_ID' )
            aDokWyj[ 'CONTRACTOR_PROGRAM_ID' ] := aDokWej[ 'CONTRACTOR' ][ 'CONTRACTOR_PROGRAM_ID' ]
         ENDIF
      ENDIF
      IF HB_ISHASH( aKontrah )
         aDokWyj[ 'CONTRACTOR_NAME' ] := HGetDefault( aKontrah, 'FULL_NAME', '' )
         aDokWyj[ 'CONTRACTOR_VAT_NUMBER' ] := HGetDefault( aKontrah, 'VAT_NUMBER', '' )
      ELSE
         aDokWyj[ 'CONTRACTOR_NAME' ] := ''
         aDokWyj[ 'CONTRACTOR_VAT_NUMBER' ] := ''
      ENDIF
      aDokWyj[ 'DOCUMENT_ID' ] := HGetDefault( aDokWej, 'DOCUMENT_ID', '' )
      aDokWyj[ 'NUMBER' ] := HGetDefault( aDokWej, 'NUMBER', '' )
      aDokWyj[ 'ISSUE_DATE' ] := sxml2date( HGetDefault( aDokWej, 'ISSUE_DATE', '' ) )
      aDokWyj[ 'SALE_DATE' ] := sxml2date( HGetDefault( aDokWej, 'SALE_DATE', '' ) )
      IF hb_HHasKey( aDokWej, 'DOCUMENT_TYPE' )
         aDokWyj[ 'DOCUMENT_TYPE' ] := HGetDefault( aDokWej, 'SHORT_NAME', '' )
      ELSE
         aDokWyj[ 'DOCUMENT_TYPE' ] := ''
      ENDIF
      aDokWyj[ 'DESCRIPTION' ] := HGetDefault( aDokWej, 'DESCRIPTION', '' )
      aDokWyj[ 'REGISTRY' ] := HGetDefault( aDokWej, 'REGISTRY', '' )
      aDokWyj[ 'FOLDER_MONTH' ] := HGetDefault( aDokWej[ 'FOLDER' ], 'MONTH', '' )
      aDokWyj[ 'FOLDER_YEAR' ] := HGetDefault( aDokWej[ 'FOLDER' ], 'YEAR', '' )
      aDokWyj[ 'SUM' ] := sxml2num( HGetDefault( aDokWej, 'SUM', '0' ) )
      aDokWyj[ 'NETTO_A' ] := 0
      aDokWyj[ 'VAT_A' ] := 0
      aDokWyj[ 'NETTO_B' ] := 0
      aDokWyj[ 'VAT_B' ] := 0
      aDokWyj[ 'NETTO_C' ] := 0
      aDokWyj[ 'VAT_C' ] := 0
      aDokWyj[ 'NETTO_D' ] := 0
      aDokWyj[ 'VAT_D' ] := 0
      aDokWyj[ 'NETTO_ZR' ] := 0
      aDokWyj[ 'NETTO_ZW' ] := 0
      aDokWyj[ 'NETTO_NP' ] := 0
      aDokWyj[ 'NETTO_OO' ] := 0
      IF hb_HHasKey( aDokWej, 'VAT_REGISTRIES' )
         AEval( aDokWej[ 'VAT_REGISTRIES' ], { | aPoz |
            DO CASE
            CASE aPoz[ 'RATE' ] == '23'
               aDokWyj[ 'NETTO_A' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
               aDokWyj[ 'VAT_A' ] +=  sxml2num( aPoz[ 'VAT' ], 0 )
            CASE aPoz[ 'RATE' ] == '8'
               aDokWyj[ 'NETTO_B' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
               aDokWyj[ 'VAT_B' ] +=  sxml2num( aPoz[ 'VAT' ], 0 )
            CASE aPoz[ 'RATE' ] == '5'
               aDokWyj[ 'NETTO_C' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
               aDokWyj[ 'VAT_C' ] +=  sxml2num( aPoz[ 'VAT' ], 0 )
            CASE aPoz[ 'RATE' ] == '7'
               aDokWyj[ 'NETTO_D' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
               aDokWyj[ 'VAT_D' ] +=  sxml2num( aPoz[ 'VAT' ], 0 )
            CASE aPoz[ 'RATE' ] == '0'
               aDokWyj[ 'NETTO_ZR' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
            CASE aPoz[ 'RATE' ] == 'ZW'
               aDokWyj[ 'NETTO_ZW' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
            CASE aPoz[ 'RATE' ] == 'NP'
               aDokWyj[ 'NETTO_NP' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
            CASE aPoz[ 'RATE' ] == 'OO'
               aDokWyj[ 'NETTO_OO' ] += sxml2num( aPoz[ 'NETTO' ], 0 )
            ENDCASE
         } )
      ENDIF
      AAdd( aDane, aDokWyj )
   NEXT

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DokRej( cSalRej, nRodzaj )

   LOCAL cRes, aRodzaje := { "KS-", "KZ-" }

   hb_default( @nRodzaj, 0 )

   IF Len( cSalRej ) >= 5 .AND. ( ( nRodzaj == 0 .AND. AScan( aRodzaje, SubStr( cSalRej, 1, 3 ) ) > 0 ) .OR. ( nRodzaj > 0 .AND. SubStr( cSalRej, 1, 3 ) == aRodzaje[ nRodzaj ] ) )
      cRes := SubStr( cSalRej, 4, 2 )
   ELSE
      cRes := '  '
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DodajKontrahent( aKontrahent )

   LOCAL nOrdIdx, cKraj

   IF HB_ISHASH( aKontrahent ) .AND. hb_HHasKey( aKontrahent, 'CONTRACTOR_ID' ) .AND. ! Empty( aKontrahent[ 'CONTRACTOR_ID' ] )
      nOrdIdx := kontr->( ordSetFocus( 4 ) )
      IF ! kontr->( dbSeek( "+" + ident_fir + aKontrahent[ 'CONTRACTOR_ID' ] ) )
         kontr->( dbAppend() )
         kontr->del := "+"
         kontr->firma := ident_fir
         kontr->nazwa := HGetDefault( aKontrahent, 'FULL_NAME', '' )
         kontr->adres := SalKontrahentAdres( aKontrahent )
         kontr->nr_ident := HGetDefault( aKontrahent, 'VAT_NUMBER', '' )
         cKraj := HGetDefault( aKontrahent, 'COUNTRY_ISO3166A2', 'PL' )
         kontr->kraj := cKraj
         IF cKraj <> 'PL'
            kontr->export := iif( KrajUE( cKraj ), 'N', 'T' )
            kontr->ue := iif( KrajUE( cKraj ), 'T', 'N' )
         ELSE
            kontr->export := 'N'
            kontr->ue := 'N'
         ENDIF
         kontr->zrodlo := "S"
         kontr->dataspr := Date()
         kontr->nazwaskr := HGetDefault( aKontrahent, 'SHORT_NAME', '' )
         kontr->kodpoczt := HGetDefault( aKontrahent, 'POSTCODE', '' )
         kontr->miasto := HGetDefault( aKontrahent, 'CITY', '' )
         kontr->ulica := HGetDefault( aKontrahent, 'STREET', '' )
         kontr->salsalid := aKontrahent[ 'CONTRACTOR_ID' ]
         kontr->( dbCommit() )
      ENDIF
      kontr->( ordSetFocus( nOrdIdx ) )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DekretujS( aDaneWej )

   LOCAL aDekret, nI, aDane, nC := 0
   LOCAL aJPKGTU := { "GTU_01", "GTU_02", "GTU_03", "GTU_04", "GTU_05", "GTU_06", ;
      "GTU_07", "GTU_08", "GTU_09", "GTU_10", "GTU_11", "GTU_12", "GTU_13" }
   LOCAL aJPKPrc := { "WSTO_EE", "IED", "TP", "TT_WNT", "TT_D", "MR_T", "MR_UZ", ;
      "I_42", "I_63", "B_SPV", "B_SPV_DOSTAWA", "B_MPV_PROWIZJA" }

   FOR nI := 1 TO Len( aDaneWej )
      aDane := aDaneWej[ nI ]
      aDane[ 'Aktywny' ] := aDane[ 'DOCUMENT_TYPE' ] == 'DS' .OR. aDane[ 'DOCUMENT_TYPE' ] == ''
      aDane[ 'Importuj' ] := aDane[ 'Aktywny' ] .AND. Val( aDane[ 'FOLDER_YEAR' ] ) == Val( param_rok ) .AND. Val( aDane[ 'FOLDER_MONTH' ] ) == Val( miesiac )
      aDekret := { => }
      IF aDane[ 'Aktywny' ]
         aDekret[ 'zsek_cv7' ] := '  '
         aDekret[ 'zdzien' ] := Str( Day( aDane[ 'ISSUE_DATE' ] ), 2 )
         aDekret[ 'zdatatran' ] := aDane[ 'ISSUE_DATE' ]
         aDekret[ 'znumer' ] := aDane[ 'NUMBER' ]
         aDekret[ 'zkraj' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'COUNTRY_ISO3166A2' ), aDane[ 'CONTRACTOR' ][ 'COUNTRY_ISO3166A2' ], 'PL' )
         aDekret[ 'zue' ] := iif( KrajUE( aDekret[ 'zkraj' ] ), 'T', 'N' )
         aDekret[ 'znr_ident' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'VAT_NUMBER' ), aDane[ 'CONTRACTOR' ][ 'VAT_NUMBER' ], '' )
         aDekret[ 'znazwa' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'FULL_NAME' ), aDane[ 'CONTRACTOR' ][ 'FULL_NAME' ], '' )
         aDekret[ 'zadres' ] := SalKontrahentAdres( aDane[ 'CONTRACTOR' ] )
         aDekret[ 'zdatas' ] := aDane[ 'SALE_DATE' ]
         aDekret[ 'zwartzw' ] := aDane[ 'NETTO_ZW' ]
         aDekret[ 'zexport' ] := 'N'
         IF aDekret[ 'zue' ] == 'N' .AND. aDekret[ 'zkraj' ] <> 'PL'
            aDekret[ 'zexport' ] := 'T'
         ENDIF
         aDekret[ 'zwart02' ] := aDane[ 'NETTO_C' ]
         aDekret[ 'zvat02' ] := aDane[ 'VAT_C' ]
         aDekret[ 'zwart07' ] := aDane[ 'NETTO_B' ]
         aDekret[ 'zvat07' ] := aDane[ 'VAT_B' ]
         aDekret[ 'zwart22' ] := aDane[ 'NETTO_A' ]
         aDekret[ 'zvat22' ] := aDane[ 'VAT_A' ]
         aDekret[ 'zwart08' ] := aDane[ 'NETTO_NP' ]
         aDekret[ 'zwart00' ] := aDane[ 'NETTO_ZR' ]
         aDekret[ 'zkorekta' ] := iif( hb_HHasKey( aDane, 'IS_CORRECTIVE' ) .AND. aDane[ 'IS_CORRECTIVE' ] == 'true', 'T', 'N' )
         aDekret[ 'KodWaluty' ] := 'PLN'
         aDekret[ 'VATMarza' ] := 0
         aDekret[ 'RodzDow' ] := ''
         aDekret[ 'Procedura' ] := ''
         aDekret[ 'Oznaczenie' ] := ''
         IF hb_HHasKey( aDane, 'JPK_CODES' )
            AEval( aDane[ 'JPK_CODES' ], { | aPoz |
               IF AScan( aJPKGTU, aPoz[ 'JPK_CODE' ] ) > 0
                  IF Len( aDekret[ 'Procedura' ] ) > 0
                     aDekret[ 'Procedura' ] += ','
                  ENDIF
                  aDekret[ 'Procedura' ] += aPoz[ 'JPK_CODE' ]
               ELSEIF AScan( aJPKPrc, aPoz[ 'JPK_CODE' ] )
                  IF Len( aDekret[ 'Oznaczenie' ] ) > 0
                     aDekret[ 'Oznaczenie' ] += ','
                  ENDIF
                  aDekret[ 'Oznaczenie' ] += aPoz[ 'JPK_CODE' ]
               ENDIF
            } )
         ENDIF
         aDekret[ 'zsymb_rej' ] := SalImp_DokRej( aDane[ 'REGISTRY' ], 1 )
         aDekret[ 'ztresc' ] := aDane[ 'DESCRIPTION' ]

         IF ! hb_HHasKey( aDane, 'CONTRACTOR_PROGRAM_ID' ) .AND. hb_HHasKey( aDane, 'CONTRACTOR' )
            aDekret[ 'Kontrahent' ] := aDane[ 'CONTRACTOR' ]
         ENDIF

         nC++
      ENDIF
      aDane[ 'Dekret' ] := aDekret
   NEXT

   RETURN nC

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DekretujZ( aDaneWej )

   LOCAL aDekret, nI, aDane, nC := 0, aDokTyp := { "FK", "T/M" }

   FOR nI := 1 TO Len( aDaneWej )
      aDane := aDaneWej[ nI ]
      aDane[ 'Aktywny' ] := AScan( aDokTyp, aDane[ 'DOCUMENT_TYPE' ] ) > 0 .OR. aDane[ 'DOCUMENT_TYPE' ] == ''
      aDane[ 'Importuj' ] := aDane[ 'Aktywny' ] .AND. Val( aDane[ 'FOLDER_YEAR' ] ) == Val( param_rok ) .AND. Val( aDane[ 'FOLDER_MONTH' ] ) == Val( miesiac )
      aDekret := { => }
      IF aDane[ 'Aktywny' ]
         aDekret[ 'zsek_cv7' ] := '  '
         aDekret[ 'zdzien' ] := Str( Day( aDane[ 'ISSUE_DATE' ] ), 2 )
         aDekret[ 'zdatatran' ] := aDane[ 'ISSUE_DATE' ]
         aDekret[ 'znumer' ] := aDane[ 'NUMBER' ]
         aDekret[ 'zkolumna' ] := '10'
         aDekret[ 'zkraj' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'COUNTRY_ISO3166A2' ), aDane[ 'CONTRACTOR' ][ 'COUNTRY_ISO3166A2' ], 'PL' )
         aDekret[ 'zue' ] := iif( KrajUE( aDekret[ 'zkraj' ] ), 'T', 'N' )
         aDekret[ 'znr_ident' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'VAT_NUMBER' ), aDane[ 'CONTRACTOR' ][ 'VAT_NUMBER' ], '' )
         aDekret[ 'znazwa' ] := iif( hb_HHasKey( aDane, 'CONTRACTOR' ) .AND. hb_HHasKey( aDane[ 'CONTRACTOR' ], 'FULL_NAME' ), aDane[ 'CONTRACTOR' ][ 'FULL_NAME' ], '' )
         aDekret[ 'zadres' ] := SalKontrahentAdres( aDane[ 'CONTRACTOR' ] )
         aDekret[ 'zdatas' ] := aDane[ 'SALE_DATE' ]
         aDekret[ 'zwartzw' ] := aDane[ 'NETTO_ZW' ]
         aDekret[ 'zexport' ] := 'N'
         IF aDekret[ 'zue' ] == 'N' .AND. aDekret[ 'zkraj' ] <> 'PL'
            aDekret[ 'zexport' ] := 'T'
         ENDIF
         aDekret[ 'zwart02' ] := aDane[ 'NETTO_C' ]
         aDekret[ 'zvat02' ] := aDane[ 'VAT_C' ]
         aDekret[ 'zwart07' ] := aDane[ 'NETTO_B' ]
         aDekret[ 'zvat07' ] := aDane[ 'VAT_B' ]
         aDekret[ 'zwart22' ] := aDane[ 'NETTO_A' ]
         aDekret[ 'zvat22' ] := aDane[ 'VAT_A' ]
         aDekret[ 'zwart08' ] := aDane[ 'NETTO_NP' ]
         aDekret[ 'zwart00' ] := aDane[ 'NETTO_ZR' ]
         aDekret[ 'zkorekta' ] := iif( hb_HHasKey( aDane, 'IS_CORRECTIVE' ) .AND. aDane[ 'IS_CORRECTIVE' ] == 'true', 'T', 'N' )
         aDekret[ 'KodWaluty' ] := 'PLN'
         aDekret[ 'VATMarza' ] := 0
         aDekret[ 'RodzDow' ] := ''
         aDekret[ 'Procedura' ] := ''
         aDekret[ 'Oznaczenie' ] := ''
         aDekret[ 'zsymb_rej' ] := SalImp_DokRej( aDane[ 'REGISTRY' ], 2 )
         aDekret[ 'ztresc' ] := aDane[ 'DESCRIPTION' ]
         aDekret[ 'SierTrwaly' ] := .F.
         aDekret[ 'UwagaVat' ] := .F.

         IF ! hb_HHasKey( aDane, 'CONTRACTOR_PROGRAM_ID' ) .AND. hb_HHasKey( aDane, 'CONTRACTOR' )
            aDekret[ 'Kontrahent' ] := aDane[ 'CONTRACTOR' ]
         ENDIF

         nC++
      ENDIF
      aDane[ 'Dekret' ] := aDekret
   NEXT

   RETURN nC

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DokPodglad( aDane )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "Folder", "NIP", "Nazwa", "Nr dowodu", "Data wyst.", ;
      "Data sprz.", "Rej", "Og¢lna wart.", "Netto A", "VAT A", "Netto B", "VAT B", ;
      "Netto C", "VAT C", "Netto D", "VAT D", "Netto 0%", "Netto ZW", "Netto NP", ;
      "Opis zdarzenia gospodarczego" }
   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ 'Importuj' ], "TAK", "NIE" ) }, ;
      { || PadC( aDane[ nElem ][ 'FOLDER_MONTH' ] + "/" + aDane[ nElem ][ 'FOLDER_YEAR' ], 8 ) }, ;
      { || PadR( aDane[ nElem ][ 'CONTRACTOR_VAT_NUMBER' ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ 'CONTRACTOR_NAME' ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ 'NUMBER' ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ 'ISSUE_DATE' ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ 'SALE_DATE' ], 10 ) }, ;
      { || PadR( SalImp_DokRej( aDane[ nElem ][ 'REGISTRY' ] ), 2 ) }, ;
      { || Transform( aDane[ nElem ][ "SUM" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_A" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "VAT_A" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_B" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "VAT_B" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_C" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "VAT_C" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_D" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "VAT_D" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_ZR" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_ZW" ], RPICE ) }, ;
      { || Transform( aDane[ nElem ][ "NETTO_NP" ], RPICE ) }, ;
      { || PadR( aDane[ nElem ][ 'DESCRIPTION' ], 40 ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}

   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalImp_DokIlosc( aDane )

   LOCAL nI := 0

   AEval( aDane, { | aPoz |
      IF aPoz[ 'Importuj' ]
         nI++
      ENDIF
   } )

   RETURN nI

/*----------------------------------------------------------------------*/

FUNCTION SalImp_VatS_Importuj( aDane )

   LOCAL nI := 1, nIlosc := SalImp_DokIlosc( aDane[ 'Dokumenty' ] )
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import sprzeda¾y", 48 )

   AEval( aDane[ 'Dokumenty' ], { | aPozD |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := aPozD[ 'Importuj' ]
      LOCAL aPoz

      IF lImportuj
         aPoz := aPozD[ 'Dekret' ]

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         IF aDane[ 'DataRej' ] == 'W'
            zDZIEN := aPoz[ 'zdzien' ]
         ELSE
            zDZIEN := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         ENDIF
         znazwa := PadR( aPoz[ 'znazwa' ], 100 )
         zNR_IDENT := PadR( aPoz[ 'znr_ident' ], 30 )
         zNUMER := PadR( JPKImp_NrDokumentu( aPoz[ 'znumer' ] ), 100 )
         zADRES := PadR( aPoz[ 'zadres' ], 100 )
         zTRESC := PadR( iif( ! Empty( aPoz[ 'ztresc' ] ), aPoz[ 'ztresc' ], aDane[ 'OpisZd' ] ), 30 )
         zROKS := Str( Year( aPoz[ 'zdatas' ] ), 4 )
         zMCS := Str( Month( aPoz[ 'zdatas' ] ), 2 )
         zDZIENS := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         zDATAS := aPoz[ 'zdatas' ]
         zDATATRAN := aPoz[ 'zdatatran' ]
         zKOLUMNA := aDane[ 'KolRej' ]
         zuwagi := Space( 20 )
         zWARTZW := aPoz[ 'zwartzw' ]
         zWART08 := aPoz[ 'zwart08' ]
         zWART00 := aPoz[ 'zwart00' ]
         zWART02 := aPoz[ 'zwart02' ]
         zVAT02 := aPoz[ 'zvat02' ]
         zWART07 := aPoz[ 'zwart07' ]
         zVAT07 := aPoz[ 'zvat07' ]
         zWART22 := aPoz[ 'zwart22' ]
         zVAT22 := aPoz[ 'zvat22' ]
         zWART12 := 0
         zVAT12 := 0
         zBRUTZW := zWartZw
         zBRUT08 := zWart08
         zBRUT00 := zWart00
         zBRUT02 := zWart02 + zVat02
         zBRUT07 := zWart07 + zVat07
         zBRUT22 := zWart22 + zVat22
         zBRUT12 := zWart12 + zVat12
         zRODZDOW := iif( AllTrim( aPoz[ 'RodzDow' ] ) <> "", aPoz[ 'RodzDow' ], aDane[ 'RodzDow' ] )
         zVATMARZA := HGetDefault( aPoz, 'VATMarza', 0 )
         IF AllTrim( zRODZDOW ) <> "FP"
            IF zVATMARZA > 0
               zNETTO := _round( zVATMARZA - ( zVat02 + zVat07 + zVat22 + zVat12 ), 2 )
            ELSE
               zNETTO := _round( zWARTZW + zWART08 + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
            ENDIF
         ELSE
            zNETTO := 0
         ENDIF
         zExPORT := aPoz[ 'zexport' ]
         IF aPoz[ 'zue' ] == 'T' .AND. aDane[ 'Export' ] == 'T'
            zExPORT := 'T'
         ENDIF
         zUE := aPoz[ 'zue' ]
         zKRAJ := aPoz[ 'zkraj' ]
         zSEK_CV7 := aPoz[ 'zsek_cv7' ]
         zRACH := 'F'
         zDETAL := DETALISTA
         zKOREKTA :=  HGetDefault( aPoz, 'zkorekta', iif( zNETTO < 0, 'T', 'N' ) )
         zROZRZAPS := iif( AllTrim( pzROZRZAPS ) == "", "N", pzROZRZAPS )
         zZAP_TER := 0
         zZAP_DAT := date()
         zZAP_WART := 0
         zTROJSTR := 'N'
         zSYMB_REJ := iif( ! Empty( aPoz[ 'zsymb_rej' ] ), aPoz[ 'zsymb_rej' ], aDane[ 'Rejestr' ] )
         zOPCJE := iif( AllTrim( aPoz[ 'Oznaczenie' ] ) <> "", aPoz[ 'Oznaczenie' ], aDane[ 'Oznaczenie' ] )
         zPROCEDUR := iif( AllTrim( aPoz[ 'Procedura' ] ) <> "", aPoz[ 'Procedura' ], aDane[ 'Procedura' ] )
         zKOL36 := 0
         zKOL37 := 0
         zKOL38 := 0
         zKOL39 := 0
         zNETTO2 := 0
         zKOLUMNA2 := '  '
         zDATA_ZAP := CToD('')

         IF hb_HHasKey( aPoz, 'Kontrahent' )
            SalImp_DodajKontrahent( aPoz[ 'Kontrahent' ] )
         ENDIF

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'REJS', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            KRejS_Ksieguj()
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

FUNCTION SalImp_VatZ_Importuj( aDane )

   LOCAL nI := 1, nIlosc := SalImp_DokIlosc( aDane[ 'Dokumenty' ] )
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import zakup¢w", 48 )

   AEval( aDane[ 'Dokumenty' ], { | aPozD |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := aPozD[ 'Importuj' ]
      LOCAL aPoz

      IF lImportuj
         aPoz := aPozD[ 'Dekret' ]

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         IF aDane[ 'DataRej' ] == 'W'
            zDZIEN := aPoz[ 'zdzien' ]
         ELSE
            zDZIEN := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         ENDIF
         znazwa := PadR( aPoz[ 'znazwa' ], 100 )
         zNR_IDENT := PadR( aPoz[ 'znr_ident' ], 30 )
         zNUMER := PadR( JPKImp_NrDokumentu( aPoz[ 'znumer' ] ), 100 )
         zADRES := PadR( aPoz[ 'zadres' ], 100 )
         zTRESC := PadR( iif( ! Empty( aPoz[ 'ztresc' ] ), aPoz[ 'ztresc' ], aDane[ 'OpisZd' ] ), 30 )
         zROKS := Str( Year( aPoz[ 'zdatas' ] ), 4 )
         zMCS := Str( Month( aPoz[ 'zdatas' ] ), 2 )
         zDZIENS := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         zDATAS := aPoz[ 'zdatas' ]
         zDATAKS := zDATAS
         zDATATRAN := aPoz[ 'zdatatran' ]
         zKOLUMNA := '10'
         zuwagi := Space( 20 )
         zWARTZW := aPoz[ 'zwartzw' ]
         zWART08 := aPoz[ 'zwart08' ]
         zWART00 := aPoz[ 'zwart00' ]
         zWART02 := aPoz[ 'zwart02' ]
         zVAT02 := aPoz[ 'zvat02' ]
         zWART07 := aPoz[ 'zwart07' ]
         zVAT07 := aPoz[ 'zvat07' ]
         zWART22 := aPoz[ 'zwart22' ]
         zVAT22 := aPoz[ 'zvat22' ]
         zWART12 := 0
         zVAT12 := 0
         zBRUTZW := zWartZw
         zBRUT08 := zWart08
         zBRUT00 := zWart00
         zBRUT02 := zWart02 + zVat02
         zBRUT07 := zWart07 + zVat07
         zBRUT22 := zWart22 + zVat22
         zBRUT12 := zWart12 + zVat12
         zExPORT := aPoz[ 'zexport' ]
         zNETTO := _round( zWARTZW + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
         zExPORT := aPoz[ 'zexport' ]
         zUE := aPoz[ 'zue' ]
         zKRAJ := aPoz[ 'zkraj' ]
         zSEK_CV7 := aPoz[ 'zsek_cv7' ]
         zRACH := 'F'
         zDETAL := DETALISTA
         zKOREKTA :=  HGetDefault( aPoz, 'zkorekta', iif( zNETTO < 0, 'T', 'N' ) )
         zROZRZAPZ := iif( AllTrim( pzROZRZAPZ ) == "", "N", pzROZRZAPZ )
         zZAP_TER := 0
         zZAP_DAT := date()
         zZAP_WART := 0
         zTROJSTR := 'N'
         zSYMB_REJ := iif( ! Empty( aPoz[ 'zsymb_rej' ] ), aPoz[ 'zsymb_rej' ], aDane[ 'Rejestr' ] )
         zNETTO2 := 0
         zKOLUMNA2 := '  '
         zDATA_ZAP := CToD('')
         zUSLUGAUE := 'N'
         zWEWDOS := 'N'
         zPALIWA := 0
         zPOJAZDY := 0
         IF aPoz[ 'SierTrwaly' ]
            zSP22 := 'S'
            zSP12 := 'S'
            zSP07 := 'S'
            zSP02 := 'S'
            zSP00 := 'S'
            zSPZW := 'S'
         ELSE
            zSP22 := 'P'
            zSP12 := 'P'
            zSP07 := 'P'
            zSP02 := 'P'
            zSP00 := 'P'
            zSPZW := 'P'
         ENDIF
         zZOM22 := 'O'
         zZOM00 := 'O'
         zZOM12 := 'O'
         zZOM07 := 'O'
         zZOM02 := 'O'
         zOPCJE := " "

         zKOL47 := 0
         zKOL48 := 0
         zKOL49 := 0
         zKOL50 := 0

         zNETTO2 := 0
         zKOLUMNA2 := '  '

         zRODZDOW := HGetDefault( aPoz, 'RodzDow', '' )
         zVATMARZA := HGetDefault( aPoz, 'VATMarza', 0 )

         IF hb_HHasKey( aPoz, 'Kontrahent' )
            SalImp_DodajKontrahent( aPoz[ 'Kontrahent' ] )
         ENDIF

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'REJZ', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            KRejZ_Ksieguj()
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

FUNCTION SalImp_VatS( nDokTyp )

   LOCAL aDane := hb_Hash( 'ZezwolNaDuplikaty', 'N', 'Rejestr', '  ', ;
      'OpisZd', Space( 30 ), 'KolRej', iif( zRYCZALT == 'T', ' 5', '7' ), ;
      'DataRej', 'W', 'Oznaczenie', Space( 16 ), 'Procedura', Space( 32 ), ;
      'SprawdzRegon', iif( olparam_ra, 'T', 'N' ), 'RodzDow', Space( 6 ), ;
      'Export', 'N' )
   LOCAL cPlik
   LOCAL cKolor
   LOCAL cEkran := SaveScreen()
   LOCAL nMenu, cEkran2
   LOCAL aRaport, cRaport, cTN, cRej, lOk, cKolKs, cDataRej, cRegon, cExport
   LOCAL nSumaImp, nLiczbaLp := 0
   LOCAL bKolRyczW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( Tab_RyczInfo(), 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bKolRyczV := { | |
      LOCAL cKolor := ColStd()
      @ 24, 0
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL aDaneDok := SalListaDokumentow( nDokTyp )
   LOCAL aDanePrz
   PRIVATE cOpisZd, zOpcje, zProcedur, zRodzDow

   IF HB_ISHASH( aDaneDok ) .AND. hb_HHasKey( aDaneDok, 'DOCUMENTS' ) .AND. HB_ISARRAY( aDaneDok[ 'DOCUMENTS' ] ) .AND. Len( aDaneDok[ 'DOCUMENTS' ] ) > 0
      aDanePrz := SalImp_DokTrans( aDaneDok )
      IF SalImp_DekretujS( @aDanePrz ) > 0

         aDane[ 'Dokumenty' ] := aDanePrz

         ColStd()
         @ 24,  0
         @ 12,  0 CLEAR TO 19, 79
         @ 12,  2 TO 19, 77 DOUBLE

         @ 13,  3 SAY PadC( "IMPORT SPRZEDA½Y Z SALDEOSMART", 72 )
         PrintTextEx( 15, 4, " Liczba pozycji sprzeda¾y: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ) )
         PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ), 72 ) )

         nMenu := 1
         DO WHILE nMenu != 0
            @ 18,  4 PROMPT "[ Wykonaj import ]"
            @ 18, 26 PROMPT "[ Podgl¥d zawarto˜ci ]"
            @ 18, 52 PROMPT "[ Opcje ]"
            @ 18, 65 PROMPT "[ Anuluj ]"
            MENU TO nMenu

            DO CASE
            CASE nMenu == 1
               IF TNEsc( , "Czy wykona† import danych sprzeda¾y? ( T / N )" )

                  aRaport := SalImp_VatS_Importuj( aDane )

                  cRaport := "IMPORT ZAKOãCZONY" + hb_eol()
                  cRaport += "-----------------" + hb_eol()
                  cRaport += hb_eol()
                  cRaport += "Liczba zaimportowanych pozycji: " + AllTrim( Str( aRaport[ 'Zaimportowano' ] ) ) + hb_eol()
                  cRaport += "Liczba pomini©tych dokument¢w: " + AllTrim( Str( aRaport[ 'Pominieto' ] ) ) + hb_eol()
                  cRaport += "Liczba dokument¢w w obej walucie: " + AllTrim( Str( aRaport[ 'Waluta' ] ) ) + hb_eol()
                  IF aRaport[ 'Pominieto' ] > 0
                     cRaport += hb_eol()
                     cRaport += "POMINI¨TE DOKUMENTY" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaPom' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Waluta' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY W OBCEJ WALUCIE" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaWal' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF

                  WyswietlTekst( cRaport )

                  nMenu := 0
               ENDIF
            CASE nMenu == 2

               SalImp_DokPodglad( @aDane[ 'Dokumenty' ] )
               PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ), 72 ) )

            CASE nMenu == 3
               cEkran2 := SaveScreen()
               cTN := aDane[ 'ZezwolNaDuplikaty' ]
               cRej := aDane[ 'Rejestr' ]
               cOpisZd := aDane[ 'OpisZd' ]
               cKolRej := aDane[ 'KolRej' ]
               cDataRej := aDane[ 'DataRej' ]
               zOpcje := aDane[ 'Oznaczenie' ]
               zProcedur := aDane[ 'Procedura' ]
               cRegon := aDane[ 'SprawdzRegon' ]
               zRodzDow := aDane[ 'RodzDow' ]
               cExport := aDane[ 'Export' ]
               @  6, 13 CLEAR TO 21, 67
               @  7, 15 TO 20, 65
               @  8, 17 SAY "Zezw¢l na import dokument¢w z istniej¥cym nr" GET cTN PICTURE "!" VALID ValidTakNie( cTN, 8, 63 )
               @  9, 17 SAY "Domy˜lny symbol rejestru" GET cRej PICTURE "!!" VALID { || Kat_Rej_Wybierz( @cRej, 9, 42 ), .T. }
               @ 10, 17 SAY "Opis zdarzenia" GET cOpisZd VALID JPKImp_VatS_Tresc_V( "S" )
               IF zRYCZALT == 'T'
                  @ 11, 17 SAY "Domy˜lna kol. ewid. (5,6,7,8,9,10,11,12,13)" GET cKolRej PICTURE '@K 99' WHEN Eval( bKolRyczW ) VALID ( AllTrim( cKolRej ) $ '56789' .OR. cKolRej == '10' .OR. cKolRej == '11' .OR. cKolRej == '12' .OR. cKolRej == '13' ) .AND. Eval( bKolRyczV )
               ELSE
                  @ 11, 17 SAY "Domy˜lna kolumna ksi©gi (7,8)" GET cKolRej PICTURE "9" VALID cKolRej $ '78'
               ENDIF
               @ 12, 17 SAY "Do rejestru na dzieä (S-sprzed., W-wystaw.)" GET cDataRej PICTURE "!" VALID cDataRej $ 'SW'
               @ 13, 17 SAY "Oznaczenie dot. dostawy i ˜wiadczenia usˆug" GET zOpcje PICTURE '!!' WHEN KRejSWhOpcje() VALID KRejSVaOpcje()
               @ 14, 17 SAY "Oznaczenia dot. procedur" GET zProcedur PICTURE '!!!!!!!!!!!!!!!' WHEN KRejSWhProcedur() VALID KRejSVaProcedur()
               @ 15, 17 SAY "Rodzaj dowodu sprzeda¾y" GET zRodzDow PICTURE '!!!' WHEN KRejSWRodzDow() VALID KRejSVRodzDow()
               //@ 16, 17 SAY "Pobieraj dane kontrahenta z bazy REGON" GET cRegon PICTURE '!' WHEN olparam_ra VALID ValidTakNie( cRegon, 16, 57 )
               @ 16, 17 SAY "Oznacz kraje UE jako eksport" GET cExport PICTURE '!' VALID ValidTakNie( cExport, 16, 47 )
               @ 19, 52 GET lOk PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
               ValidTakNie( cTN, 8, 63 )
               //ValidTakNie( cRegon, 16, 57 )
               ValidTakNie( cExport, 16, 47 )
               READ
               IF LastKey() <> K_ESC
                  aDane[ 'ZezwolNaDuplikaty' ] := cTN
                  aDane[ 'Rejestr' ] := cRej
                  aDane[ 'OpisZd' ] := cOpisZd
                  aDane[ 'KolRej' ] := cKolRej
                  aDane[ 'DataRej' ] := cDataRej
                  aDane[ 'Oznaczenie' ] := zOpcje
                  aDane[ 'Procedura' ] := zProcedur
                  aDane[ 'SprawdzRegon' ] := cRegon
                  aDane[ 'RodzDow' ] := zRodzDow
                  aDane[ 'Export' ] := cExport
               ENDIF
               RestScreen( , , , , cEkran2 )
            CASE nMenu == 4
               nMenu := 0
            ENDCASE

         ENDDO

      ELSE
         Komun( "Brak danych do importu" )
      ENDIF
   ELSE
      Komun( "Brak danych do importu" )
   ENDIF

   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION SalImp_VatZ( nDokTyp )

   LOCAL aDane := hb_Hash( 'ZezwolNaDuplikaty', 'N', 'Rejestr', '  ', ;
      'OpisZd', Space( 30 ), 'DomVat', 1, 'DataRej', 'W', ;
      'SprawdzRegon', iif( olparam_ra, 'T', 'N' ) )
   LOCAL cEkran := SaveScreen()
   LOCAL nMenu, cEkran2
   LOCAL aRaport, cRaport, cTN, cRej, lOk, nDomVat, cDataRej, cRegon
   LOCAL aDanePrz
   LOCAL aDaneDok := SalListaDokumentow( nDokTyp )

   PRIVATE cOpisZd

   IF HB_ISHASH( aDaneDok ) .AND. hb_HHasKey( aDaneDok, 'DOCUMENTS' ) .AND. HB_ISARRAY( aDaneDok[ 'DOCUMENTS' ] ) .AND. Len( aDaneDok[ 'DOCUMENTS' ] ) > 0
      aDanePrz := SalImp_DokTrans( aDaneDok )
      IF SalImp_DekretujZ( @aDanePrz ) > 0

         aDane[ 'Dokumenty' ] := aDanePrz

         ColStd()
         @ 24,  0
         @ 12,  0 CLEAR TO 19, 79
         @ 12,  2 TO 19, 77 DOUBLE

         @ 13,  3 SAY PadC( "IMPORT ZAKUPàW Z SALDEOSMART", 72 )
         PrintTextEx( 15, 4, " Liczba pozycji zakup¢w: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ) )
         PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ), 72 ) )

         nMenu := 1
         DO WHILE nMenu != 0
            @ 18,  4 PROMPT "[ Wykonaj import ]"
            @ 18, 26 PROMPT "[ Podgl¥d zawarto˜ci ]"
            @ 18, 52 PROMPT "[ Opcje ]"
            @ 18, 65 PROMPT "[ Anuluj ]"
            MENU TO nMenu

            DO CASE
            CASE nMenu == 1
               IF TNEsc( , "Czy wykona† import danych zakup¢w? ( T / N )" )

                  aRaport := SalImp_VatZ_Importuj( aDane )

                  cRaport := "IMPORT ZAKOãCZONY" + hb_eol()
                  cRaport += "-----------------" + hb_eol()
                  cRaport += hb_eol()
                  cRaport += "Liczba zaimportowanych pozycji: " + AllTrim( Str( aRaport[ 'Zaimportowano' ] ) ) + hb_eol()
                  cRaport += "Liczba pomini©tych dokument¢w: " + AllTrim( Str( aRaport[ 'Pominieto' ] ) ) + hb_eol()
                  cRaport += "Liczba dokument¢w w obej walucie: " + AllTrim( Str( aRaport[ 'Waluta' ] ) ) + hb_eol()
                  IF aRaport[ 'Pominieto' ] > 0
                     cRaport += hb_eol()
                     cRaport += "POMINI¨TE DOKUMENTY" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaPom' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Waluta' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY W OBCEJ WALUCIE" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaWal' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF

                  WyswietlTekst( cRaport )

                  nMenu := 0
               ENDIF
            CASE nMenu == 2

               SalImp_DokPodglad( @aDane[ 'Dokumenty' ] )
               PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( SalImp_DokIlosc( aDanePrz ) ) ), 72 ) )

            CASE nMenu == 3
               cEkran2 := SaveScreen()
               cTN := aDane[ 'ZezwolNaDuplikaty' ]
               cRej := aDane[ 'Rejestr' ]
               cOpisZd := aDane[ 'OpisZd' ]
               nDomVat := aDane[ 'DomVat' ]
               cDataRej := aDane[ 'DataRej' ]
               cRegon := aDane[ 'SprawdzRegon' ]
               @  9, 13 CLEAR TO 20, 66
               @ 10, 15 TO 19, 64
               @ 11, 17 SAY "Zezw¢l na import dokument¢w z istniej¥cym nr" GET cTN PICTURE "!" VALID cTN$"TN"
               @ 12, 17 SAY "Domy˜lny symbol rejestru" GET cRej PICTURE "!!" VALID { || Kat_Rej_Wybierz( @cRej, 12, 42, 'Z' ), .T. }
               @ 13, 17 SAY "Opis zdarzenia" GET cOpisZd VALID JPKImp_VatS_Tresc_V( "Z" )
               @ 14, 17 SAY "Domy˜lna stawka VAT"
               @ 14, 37, 20, 41 GET nDomVat LISTBOX { { "23%", 1 }, { "8% ", 2 }, { "5% ", 3 }, { "0% ", 4 } } DROPDOWN
               @ 15, 17 SAY "Do rejestru na dzieä (Z-zakupu, W-wystaw.)" GET cDataRej VALID cDataRej $ "WZ"
               //@ 16, 17 SAY "Pobieraj dane kontrahenta z bazy REGON" GET cRegon PICTURE '!' WHEN olparam_ra VALID cRegon $ 'TN'
               @ 18, 52 GET lOk PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
               READ
               IF LastKey() <> K_ESC
                  aDane[ 'ZezwolNaDuplikaty' ] := cTN
                  aDane[ 'Rejestr' ] := cRej
                  aDane[ 'OpisZd' ] := cOpisZd
                  aDane[ 'DomVat' ] := nDomVat
                  aDane[ 'DataRej' ] := cDataRej
                  aDane[ 'SprawdzRegon' ] := cRegon
               ENDIF
               RestScreen( , , , , cEkran2 )
            CASE nMenu == 4
               nMenu := 0
            ENDCASE

         ENDDO

      ELSE
         Komun( "Brak danych do importu" )
      ENDIF

   ELSE
      Komun( "Brak danych do importu" )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

