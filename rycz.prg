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

PROCEDURE Rycz()

   LOCAL nLP1, nLP2, nPozDzien, nPozMiesiac
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou, POZOBR
   POZOBR := .F.
   zexport := 'N'
   @ 1, 47 SAY '          '
   *********************** lp
   IF param_lp == 'T'
      DO WHILE ! Dostep( 'FIRMA' )
      ENDDO
      GO Val( ident_fir )
      m->liczba := liczba
      USE
   ENDIF
   *################################# GRAFIKA ##################################
   ryczRysujTlo()
   *############################### OTWARCIE BAZ ###############################
   SELECT 3
   IF Dostep( 'TRESC' )
      SET INDEX TO tresc
   ELSE
      SELECT 1
      close_()
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'SUMA_MC' )
      SET INDEX TO suma_mc
      SEEK '+' + ident_fir + miesiac
   ELSE
      SELECT 1
      close_()
      RETURN
   ENDIF

   SELECT 1
   IF Dostep( 'EWID' )
      SetInd( 'EWID' )
      SEEK '+' + ident_fir + miesiac
   ELSE
      SELECT 1
      close_()
      RETURN
   ENDIF
   IF ! Found() .AND. suma_mc->zamek
      kom(3, '*u', ' Brak danych (miesi&_a.c jest zamkni&_e.ty) ' )
      close_()
      RETURN
   ENDIF
   *################################# OPERACJE #################################
   *----- parametry ------
   _top := 'firma#ident_fir.or.mc#miesiac'
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + '‏'
   _proc := 'say1e'
   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF ! &_top_bot
      DO &_proc
   ENDIF
   kl := 0
   VzVAT := zVAT
   DO WHILE kl # K_ESC
      zVAT := VzVAT
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      Ster()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE ( kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot ) .AND. kl # K_ESC
         @ 1, 47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         KtorOper()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            IF ins
               zDZIEN := '  '
               zDATAPRZY := CToD( '    .  .  ' )
               zNUMER := Space( 100 )
               zTRESC := Space( 30 )
               STORE 0 TO zHANDEL, zPRODUKCJA, zUSLUGI, zRY20, zRY17, zRY10, zRYK07, zRYK08, zRYK09, zRYK10
               zuwagi := Space( 200 )
               zzaplata := '1'
               zkwota := 0
               @ 19, 40 SAY Space( 40 )
               @ 13, 67 SAY Space( 12 )
               *********************** lp
               IF param_lp == 'T'
                  @ 3, 71 SAY Space( 8 )
               ENDIF
               ***********************
            ELSE
               IF Left( LTrim( numer ), 2 ) == 'S-' .OR. Left( LTrim( numer ), 2 ) == 'R-' .OR. Left( LTrim( numer ), 2 ) == 'F-' .OR. Left( LTrim( numer ), 3 ) == 'KF-' .OR. Left( LTrim( numer ), 3 ) == 'KR-'
                  kom( 4, '*u', ' Symbole S-,F-,R-,KR- i KF- mo&_z.na modyfikowa&_c. tylko w modyfikacji faktury ' )
                  BREAK
               ENDIF
               IF Left( LTrim( numer ), 3 ) == 'RS-'
                  kom( 4, '*u', ' Symbole RS- mo&_z.na modyfikowa&_c. tylko w modyfikacji rejestru sprzeda&_z.y ' )
                  BREAK
               ENDIF
               IF Left( LTrim( numer ), 3 ) == 'RZ-'
                  kom( 4, '*u', ' Symbole RZ- mo&_z.na modyfikowa&_c. tylko w modyfikacji rejestru zakupu ' )
                  BREAK
               ENDIF
               zDZIEN := DZIEN
               zDATAPRZY := DATAPRZY
               zNUMER := iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer )
               zTRESC := TRESC
               zHANDEL := HANDEL
               zUSLUGI := USLUGI
               zPRODUKCJA := PRODUKCJA
               zRY20 := RY20
               zRY17 := RY17
               zRY10 := RY10
               zRYK07 := RYK07
               zRYK08 := RYK08
               zRYK09 := RYK09
               zRYK10 := RYK10
               zuwagi := uwagi
               zzaplata := zaplata
               zkwota := kwota
            ENDIF
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            SET COLOR TO ,W+/W,,,N/W
            ColStd()
            @  3, 40 GET zDZIEN PICTURE "99" WHEN WERSJA4 == .T. .OR. ins VALID v1_1r()
            @  4, 40 GET zDATAPRZY PICTURE "@D" WHEN v1_6e()
            @  5, 40 GET zTRESC VALID v1_5r()
            @  7, 67 GET zNUMER PICTURE "@S20 " + Replicate( '!', 100 ) VALID v1_2r()
            @  8, 67 GET zRY20      PICTURE FPICold VALID v1_6ar()
            @  9, 67 GET zRY17      PICTURE FPICold VALID v1_6br()
            @ 10, 67 GET zRYK09     PICTURE FPICold VALID v1_9r()
            @ 11, 67 GET zUSLUGI    PICTURE FPICold VALID v1_6r()
            @ 12, 67 GET zRYK10     PICTURE FPICold VALID v1_10r()
            @ 13, 67 GET zPRODUKCJA PICTURE FPICold VALID v1_7r()
            @ 14, 67 GET zHANDEL    PICTURE FPICold VALID v1_8r()
            @ 15, 67 GET zRYK07     PICTURE FPICold
            @ 16, 67 GET zRY10      PICTURE FPICold
            IF staw_k08w
               @ 15, 67 GET zRYK08     PICTURE FPICold
            ENDIF
            SET COLOR TO i
            @ 19, 40 SAY SubStr( zUWAGI, 1, 40 )
            SET COLOR TO
            CLEAR TYPEAHEAD
            read_()
            IF LastKey() == K_ESC
               BREAK
            ENDIF
            ColStd()
            @ 19, 40 GET zUWAGI PICTURE "@S40 " + Replicate( "X", 200 )
            CLEAR TYPEAHEAD
            Read_()
            IF LastKey() == K_ESC
               BREAK
            ENDIF
            *-------------------------
            IF AllTrim( znumer ) == 'REM-P' .OR. AllTrim( znumer ) == 'REM-K'
               zzaplata := '1'
               zkwota := 0
            ELSE
               ColStd()
               @ 23,  0
               @ 24,  7 PROMPT '[ Zap&_l.acone ]'
               @ 24, 27 PROMPT '[ Cz&_e.&_s.ciowo zap&_l.acone ]'
               @ 24, 57 PROMPT '[ Niezap&_l.acone ]'
               zzaplata := Str( Menu( Val( zzaplata ) ), 1 )
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               IF zzaplata == '2'
                  @ 24,  0
                  @ 24, 28 SAY 'Zaplacono' GET zkwota PICTURE '   99999999.99' VALID v1_22r()
                  CLEAR TYPEAHEAD
                  Read_()
                  IF LastKey() == K_ESC
                     BREAK
                  ENDIF
                  SET COLOR TO i
                  @ 24, 38 SAY Kwota( zkwota, 14, 2 )
                  SET COLOR TO
               ELSE
                  zkwota := 0
               ENDIF
            ENDIF
            *-------------------------
            zNUMER := dos_l( znumer )
            zdzien := Str( Val( zDZIEN ), 2 )
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            tresc_ := tresc
            stan_ := -USLUGI - PRODUKCJA - HANDEL - RY20 - RY17 - RY10 - RYK07 - RYK08 - RYK09 - RYK10
            obrot_ := USLUGI + PRODUKCJA + HANDEL + RY20 + RY17 + RY10 + RYK07 + RYK08 + RYK09 + RYK10
            SELECT tresc
            IF ! ins
               SEEK '+' + ident_fir + tresc_
               IF Found()
                  BlokadaR()
                  repl_( 'stan', stan - stan_ )
                  COMMIT
                  UNLOCK
               ENDIF
            ENDIF
            SEEK '+' + ident_fir + ztresc
            IF Found()
               BlokadaR()
               repl_( 'stan', stan+( -zPRODUKCJA - zUSLUGI - zHANDEL - zRY20 - zRY17 - zRY10 - zRYK07 - zRYK08 - zRYK09 - zRYK10 ) )
               COMMIT
               UNLOCK
            ENDIF
            SELECT suma_mc
            BlokadaR()
            IF ! ins .AND. Left( ewid->numer, 1 ) # Chr( 1 ) .AND. Left( ewid->numer, 1 ) # Chr( 254 )
               repl_( 'wyr_tow', wyr_tow - ewid->produkcja )
               repl_( 'uslugi', uslugi - ewid->uslugi )
               repl_( 'handel', handel - ewid->handel )
               repl_( 'RY20', RY20 - ewid->RY20 )
               repl_( 'RY17', RY17 - ewid->RY17 )
               repl_( 'RY10', RY10 - ewid->RY10 )
               repl_( 'RYK07', RYK07 - ewid->RYK07 )
               repl_( 'RYK08', RYK08 - ewid->RYK08 )
               repl_( 'RYK09', RYK09 - ewid->RYK09 )
               repl_( 'RYK10', RYK10 - ewid->RYK10 )
            ENDIF
            IF RTrim( znumer ) # 'REM-P' .AND. RTrim( znumer ) # 'REM-K'
               repl_( 'wyr_tow', wyr_tow + zPRODUKCJA )
               repl_( 'uslugi', uslugi + zuslugi )
               repl_( 'handel', handel + zhandel )
               repl_( 'RY20', RY20 + zRY20 )
               repl_( 'RY17', RY17 + zRY17 )
               repl_( 'RY10', RY10 + zRY10 )
               repl_( 'RYK07', RYK07 + zRYK07 )
               repl_( 'RYK08', RYK08 + zRYK08 )
               repl_( 'RYK09', RYK09 + zRYK09 )
               repl_( 'RYK10', RYK10 + zRYK10 )
            ENDIF
            IF ins
               repl_( 'pozycje', pozycje + 1 )
            ENDIF
            COMMIT
            UNLOCK
            SELECT ewid
            IF ins
               app()
               repl_( 'firma', ident_fir )
               repl_( 'mc', miesiac )
            ENDIF
            BlokadaR()
            repl_( 'DZIEN', zdzien )
            repl_( 'DATAPRZY', zDATAPRZY )
            DO CASE
            CASE RTrim( znumer ) == 'REM-P'
               repl_( 'NUMER', Chr( 1 ) + znumer )
            CASE rtrim( znumer ) == 'REM-K'
               repl_( 'NUMER', Chr( 254 ) + znumer )
            OTHERWISE
               repl_( 'NUMER', znumer )
            ENDCASE
            repl_( 'TRESC', zTRESC )
            repl_( 'PRODUKCJA', zPRODUKCJA )
            repl_( 'USLUGI', zUSLUGI )
            repl_( 'HANDEL', zHANDEL )
            repl_( 'RY20', zRY20 )
            repl_( 'RY17', zRY17 )
            repl_( 'RY10', zRY10 )
            repl_( 'RYK07', zRYK07 )
            repl_( 'RYK08', zRYK08 )
            repl_( 'RYK09', zRYK09 )
            repl_( 'RYK10', zRYK10 )
            repl_( 'UWAGI', zUWAGI )
            repl_( 'zaplata', zzaplata )
            repl_( 'kwota', zkwota )
            COMMIT
            UNLOCK
            *********************** lp
            IF param_lp == 'T'
               IF param_kslp == '3'
                  SET ORDER TO 4
               ENDIF
               Blokada()
               ColInb()
               @ 24, 0
               Center( 24, 'Prosz&_e. czeka&_c....' )
               SET COLOR TO
               rec := RecNo()
               IF ins
                  SKIP -1
                  IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                     zlp := liczba
                  ELSE
                     zlp := lp + 1
                  ENDIF
                  GO rec
                  DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                     repl_( 'lp', zlp )
                     zlp := zlp + 1
                     SKIP
                  ENDDO
               ELSE
                  zlp := lp
                  SKIP -1
                  IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                     zlp := liczba
                     GO rec
                     DO WHILE del == '+' .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                        repl_( 'lp', zlp )
                        zlp := zlp + 1
                        SKIP
                     ENDDO
                  ELSE
                     IF lp < zlp
                        zlp := lp + 1
                        GO rec
                        DO WHILE del == '+' .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
                           repl_( 'lp', zlp )
                           zlp := zlp + 1
                           SKIP
                        ENDDO
                     ELSE
                        zlp := lp
                        GO rec
                        DO WHILE ! Bof() .AND. firma == ident_fir .AND. lp # zlp .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
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
               @ 24, 0
            ENDIF
            ***********************
            COMMIT
            *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
         END
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         @ 23, 0
         @ 24, 0
         *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' ) .OR. kl == K_CTRL_DEL
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, '‏                   ‏' )
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
            IF kl <> K_CTRL_DEL
               IF Left( numer, 2 ) == 'S-' .OR. Left( numer, 2 ) == 'R-' .OR. Left( numer, 2 ) == 'F-' .OR. Left( numer, 3 ) == 'KF-' .OR. Left( numer, 3 ) == 'KR-'
                  kom( 4, '*u', ' Symbole S-,F-,R-,KF- i KR- mo&_z.na wykasowa&_c. tylko w opcji FAKTUROWANIE ' )
                  BREAK
               ENDIF
               IF Left( numer, 3 ) == 'RS-'
                  kom( 4, '*u', ' Na dokumenty o symbolu RS- mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr sprzeda&_z.y ' )
                  BREAK
               ENDIF
               IF Left( numer, 3 ) == 'RZ-'
                  kom( 4, '*u', ' Na dokumenty o symbolu RZ- mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr zakupu ' )
                  BREAK
               ENDIF
            ELSE
               IF Left( numer, 3 ) == 'RS-' .AND. rejzid > 0
                  SELECT 100
                  DO WHILE ! Dostep( 'REJS' )
                  ENDDO
                  dbGoto( ewid->rejzid )
                  IF AllTrim( SubStr( ewid->numer, 4 ) ) == AllTrim( numer ) .AND. del == '+'
                     kom( 4, '*u', ' Na dokumenty o symbolu RS- mo&_z.na wp&_l.ywa&_c. tylko poprzez rejestr sprzeda&_z.y ' )
                     dbCloseArea()
                     SELECT ewid
                     BREAK
                  ENDIF
                  dbCloseArea()
                  SELECT ewid
               ELSE
                  kom( 4, '*u', ' Nie mo¾na usun¥† tego dokumentu ' )
                  BREAK
               ENDIF
            ENDIF
            IF ! TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            tresc_ := tresc
            stan_ := -PRODUKCJA - USLUGI - HANDEL - RY20 - RY17 - RY10 - RYK07 - RYK08 - RYK09 - RYK10
            obrot_ := PRODUKCJA + USLUGI + HANDEL + RY20 + RY17 + RY10 + RYK07 + RYK08 + RYK09 + RYK10
            SELECT tresc
            SEEK '+' + ident_fir + tresc_
            IF Found()
               BlokadaR()
               repl_( 'stan', stan-stan_)
               COMMIT
               UNLOCK
            ENDIF
            SELECT suma_mc
            BlokadaR()
            IF Left( ewid->numer, 1 ) # Chr( 1 ) .AND. Left( ewid->numer, 1 ) # Chr( 254 )
               repl_( 'wyr_tow', wyr_tow - ewid->produkcja )
               repl_( 'uslugi', uslugi - ewid->uslugi )
               repl_( 'handel', handel - ewid->handel )
               repl_( 'RY20', RY20 - ewid->RY20 )
               repl_( 'RY17', RY17 - ewid->RY17 )
               repl_( 'RY10', RY10 - ewid->RY10 )
               repl_( 'RYK07', RYK07 - ewid->RYK07 )
               repl_( 'RYK08', RYK08 - ewid->RYK08 )
               repl_( 'RYK09', RYK09 - ewid->RYK09 )
               repl_( 'RYK10', RYK10 - ewid->RYK10 )
            ENDIF
            repl_( 'pozycje', pozycje - 1 )
            COMMIT
            UNLOCK
            SELECT ewid
            BlokadaR()
            del()
            COMMIT
            UNLOCK
            SKIP
            *********************** lp
            IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir
               IF param_kslp == '3'
                  SET ORDER TO 4
               ENDIF
               Blokada()
               SET COLOR TO *w
               Center( 24, 'Prosz&_e. czeka&_c....' )
               SET COLOR TO
               rec := RecNo()
               DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == miesiac, .T. )
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
            *******************************
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            IF ! &_bot
               DO &_proc
            ELSE
               ryczRysujTlo()
            ENDIF
         end
         @ 23, 0
         @ 24, 0

      *################################# SZUKANIE DNIA ############################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         Center( 23, '‏                 ‏' )
         ColSta()
         Center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := '  '
         @ 3, 40 GET f10 PICTURE "99"
         Read_()
         IF ! Empty( f10 ) .AND. LastKey() # K_ESC
            SEEK '+' + ident_fir + miesiac + Str( Val( f10 ), 2 )
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         DO &_proc
         @ 23, 0

      *################################# SZUKANIE ZLOZONE #########################
      CASE kl == K_F9
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         ColStb()
         Center( 23, '‏                 ‏' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         zDZIEN := '  '
         zNUMER := '                    '
         zZDARZ := Space( 20 )
         zLP := '     '
         DECLARE pp[ 4 ]
         *---------------------------------------
         pp[ 1] := '      Dzie&_n.:                     '
         pp[ 2] := '  Nr dowodu:                     '
         pp[ 3] := '  Zdarzenie:                     '
         pp[ 4] := '       L.p.:                     '
         *---------------------------------------
         SET COLOR TO N/W,W+/W,,,N/W
         i := 4
         j := 22
         DO WHILE i > 0
            IF Type( 'pp[i]' ) # 'U'
               Center( j, pp[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET CURSOR ON
         ColStd()
         @ 19, 35 GET zDZIEN PICTURE '99' VALID zDZIEN == '  ' .OR. ( Val( zDZIEN ) >= 1 .AND. Val( zDZIEN ) <= 31 )
         @ 20, 35 GET zNUMER PICTURE '!!!!!!!!!!!!!!!!!!!!'
         @ 21, 35 GET zZDARZ PICTURE Replicate( '!', 20 )
         @ 22, 35 GET zLP PICTURE '99999'
         READ
         SET COLOR TO
         SET CURSOR OFF
         REC := RecNo()
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            GO top
            SZUK := "del='+'.and.firma=ident_fir.and.mc=miesiac"
            SEEK '+' + ident_fir + miesiac
            IF AllTrim( zDZIEN ) <> ""
               AA := Str( Val( zDZIEN ), 2 )
               SZUK := SZUK + '.and.DZIEN=AA'
            ENDIF
            IF AllTrim( zNUMER ) <> ""
               aNUMER := AllTrim( zNUMER )
               SZUK := SZUK + '.and.aNUMER$upper(NUMER)'
            ENDIF
            IF AllTrim( zZDARZ ) <> ""
               aZDARZ := AllTrim( zZDARZ )
               SZUK := SZUK + '.and.aZDARZ$upper(TRESC)'
            ENDIF
            IF AllTrim( zLP ) <> ""
               SZUK := SZUK + '.and.LP=val(zLP)'
            ENDIF
            IF SZUK <> "del='+'.and.firma=ident_fir.and.mc=miesiac"
               DO WHILE ! Eof() .AND. del == '+' .AND. firma == ident_fir .AND. mc == miesiac
                  IF &SZUK
                     REC := RecNo()
                     SC1 := savescreen( 17, 23, 22, 57 )
                     RESTORE SCREEN FROM scr_
                     DO &_proc
                     SAVE SCREEN TO scr_
                     RestScreen( 17, 23, 22, 57, SC1 )
                     @ 23, 0
                     WSZUK := 1
                     ColStd()
                     @ 24, 18 PROMPT '[ Dalsze szukanie ]'
                     @ 24, 42 PROMPT '[ Koniec szukania ]'
                     MENU TO wszuk
                     IF WSZUK == 2
                        RESTORE SCREEN FROM scr_
                        EXIT
                     ENDIF
                  ENDIF
                  SKIP 1
               ENDDO
               kom( 3, '*u', ' KONIEC SZUKANIA ' )
            ENDIF
         ENDIF
         RESTORE SCREEN FROM scr_
         GO REC
         DO &_proc
         _disp := .F.
      *#################################### POMOC ##################################
      CASE kl == K_F1
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE pppp[ 20 ]
         *---------------------------------------
         pppp[  1 ] := '                                                        '
         pppp[  2 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         pppp[  3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         pppp[  4 ] := '   [Ins]...................wpisywanie                   '
         pppp[  5 ] := '   [M].....................modyfikacja pozycji          '
         pppp[  6 ] := '   [Del]...................kasowanie pozycji            '
         pppp[  7 ] := '   [F9 ]...................szukanie z&_l.o&_z.one             '
         pppp[  8 ] := '   [F10]...................szukanie dnia                '
         pppp[  9 ] := '   [Esc]...................wyj&_s.cie                      '
         pppp[ 10 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 12
         j := 22
         DO WHILE i>0
            IF Type( 'pppp[i]' ) # 'U'
               Center( j, pppp[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.

      *########################### PRZESUN W GORE #################################
      CASE kl == K_CTRL_PGUP .AND. param_kslp == '3'
         SELECT ewid
         nPozDzien := ewid->dzien
         nPozMiesiac := ewid->mc
         nLP1 := ewid->lp
         rec := RecNo()
         dbSkip( -1 )
         IF Bof() .OR. firma#ident_fir .OR. nPozDzien <> ewid->dzien .OR. nPozMiesiac <> ewid->mc
            dbGoto( rec )
            komun('Nie mo¾na przesun¥† wy¾ej')
         ELSE
            nLP2 := ewid->lp
            blokada()
            ewid->lp := nLP1
   //         unlock
            dbGoto( rec )
   //         blokadar()
            ewid->lp := nLP2
            unlock
   //         setind('OPER')
   //         dbGoto( rec )
            commit_()
         ENDIF
         DO &_proc

      *########################### PRZESUN W DOL ##################################
      CASE kl == K_CTRL_PGDN .AND. param_kslp == '3'
         SELECT ewid
         nPozDzien := ewid->dzien
         nPozMiesiac := ewid->mc
         nLP1 := ewid->lp
         rec := RecNo()
         dbSkip( 1 )
         IF Eof() .OR. firma#ident_fir .OR. nPozDzien <> ewid->dzien .OR. nPozMiesiac <> ewid->mc
            dbGoto( rec )
            komun('Nie mo¾na przesun¥† ni¾ej')
         ELSE
            nLP2 := ewid->lp
            blokada()
            ewid->lp := nLP1
   //         unlock
            dbGoto( rec )
   //         blokadar()
            ewid->lp := nLP2
            unlock
   //         setind('OPER')
   //         dbGoto( rec )
            commit_()
         ENDIF
         DO &_proc
      ******************** ENDCASE
      ENDCASE
   ENDDO
   zVAT := VzVAT
   close_()
   RETURN

*################################## FUNKCJE #################################
PROCEDURE say1e()
   CLEAR TYPEAHEAD
   SELECT ewid
   *********************** lp
   IF param_lp == 'T'
      @ 3, 71 SAY 'Lp.'
      SET COLOR TO +w
      @ 3, 74 SAY lp PICTURE '99999'
      SET COLOR TO
   ENDIF
   ***********************
   SET COLOR TO +w
   @  3, 40 SAY dos_l( DZIEN )
   @  4, 40 SAY DToC( DATAPRZY )
   @  5, 40 SAY TRESC
   @  7, 67 SAY SubStr( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + ' ', numer ), 1, 20 )
   @  8, 67 SAY RY20 PICTURE RPIC
   @  9, 67 SAY RY17 PICTURE RPIC
   @ 10, 67 SAY RYK09 PICTURE RPIC
   @ 11, 67 SAY uslugi PICTURE RPIC
   @ 12, 67 SAY RYK10 PICTURE RPIC
   @ 13, 67 SAY produkcja PICTURE RPIC
   @ 14, 67 SAY handel PICTURE RPIC
   @ 15, 67 SAY RYK07 PICTURE RPIC
   @ 16, 67 SAY RY10 PICTURE RPIC
/*
   IF staw_k08w
      @ 15, 67 SAY RYK08 PICTURE RPIC
   ENDIF
*/
   @ 17, 67 SAY handel + produkcja + uslugi + RY20 + RY17 + RY10 + RYK07 + RYK08 + RYK09 + RYK10 PICTURE RPIC
   @ 19, 40 SAY SubStr( uwagi, 1, 40 )
   @ 21, 40 SAY Space( 40 )
   DO CASE
   CASE zaplata == '1'
      DO CASE
      CASE Left( NUMER, 3 ) == 'RS-'
         @ 21, 40 SAY 'Informacja w Rejestrze Sprzeda&_z.y'
      OTHERWISE
         @ 21, 40 SAY 'Zap&_l.acone'
      ENDCASE
   CASE zaplata == '2'
      DO CASE
      CASE Left( NUMER, 3 ) == 'RS-'
         @ 21, 40 SAY 'Informacja w Rejestrze Sprzeda&_z.y'
      OTHERWISE
         @ 21, 40 SAY dos_p( 'Zap&_l.acono ' + dos_l( kwota( kwota, 14, 2 ) ) )
      ENDCASE
   CASE zaplata == '3'
      DO CASE
      CASE Left( NUMER, 3 ) == 'RS-'
         @ 21, 40 SAY 'Informacja w Rejestrze Sprzeda&_z.y'
      OTHERWISE
         @ 21, 40 SAY 'Niezap&_l.acone'
      ENDCASE
   ENDCASE
   SET COLOR TO
   RETURN

***************************************************
FUNCTION v1_1r()

   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 3, 40 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF
   curdok := param_rok + StrTran( miesiac, ' ', '0' ) + StrTran( Str( Val( zdzien ), 2 ), ' ', '0' )
   currek := param_rok + StrTran( miesiac, ' ', '0' ) + StrTran( Str( Val( ewid->dzien ), 2 ), ' ', '0' )
   RETURN .T.

***************************************************
FUNCTION v1_5r()
***************************************************
   IF Empty( ztresc )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT ewid
      ELSE
         SAVE SCREEN TO scr2
         Tresc_()
         RESTORE SCREEN FROM scr2
         SELECT ewid
         IF LastKey() == K_ESC
            RETURN .T.
         ENDIF
         ztresc := Left( tresc->tresc, 30 )
         SET COLOR TO i
         @ 5, 40 SAY ztresc
         SET COLOR TO
      ENDIF
   ENDIF
   *if alltrim(znumer)=[REM-P].or.alltrim(znumer)=[REM-K]
   *keyboard chr(13)+chr(13)
   *endif
   RETURN .T.

***************************************************
FUNCTION V1_2r()
***************************************************
   IF ' ' $ AllTrim( znumer )
      RETURN .F.
   ENDIF
   @ 24, 0
   DO CASE
   CASE AllTrim( znumer ) == 'REM-P'
      Center( 24, ' Symbol zastrzezony dla remanentu pocz&_a.tkowego ' )
   CASE AllTrim( znumer ) == 'REM-K'
      Center( 24, ' Symbol zastrzezony dla remanentu ko&_n.cowego ' )
   CASE Left( LTrim( znumer ), 2 ) == 'S-'
      Kom( 4, '*u', ' Symbol dowodu (S-) jest zastrzezony dla faktur ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'F-'
      Kom( 4, '*u', ' Symbol dowodu (F-) jest zastrzezony dla faktur VAT' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 2 ) == 'R-'
      Kom( 4, '*u', ' Symbol dowodu (R-) jest zastrzezony dla rachunk&_o.w uproszczonych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KF-'
      Kom( 4, '*u', ' Symbol dowodu (KF-) jest zastrzezony dla faktur VAT koryguj&_a.cych ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'KR-'
      Kom( 4, '*u', ' Symbol dowodu (KR-) jest zastrzezony dla rachunk&_o.w uproszcz.koryg. ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RS-'
      Kom( 4, '*u', ' Symbol dowodu (RS-) jest zastrzezony dla sum z rejestru sprzeda&_z.y ' )
      RETURN .F.
   CASE Left( LTrim( znumer ), 3 ) == 'RZ-'
      Kom( 4, '*u', ' Symbol dowodu (RZ-) jest zastrzezony dla dokument&_o.w z rejestru zakupu ' )
      RETURN .F.
   ENDCASE
   EwidSprawdzNrDok( 'EWID', ident_fir, miesiac, znumer, iif( ins, 0, RecNo() ) )
   RETURN .T.

***************************************************
FUNCTION v1_6ar()

   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zRY20 # 0 .AND. LastKey() == K_ENTER
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION v1_6br()

   IF LastKey() == K_UP
      set color TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zRY17 # 0 .AND. LastKey() == K_ENTER
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION v1_6r()

   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zUSLUGI # 0 .AND. LastKey() == K_ENTER
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION v1_6e()
***************************************************
   IF zDATAPRZY == CToD( '    .  .  ' )
      zDATAPRZY := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION V1_7r()
***************************************************
   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zPRODUKCJA <> 0 .AND. LastKey() == K_ENTER
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION V1_8r()
***************************************************
   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zHANDEL <> 0 .AND. LastKey() == K_ESC
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION V1_9r()
***************************************************
   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zRYK09 <> 0 .AND. LastKey() == K_ESC
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION V1_10r()
***************************************************
   IF LastKey() == K_UP
      SET COLOR TO w+
      @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
      SET COLOR TO
      RETURN .T.
   ENDIF
   IF zRYK10 <> 0 .AND. LastKey() == K_ESC
      SET KEY 23 TO
      KEYBOARD Chr( K_CTRL_W )
   ENDIF
   SET COLOR TO w+
   @ 17, 67 SAY iif( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08 + zRYK09 + zRYK10 # 0, dos_l( Kwota( zhandel + zprodukcja + zuslugi + zRY20 + zRY17 + zRY10 + zRYK07 + zRYK08, 12, 2 ) ), Space( 12 ) )
   SET COLOR TO
   RETURN .T.

***************************************************
FUNCTION V1_22r()
***************************************************
   RETURN ZKWOTA > 0

*############################################################################
FUNCTION ryczRysujTlo()

   ColStd()
   @  3, 0 SAY ' (2)  Data wpisu (dzie&_n.)................                                        '
   @  4, 0 SAY ' (3)  Data uzyskania przychodu..........                                        '
   @  5, 0 SAY '      Opis zdarzenia....................                                        '
   @  6, 0 SAY ' ------------------------------PRZYCHODY--------------------------------------- '
   @  7, 0 SAY ' (4)  Nr fakt/rach lub dziennego zestawienia sprzeda&_z.y.............             '
   @  8, 0 SAY ' (5)  Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_ry20 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ory20 ) ) + ')', 25, '.' ) + '.             '
   @  9, 0 SAY ' (6)  Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_ry17 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ory17 ) ) + ')', 25, '.' ) + '.             '
   @ 10, 0 SAY ' (7)  Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_rk09 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ork09 ) ) + ')', 25, '.' ) + '.             '
   @ 11, 0 SAY ' (8)  Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_uslu * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ouslu ) ) + ')', 25, '.' ) + '.             '
   @ 12, 0 SAY ' (9)  Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_rk10 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ork10 ) ) + ')', 25, '.' ) + '.             '
   @ 13, 0 SAY ' (10) Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_prod * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_oprod ) ) + ')', 25, '.' ) + '.             '
   @ 14, 0 SAY ' (11) Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_hand * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ohand ) ) + ')', 25, '.' ) + '.             '
   @ 15, 0 SAY ' (12) Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_rk07 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ork07 ) ) + ')', 25, '.' ) + '.             '
   @ 16, 0 SAY ' (13) Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_ry10 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ory10 ) ) + ')', 25, '.' ) + '.             '
/*
   IF staw_k08w
      @ 15, 0 SAY ' (12) Warto&_s.&_c. sprzedazy wg stawki ' + Str( staw_rk08 * 100, 5, 2 ) + '% (' + PadR( Lower( AllTrim( staw_ork08 ) ) + ')', 25, '.' ) + '.             '
      @ 16, 0 SAY ' ------------------------------------------------------------------------------ '
      @ 17, 0 SAY ' (13) OGאEM PRZYCHאD (5+6+7+8+9+10+11+12).........................             '
      @ 18, 0 SAY ' ------------------------------------------------------------------------------ '
      @ 19, 0 SAY ' (14) Uwagi......................................................               '
   ELSE
      @ 15, 0 SAY '                                                                                '
      @ 16, 0 SAY ' ------------------------------------------------------------------------------ '
      @ 17, 0 SAY ' (12) OGאEM PRZYCHאD (5+6+7+8+9+10+11)............................             '
      @ 18, 0 SAY ' ------------------------------------------------------------------------------ '
      @ 19, 0 SAY ' (13) Uwagi......................................................               '
   ENDIF
*/

   @ 17, 0 SAY ' (14) OGאEM PRZYCHאD (5+6+7+8+9+10+11+12+13)......................             '
   @ 18, 0 SAY ' ------------------------------------------------------------------------------ '
   @ 19, 0 SAY ' (15) Uwagi......................................................               '

   @ 20, 0 SAY ' ------------------------------------------------------------------------------ '
   @ 21, 0 SAY '      Zap&_l.acono ?.......................                                        '
   @ 22, 0 SAY Space( 80 )
   RETURN

/*----------------------------------------------------------------------*/

