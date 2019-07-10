/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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
   @ 18, 18 GET aDane[ 'ORDZU' ][ 'rob' ] CHECKBOX CAPTION 'Uzasadnienie przyczyn korekty (ORD-ZU)' WHEN aDane[ 'Korekta' ] STYLE '[X ]'
   @ 18, 61 GET lBORDZU  PUSHBUTTON CAPTION ' Edytuj ORD-ZU ' WHEN aDane[ 'ORDZU' ][ 'rob' ] STATE { || VAT_ORD_ZU( aDane ) }
//   @ 19, 18 GET aDane[ 'VATZZ' ][ 'rob' ] CHECKBOX CAPTION 'Wniosek o zwrot podatku VAT   (VAT-ZZ)' STYLE '[X ]'
//   @ 19, 61 GET lBVATZZ  PUSHBUTTON CAPTION ' Edytuj VAT-ZZ ' WHEN aDane[ 'VATZZ' ][ 'rob' ] STATE { || VAT_ZZ_Edycja( aDane ) }
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

   LOCAL cEkran := SaveScreen()
   LOCAL cKolor := ColStd()
   LOCAL cNIP := iif( Empty( cNIPIn ), Space( 10 ), PadR( TrimNip( cNIPIn ), 10 ) )
   LOCAL GetList := {}
   LOCAL bOldF8

   bOldF8 := hb_SetKeyGet( K_ALT_F8 )
   SET KEY K_ALT_F8 TO

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

   //SET KEY K_ALT_F8 TO VAT_Sprzwdz_NIP_DlgK
   SetKey( K_ALT_F8, bOldF8 )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_RejE()

   VAT_Sprzwdz_NIP_Dlg( zNR_IDENT )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_Rej()

   VAT_Sprzwdz_NIP_Dlg( NR_IDENT )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VAT_Sprzwdz_NIP_DlgK()

   VAT_Sprzwdz_NIP_Dlg()

   RETURN

/*----------------------------------------------------------------------*/
