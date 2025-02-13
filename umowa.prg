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

#include "Inkey.ch"
#include "Directry.ch"
#include "hbcompat.ch"

STATIC aUmowaPolaTrans := { ;
   '@DZISIAJ' => { || DToC( DATE() ) }, ;
   '#DZISIAJ' => { || DToC( DATE() ) }, ;
   '@NAZWISKO' => { || prac->NAZWISKO }, ;
   '#NAZWISKO' => { || AllTrim( prac->NAZWISKO ) }, ;
   '@IMIE1' => { || prac->IMIE1 }, ;
   '#IMIE1' => { || AllTrim( prac->IMIE1 ) }, ;
   '@IMIE2' => { || prac->IMIE2 }, ;
   '#IMIE2' => { || AllTrim( prac->IMIE2 ) }, ;
   '@IMIE_O' => { || prac->IMIE_O }, ;
   '#IMIE_O' => { || AllTrim( prac->IMIE_O ) }, ;
   '@IMIE_M' => { || prac->IMIE_M }, ;
   '#IMIE_M' => { || AllTrim( prac->IMIE_M ) }, ;
   '@MIEJSC_UR' => { || prac->MIEJSC_UR }, ;
   '#MIEJSC_UR' => { || AllTrim( prac->MIEJSC_UR ) }, ;
   '@DATA_UR' => { || DToC( prac->DATA_UR ) }, ;
   '#DATA_UR' => { || DToC( prac->DATA_UR ) }, ;
   '@ZATR' => { || prac->ZATRUD }, ;
   '#ZATR' => { || AllTrim( prac->ZATRUD ) }, ;
   '@PESEL' => { || prac->PESEL }, ;
   '#PESEL' => { || AllTrim( prac->PESEL ) }, ;
   '@NIP' => { || prac->NIP }, ;
   '#NIP' => { || AllTrim( prac->NIP ) }, ;
   '@MIEJSC_ZAM' => { || prac->MIEJSC_ZAM }, ;
   '#MIEJSC_ZAM' => { || AllTrim( prac->MIEJSC_ZAM ) }, ;
   '@KOD' => { || prac->KOD_POCZT }, ;
   '#KOD' => { || AllTrim( prac->KOD_POCZT ) }, ;
   '@GMINA' => { || prac->GMINA }, ;
   '#GMINA' => { || AllTrim( prac->GMINA ) }, ;
   '@ULICA' => { || prac->ULICA }, ;
   '#ULICA' => { || AllTrim( prac->ULICA ) }, ;
   '@DOM' => { || prac->NR_DOMU }, ;
   '#DOM' => { || AllTrim( prac->NR_DOMU ) }, ;
   '@LOKAL' => { || prac->NR_MIESZK }, ;
   '#LOKAL' => { || AllTrim( prac->NR_MIESZK ) }, ;
   '@DOWOD' => { || prac->DOWOD_OSOB }, ;
   '#DOWOD' => { || AllTrim( prac->DOWOD_OSOB ) }, ;
   '@FIRMA' => { || firma->NAZWA }, ;
   '#FIRMA' => { || AllTrim( firma->NAZWA ) }, ;
   '@UL_FIRMY' => { || firma->ULICA + ' ' + firma->NR_DOMU + '/' + firma->NR_MIESZK }, ;
   '#UL_FIRMY' => { || AllTrim( firma->ULICA ) + ' ' + AllTrim( firma->NR_DOMU ) + '/' + AllTrim( firma->NR_MIESZK ) }, ;
   '@ADR_FIRMY' => { || firma->MIEJSC }, ;
   '#ADR_FIRMY' => { || AllTrim( firma->MIEJSC ) }, ;
   '@UMOWA' => { || umowy->NUMER }, ;
   '#UMOWA' => { || AllTrim( umowy->NUMER ) }, ;
   '@DATA_UM' => { || DToC( umowy->DATA_UMOWY ) }, ;
   '#DATA_UM' => { || DToC( umowy->DATA_UMOWY ) }, ;
   '@DATA_WYP' => { || DToC( umowy->DATA_WYP ) }, ;
   '#DATA_WYP' => { || DToC( umowy->DATA_WYP ) }, ;
   '@DATA_RA' => { || DToC( umowy->DATA_RACH ) }, ;
   '#DATA_RA' => { || DToC( umowy->DATA_RACH ) }, ;
   '@BRUTTO' => { || kwota( umowy->BRUT_RAZEM, 11, 2 ) }, ;
   '#BRUTTO' => { || AllTrim( kwota( umowy->BRUT_RAZEM, 11, 2 ) ) }, ;
   '@BSLOW' => { || slownie( umowy->BRUT_RAZEM ) }, ;
   '#BSLOW' => { || slownie( umowy->BRUT_RAZEM ) }, ;
   '@%KOSZT' => { || Str( umowy->KOSZTY, 5, 2 ) }, ;
   '#%KOSZT' => { || AllTrim( Str( umowy->KOSZTY, 5, 2 ) ) }, ;
   '@KOSZT' => { || kwota( umowy->KOSZT, 11, 2 ) }, ;
   '#KOSZT' => { || AllTrim( kwota( umowy->KOSZT, 11, 2 ) ) }, ;
   '@DOCHOD' => { || kwota( umowy->DOCHOD, 11, 2 ) }, ;
   '#DOCHOD' => { || AllTrim( kwota( umowy->DOCHOD, 11, 2 ) ) }, ;
   '@%PODATEK' => { || Str( umowy->STAW_PODA2, 5, 2 ) }, ;
   '#%PODATEK' => { || AllTrim( Str( umowy->STAW_PODA2, 5, 2 ) ) }, ;
   '@PODATEK' => { || kwota( umowy->PODATEK, 11, 2 ) }, ;
   '#PODATEK' => { || AllTrim( kwota( umowy->PODATEK, 11, 2 ) ) }, ;
   '@NETTO' => { || kwota( umowy->DO_WYPLATY, 11, 2 ) }, ;
   '#NETTO' => { || AllTrim( kwota( umowy->DO_WYPLATY, 11, 2 ) ) }, ;
   '@NSLOW' => { || slownie( umowy->DO_WYPLATY ) }, ;
   '#NSLOW' => { || AllTrim( slownie( umowy->DO_WYPLATY ) ) }, ;
   '@TEMAT1' => { || umowy->TEMAT1 }, ;
   '#TEMAT1' => { || AllTrim( umowy->TEMAT1 ) }, ;
   '@TEMAT2' => { || umowy->TEMAT2 }, ;
   '#TEMAT2' => { || AllTrim( umowy->TEMAT2 ) }, ;
   '@TERMIN' => { || DToC( umowy->TERMIN ) }, ;
   '#TERMIN' => { || DToC( umowy->TERMIN ) }, ;
   '@STAW_PUE' => { || kwota( umowy->STAW_PUE, 5, 2 ) }, ;
   '#STAW_PUE' => { || AllTrim( kwota( umowy->STAW_PUE, 5, 2 ) ) }, ;
   '@STAW_PUR' => { || kwota( umowy->STAW_PUR, 5, 2 ) }, ;
   '#STAW_PUR' => { || AllTrim( kwota( umowy->STAW_PUR, 5, 2 ) ) }, ;
   '@STAW_PUC' => { || kwota( umowy->STAW_PUC, 5, 2 ) }, ;
   '#STAW_PUC' => { || AllTrim( kwota( umowy->STAW_PUC, 5, 2 ) ) }, ;
   '@STAW_PSUM' => { || kwota( umowy->STAW_PSUM, 5, 2 ) }, ;
   '#STAW_PSUM' => { || AllTrim( kwota( umowy->STAW_PSUM, 5, 2 ) ) }, ;
   '@STAW_PUW' => { || kwota( umowy->STAW_PUW, 5, 2 ) }, ;
   '#STAW_PUW' => { || AllTrim( kwota( umowy->STAW_PUW, 5, 2 ) ) }, ;
   '@STAW_PUZ' => { || kwota( umowy->STAW_PUZ, 5, 2 ) }, ;
   '#STAW_PUZ' => { || AllTrim( kwota( umowy->STAW_PUZ, 5, 2 ) ) }, ;
   '@STAW_PZK' => { || kwota( umowy->STAW_PZK, 5, 2 ) }, ;
   '#STAW_PZK' => { || AllTrim( kwota( umowy->STAW_PZK, 5, 2 ) ) }, ;
   '@STAW_FUE' => { || kwota( umowy->STAW_FUE, 5, 2 ) }, ;
   '#STAW_FUE' => { || AllTrim( kwota( umowy->STAW_FUE, 5, 2 ) ) }, ;
   '@STAW_FUR' => { || kwota( umowy->STAW_FUR, 5, 2 ) }, ;
   '#STAW_FUR' => { || AllTrim( kwota( umowy->STAW_FUR, 5, 2 ) ) }, ;
   '@STAW_FUC' => { || kwota( umowy->STAW_FUC, 5, 2 ) }, ;
   '#STAW_FUC' => { || AllTrim( kwota( umowy->STAW_FUC, 5, 2 ) ) }, ;
   '@STAW_FUW' => { || kwota( umowy->STAW_FUW, 5, 2 ) }, ;
   '#STAW_FUW' => { || AllTrim( kwota( umowy->STAW_FUW, 5, 2 ) ) }, ;
   '@STAW_FUZ' => { || kwota( umowy->STAW_FUZ, 5, 2 ) }, ;
   '#STAW_FUZ' => { || AllTrim( kwota( umowy->STAW_FUZ, 5, 2 ) ) }, ;
   '@STAW_FSUM' => { || kwota( umowy->STAW_FSUM, 5, 2 ) }, ;
   '#STAW_FSUM' => { || AllTrim( kwota( umowy->STAW_FSUM, 5, 2 ) ) }, ;
   '@WAR_PUE' => { || kwota( umowy->WAR_PUE, 11, 2 ) }, ;
   '#WAR_PUE' => { || AllTrim( kwota( umowy->WAR_PUE, 11, 2 ) ) }, ;
   '@WAR_PUR' => { || kwota( umowy->WAR_PUR, 11, 2 ) }, ;
   '#WAR_PUR' => { || AllTrim( kwota( umowy->WAR_PUR, 11, 2 ) ) }, ;
   '@WAR_PUC' => { || kwota( umowy->WAR_PUC, 11, 2 ) }, ;
   '#WAR_PUC' => { || AllTrim( kwota( umowy->WAR_PUC, 11, 2 ) ) }, ;
   '@WAR_PSUM' => { || kwota( umowy->WAR_PSUM, 11, 2 ) }, ;
   '#WAR_PSUM' => { || AllTrim( kwota( umowy->WAR_PSUM, 11, 2 ) ) }, ;
   '@WAR_PUW' => { || kwota( umowy->WAR_PUW, 11, 2 ) }, ;
   '#WAR_PUW' => { || AllTrim( kwota( umowy->WAR_PUW, 11, 2 ) ) }, ;
   '@WAR_PUZ' => { || kwota( umowy->WAR_PUZ, 11, 2 ) }, ;
   '#WAR_PUZ' => { || AllTrim( kwota( umowy->WAR_PUZ, 11, 2 ) ) }, ;
   '@WAR_PZK' => { || kwota( umowy->WAR_PZK, 11, 2 ) }, ;
   '#WAR_PZK' => { || AllTrim( kwota( umowy->WAR_PZK, 11, 2 ) ) }, ;
   '@WAR_FUE' => { || kwota( umowy->WAR_FUE, 11, 2 ) }, ;
   '#WAR_FUE' => { || AllTrim( kwota( umowy->WAR_FUE, 11, 2 ) ) }, ;
   '@WAR_FUR' => { || kwota( umowy->WAR_FUR, 11, 2 ) }, ;
   '#WAR_FUR' => { || AllTrim( kwota( umowy->WAR_FUR, 11, 2 ) ) }, ;
   '@WAR_FUC' => { || kwota( umowy->WAR_FUC, 11, 2 ) }, ;
   '#WAR_FUC' => { || AllTrim( kwota( umowy->WAR_FUC, 11, 2 ) ) }, ;
   '@WAR_FUW' => { || kwota( umowy->WAR_FUW, 11, 2 ) }, ;
   '#WAR_FUW' => { || AllTrim( kwota( umowy->WAR_FUW, 11, 2 ) ) }, ;
   '@WAR_FUZ' => { || kwota( umowy->WAR_FUZ, 11, 2 ) }, ;
   '#WAR_FUZ' => { || AllTrim( kwota( umowy->WAR_FUZ, 11, 2 ) ) }, ;
   '@WAR_FSUM' => { || kwota( umowy->WAR_FSUM, 11, 2 ) }, ;
   '#WAR_FSUM' => { || AllTrim( kwota( umowy->WAR_FSUM, 11, 2 ) ) }, ;
   '@STAW_FFP' => { || kwota( umowy->STAW_FFP, 5, 2 ) }, ;
   '#STAW_FFP' => { || AllTrim( kwota( umowy->STAW_FFP, 5, 2 ) ) }, ;
   '@STAW_FFG' => { || kwota( umowy->STAW_FFG, 5, 2 ) }, ;
   '#STAW_FFG' => { || AllTrim( kwota( umowy->STAW_FFG, 5, 2 ) ) }, ;
   '@WAR_FFP' => { || kwota( umowy->WAR_FFP, 11, 2 ) }, ;
   '#WAR_FFP' => { || AllTrim( kwota( umowy->WAR_FFP, 11, 2 ) ) }, ;
   '@WAR_FFG' => { || kwota( umowy->WAR_FFG, 11, 2 ) }, ;
   '#WAR_FFG' => { || AllTrim( kwota( umowy->WAR_FFG, 11, 2 ) ) }, ;
   '@POTRACENIA' => { || kwota( umowy->POTRACENIA, 11, 2 ) }, ;
   '#POTRACENIA' => { || AllTrim( kwota( umowy->POTRACENIA, 11, 2 ) ) }, ;
   '@PPKZS1' => { || kwota( umowy->PPKZS1, 5, 2 ) }, ;
   '#PPKZS1' => { || AllTrim( kwota( umowy->PPKZS1, 5, 2 ) ) }, ;
   '@PPKZK1' => { || kwota( umowy->PPKZK1, 11, 2 ) }, ;
   '#PPKZK1' => { || AllTrim( kwota( umowy->PPKZK1, 11, 2 ) ) }, ;
   '@PPKZS2' => { || kwota( umowy->PPKZS2, 5, 2 ) }, ;
   '#PPKZS2' => { || AllTrim( kwota( umowy->PPKZS2, 5, 2 ) ) }, ;
   '@PPKZK2' => { || kwota( umowy->PPKZK2, 11, 2 ) }, ;
   '#PPKZK2' => { || AllTrim( kwota( umowy->PPKZK2, 11, 2 ) ) }, ;
   '@PPKPK1' => { || kwota( umowy->PPKPK1, 11, 2 ) }, ;
   '#PPKPK1' => { || AllTrim( kwota( umowy->PPKPK1, 11, 2 ) ) }, ;
   '@PPKPS2' => { || kwota( umowy->PPKPS2, 5, 2 ) }, ;
   '#PPKPS2' => { || AllTrim( kwota( umowy->PPKPS2, 5, 2 ) ) }, ;
   '@PPKPK2' => { || kwota( umowy->PPKPK2, 11, 2 ) }, ;
   '#PPKPK2' => { || AllTrim( kwota( umowy->PPKPK2, 11, 2 ) ) }, ;
   '@PPKPPM' => { || kwota( umowy->PPKPPM, 11, 2 ) }, ;
   '#PPKPPM' => { || AllTrim( kwota( umowy->PPKPPM, 11, 2 ) ) }, ;
   '@ZASI_BZUS' => { || kwota( umowy->ZASI_BZUS, 11, 2 ) }, ;
   '#ZASI_BZUS' => { || AllTrim( kwota( umowy->ZASI_BZUS, 11, 2 ) ) }, ;
   '@PODZDRO' => { || kwota( umowy->PENSJA - umowy->WAR_PSUM, 11, 2 ) }, ;
   '#PODZDRO' => { || AllTrim( kwota( umowy->PENSJA - umowy->WAR_PSUM, 11, 2 ) ) } }


*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±edycja wzorca UMOWY-ZLECENIA                                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Umowa( zbior )

   LOCAL tekst

   @ 1, 47 SAY '         '
   tekst := MemoRead( zbior )
   SET CURSOR ON
   @  3, 0 TO 14, 79 DOUBLE
   ColInf()
   Center( 3, ' Edycja zbioru ' + ZBIOR + ' ' )
   @ 23, 0 SAY ' Ctrl+W - zapami&_e.tanie wzoru      F2 - wstaw pole      ESC - zaniechanie edycji '
   SET COLOR TO
   @ 15, 0 SAY 'NAZWISKO   IMIE1 ULICA TERMIN DZISIAJ  $_FFP - fundusz pracy  & ="P"oplaca prac.'
   @ 16, 0 SAY 'ADR_FIRMY  IMIE2 LOKAL TEMAT1 DATA_UM  $_FFG - fundusz FGSP      "F"oplaca firma'
   @ 17, 0 SAY 'UL_FIRMY   PESEL FIRMA TEMAT2 DATA_RA  $_&UE - ubezp.emeryt.  $ ="STAW"- stawka '
   @ 18, 0 SAY 'MIEJSC_UR  NIP   UMOWA %KOSZT DATA_UR  $_&UR - ubezp.rentowe     "WAR"   wartosc'
   @ 19, 0 SAY 'MIEJSC_ZAM ZATR  DOWOD KOSZT  PODATEK  $_PUC - ubezp.chorob.      Przedrostki   '
   @ 20, 0 SAY 'DATA_WYP   KOD   NETTO BRUTTO IMIE_O   $_FUW - ubezp.wypadk.  # = spacje obciete'
   @ 21, 0 SAY '%PODATEK   DOM   NSLOW BSLOW  IMIE_M   $_PUZ - ub.zdr.do ZUS  @ = spacje drukow.'
   @ 22, 0 SAY 'POTRACENIA       ZASI_BZUS    PODZDRO  $_PZK - ub.zdr.do odl                    '

   *@ 19,0 say '@NAZWISKO  @IMIE1  @IMIE2  @IMIE_O  @IMIE_M  @MIEJSC_UR  @DATA_UR  @DOWOD @PESEL'
   *@ 20,0 say '@ZATR  @NIP  @MIEJSC_ZAM  @KOD  @GMINA  @ULICA  @DOM  @LOKAL   @DZISIAJ   @UMOWA'
   *@ 21,0 say '@DATA_UM  @DATA_RA  @TERMIN  @TEMAT1  @TEMAT2  @BRUTTO  @BSLOW   @NETTO   @NSLOW'
   *@ 22,0 say '@%KOSZT @KOSZT @DOCHOD @%PODATEK @PODATEK  @DATA_WYP @FIRMA @UL_FIRMY @ADR_FIRMY'

   SET KEY K_F2 TO UmowaWstaw
   tekst := MemoEdit( tekst, 4, 1, 13, 78, .T. )
   SET KEY K_F2 TO
   MemoWrit( ZBIOR, TEKST )
   SET CURSOR OFF
   ColStd()

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE UmowaWstaw()

   LOCAL nRes, cEkran, cKolor, nC := Col(), nR := Row(), aUmowaPola := hb_HKeys( aUmowaPolaTrans )
   SAVE SCREEN TO cEkran
   cKolor := ColStd()
   @ 4, 34 TO 22, 47
   SET CURSOR OFF
   IF ( nRes := AChoice(5, 35, 21, 46, aUmowaPola ) ) > 0
      KEYBOARD aUmowaPola[ nRes ]
   ENDIF
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )
   SET CURSOR ON
   DevPos( nR, nC )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION UmowaSzabWybierz( cRodzaj )

   LOCAL cEkran, cKolor, aPliki := {}, nWiersz, nDlug, nPlik := 0
   LOCAL aFiltr := { ;
      'U' => { 'umow*.odt', 'umow*.docx', 'umow*.doc' }, ;
      'R' => { 'rach*.odt', 'rach*.docx', 'rach*.doc' }, ;
      'W' => { 'wypl*.odt', 'wypl*.docx', 'wypl*.doc' } }
   LOCAL bZnajdz := { | |
      AEval( aFiltr[ cRodzaj ], { | cFiltr |
         AEval( Directory( cFiltr ), { | aPlik |
            nDlug := Max( Len( aPlik[ F_NAME ] ), nDlug )
            AAdd( aPliki, aPlik[ F_NAME ] )
         } )
      } )
   }

   IF ! cRodzaj $ 'RUW'
      RETURN
   ENDIF

   nDlug := 0
   Eval( bZnajdz )

   IF Len( aPliki ) == 0

      IF File( 'szablony.zip' )
         hb_Run( '7z e -aos szablony.zip > nul' )
      ENDIF

      Eval( bZnajdz )

      IF Len( aPliki ) == 0
         Komun( "Brak zdefiniowanych szablon¢w" )
         RETURN
      ENDIF

   ENDIF

   cEkran := SaveScreen()
   cKolor := ColPro()

   nWiersz := Min( Len( aPliki ), 21 )
   nDlug := Min( 77, nDlug )

   @ 21 - nWiersz, 0 TO 22, nDlug + 2
   nPlik := AChoice( 21 - nWiersz + 1, 1, 21, nDlug + 1, aPliki, .T., .T., nPlik )

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN iif( nPlik > 0, aPliki[ nPlik ], NIL )

/*----------------------------------------------------------------------*/

PROCEDURE UmowaSzabGraf( cRodzaj )

   LOCAL cPlik
   LOCAL oOODocument, oOOReplaceDescriptor, oOOFindDescriptor, oFound, aPola

   cPlik := UmowaSzabWybierz( cRodzaj )

   IF ! Empty( cPlik )

      cKolor := ColErr()
      @ 24, 0 SAY PadC( 'Generowanie dokumentu... Prosz© czeka†...', 80 )

      TRY

         oOODocument := OOWczytajDok( 'file:///' + StrTran( hb_DirBase(), '\', '/' ) + '/' + cPlik, .T. )

         IF ! Empty( oOODocument )

            aPola := {}
            oOOFindDescriptor := oOODocument:createSearchDescriptor()
            oOOFindDescriptor:setSearchString( '\{[^\{]*\}' )
            oOOFindDescriptor:SearchRegularExpression := .T.
            oFound := oOODocument:FindFirst( oOOFindDescriptor )
            DO WHILE ! Empty( oFound )
               IF AScan( aPola, oFound:getString() ) == 0
                  AAdd( aPola, oFound:getString() )
               ENDIF
               oFound := oOODocument:FindNext( oFound:End, oOOFindDescriptor )
            ENDDO

            oOOReplaceDescriptor := oOODocument:createReplaceDescriptor()
            AEval( aPola, { | cPole |
               LOCAL cKlucz, bBlok
               cKlucz := '#' + Upper( AllTrim( StrTran( StrTran( cPole, '{', '' ), '}', '' ) ) )
               IF hb_HHasKey( aUmowaPolaTrans, cKlucz )
                  oOOReplaceDescriptor:setSearchString( cPole )
                  oOOReplaceDescriptor:setReplaceString( Eval( aUmowaPolaTrans[ cKlucz ] ) )
                  oOODocument:replaceAll( oOOReplaceDescriptor )
               ENDIF
            } )

         ENDIF

      CATCH oErr

         Alert( 'Wyst¥piˆ bˆ¥d podczas pr¢by tworzenia dokumentu: ' + oErr:description )

      END

      SetColor( cKolor )
      @ 24, 0

   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE UmowaEdytujTekst( cFiltr )

   LOCAL _ilm
   LOCAL a, ZZ

   _ilm := ADir( cFiltr )
   a := Array( _ilm )
   ADir( cFiltr, a )
   ASort( a )
   ZZ := 0
   IF _ilm > 21
      _ilm := 21
   ENDIF
   @ 21 - _ilm, 20 TO 22, 33
   ZZ := AChoice( 21 - ( _ilm - 1 ), 21, 21, 32, a, .T., .T., ZZ )
   IF ZZ <> 0
      Umowa( AllTrim( a[ ZZ ] ) )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE UmowaEdytujGraf( cRodzaj )

   LOCAL cPlik

   cPlik := UmowaSzabWybierz( cRodzaj )

   IF ! Empty( cPlik )
      OOWczytajDok( 'file:///' + StrTran( hb_DirBase(), '\', '/' ) + '/' + cPlik, .F. )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION OOWczytajDok( cURL, lTemplate )

   LOCAL oOODocument, aOOOpenParams, oOOProp, oOOCls

   hb_default( @cURL, 'private:factory/swriter' )
   hb_default( @lTemplate, .T. )

   TRY

      oOOService := win_oleCreateObject( 'com.sun.star.ServiceManager' )
      oOODesktop := oOOService:createInstance( 'com.sun.star.frame.Desktop' )
      oOOCoreReflection := oOOService:createInstance( 'com.sun.star.reflection.CoreReflection' )

      IF lTemplate
         oOOCls := oOOCoreReflection:forName( 'com.sun.star.beans.PropertyValue' )
         oOOCls:CreateObject( @oOOProp )
         oOOProp:Name := 'AsTemplate'
         oOOProp:Value := .T.
         aOOOpenParams := { oOOProp }
      ELSE
         aOOOpenParams := {}
      ENDIF

      oOODocument := oOODesktop:LoadComponentFromURL( cURL, '_default', 0, aOOOpenParams )

   CATCH oErr

      Alert( 'Wyst¥piˆ bˆ¥d otwierania dokumentu: ' + oErr:description )

   END

   RETURN oOODocument

/*----------------------------------------------------------------------*/

