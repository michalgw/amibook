/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

#include "inkey.ch"

***blad ponownych wydrukow przy wydrukach dzielonych
***bez raport.dbf
***tworzenie wydruku podczas ogladania strony
***przesuwanie g¢ra d¢l za pomoca podswietlenia
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± MON_DRK  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
function mon_drk( _linia )

   IF nWybProfilDrukarkiIdx == 0
      nWybProfilDrukarkiIdx := nDomProfilDrukarkiIdx
   ENDIF

   RAPORT=RAPTEMP

   PRIVATE _kl, _pk, _i, _j, _zm, nStProfIdx

   *----------
   IF awaria
      commit_()
      CLEAR
      SET COLOR TO *w
      ? 'wydruk nie powinien dokonywac zmian w bazach danych'
      SET COLOR TO
      Tone( 100, 5 )
      SET CURSOR ON
      hbfr_FreeLibrary()
      amiDllZakoncz()
      WinPrintDone()
      CANCEL
   ENDIF
   *----------
   Inkey()
   IF LastKey() == K_ESC
      SET PRINTER TO
      SET DEVICE TO SCREEN
      SELECT 100
      ZAP
      USE
      SELECT 1
      BREAK
   ENDIF
*################################ S T A R T #################################

   IF Left( _linia,1 ) == 'ˆ'
      buforDruku := ''
      _linia := SubStr( _linia, 2 )

      PUBLIC _mon2, _mon3, _mon4, _mon5, _mon6, _mon7, _mon8, _mon9, _mon10
      PUBLIC _mon11, _mon12, _mon13, _mon14, _mon15, _mon16, _mon17, _mon18
      PUBLIC _mon19, _mon20, _mon21, _mon22, _mon23, _mon24
      PUBLIC _mon_drk, _kolumna, _wiersz

      _kolumna := 1
      _mon_drk := 2
      IF _czy_mon
         ColStd()
         @ 24, 0
         @ 24, 15 PROMPT '[ Monitor ]'
         @ 24, 35 PROMPT '[ Drukarka ]'
         @ 24, 57 PROMPT '[ Plik ]'
         CLEAR TYPE
         _mon_drk := menu( 1 )
         IF LastKey() == K_ESC
            BREAK
         ENDIF
      ENDIF
      *-----
      PUBLIC _druk_1, _druk_2, _druk_3, _druk_4, _druk_5, _druk_6, _druk_7
      PUBLIC _druk_8, _druk_81, _druk_82

      _druk_81 := kod_17cp + Space( 40 - Len( kod_17cp ) )
      _druk_82 := kod_17cp + Space( 40 - Len( kod_17cp ) )
      _druk_8 := 1
      IF File( _linia + '.mem' )
         RESTORE FROM ( _linia ) ADDITIVE
         stronap := 1
         stronak := 99999
      ELSE
         _druk_1 := 1
         _druk_2 := 60
         _druk_3 := 2
         _druk_4 := 0
         _druk_5 := 1
         _druk_6 := 2
         _druk_7 := 1
         _druk_8 := 1
         _druk_81 := kod_17cp + Space( 40 - Len( kod_17cp ) )
         _druk_82 := kod_17cp + Space( 40 - Len( kod_17cp ) )
         stronap := 1
         stronak := 99999
         SAVE TO (_linia) ALL LIKE _druk_*
      ENDIF
      DO CASE
      CASE _mon_drk == 1
         _wiersz := 1
         *** cls ***
         FOR _i := 24 TO 0 STEP -1
            @ _i, 0
            _j := 0
            DO WHILE _j < 20
               _j := _j + 1
            ENDDO
         NEXT
         ***********
         ColSti()
         @ 0, 0 SAY status()
         SET COLOR TO
         SELECT 100
         DO WHILE ! dostepex( RAPORT )
         ENDDO
         ZAP
         SELECT 1
         RETURN 0
      CASE _mon_drk == 2
         _wiersz := 0
         DO WHILE .T.
            ColInf()
            @ 23, 0 CLEAR TO 23, 79
            @ 24, 0 CLEAR TO 24, 79
            @ 23, 10 SAY 'Profil: ' + PadR( aProfileDrukarek[ nWybProfilDrukarkiIdx, 'nazwa' ], 28 ) + 'P - Wyb¢r profilu   W - Ust.drukarki'
            center( 24, 'ENTER - drukowanie     M - modyfikacja parametr&_o.w drukowania' )
            SET COLOR TO
            kartka()
            IF param_dzw == 'T'
               Tone( 400, 1 )
               Tone( 400, 1 )
               Tone( 400, 1 )
            ENDIF
            _kl := 0
            CLEAR TYPE
            DO WHILE _kl#K_ESC .AND. _kl#K_ENTER .AND. _kl#Asc( 'M' ) .AND. _kl#Asc( 'm' ) .AND. ;
               _kl#Asc( 'P' ) .AND. _kl#Asc( 'p' ) .AND. _kl#Asc( 'W' ) .AND. _kl#Asc( 'w' )

               _kl := Inkey( 0 )
            ENDDO
            ColStd()
            @ 24, 0
            IF _kl == K_ESC
               BREAK
            ENDIF

            IF _kl == Asc( 'P' ) .OR. _kl == Asc( 'p' ) // P
               nStProfIdx := WybierzProfilDrukarki( nWybProfilDrukarkiIdx )
               IF nStProfIdx > 0
                  nWybProfilDrukarkiIdx := nStProfIdx
               ENDIF
               LOOP
            ENDIF

            IF _kl == 87 .OR. _kl == 119 // W
               WinPrintPrinterSetupDlg( AllTrim( aProfileDrukarek[ nWybProfilDrukarkiIdx, 'drukarka' ] ) )
               LOOP
            ENDIF

            IF _kl == Asc( 'M' ) .OR. _kl == Asc( 'm' )
               SAVE SCREEN TO scr_
               * GRAFIKA 
               @  1, 42 CLEAR TO 22, 42
               SET COLOR TO i
               @  1, 43 SAY '     ≥ PICA CONDENSED (17 zn/cal)..1 '
               @  2, 43 SAY '     ≥                             2 '
               @  3, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @  4, 43 SAY '     ≥ pojedyncze kartki papieru...1 '
               @  5, 43 SAY '     ≥ ta&_s.ma papierowa sk&_l.adana....2 '
               @  6, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @  7, 43 SAY '     ≥ ilo&_s.&_c. wierszy na stronie....? '
               @  8, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @  9, 43 SAY '     ≥ druk zag&_e.szczony.(8w/cal)...1 '
               @ 10, 43 SAY '     ≥ druk normalny....(6w/cal)...2 '
               @ 11, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @ 12, 43 SAY '     ≥ lewy margines (ilo&_s.&_c. znak&_o.w)  '
               @ 13, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @ 14, 43 SAY '     ≥ wysuw papieru po wydruku....1 '
               @ 15, 43 SAY '     ≥ brak wysuwu papieru.........2 '
               @ 16, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @ 17, 43 SAY '     ≥ drukowanie dok&_l.adne.........1 '
               @ 18, 43 SAY '     ≥ drukowanie szybkie..........2 '
               @ 19, 43 SAY 'ƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ'
               @ 20, 43 SAY '     ≥ ilo&_s.&_c. wydruk&_o.w..............? '
               @ 21, 43 SAY '     ≥ od strony...................? '
               @ 22, 43 SAY '     ≥ do strony...................? '
               SET COLOR TO
               BEGIN SEQUENCE
                  * ZMIENNE 
                  _druk1 := _druk_1
                  _druk2 := _druk_2
                  _druk3 := _druk_3
                  _druk4 := _druk_4
                  _druk5 := _druk_5
                  _druk6 := _druk_6
                  _druk7 := _druk_7
                  _druk8 := _druk_8
                  _druk81 := _druk_81
                  _druk82 := _druk_82
                  * GET 
                  ColStd()
                  @  2, 45 GET _druk8  PICTURE '99'    RANGE 1, 2
                  @  2, 50 GET _druk82 PICTURE '@S27 ' + Replicate( 'X', 40 ) WHEN _druk8 == 2
                  @  5, 45 GET _druk1  PICTURE '99'    RANGE 1, 2
                  @  7, 45 GET _druk2  PICTURE '99'    RANGE 1, 99
                  @ 10, 45 GET _druk3  PICTURE '99'    RANGE 1, 2
                  @ 12, 45 GET _druk4  PICTURE '99'    RANGE 0, 99
                  @ 15, 45 GET _druk5  PICTURE '99'    RANGE 1, 2
                  @ 18, 45 GET _druk6  PICTURE '99'    RANGE 1, 2
                  @ 20, 43 GET _druk7  PICTURE '99999' RANGE 1, 99
                  @ 21, 43 GET stronap PICTURE '99999' RANGE 1, 99999
                  @ 22, 43 GET stronak PICTURE '99999' RANGE 1, 99999
                  CLEAR TYPE
                  read_()
                  SET COLO TO
                  IF lastkey() == K_ESC
                     BREAK
                  ENDIF
                  * REPL 
                  _druk_1 := _druk1
                  _druk_2 := _druk2
                  _druk_3 := _druk3
                  _druk_4 := _druk4
                  _druk_5 := _druk5
                  _druk_6 := _druk6
                  _druk_7 := _druk7
                  _druk_8 := _druk8
                  _druk_81 := _druk81
                  _druk_82 := _druk82
                  SAVE TO (_linia) ALL LIKE _druk_*
                  *
               END
               RESTORE SCREEN FROM scr_
               LOOP
            ENDIF
            ColInb()
            @ 24, 0
            center( 24, 'Prosz&_e. czeka&_c....' )
            SET COLOR TO

            IF Len( buforDruku ) > 0
               buforDruku := buforDruku + kod_eject
            ENDIF
            buforDruku := buforDruku + &kod_res + Chr( 13 )
            IF _druk_8 == 1
               KODS := kod_17cp
            ELSE
               KODS := AllTrim( _druk_82 )
               IF Len( KODS ) == 0
                  KODS := kod_17cp
               ENDIF
            ENDIF
            kodStartDruku := &KODS + iif( _druk_3 == 1, &kod_8wc, &kod_6wc ) + Chr( 13 )
            buforDruku := buforDruku + &KODS + iif( _druk_3 == 1, &kod_8wc, &kod_6wc ) + Chr( 13 )
            EXIT
         ENDDO
         SELECT 100
         USE
         DO WHILE ! dostepex( RAPORT )
         ENDDO
         ZAP
         SELECT 1
         RETURN 0
      CASE _mon_drk == 3
         _wiersz := 0
         ColStd()
         @ 24, 0
         _pk := Space( 8 )
         @ 24, 30 SAY 'Nazwa pliku' GET _pk PICTURE '@A' VALID plik_()
         read_()
         IF LastKey() == K_ESC
            BREAK
         ENDIF
         _pk := AllTrim( _pk ) + '.txt'
         ColInb()
         @ 24, 0
         center( 24, 'Prosz&_e. czeka&_c....' )
         SET COLOR TO
         SET DEVICE TO PRINT
         SET PRINTER TO &_pk
         SELECT 1
         RETURN 0
      ENDCASE
   ENDIF

   IF _druk_8 == 1
      KODS := kod_17cp
   ELSE
      KODS := AllTrim( _druk_82 )
      IF Len( KODS ) == 0
         KODS := kod_17cp
      ENDIF
   ENDIF

   SELECT 100
   STRONAB := _wiersz / _druk_2 + 1
   stronakon := stronak + 1
   stronapocz := stronap

   IF aProfileDrukarek[ nWybProfilDrukarkiIdx, 'szercal' ] == 10 .AND. ( CZESC == 2 .OR. CZESC == 3 ) .AND. _mon_drk == 2
      STRONAB := _wiersz / _druk_2
   ENDIF

   *############################# D R U K A R K A ##############################
   IF _mon_drk == 2
      IF _linia == '˛'
         *==============kolejne wydruki==============
         BEGIN SEQUENCE
            FOR _kl := 2 TO _druk_7
               _wiersz := iif( _druk_5 ==1, 0, _wiersz )
               GO TOP
               DO WHILE ! Eof()
                  *---------
                  IF Mod( _wiersz, _druk_2 ) == 0 .AND. stronab > stronapocz .AND. stronab < stronakon
                     IF Len( buforDruku ) > 0
                        buforDruku := buforDruku + kod_eject
                     ENDIF
                     IF aProfileDrukarek[ nWybProfilDrukarkiIdx, 'podzialstr' ] == .T.
                        drukujNowy( buforDruku, 1, aProfileDrukarek[ nWybProfilDrukarkiIdx ] )
                        buforDruku := ''
                        IF _druk_1 == 1
                           IF ! entesc( '*u', ' Zmie&_n. papier i naci&_s.nij [Enter] ' )
                              BREAK
                           ENDIF
                           SET COLOR TO *w
                           center( 24, 'Prosz&_e. czeka&_c....' )
                           buforDruku := buforDruku + &KODS + iif( _druk_3 == 1, &kod_8wc, &kod_6wc ) + Chr( 13 )
                        ENDIF
                     ENDIF
                  ENDIF
                  _linia := RTrim( linia_l + linia_p )
                  buforDruku := buforDruku + Space( _druk_4 ) + _linia + &kod_lf  // WinPrint
                  _wiersz := _wiersz + 1
                  *---------
                  SKIP
               ENDDO
            NEXT
         END
         *===========================================
         IF _druk_5 == 1
            IF Len( buforDruku ) > 0
               buforDruku := buforDruku + kod_eject
            ENDIF
            IF aProfileDrukarek[ nWybProfilDrukarkiIdx, 'podzialstr' ] == .T.
               drukujNowy( buforDruku, 1, aProfileDrukarek[ nWybProfilDrukarkiIdx ] )
               buforDruku := ''
            ENDIF
         ELSE
            buforDruku := buforDruku + &kod_res + Chr( 13 )
         ENDIF
         *******nowe drukowanie
         SELECT 100
         ZAP
         USE
         SELECT 1
         drukujNowy( buforDruku, 1, aProfileDrukarek[ nWybProfilDrukarkiIdx ] )
         buforDruku := ''
         @ 24, 0
         IF param_dzw == 'T'
            Tone( 500, 3 )
         ENDIF
         RETURN 0
      ENDIF

      IF Mod( _wiersz, _druk_2 ) == 0 .AND. stronab > stronapocz .AND. stronab < stronakon
         IF Len( buforDruku ) > 0
            buforDruku := buforDruku + kod_eject
         ENDIF
         IF aProfileDrukarek[ nWybProfilDrukarkiIdx, 'podzialstr' ] == .T.
            drukujNowy( buforDruku, 1, aProfileDrukarek[ nWybProfilDrukarkiIdx ] )
            buforDruku := kodStartDruku
            IF _wiersz#0
               IF _druk_1 == 1
                  IF ! entesc( '*u',' Zmie&_n. papier i naci&_s.nij [Enter] ' )
                     ZAP
                     USE
                     SELECT 1
                     BREAK
                  ENDIF
                  SET COLOR TO *w
                  center( 24, 'Prosz&_e. czeka&_c....' )
                  SET COLOR TO
               ENDIF
            ENDIF
         ENDIF

         IF _strona .AND. stronab >= stronapocz .AND. stronab < stronakon
            _kl := 'str. ' + LTrim( Str( STRONAB, 10 ) )
            _kl := SubStr( Space( _prawa - _lewa - Len( _kl ) + 1 ) + _kl, _lewa, _prawa - _lewa + 1 )
            IF _druk_7#1
               APPEND BLANK
               REPL linia_l WITH Left( _kl, 190 )
               REPL linia_p WITH SubStr( _kl, 191 )
            ENDIF
            buforDruku := buforDruku + Space( _druk_4 ) + _kl + &kod_lf
            _wiersz := _wiersz + 1
         ENDIF
      ENDIF
      _linia := SubStr( _linia, _lewa, _prawa - _lewa + 1 )
      IF _druk_6 == 2
         _linia := StrTran( _linia, 'ƒ', '-' )
         _linia := StrTran( _linia, '≥', '|' )
         _linia := StrTran( _linia, '⁄', '-' )
         _linia := strtran( _linia, 'ø', '-' )
         _linia := StrTran( _linia, 'Ÿ', '-' )
         _linia := StrTran( _linia, '¿', '-' )
         _linia := StrTran( _linia, '¬', '-' )
         _linia := StrTran( _linia, '¡', '-' )
         _linia := StrTran( _linia, '√', '|' )
         _linia := StrTran( _linia, '¥', '|' )
         _linia := StrTran( _linia, '≈', '|' )
         *-----
         _linia := StrTran( _linia, 'Õ', '=' )
         _linia := StrTran( _linia, '∆', '=' )
         _linia := StrTran( _linia, 'µ', '=' )
         _linia := StrTran( _linia, '’', '=' )
         _linia := StrTran( _linia, '‘', '=' )
         _linia := StrTran( _linia, '∏', '=' )
   *     _linia=strtran(_linia,[æ],[=])
         _linia := StrTran( _linia, 'ÿ', '=' )
         _linia := StrTran( _linia, '—', '=' )
         _linia := StrTran( _linia, 'œ', '=' )
      ENDIF
      IF _druk_7#1 .AND. stronab >= stronapocz .AND. stronab < stronakon
         APPEND BLANK
         REPL linia_l WITH Left( _linia, 190 )
         REPL linia_p WITH SubStr( _linia, 191 )
      ENDIF
      IF stronab >= stronapocz .AND. stronab < stronakon
         buforDruku := buforDruku + Space( _druk_4 ) + _linia + &kod_lf
      ENDIF
      _wiersz := _wiersz + 1
      SELECT 1
      RETURN 0
   ENDIF
*################################# P L I K ##################################
   IF _mon_drk == 3
      IF _linia == '˛'
         SET PRINTER TO
         SET DEVICE TO SCREEN
         @ 24, 0
         IF param_dzw == 'T'
            Tone( 500, 3 )
         ENDIF
         SELECT 1
         RETURN 0
      ENDIF
      IF Mod( _wiersz, _druk_2 ) == 0 .AND. _strona
         _kl := 'str. ' + LTrim( Str( STRONAB, 10 ) )
         _kl := SubStr( Space( _prawa - _lewa - Len( _kl ) + 1 ) + _kl, _lewa, _prawa - _lewa + 1 )
         @ 0, 0 SAY _kl
         _wiersz := _wiersz + 1
      ENDIF
      _linia := SubStr( _linia, _lewa, _prawa - _lewa + 1 )
      IF _druk_6 == 2
         _linia := StrTran( _linia, 'ƒ', '-' )
         _linia := StrTran( _linia, '≥', '|' )
         _linia := StrTran( _linia, '⁄', '-' )
         _linia := StrTran( _linia, 'ø', '-' )
         _linia := StrTran( _linia, 'Ÿ', '-' )
         _linia := StrTran( _linia, '¿', '-' )
         _linia := StrTran( _linia, '¬', '-' )
         _linia := StrTran( _linia, '¡', '-' )
         _linia := StrTran( _linia, '√', '|' )
         _linia := StrTran( _linia, '¥', '|' )
         _linia := StrTran( _linia, '≈', '|' )
         *-----
         _linia := StrTran( _linia, 'Õ', '=' )
         _linia := StrTran( _linia, '∆', '=' )
         _linia := StrTran( _linia, 'µ', '=' )
         _linia := StrTran( _linia, '’', '=' )
         _linia := StrTran( _linia, '‘', '=' )
         _linia := StrTran( _linia, '∏', '=' )
   *     _linia := StrTran( _linia, 'æ', '=' )
         _linia := StrTran( _linia, 'ÿ', '=' )
         _linia := StrTran( _linia, '—', '=' )
         _linia := StrTran( _linia, 'œ', '=' )
      ENDIF
      @ PRow() + 1, 0 SAY _linia
      _wiersz := _wiersz + 1
      SELECT 1
      RETURN 0
   ENDIF
*############################## M O N I T O R ###############################

   IF _linia == '˛'
      SKIP
      FOR _wiersz := recc() TO 22
         scrol()
      NEXT
      SKIP -1
   ELSE
      APPEND BLANK
      REPL linia_l WITH Left( _linia, 190 )
      REPL linia_p WITH SubStr( _linia, 191 )
      _wiersz := _wiersz + 1
      scrol()
      IF _wiersz < 24
         SELECT 1
         RETURN 0
      ENDIF
   ENDIF

   _pk := .F.
   _kl := 0
   SET COLOR TO i
   ColSti()
   @ 0, 47 SAY '[F1]-pomoc'
   SET COLOR TO
   commit_()

   DO WHILE _kl#K_ESC
      _kl := Inkey( 0 )
      DO CASE
      CASE ( _kl == K_RIGHT .OR. _kl == Asc( '6' ) ) .AND. _kolumna + 79 < _szerokosc
         RestScreen( 2, 0, 24, 78, SaveScreen( 2, 1, 24, 79 ) )
         _kolumna := _kolumna + 1
         @  2, 79 SAY SubStr( _mon2 ,_kolumna + 79, 1 )
         @  3, 79 SAY SubStr( _mon3 ,_kolumna + 79, 1 )
         @  4, 79 SAY SubStr( _mon4 ,_kolumna + 79, 1 )
         @  5, 79 SAY SubStr( _mon5 ,_kolumna + 79, 1 )
         @  6, 79 SAY SubStr( _mon6 ,_kolumna + 79, 1 )
         @  7, 79 SAY SubStr( _mon7 ,_kolumna + 79, 1 )
         @  8, 79 SAY SubStr( _mon8 ,_kolumna + 79, 1 )
         @  9, 79 SAY SubStr( _mon9 ,_kolumna + 79, 1 )
         @ 10, 79 SAY SubStr( _mon10,_kolumna + 79, 1 )
         @ 11, 79 SAY SubStr( _mon11,_kolumna + 79, 1 )
         @ 12, 79 SAY SubStr( _mon12,_kolumna + 79, 1 )
         @ 13, 79 SAY SubStr( _mon13,_kolumna + 79, 1 )
         @ 14, 79 SAY SubStr( _mon14,_kolumna + 79, 1 )
         @ 15, 79 SAY SubStr( _mon15,_kolumna + 79, 1 )
         @ 16, 79 SAY SubStr( _mon16,_kolumna + 79, 1 )
         @ 17, 79 SAY SubStr( _mon17,_kolumna + 79, 1 )
         @ 18, 79 SAY SubStr( _mon18,_kolumna + 79, 1 )
         @ 19, 79 SAY SubStr( _mon19,_kolumna + 79, 1 )
         @ 20, 79 SAY SubStr( _mon20,_kolumna + 79, 1 )
         @ 21, 79 SAY SubStr( _mon21,_kolumna + 79, 1 )
         @ 22, 79 SAY SubStr( _mon22,_kolumna + 79, 1 )
         @ 23, 79 SAY SubStr( _mon23,_kolumna + 79, 1 )
         @ 24, 79 SAY SubStr( _mon24,_kolumna + 79, 1 )
      CASE ( _kl == K_LEFT .OR. _kl == Asc( '4' ) ) .AND. _kolumna > 1
         RestScreen( 2, 1, 24, 79, SaveScreen( 2, 0, 24, 78 ) )
         _kolumna := _kolumna - 1
         @  2,0 SAY SubStr( _mon2 ,_kolumna, 1 )
         @  3,0 SAY SubStr( _mon3 ,_kolumna, 1 )
         @  4,0 SAY SubStr( _mon4 ,_kolumna, 1 )
         @  5,0 SAY SubStr( _mon5 ,_kolumna, 1 )
         @  6,0 SAY SubStr( _mon6 ,_kolumna, 1 )
         @  7,0 SAY SubStr( _mon7 ,_kolumna, 1 )
         @  8,0 SAY SubStr( _mon8 ,_kolumna, 1 )
         @  9,0 SAY SubStr( _mon9 ,_kolumna, 1 )
         @ 10,0 SAY SubStr( _mon10,_kolumna, 1 )
         @ 11,0 SAY SubStr( _mon11,_kolumna, 1 )
         @ 12,0 SAY SubStr( _mon12,_kolumna, 1 )
         @ 13,0 SAY SubStr( _mon13,_kolumna, 1 )
         @ 14,0 SAY SubStr( _mon14,_kolumna, 1 )
         @ 15,0 SAY SubStr( _mon15,_kolumna, 1 )
         @ 16,0 SAY SubStr( _mon16,_kolumna, 1 )
         @ 17,0 SAY SubStr( _mon17,_kolumna, 1 )
         @ 18,0 SAY SubStr( _mon18,_kolumna, 1 )
         @ 19,0 SAY SubStr( _mon19,_kolumna, 1 )
         @ 20,0 SAY SubStr( _mon20,_kolumna, 1 )
         @ 21,0 SAY SubStr( _mon21,_kolumna, 1 )
         @ 22,0 SAY SubStr( _mon22,_kolumna, 1 )
         @ 23,0 SAY SubStr( _mon23,_kolumna, 1 )
         @ 24,0 SAY SubStr( _mon24,_kolumna, 1 )
      CASE ( _kl == K_UP .OR. _kl == Asc( '8' ) ) .AND. recc() >= 23
         IF ! _pk
            GO RecNo() - 22
            _pk := .T.
         ENDIF
         IF RecNo() > 1
            skip -1
            scrol_()
         ENDIF
         CLEAR TYPE
      CASE ( _kl == K_DOWN .OR. _kl == Asc( '2' ) ) .AND. recc() >= 23
         IF _pk
            GO RecNo() + 22
            _pk := .F.
         ENDIF
         IF RecNo() == recc()
            IF _linia#'˛'
               _wiersz := 23
               SELECT 1
               RETURN 0
            ENDIF
         ELSE
            SKIP
            scrol()
         ENDIF
         CLEAR TYPE
      CASE ( _kl == K_HOME .OR. _kl == Asc( '7' ) ) .AND. _kolumna > 1
         _kolumna := 1
         @  2, 0 SAY Left( _mon2 , 80 )
         @  3, 0 SAY Left( _mon3 , 80 )
         @  4, 0 SAY Left( _mon4 , 80 )
         @  5, 0 SAY Left( _mon5 , 80 )
         @  6, 0 SAY Left( _mon6 , 80 )
         @  7, 0 SAY Left( _mon7 , 80 )
         @  8, 0 SAY Left( _mon8 , 80 )
         @  9, 0 SAY Left( _mon9 , 80 )
         @ 10, 0 SAY Left( _mon10, 80 )
         @ 11, 0 SAY Left( _mon11, 80 )
         @ 12, 0 SAY Left( _mon12, 80 )
         @ 13, 0 SAY Left( _mon13, 80 )
         @ 14, 0 SAY Left( _mon14, 80 )
         @ 15, 0 SAY Left( _mon15, 80 )
         @ 16, 0 SAY Left( _mon16, 80 )
         @ 17, 0 SAY Left( _mon17, 80 )
         @ 18, 0 SAY Left( _mon18, 80 )
         @ 19, 0 SAY Left( _mon19, 80 )
         @ 20, 0 SAY Left( _mon20, 80 )
         @ 21, 0 SAY Left( _mon21, 80 )
         @ 22, 0 SAY Left( _mon22, 80 )
         @ 23, 0 SAY Left( _mon23, 80 )
         @ 24, 0 SAY Left( _mon24, 80 )
      CASE (_kl == K_END .OR. _kl == Asc( '1' ) ) .AND. _kolumna + 80 <= _szerokosc
         _kolumna := _szerokosc - 79
         @  2, 0 SAY SubStr( _mon2 , _kolumna, 80)
         @  3, 0 SAY SubStr( _mon3 , _kolumna, 80)
         @  4, 0 SAY SubStr( _mon4 , _kolumna, 80)
         @  5, 0 SAY SubStr( _mon5 , _kolumna, 80)
         @  6, 0 SAY SubStr( _mon6 , _kolumna, 80)
         @  7, 0 SAY SubStr( _mon7 , _kolumna, 80)
         @  8, 0 SAY SubStr( _mon8 , _kolumna, 80)
         @  9, 0 SAY SubStr( _mon9 , _kolumna, 80)
         @ 10, 0 SAY SubStr( _mon10, _kolumna, 80)
         @ 11, 0 SAY SubStr( _mon11, _kolumna, 80)
         @ 12, 0 SAY SubStr( _mon12, _kolumna, 80)
         @ 13, 0 SAY SubStr( _mon13, _kolumna, 80)
         @ 14, 0 SAY SubStr( _mon14, _kolumna, 80)
         @ 15, 0 SAY SubStr( _mon15, _kolumna, 80)
         @ 16, 0 SAY SubStr( _mon16, _kolumna, 80)
         @ 17, 0 SAY SubStr( _mon17, _kolumna, 80)
         @ 18, 0 SAY SubStr( _mon18, _kolumna, 80)
         @ 19, 0 SAY SubStr( _mon19, _kolumna, 80)
         @ 20, 0 SAY SubStr( _mon20, _kolumna, 80)
         @ 21, 0 SAY SubStr( _mon21, _kolumna, 80)
         @ 22, 0 SAY SubStr( _mon22, _kolumna, 80)
         @ 23, 0 SAY SubStr( _mon23, _kolumna, 80)
         @ 24, 0 SAY SubStr( _mon24, _kolumna, 80)
      CASE _kl == K_CTRL_RIGHT .AND. _kolumna + 80 <= _szerokosc
         restscreen( 2, 0, 24, 79 - Min( 10, _szerokosc - _kolumna - 79 ), SaveScreen( 2, Min( 10, _szerokosc - _kolumna - 79 ), 24, 79 ) )
         _kolumna := Min( _szerokosc - 79, _kolumna + 10 )
         @  2, 70 SAY SubStr( _mon2 , _kolumna + 70, 10 )
         @  3, 70 SAY SubStr( _mon3 , _kolumna + 70, 10 )
         @  4, 70 SAY SubStr( _mon4 , _kolumna + 70, 10 )
         @  5, 70 SAY SubStr( _mon5 , _kolumna + 70, 10 )
         @  6, 70 SAY SubStr( _mon6 , _kolumna + 70, 10 )
         @  7, 70 SAY SubStr( _mon7 , _kolumna + 70, 10 )
         @  8, 70 SAY SubStr( _mon8 , _kolumna + 70, 10 )
         @  9, 70 SAY SubStr( _mon9 , _kolumna + 70, 10 )
         @ 10, 70 SAY SubStr( _mon10, _kolumna + 70, 10 )
         @ 11, 70 SAY SubStr( _mon11, _kolumna + 70, 10 )
         @ 12, 70 SAY SubStr( _mon12, _kolumna + 70, 10 )
         @ 13, 70 SAY SubStr( _mon13, _kolumna + 70, 10 )
         @ 14, 70 SAY SubStr( _mon14, _kolumna + 70, 10 )
         @ 15, 70 SAY SubStr( _mon15, _kolumna + 70, 10 )
         @ 16, 70 SAY SubStr( _mon16, _kolumna + 70, 10 )
         @ 17, 70 SAY SubStr( _mon17, _kolumna + 70, 10 )
         @ 18, 70 SAY SubStr( _mon18, _kolumna + 70, 10 )
         @ 19, 70 SAY SubStr( _mon19, _kolumna + 70, 10 )
         @ 20, 70 SAY SubStr( _mon20, _kolumna + 70, 10 )
         @ 21, 70 SAY SubStr( _mon21, _kolumna + 70, 10 )
         @ 22, 70 SAY SubStr( _mon22, _kolumna + 70, 10 )
         @ 23, 70 SAY SubStr( _mon23, _kolumna + 70, 10 )
         @ 24, 70 SAY SubStr( _mon24, _kolumna + 70, 10 )
      CASE _kl == K_CTRL_LEFT .AND. _kolumna > 1
         RestScreen( 2, Min( 10, _kolumna - 1 ), 24, 79, SaveScreen( 2, 0, 24, 79 - Min( 10, _kolumna - 1 ) ) )
         _kolumna := Max( 1, _kolumna - 10 )
         @  2, 0 SAY SubStr( _mon2 , _kolumna, 10 )
         @  3, 0 SAY SubStr( _mon3 , _kolumna, 10 )
         @  4, 0 SAY SubStr( _mon4 , _kolumna, 10 )
         @  5, 0 SAY SubStr( _mon5 , _kolumna, 10 )
         @  6, 0 SAY SubStr( _mon6 , _kolumna, 10 )
         @  7, 0 SAY SubStr( _mon7 , _kolumna, 10 )
         @  8, 0 SAY SubStr( _mon8 , _kolumna, 10 )
         @  9, 0 SAY SubStr( _mon9 , _kolumna, 10 )
         @ 10, 0 SAY SubStr( _mon10, _kolumna, 10 )
         @ 11, 0 SAY SubStr( _mon11, _kolumna, 10 )
         @ 12, 0 SAY SubStr( _mon12, _kolumna, 10 )
         @ 13, 0 SAY SubStr( _mon13, _kolumna, 10 )
         @ 14, 0 SAY SubStr( _mon14, _kolumna, 10 )
         @ 15, 0 SAY SubStr( _mon15, _kolumna, 10 )
         @ 16, 0 SAY SubStr( _mon16, _kolumna, 10 )
         @ 17, 0 SAY SubStr( _mon17, _kolumna, 10 )
         @ 18, 0 SAY SubStr( _mon18, _kolumna, 10 )
         @ 19, 0 SAY SubStr( _mon19, _kolumna, 10 )
         @ 20, 0 SAY SubStr( _mon20, _kolumna, 10 )
         @ 21, 0 SAY SubStr( _mon21, _kolumna, 10 )
         @ 22, 0 SAY SubStr( _mon22, _kolumna, 10 )
         @ 23, 0 SAY SubStr( _mon23, _kolumna, 10 )
         @ 24, 0 SAY SubStr( _mon24, _kolumna, 10 )
      CASE ( _kl == K_PGUP .OR. _kl == Asc( '9' ) ) .AND. recc() >= 23
         IF ! _pk
            GO RecNo() - 22
            _pk := .T.
         ENDIF
         FOR _wiersz := 1 TO 23
            SKIP -1
            IF Bof()
               EXIT
            ENDIF
            scrol_()
         NEXT
         CLEAR TYPE
      CASE ( _kl == K_PGDN .OR. _kl == Asc( '3' ) ) .AND. recc() >= 23
         IF _pk
            go RecNo() + 22
            _pk := .F.
         ENDIF
         IF RecNo() < recc() .OR. _linia#'˛'
            FOR _wiersz := 1 TO 23
               SKIP
               IF Eof()
                  IF _linia == '˛'
                     SKIP -1
                     EXIT
                  ELSE
                     SELECT 1
                     RETURN 0
                  ENDIF
               ENDIF
               scrol()
            NEXT
         ENDIF
         clear TYPE
      CASE _kl == K_F1
         SAVE SCREEN TO scr_
         SET COLOR TO i
         @ 0, 47 SAY '          '
         SET COLOR TO
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                  '
         p[ 2 ] := '   ['+chr(24)+'/'+chr(25)+']...........przewijanie pionowe            '
         p[ 3 ] := '   [PgUp/PgDn].....poprzednia/nast&_e.pna strona     '
         p[ 4 ] := '   ['+chr(27)+'/'+chr(26)+']...........przewijanie poziome            '
         p[ 5 ] := '   [Ctrl '+chr(27)+'/'+chr(26)+']......przewijanie poziome szybkie    '
         p[ 6 ] := '   [Home/End]......lewa/prawa cz&_e.&_s.&_c. zestawienia   '
         p[ 7 ] := '   [Esc]...........wyj&_s.cie                        '
         p[ 8 ] := '                                                  '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[ i ]' )#'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause(0)
         IF LastKey()#K_ESC .AND. LastKey()#K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
      ENDCASE
   ENDDO
   ZAP
   USE
   SELECT 1
   BREAK
   RETURN 0

****************
PROCEDURE scrol()

   Scroll( 2, ( 80 - Min( _szerokosc, 80 ) ) / 2, 24, ( 78 + Min( _szerokosc, 80 ) ) / 2, 1 )

   @ 24, 0 SAY PadC( SubStr( linia_l + linia_p, _kolumna, Min( _szerokosc, 80 ) ), 80 )
   _mon2 := _mon3
   _mon3 := _mon4
   _mon4 := _mon5
   _mon5 := _mon6
   _mon6 := _mon7
   _mon7 := _mon8
   _mon8 := _mon9
   _mon9 := _mon10
   _mon10 := _mon11
   _mon11 := _mon12
   _mon12 := _mon13
   _mon13 := _mon14
   _mon14 := _mon15
   _mon15 := _mon16
   _mon16 := _mon17
   _mon17 := _mon18
   _mon18 := _mon19
   _mon19 := _mon20
   _mon20 := _mon21
   _mon21 := _mon22
   _mon22 := _mon23
   _mon23 := _mon24
   _mon24 := linia_l + linia_p

   RETURN

****************
PROCEDURE scrol_()

   Scroll( 2, ( 80 - Min( _szerokosc, 80 ) ) / 2, 24, ( 78 + Min( _szerokosc, 80 ) ) / 2, -1 )
   @ 2, 0 SAY PadC( SubStr( linia_l + linia_p, _kolumna, Min( _szerokosc, 80 ) ), 80 )
   _mon24 := _mon23
   _mon23 := _mon22
   _mon22 := _mon21
   _mon21 := _mon20
   _mon20 := _mon19
   _mon19 := _mon18
   _mon18 := _mon17
   _mon17 := _mon16
   _mon16 := _mon15
   _mon15 := _mon14
   _mon14 := _mon13
   _mon13 := _mon12
   _mon12 := _mon11
   _mon11 := _mon10
   _mon10 := _mon9
   _mon9 := _mon8
   _mon8 := _mon7
   _mon7 := _mon6
   _mon6 := _mon5
   _mon5 := _mon4
   _mon4 := _mon3
   _mon3 := _mon2
   _mon2 := linia_l + linia_p

   RETURN

***************************************
FUNCTION plik_()

   IF Empty( _pk ) .OR. ' '$AllTrim( _pk )
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************
FUNCTION kartka()

   LOCAL cucol

   DO CASE
   CASE _papsz == 1
      cucol := SetColor()
      SET COLO TO w
      @ MaxRow() - 2, 2 SAY ':€€€€:'
      @ MaxRow() - 1, 2 SAY ':€€€€:'
      @ MaxRow(),     2 SAY ':€€€€:'
      SET COLO TO /w
      @ MaxRow() - 1, 4 SAY 'A4'
      SetColor( CUCOL )
   CASE _papsz == 2
      cucol := SetColor()
      SET COLO TO w
      @ MaxRow() - 1, 1 SAY ':€€€€€€:'
      @ MaxRow(),     1 SAY ':€€€€€€:'
      SET COLO TO /w
      @ MaxRow(),     4 SAY 'A4'
      SetColor( CUCOL )
   CASE _papsz == 3
      CUCOL := SetColor()
      SET COLO TO w
      @ MaxRow() - 2, 0 SAY ':€€€€€€€€:'
      @ MaxRow() - 1, 0 SAY ':€€€€€€€€:'
      @ MaxRow(),     0 SAY ':€€€€€€€€:'
      SET COLO TO /w
      @ MaxRow() - 1, 4 SAY 'A3'
      SetColor( CUCOL )
   ENDCASE

   RETURN .T.

***************************************************
FUNCTION mon_drk2( _glmondrk2, _stmondrk2, _trmondrk2 )

   DO &_glmondrk2
   mon_drk( _trmondrk2 )
   strona := strona + 1
   DO &_stmondrk2

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
