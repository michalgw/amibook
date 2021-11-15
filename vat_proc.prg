/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

#include "box.ch"
#include "inkey.ch"

PROCEDURE VAT_Zalaczniki( aDane )

   LOCAL lBORDZU, lBVATZZ, lBKoniec

   ColStd()
   @ 17, 16 CLEAR TO 22, 79
   @ 17, 16, 22, 79 BOX B_DOUBLE
   @ 18, 18 GET aDane[ 'ORDZU' ][ 'rob' ] CHECKBOX CAPTION 'Uzasadnienie przyczyn korekty (ORD-ZU)' WHEN aDane[ 'Korekta' ] STYLE '[X ]'
   @ 18, 61 GET lBORDZU  PUSHBUTTON CAPTION ' Edytuj ORD-ZU ' WHEN aDane[ 'ORDZU' ][ 'rob' ] STATE { || VAT_ORD_ZU( aDane ) }
   @ 19, 18 GET aDane[ 'VATZZ' ][ 'rob' ] CHECKBOX CAPTION 'Wniosek o zwrot podatku VAT   (VAT-ZZ)' STYLE '[X ]'
   @ 19, 61 GET lBVATZZ  PUSHBUTTON CAPTION ' Edytuj VAT-ZZ ' WHEN aDane[ 'VATZZ' ][ 'rob' ] STATE { || VAT_ZZ_Edycja( aDane ) }
   @ 21, 67 GET lBKoniec PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
   Read_()

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Zalaczniki19( aDane )

   LOCAL lBORDZU, lBVATZZ, lBKoniec

   ColStd()
   @ 17, 16 CLEAR TO 22, 79
   @ 17, 16, 22, 79 BOX B_DOUBLE
   @ 18, 18 GET aDane[ 'ORDZU' ][ 'rob' ] CHECKBOX CAPTION 'Uzasadnienie przyczyn korekty (ORD-ZU)' STYLE '[X ]'
   @ 18, 61 GET lBORDZU  PUSHBUTTON CAPTION ' Edytuj ORD-ZU ' WHEN aDane[ 'ORDZU' ][ 'rob' ] STATE { || VAT_ORD_ZU( aDane ) }
   IF zVATFORDR <> '8 '
      @ 19, 18 GET aDane[ 'VATZD' ][ 'rob' ] CHECKBOX CAPTION 'Zawiadomienie o skoryg. podat.(VAT-ZD)' STYLE '[X ]'
      @ 19, 61 GET lBVATZZ  PUSHBUTTON CAPTION ' Edytuj VAT-ZD ' WHEN aDane[ 'VATZD' ][ 'rob' ] STATE { || VAT_ZD_Edycja( aDane ) }
   ENDIF
   @ 21, 67 GET lBKoniec PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
   Read_()

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_ZZ_Edycja( aDane )

   LOCAL nP_8 := aDane[ 'VATZZ' ][ 'P_8' ] + 1
   LOCAL nP_9 := aDane[ 'VATZZ' ][ 'P_9' ]
   LOCAL nP_10 := aDane[ 'VATZZ' ][ 'P_10' ]
   LOCAL cScr := SaveScreen(), cKolor
   LOCAL GetList := {}
   LOCAL aPowody := { ;
      { 'WIBIERZ (1-4)', 0 }, ;
      { '1.pod.dokonywaˆ dost.tow. lub usˆ.poza terytorium bez sprzeda¾y opodatkowanej', 1 }, ;
      { '2.pod.nie dokonywaˆ czynno˜ci opod.na terenie kraju oraz w art.86 ust.8 pkt 1', 2 }, ;
      { '3.pod.dokonywaˆ importu towar¢w lub usˆug finansowanych z pomocy zagranicznej', 3 }, ;
      { '4.w innych przypadkach ni¾ wymienione w pkt 1 - 3', 4 } }

   cKolor := ColStd()
   @  3,  0 CLEAR TO 22, 79
   @  3,  0, 22, 79 BOX B_DOUBLE
   @  4,  2 SAY 'Pow¢d zwrotu (1-4)'
   @  5,  2, 12, 77 GET nP_8 LISTBOX aPowody VALID nP_8 > 1 DROPDOWN SCROLLBAR
   @  6,  1,  6, 78 BOX B_SINGLE
   @  7,  2 SAY 'Wnioskowana kwota zwrotu:   ' GET nP_9 PICTURE RPic
   @  8,  1,  8, 78 BOX B_SINGLE
   @  9,  1, 21, 78 BOX B_SINGLE
   @  9,  4 SAY 'Uzasadnienie zˆo¾enia wniosku'

   SetColor( hb_ColorIndex( ColStd(), 4 ) )
   MemoEdit( nP_10, 10, 2, 20, 77, .F., .F. )

   ColStd()
   Read_( GetList )
   IF LastKey() != K_ESC

      aDane[ 'VATZZ' ][ 'P_8' ] := nP_8 - 1
      aDane[ 'VATZZ' ][ 'P_9' ] := nP_9

      @ 24, 0 SAY PadC( 'ALT-W - Zarwierd«        ESC - Anuluj', 80 )
      SetColor( hb_ColorIndex( ColStd(), 1 ) )
      nP_10 := MemoEdit( nP_10, 10, 2, 20, 77 )
      aDane[ 'VATZZ' ][ 'P_10' ] := nP_10
      @ 24, 0
   ENDIF

   SetColor( cKolor )
   RestScreen( , , , , cScr )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_ZD_Edycja( aDane )

   LOCAL cEkran, aKolumny

   cEkran := SaveScreen( 0, 0, MaxRow(), MaxCol() )

   DO WHILE ! DostepPro( 'VAT7ZD', 'VAT7ZD' )
   ENDDO

   vat7zd->( dbSetFilter( { || vat7zd->del == "+" .AND. vat7zd->firma == aDane[ 'Firma' ] .AND. vat7zd->mc == aDane[ 'Miesiac' ] }, ;
      "vat7zd->del == '+' .AND. vat7zd->firma == aDane[ 'Firma' ] .AND. vat7zd->mc == aDane[ 'Miesiac' ]" ) )
   vat7zd->( dbGoTop() )

   GMBrowse( { ;
      { 'field' => 'NIP', 'caption' => 'Nr ident. podatk.', 'width' => 14, 'picture' => '@S30 !!!!!!!!!!!!!!' }, ;
      { 'field' => 'NAZWA', 'caption' => 'Nazwa kontrahenta', 'width' => 60, 'picture' => '@S100 ' + Replicate( '!', 60 ) }, ;
      { 'field' => 'NR_DOK', 'caption' => 'Numer dokumentu', 'width' => 20, 'picture' => '@S40 ' + Replicate( '!', 20 ) }, ;
      { 'field' => 'DATA_WYST', 'caption' => 'Data wyst.', 'width' => 10 }, ;
      { 'field' => 'DATA_TERM', 'caption' => 'Termin plat.', 'width' => 10 }, ;
      { 'field' => 'PODSTAWA', 'caption' => 'Podstawa opod.', 'width' => 11 }, ;
      { 'field' => 'PODATEK', 'caption' => 'Podatek', 'width' => 11 } }, ;
      2, 0, 22, 79, { 'new_record' => { || vat7zd->del := '+', vat7zd->mc := aDane[ 'Miesiac' ], vat7zd->firma := aDane[ 'Firma' ] }, ;
      'before_delete' => { || vat7zd->( RLock() ) }, 'after_delete' => { || vat7zd->( dbUnlock() ) }, ;
      'before_edit' => { || vat7zd->( RLock() ) }, 'after_edit' => { || vat7zd->( dbUnlock() ) } } )

   aDane[ 'VATZD' ][ 'P_10' ] := 0
   aDane[ 'VATZD' ][ 'P_11' ] := 0
   aDane[ 'VATZD' ][ 'PB' ] := {}
   vat7zd->( dbGoTop() )
   DO WHILE ! vat7zd->( Eof() )
      IF ! Empty( vat7zd->nip ) .AND. ! Empty( vat7zd->nazwa ) .AND. ( vat7zd->podstawa > 0 .OR. vat7zd->podstawa > 0 )
         AAdd( aDane[ 'VATZD' ][ 'PB' ], { ;
            'P_BB' => AllTrim( vat7zd->nazwa ), ;
            'P_BC' => AllTrim( vat7zd->nip ), ;
            'P_BD1' => AllTrim( vat7zd->nr_dok ), ;
            'P_BD2' => vat7zd->data_wyst, ;
            'P_BE' => vat7zd->data_term, ;
            'P_BF' => vat7zd->podstawa, ;
            'P_BG' => vat7zd->podatek } )
         aDane[ 'VATZD' ][ 'P_10' ] := aDane[ 'VATZD' ][ 'P_10' ] + vat7zd->podstawa
         aDane[ 'VATZD' ][ 'P_11' ] := aDane[ 'VATZD' ][ 'P_11' ] + vat7zd->podatek
      ENDIF
      vat7zd->( dbSkip() )
   ENDDO

   aDane[ 'VATZD' ][ 'P_10' ] := Round( aDane[ 'VATZD' ][ 'P_10' ], 0 )
   aDane[ 'VATZD' ][ 'P_11' ] := Round( aDane[ 'VATZD' ][ 'P_11' ], 0 )

   vat7zd->( dbCommit() )
   vat7zd->( dbCloseArea() )

   RestScreen( 0, 0, MaxRow(), MaxCol(), cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE VAT_ZD_Wczytaj( aDane )

   DO WHILE ! DostepPro( 'VAT7ZD', 'VAT7ZD' )
   ENDDO

   vat7zd->( dbSetFilter( { || vat7zd->del == "+" .AND. vat7zd->firma == aDane[ 'Firma' ] .AND. vat7zd->mc == aDane[ 'Miesiac' ] }, ;
      "vat7zd->del == '+' .AND. vat7zd->firma == aDane[ 'Firma' ] .AND. vat7zd->mc == aDane[ 'Miesiac' ]" ) )
   vat7zd->( dbGoTop() )

   aDane[ 'VATZD' ][ 'P_10' ] := 0
   aDane[ 'VATZD' ][ 'P_11' ] := 0
   aDane[ 'VATZD' ][ 'PB' ] := {}
   vat7zd->( dbGoTop() )
   DO WHILE ! vat7zd->( Eof() )
      IF ! Empty( vat7zd->nip ) .AND. ! Empty( vat7zd->nazwa ) .AND. ( vat7zd->podstawa > 0 .OR. vat7zd->podstawa > 0 )
         AAdd( aDane[ 'VATZD' ][ 'PB' ], { ;
            'P_BB' => AllTrim( vat7zd->nazwa ), ;
            'P_BC' => AllTrim( vat7zd->nip ), ;
            'P_BD1' => AllTrim( vat7zd->nr_dok ), ;
            'P_BD2' => vat7zd->data_wyst, ;
            'P_BE' => vat7zd->data_term, ;
            'P_BF' => vat7zd->podstawa, ;
            'P_BG' => vat7zd->podatek } )
         aDane[ 'VATZD' ][ 'P_10' ] := aDane[ 'VATZD' ][ 'P_10' ] + vat7zd->podstawa
         aDane[ 'VATZD' ][ 'P_11' ] := aDane[ 'VATZD' ][ 'P_11' ] + vat7zd->podatek
      ENDIF
      vat7zd->( dbSkip() )
   ENDDO

   aDane[ 'VATZD' ][ 'P_10' ] := Round( aDane[ 'VATZD' ][ 'P_10' ], 0 )
   aDane[ 'VATZD' ][ 'P_11' ] := Round( aDane[ 'VATZD' ][ 'P_11' ], 0 )

   vat7zd->( dbCommit() )
   vat7zd->( dbCloseArea() )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION VAT_ORD_ZU( aDane )

   LOCAL cTresc := edekOrdZuTrescPobierz( 'VAT-7', Val( AllTrim( aDane[ 'Firma' ] ) ), Val( AllTrim( aDane[ 'Miesiac' ] ) ) )

   IF HB_ISCHAR( cTresc )
      aDane[ 'ORDZU' ][ 'P_13' ] := cTresc
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION VAT_Sprawdz_NIP( cNIP )

   LOCAL nWynik
   LOCAL cEkran, cKolor

   cEkran := SaveScreen()
   cKolor := ColInf()
   @ 24, 0 SAY PadC( "Trwa sprawdzanie statusu VAT... Prosz© czeka†...", 80 )

   nWynik := amiSprawdzNIPVAT( cNIP )

   SWITCH nWynik
   CASE 0
      Komun( "Podmiot NIE jest zarejestrowany jako podatnik VAT" )
      EXIT
   CASE 1
      Komun( "Podmiot jest zarejestrowany jako podatnik VAT czynny" )
      EXIT
   CASE 2
      Komun( "Wprowadzono niepoprawny numer NIP (bˆ©dny format)" )
      EXIT
   CASE 3
      Komun( "Wprowadzono niepoprawny numer NIP (bˆ©dna suma kontrolna)" )
      EXIT
   CASE 4
      Komun( SubStr( "Podczas sprawdzania statusu VAT wyst¥piˆ bˆ¥d: " + amiEdekBladTekst(), 1, 75 ) )
      EXIT
   CASE 5
      Komun( "Brak licencji - weryfikacja dost©pna w peˆnej wersji programu" )
      EXIT
   ENDSWITCH

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_Dlg( cNIPIn )

   VAT_Sprzwdz_NIP_Dlg_WLApi( cNIPIn )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_DlgOld( cNIPIn )

   LOCAL cEkran := SaveScreen()
   LOCAL cKolor := ColStd()
   LOCAL cNIP := iif( Empty( cNIPIn ), Space( 10 ), PadR( TrimNip( cNIPIn ), 10 ) )
   LOCAL GetList := {}
   LOCAL bOldF8
   LOCAL bOldF9

   bOldF8 := hb_SetKeyGet( K_ALT_F8 )
   bOldF9 := hb_SetKeyGet( K_ALT_F9 )
   SET KEY K_ALT_F8 TO
   SET KEY K_ALT_F9 TO

   @  9, 16 CLEAR TO 15, 59
   @ 10, 18 TO 14, 57
   @ 10, 21 SAY "SPRAWDZENIE STATUSU PODMIOTU W VAT"
   @ 12, 20 SAY "Identyfikator podatkowy:" GET cNIP PICTURE "9999999999" VALID Len( AllTrim( cNIP ) ) == 10

  // Read_()
   READ

   IF LastKey() <> K_ESC
      VAT_Sprawdz_NIP( cNIP )
   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   SetKey( K_ALT_F8, bOldF8 )
   SetKey( K_ALT_F9, bOldF9 )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_RejE()

   LOCAL cKraj := "", cNIP

   cNIP := PodzielNIP( zNR_IDENT, @cKraj )

   IF KrajUE( cKraj )
      VAT_Sprawdz_Vies_Dlg( cKraj, cNIP )
   ELSE
      VAT_Sprzwdz_NIP_Dlg( zNR_IDENT )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_Rej()

   LOCAL cKraj := "", cNIP

   cNIP := PodzielNIP( NR_IDENT, @cKraj )

   IF KrajUE( cKraj )
      VAT_Sprawdz_Vies_Dlg( cKraj, cNIP )
   ELSE
      VAT_Sprzwdz_NIP_Dlg( NR_IDENT )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_DlgK()

   VAT_Sprzwdz_NIP_Dlg()

   RETURN

/*----------------------------------------------------------------------*/

#define WLAPI_URL          "https://wl-api.mf.gov.pl/api"
#define WLAPI_CONTENT_TYPE "application/json"
#define WLAPI_HEADER       "accept: application/json"

FUNCTION WLApiSearchNip( cNip, dData, xDane )

   LOCAL nRes
   LOCAL cAdres
   LOCAL cResponse

   cAdres := WLAPI_URL + "/search/nip/" + cNip + "?date=" + hb_DToC( dData, "yyyy-mm-dd" )

   nRes := amiRest( cAdres, WLAPI_CONTENT_TYPE, "", "GET", WLAPI_HEADER )

   cResponse := amiRestResponse()
   IF ! Empty( cResponse )
      IF nRes == 200 .OR. nRes == 400
         hb_jsonDecode( cResponse, @xDane )
         IF nRes == 200 .AND. HB_ISHASH( xDane ) .AND. hb_HHasKey( xDane, 'result' ) .AND. hb_HHasKey( xDane[ 'result' ], 'subject' ) .AND. ! Empty( xDane[ 'result' ][ 'subject' ] )
            IF hb_HHasKey( xDane[ 'result' ], 'requestDateTime' ) .AND. ! Empty( xDane[ 'result' ][ 'requestDateTime' ] )
               xDane[ 'result' ][ 'subject' ][ 'requestDateTime' ] := xDane[ 'result' ][ 'requestDateTime' ]
            ENDIF
            IF hb_HHasKey( xDane[ 'result' ], 'requestId' ) .AND. ! Empty( xDane[ 'result' ][ 'requestId' ] )
               xDane[ 'result' ][ 'subject' ][ 'requestId' ] := xDane[ 'result' ][ 'requestId' ]
            ENDIF
            WLApiFixDate( @xDane[ 'result' ][ 'subject' ] )
            xDane := xDane[ 'result' ][ 'subject' ]
            xDane[ 'jest' ] := .T.
            xDane[ 'stanNa' ] := dData
         ENDIF
      ELSE
         xDane := cResponse
      ENDIF
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION WLApiSearchNips( aNips, dData, xDane )

   LOCAL nRes
   LOCAL cAdres
   LOCAL cResponse
   LOCAL cNips := ""
   LOCAL aWpis, aWpisy

   AEval( aNips, { | cElement |
      IF Len( cNips ) > 0
         cNips := cNips + ","
      ENDIF
      cNips := cNips + cElement
   } )

   cAdres := WLAPI_URL + "/search/nips/" + cNips + "?date=" + hb_DToC( dData, "yyyy-mm-dd" )

   nRes := amiRest( cAdres, WLAPI_CONTENT_TYPE, "", "GET", WLAPI_HEADER )

   cResponse := amiRestResponse()
   IF ! Empty( cResponse )
      IF nRes == 200 .OR. nRes == 400
         hb_jsonDecode( cResponse, @xDane )
         IF nRes == 200 .AND. HB_ISHASH( xDane ) .AND. hb_HHasKey( xDane, 'result' ) .AND. hb_HHasKey( xDane[ 'result' ], 'entries' )
            aWpisy := {}
            AEval( xDane[ 'result' ][ 'entries' ], { | aElem |
               IF hb_HHasKey( aElem, 'subjects' ) .AND. Len( aElem[ 'subjects' ] ) > 0
                  aWpis := aElem[ 'subjects' ][ 1 ]
                  aWpis[ 'stanNa' ] := dData
                  IF hb_HHasKey( xDane[ 'result' ], 'requestDateTime' ) .AND. ! Empty( xDane[ 'result' ][ 'requestDateTime' ] )
                     aWpis[ 'requestDateTime' ] := xDane[ 'result' ][ 'requestDateTime' ]
                  ENDIF
                  IF hb_HHasKey( xDane[ 'result' ], 'requestId' ) .AND. ! Empty( xDane[ 'result' ][ 'requestId' ] )
                     aWpis[ 'requestId' ] := xDane[ 'result' ][ 'requestId' ]
                  ENDIF
                  WLApiFixDate( @aWpis )
                  AAdd( aWpisy, aWpis )
               ENDIF
            } )
            xDane := aWpisy
         ENDIF
      ELSE
         xDane := cResponse
      ENDIF
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

PROCEDURE WLApiFixDate( aWpis )

   IF ! HB_ISHASH( aWpis )
      RETURN
   ENDIF

   IF hb_HHasKey( aWpis, 'registrationLegalDate' ) .AND. ! Empty( aWpis[ 'registrationLegalDate' ] ) .AND. ValType( aWpis[ 'registrationLegalDate' ] ) == 'C'
      aWpis[ 'registrationLegalDate' ] := hb_CToD( aWpis[ 'registrationLegalDate' ], "yyyy-mm-dd" )
   ENDIF
   IF hb_HHasKey( aWpis, 'registrationDenialDate' ) .AND. ! Empty( aWpis[ 'registrationDenialDate' ] ) .AND. ValType( aWpis[ 'registrationDenialDate' ] ) == 'C'
      aWpis[ 'registrationDenialDate' ] := hb_CToD( aWpis[ 'registrationDenialDate' ], "yyyy-mm-dd" )
   ENDIF
   IF hb_HHasKey( aWpis, 'restorationDate' ) .AND. ! Empty( aWpis[ 'restorationDate' ] ) .AND. ValType( aWpis[ 'restorationDate' ] ) == 'C'
      aWpis[ 'restorationDate' ] := hb_CToD( aWpis[ 'restorationDate' ], "yyyy-mm-dd" )
   ENDIF
   IF hb_HHasKey( aWpis, 'removalDate' ) .AND. ! Empty( aWpis[ 'removalDate' ] ) .AND. ValType( aWpis[ 'removalDate' ] ) == 'C'
      aWpis[ 'removalDate' ] := hb_CToD( aWpis[ 'removalDate' ], "yyyy-mm-dd" )
   ENDIF
   IF hb_HHasKey( aWpis, 'requestDateTime' ) .AND. ! Empty( aWpis[ 'requestDateTime' ] ) .AND. ValType( aWpis[ 'requestDateTime' ] ) == 'C'
      aWpis[ 'requestDateTime' ] := hb_CToT( aWpis[ 'requestDateTime' ], "dd-mm-yyyy", " hh:mm:ss" )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION KontrSprDodaj( aWpis, lOtworz )

   LOCAL nTmpWA

   IF ! hb_HHasKey( aWpis, 'nip' )
      RETURN .F.
   END

   hb_default( @lOtworz, .T. )

   IF lOtworz
      nTmpWA := Select()
      DO WHILE ! DostepPro( "KONTRSPR", "KONTRSPR", .T. )
      ENDDO
   ENDIF

   kontrspr->( dbAppend() )
   kontrspr->nip := aWpis[ 'nip' ]
   kontrspr->stanna := aWpis[ 'stanNa' ]
   IF hb_HHasKey( aWpis, 'name' ) .AND. ! Empty( aWpis[ 'name' ] )
      kontrspr->name := aWpis[ 'name' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'statusVat' ) .AND. ! Empty( aWpis[ 'statusVat' ] )
      kontrspr->statusvat := aWpis[ 'statusVat' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'regon' ) .AND. ! Empty( aWpis[ 'regon' ] )
      kontrspr->regon := aWpis[ 'regon' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'pesel' ) .AND. ! Empty( aWpis[ 'pesel' ] )
      kontrspr->pesel := aWpis[ 'pesel' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'krs' ) .AND. ! Empty( aWpis[ 'krs' ] )
      kontrspr->krs := aWpis[ 'krs' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'residenceAddress' ) .AND. ! Empty( aWpis[ 'residenceAddress' ] )
      kontrspr->resadres := aWpis[ 'residenceAddress' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'workingAddress' ) .AND. ! Empty( aWpis[ 'workingAddress' ] )
      kontrspr->workadr := aWpis[ 'workingAddress' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'registrationLegalDate' ) .AND. ! Empty( aWpis[ 'registrationLegalDate' ] )
      kontrspr->reglegdat := aWpis[ 'registrationLegalDate' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'registrationDenialDate' ) .AND. ! Empty( aWpis[ 'registrationDenialDate' ] )
      kontrspr->regdendat := aWpis[ 'registrationDenialDate' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'registrationDenialBasis' ) .AND. ! Empty( aWpis[ 'registrationDenialBasis' ] )
      kontrspr->regdenbas := aWpis[ 'registrationDenialBasis' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'restorationDate' ) .AND. ! Empty( aWpis[ 'restorationDate' ] )
      kontrspr->restdate := aWpis[ 'restorationDate' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'restorationBasis' ) .AND. ! Empty( aWpis[ 'restorationBasis' ] )
      kontrspr->restbasis := aWpis[ 'restorationBasis' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'removalDate' ) .AND. ! Empty( aWpis[ 'removalDate' ] )
      kontrspr->removdate := aWpis[ 'removalDate' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'removalBasis' ) .AND. ! Empty( aWpis[ 'removalBasis' ] )
      kontrspr->removbasi := aWpis[ 'removalBasis' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'requestDateTime' ) .AND. ! Empty( aWpis[ 'requestDateTime' ] )
      kontrspr->reqdatetm := aWpis[ 'requestDateTime' ]
   ENDIF
   IF hb_HHasKey( aWpis, 'requestId' ) .AND. ! Empty( aWpis[ 'requestId' ] )
      kontrspr->reqid := aWpis[ 'requestId' ]
   ENDIF
   kontrspr->( dbCommit() )

   IF lOtworz
      kontrspr->( dbCloseArea() )
      dbSelectArea( nTmpWA )
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION KontrSprSzukaj( cNip, dData, lOtworz )

   LOCAL aRes := hb_Hash( 'jest', .F., 'nip', cNip )
   LOCAL nTmpWA

   hb_default( @dData, Date() )
   hb_default( @lOtworz, .T. )

   IF lOtworz
      nTmpWA := Select()
      DO WHILE ! DostepPro( "KONTRSPR", "KONTRSPR", .T. )
      ENDDO
   ENDIF

   //kontrspr->( dbSetFilter( { || kontrspr->nip == cNip }, "kontrspr->nip == cNip" ) )
   //kontrspr->( dbGoBottom() )

   IF kontrspr->( dbSeek( cNip + DToS( dData ) ) ) .AND. kontrspr->nip == cNip .AND. kontrspr->stanna == dData
      aRes[ 'jest' ] := .T.
      IF ! Empty( kontrspr->name )
         aRes[ 'name' ] := AllTrim( kontrspr->name )
      ENDIF
      aRes[ 'stanNa' ] := kontrspr->stanna
      IF ! Empty( kontrspr->statusvat )
         aRes[ 'statusVat' ] := AllTrim( kontrspr->statusvat )
      ENDIF
      IF ! Empty( kontrspr->regon )
         aRes[ 'regon' ] := AllTrim( kontrspr->regon )
      ENDIF
      IF ! Empty( kontrspr->pesel )
         aRes[ 'pesel' ] := AllTrim( kontrspr->pesel )
      ENDIF
      IF ! Empty( kontrspr->krs )
         aRes[ 'krs' ] := AllTrim( kontrspr->krs )
      ENDIF
      IF ! Empty( kontrspr->resadres )
         aRes[ 'residenceAddress' ] := AllTrim( kontrspr->resadres )
      ENDIF
      IF ! Empty( kontrspr->workadr )
         aRes[ 'workingAddress' ] := AllTrim( kontrspr->workadr )
      ENDIF
      IF ! Empty( kontrspr->reglegdat )
         aRes[ 'registrationLegalDate' ] := kontrspr->reglegdat
      ENDIF
      IF ! Empty( kontrspr->regdendat )
         aRes[ 'registrationDenialDate' ] := kontrspr->regdendat
      ENDIF
      IF ! Empty( kontrspr->regdenbas )
         aRes[ 'registrationDenialBasis' ] := AllTrim( kontrspr->regdenbas )
      ENDIF
      IF ! Empty( kontrspr->restdate )
         aRes[ 'restorationDate' ] := kontrspr->restdate
      ENDIF
      IF ! Empty( kontrspr->restbasis )
         aRes[ 'restorationBasis' ] := AllTrim( kontrspr->restbasis )
      ENDIF
      IF ! Empty( kontrspr->removdate )
         aRes[ 'removalDate' ] := kontrspr->removdate
      ENDIF
      IF ! Empty( kontrspr->removbasi )
         aRes[ 'removalBasis' ] := AllTrim( kontrspr->removbasi )
      ENDIF
      IF ! Empty( kontrspr->reqdatetm )
         aRes[ 'requestDateTime' ] := kontrspr->reqdatetm
      ENDIF
      IF ! Empty( kontrspr->reqid )
         aRes[ 'requestId' ] := AllTrim( kontrspr->reqid )
      ENDIF
   ENDIF

   IF lOtworz
      kontrspr->( dbCloseArea() )
      dbSelectArea( nTmpWA )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION WLApiSzukajNip( cNip, dData, xDane, lOtworz )

   LOCAL cScr := SaveScreen( 0, 0, MaxRow(), MaxCol() )
   LOCAL lRes := .F.

   xDane := KontrSprSzukaj( cNip, dData, lOtworz )
   lRes := HB_ISHASH( xDane ) .AND. hb_HHasKey( xDane, 'jest' ) .AND. xDane[ 'jest' ]
   IF ! lRes
      IF WLApiSearchNip( cNip, dData, @xDane ) == 200
         lRes := HB_ISHASH( xDane ) .AND. hb_HHasKey( xDane, 'jest' ) .AND. xDane[ 'jest' ]
         IF lRes
            KontrSprDodaj( xDane, lOtworz )
         ENDIF
      ENDIF
   ENDIF

   RestScreen( cScr, 0, 0, MaxRow(), MaxCol() )

   RETURN lRes

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_Dlg_WLApi( cNIPIn )

   LOCAL cEkran := SaveScreen()
   LOCAL cKolor := ColStd()
   LOCAL cNIP := iif( Empty( cNIPIn ), Space( 10 ), PadR( TrimNip( cNIPIn ), 10 ) )
   LOCAL GetList := {}
   LOCAL bOldF8
   LOCAL dData := Date()
   LOCAL xDane
   LOCAL cRaport
   LOCAL nCnt
   LOCAL bPerson := { | aElem |
      cRaport += AllTrim( Str( nCnt ) ) + ". "
      IF hb_HHasKey( aElem, 'companyName' ) .AND. ! Empty( aElem[ 'companyName' ] )
         cRaport += "(" + eElem[ 'companyName' ] + ")"
      ENDIF
      IF hb_HHasKey( aElem, 'firstName' ) .AND. ! Empty( aElem[ 'firstName' ] )
         cRaport += " " + eElem[ 'firstName' ]
      ENDIF
      IF hb_HHasKey( aElem, 'lastName' ) .AND. ! Empty( aElem[ 'lastName' ] )
         cRaport += " " + eElem[ 'lastName' ]
      ENDIF
      IF hb_HHasKey( aElem, 'pesel' ) .AND. ! Empty( aElem[ 'pesel' ] )
         cRaport += " PESEL:" + eElem[ 'pesel' ]
      ENDIF
      IF hb_HHasKey( aElem, 'nip' ) .AND. ! Empty( aElem[ 'nip' ] )
         cRaport += " " + eElem[ 'nip' ]
      ENDIF
      cRaport += hb_eol()
      nCnt++
   }

   bOldF8 := hb_SetKeyGet( K_ALT_F8 )
   SET KEY K_ALT_F8 TO

   @  9, 16 CLEAR TO 16, 59
   @ 10, 18 TO 15, 57
   @ 10, 21 SAY "SPRAWDZENIE STATUSU PODMIOTU W VAT"
   @ 12, 20 SAY "          Stan na dzieä:" GET dData VALID ! Empty( dData )
   @ 13, 20 SAY "Identyfikator podatkowy:" GET cNIP PICTURE "9999999999" VALID Len( AllTrim( cNIP ) ) == 10 .AND. SprawdzNIPSuma( cNIP )

   READ

   IF LastKey() <> K_ESC
      ColInf()
      @ 24, 0 SAY PadC( 'Trwa sprawdzanie statusu VAT... Prosz© czeka†...', 80 )
      ColStd()
      IF WLApiSzukajNip( cNIP, dData, @xDane )
         ColStd()
         @ 3, 0
         @ 3, 0 SAY "       Status podmiotu w VAT:"
         @ 24, 0
         ColInf()
         IF hb_HHasKey( xDane, 'statusVat' )
            @ 3, 33 SAY "  " + xDane[ 'statusVat' ] + "  "
         ENDIF
         ColStd()
         cRaport := "Sprawdzanie statusu VAT podmiotu" + hb_eol()
         cRaport += "--------------------------------" + hb_eol()
         cRaport += "Nr NIP: " + cNIP + hb_eol()
         cRaport += "Stan na dzieä: " + hb_DToC( dData ) + hb_eol()
         cRaport += "--------------------------------" + hb_eol()
         cRaport += "Status VAT: " + xmlWartoscH( xDane, 'statusVat', 'nieznany' ) + hb_eol()
         cRaport += "--------------------------------" + hb_eol()
         cRaport += "Firma (nazwa) lub imi© i nazwisko: " + xmlWartoscH( xDane, 'name', '' ) + hb_eol()
         IF hb_HHasKey( xDane, 'regon' ) .AND. ! Empty( xDane[ 'regon' ] )
            cRaport += "Numer identyfikacyjny REGON: " + xDane[ 'regon' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'pesel' ) .AND. ! Empty( xDane[ 'pesel' ] )
            cRaport += "Numer identyfikacyjny PESEL: " + xDane[ 'pesel' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'krs' ) .AND. ! Empty( xDane[ 'krs' ] )
            cRaport += "Numer identyfikacyjny KRS: " + xDane[ 'krs' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'residenceAddress' ) .AND. ! Empty( xDane[ 'residenceAddress' ] )
            cRaport += "Adres siedziby: " + xDane[ 'residenceAddress' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'workingAddress' ) .AND. ! Empty( xDane[ 'workingAddress' ] )
            cRaport += "Adres staˆego miejsca prowadzenia dziaˆalno˜ci lub adres miejsca zamieszkania w przypadku braku adresu staˆego miejsca prowadzenia dziaˆalno˜ci: " + xDane[ 'workingAddress' ] + hb_eol()
         ENDIF

         IF hb_HHasKey( xDane, 'representatives' ) .AND. ! Empty( xDane[ 'representatives' ] )
            cRaport += "Imiona i nazwiska os¢b wchodz¥cych w skˆad organu uprawnionego do reprezentowania podmiotu oraz ich numery NIP i/lub PESEL: " + hb_eol()
            nCnt := 1
            AEval( xDane[ 'representatives' ], bPerson )
         ENDIF

         IF hb_HHasKey( xDane, 'authorizedClerks' ) .AND. ! Empty( xDane[ 'authorizedClerks' ] )
            cRaport += "Imiona i nazwiska prokurent¢w oraz ich numery NIP i/lub PESEL: " + hb_eol()
            nCnt := 1
            AEval( xDane[ 'authorizedClerks' ], bPerson )
         ENDIF

         IF hb_HHasKey( xDane, 'partners' ) .AND. ! Empty( xDane[ 'partners' ] )
            cRaport += "Imiona i nazwiska lub firm© (nazwa) wsp¢lnika oraz jego numeryNIP i/lub PESEL: " + hb_eol()
            nCnt := 1
            AEval( xDane[ 'partners' ], bPerson )
         ENDIF

         IF hb_HHasKey( xDane, 'registrationLegalDate' ) .AND. ! Empty( xDane[ 'registrationLegalDate' ] )
            cRaport += "Data rejestracji jako podatnika VAT: " + hb_DToC( xDane[ 'registrationLegalDate' ] ) + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'registrationDenialDate' ) .AND. ! Empty( xDane[ 'registrationDenialDate' ] )
            cRaport += "Data odmowy rejestracji jako podatnika VAT: " + hb_DToC( xDane[ 'registrationDenialDate' ] ) + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'registrationDenialBasis' ) .AND. ! Empty( xDane[ 'registrationDenialBasis' ] )
            cRaport += "Podstawa prawna odmowy rejestracji: " + xDane[ 'registrationDenialBasis' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'restorationDate' ) .AND. ! Empty( xDane[ 'restorationDate' ] )
            cRaport += "Data przywr¢cenia jako podatnika VAT: " + hb_DToC( xDane[ 'restorationDate' ] ) + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'restorationBasis' ) .AND. ! Empty( xDane[ 'restorationBasis' ] )
            cRaport += "Podstawa prawna przywr¢cenia jako podatnika VAT: " + xDane[ 'restorationBasis' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'removalDate' ) .AND. ! Empty( xDane[ 'removalDate' ] )
            cRaport += "Data wykre˜lenia odmowy rejestracji jako podatnika VAT: " + hb_DToC( xDane[ 'removalDate' ] ) + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'removalBasis' ) .AND. ! Empty( xDane[ 'removalBasis' ] )
            cRaport += "Podstawa prawna wykre˜lenia odmowy rejestracji jako podatnika VAT: " + xDane[ 'removalBasis' ] + hb_eol()
         ENDIF

         IF hb_HHasKey( xDane, 'accountNumbers' ) .AND. ! Empty( xDane[ 'accountNumbers' ] )
            cRaport += "Numery kont: " + hb_eol()
            nCnt := 1
            AEval( xDane[ 'accountNumbers' ], { | cNr |
               cRaport += AllTrim( Str( nCnt ) ) + ". " + cNr + hb_eol()
               nCnt++
            } )
         ENDIF

         IF hb_HHasKey( xDane, 'requestId' ) .AND. ! Empty( xDane[ 'requestId' ] )
            cRaport += "Id wywoˆania: " + xDane[ 'requestId' ] + hb_eol()
         ENDIF
         IF hb_HHasKey( xDane, 'requestDateTime' ) .AND. ! Empty( xDane[ 'requestDateTime' ] )
            cRaport += "Data i czas wywoˆania: " + hb_TToC( xDane[ 'requestDateTime' ] ) + hb_eol()
         ENDIF
         WyswietlTekst( cRaport, 4, , "Statusu VAT podmiotu" )
      ELSE
         Komun( "Sprawdzanie statusu nie powiodˆo si©." )
      ENDIF
   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   //SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
   SetKey( K_ALT_F8, bOldF8 )

   RETURN

/*----------------------------------------------------------------------*/

STATIC PROCEDURE VAT_Sprzwdz_GrpNIP_WLApi_DNA2( aGrpAr, aResPoz )

   AEval( aGrpAr, { | aGrpPoz |
      IF aGrpPoz[ 'NIP' ] == aResPoz[ 'nip' ]
         aGrpPoz[ 'StatusVat' ] := aResPoz[ 'statusVat' ]
      ENDIF
   } )

   RETURN

/*----------------------------------------------------------------------*/

STATIC PROCEDURE VAT_Sprzwdz_GrpNIP_WLApi_DNA( xData, dData, aGrpAr )

   AEval( xData, { | aResPoz |
      IF HB_ISHASH( aResPoz ) .AND. hb_HHasKey( aResPoz, 'statusVat' ) .AND. ! Empty( aResPoz[ 'statusVat' ] )
         aResPoz[ 'stanNa' ] := dData
         KontrSprDodaj( aResPoz, .F. )
         VAT_Sprzwdz_GrpNIP_WLApi_DNA2( @aGrpAr, aResPoz )
      ENDIF
   } )

   RETURN

/*----------------------------------------------------------------------*/

STATIC FUNCTION VAT_Sprzwdz_GrpNIP_WLApi_Prz()

   RETURN iif( lPrzerwij, .T., ( lPrzerwij := NextKey() == K_ESC ) )

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_GrpNIP_WLApi( cTablica, bEof )

   LOCAL cRodzajDaty := "Z"
   LOCAL dData := Date()
   LOCAL lBtnRozpocznij := .T.
   LOCAL cRodzajRap := "S"
   LOCAL cSprawdzVies := "T"
   LOCAL cEkran := SaveScreen( 0, 0, MaxRow(), MaxCol() )
   LOCAL cKolor := ColStd()
   LOCAL cEkranDt
   LOCAL bRodzajDatyW := { | x |
      cEkranDt := SaveScreen( 13, 36, 18, 55 )
      ColInf()
      @ 13, 36 CLEAR TO 18, 55
      @ 13, 36 TO 18, 55
      @ 14, 38 SAY "R - Rejestru"
      @ 15, 38 SAY "W - Wystawienia"
      @ 16, 38 SAY "T - Transakcji"
      @ 17, 38 SAY "Z - Zdefiniowany"
      ColStd()
      RETURN .T.
   }
   LOCAL bRodzajDatyV := { | x |
      IF cRodzajDaty $ 'RWTZ'
         RestScreen( 13, 36, 18, 55, cEkranDt )
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }
   LOCAL aDane := {}, aBledne := {}, aDaneRap, aDaneVies := {}, aDaneViesGr := {}, aDaneViesRes
   LOCAL aPozycja, nTmpWA, nTmpRecNo, aGrupy, cRaport := '', nCnt, nIlosc, nGrTx
   LOCAL bRodzajRapW := { | x |
      ColInf()
      @ 24, 0 SAY PadC( "P - peˆny raport (wszystkie dokumenty) | S - Skr¢cony raport (tylko nie-vatowcy)", 80 )
      ColStd()
      RETURN .T.
   }
   LOCAL bRodzajRapV := { | x |
      IF cRodzajRap $ 'PS'
         @ 24, 0
         RETURN .T.
      ELSE
         RETURN .F.
      ENDIF
   }

   PRIVATE lPrzerwij := .F.

   @  8, 16 CLEAR TO 17, 59
   @  9, 18 TO 16, 57
   @  9, 21 SAY "GRUPOWA WERYFIKACJA PODMIOTU W VAT"
   @ 11, 20 SAY "Sprawdz na dzieä:" GET cRodzajDaty PICTURE "!" WHEN Eval( bRodzajDatyW ) VALID Eval( bRodzajDatyV )
   @ 12, 20 SAY "   Stan na dzieä:" GET dData WHEN cRodzajDaty == "Z" VALID ! Empty( dData )
   @ 13, 20 SAY "  Sprawd« w VIES:" GET cSprawdzVies PICTURE "!" VALID cSprawdzVies $ 'TN'
   @ 14, 20 SAY "Rodzaj raportu (Peˆny/Skr¢cony):" GET cRodzajRap PICTURE "!" WHEN Eval( bRodzajRapW ) VALID Eval( bRodzajRapV )

   READ

   Restscreen( 0, 0, MaxRow(), MaxCol(), cEkran )

   IF LastKey() <> K_ESC
      ColInf()
      @ 24, 0 SAY PadC( "Krok 1/4 ...Wybieranie danych...", 80 )
      nTmpWA := Select()
      nTmpRecNo := ( cTablica )->( RecNo() )
      DO WHILE .NOT. Eval( bEof ) .AND. ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
         IF ( ( cTablica )->kraj == 'PL' .OR. ( cTablica )->kraj == '  ' )
            aPozycja := hb_Hash()
            aPozycja[ 'RecNo' ] := ( cTablica )->( RecNo() )
            aPozycja[ 'NIP' ] := TrimNip( ( cTablica )->nr_ident )
            aPozycja[ 'NrDok' ] := AllTrim( ( cTablica )->numer )
            aPozycja[ 'Kontrahent' ] := AllTrim( ( cTablica )->nazwa )
            aPozycja[ 'Kraj' ] := 'PL'
            aPozycja[ 'DataDok' ] := hb_Date( Val( param_rok ), Val( ( cTablica )->mc ), Val( ( cTablica )->dzien ) )
            SWITCH cRodzajDaty
            CASE "Z"
               aPozycja[ 'StanNa' ] := dData
               EXIT
            CASE "R"
               aPozycja[ 'StanNa' ] := aPozycja[ 'DataDok' ]
               EXIT
            CASE "W"
               aPozycja[ 'StanNa' ] := hb_Date( Val( ( cTablica )->roks ), Val( ( cTablica )->mcs ), Val( ( cTablica )->dziens ) )
               EXIT
            CASE "T"
               aPozycja[ 'StanNa' ] := iif( Empty( ( cTablica )->datatran ), hb_Date( Val( ( cTablica )->roks ), Val( ( cTablica )->mcs ), Val( ( cTablica )->dziens ) ), ( cTablica )->datatran )
               EXIT
            OTHERWISE
               aPozycja[ 'StanNa' ] := aPozycja[ 'DataDok' ]
               EXIT
            ENDSWITCH
            IF Len( TrimNip( ( cTablica )->nr_ident ) ) >= 10 .AND. SprawdzNIPSuma( TrimNip( ( cTablica )->nr_ident ) )
               AAdd( aDane, aPozycja )
            ELSE
               aPozycja[ 'StatusVat' ] := 'NIEPRAWIDOWA SUMA KONTROLNA NIP'
               AAdd( aBledne, aPozycja )
            ENDIF
         ENDIF
         IF cSprawdzVies == 'T' .AND. KrajUE( ( cTablica )->kraj )
            aPozycja := hb_Hash()
            aPozycja[ 'RecNo' ] := ( cTablica )->( RecNo() )
            aPozycja[ 'NIP' ] := PodzielNIP( TrimNip( ( cTablica )->nr_ident ) )
            aPozycja[ 'NrDok' ] := AllTrim( ( cTablica )->numer )
            aPozycja[ 'Kontrahent' ] := AllTrim( ( cTablica )->nazwa )
            aPozycja[ 'Kraj' ] := ( cTablica )->kraj
            aPozycja[ 'DataDok' ] := hb_Date( Val( param_rok ), Val( ( cTablica )->mc ), Val( ( cTablica )->dzien ) )
            aPozycja[ 'StanNa' ] := Date()
            AAdd( aDaneVies, aPozycja )
         ENDIF
         ( cTablica )->( dbSkip() )
      ENDDO
      ( cTablica )->( dbGoto( nTmpRecNo ) )

      IF ! lPrzerwij

         ASort( aDane, , , { | aEl1, aEl2 | aEl1[ 'StanNa' ] > aEl2[ 'StanNa' ] } )

         DO WHILE ! DostepPro( "KONTRSPR", "KONTRSPR", .T. )
         ENDDO

         @ 24, 0 SAY PadC( "Krok 2/4 ...Wyszukiwanie statusu w lokalnej bazie...", 80 )
         ColStd()
         @ 11, 15 CLEAR TO 15, 64
         @ 11, 15 TO 15, 64 DOUBLE
         @ 12, 16 SAY PadC( "Wyszukiwanie w bazie lokalnej", 48 )
         nCnt := 0
         AEval( aDane, { | aPoz |
            LOCAL aWynik

            @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( Len( aDane ) ) ), 48 )
            @ 14, 17 SAY ProgressBar( nCnt, Len( aDane ), 46 )

            IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
               aWynik := KontrSprSzukaj( aPoz[ 'NIP' ], aPoz[ 'StanNa' ], .F. )
               IF HB_ISHASH( aWynik ) .AND. hb_HHasKey( aWynik, 'statusVat' ) .AND. ! Empty( aWynik[ 'statusVat' ] )
                  aPoz[ 'StatusVat' ] := aWynik[ 'statusVat' ]
               ENDIF
            ENDIF

            nCnt++
            @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( Len( aDane ) ) ), 48 )
            @ 14, 17 SAY ProgressBar( nCnt, Len( aDane ), 46 )

         } )

         IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
            nIlosc := 0
            aGrupy := hb_Hash()
            AEval( aDane, { | aPoz |
               IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
                  IF ! hb_HHasKey( aPoz, 'StatusVat' )
                     IF ! hb_HHasKey( aGrupy, aPoz[ 'StanNa' ] )
                        aGrupy[ aPoz[ 'StanNa' ] ] := {}
                     ENDIF
                     AAdd( aGrupy[ aPoz[ 'StanNa' ] ], aPoz )
                     nIlosc++
                  ENDIF
               ENDIF
            } )

            IF ! lPrzerwij
               ColInf()
               @ 24, 0 SAY PadC( "Krok 3/4 ...Wyszukiwanie statusu w bazie MF...", 80 )

               ColStd()
               @ 11, 15 CLEAR TO 15, 64
               @ 11, 15 TO 15, 64 DOUBLE
               @ 12, 16 SAY PadC( "Wyszukiwanie w bazie MF", 48 )
               nCnt := 0

               hb_HEval( aGrupy, { | dData, aGrpAr |

                  LOCAL xData, nI, nJ, aNipy

                  IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()

                     IF Len( aGrpAr ) == 1
                        IF WLApiSzukajNip( aGrpAr[ 1 ][ 'NIP' ], dData, @xData, .F. ) .AND. HB_ISHASH( xData ) .AND. hb_HHasKey( xData, 'statusVat' )
                           aGrpAr[ 1 ][ 'StatusVat' ] := xData[ 'statusVat' ]
                        ENDIF
                        nCnt++
                        @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
                        @ 14, 17 SAY ProgressBar( nCnt, nIlosc, 46 )
                     ELSEIF Len( aGrpAr ) > 1
                        aNipy := {}
                        @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
                        @ 14, 17 SAY ProgressBar( nCnt, nIlosc, 46 )
                        FOR nI := 1 TO Len( aGrpAr )
                           IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
                              IF AScan( aNipy, aGrpAr[ nI ][ 'NIP' ] ) == 0
                                 AAdd( aNipy, aGrpAr[ nI ][ 'NIP' ] )
                              ENDIF
                              IF Len( aNipy ) == 30 .OR. nI == Len( aGrpAr )
                                 IF WLApiSearchNips( aNipy, dData, @xData ) == 200 .AND. HB_ISARRAY( xData )
                                    VAT_Sprzwdz_GrpNIP_WLApi_DNA( @xData, dData, @aGrpAr )
                                 ENDIF
                                 nCnt := nCnt + Len( aNipy )
                                 @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
                                 @ 14, 17 SAY ProgressBar( nCnt, nIlosc, 46 )
                                 aNipy := {}
                              ENDIF
                           ENDIF
                        NEXT
                     ENDIF
                  ENDIF
               } )

               IF ! lPrzerwij
                  ColInf()
                  @ 24, 0 SAY PadC( "Krok 4/4 ...Wyszukiwanie statusu w bazie VIES...", 80 )

                  ColStd()
                  @ 11, 15 CLEAR TO 15, 64
                  @ 11, 15 TO 15, 64 DOUBLE
                  @ 12, 16 SAY PadC( "Wyszukiwanie w bazie VIES", 48 )
                  nCnt := 0
                  AEval( aDaneVies, { | aPoz |
                     PUBLIC aPozL := aPoz
                     IF AScan( aDaneViesGr, { | aPozV | aPozV[ 'NIP' ] == aPozL[ 'NIP' ] .AND. aPozV[ 'Kraj' ] == aPozL[ 'Kraj' ] } ) == 0
                        AAdd( aDaneViesGr, aPoz )
                     ENDIF
                  } )
                  AEval( aDaneViesGr, { | aPoz |
                     IF ! VAT_Sprzwdz_GrpNIP_WLApi_Prz()
                        PUBLIC aPozL := aPoz
                        nI := Vies_CheckVat( aPoz[ 'Kraj' ], aPoz[ 'NIP' ], @aDaneViesRes )
                        DO CASE
                        CASE nI == 1
                           AEval( aDaneVies, { | aPozV |
                              IF aPozV[ 'Kraj' ] == aPozL[ 'Kraj' ] .AND. aPozV[ 'NIP' ] == aPozL[ 'NIP' ]
                                 aPozV[ 'StatusVat' ] := "AKTYWNY"
                              ENDIF
                           } )
                        CASE nI == 0
                           AEval( aDaneVies, { | aPozV |
                              IF aPozV[ 'Kraj' ] == aPozL[ 'Kraj' ] .AND. aPozV[ 'NIP' ] == aPozL[ 'NIP' ]
                                 aPozV[ 'StatusVat' ] := "NIE JEST AKTYWNY"
                              ENDIF
                           } )
                        ENDCASE
                        nCnt++
                        @ 13, 16 SAY PadC( AllTrim( Str( nCnt ) ) + " / " + AllTrim( Str( Len( aDaneViesGr ) ) ), 48 )
                        @ 14, 17 SAY ProgressBar( nCnt, Len( aDaneViesGr ), 46 )
                     ENDIF
                  } )
               ENDIF
            ENDIF
         ENDIF
      ENDIF

      kontrspr->( dbCloseArea() )
      dbSelectArea( nTmpWA )

      CLEAR TYPEAHEAD
      Restscreen( 0, 0, MaxRow(), MaxCol(), cEkran )

      AEval( aDaneVies, { | aPoz | AAdd( aDane, aPoz ) } )
      AEval( aBledne, { | aPoz | AAdd( aDane, aPoz ) } )
      AEval( aDane, { | aPoz |
         IF ! hb_HHasKey( aPoz, 'StatusVat' )
            aPoz[ 'StatusVat' ] := '(nieznany)'
         ENDIF
      } )

      nGrTx := GraficznyCzyTekst()

      DO CASE
      CASE nGrTx == 1

         IF cRodzajRap == 'S'
            aDaneRap := {}
            AEval( aDane, { | aPoz |
               IF ( ! hb_HHasKey( aPoz, 'StatusVat' ) .OR. Empty( aPoz[ 'StatusVat' ] ) .OR. SubStr( aPoz[ 'StatusVat' ], 1, 1 ) <> "C" )
                  AAdd( aDaneRap, aPoz )
               ENDIF
            } )
         ELSE
            aDaneRap := aDane
         ENDIF

         FRDrukuj( 'frf\wervat.frf', hb_Hash( 'dane', aDaneRap ) )

      CASE nGrTx == 2

         ColStd()
         @ 24, 0
         AEval( aDane, { | aPoz |
            IF cRodzajRap == 'P' .OR. ( ! hb_HHasKey( aPoz, 'StatusVat' ) .OR. Empty( aPoz[ 'StatusVat' ] ) .OR. SubStr( aPoz[ 'StatusVat' ], 1, 1 ) <> "C" )
               cRaport += "--------------------------------" + hb_eol()
               cRaport += "Nr NIP: " + aPoz[ 'NIP' ] + hb_eol()
               cRaport += "Kontrahent: " + aPoz[ 'Kontrahent' ] + hb_eol()
               IF hb_HHasKey( aPoz, 'StatusVat' ) .AND. ! Empty( aPoz[ 'StatusVat' ] )
                  cRaport += "Status VAT: " + aPoz[ 'StatusVat' ] + hb_eol()
               ELSE
                  cRaport += "Status VAT: (nieznany)" + hb_eol()
               ENDIF
               cRaport += "Stan na dzieä: " + hb_DToC( aPoz[ 'StanNa' ] ) + hb_eol()
               cRaport += "Nr dokumantu: " + aPoz[ 'NrDok' ] + hb_eol()
               cRaport += "Data dokumentu: " + hb_DToC( aPoz[ 'DataDok' ] ) + hb_eol()
            ENDIF
         } )

         IF Len( cRaport ) > 0
            WyswietlTekst( cRaport, , , "Raport sprawdzenia statusu VAT podmiot¢w" )
         ELSE
            Komun( 'Wszystkie podmioty maj¥ "czynny" status VAT' )
         ENDIF

      ENDCASE
   ENDIF

   Restscreen( 0, 0, MaxRow(), MaxCol(), cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Vies_CheckVat( cKraj, cNIP, aDane )

   LOCAL nRes

   IF ( ! KrajUE( cKraj ) .AND. cKraj <> "PL" ) .OR. ! HB_ISCHAR( cNIP ) .OR. Len( cNIP ) == 0
      RETURN 4
   ENDIF

   nRes := amiViesCheckVat( cKraj, cNIP )

   IF nRes == 1
      hb_jsonDecode( amiEdekBladTekst(), @aDane )
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION VAT_Sprawdz_Vies_Dlg( cKraj, cNIP )

   LOCAL bOldF8
   LOCAL bOldF9
   LOCAL cEkran := SaveScreen()
   LOCAL cKolor := ColStd()
   LOCAL nWynik
   LOCAL aDane
   LOCAL GetList := {}

   hb_default( @cKraj, "  " )
   hb_default( @cNIP, Space( 12 ) )

   cNIP := PadR( cNIP, 12 )

   bOldF8 := hb_SetKeyGet( K_ALT_F8 )
   bOldF9 := hb_SetKeyGet( K_ALT_F9 )
   SET KEY K_ALT_F8 TO
   SET KEY K_ALT_F9 TO

   @  9, 16 CLEAR TO 16, 59
   @ 10, 18 TO 15, 57
   @ 10, 21 SAY "SPRAWDZENIE STATUSU PODMIOTU W VIES"
   @ 12, 20 SAY "              Kod kraju:" GET cKraj PICTURE "!!" VALID KrajUE( cKraj ) .OR. cKraj == "PL"
   @ 13, 20 SAY "Identyfikator podatkowy:" GET cNIP PICTURE "!!!!!!!!!!!!" VALID Len( AllTrim( cNIP ) ) > 0

   READ

   IF LastKey() <> K_ESC
      ColInf()
      @ 24, 0 SAY PadC( 'Trwa sprawdzanie statusu VAT... Prosz© czeka†...', 80 )
      ColStd()
      nWynik := Vies_CheckVat( cKraj, AllTrim( cNIP ), @aDane )
      @ 24, 0
      IF nWynik == 1
         Komunikat( "Podmiot JEST zarejestrowany w VIES;;Kraj: " + ;
            HGetDefault( aDane, 'countryCode', '??' ) + ;
            '   NIP: ' + HGetDefault( aDane, 'vatNumber', '???' )  + ';' + ;
            HGetDefault( aDane, 'name', '' ) + ';' + HGetDefault( aDane, 'address', '' ), CColStd )
      ELSEIF nWynik == 0
         Komun( "Podmiot nie jest zarejestrowany w VIES" )
      ELSE
         Komun( "Sprawdzanie statusu nie powiodˆo si©." )
      ENDIF
   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   SetKey( K_ALT_F8, bOldF8 )
   SetKey( K_ALT_F9, bOldF9 )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprawdz_Vies_DlgF( cKraj, cNIP )

   VAT_Sprawdz_Vies_Dlg()

   RETURN NIL

/*----------------------------------------------------------------------*/
