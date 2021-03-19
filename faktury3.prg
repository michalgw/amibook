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

PROCEDURE Faktury3()

* do 99 999 999 faktur w sumie na wszystkie firmy
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   PRIVATE _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou

   *################################# GRAFIKA ##################################
   @  0, 0 SAY '                    F A K T U R A     Nr        z dnia                          '
   @  1, 0 SAY 'Dla  :............................................................              '
   @  2, 0 SAY 'Adres:........................................                                  '
   @  3, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
   @  4, 0 SAY '³     Nazwa towaru/us&_l.ugi    ³    Ilo&_s.&_c.    ³ Jm  ³  Cena jedn.  ³    Warto&_s.&_c.   ³'
   @  5, 0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
   @  6, 0 SAY '³                            ³             ³     ³              ³              ³'
   @  7, 0 SAY '³                            ³             ³     ³              ³              ³'
   @  8, 0 SAY '³                            ³             ³     ³              ³              ³'
   @  9, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 10, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 11, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 12, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 13, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 14, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 15, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 16, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 17, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 18, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 19, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 20, 0 SAY '³                            ³             ³     ³              ³              ³'
   @ 21, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
   @ 22, 0 SAY '                                                                                '

   *############################### OTWARCIE BAZ ###############################
   SELECT 7
   IF Dostep( 'TRESC' )
      SET INDEX TO tresc
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 6
   IF Dostep( 'KONTR' )
      SetInd( 'KONTR' )
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 5
   IF Dostep( 'FIRMA' )
      GO Val( ident_fir )
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 4
   IF Dostep( 'SUMA_MC' )
      SET INDEX TO suma_mc
      SEEK '+' + ident_fir + miesiac
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 3
   IF Dostep( 'OPER' )
      SetInd( 'OPER' )
      SET ORDER TO 3
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 1
   IF Dostep( 'POZYCJE' )
      SET INDEX TO pozycje
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF
   SELECT 2
   IF Dostep( 'FAKTURY' )
      SetInd( 'FAKTURY' )
      SET ORDER TO 2
      *set inde to faktury1,faktury2,faktury
      SEEK '+' + ident_fir + miesiac
   ELSE
      SELECT 2
      close_()
      return
   ENDIF
   IF .NOT. Found() .AND. suma_mc->zamek
      kom( 3, '*u', ' Brak danych (miesi&_a.c jest zamkni&_e.ty) ' )
      close_()
      RETURN
   ENDIF

   *################################# OPERACJE #################################
   *----- parametry ------
   _top := "firma#ident_fir.or.mc#miesiac"
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + mc
   _sbot := '+' + ident_fir + mc + 'þ'
   _proc := 'say2603'

   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF .NOT. &_top_bot
      DO &_proc
   ENDIF
   kl := 0
   DO WHILE kl # 27
      kl := Inkey( 0 )
      Ster()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. kl == 109 .OR. kl == 77 .OR. &_top_bot
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         KtorOper()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF ins .AND. Month( Date() ) # Val( miesiac ) .AND. del == '+' .AND. firma = ident_fir .AND. mc = miesiac
               IF .NOT. TNEsc( '*u', ' Jest ' + Upper( RTrim( miesiac( Month( date() ) ) ) ) + ' - jeste&_s. pewny? (T/N) ' )
                  BREAK
               ENDIF
            ENDIF
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            DECLARE ztowar[ 15 ], zilosc[ 15 ], zjm[ 15 ], zcena[ 15 ], zwartosc[ 15 ]
            FOR I := 1 TO 15
                ztowar[ i ] := Space( 58 )
                zilosc[ i ] := 0
                zjm[ i ] := Space( 5 )
                zcena[ i ] := 0
                zwartosc[ i ] := 0
            NEXT
            IF ins
               @ 6, 65 CLEAR TO 20, 75
               zrach := ' '
               zNUMER := firma->nr_rach
               zDZIEN := '  '
               znazwa := Space( 70 )
               zADRES := Space( 40 )
               zsposob_p := 2
               ztermin_z := 0
               zkwota := 0
               znr_ident := Space( 30 )
               @  2, 47 SAY repl( '.', 32 )
               @ 22,  0
            ELSE
               zrach := ' '
               zNUMER := NUMER
               zDZIEN := DZIEN
               znazwa := nazwa
               zADRES := ADRES
               zsposob_p := sposob_p
               zkwota := kwota
               znr_ident := nr_ident
               ztermin_z := termin_z
               zident_poz := Str( rec_no, 8 )
               SELECT pozycje
               SEEK '+' + zident_poz
               i := 0
               DO WHILE del == '+' .AND. ident = zident_poz
                  i := i + 1
                  ztowar[ i ] := towar
                  zilosc[ i ] := ilosc
                  zjm[ i ] := jm
                  zcena[ i ] := cena
                  zwartosc[ i ] := wartosc
                  SKIP
               ENDDO
               SELECT faktury
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            SET COLOR TO +w
            @ 0, 41 SAY StrTran( Str( zNUMER, 5 ), ' ', '0' )
            SET COLOR TO
            @ 0, 55 GET zDZIEN PICTURE "99" VALID v26_103()
            @ 1,  6 GET znazwa PICTURE repl( '!', 70 ) VALID v26_203()
            @ 2,  6 GET zADRES PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            FOR i := 1 TO 15
                @ 5 + i,  1 GET ztowar[ i ]   PICTURE '@s28 !' + repl( 'X', 45 ) WHEN { | oGet | Fakt3WhenTowar( oGet:row - 5 ) } VALID v26_503()
                @ 5 + i, 30 GET zilosc[ i ]   PICTURE "  9999999.999"            VALID v26_603()
                @ 5 + i, 44 GET zjm[ i ]      PICTURE "XXXXX"                    VALID v26_703()
                @ 5 + i, 50 GET zcena[ i ]    PICTURE "   99999999.99"           VALID v26_803()
                @ 5 + i, 65 GET zwartosc[ i ] PICTURE "   99999999.99"           VALID v26_903()
            NEXT
            wiersz := 1
            CLEAR TYPEAHEAD
            read_()
            SET CONFIRM OFF
            IF LastKey() == 27
               BREAK
            ENDIF
            *-----kontrola wartosci faktury-----
            razem := 0
            FOR i := 1 TO 15
                razem := razem + zwartosc[ i ]
            NEXT
            IF razem > 999999999
               kom( 3, '*u', ' Przekroczony zakres warto&_s.ci faktury ' )
               BREAK
            ENDIF
            *-----------------------------------
            @ 22,  0
            @ 22,  9 PROMPT '[P&_l.atne przelewem]'
            @ 22, 33 PROMPT '[P&_l.atne got&_o.wk&_a.]'
            @ 22, 55 PROMPT '[P&_l.atne czekiem]'
            zsposob_p := menu( zsposob_p )
            @ 22,  0
            if LastKey() == 27
               BREAK
            ENDIF
            SET COLOR TO +w
            DO CASE
            CASE zsposob_p == 1
               IF ins
                  ztermin_z := 0
               ENDIF
               zkwota := 0
               @ 22, 24 SAY 'P&_l.atne przelewem w ci&_a.gu    dni'
               @ 22, 49 GET ztermin_z PICTURE '99' RANGE 1, 99
               read_()
               IF LastKey() == 27
                  SET COLOR TO
                  BREAK
               ENDIF
            CASE zsposob_p == 2
               @ 22, 15 SAY 'P&_l.atne w terminie    dni,'
               @ 22, 33 GET ztermin_z picture '99' VALID v26_1003()
               @ 22, 41 SAY 'zap&_l.acono' GET zkwota PICTURE '   99999999.99' RANGE 0, 99999999999
               read_()
               IF LastKey() == 27
                  SET COLOR TO
                  BREAK
               ENDIF
            CASE zsposob_p == 3
                 @ 22, 25 SAY '       Zap&_l.acono czekiem       '
                 zkwota := 0
            ENDCASE
            SET COLOR TO
            zdzien := Str( Val( zdzien ), 2 )
            znazwa := znazwa
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            SELECT kontr
            IF .NOT. Empty( znazwa ) .AND. param_aut == 'T'
               SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
               IF .NOT. Found()
                  app()
                  repl_( 'firma', ident_fir )
                  repl_( 'nazwa', znazwa )
                  repl_( 'adres', zadres )
                  COMMIT
                  UNLOCK
               ENDIF
            ENDIF
            SELECT firma
            IF ins
               BlokadaR()
               repl_( 'nr_rach', nr_rach + 1 )
               COMMIT
               UNLOCK
            ENDIF
            SELECT faktury
            IF ins
               BlokadA()
               SET ORDER TO 4
               GO BOTTOM
               z_rec_no := rec_no + 1
               SET ORDER TO 2
               app()
               repl_( 'rec_no', z_rec_no )
            ENDIF
            BlokadaR()
            repl_( 'firma', ident_fir )
            repl_( 'mc', miesiac )
            repl_( 'NUMER', zNUMER )
            repl_( 'DZIEN', zDZIEN )
            repl_( 'nazwa', znazwa )
            repl_( 'ADRES', zADRES )
            repl_( 'NR_IDENT', zNR_IDENT )
            repl_( 'sposob_p', zsposob_p )
            repl_( 'termin_z', ztermin_z )
            repl_( 'kwota', zkwota )
            COMMIT
            UNLOCK
            zident_poz := Str( rec_no, 8 )
            SELECT pozycje
            SEEK '+' + zident_poz
            razem := 0
            FOR i := 1 TO 15
               IF Empty( ztowar[ i ] )
                  DO WHILE del == '+' .AND. ident = zident_poz
                     SKIP
                     nr_rec := RecNo()
                     SKIP -1
                     BlokadaR()
                     repl_( 'del', '-' )
                     COMMIT
                     UNLOCK
                     GO NR_REC
                  ENDDO
                  EXIT
               ELSE
                 razem := razem + zwartosc[ i ]
                 IF del # '+' .OR. ident # zident_poz
                     app()
                     repl_( 'ident', zident_poz )
                  ENDIF
                  BlokadaR()
                  repl_( 'towar', ztowar[ i ] )
                  repl_( 'ilosc', zilosc[ i ] )
                  repl_( 'jm', zjm[ i ] )
                  repl_( 'cena', zcena[ i ] )
                  repl_( 'wartosc', zwartosc[ i ] )
                  COMMIT
                  UNLOCK
                  SKIP
               ENDIF
            NEXT
            razem := _round( razem, 2 )
            *========================= Ksiegowanie ========================
            IF zRYCZALT <> 'T'
               SELECT oper
               REC := RecNo()
               SET INDEX TO
               GO BOTTOM
               ILREK := RecNo()
               SetInd( 'OPER' )
               SET ORDER TO 3
               GO REC
               IF ins
                  app()
                  repl_( 'firma', ident_fir )
                  repl_( 'mc', miesiac )
                  repl_( 'zapis', ILREK )
                  repl_( 'numer', 'S-' + StrTran( Str( znumer, 5 ), ' ', '0' ) + '/' + param_rok )
                  repl_( 'tresc', 'Sprzedaz wg rachunku' )
                  repl_( 'ZAKUP', 0 )
                  repl_( 'UBOCZNE', 0 )
                  repl_( 'WYNAGR_G', 0 )
                  repl_( 'WYDATKI', 0 )
                  repl_( 'UWAGI', Space( 14 ) )
                  razem_ := 0
                  rodzaj := zilosc[ 1 ] * 1000 # 0
               ELSE
                  SEEK '+' + ident_fir + miesiac + 'S-' + StrTran( Str( znumer, 5 ), ' ', '0' )
                  razem_ := wyr_tow
                  rodzaj := ( wyr_tow # 0 )
               ENDIF
               BlokadaR()
               repl_( 'dzien', zdzien )
               repl_( 'nazwa', znazwa )
               repl_( 'adres', zadres )
               repl_( 'wyr_tow', razem )
               IF zsposob_p == 1 .OR. zsposob_p == 3
                  IF zsposob_p == 3 .AND. nr_uzytk == 6
                     repl_( 'zaplata', '1' )
                  ELSE
                     repl_( 'zaplata', '3' )
                  ENDIF
               ELSE
                  IF ztermin_z == 0
                     repl_( 'zaplata', '1' )
                  ELSE
                     IF zkwota == 0
                        repl_( 'zaplata', '3' )
                     ELSE
                        repl_('zaplata', '2' )
                     ENDIF
                  ENDIF
               ENDIF
               repl_( 'kwota', zkwota )
               COMMIT
               UNLOCK
               SET ORDER TO 1
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T'
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
                     IF ins
                        SKIP -1
                        IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                           zlp := firma->liczba
                        ELSE
                           zlp := lp + 1
                        ENDIF
                        GO rec
                        DO WHILE del == '+' .AND. firma = ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           repl_( 'lp', zlp )
                           zlp := zlp + 1
                           SKIP
                        ENDDO
                     ELSE
                        zlp := lp
                        SKIP -1
                        IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                           zlp := firma->liczba
                           GO rec
                           DO WHILE del == '+' .AND. firma = ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                              repl_( 'lp', zlp )
                              zlp := zlp + 1
                              SKIP
                           ENDDO
                        ELSE
                           IF lp < zlp
                              zlp := lp + 1
                              GO rec
                              DO WHILE del == '+' .AND. firma = ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                 repl_( 'lp', zlp )
                                 zlp := zlp + 1
                                 SKIP
                              ENDDO
                           ELSE
                              zlp := lp
                              GO rec
                              DO WHILE .NOT. Bof() .AND. firma = ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                                 repl_( 'lp', zlp )
                                 zlp := zlp - 1
                                 SKIP -1
                              ENDDO
                           ENDIF
                        ENDIF
                     ENDIF
                     GO rec
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                  ENDIF
               ENDIF
               SET ORDER TO 3
               COMMIT
               UNLOCK
               SELECT suma_mc
               BlokadaR()
               repl_( 'wyr_tow', wyr_tow - razem_ )
               repl_( 'wyr_tow', wyr_tow + razem )
               IF ins
                  repl_( 'pozycje', pozycje + 1 )
               ENDIF
               COMMIT
               UNLOCK
               *==============================================================
            ENDIF
            ***********************
            SELECT faktury
            commit_()
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
         END
         @ 22, 0
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         @ 23, 0
         @ 24, 0
         *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF .NOT. TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            zident_poz := Str( rec_no, 8 )
            IF zRYCZALT <> 'T'
               *========================= Ksiegowanie ========================
               SELECT oper
               SEEK '+' + ident_fir + miesiac + 'S-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' )
               razem_ := wyr_tow
               rodzaj := ( wyr_tow # 0 )
               SET ORDER TO 1
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
               *********************** lp
               IF nr_uzytk >= 0
                  IF param_lp == 'T' .AND. del == '+' .AND. firma = ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     IF param_kslp == '3'
                        SET ORDER TO 4
                     ENDIF
                     Blokada()
                     Czekaj()
                     rec := RecNo()
                     DO WHILE del == '+' .AND. firma = ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', lp - 1 )
                        SKIP
                     ENDDO
                     GO rec
                     COMMIT
                     UNLOCK
                     IF param_kslp == '3'
                        SET ORDER TO 1
                     ENDIF
                  ENDIF
               ENDIF
               ***********************
               SET ORDER TO 3
               COMMIT
               UNLOCK
               SELECT suma_mc
               BlokadaR()
               repl_( 'wyr_tow', wyr_tow - razem_ )
               repl_( 'pozycje', pozycje - 1 )
               COMMIT
               UNLOCK
               *==============================================================
            ENDIF
            IF faktury->numer = firma->nr_rach - 1
               SELECT firma
               BlokadaR()
               repl_( 'nr_rach', nr_rach - 1 )
               COMMIT
               UNLOCK
            ENDIF
            SELECT pozycje
            SEEK '+' + zident_poz
            DO WHILE del == '+' .AND. ident = zident_poz
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
            ENDDO
            SELECT faktury
            BlokadaR()
            del()
            * repl_('del','-')
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            IF .NOT. &_bot
               DO &_proc
            ENDIF
         END
         @ 23, 0
         @ 24, 0
      *################################# SZUKANIE #################################
      CASE kl == -9 .OR. kl == 247
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := '  '
         ColStd()
         @ 0, 55 GET f10 PICTURE "99"
         read_()
         IF .NOT. Empty( f10 ) .AND. LastKey() # 27
            SEEK '+' + ident_fir + miesiac + Str( Val( f10 ), 2 )
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         DO &_proc
         @ 23, 0
      *############################### WYDRUK FAKTURY #############################
      CASE kl == 13
         BEGIN SEQUENCE
            IF numer # firma->nr_rach - 1
               IF .NOT. TNEsc( '*i', '   Drukujesz wcze&_s.niej wystawion&_a. faktur&_e. - jeste&_s. pewny? (T/N)   ' )
                  BREAK
               ENDIF
            ENDIF
            SAVE SCREEN TO scr_
            Fakt3( zVAT )
            SELECT faktury
            RESTORE SCREEN FROM scr_
         END
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  4 ] := '   [Ins]...................wpisywanie                   '
         p[  5 ] := '   [M].....................modyfikacja pozycji          '
         p[  6 ] := '   [Del]...................kasowanie pozycji            '
         p[  7 ] := '   [F10]...................szukanie                     '
         p[  8 ] := '   [Enter].................wydruk faktury               '
         p[  9 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 10 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   RETURN NIL

/*----------------------------------------------------------------------*/

*################################## FUNKCJE #################################
PROCEDURE say2603()

   CLEAR TYPEAHEAD
   SELECT faktury
   *@ 1, 6 say repl([.],60)
   SET COLOR TO +w
   @  1,  6 SAY nazwa
   @  2,  6 SAY adres
   SET COLOR TO
   *@ 1,47 say repl([.],32)
   @  2, 76 SAY '....'
   SET COLOR TO +w
   @  0, 41 SAY StrTran( Str( NUMER, 5 ), ' ', '0' )
   @  0, 55 SAY DZIEN
   @ 22,  0 SAY Space( 58 )
   DO CASE
   CASE sposob_p == 1
      @ 22, 1 SAY 'P&_l.atne przelewem w ci&_a.gu ' + Str( termin_z, 2 ) + ' dni'
   CASE sposob_p == 2
      IF termin_z == 0
         @ 22, 1 SAY 'Zap&_l.acono got&_o.wk&_a.'
      ELSE
         IF kwota == 0
            @ 22, 1 SAY 'P&_l.atne got&_o.wk&_a. w terminie ' + Str( termin_z, 2 ) + ' dni'
         ELSE
            @ 22, 1 SAY 'Zap&_l.acono ' + LTrim( kwota( kwota, 13, 2 ) ) + ', reszta p&_l.atna w terminie ' + Str( termin_z, 2 ) + ' dni'
         ENDIF
      ENDIF
   CASE sposob_p == 3
      @ 22, 1 SAY 'Zap&_l.acono czekiem'
   ENDCASE
   zident_poz := Str( rec_no, 8 )
   SELECT pozycje
   SEEK '+' + zident_poz
   razem := 0
   i := 0
   DO WHILE del == '+' .AND. ident = zident_poz
      i := i + 1
      @ 5 + i, 1 SAY Left( towar, 28 )
      IF ilosc * 1000 = 0
         @ 5 + i, 30 SAY Space( 13 )
         @ 5 + i, 44 SAY Space( 5 )
         @ 5 + i, 50 SAY Space( 14 )
      ELSE
         zm := kwota( ilosc, 13, 3 )
         IF Right( zm, 1 ) = '0'
            zm := ' ' + Left( zm, 12 )
            IF Right( zm, 1 ) = '0'
               zm := ' ' + Left( zm, 12 )
            ENDIF
            IF Right( zm, 1 ) = '0'
               zm := '  ' + Left( zm, 11 )
            ENDIF
         ENDIF
         @ 5 + i, 30 SAY zm
         @ 5 + i, 44 SAY JM
         @ 5 + i, 50 SAY CENA PICTURE "999 999 999.99"
      ENDIF
      @ 5 + i, 65 SAY WARTOSC PICTURE "999 999 999.99"
      razem := razem + wartosc
      SKIP
   ENDDO
   @ 6 + i,  1 CLEAR TO 20, 28
   @ 6 + i, 30 CLEAR TO 20, 42
   @ 6 + i, 44 CLEAR TO 20, 48
   @ 6 + i, 50 CLEAR TO 20, 63
   @ 6 + i, 65 CLEAR TO 20, 78
   @ 22, 65 say _round( razem, 2 ) PICTURE "999 999 999.99"
   SELECT faktury
   SET COLOR TO
   @ 22, 59 SAY 'Razem '

   RETURN

***************************************************
FUNCTION v26_103()

   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 0, 55 SAY zDZIEN
      SET COLOR TO
   ENDIF

   RETURN Val( zdzien ) >= 1 .AND. Val( zdzien ) <= msc( Val( miesiac ) )

***************************************************
FUNCTION v26_203()

   IF LastKey() == 5
      RETURN .T.
   ENDIF
   IF param_aut == 'T'
      SAVE SCREEN TO scr2
      SELECT kontr
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
      ENDIF
      IF del == '+' .AND. firma = ident_fir
         Kontr_()
         RESTORE SCREEN FROM scr2
         IF LastKey() == 13
            znazwa := kontr->nazwa
            zadres := kontr->adres
            znr_ident := kontr->nr_ident
            SET COLOR TO i
            @ 1, 6 SAY znazwa
            @ 2, 6 SAY zadres
            SET COLOR TO
            pause( 0.5 )
            KEYBOARD Chr( 13 )
         ENDIF
      ENDIF
   ELSE
      IF Empty( znazwa )
         SAVE SCREEN TO scr2
         SELECT kontr
         SEEK '+' + ident_fir
         IF del == '+' .AND. firma = ident_fir
            Kontr_()
            RESTORE SCREEN FROM scr2
            IF LastKey() == 13
               znazwa := nazwa
               zadres := adres
               znr_ident := nr_ident
               SET COLOR TO i
               @ 1, 6 SAY znazwa
               @ 2, 6 SAY zadres
               SET COLOR TO
               KEYBOARD Chr( 13 )
            ENDIF
         ENDIF
      ENDIF
   ENDIF
   SELECT faktury

   RETURN .NOT. Empty( znazwa )

***************************************************
FUNCTION v26_503()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   IF wiersz == 1
      IF Empty( ztowar[ 1 ] )
         RETURN .F.
      ENDIF
   ELSE
      IF Empty( ztowar[ wiersz ] )
         SET KEY 23 TO
         KEYBOARD Chr( 23 )
         RETURN .T.
      ENDIF
      IF zilosc[ 1 ] == 0
         KEYBOARD Chr( 13 ) + Chr( 13 ) + Chr( 13 )
         zilosc[ wiersz ] := 0
         zjm[ wiersz ] := Space( 5 )
         zcena[ wiersz ] := 0
      ENDIF
   ENDIF
   SET CONFIRM OFF

   RETURN .T.

***************************************************
FUNCTION v26_603()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   IF wiersz == 1
      IF zilosc[ 1 ] == 0
         KEYBOARD Chr( 13 ) + Chr( 13 )
         zjm[ 1 ] := Space( 5 )
         zcena[ 1 ] := 0
      ENDIF
      RETURN zilosc[ 1 ] >= 0
   ELSE
      RETURN zilosc[ wiersz ] > 0 .OR. zilosc[ 1 ] == 0 .OR. Empty( ztowar[ wiersz ] )
   ENDIF

***************************************************
FUNCTION v26_703()

   IF LastKey() == 5
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION v26_803()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   IF zilosc[ 1 ] # 0
      IF zilosc[ wiersz ] * zcena[ wiersz ] > 999999999
         kom( 3, '*u', ' Przekroczony zakres warto&_s.ci ' )
         RETURN .F.
      ENDIF
      zwartosc[ wiersz ] := _round( zilosc[ wiersz ] * zcena[ wiersz ], 2 )
      KEYBOARD Chr( 13 )
   ENDIF

   RETURN .T.

***************************************************
FUNCTION v26_903()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   SET CONFIRM ON
   wiersz := wiersz + 1

   RETURN .T.

***************************************************
FUNCTION v26_1003()

   IF ztermin_z < 0
      RETURN .F.
   ENDIF
   IF ztermin_z == 0
      zkwota := 0
      KEYBOARD Chr( 13 )
   ENDIF

   RETURN .T.

*############################################################################

FUNCTION Fakt3WhenTowar( nWiersz )

   LOCAL cTresc

   IF Empty( zTowar[ nWiersz ] )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT faktury
      ELSE
         SAVE SCREEN TO scr2_a
         Tresc_()
         RESTORE SCREEN FROM scr2_a
         IF LastKey() == K_ENTER
            cTresc := tresc->tresc
            zTowar[ nWiersz ] := PadR( AllTrim( cTresc ), 45 )
         ENDIF
         SELECT faktury
      ENDIF
   ENDIF
   SET CONFIRM OFF
   RETURN .T.


   RETURN NIL

/*----------------------------------------------------------------------*/

