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

#include "Inkey.ch"
#include "ami_book.ch"

PROCEDURE FakturyV()

   * do 99 999 faktur w sumie na wszystkie firmy
   SAVE SCREEN TO scr_1
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±Obsluga podstawowych operacji na bazie ......                             ±
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, _stop, ;
      _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou, _top_bot
   *********************** lp
   m->liczba := 1
   LpStart()

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )

   @  1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3,  0 SAY '                Nr       z dnia     data sprz..           data zalicz.          '
   @  4,  0 SAY 'NABYWCA: Nr ident.(NIP).                                                 Exp:   '
   @  5,  0 SAY '         Nazwa..........                                                  UE:   '
   @  6,  0 SAY '         Adres..........                                                Kraj:   '
   @  7,  0 SAY 'UWAGI....                                         Zlecenie.                     '
   @  8,  0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄ¿'
   @  9,  0 SAY '³    Nazwa towaru/us&_l.ugi      ³PKW/PKOB³  Ilo&_s.&_c.  ³ JM  ³Cena nett³Wart.netto³VA³'
   @ 10,  0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄ´'
   @ 11,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 12,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 13,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 14,  0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÂÄÄÄÄÁÄÄÄÄÄÅÄÄÂÄÄÄÄÄÄÁÄÄÂÄÄÄÄÄÄÄÁÄÄ´'
   @ 15,  0 SAY '                                            ³          ³' + Str( vat_A, 2 ) + '³         ³          ³'
   @ 16,  0 SAY 'ODBIORCA:                                   ³          ³' + Str( vat_B, 2 ) + '³         ³          ³'
   @ 17,  0 SAY 'Nazwa.                                      ³          ³' + Str( vat_C, 2 ) + '³         ³          ³'
   @ 18,  0 SAY 'Adres.                                      ³          ³' + Str( vat_D, 2 ) + '³         ³          ³'
   @ 19,  0 SAY 'Osoba.                                      ³          ³ 0³         ³          ³'
   @ 20,  0 SAY '                                            ³          ³ZW³         ³          ³'
   @ 21,  0 SAY '                                            ³          ³  ³         ³          ³'
   @ 22,  0 SAY '                                       RAZEMÀÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ'
   IF NR_UZYTK == 800
      @ 20,  0 SAY 'Opl.skarb.'
      @ 21,  0 SAY 'Od darowiz.'
      @ 21, 22 SAY 'Od czynnos.'
   ENDIF

   *############################### OTWARCIE BAZ ###############################
   SELECT 8
   IF Dostep( 'TRESC' )
      SET INDEX TO tresc
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

   IF zRYCZALT == 'T'
      USEBAZ := 'EWID'
   ELSE
      USEBAZ := 'OPER'
   ENDIF
   SELECT 7
   IF Dostep( USEBAZ )
      SetInd( USEBAZ )
      SET ORDER TO 3
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
   IF Dostep('FIRMA')
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
   IF Dostep( 'REJS' )
      SET INDEX TO rejs2, rejs, rejs1, rejs3, rejs4
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

   SELECT 1
   IF Dostep( 'POZYCJE' )
      SetInd( 'POZYCJE' )
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'FAKTURY' )
      SetInd( 'FAKTURY' )
      SET ORDER TO 2
      SEEK '+' + ident_fir + miesiac
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

   IF ZamSum()
      RETURN
   ENDIF

   DO CASE
   CASE miesiac == ' 1' .OR. miesiac == ' 3' .OR. miesiac == ' 5' .OR. miesiac == ' 7' .OR. miesiac == ' 8' .OR. miesiac == '10' .OR. miesiac == '12'
      DAYM := '31'
   CASE miesiac == ' 4' .OR. miesiac == ' 6' .OR. miesiac == ' 9' .OR. miesiac == '11'
      DAYM := '30'
   CASE miesiac == ' 2'
      DAYM := '29'
      IF Day( CToD( param_rok + '.' + miesiac + '.' + DAYM ) ) == 0
         DAYM := '28'
      ENDIF
   ENDCASE
   *################################# OPERACJE #################################
   *----- parametry ------
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,13'
   _top := 'firma#ident_fir.or.mc#miesiac'
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + mc
   _sbot := '+' + ident_fir + mc + 'þ'
   _proc := 'say260v'
   *----------------------
   _top_bot := _top + '.or.' + _bot
   IF ! &_top_bot
      DO &_proc
   ENDIF
   kl := 0
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      Ster()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot
         @ 1, 47 SAY '          '
         ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
         KtorOper()
         BEGIN SEQUENCE
            *-------zamek-------
            IF suma_mc->zamek
               kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
               BREAK
            ENDIF
            *-------------------
            IF ins .AND. Month( Date() ) # Val( miesiac ) .AND. del == '+' .AND. firma == ident_fir .AND. mc == miesiac
               IF ! TNEsc( '*u', ' Jest ' + Upper( RTrim( miesiac( Month( Date() ) ) ) ) + ' - jeste&_s. pewny? (T/N) ' )
                  BREAK
               ENDIF
            ENDIF
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               @  4, 78 CLEAR TO 5, 79
               @ 11,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
               @ 12,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
               @ 13,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
               @ 16, 45 CLEAR TO 21, 54
               @ 16, 59 CLEAR TO 21, 67
               @ 16, 69 CLEAR TO 21, 78
               zrach := 'F'
               zNUMERF := firma->nr_fakt
               zDZIEN := Str( Day( Date() ), 2 )
               zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
               zdataz := CToD( '    .  .  ' )
               znazwa := Space( 100 )
               zADRES := Space( 100 )
               znr_ident := Space( 30 )
               zsposob_pp := 2
               ztermin_z := 0
               zkwota := 0
               zKOMENTARZ := Space( 60 )
               zzamowienie := Space( 30 )
               zexport := 'N'
               zkraj := 'PL'
               zUE := 'N'
            ELSE
               zRACH := RACH
               zNUMER&zRACH := NUMER
               zDZIEN := DZIEN
               zDATAS := DATAS
               zDATAZ := DATAZ
               znazwa := nazwa
               zADRES := ADRES
               zNR_IDENT := NR_IDENT
               zsposob_pp := sposob_p
               zkwota := kwota
               ztermin_z := termin_z
               zKOMENTARZ := KOMENTARZ
               zZAMOWIENIE := ZAMOWIENIE
               zident_poz := Str( rec_no, 8 )
 *             sele kontr
 *             seek '+'+ident_fir+substr(znazwa,1,15)+substr(zadres,1,15)
 *             if found()
 *                if eXport='T'
 *                   zexport='TAK'
 *                else
 *                   zexport='NIE'
 *                endif
 *                if UE='T'
 *                   zUE='TAK'
 *                else
 *                   zUE='NIE'
 *                endif
 *                zKRAJ=KRAJ
 *             else
 *                sele faktury
               zexport := export
               zUE := ue
               zKRAJ := KRAJ

 *             endif
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ 23,0
            SELECT faktury
            SET CURSOR ON
            @ 3,  0 SAY 'Faktura VAT'
            @ 3, 32 GET zDZIEN PICTURE "99" when v26_00v() VALID v26_10v()
            @ 3, 47 GET zDATAS PICTURE "@D" when w26_20v() VALID v26_20v()
            @ 3, 70 GET zDATAZ PICTURE "@D"
            @ 4, 24 GET zNR_IDENT PICTURE repl( '!', 30 ) VALID vv1_3f()
            @ 5, 24 GET znazwa PICTURE "@S46 " + repl( '!', 100 ) VALID w1_3f()
            @ 6, 24 GET zADRES PICTURE "@S40 " + repl( '!', 100 )
 *          if ins
            @ 4, 77 GET zexport PICTURE '!' WHEN wfEXIM( 4, 78 ) VALID vfEXIM( 4, 78 )
            @ 5, 77 GET zUE PICTURE '!' WHEN wfUE( 5, 78 ) VALID vfUE( 5, 78 )
            @ 6, 77 GET zKRAJ PICTURE '!!'
 *          endif
            @ 7,  9 GET zKOMENTARZ PICTURE "@S38" + repl( '!', 60 )
            @ 7, 59 GET zZAMOWIENIE PICTURE "@S20" + repl( '!', 30 )
            wiersz := 1
            CLEAR TYPEAHEAD
            read_()
            SET CONFIRM OFF
            IF LastKey() == K_ESC
               BREAK
            ENDIF

            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð

            KontrApp()
            SELECT firma
            IF ins
               BlokadaR()
               repl_( 'nr_fakt', nr_fakt + 1 )
               UNLOCK
            ENDIF

            SELECT faktury
            IF ins
               Blokada()
               SET ORDER TO 4
               GO BOTTOM
               z_rec_no := rec_no + 1
               SET ORDER TO 2
               app()
               repl_( 'rec_no', z_rec_no )
            ENDIF
            BlokadaR()
            zdzien := Str( Val( zdzien ), 2 )
            repl_( 'firma', ident_fir )
            repl_( 'mc', miesiac )
            repl_( 'RACH', zRACH )
            repl_( 'NUMER', zNUMER&zRACH )
            repl_( 'DZIEN', zDZIEN )
            repl_( 'DATAS', zDATAS )
            repl_( 'DATAZ', zDATAZ )
            repl_( 'nazwa', znazwa )
            repl_( 'ADRES', zADRES )
            repl_( 'NR_IDENT', zNR_IDENT )
            repl_( 'KOMENTARZ', zKOMENTARZ )
            repl_( 'ZAMOWIENIE', zZAMOWIENIE )
            repl_( 'EXPORT', zEXPORT )
            repl_( 'UE', zUE )
            repl_( 'KRAJ', zKRAJ )
            UNLOCK
            zident_poz := Str( rec_no, 8 )

            FaPoz()
            SELECT faktury

            *-----------------------------------
            @ 23, 0
            DO WHILE LastKey() # K_ENTER
               @ 23,  9 PROMPT '[P&_l.atne przelewem]'
               @ 23, 33 PROMPT '[P&_l.atne got&_o.wk&_a.]'
               @ 23, 55 PROMPT '[P&_l.atne czekiem]'
               zsposob_p := menu( zsposob_pp )
            ENDDO
            @ 23,0
            SET COLOR TO +w
            DO CASE
            CASE zsposob_p == 1
               IF ins
                  ztermin_z := 0
               ENDIF
               zkwota := 0
               jeszcze := .T.
               DO WHILE jeszcze
                  @ 23, 24 SAY 'P&_l.atne przelewem w ci&_a.gu    dni'
                  @ 23, 49 GET ztermin_z PICTURE '99' RANGE 1, 99
                  read_()
                  IF LastKey() == K_ESC
                     jeszcze := .T.
                  ELSE
                     jeszcze := .F.
                  ENDIF
               ENDDO
            CASE zsposob_p == 2
               jeszcze := .T.
               DO WHILE jeszcze
                  @ 23, 15 SAY 'P&_l.atne w terminie    dni,'
                  @ 23, 33 GET ztermin_z PICTURE '99' VALID v26_100v()
                  @ 23, 41 SAY 'zap&_l.acono' GET zkwota PICTURE '   99999999.99' RANGE 0, 99999999999
                  read_()
                IF LastKey() == K_ESC
                     jeszcze := .T.
                  ELSE
                     jeszcze := .F.
                  ENDIF
               ENDDO
            CASE zsposob_p == 3
               @ 23, 25 SAY '       Zap&_l.acono czekiem       '
               zkwota := 0
            ENDCASE

            SELECT faktury
            BlokadaR()
            repl_( 'sposob_p', zsposob_p )
            repl_( 'termin_z', ztermin_z )
            repl_( 'kwota', zkwota )
            UNLOCK

            KVA := ' '
            IF nr_uzytk == 35 .OR. nr_uzytk == 376 .OR. nr_uzytk == 288
               @ 23, 0
               SET CURSOR ON
               SET CONFIRM ON
               jeszcze := .T.
               DO WHILE jeszcze
                  @ 23, 28 SAY 'Ksi&_e.gowa&_c. VAT (T/N) ?'
                  @ 23, 50 GET KVA PICTURE '!' VALID KVA $ 'TN'
                  READ
                  IF LastKey() == K_ESC
                     jeszcze := .T.
                  ELSE
                     jeszcze := .F.
                  ENDIF
               ENDDO
               SET CONFIRM OFF
               SET CURSOR OFF
               @ 23, 0
            ENDIF
            SET COLOR TO
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            SELECT pozycje
            SEEK '+' + zident_poz

            razem := 0
            zWARTZW := 0
            zWART08 := 0
            zWART00 := 0
            zWART07 := 0
            zWART02 := 0
            zWART22 := 0
            zWART12 := 0
            zVAT07 := 0
            zVAT02 := 0
            zVAT22 := 0
            zVAT12 := 0
            zSEK_CV7 := '  '
            DO WHILE del == '+' .AND. ident == zident_poz
               DO CASE
               CASE VAT == 'ZW'
                  zWARTZW := zWARTZW + WARTOSC
               CASE VAT == 'NP' .OR. VAT == 'PN'
                  zWART08 := zWART08 + WARTOSC
                  IF VAT == 'PN'
                     zSEK_CV7 := 'PN'
                  ENDIF
               CASE VAT == '0 '
                  zWART00 := zWART00 + WARTOSC
               CASE AllTrim( VAT ) == Str( vat_B, 1 )
                  zWART07 := zWART07 + WARTOSC
               CASE AllTrim( VAT ) == Str( vat_C, 1 )
                  zWART02 := zWART02 + WARTOSC
               CASE AllTrim( VAT ) == Str( vat_A, 2 )
                  zWART22 := zWART22 + WARTOSC
               CASE AllTrim( VAT ) == Str( vat_D, 1 )
                  zWART12 := zWART12 + WARTOSC
               ENDCASE
               SKIP
            ENDDO
            zVAT07 := _round( zWART07 * ( vat_B / 100 ), 2 )
            zVAT02 := _round( zWART02 * ( vat_C / 100 ), 2 )
            zVAT22 := _round( zWART22 * ( vat_A / 100 ), 2 )
            zVAT12 := _round( zWART12 * ( vat_D / 100 ), 2 )
            razem := zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12
            *========================= Ksiegowanie ========================
            SELECT rejs
            REC := RecNo()
            SET INDEX TO
            GO BOTTOM
            ILREK := RecNo()
            SET INDEX TO rejs2, rejs, rejs1, rejs3, rejs4
            GO REC
            IF ins
               app()
               repl_( 'firma', ident_fir)
               repl_( 'mc', miesiac)
               repl_( 'RACH', zRACH)
               repl_( 'numer', zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ) )
               repl_( 'tresc',  'Sprzedaz udokumentowana' )
               IF zRYCZALT == 'T'
                  repl_( 'KOLUMNA', ' 0' )
               ELSE
                  repl_( 'KOLUMNA', ' 7' )
               ENDIF
               repl_( 'KOREKTA', 'N' )
               repl_( 'UWAGI', Space( 20 ) )
               UNLOCK
               razem_ := 0
            ELSE
               SEEK '+' + ident_fir + miesiac + zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' )
               IF Found()
                  razem_ := netto
               ELSE
                  razem_ := 0
               ENDIF
            ENDIF
            BlokadaR()
            repl_( 'dzien', zdzien )
            repl_( 'nazwa', znazwa )
            repl_( 'adres', zadres )
            repl_( 'NR_IDENT', zNR_IDENT )
            repl_( 'EXPORT', zEXPORT )
            repl_( 'UE', zUE )
            repl_( 'KRAJ', zKRAJ )
            repl_( 'SEK_CV7', zSEK_CV7 )
            IF KVA <> 'N'
               repl_( 'WARTZW', zWARTZW )
               repl_( 'WART08', zWART08 )
               repl_( 'WART00', zWART00 )
               repl_( 'WART07', zWART07 )
               repl_( 'WART02', zWART02 )
               repl_( 'WART22', zWART22 )
               repl_( 'WART12', zWART12 )
               repl_( 'VAT07', zVAT07 )
               repl_( 'VAT02', zVAT02 )
               repl_( 'VAT22', zVAT22 )
               repl_( 'VAT12', zVAT12 )
            ELSE
               repl_( 'WARTZW', 0 )
               repl_( 'WART08', 0 )
               repl_( 'WART00', 0 )
               repl_( 'WART07', 0 )
               repl_( 'WART02', 0 )
               repl_( 'WART22', 0 )
               repl_( 'WART12', 0 )
               repl_( 'VAT07', 0 )
               repl_( 'VAT02', 0 )
               repl_( 'VAT22', 0 )
               repl_( 'VAT12', 0 )
            ENDIF
            IF zRYCZALT <> 'T'
              repl_( 'NETTO', razem )
            ENDIF
            repl_( 'ROKS', Str( Year( zDATAS ), 4 ) )
            repl_( 'MCS', Str( Month( zDATAS ), 2 ) )
            repl_( 'DZIENS', Str( Day( zDATAS ), 2 ) )
            IF zsposob_p == 1 .OR. zsposob_p == 3
               IF zsposob_p == 3 .AND. nr_uzytk == 6
                  repl_( 'zaplata',  '1' )
               ELSE
                  repl_( 'zaplata',  '3' )
               ENDIF
            ELSE
               IF ztermin_z == 0
                  repl_( 'zaplata',  '1' )
               ELSE
                  IF zkwota == 0
                     repl_( 'zaplata',  '3' )
                  ELSE
                     repl_( 'zaplata',  '2' )
                  ENDIF
               ENDIF
            ENDIF
            repl_( 'kwota', zkwota )
            UNLOCK
            IF zRYCZALT <> 'T'
               ************* ZAPIS REJESTRU DO KSIEGI *******************
               SELECT oper
               SET ORDER TO 3
               IF ! ins
                  SEEK '+' + ident_fir + miesiac + 'RS-7'
                  IF Found()
                     BlokadaR()
                     repl_( 'wyr_tow', wyr_tow - razem_ )
                     UNLOCK
                  ELSE
                     *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                     SELECT &USEBAZ
                     app()
                     ADDDOC
                     repl_( 'DZIEN', DAYM )
                     repl_( 'NUMER', 'RS-7' )
                     repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                     repl_( 'WYR_TOW', -razem_ )
                     repl_( 'zaplata', '1' )
 *                   repl_([kwota],zkwota)
                     UNLOCK
                     *********************** lp
                     SET ORDER TO 1
                     IF nr_uzytk >= 0
                        IF param_lp == 'T'
                           Blokada()
                           Czekaj()
                           rec := RecNo()

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

                           GO rec
                           UNLOCK
                        ENDIF
                     ENDIF
                     UNLOCK
                  ***********************
                  ENDIF
               ENDIF
               SET ORDER TO 3
               SEEK '+' + ident_fir + miesiac + 'RS-7'
               IF Found()
                  BlokadaR()
                  repl_( 'wyr_tow', wyr_tow + razem )
                  UNLOCK
                  SELECT suma_mc
                  BlokadaR()
                  repl_( 'wyr_tow', wyr_tow - razem_ )
                  repl_( 'wyr_tow', wyr_tow + razem )
                  UNLOCK
               ELSE
                  *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                  SELECT oper
                  app()
                  repl_( 'firma', ident_fir )
                  repl_( 'mc', miesiac )
                  repl_( 'DZIEN', DAYM )
                  repl_( 'NUMER', 'RS-7' )
                  repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                  repl_( 'WYR_TOW', RAZEM )
                  repl_( 'zaplata', '1' )
 *                repl_([kwota],zkwota)
                  UNLOCK
                  *********************** lp
                  SET ORDER TO 1
                  IF nr_uzytk >= 0
                     IF param_lp == 'T'
                        Blokada()
                        Czekaj()
                        rec := RecNo()

                        SKIP -1
                        IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                           zlp := liczba
                        ELSE
                           zlp := lp + 1
                        ENDIF
                        GO rec
                        DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc # miesiac, .F. )
                           repl_( 'lp', zlp )
                           zlp := zlp + 1
                           SKIP
                        ENDDO

                        GO rec
                        UNLOCK
                     ENDIF
                  ENDIF
                  UNLOCK
                  ***********************
                  SELECT suma_mc
                  BlokadaR()
                  repl_( 'wyr_tow', wyr_tow - razem_ )
                  repl_( 'wyr_tow', wyr_tow + razem )
                  repl_( 'pozycje', pozycje + 1 )
                  UNLOCK
               ENDIF
               ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
               SET ORDER TO 1
            ENDIF
            SELECT faktury
            commit_()
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
         END
         @ 23, 0
         IF &_top_bot
            EXIT
         ELSE
            DO &_proc
         ENDIF
         @ 23, 0
         @ 24, 0

*################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' )
         @ 1, 47 SAY '          '
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
            IF TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
               BREAK
            ENDIF
            zident_poz := Str( rec_no, 8 )
            *========================= Ksiegowanie ========================
            SELECT rejs
            SEEK '+' + ident_fir + miesiac + faktury->RACH + '-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' )
            IF Found()
               razem_ := netto
               BlokadaR()
               repl_( 'del', '-' )
               commit_()
               UNLOCK
               SKIP
               IF zRYCZALT <> 'T'
                  ************* ZAPIS REJESTRU DO KSIEGI *******************
                  SELECT oper
                  SET ORDER TO 3
                  SEEK '+' + ident_fir + miesiac + 'RS-7'
                  IF Found()
                     BlokadaR()
                     repl_( 'wyr_tow', wyr_tow - razem_ )
                     UNLOCK
                     SELECT suma_mc
                     BlokadaR()
                     repl_( 'wyr_tow', wyr_tow - razem_ )
                     UNLOCK
                  ELSE
                     *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                     SELECT &USEBAZ
                     app()
                     ADDDOC
                     repl_( 'DZIEN', DAYM )
                     repl_( 'NUMER', 'RS-7' )
                     repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                     repl_( 'WYR_TOW', -razem_ )
                     repl_( 'zaplata', '1' )
 *                   repl_([kwota],zkwota)
                     UNLOCK
                     *********************** lp
                     SET ORDER TO 1
                     IF nr_uzytk >= 0
                        IF param_lp == 'T'
                           Blokada()
                           Czekaj()
                           rec := RecNo()

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

                           GO rec
                           UNLOCK
                        ENDIF
                     ENDIF
                     SELECT suma_mc
                     BlokadaR()
                     repl_( 'wyr_tow', wyr_tow - razem_ )
                     repl_( 'pozycje', pozycje + 1 )
                     UNLOCK
                  ENDIF
                  ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
               ENDIF
            ENDIF
            *==============================================================
            IF faktury->numer == firma->nr_fakt - 1
               SELECT firma
               BlokadaR()
               repl_( 'nr_fakt', nr_fakt - 1 )
               UNLOCK
            ENDIF
            SELECT pozycje
            SEEK '+' + zident_poz
            DO WHILE del == '+' .AND. ident == zident_poz
               BlokadaR()
               Del()
               unlock
               SKIP
            ENDDO
            SELECT faktury
            BlokadaR()
            Del()
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
            IF ! &_bot
               DO &_proc
            ENDIF
         END
         @ 23, 0
         @ 24, 0

      *################################# SZUKANIE dnia#############################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         f10 := '  '
         ColStd()
         @ 3, 32 GET f10 PICTURE "99"
         read_()
         IF ! Empty( f10 ) .AND. LastKey() # K_ESC
            SEEK '+' + ident_fir + miesiac + Str( Val( f10 ), 2 )
            IF &_bot
               skip -1
            ENDIF
         ENDIF
         DO &_proc
         @ 23, 0

      *################################# SZUKANIE numeru###########################
      CASE kl == K_F9
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         frach := 'F'
         fnum := 0
         ColStd()
         @ 3, 19 GET fnum PICTURE '99999'
         read_()
         IF ! Empty( frach ) .AND. LastKey() # K_ESC
            SET ORDER TO 1
            SEEK '+' + ident_fir + frach + Str( fnum, 5 )
            IF &_bot
               SKIP -1
            ENDIF
            SET ORDER TO 2
         ENDIF
         DO &_proc
         @ 23, 0

      *############################### WYDRUK FAKTURY #############################
      CASE kl == K_ENTER
         @ 1,47 say [          ]
         BEGIN SEQUENCE
            IF NR_UZYTK == 800
               zoplskarb := oplskarb
               zpoddarow := poddarow
               zpodcywil := podcywil
            ENDIF
            zodbnazwa := iif( Empty( odbnazwa ), nazwa, odbnazwa )
            zodbadres := iif( Empty( odbadres ), adres, odbadres )
            zodbosoba := iif( Empty( odbosoba ), Space( 30 ), odbosoba )
            SET CURSOR ON
            @ 17, 6 GET zodbnazwa PICTURE '@S30 ' + repl( '!', 70 )
            @ 18, 6 GET zodbADRES PICTURE '@S30 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
            @ 19, 6 GET zodbosoba PICTURE '!' + repl( 'X', 29 )
            IF NR_UZYTK == 800
               @ 20, 11 GET zoplskarb PICTURE '999999.99'
               @ 21, 11 GET zpoddarow PICTURE '999999.99'
               @ 21, 33 GET zpodcywil PICTURE '999999.99'
            ENDIF
            READ
            SET CURSOR OFF
            IF LastKey() <> K_ESC
               BlokadaR()
               REPLACE odbnazwa WITH zodbnazwa, odbadres WITH zodbadres, odbosoba WITH zodbosoba
               IF NR_UZYTK == 800
                  REPLACE oplskarb WITH zoplskarb, poddarow WITH zpoddarow, podcywil WITH zpodcywil
               ENDIF
               UNLOCK
               SET COLOR TO w+
               @ 17, 6 SAY SubStr( ODBNAZWA, 1, 30 )
               @ 18, 6 SAY SubStr( ODBADRES, 1, 30 )
               @ 19, 6 SAY ODBOSOBA
               IF NR_UZYTK == 800
                  @ 20, 11 SAY zoplskarb PICTURE '999999.99'
                  @ 21, 11 SAY zpoddarow PICTURE '999999.99'
                  @ 21, 33 SAY zpodcywil PICTURE '999999.99'
               ENDIF
               SAVE SCREEN TO fff
               IF NR_UZYTK == 800
                  Fakt2Not()
               ELSE
                  Fakt2()
               ENDIF
               RESTORE SCREEN FROM fff
            ENDIF
            SELECT faktury
         END

      *################################### POMOC ##################################
      CASE kl == K_F1
         @ 1, 47 SAY '          '
         SAVE SCREEN TO scr_
         DECLARE p[ 11 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna faktura  '
         p[  3 ] := '   [Home/End]..............pierwsza/ostatnia faktura    '
         p[  4 ] := '   [Ins]...................wystawienie nowej faktury    '
         p[  5 ] := '   [M].....................modyfikacja faktury          '
         p[  6 ] := '   [Del]...................kasowanie faktury            '
         p[  7 ] := '   [F9]....................szukanie faktury/rachunku    '
         p[  8 ] := '   [F10]...................szukanie dnia                '
         p[  9 ] := '   [Enter].................wydruk faktury               '
         p[ 10 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 11 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 11
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               Center( j, p[ i ] )
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
         ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   RETURN

*################################## FUNKCJE #################################
PROCEDURE SAY260V()

   CLEAR TYPEAHEAD
   SELECT faktury
   zrach := rach
   *  set cent off
   SET COLOR TO +w
   @ 3,  0 SAY iif( RACH == 'F', 'Faktura VAT', 'Rachunek   ' )
   @ 3, 19 SAY StrTran( Str( NUMER, 5 ), ' ', '0' )
   @ 3, 32 SAY DZIEN
   @ 3, 47 SAY DATAS

   sprawdzVAT( 10, DATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   @ 3, 70 SAY DATAZ
   @ 4, 24 SAY nr_ident
   @ 5, 24 SAY SubStr( nazwa, 1, 46 )
   @ 6, 24 SAY SubStr( adres, 1, 40 )
   @ 4, 77 SAY EXPORT + iif( EXPORT == 'T', 'ak', 'ie' )
   @ 5, 77 SAY UE + iif( UE == 'T', 'ak', 'ie' )
   @ 6, 77 SAY KRAJ
   //003 nowa linia
   @  7,  9 SAY SubStr( KOMENTARZ, 1, 38 )
   @  7, 59 SAY SubStr( ZAMOWIENIE, 1, 20 )
   @ 17,  6 SAY SubStr( ODBNAZWA, 1, 30 )
   @ 18,  6 SAY SubStr( ODBADRES, 1, 30 )
   @ 19,  6 SAY ODBOSOBA
   IF NR_UZYTK == 800
      @ 20, 11 SAY oplskarb PICTURE '999999.99'
      @ 21, 11 SAY poddarow PICTURE '999999.99'
      @ 21, 33 SAY podcywil PICTURE '999999.99'
   ENDIF
   @ 22, 0 SAY Space( 44 )
   DO CASE
   CASE sposob_p == 1
      @ 22, 0 SAY 'P&_l.atne przelewem w ci&_a.gu ' + Str( termin_z, 2 ) + ' dni'
   CASE sposob_p == 2
      IF termin_z == 0
         @ 22, 0 SAY 'Zap&_l.acono got&_o.wk&_a.'
      ELSE
         IF kwota == 0
            @ 22, 0 SAY 'P&_l.atne got&_o.wk&_a. w terminie ' + Str( termin_z, 2 ) + ' dni'
         ELSE
            @ 22, 0 SAY 'Zap&_l.acono ' + Str( kwota, 8, 2 ) + ', reszta w terminie ' + Str( termin_z, 2 ) + ' dni'
         ENDIF
      ENDIF
   CASE sposob_p == 3
      @ 22, 0 SAY 'Zap&_l.acono czekiem'
   ENDCASE
   zident_poz := Str( rec_no, 8 )
   SELECT pozycje
   SEEK '+' + zident_poz
   razem := 0
   i := 0
   zWARTZW := 0
   zWART08 := 0
   zWART00 := 0
   zWART07 := 0
   zWART02 := 0
   zWART22 := 0
   zWART12 := 0
   zVAT07 := 0
   zVAT02 := 0
   zVAT22 := 0
   zVAT12 := 0
   ColStd()
   @ 11, 0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 12, 0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 13, 0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   SET COLOR TO +w
   DO WHILE del == '+' .AND. ident == zident_poz
      IF i < 3
         i := i + 1
         @ 10 + i, 1 SAY Left( towar, 29 )
         IF ilosc * 1000 == 0
            @ 10 + i, 31 SAY Space( 8 )
            @ 10 + i, 40 SAY Space( 8 )
            @ 10 + i, 50 SAY Space( 5 )
            @ 10 + i, 56 SAY Space( 9 )
         ELSE
            IF nr_uzytk == 204
               zil := Str( ilosc, 9, 2 )
            ELSE
               zil := Str( ilosc, 9, 3 )
            ENDIF
            @ 10 + i, 31 SAY SubStr( SWW, 1, 8 )
            @ 10 + i, 40 SAY zil
            @ 10 + i, 50 SAY JM
            @ 10 + i, 56 SAY CENA PICTURE "999999.99"
         ENDIF
         @ 10 + i, 66 SAY WARTOSC PICTURE "9999999.99"
         @ 10 + i, 77 SAY VAT PICTURE "!!"
      ENDIF
      DO CASE
      CASE VAT == 'ZW'
         zWARTZW := zWARTZW + WARTOSC
      CASE VAT == 'NP' .OR. VAT == 'PN'
         zWART08 := zWART08 + WARTOSC
      CASE VAT == '0 '
         zWART00 := zWART00 + WARTOSC
      CASE AllTrim( VAT ) == Str( vat_B, 1 )
         zWART07 := zWART07 + WARTOSC
      CASE AllTrim( VAT ) == Str( vat_C, 1 )
         zWART02 := zWART02 + WARTOSC
      CASE AllTrim( VAT ) == Str( vat_A, 2 )
         zWART22 := zWART22+WARTOSC
      CASE AllTrim( VAT ) == Str( vat_D, 1 )
         zWART12 := zWART12 + WARTOSC
      ENDCASE
      SKIP
   ENDDO
   zVAT07 := _round( zwart07 * ( vat_B / 100 ), 2 )
   zVAT02 := _round( zwart02 * ( vat_C / 100 ), 2 )
   zVAT22 := _round( zwart22 * ( vat_A / 100 ), 2 )
   zVAT12 := _round( zwart12 * ( vat_D / 100 ), 2 )
   SET COLOR TO +w
   @ 15, 45 SAY zWART22 PICTURE "@Z 999 999.99"
   @ 15, 59 SAY zVAT22 PICTURE "@Z 99 999.99"
   @ 15, 69 SAY zWART22 + zVAT22 PICTURE "@Z 999 999.99"
   @ 16, 45 SAY zWART07 PICTURE "@Z 999 999.99"
   @ 16, 59 SAY zVAT07 PICTURE "@Z 99 999.99"
   @ 16, 69 SAY zWART07 + zVAT07 PICTURE "@Z 999 999.99"
   @ 17, 45 SAY zWART02 PICTURE "@Z 999 999.99"
   @ 17, 59 SAY zVAT02 PICTURE "@Z 99 999.99"
   @ 17, 69 SAY zWART02 + zVAT02 PICTURE "@Z 999 999.99"
   @ 18, 45 SAY zWART12 PICTURE "@Z 999 999.99"
   @ 18, 59 SAY zVAT12 PICTURE "@Z 99 999.99"
   @ 18, 69 SAY zWART12 + zVAT12 PICTURE "@Z 999 999.99"
   @ 19, 45 SAY zWART00 PICTURE "@Z 999 999.99"
   @ 19, 59 SAY 0 PICTURE "@Z 99 999.99"
   @ 19, 69 SAY zWART00 PICTURE "@Z 999 999.99"
   @ 20, 45 SAY zWARTzw PICTURE "@Z 999 999.99"
   @ 20, 59 SAY 0 PICTURE "@Z 99 999.99"
   @ 20, 69 SAY zWARTzw PICTURE "@Z 999 999.99"
   @ 21, 45 SAY zWART08 PICTURE "@Z 999 999.99"
   @ 21, 59 SAY 0 PICTURE "@Z 99 999.99"
   @ 21, 69 SAY zWART08 PICTURE "@Z 999 999.99"
   *@ 21,45 say zWART12 picture "@Z 999 999.99"
   *@ 21,59 say zVAT12 picture "@Z 99 999.99"
   *@ 21,69 say zWART12+zVAT12 picture "@Z 999 999.99"
   SET COLOR TO w
   @ 22, 45 SAY zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 PICTURE "999 999.99"
   @ 22, 59 SAY zVAT07 + zVAT22 + zVAT02 + zVAT12 PICTURE "99 999.99"
   SET COLOR TO w+*
   @ 22, 69 SAY zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 + zVAT07 + zVAT22 + zVAT02 + zVAT12 PICTURE "999 999.99"
   SELECT faktury
   SET COLOR TO
   *  set cent on
   RETURN

***************************************************
FUNCTION v26_00v()

   R := .T.
   IF zRACH <> 'F' .AND. zRACH <> 'R'
      R := .F.
   ELSE
      SET COLOR TO +w
      @ 3, 19 SAY StrTran( Str( zNUMER&zRACH, 5 ), ' ', '0' )
      SET COLOR TO
   ENDIF
   RETURN R

***************************************************
FUNCTION v26_10v()

   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 3, 32 SAY zDZIEN
      SET COLOR TO
   ENDIF

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( zDZIEN, ' ', '0' ) ) )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   RETURN Val( zdzien ) >= 1 .AND. Val( zdzien ) <= msc( Val( miesiac ) )

***************************************************
FUNCTION v26_100v()

   IF ztermin_z < 0
      RETURN .F.
   ENDIF
   IF ztermin_z == 0
      zkwota := 0
      KEYBOARD Chr( K_ENTER )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w26_20v()

   IF zDATAS > CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
      zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v26_20v()

   sprawdzVAT( 10, zDATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   RETURN .T.

*############################################################################
FUNCTION Vv1_3f()
***************************************************
   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   IF Len( AllTrim( znr_ident ) ) # 0
      IF ins
         SELECT kontr
         SET ORDER TO 2
         SEEK '+' + ident_fir + znr_ident
         IF Found()
            znazwa := nazwa
            zadres := adres
            zexport := export
            zUE := UE
            zKRAJ := KRAJ
            KEYBOARD Chr( K_ENTER )
         ELSE
            znazwa := Space( 70 )
            zadres := Space( 40 )
            zexport := 'N'
            zUE := 'N'
            ZKRAJ := 'PL'
            SET COLOR TO i
            @ 4, 24 SAY zNR_IDENT
            @ 5, 24 SAY SubStr( znazwa, 1, 46 )
            @ 6, 24 SAY zadres
            @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
            @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
            @ 6, 77 SAY zKRAJ
            SET COLOR TO
         ENDIF
         SET ORDER TO 1
         SELECT faktury
      ELSE
         IF znr_ident # faktury->nr_ident
            SELECT kontr
            SET ORDER TO 2
            SEEK '+' + ident_fir + znr_ident
            IF Found()
               znazwa := nazwa
               zadres := adres
               zexport := export
               zUE := UE
               zKRAJ := KRAJ
               KEYBOARD Chr( K_ENTER )
            else
               znazwa := Space( 70 )
               zadres := Space( 40 )
               zexport := 'N'
               zUE := 'N'
               ZKRAJ := 'PL'
               SET COLOR TO i
               @ 4, 24 SAY zNR_IDENT
               @ 5, 24 SAY SubStr( znazwa, 1, 46 )
               @ 6, 24 SAY zadres
               @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
               @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
               @ 6, 77 SAY zKRAJ
               SET COLOR TO
            ENDIF
            SET ORDER TO 1
            SELECT faktury
         ENDIF
      ENDIF
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w1_3f()
***************************************************
   SAVE SCREEN TO scr2
   IF Len( AllTrim( znr_ident ) ) # 0
      SELECT kontr
      SET ORDER TO 2
      SEEK '+' + ident_fir + znr_ident
      IF ! Found()
         SET ORDER TO 1
         SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 ) + SubStr( zadres, 1, 15 )
         IF del # '+' .OR. firma # ident_fir
            SKIP -1
         ENDIF
      ENDIF
      SET ORDER TO 1
   ELSE
      SELECT kontr
      SEEK '+' + ident_fir + SubStr( znazwa, 1, 15 )
      IF del # '+' .OR. firma # ident_fir
         SKIP -1
      ENDIF
   ENDIF
   IF del == '+' .AND. firma == ident_fir
      Kontr_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER
         znazwa := nazwa
         zadres := adres
         zNR_IDENT := NR_IDENT
         zexport := export
         zUE := UE
         ZKRAJ := KRAJ
         SET COLOR to i
         @ 4, 24 SAY zNR_IDENT
         @ 5, 24 SAY SubStr( znazwa, 1, 46 )
         @ 6, 24 SAY zadres
         @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT faktury
   RETURN .T.
