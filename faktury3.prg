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

   *############################### OTWARCIE BAZ ###############################
   SELECT 7
   IF Dostep( 'TRESC' )
      SetInd( 'TRESC' )
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

   *################################# GRAFIKA ##################################
   IF firma->rodzajfnv == 'R'
      @  0, 0 SAY '                  R A C H U N E K     Nr        z dnia                          '
   ELSE
      @  0, 0 SAY '                    F A K T U R A     Nr        z dnia                          '
   ENDIF
   @  1, 0 SAY 'Dla NIP:..............   Nazwa:.................................................'
   @  2, 0 SAY 'Adres:................................................................  Kraj:   '
   @  3, 0 SAY 'Úֲֲֲֲִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ¿'
   @  4, 0 SAY '³     Nazwa towaru/us&_l.ugi    ³    Ilo&_s.&_c.    ³ Jm  ³  Cena jedn.  ³    Warto&_s.&_c.   ³'
   @  5, 0 SAY 'ֳִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִֵֵֵֵ´'
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
   @ 21, 0 SAY 'ְֱֱֱֱִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִÙ'
   @ 22, 0 SAY '                                                                                '

   *################################# OPERACJE #################################
   *----- parametry ------
   _top := "firma#ident_fir.or.mc#miesiac"
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + mc
   _sbot := '+' + ident_fir + mc + '‏'
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
      CASE ( kl == 22 .OR. kl == 48 .OR. kl == 109 .OR. kl == 77 .OR. kl == K_F6 .OR. &_top_bot ) .AND. kl <> K_F7
         ins := ( kl # 109 .AND. kl # 77 ) .OR. kl == K_F6 .OR. &_top_bot
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
            *ננננננננננננננננננננננננננננננ ZMIENNE ננננננננננננננננננננננננננננננננ
            DECLARE ztowar[ 15 ], zilosc[ 15 ], zjm[ 15 ], zcena[ 15 ], zwartosc[ 15 ]
            FOR I := 1 TO 15
                ztowar[ i ] := Space( 512 )
                zilosc[ i ] := 0
                zjm[ i ] := Space( 5 )
                zcena[ i ] := 0
                zwartosc[ i ] := 0
            NEXT
            IF ins .AND. kl == K_F6
               aBufDok := Bufor_Dok_Wybierz( 'faktury3' )
               IF ! Empty( aBufDok )
                  @ 6, 65 CLEAR TO 20, 75
                  zrach := aBufDok[ 'RACH' ]
                  zNUMER := firma->nr_rach
                  zDZIEN := '  '
                  znazwa := aBufDok[ 'NAZWA' ]
                  zADRES := aBufDok[ 'ADRES' ]
                  zsposob_p := aBufDok[ 'SPOSOB_P' ]
                  zkwota := aBufDok[ 'KWOTA' ]
                  znr_ident := aBufDok[ 'NR_IDENT' ]
                  ztermin_z := aBufDok[ 'TERMIN_Z' ]
                  zkraj := aBufDok[ 'KRAJ' ]
                  i := 0
                  AEval( aBufDok[ 'pozycje' ], { | aPoz |
                     i := i + 1
                     ztowar[ i ] := aPoz[ 'TOWAR' ]
                     zilosc[ i ] := aPoz[ 'ILOSC' ]
                     zjm[ i ] := aPoz[ 'JM' ]
                     zcena[ i ] := aPoz[ 'CENA' ]
                     zwartosc[ i ] := aPoz[ 'WARTOSC' ]
                  } )
               ELSE
                  BREAK
               ENDIF
            ELSEIF ins
               @ 6, 65 CLEAR TO 20, 75
               zrach := iif( firma->rodzajfnv $ 'FR', firma->rodzajfnv, 'F' )
               zNUMER := firma->nr_rach
               zDZIEN := '  '
               znazwa := Space( 70 )
               zADRES := Space( 40 )
               zsposob_p := 2
               ztermin_z := 0
               zkwota := 0
               znr_ident := Space( 30 )
               zkraj := '  '
               //@  2, 47 SAY repl( '.', 32 )
               @ 22,  0
            ELSE
               zrach := RACH
               zNUMER := NUMER
               zDZIEN := DZIEN
               znazwa := nazwa
               zADRES := ADRES
               zsposob_p := sposob_p
               zkwota := kwota
               znr_ident := nr_ident
               ztermin_z := termin_z
               zkraj := kraj
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
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            SET COLOR TO +w
            @ 0, 41 SAY StrTran( Str( zNUMER, 5 ), ' ', '0' )
            SET COLOR TO
            @ 0, 55 GET zDZIEN PICTURE "99" VALID v26_103()
            @ 1,  8 GET zNR_IDENT PICTURE "@S14 " + repl( '!', 30 ) VALID Faktury3_KonValidNIP()
            @ 1, 31 GET znazwa PICTURE "@S49 " + repl( '!', 200 ) VALID v26_203()
            @ 2,  6 GET zADRES PICTURE "@S64 " + repl( '!', 200 )
            @ 2, 77 GET zKRAJ  PICTURE "!!"
            FOR i := 1 TO 15
                @ 5 + i,  1 GET ztowar[ i ]   PICTURE '@s28 !' + repl( 'X', 512 ) WHEN { | oGet | Fakt3WhenTowar( oGet:row - 5 ) } VALID v26_503()
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
               //zkwota := 0
               @ 22, 10 SAY 'Pˆatne przelewem w ci¥gu    dni,'
               @ 22, 35 GET ztermin_z PICTURE '99' RANGE 1, 99
               @ 22, 43 SAY 'zapˆacono' GET zkwota PICTURE '   99999999.99' RANGE 0, 99999999999
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
            *ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            SELECT kontr
            IF .NOT. Empty( znazwa ) .AND. param_aut == 'T'
               SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
               IF .NOT. Found()
                  app()
                  repl_( 'firma', ident_fir )
                  repl_( 'nazwa', znazwa )
                  repl_( 'adres', zadres )
                  repl_( 'nr_ident', znr_ident )
                  repl_( 'kraj', zkraj )
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
            repl_( 'rach', zrach )
            repl_( 'kraj', zkraj )
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

            Faktury3_Ksieguj()

            ***********************
            SELECT faktury
            commit_()
            *נננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננננ
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
         center( 23, '‏                 ‏' )
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
            IF firma_rodzajdrfv == 'G'
               Faktury3_DrukGraf()
            ELSE
               Fakt3( zVAT )
            ENDIF
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
         p[  7 ] := '   [O].....................edycja odbiorcy faktury      '
         p[  8 ] := '   [F10]...................szukanie                     '
         p[  9 ] := '   [F5 ]..................kopiowanie dokumentu do bufora'
         p[ 10 ] := '   [Shift+F5]........kopiowanie wsystkich dok. do bufora'
         p[ 11 ] := '   [F6]....................wstawianie z bufora          '
         p[ 12 ] := '   [F7]..............wstawianie wszystkich dok. z bufora'
         p[ 13 ] := '   [Enter].................wydruk faktury               '
         p[ 14 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 15 ] := '                                                        '
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

      CASE kl == K_F5
         IF faktury->korekta <> 'T'
            aBufRec := FakturyN_PobierzDok()
            IF ( nBufRecIdx := Bufor_Dok_Znajdz( 'faktury3', id ) ) > 0
               bufor_dok[ 'faktury3' ][ nBufRecIdx ] := aBufRec
            ELSE
               AAdd( bufor_dok[ 'faktury3' ], aBufRec )
            ENDIF
            Komun( "Dokument zostaˆ skopiowany" )
         ELSE
            Komun( "Nie mo¾na kopiowa† faktury koryguj¥cej" )
         ENDIF

      CASE kl == K_SH_F5
         IF TNEsc( , "Czy skopiowa† wszytkie faktury do bufora? (Tak/Nie)" )
            nAktRec := RecNo()
            nLicznik := 0
            GO TOP
            SEEK "+" + ident_fir + miesiac
            DO WHILE ! &_bot
               IF faktury->korekta <> 'T'
                  aBufRec := FakturyN_PobierzDok()
                  IF ( nBufRecIdx := Bufor_Dok_Znajdz( 'faktury3', id ) ) > 0
                     bufor_dok[ 'faktury3' ][ nBufRecIdx ] := aBufRec
                  ELSE
                     AAdd( bufor_dok[ 'faktury3' ], aBufRec )
                  ENDIF
                  nLicznik++
               ENDIF
               SKIP
            ENDDO
            dbGoto( nAktRec )
            Komun( "Skopiowano " + AllTrim( Str( nLicznik ) ) + " dokument¢w" )
         ENDIF

      CASE kl == K_F7

         IF HB_ISHASH( bufor_dok ) .AND. hb_HHasKey( bufor_dok, 'faktury3' ) .AND. HB_ISARRAY( bufor_dok[ 'faktury3' ] ) .AND. Len( bufor_dok[ 'faktury3' ] ) > 0

            IF TNEsc( , "Czy wstawi† wsystkie faktury z bufora? (Tak/Nie)" )

           ins := .T.
            lKorekta := .F.
            DECLARE ztowar[ 15 ], zilosc[ 15 ], zjm[ 15 ], zcena[ 15 ], zwartosc[ 15 ]
            ColInf()
            @ 24, 0 SAY PadC( "Dodawanie dokument¢w... Prosz© czeka†...", 80 )
            AEval( bufor_dok[ 'faktury3' ], { | aBufDok |

            FOR I := 1 TO 15
                ztowar[ i ] := Space( 512 )
                zilosc[ i ] := 0
                zjm[ i ] := Space( 5 )
                zcena[ i ] := 0
                zwartosc[ i ] := 0
            NEXT
                  zrach := aBufDok[ 'RACH' ]
                  zNUMER := firma->nr_rach
                  zDZIEN := Str( Day( Date() ), 2 )
                  znazwa := aBufDok[ 'NAZWA' ]
                  zADRES := aBufDok[ 'ADRES' ]
                  zsposob_p := aBufDok[ 'SPOSOB_P' ]
                  zkwota := aBufDok[ 'KWOTA' ]
                  znr_ident := aBufDok[ 'NR_IDENT' ]
                  ztermin_z := aBufDok[ 'TERMIN_Z' ]
                  zkraj := aBufDok[ 'KRAJ' ]
                  i := 0
                  AEval( aBufDok[ 'pozycje' ], { | aPoz |
                     i := i + 1
                     ztowar[ i ] := aPoz[ 'TOWAR' ]
                     zilosc[ i ] := aPoz[ 'ILOSC' ]
                     zjm[ i ] := aPoz[ 'JM' ]
                     zcena[ i ] := aPoz[ 'CENA' ]
                     zwartosc[ i ] := aPoz[ 'WARTOSC' ]
                  } )
            //-----kontrola wartosci faktury-----
            razem := 0
            FOR i := 1 TO 15
                razem := razem + zwartosc[ i ]
            NEXT
            zdzien := Str( Val( zdzien ), 2 )
            znazwa := znazwa
            //ננננננננננננננננננננננננננננננננ REPL נננננננננננננננננננננננננננננננננ
            SELECT firma
            BlokadaR()
            repl_( 'nr_rach', nr_rach + 1 )
            COMMIT
            UNLOCK
            SELECT faktury
               BlokadA()
               SET ORDER TO 4
               GO BOTTOM
               z_rec_no := rec_no + 1
               SET ORDER TO 2
               app()
               repl_( 'rec_no', z_rec_no )
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
            repl_( 'rach', zrach )
            repl_( 'kraj', zkraj )
            COMMIT
            UNLOCK
            zident_poz := Str( rec_no, 8 )
            SELECT pozycje
            SEEK '+' + zident_poz
            razem := 0
            FOR i := 1 TO 15
               IF ! Empty( ztowar[ i ] )
                 razem := razem + zwartosc[ i ]
                     app()
                     repl_( 'ident', zident_poz )
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

            Faktury3_Ksieguj()

            SELECT faktury

         } )
               ColStd()
               @ 24, 0

            IF &_top_bot
               EXIT
            ELSE
               DO &_proc
            ENDIF
            ENDIF
            ELSE
               Komun( "Brak dokument¢w w buforze" )
            ENDIF

      CASE kl == Asc( 'O' ) .OR. kl == Asc( 'o' )
         Faktury3_Odbiorca()

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
   @  1,  8 SAY SubStr( nr_ident, 1, 14 )
   @  1, 31 SAY SubStr( nazwa, 1, 49 )
   @  2,  6 SAY SubStr( adres, 1, 64 )
   @  2, 77 SAY kraj
   @  0, 70 SAY iif( odbjest == 'T', 'ODBIORCA', '        ' )
   SET COLOR TO
   *@ 1,47 say repl([.],32)
   //@  2, 76 SAY '....'
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
         IF LastKey() == 13 .OR. LastKey() == 1006
            KontrahAktualizuj()
            znazwa := kontr->nazwa
            zadres := kontr->adres
            znr_ident := kontr->nr_ident
            zkraj := kontr->kraj
            SET COLOR TO i
            @  1,  8 SAY SubStr( nr_ident, 1, 14 )
            @  1, 31 SAY SubStr( nazwa, 1, 49 )
            @  2,  6 SAY SubStr( adres, 1, 64 )
            @  2, 77 SAY kraj
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
            IF LastKey() == 13 .OR. LastKey() == 1006
               KontrahAktualizuj()
               znazwa := nazwa
               zadres := adres
               znr_ident := nr_ident
               zkraj := kraj
               SET COLOR TO i
               @  1,  8 SAY SubStr( nr_ident, 1, 14 )
               @  1, 31 SAY SubStr( nazwa, 1, 49 )
               @  2,  6 SAY SubStr( adres, 1, 64 )
               @  2, 77 SAY kraj
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
         IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
            cTresc := tresc->tresc
            zTowar[ nWiersz ] := cTresc
         ENDIF
         SELECT faktury
      ENDIF
   ENDIF
   SET CONFIRM OFF
   RETURN .T.


   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Faktury3_DrukGraf()

   LOCAL aDane := {=>}, aPoz, aSuma, nIdx, nWartosc := 0
   LOCAL cFakturyId := Str( faktury->rec_no, 8 )

   aDane[ 'nr_dok' ] := 'S-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' ) + '/' + param_rok
   aDane[ 'data_dok' ] := hb_Date( Val( param_rok ), Val( faktury->mc ), Val( faktury->dzien ) )
   aDane[ 'k_nazwa' ] := AllTrim( faktury->nazwa )
   aDane[ 'k_adres' ] := AllTrim( faktury->adres )
   aDane[ 'k_nip' ] := AllTrim( faktury->nr_ident )
   aDane[ 'k_kraj' ] := AllTrim( faktury->kraj )
   aDane[ 'f_nazwa' ] := AllTrim( firma->nazwa )
   aDane[ 'f_kod_poczt' ] := AllTrim( firma->kod_p )
   aDane[ 'f_miejscowosc' ] := AllTrim( firma->miejsc )
   aDane[ 'f_ulica' ] := AllTrim( firma->ulica )
   aDane[ 'f_nr_domu' ] := AllTrim( firma->nr_domu )
   aDane[ 'f_nr_lokalu' ] := AllTrim( firma->nr_mieszk )
   aDane[ 'f_nip' ] := AllTrim( iif( faktury->ue == 'T', firma->nipue, firma->nip ) )
   aDane[ 'f_tel' ] := AllTrim( firma->tel )
   aDane[ 'f_fax' ] := AllTrim( firma->fax )
   aDane[ 'f_regon' ] := AllTrim( SubStr( firma->nr_regon, 1, 11 ) )
   aDane[ 'f_nr_konta' ] := AllTrim( firma->nr_konta )
   aDane[ 'f_bank' ] := AllTrim( firma->bank )
   aDane[ 'odebral' ] := AllTrim( faktury->odbosoba )
   aDane[ 'uwagi' ] := AllTrim( faktury->komentarz )
   aDane[ 'zamowienie' ] := AllTrim( faktury->zamowienie )
   aDane[ 'rach' ] := faktury->rach
   aDane[ 'rodzaj' ] := iif( faktury->rach == 'R', 'RACHUNEK', 'FAKTURA' )
   aDane[ 'typ_faktury' ] := AllTrim( faktury->fakttyp )
   IF faktury->odbjest == 'T'
      aDane[ 'odbiorca' ] := 1
      aDane[ 'o_nazwa' ] := AllTrim( faktury->odbnazwa )
      aDane[ 'o_adres' ] := AllTrim( faktury->odbadres )
      aDane[ 'o_nip' ] := AllTrim( faktury->odnr_ident )
      aDane[ 'o_kraj' ] := AllTrim( faktury->odbkraj )
   ELSE
      aDane[ 'odbiorca' ] := 0
      aDane[ 'o_nazwa' ] := ""
      aDane[ 'o_adres' ] := ""
      aDane[ 'o_nip' ] := ""
      aDane[ 'o_kraj' ] := ""
   ENDIF

   aDane[ 'naglowki' ] := {}
   AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Sprzedawca', 'dane' => aDane[ 'f_nazwa' ] + hb_eol() + ;
      aDane[ 'f_kod_poczt' ] + ' ' + aDane[ 'f_miejscowosc' ] + ', ' + aDane[ 'f_ulica' ] + ' ' + ;
      aDane[ 'f_nr_domu' ] + '/' + aDane[ 'f_nr_lokalu' ] + hb_eol() + 'NIP: ' + aDane[ 'f_nip' ] } )
   AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Nabywca', 'dane' => aDane[ 'k_nazwa' ] + hb_eol() + ;
      aDane[ 'k_adres' ] + hb_eol() + 'NIP: ' + aDane[ 'k_nip' ] } )
   IF faktury->odbjest == 'T'
      AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Odbiorca', 'dane' => aDane[ 'o_nazwa' ] + hb_eol() + ;
         aDane[ 'o_adres' ] + hb_eol() + 'NIP: ' + aDane[ 'o_nip' ] } )
   ENDIF


   aDane[ 'pozycje' ] := {}
   pozycje->( dbSeek( '+' + cFakturyId ) )
   DO WHILE pozycje->del == '+' .AND. pozycje->ident == cFakturyId
      IF pozycje->wartosc == 0 .AND. Len( aDane[ 'pozycje' ] ) > 0
         aPoz := ATail( aDane[ 'pozycje' ] )
         aPoz[ 'towar' ] := aPoz[ 'towar' ] + hb_eol() + AllTrim( pozycje->towar )
      ELSE
         aPoz := {=>}
         aPoz[ 'wartosc' ] := pozycje->wartosc
         aPoz[ 'towar' ] := AllTrim( pozycje->towar )
         aPoz[ 'ilosc' ] := pozycje->ilosc
         aPoz[ 'jm' ] := AllTrim( pozycje->jm )
         aPoz[ 'cena' ] := pozycje->cena
         nWartosc := nWartosc + aPoz[ 'wartosc' ]
         AAdd( aDane[ 'pozycje' ], aPoz )
      ENDIF
      pozycje->( dbSkip() )
   ENDDO

   aDane[ 'wartosc' ] := nWartosc
   aDane[ 'slownie' ] := slownie( nWartosc )
   aDane[ 'sposob_p' ] := faktury->sposob_p
   aDane[ 'termin_z' ] := faktury->termin_z
   aDane[ 'zaplacono' ] := faktury->kwota
   aDane[ 'do_zaplaty' ] := nWartosc - faktury->kwota

   aDane[ 'wystawil' ] := AllTrim( ewid_wyst )

   DO CASE
   CASE faktury->sposob_p == 1
      aDane[ 'zaplata' ] := 'Pˆatne przelewem w ci¥gu ' + Str( faktury->termin_z, 2 ) ;
         + ' dni na konto ' + iif( SubStr( firma->nr_konta, 1, 2 ) == '  ', ;
         SubStr( firma-> nr_konta, 4 ), firma->nr_konta ) + hb_eol() + firma->bank
      IF faktury->kwota > 0
         aDane[ 'zaplata' ] := 'Zapˆacono ' + LTrim( kwota( faktury->kwota, 13, 2 ) ) + '            Pozostaˆo do zapˆaty ' + LTrim( kwota( nWartosc - faktury->kwota, 13, 2 ) ) +  hb_eol() + aDane[ 'zaplata' ]
      ENDIF
   CASE faktury->sposob_p == 2
      IF faktury->termin_z == 0
         aDane[ 'zaplata' ] := 'Zapˆacono got¢wk¥'
      ELSE
         IF faktury->kwota == 0
            aDane[ 'zaplata' ] := 'Pˆatne got¢wk¥ w ci¥gu ' + Str( faktury->termin_z, 2 ) + ' dni'
         ELSE
            aDane[ 'zaplata' ] := 'Zapˆacono got¢wk¥ ' + LTrim( kwota( faktury->kwota, 13, 2 ) ) + hb_eol() ;
               + 'Do zapˆaty ' + LTrim( kwota( nWartosc - faktury->kwota, 13, 2 ) ) + ' w terminie ' + Str( faktury->termin_z, 2 ) + ' dni'
         ENDIF
      ENDIF
   CASE faktury->sposob_p == 3
      aDane[ 'zaplata' ] := 'Zapˆacono czekiem'
   OTHERWISE
      aDane[ 'zaplata' ] := ''
   ENDCASE

   FRDrukuj( 'frf\fr.frf', aDane )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Faktury3_Ksieguj()

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
               repl_( 'kraj', zkraj )
               repl_( 'nr_ident', znr_ident )
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

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Faktury3_KonValidNIP()

   LOCAL aDane := hb_Hash()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   IF Len( AllTrim( znr_ident ) ) > 0 .OR. znr_ident # faktury->nr_ident
      IF  KontrahZnajdz( znr_ident, @aDane )
         znazwa := Pad( aDane[ 'nazwa' ], 200 )
         zadres := Pad( aDane[ 'adres' ], 200 )
         zkraj := aDane[ 'kraj' ]
         KEYBOARD Chr( K_ENTER )
      ELSE
         znazwa := Space( 200 )
         zadres := Space( 200 )
         ZKRAJ := 'PL'
         SET COLOR TO i
         @  1,  8 SAY SubStr( znr_ident, 1, 14 )
         @  1, 31 SAY SubStr( znazwa, 1, 49 )
         @  2,  6 SAY SubStr( zadres, 1, 64 )
         @  2, 77 SAY zkraj
         SET COLOR TO
      ENDIF
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

PROCEDURE Faktury3_Odbiorca()

   LOCAL cEkran, cKolor
   PUBLIC zODBJEST, zODNR_IDENT, zODBNAZWA, zODBADRES, zODBKRAJ

   zODBJEST := iif( ! ODBJEST$'TN', 'N', ODBJEST )
   zODNR_IDENT := ODNR_IDENT
   zODBNAZWA := ODBNAZWA
   zODBADRES := ODBADRES
   zODBKRAJ := ODBKRAJ

   cEkran := SaveScreen()
   cKolor := ColStd()

   @  6, 3 CLEAR TO 12, 76
   @  6, 3 TO 12, 76
   @  6, 40 SAY " ODBIORCA "
   @  7, 5 SAY "Odbiorca na fakturze: "
   @  8, 5 SAY "  NIP: "
   @  9, 5 SAY "Nazwa: "
   @ 10, 5 SAY "Adres: "
   @ 11, 5 SAY " Kraj: "

   ValidTakNie( zODBJEST, 7, 28 )

   @  7, 27 GET zODBJEST    PICTURE "!" VALID ValidTakNie( zODBJEST, 7, 28 )
   @  8, 12 GET zODNR_IDENT PICTURE repl( '!', 30 ) WHEN zODBJEST == 'T' VALID Faktury3_OdbValidNIP()
   @  9, 12 GET zODBNAZWA   PICTURE "@S63 " + repl( '!', 200 ) WHEN zODBJEST == 'T' .AND. Faktury3_OdbWhenNazwa()
   @ 10, 12 GET zODBADRES   PICTURE "@S63 " + repl( '!', 200 ) WHEN zODBJEST == 'T'
   @ 11, 12 GET zODBKRAJ    PICTURE "!!" WHEN zODBJEST == 'T'

   read_()

   IF LastKey() <> K_ESC
      BlokadaR()
      repl_( 'ODBJEST', zODBJEST )
      repl_( 'ODNR_IDENT', zODNR_IDENT )
      repl_( 'ODBNAZWA', zODBNAZWA )
      repl_( 'ODBADRES', zODBADRES )
      repl_( 'ODBKRAJ', zODBKRAJ )

      COMMIT
      unlock
   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   DO &_proc

   RETURN NIL
*/
/*----------------------------------------------------------------------*/

FUNCTION Faktury3_OdbValidNIP()

   LOCAL aDane := hb_Hash()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   IF Len( AllTrim( zodnr_ident ) ) > 0 .OR. zodnr_ident # faktury->odnr_ident
      IF  KontrahZnajdz( zodnr_ident, @aDane )
         zodbnazwa := Pad( aDane[ 'nazwa' ], 200 )
         zodbadres := Pad( aDane[ 'adres' ], 200 )
         zodbkraj := aDane[ 'kraj' ]
         KEYBOARD Chr( K_ENTER )
      ELSE
         zodbnazwa := Space( 200 )
         zodbadres := Space( 200 )
         ZODBKRAJ := 'PL'
         SET COLOR TO i
         @  8, 12 SAY SubStr( zODNR_IDENT, 1, 14 )
         @  9, 12 SAY SubStr( zodbnazwa, 1, 30 )
         @ 10, 12 SAY SubStr( zodbadres, 1, 30 )
         @ 11, 12 SAY zODBKRAJ
         SET COLOR TO
      ENDIF
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION Faktury3_OdbWhenNazwa()

   SAVE SCREEN TO scr2
   IF Len( AllTrim( zodnr_ident ) ) # 0
      SELECT kontr
      SET ORDER TO 2
      SEEK '+' + ident_fir + zodnr_ident
      IF ! Found()
         SET ORDER TO 1
         SEEK '+' + ident_fir + SubStr( zodbnazwa, 1, 15 ) + SubStr( zodbadres, 1, 15 )
         IF del # '+' .OR. firma # ident_fir
            SKIP -1
         ENDIF
      ENDIF
      SET ORDER TO 1
   ELSE
      SELECT kontr
      SEEK '+' + ident_fir + SubStr( zodbnazwa, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
      ENDIF
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kontr_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         KontrahAktualizuj()
         zodbnazwa := nazwa
         zodbadres := adres
         zODNR_IDENT := NR_IDENT
         ZODBKRAJ := KRAJ
         SET COLOR TO i
         @  8, 12 SAY SubStr( zODNR_IDENT, 1, 14 )
         @  9, 12 SAY SubStr( zodbnazwa, 1, 30 )
         @ 10, 12 SAY SubStr( zodbadres, 1, 30 )
         @ 11, 12 SAY zODBKRAJ
         SET COLOR TO
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT faktury
   RETURN .T.

/*----------------------------------------------------------------------*/
