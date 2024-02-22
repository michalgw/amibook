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

#include "inkey.ch"

FUNCTION Ewid()

   miesiac := '  '
   ewid_wyst := Space( 30 )
   ewid_rz1s := 'N'
   ewid_rz1k := 'N'
   ewid_rz1i := '**'
   ewid_rz1z := 'N'
   ewid_rz2s := 'N'
   ewid_rz2k := 'N'
   ewid_rz2i := '**'
   ewid_rz2z := 'N'
   ewid_rz3s := 'N'
   ewid_rz3k := 'N'
   ewid_rz3i := '**'
   ewid_rz3z := 'N'
   ewid_rs1s := 'N'
   ewid_rs1k := 'N'
   ewid_rs1i := '**'
   ewid_rs1z := 'N'
   ewid_rs2s := 'N'
   ewid_rs2k := 'T'
   ewid_rs2i := '**'
   ewid_rs2z := 'N'
   ewid_rs3s := 'N'
   ewid_rs3k := 'T'
   ewid_rs3i := '**'
   ewid_rs3z := 'N'
   ewid_rs4s := 'N'
   ewid_rs4k := 'T'
   ewid_rs4i := '**'
   ewid_rs4z := 'N'

   IF File( 'ewid.mem' )
      RESTORE FROM ewid ADDITIVE
   ELSE
      SAVE TO ewid ALL LIKE ewid_*
   ENDIF

   mmm := Array( 12 )
   mmm[ 1 ]  := '1 - Stycze&_n.     '
   mmm[ 2 ]  := '2 - Luty        '
   mmm[ 3 ]  := '3 - Marzec      '
   mmm[ 4 ]  := '4 - Kwiecie&_n.    '
   mmm[ 5 ]  := '5 - Maj         '
   mmm[ 6 ]  := '6 - Czerwiec    '
   mmm[ 7 ]  := '7 - Lipiec      '
   mmm[ 8 ]  := '8 - Sierpie&_n.    '
   mmm[ 9 ]  := '9 - Wrzesie&_n.    '
   mmm[ 10 ] := 'P - Pa&_x.dziernik '
   mmm[ 11 ] := 'L - Listopad    '
   mmm[ 12 ] := 'G - Grudzie&_n.    '

   SAVE SCREEN TO ROBSO1

   DO WHILE .T.
   *=============================
      IF zRYCZALT == 'T'
         DO WHILE ! dostep( 'EWID' )
         ENDDO
         setind( 'EWID' )
         SEEK '+' + ident_fir
         mc_rozp := iif( del == '+' .AND. firma == ident_fir, mc, '  ' )
         SEEK '+' + ident_fir + 'þ'
         SKIP -1
         aktualny := iif( del == '+' .AND. firma == ident_fir, mc, '  ' )
         USE
      ELSE
         DO WHILE ! dostep( 'OPER' )
         ENDDO
         setind( 'OPER' )
         SEEK '+' + ident_fir
         mc_rozp := iif( del == '+' .AND. firma == ident_fir, mc, '  ' )
         SEEK '+' + ident_fir + 'þ'
         SKIP -1
         aktualny := iif( del == '+' .AND. firma == ident_fir, mc, '  ' )
         USE
      ENDIF

      aktualny := iif( aktualny == '  ' .OR. Len( AllTrim( aktualny ) ) == 0, ' 1', aktualny )
      miesiac := iif( miesiac == '  ' .OR. Len( AllTrim( miesiac ) ) == 0, aktualny, miesiac )
      mc_rozp := iif( mc_rozp == '  ' .OR. Len( AllTrim( mc_rozp ) ) == 0, aktualny, mc_rozp )

      ColPro()
      @  8, 14 TO 21, 31
      KEYBOARD Chr( 32 )

      miesiac := Str( AChoice( 9, 15, 20, 30, mmm, .T., "infomies", Val( miesiac ) ), 2 )
      ColStd()
      IF LastKey() == K_ESC
         RETURN
      ENDIF
      **************************
      IF miesiac < aktualny
         IF ! tnesc( '*i', ' UWAGA ! ' + RTrim( miesiac( Val( aktualny ) ) ) + ' jest aktualnym miesi&_a.cem ewidencyjnym, jeste&_s. pewny? (T/N) ' )
            LOOP
         ENDIF
      ENDIF
      mc_rozp := iif( mc_rozp == '  ', miesiac, mc_rozp )
      ColSta()
      @ 1,  0 SAY ' Miesi&_a.c ewidencyjny                 '
      SET COLOR TO +w
      @ 1, 21 SAY Upper( RTrim( miesiac( Val( miesiac ) ) ) ) + ' ' + param_rok
      ColStd()
      *=============================
      opcja := 1
      SAVE SCREEN TO ROBSO
      DO WHILE .T.
      *=============================
         ColPro()
         @  8, 4 TO 22, 37
         @  9, 5 PROMPT ' K - KSI&__E.GOWANIE DOKUMENT&__O.W...  '
         @ 10, 5 PROMPT ' B - ZESTAWIENIA                '
         @ 11, 5 PROMPT ' F - FAKTUROWANIE (' + SubStr( ewid_wyst, 1, 12 ) + ')'
         @ 12, 5 PROMPT ' P - PRZEBIEGI POJAZD&__O.W...      '
         @ 13, 5 PROMPT ' W - WYPOSA&__Z.ENIE - AKTUALIZACJA '
         @ 14, 5 PROMPT ' I - Informacje o...            '
         IF zRYCZALT == 'T'
            @ 15, 5 PROMPT ' E - Ewidencja przych.i zakup&_o.w '
         ELSE
            @ 15, 5 PROMPT ' E - Ewidencja-ksi&_e.ga podatkowa '
         ENDIF
         @ 16, 5 PROMPT ' D - Deklaracje...              '
         @ 17, 5 PROMPT ' R - Rejestry...                '
         @ 18, 5 PROMPT ' L - Listy wyp&_l.at...            '
         @ 19, 5 PROMPT ' U - Umorzenie &_s.rodk&_o.w trwa&_l.ych '
         @ 20, 5 PROMPT ' Z - Zestawienie pomocnicze     '
         @ 21, 5 PROMPT ' @ - Zamkni&_e.cie miesi&_a.ca        '
         opcja := menu( opcja )
         ColStd()
         IF LastKey() == K_ESC
            EXIT
         ENDIF
         *=============================
         SAVE SCREEN TO scr1
         DO CASE
            CASE opcja == 1
               ksieg()

            CASE opcja == 2
               //zbiorcze()
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               DO WHILE .T.
                  *=============================
                  ColPro()
                  @ 11, 6 TO 15, 40
                  @ 12, 7 PROMPT ' Z - Zestawienie zbiorcze        '
                  @ 13, 7 PROMPT ' E - Ewidencja zwrot¢w paragon¢w '
                  @ 14, 7 PROMPT ' O - Ewidencja sprzeda¾y OSS     '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22

                  DO CASE
                     CASE opcja1 == 1
                        zbiorcze()

                     CASE opcja1 == 2
                        EwidencjaZwrotowParagonow()

                     CASE opcja1 == 3
                        RejestrOSS()

                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 3
               SET CURSOR on
               ColPro()
               @ 11, 10 SAY 'WYSTAWIA: '
               @ 11, 20 GET ewid_wyst PICTURE '@S16 !' + repl( 'X', 29 )
               READ
               ColStd()
               SET CURS OFF

               IF LastKey() <> K_ESC
                  SAVE TO ewid ALL LIKE ewid_*
                  *=============================
                  opcja1 := 1
                  SAVE SCREEN TO ROBSO11
                  DO WHILE .T.
                  *=============================
                     ColPro()
                     IF ZVAT == 'T'
                        @ 12, 2 TO 16, 40
                     ELSE
                        @ 12, 2 TO 15, 40
                     ENDIF
                     @ 13, 3 PROMPT    ' F - Fakturowanie                    '
                     @ 14, 3 PROMPT    ' W - Faktury wewn©trzne              '
                     IF ZVAT == 'T'
                        @ 15, 3 PROMPT ' J - Jednolity Plik Kontrolny JPK_FA '
                     ENDIF
                     opcja1 := menu( opcja1 )
                     ColStd()
                     IF LastKey() == K_ESC
                        EXIT
                     ENDIF
                     *=============================
                     SAVE SCREEN TO scr22
                     DO CASE

                        CASE opcja1 == 1

                           DO CASE
                              CASE ZVAT='T'
                                 fakturyn()
                              OTHERWISE
                                 faktury3()
                           ENDCASE

                        CASE opcja1 == 2
                           fakturyw()

                        CASE opcja1 == 3
                           JPK_FA_Rob()

                     ENDCASE

                     close_()
                     RESTORE SCREEN FROM SCR22
                  ENDDO
                  RESTORE SCREEN FROM ROBSO11
               ELSE
                  RESTORE FROM ewid ADDITIVE
               ENDIF

            CASE opcja == 4
            *=============================
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               DO WHILE .T.
                  *=============================
                  ColPro()
                  @ 13, 7 TO 18, 34
                  @ 14, 8 PROMPT ' P - Ewidencja przebieg&_o.w '
                  @ 15, 8 PROMPT ' E - Ewidencja rachunk&_o.w  '
                  @ 16, 8 PROMPT ' N - Rozliczenie narast.  '
                  @ 17, 8 PROMPT ' R - Relacje (trasy)      '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22

                  DO CASE
                     CASE opcja1 == 1
                        ewidpoj()

                     CASE opcja1 == 2
                        rachpoj()

                     CASE opcja1 == 3
                        rozpoj()

                     CASE opcja1 == 4
                        relacje()

                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 5
               wyposaz()

            CASE opcja == 6
               *=============================
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               DO WHILE .T.
               *=============================
                  ColPro()
                  @ 14, 4 to 22, 37
                  @ 15, 5 PROMPT ' D - podatku dochodowym         '
                  @ 16, 5 PROMPT ' V - podatku VAT                '
                  @ 17, 5 PROMPT ' W - podatku od wyp&_l.at          '
                  @ 18, 5 PROMPT ' R - podatku zrycza&_l.towanym     '
                  @ 19, 5 PROMPT ' S - strukturze sprzeda&_z.y-detal '
                  @ 20, 5 PROMPT ' K - % korekty VAT-zak.pozosta. '
                  @ 21, 5 PROMPT ' Z - skˆadkach ZUS wˆa˜cicieli  '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22
                  DO CASE
                     CASE opcja1 == 1
                        IF zRYCZALT == 'T'
                        *=============================
                           opcja2 := 1
                           SAVE SCREEN TO ROBSO111
                           DO WHILE .T.
                           *=============================
                              ColPro()
                              @ 16, 11 TO 20, 29
                              @ 17, 12 PROMPT ' M - miesi&_e.cznie '
                              @ 18, 12 PROMPT ' K - kwartalnie  '
                              @ 19, 12 PROMPT ' N - narastaj&_a.co '
                              opcja2 := menu( opcja2 )
                              ColStd()
                              IF LastKey() == K_ESC
                                 EXIT
                              ENDIF
                              *=============================
                              SAVE SCREEN TO scr222
                              DO CASE
                                 CASE opcja2 == 1
                                    p_rycz( 'M' )

                                 CASE opcja2 == 2
                                    p_rycz( 'K' )

                                 CASE opcja2 == 3
                                    p_rycz( 'N' )

                              ENDCASE
                              close_()
                              RESTORE SCREEN FROM SCR222
                           ENDDO
                           RESTORE SCREEN FROM ROBSO111
                        ELSE
                           p_dochod( 'I' )
                        ENDIF

                     CASE opcja1 == 2
                        vat_720( 0, 0, 1, 'I' )

                     CASE opcja1 == 3
                        pit_4r( 0,0,1,'E' )

                     CASE opcja1 == 4
                        pit_8ar( 0,0,1,'E' )

                     CASE opcja1 == 5
                        struktur()

                     CASE opcja1 == 6
                        info_kor()

                     CASE opcja1 == 7
                        Wlasciciel_SkladkiZus()

                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 7
               IF zRYCZALT == 'T'
                  ewid_dr16rob()
               ELSE
                  SAVE SCREEN TO ROBSO11
                  opcja1 := 1
                  ColPro()
                  @ 16, 4 TO 19, 37
                  @ 17, 5 PROMPT ' D - Wydruk ewidencji           '
                  @ 18, 5 PROMPT ' J - JPK_PKPIR (2)              '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() <> K_ESC
                     DO CASE
                        CASE opcja1 == 1
                           ksiega16()
                        CASE opcja1 == 2
                           JpkPkpirRob()
                     ENDCASE
                  ENDIF
                  RESTORE SCREEN FROM ROBSO11
               ENDIF

            CASE opcja == 8
               *=============================
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               DO WHILE .T.
               *=============================
                  ColPro()
                  verdekold := '                                     '

                  DO CASE
                     CASE zVATFORDR == '7 '
                        verdekold := ' J - JPK_V7M  (2)                    '

                     CASE zVATFORDR == '7K'
                        verdekold := ' J - JPK_V7K  (2)                    '

                     CASE zVATFORDR == '8 '
                        verdekold := ' J - VAT-8    (11)                   '

                     CASE zVATFORDR == '9M'
                        verdekold := ' J - VAT-9M   (10)                   '

                  ENDCASE

                  @  7, 1 TO 22, 39
                  @  8, 2 PROMPT ' 4 - PIT-4R   (13)                   '
                  @  9, 2 PROMPT ' 8 - PIT-8AR  (13)                   '
                  @ 10, 2 PROMPT ' 5 - raporty z obl.podatku dochodow. '
                  @ 11, 2 PROMPT ' S - sumy do zeznania pod.dochodowego'
                  @ 12, 2 PROMPT verdekold
                  @ 13, 2 PROMPT ' U - VAT-UE   (5)                    '
                  @ 14, 2 PROMPT ' I - IFT-2/2R (10)                   '
                  @ 15, 2 PROMPT ' V - VIU-DO   (1)                    '
                  @ 16, 2 TO 16, 38
                  @ 17, 2 PROMPT ' C - RCA raport imienny              '
                  @ 18, 2 PROMPT ' Z - RZA raport imienny (zdrowot.)   '
                  @ 19, 2 PROMPT ' D - DRA deklaracja rozliczeniowa    '
                  @ 20, 2 TO 20, 38
                  @ 21, 2 PROMPT ' P - PPK deklaracja wpˆaty           '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22
                  papier := 'K'
                  DO CASE
                     CASE opcja1 == 1
                        papier := menuDeklaracjaDruk( 11, .F. )
                        IF LastKey() == K_ESC .OR. papier == ''

                        ELSE
                           pit_4r( 0, 0, 1, papier )
                        ENDIF

                     CASE opcja1 == 2
                        papier := menuDeklaracjaDruk( 12, .F. )
                        IF LastKey() == K_ESC .OR. papier == ''

                        ELSE
                           pit_8ar( 0, 0, 1, papier )
                        ENDIF

                     CASE opcja1 == 3
                        IF LastKey() <> K_ESC
                           IF zRYCZALT == 'T'
                              kom( 5, '+w', ' UWAGA !!! Funkcja nie jest aktywna dla p&_l.atnik&_o.w podatku zrycza&_l.towanego ' )
                           ELSE
                              p_dochod( 'W' )
                           ENDIF
                        ENDIF

                     CASE opcja1 == 4
                        IF LastKey() <> K_ESC
                           IF zRYCZALT == 'T'
                              kom( 5, '+w', ' UWAGA !!! Funkcja nie jest aktywna dla p&_l.atnik&_o.w podatku zrycza&_l.towanego ' )
                           ELSE
                              p_dochod( 'Z' )
                           ENDIF
                        ENDIF

                     CASE opcja1 == 5
                        IF zVATFORDR == '8 ' .OR. zVATFORDR == '9M'
                           papier := menuDeklaracjaDruk( 14, .F. )
                           SET CURSOR OFF
                           DO CASE
                           CASE papier == 'K'
                              vat_720( 0, 0, 1, iif( zVATFORDR == '8 ', '8D', '9D' ) )
                           CASE papier == 'X'
                              vat_720( 0, 0, 1, iif( zVATFORDR == '8 ', '8X', '9X' ) )
                           ENDCASE
                        ELSE
                           JPK_V7_Rob( 15, 4 )
                        ENDIF

                     CASE opcja1 == 6

                        SWITCH edekCzyKorekta( 16, 2 )
                        CASE 1
                           vue_info( 1 )
                           EXIT
                        CASE 2
                           VatUE4KRob( 1 )
                           EXIT
                        ENDSWITCH

                     CASE opcja1 == 7
                        IFT2_Rob()

                     CASE opcja1 == 8
                        OSSDeklaracjaVIU_DO()

                     CASE opcja1 == 9
                        opcja11 := 1
                        SAVE SCREEN TO ROBSO111
                        DO WHILE .T.
                        *=============================
                           ColPro()
                           @ 18, 11 TO 21, 33
                           @ 19, 12 PROMPT ' 1 - Pracownicy      '
                           @ 20, 12 PROMPT ' 2 - Z w&_l.a&_s.cicielami '
                           opcja11 := menu( opcja11 )
                           ColStd()
                           IF LastKey() == K_ESC
                              EXIT
                           ENDIF
                           *=============================
                           SAVE SCREEN TO scr222
                           DO CASE
                              CASE opcja11 == 1
                                 zusrca( 1 )

                              CASE opcja11 == 2
                                 zusrca( 2 )
                           ENDCASE
                           close_()
                           RESTORE SCREEN FROM SCR222
                        ENDDO
                        RESTORE SCREEN FROM ROBSO11

                     CASE opcja1 == 10
                        opcja11 := 1
                        SAVE SCREEN TO ROBSO111
                        DO WHILE .T.
                        *=============================
                           ColPro()
                           @ 19, 8  TO 22, 34
                           @ 20, 9  PROMPT ' 1 - W&_l.a&_s.ciciele (razem )'
                           @ 21, 9  PROMPT ' 2 - W&_l.a&_s.ciciele (osobno)'
                           opcja11 := menu( opcja11 )
                           ColStd()
                           IF LastKey() == K_ESC
                              EXIT
                           ENDIF
                           *=============================
                           SAVE SCREEN TO scr222
                           DO CASE
                              CASE opcja11 == 1
                                 zusrza( 1 )

                              CASE opcja11 == 2
                                 zusrza( 2 )
                           ENDCASE
                           close_()
                           RESTORE SCREEN FROM SCR222
                        ENDDO
                        RESTORE SCREEN FROM ROBSO11

                     CASE opcja1 == 11
                        opcja11 := 1
                        SAVE SCREEN TO ROBSO111
                        DO WHILE .T.
                        *=============================
                           ColPro()
                           @ 18, 13 TO 22, 31
                           @ 19, 14 PROMPT ' 1 - Pracownicy  '
                           @ 20, 14 PROMPT ' 2 - W&_l.a&_s.ciciele '
                           @ 21, 14 PROMPT ' 3 - Razem       '
                           opcja11 := menu( opcja11 )
                           ColStd()
                           IF LastKey() == K_ESC
                              EXIT
                           ENDIF
                           *=============================
                           SAVE SCREEN TO scr222
                           DO CASE
                              CASE opcja11 == 1
                                 zusdra( 1 )

                              CASE opcja11 == 2
                                 zusdra( 2 )

                              CASE opcja11 == 3
                                 zusdra( 3 )
                           ENDCASE
                           close_()
                           RESTORE SCREEN FROM SCR222
                        ENDDO
                        RESTORE SCREEN FROM ROBSO11

                     CASE opcja1 == 12
                        opcja11 := MenuEx( 19, 6, { "S - Deklaracja skˆadki", "K - Korekta skˆadki" } )
                        DO CASE
                        CASE opcja11 == 1
                           PPK_Skladka()
                        CASE opcja11 == 2
                           PPK_KorSkladka()
                        ENDCASE

                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 9
               *=============================
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               ewid_rz1z := 'N'
               ewid_rz2z := 'N'
               DO WHILE .T.
               *=============================
                  ColPro()
                  @  9, 0 TO 22, 41
                  @ 10, 1 SAY    '                    Sumy Kor ID StanZap '
                  @ 11, 1 SAY    '   POD.NALICZONY (zakupy, nabycie, itp) '
                  @ 12, 1 PROMPT ' 1 - &__S.RODKI TRWA&__L.E  ' + iif( ewid_rz1s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rz1k == 'N', 'Nie', iif( ewid_rz1k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rz1i + ' ' + Space( 8 )
                  @ 13, 1 PROMPT ' 2 - POZOSTA&__L.E      ' + iif( ewid_rz2s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rz2k == 'N', 'Nie', iif( ewid_rz2k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rz2i + ' ' + Space( 8 )
                  @ 14, 1 PROMPT ' 3 - wg STAWEK VAT  ' + iif( ewid_rz3s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rz3k == 'N', 'Nie', iif( ewid_rz3k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rz3i + ' ' + iif( ewid_rz3z == 'D', 'Do_zapl', iif( ewid_rz3z == 'Z', 'Zaplaco', iif( ewid_rz3z == 'W', 'Wszystk', 'Niedruk' ) ) ) + ' '
                  @ 15, 1 PROMPT ' 4 - Zakupy do sprzeda¾y w proc. mar¾y  '
                  @ 16, 1 SAY    '   POD.NALE&__Z.NY (sprzeda&_z., dostawa, itp) '
                  @ 17, 1 PROMPT ' 5 - SPRZEDAZ       ' + iif( ewid_rs1s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rs1k == 'N', 'Nie', iif( ewid_rs1k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rs1i + ' ' + iif( ewid_rs1z == 'D', 'Do_zapl', iif( ewid_rs1z == 'Z', 'Zaplaco', iif( ewid_rs1z == 'W', 'Wszystk', 'Niedruk' ) ) ) + ' '
                  @ 18, 1 PROMPT ' 6 - KOREKTY SPRZ.  ' + iif( ewid_rs2s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rs2k == 'N', 'Nie', iif( ewid_rs2k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rs2i + ' ' + Space( 8 )
                  @ 19, 1 PROMPT ' 7 - NABYCIA UE,IMP ' + iif( ewid_rs3s == 'B', 'Brut', 'Nett' ) + ' ' + iif( ewid_rs3k == 'N', 'Nie', iif( ewid_rs3k == 'T', 'Tak', 'Raz' ) ) + ' ' + ewid_rs3i + ' ' + Space( 8 )
                  @ 20, 1 SAY    '   JPK                                  '
                  @ 21, 1 PROMPT ' 8 - Jednolity Plik Kontrolny VAT       '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22
                  DO CASE
                     CASE opcja1 == 1
                        SET CURSOR ON
                        ColStd()
                        @ 12, 21 GET ewid_rz1s PICTURE '!' WHEN wrz1s() VALID vRz1S()
                        @ 12, 26 GET ewid_rz1k PICTURE '!' WHEN wrz1k() VALID vRz1K()
                        @ 12, 30 GET ewid_rz1i PICTURE '!!' WHEN wrzi( 'rz1', 12, 30 )
                        ewid_rz1z := 'N'
                        READ
                        SET CURSOR OFF
                        IF LastKey() <> K_ESC

                           RejVAT_Zak_Drukuj( 1, ident_fir, miesiac, ewid_rz1s, ewid_rz1k, ewid_rz1i, ewid_rz1z )

                        ELSE
                           RESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 2
                        SET CURSOR ON
                        ColStd()
                        @ 13, 21 GET ewid_rz2s PICTURE '!' WHEN wrz2s() VALID vRz2S()
                        @ 13, 26 GET ewid_rz2k PICTURE '!' WHEN wrz2k() VALID vRz2K()
                        @ 13, 30 GET ewid_rz2i PICTURE '!!' WHEN wrzi( 'rz2', 13, 30 )
                        ewid_rz2z := 'N'
                        READ
                        SET CURSOR OFF
                        IF LastKey() <> K_ESC
                           RejVAT_Zak_Drukuj( 2, ident_fir, miesiac, ewid_rz2s, ewid_rz2k, ewid_rz2i, ewid_rz2z )
                        ELSE
                           RESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 3
                        SET CURSOR ON
                        ColStd()
                        @ 14, 21 GET ewid_rz3s PICTURE '!' WHEN wrz3s() VALID vRz3S()
                        @ 14, 26 GET ewid_rz3k PICTURE '!' WHEN wrz3k() VALID vRz3K()
                        @ 14, 30 GET ewid_rz3i PICTURE '!!' WHEN wrzi( 'rz3', 14, 30 )
                        @ 14, 33 GET ewid_rz3z PICTURE '!' WHEN wrz3z() VALID vRz3z()
                        READ
                        SET CURSOR OFF
                        IF LastKey() <> K_ESC
                           RejVAT_Zak_Drukuj( 3, ident_fir, miesiac, ewid_rz3s, ewid_rz3k, ewid_rz3i, ewid_rz3z )
                        ELSE
                           rESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 4
                        RejVAT_Zak_Marza( ident_fir, miesiac )

                     CASE opcja1 == 5
                        SET CURSOR ON
                        ColStd()
                        @ 17, 21 GET ewid_rs1s PICTURE '!' WHEN wrs1s() VALID vRS1S()
                        @ 17, 26 GET ewid_rs1k PICTURE '!' WHEN wrs1k() VALID vRS1K()
                        @ 17, 30 GET ewid_rs1i PICTURE '!!' WHEN wrsi( 'rs1', 17, 30 )
                        @ 17, 33 GET ewid_rs1z PICTURE '!' WHEN wrs1z() VALID vRS1z()
                        READ
                        SET CURSOR OFF
                        IF LastKey() <> K_ESC
                           RejVAT_Sp_Drukuj( 1, ident_fir, miesiac, ewid_rs1s, ewid_rs1k, ewid_rs1i, ewid_rs1z )
                        ELSE
                           RESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 6
                        SET CURSOR ON
                        ColStd()
                        @ 18, 21 GET ewid_rs2s PICTURE '!' WHEN wrs2s() VALID vRS2S()
                        @ 18, 30 GET ewid_rs2i PICTURE '!!' WHEN wrsi( 'rs2', 18, 30 )
                        READ
                        SET CURS OFF
                        IF LastKey() <> K_ESC
                           RejVAT_Sp_Drukuj( 2, ident_fir, miesiac, ewid_rs2s, ewid_rs2k, ewid_rs2i, 'N' )
                        ELSE
                           RESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 7
                        SET CURSOR ON
                        ColStd()
                        @ 19, 21 GET ewid_rs3s PICTURE '!' WHEN wrs3s() VALID vRS3S()
                        @ 19, 26 GET ewid_rs3k PICTURE '!' WHEN wrs3k() VALID vRS3K()
                        @ 19, 30 GET ewid_rs3i PICTURE '!!' WHEN wrsi( 'rs3', 19, 30 )
                        READ
                        SET CURSOR OFF
                        IF LastKey() <> K_ESC
                           RejVAT_Zak_Drukuj( 4, ident_fir, miesiac, ewid_rs3s, ewid_rs3k, ewid_rs3i, ewid_rs3z )
                        ELSE
                           RESTORE FROM ewid ADDITIVE
                        ENDIF

                     CASE opcja1 == 8
                        JPK_VAT_Rob()
                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 10
               *=============================
               opcja1 := 1
               SAVE SCREEN TO ROBSO11
               DO WHILE .T.
               *=============================
                  ColPro()
                  @ 11, 3 TO 22,38
                  @ 12, 4 PROMPT ' E - p&_l.ace pracownik&_o.w etatowych  '
                  @ 13, 4 PROMPT ' S - specyfikacja p&_l.ac            '
                  @ 14, 4 PROMPT ' K - karty p&_l.ac                   '
                  @ 15, 4 PROMPT ' R - rozliczenie wyp&_l.at dokonanych'
                  @ 16, 4 PROMPT ' O - wyp&_l.aty dokonane w okresie   '
                  @ 17, 4 PROMPT ' 4 - rozliczone w PIT-4R          '
                  @ 18, 4 PROMPT ' N - nierozliczone w PIT-4R       '
                  //002 nowa pozycja
                  //002 poprzednie pozycje wyzej
                  @ 19, 4 PROMPT ' P - przelewy p&_l.ac                '
                  @ 20, 4 TO 20,37
                  //002a usunieto 'zlecen'
                  @ 21, 4 PROMPT ' I - lista innych wyp&_l.at          '
                  opcja1 := menu( opcja1 )
                  ColStd()
                  IF LastKey() == K_ESC
                     EXIT
                  ENDIF
                  *=============================
                  SAVE SCREEN TO scr22
                  DO CASE
                     CASE opcja1 == 1
                        listapla()

                     CASE opcja1 == 2
                        specplac( miesiac, miesiac )

                     CASE opcja1 == 3
                        Etaty( miesiac )

                     CASE opcja1 == 4
                        wyplacon( miesiac, miesiac )

                     CASE opcja1 == 5
                        wypldnia( miesiac, miesiac )

                     CASE opcja1 == 6
                        rozlicp4( miesiac, miesiac )

                     CASE opcja1 == 7
                        nierozp4( miesiac, miesiac )

                     //002 obsluga nowej pozycji
                     CASE opcja1 == 8
                        przelpra()

                     CASE opcja1 == 9
                        listaplm()
                  ENDCASE
                  close_()
                  RESTORE SCREEN FROM SCR22
               ENDDO
               RESTORE SCREEN FROM ROBSO11

            CASE opcja == 11
               TabAm( miesiac )

            CASE opcja == 12
               IF zRYCZALT == 'T'
                  kom( 5, '+w', ' UWAGA !!! Funkcja nie jest aktywna dla p&_l.atnik&_o.w podatku zrycza&_l.towanego ' )
               ELSE
                  Wykaz13()
               ENDIF

            CASE opcja == 13
               zamek()
         ENDCASE
         close_()
         RESTORE SCREEN FROM SCR1
         infofirma()
         infoobr( miesiac )
      ENDDO
      RESTORE SCREEN FROM ROBSO
      ColSta()
      IF zVAT == 'T'
         @ 0,  3 SAY 'VAT'
         @ 0, 21 SAY '                  '
      ELSE
         @ 0, 0 CLEAR TO 0, 40
      ENDIF
      @ 1, 0 SAY Left( status(), 37 )
      ColStd()
      miesiac := '  '
   ENDDO
   RESTORE SCREEN FROM ROBS1

   RETURN NIL

*************************************
FUNCTION wRz1S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 12, 22 SAY iif( ewid_rz1s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION wRz1K()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: T - tylko KOREKTY , N - bez KOREKT , R - ZAKUPY z KOREKTAMI', 80, ' ' )
   ColStd()
   @ 12, 27 SAY iif( ewid_rz1k == 'N', 'ie', iif( ewid_rz1k == 'T', 'ak', 'az' ) )
   RETURN .T.

*************************************
FUNCTION wRz1z()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D-do zaplaty , Z-zaplacone , W-wszystkie, N-nie drukowac stanu zaplat', 80, ' ' )
   ColStd()
   @ 13, 34 SAY iif( ewid_rz1z == 'D', 'o_zapl', iif( ewid_rz1z == 'Z', 'aplaco', iif( ewid_rz1z == 'W', 'szystk', 'iedruk' ) ) )
   RETURN .T.

*************************************
FUNCTION wRz2z()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D-do zaplaty , Z-zaplacone , W-wszystkie, N-nie drukowac stanu zaplat', 80, ' ' )
   ColStd()
   @ 13, 34 SAY iif( ewid_rz2z == 'D', 'o_zapl', iif( ewid_rz2z == 'Z', 'aplaco', iif( ewid_rz2z == 'W', 'szystk', 'iedruk' ) ) )
   RETURN .T.

*************************************
FUNCTION wRz3z()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D-do zaplaty , Z-zaplacone , W-wszystkie, N-nie drukowac stanu zaplat', 80, ' ' )
   ColStd()
   @ 14, 34 SAY iif( ewid_rz3z == 'D', 'o_zapl', iif( ewid_rz3z == 'Z', 'aplaco', iif( ewid_rz3z == 'W', 'szystk', 'iedruk' ) ) )
   RETURN .T.

*************************************
FUNCTION wRs1z()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D-do zaplaty , Z-zaplacone , W-wszystkie, N-nie drukowac stanu zaplat', 80, ' ' )
   ColStd()
   @ 17, 34 SAY iif( ewid_rs1z == 'D', 'o_zapl', iif( ewid_rs1z == 'Z', 'aplaco', iif( ewid_rs1z == 'W', 'szystk', 'iedruk' ) ) )
   RETURN .T.

*************************************
FUNCTION wRs2z()
   *************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D-do zaplaty , Z-zaplacone , W-wszystkie, N-nie drukowac stanu zaplat', 80, ' ' )
   ColStd()
   @ 19, 34 SAY iif( ewid_rs2z == 'D', 'o_zapl', iif( ewid_rs2z == 'Z', 'aplaco', iif( ewid_rs2z == 'W', 'szystk', 'iedruk' ) ) )
   RETURN .T.

*************************************
FUNCTION vRz1S()
*************************************
   R := .F.
   IF ewid_rz1s $ 'BN'
      ColStd()
      @ 12, 22 SAY iif( ewid_rz1s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz1K()
*************************************
   R := .F.
   IF ewid_rz1k $ 'TNR'
      ColStd()
      @ 12, 27 SAY iif( ewid_rz1k == 'N', 'ie', iif( ewid_rz1k == 'T', 'ak', 'az' ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz1z()
*************************************
   R := .F.
   IF ewid_rz1z $ 'DZWN'
      ColStd()
      @ 13, 34 SAY iif( ewid_rz1z == 'D', 'o_zapl', iif( ewid_rz1z == 'Z', 'aplaco', iif( ewid_rz1z == 'W', 'szystk', 'iedruk' ) ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz2z()
*************************************
   R := .F.
   IF ewid_rz2z $ 'DZWN'
      ColStd()
      @ 14, 34 SAY iif( ewid_rz2z == 'D', 'o_zapl', iif( ewid_rz2z == 'Z', 'aplaco', iif( ewid_rz2z == 'W', 'szystk', 'iedruk' ) ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz3z()
*************************************
   R := .F.
   IF ewid_rz3z $ 'DZWN'
      ColStd()
      @ 14, 34 SAY iif( ewid_rz3z == 'D', 'o_zapl', iif( ewid_rz3z == 'Z', 'aplaco', iif( ewid_rz3z == 'W', 'szystk', 'iedruk' ) ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRs1z()
*************************************
   R := .F.
   IF ewid_rs1z $ 'DZWN'
      ColStd()
      @ 17, 34 SAY iif( ewid_rs1z == 'D', 'o_zapl', iif( ewid_rs1z == 'Z', 'aplaco', iif( ewid_rs1z == 'W', 'szystk', 'iedruk' ) ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRs2z()
*************************************
   R := .F.
   IF ewid_rs2z $ 'DZWN'
      ColStd()
      @ 18, 34 SAY iif( ewid_rs2z == 'D', 'o_zapl', iif( ewid_rs2z == 'Z', 'aplaco', iif( ewid_rs2z == 'W', 'szystk', 'iedruk' ) ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRz2S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 13, 22 SAY iif( ewid_rz2s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION wRz2K()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: T - tylko KOREKTY , N - bez KOREKT , R - ZAKUPY z KOREKTAMI', 80, ' ' )
   ColStd()
   @ 13, 27 SAY iif( ewid_rz2k == 'N', 'ie', iif( ewid_rz2k == 'T', 'ak', 'az' ) )
   RETURN .T.

*************************************
FUNCTION vRz2S()
*************************************
   R := .F.
   IF ewid_rz2s $ 'BN'
      ColStd()
      @ 13, 22 SAY iif( ewid_rz2s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz2K()
*************************************
   R := .F.
   IF ewid_rz2k $ 'TNR'
      ColStd()
      @ 13, 27 SAY iif( ewid_rz2k == 'N', 'ie', iif( ewid_rz2k == 'T', 'ak', 'az' ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRz3S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 14, 22 SAY iif( ewid_rz3s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION wRz3K()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: T - tylko KOREKTY , N - bez KOREKT , R - ZAKUPY z KOREKTAMI', 80, ' ' )
   ColStd()
   @ 14, 27 SAY iif( ewid_rz3k == 'N', 'ie', iif( ewid_rz3k == 'T', 'ak', 'az' ) )
   RETURN .T.

*************************************
FUNCTION vRz3S()
*************************************
   R := .F.
   if ewid_rz3s $ 'BN'
      ColStd()
      @ 14, 22 SAY iif( ewid_rz3s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRz3K()
*************************************
   R := .F.
   if ewid_rz3k $ 'TNR'
      ColStd()
      @ 14, 27 SAY iif( ewid_rz3k == 'N', 'ie', iif( ewid_rz3k == 'T', 'ak', 'az' ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRS1S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 17, 22 SAY iif( ewid_rs1s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION wRS1K()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: T - tylko KOREKTY , N - bez KOREKT , R - SPRZEDA&__Z. z KOREKTAMI', 80, ' ' )
   ColStd()
   @ 17, 27 SAY iif( ewid_rs1k == 'N', 'ie', iif( ewid_rs1k == 'T', 'ak', 'az' ) )
   RETURN .T.

*************************************
FUNCTION vRS1S()
*************************************
   R := .F.
   IF ewid_rs1s $ 'BN'
      ColStd()
      @ 17, 22 SAY iif( ewid_rs1s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION vRS1K()
*************************************
   R := .F.
   IF ewid_rs1k $ 'TNR'
      ColStd()
      @ 17, 27 SAY iif( ewid_rs1k == 'N', 'ie', iif( ewid_rs1k == 'T', 'ak', 'az' ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRS2S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 18, 22 SAY iif( ewid_rs2s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION vRS2S()
*************************************
   R := .F.
   if ewid_rs2s $ 'BN'
      ColStd()
      @ 18, 22 SAY iif( ewid_rs2s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRS3S()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: B - rejestr z kolumn&_a. "SUMA BRUTTO" , N - rejestr z kolumn&_a. "SUMA NETTO"', 80, ' ' )
   ColStd()
   @ 19, 22 say iif( ewid_rs3s == 'B', 'rut', 'ett' )
   RETURN .T.

*************************************
FUNCTION vRS3S()
*************************************
   R := .F.
   IF ewid_rs3s $ 'BN'
      ColStd()
      @ 19, 22 SAY iif( ewid_rs3s == 'B', 'rut', 'ett' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wRS3K()
*************************************
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: T - tylko KOREKTY , N - bez KOREKT , R - SPRZEDA&__Z. z KOREKTAMI', 80, ' ' )
   ColStd()
   @ 19, 27 SAY iif( ewid_rs3k == 'N', 'ie', iif( ewid_rs3k == 'T', 'ak', 'az' ) )
   RETURN .T.

*************************************
FUNCTION vRS3K()
*************************************
   R := .F.
   IF ewid_rs3k $ 'TNR'
      ColStd()
      @ 19, 27 SAY iif( ewid_rs3k == 'N', 'ie', iif( ewid_rs3k == 'T', 'ak', 'az' ) )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wKART( wik, kok )
*************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: K - druk na czystych kartkach , F - druk na formularzu', 80, ' ' )
   ColStd()
   @ wik, kok + 1 SAY iif( papier == 'K', 'artki   ', 'ormularz' )
   RETURN .T.

*************************************
func vKART( wik, kok )
*************************************
   R := .F.
   if papier $ 'KF'
      ColStd()
      @ wik, kok + 1 SAY iif( papier == 'K','artki   ', 'ormularz' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wKARTv( wik, kok )
*************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: K-druk na czystych kartkach , F-zadruk formularza', 80, ' ' )
   ColStd()
   @ wik, kok + 1 SAY iif( papier == 'K', 'artki   ', 'ormularz' )
   RETURN .T.

*************************************
FUNCTION vKARTv( wik, kok )
*************************************
   R := .F.
   IF papier $ 'KF'
      ColStd()
      @ wik, kok + 1 SAY iif( papier == 'K', 'artki   ', 'ormularz' )
      R := .T.
   ENDIF
   RETURN R

*************************************
FUNCTION wKART2( wik, kok )
*************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: K-dekl.na czystych kartkach, F-dekl.na formularzu, R-raport', 80, ' ' )
   ColStd()
   @ wik, kok + 1 SAY iif( papier == 'K', 'artki   ', iif( papier == 'R', 'aport   ', 'ormularz' ) )
   RETURN .T.

*************************************
FUNCTION vKART2( wik, kok )
*************************************
   R := .F.
   IF papier $ 'KFR'
      ColStd()
      @ wik, kok + 1 SAY iif( papier == 'K', 'artki   ', iif( papier == 'R', 'aport   ', 'ormularz' ) )
      R := .T.
   ENDIF
   RETURN R

***************************************************
FUNCTION wRzI( im, wi, ko )
***************************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: SYMBOL WYBRANEGO REJESTRU lub ** - wszystkie rejestry razem', 80, ' ' )
   ColStd()
   SAVE SCREEN TO scr2
   SELECT 7
   DO WHILE ! dostep( 'KAT_ZAK' )
   ENDDO
   SetInd( 'KAT_ZAK' )
   SEEK '+' + ident_fir + &( 'ewid_' + im + 'i' )
   IF del # '+' .OR. firma # ident_fir
      SKIP -1
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      kat_rej_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         &( 'ewid_' + im + 'i' ) := SYMB_REJ
         SET COLOR TO i
         @ wi, ko SAY &( 'ewid_' + im + 'i' )
         SET COLOR TO
      ENDIF
   ENDIF
   USE
   SELECT 1
   RETURN .T.

***************************************************
FUNCTION wRsI( im, wi, ko )
***************************************************
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: SYMBOL WYBRANEGO REJESTRU lub ** - wszystkie rejestry razem', 80, ' ' )
   ColStd()
   SAVE SCREEN TO scr2
   SELECT 7
   DO WHILE ! dostep( 'KAT_SPR' )
   ENDDO
   SetInd( 'KAT_SPR' )
   SEEK '+' + ident_fir + &( 'ewid_' + im + 'i' )
   IF del # '+' .OR. firma # ident_fir
      SKIP -1
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      kat_rej_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         &( 'ewid_' + im + 'i' ) := SYMB_REJ
         SET COLOR TO i
         @ wi, ko SAY &( 'ewid_' + im + 'i' )
         SET COLOR TO
      ENDIF
   ENDIF
   USE
   SELECT 1
   RETURN .T.

FUNCTION menuDeklaracjaDruk(nTop, lFormularz)

   LOCAL nOpcja := 1, cOpcja := '', xScr

   SAVE SCREEN TO xScr
   ColPro()
   @ nTop, 4 TO nTop + iif(lFormularz, 3, 2) + 1, 29
   @ nTop + 1, 5    PROMPT ' K - Czyste kartki      '
   IF lFormularz
      @ nTop + 2, 5 PROMPT ' F - Druk na formularzu '
      @ nTop + 3, 5 PROMPT ' E - eDeklaracja        '
   ELSE
      @ nTop + 2, 5 PROMPT ' E - eDeklaracja        '
   ENDIF
   nOpcja := menu(nOpcja)
   DO CASE
      CASE nOpcja == 1
         cOpcja = 'K'

      CASE nOpcja == 2
         IF lFormularz
            cOpcja = 'F'
         ELSE
            cOpcja = 'X'
         ENDIF

      CASE nOpcja == 3
         cOpcja = 'X'
   ENDCASE
   ColStd()
   @ 24,0
   RESTORE SCREEN FROM xScr
   RETURN cOpcja

/*----------------------------------------------------------------------*/

