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
#include "ami_book.ch"
* do 99 999 faktur w sumie na wszystkie firmy

PROCEDURE FakturyW()

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
   @  3,  0 SAY '                Nr       z dnia     data powst.obowiazku podatkowego..          '
   @  4,  0 SAY 'DOSTAWCA:Nr ident.(NIP).                                                 Exp:   '
   @  5,  0 SAY '         Nazwa..........                                                  UE:   '
   @  6,  0 SAY '         Adres..........                                                Kraj:   '
   @  7,  0 SAY 'Waluta:    Kurs:         z dn.           Tab:              Dotyczy:             '
   @  8,  0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂWÄwalucieÂWÄwalucieÄÂÄÄ¿'
   @  9,  0 SAY '³    Nazwa towaru/us&_l.ugi      ³PKW/PKOB³  Ilo&_s.&_c.  ³ JM  ³Cena nett³Wart.netto³VA³'
   @ 10,  0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄ´'
   @ 11,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 12,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 13,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
   @ 14,  0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÂÄÄÄÄÁÄÄÄÄÄÅÄÄÂÄÄÄÄÄÄÁÄÄÂÄÄÄÄÄÄÄÁÄÄ´'
   @ 15,  0 SAY '  Koszty zakupu w PLN                       ³          ³' + Str( vat_A, 2 ) + '³         ³          ³'
   @ 16,  0 SAY '1.Podatki....:                              ³          ³' + Str( vat_B, 2 ) + '³         ³          ³'
   @ 17,  0 SAY '2.Clo,oplaty.:                              ³          ³' + Str( vat_C, 2 ) + '³         ³          ³'
   @ 18,  0 SAY '3.Transport..:                              ³          ³' + Str( vat_D, 2 ) + '³         ³          ³'
   @ 19,  0 SAY '4.Prowizja...:                              ³          ³ 0³         ³          ³'
   @ 20,  0 SAY '5.Opakowanie.:                              ³          ³ZW³         ³          ³'
   @ 21,  0 SAY '6.Ubezpiecze.:            7.Inne.:          ³          ³  ³         ³          ³'
   @ 22,  0 SAY 'Jaka faktura.:                         RAZEMÀÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   SELECT 8
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

   SELECT 1
   IF Dostep( 'POZYCJEW' )
      SetInd( 'POZYCJEW' )
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'FAKTURYW' )
      SetInd( 'FAKTURYW' )
      SET ORDER TO 2
      SEEK '+' + ident_fir+miesiac
   ELSE
      SELECT 2
      close_()
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
   _proc := 'say260vw'
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
         CASE kl = K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot
            @ 1, 47 SAY '          '
            ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
            KtorOper()
            BEGIN SEQUENCE
               *-------zamek-------
               *-------------------
               kom( 5, '*u', ' UWAGA !!! faktury wewn&_e.trzne NIE S&__A. ksi&_e.gowane automatycznie !!! ' )
   *           if ins.and.month(date())#val(miesiac).and.del=[+].and.firma=ident_fir.and.mc=miesiac
   *              if .not.tnesc([*u],[ Jest ]+upper(rtrim(miesiac(month(date()))))+[ - jeste&_s. pewny? (T/N) ])
   *                 break
   *              endif
   *           endif
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               IF ins
                  @  4, 78 CLEAR TO 5, 79
                  @ 11,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
                  @ 12,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
                  @ 13,  0 SAY '³                             ³        ³         ³     ³         ³          ³  ³'
                  @ 16, 14 CLEAR TO 21, 23
                  @ 16, 34 CLEAR TO 21, 43
                  @ 22, 14 CLEAR TO 22, 36
                  zrach := 'F'
                  zNUMERF := firma->nr_faktw
                  zDZIEN := Str( Day( Date( ) ), 2 )
                  zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
                  zdataz := CToD( '    .  .  ' )
                  znazwa := Space( 200 )
                  zADRES := Space( 200 )
                  znr_ident := Space( 30 )
                  zsposob_pp := 2
                  ztermin_z := 0
                  zkwota := 0
                  zKOMENTARZ := 'Wyl.wg kursu waluty 0,0000 z dnia DD.MM.RRRR. Tabela kursowa' + Space( 20 )
                  zzamowienie := 'dokument dostawy nr' + Space( 21 )
                  zexport := 'N'
                  zkraj := 'PL'
                  zUE := 'N'
                  zWALUTA := 'EUR'
                  zKURS := 0.0
                  zTABELA := Space( 20 )
                  zKURSDATA := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
                  zPODATKI := 0
                  zCLO := 0
                  zTRANSPORT := 0
                  zPROWIZJA := 0
                  zOPAKOWAN := 0
                  zUBEZPIECZ := 0
                  zINNEKOSZ := 0
                  zOPISFAKT := PadR( 'Wewn&_a.trzwsp&_o.lnotowe nabycie towar&_o.w', 50 )
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
                  zexport := export
                  zUE := ue
                  zKRAJ := KRAJ
                  zWALUTA := WALUTA
                  zKURS := KURS
                  zTABELA := TABELA
                  zKURSDATA := KURSDATA
                  zPODATKI := PODATKI
                  zCLO := CLO
                  zTRANSPORT := TRANSPORT
                  zPROWIZJA := PROWIZJA
                  zOPAKOWAN := OPAKOWAN
                  zUBEZPIECZ := UBEZPIECZ
                  zINNEKOSZ := INNEKOSZ
                  zOPISFAKT := OPISFAKT
               ENDIF
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               @ 23, 0
               SELECT fakturyw
               SET CURSOR ON
               @ 3,  0 SAY 'Faktura Wew'
               @ 3, 32 GET zDZIEN PICTURE "99" WHEN v26_00vw() VALID v26_10vw()
               @ 3, 70 GET zDATAS PICTURE "@D" WHEN w26_20vw() VALID v26_20vw()
    *          @ 3, 70 GET zDATAZ picture "@D"
               @ 4, 24 GET zNR_IDENT picture repl( '!', 30 ) VALID vv1_3fw()
               @ 5, 24 GET znazwa PICTURE "@S46 " + repl( '!', 200 ) VALID w1_3fw()
               @ 6, 24 GET zADRES PICTURE "@S40 " + repl( '!', 200 )
    *          if ins
               @ 4, 77 GET zexport PICTURE '!' WHEN wfEXIM( 4, 78 ) VALID vfEXIM( 4, 78 )
               @ 5, 77 GET zUE PICTURE '!' WHEN wfUE( 5, 78 ) VALID vfUE( 5, 78 )
               @ 6, 77 GET zKRAJ PICTURe '!!'
    *          endif
    *          @ 7,9  GET ZKOMENTARZ picture "@S38"+repl('!',80)
               @ 7, 7  GET zWALUTA PICTURE "!!!"
               @ 7, 16 GET zKURS PICTURE "999.9999"
               @ 7, 30 GET zKURSDATA PICTURE "@D"
               @ 7, 45 GET zTABELA PICTURE "@S13" + repl( '!', 20 )
               @ 7, 67 GET zZAMOWIENIE PICTURE "@S13"+repl( 'X', 40 )
               wiersz := 1
               CLEAR TYPE
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
                  repl_( 'nr_faktw', nr_faktw + 1 )
                  COMMIT
                  UNLOCK
               ENDIF

               SELECT fakturyw
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
               repl_( 'WALUTA', zWALUTA )
               repl_( 'KURS', zKURS )
               repl_( 'TABELA', zTABELA )
               repl_( 'KURSDATA', zKURSDATA )
               COMMIT
               UNLOCK
               zident_poz := Str( rec_no, 8 )

               FaPozW()

               SELECT fakturyw
               @ 16, 14 GET zPODATKI   PICTURE "@Z 9999999.99"
               @ 17, 14 GET zCLO       PICTURE "@Z 9999999.99"
               @ 18, 14 GET zTRANSPORT PICTURE "@Z 9999999.99"
               @ 19, 14 GET zPROWIZJA  PICTURE "@Z 9999999.99"
               @ 20, 14 GET zOPAKOWAN  PICTURE "@Z 9999999.99"
               @ 21, 14 GET zUBEZPIECZ PICTURE "@Z 9999999.99"
               @ 21, 34 GET zINNEKOSZ  PICTURE "@Z 9999999.99"
               @ 22, 14 GET zOPISFAKT  PICTURE "@S23" + repl( 'X', 50 )
               read_()
               IF LastKey() == K_ENTER
                  BlokadaR()
                  repl_( 'podatki', zpodatki )
                  repl_( 'clo', zclo )
                  repl_( 'transport', ztransport )
                  repl_( 'prowizja', zprowizja )
                  repl_( 'opakowan', zopakowan )
                  repl_( 'ubezpiecz', zubezpiecz )
                  repl_( 'innekosz', zinnekosz )
                  repl_( 'OPISFAKT', zOPISFAKT )
                  COMMIT
                  UNLOCK
               ENDIF

              *-----------------------------------
   *           @ 23,0
   *           do while lastkey()#13
   *              @ 23, 9 prompt '[P&_l.atne przelewem]'
   *              @ 23,33 prompt '[P&_l.atne got&_o.wk&_a.]'
   *              @ 23,55 prompt '[P&_l.atne czekiem]'
   *              zsposob_p=menu(zsposob_pp)
   *           enddo
   *           @ 23,0
   *           set color to +w
   *           do case
   *           case zsposob_p=1
   *                if ins
   *                   ztermin_z=0
   *                endif
   *                zkwota=0
   *                jeszcze=.t.
   *                do while jeszcze
   *                   @ 23,24 say [P&_l.atne przelewem w ci&_a.gu    dni]
   *                   @ 23,49 get ztermin_z picture [99] range 1,99
   *                   read_()
   *                   if lastkey()=27
   *                      jeszcze=.t.
   *                   else
   *                      jeszcze=.f.
   *                   endif
   *                enddo
   *           case zsposob_p=2
   *                jeszcze=.t.
   *                do while jeszcze
   *                   @ 23,15 say [P&_l.atne w terminie    dni,]
   *                   @ 23,33 get ztermin_z picture [99] valid v26_100v()
   *                   @ 23,41 say [zap&_l.acono] get zkwota picture [   99999999.99] range 0,99999999999
   *                   read_()
   *                   if lastkey()=27
   *                      jeszcze=.t.
   *                   else
   *                      jeszcze=.f.
   *                   endif
   *                enddo
   *           case zsposob_p=3
   *                @ 23,25 say [       Zap&_l.acono czekiem       ]
   *                zkwota=0
   *           endcase

   *           select fakturyw
   *           do BLOKADAR
   *           repl_([sposob_p],zsposob_p)
   *           repl_([termin_z],ztermin_z)
   *           repl_([kwota],zkwota)
   *           unlock

               KVA := ' '
               SET COLOR TO
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               SELECT pozycjew
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
               DO WHILE del == '+' .AND. ident == zident_poz
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

               ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************

               SELECT fakturyw
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
               *-------------------
               IF ! tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
                  BREAK
               ENDIF
               zident_poz := Str( rec_no, 8 )
               *========================= Ksiegowanie ========================
               ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
               *==============================================================
               IF fakturyw->numer == firma->nr_faktw - 1
                  SELECT firma
                  BlokadaR()
                  repl_( 'nr_faktw', nr_faktw - 1 )
                  COMMIT
                  UNLOCK
               ENDIF
               SELECT pozycjew
               SEEK '+' + zident_poz
               DO WHILE del == '+' .AND. ident == zident_poz
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT fakturyw
               BlokadaR()
               del()
               COMMIT
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
                  SKIP -1
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
            @ 1, 47 SAY '          '
            BEGIN SEQUENCE
               SET CURSOR OFF
               IF LastKey() <> K_ESC
                  SET COLOR TO w+
                  SAVE SCREEN TO fff
                  Fakt2W()
                  RESTORE SCREEN FROM fff
               ENDIF
               SELECT fakturyw
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
                  center( j, p[ i ] )
                  j := j - 1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause(0)
            IF LastKey() # K_ESC .AND. lastkey() # K_F1
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_
            _disp=.f.
         ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   RETURN

*################################## FUNKCJE #################################
PROCEDURE say260vw()

   CLEAR TYPEAHEAD
   SELECT fakturyw
   zrach := rach
   *  set cent off
   SET COLOR TO +w
   @ 3,  0 SAY iif( RACH == 'F', 'Faktura Wew', 'Rachunek   ' )
   @ 3, 19 SAY StrTran( Str( NUMER, 5 ), ' ', '0' )
   @ 3, 32 SAY DZIEN
   @ 3, 70 SAY DATAS

   sprawdzVAT( 10, DATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   *@ 3,70 say DATAZ
   @ 4, 24 SAY nr_ident
   @ 5, 24 SAY SubStr( nazwa, 1, 46 )
   @ 6, 24 SAY SubStr( adres, 1, 40 )
   @ 4, 77 SAY EXPORT + iif( EXPORT == 'T', 'ak', 'ie' )
   @ 5, 77 SAY UE + iif( UE == 'T', 'ak', 'ie' )
   @ 6, 77 SAY KRAJ
   //003 nowa linia
   @ 7,  7 SAY WALUTA
   @ 7, 16 SAY KURS PICTURE "999.9999"
   @ 7, 30 SAY KURSDATA
   @ 7, 45 SAY SubStr( TABELA, 1, 13 )
   @ 7, 67 SAY SubStr( ZAMOWIENIE, 1, 13 )

   @ 16, 14 SAY PODATKI   PICTURE "@Z 9999999.99"
   @ 17, 14 SAY CLO       PICTURE "@Z 9999999.99"
   @ 18, 14 SAY TRANSPORT PICTURE "@Z 9999999.99"
   @ 19, 14 SAY PROWIZJA  PICTURE "@Z 9999999.99"
   @ 20, 14 SAY OPAKOWAN  PICTURE "@Z 9999999.99"
   @ 21, 14 SAY UBEZPIECZ PICTURE "@Z 9999999.99"
   @ 21, 34 SAY INNEKOSZ  PICTURE "@Z 9999999.99"
   @ 22, 14 SAY SubStr( OPISFAKT, 1, 23 )
   *@ 7,9  say substr(KOMENTARZ,1,38)
   *@ 7,59 say substr(ZAMOWIENIE,1,20)
   *@ 17,6 say substr(ODBNAZWA,1,30)
   *@ 18,6 say substr(ODBADRES,1,30)
   *@ 19,6 say ODBOSOBA
   *@ 22,0 say space(44)
   zident_poz := Str( rec_no, 8 )
   SELECT pozycjew
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
         @ 10 + i, 66 SAy WARTOSC PICTURE "9999999.99"
         @ 10 + i, 77 SAy VAT PICTURE "!!"
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
            zWART22 := zWART22 + WARTOSC
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
   @ 22, 69 SAY zWARTZW  + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 + zVAT07 + zVAT22 + zVAT02 + zVAT12 PICTURE "999 999.99"
   SELECT fakturyw
   SET COLOR TO
   *  set cent on

***************************************************
FUNCTION v26_00vw()

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
FUNCTION v26_10vw()
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

   RETURN Val( zdzien ) >= 1 .AND. val( zdzien ) <= msc( Val( miesiac ) )

***************************************************
FUNCTION v26_100vw()
   IF ztermin_z < 0
      RETURN .F.
   ENDIF
   IF ztermin_z == 0
      zkwota := 0
      KEYBOARD Chr( K_ENTER )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION w26_20vw()

   IF zDATAS > CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
      zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v26_20vw()

   sprawdzVAT( 10, zDATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   RETURN .T.

*############################################################################
FUNCTION Vv1_3fw()
***************************************************
   LOCAL aDane := hb_Hash()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   IF ( ins .AND. Len( AllTrim( znr_ident ) ) > 0 ) .OR. ( ! ins .AND. znr_ident # fakturyw->nr_ident )
      IF  KontrahZnajdz( znr_ident, @aDane )
         znazwa := Pad( aDane[ 'nazwa' ], 200 )
         zadres := Pad( aDane[ 'adres' ], 200 )
         zexport := aDane[ 'export' ]
         zue := aDane[ 'ue' ]
         zkraj := aDane[ 'kraj' ]
         KEYBOARD Chr( K_ENTER )
      ELSE
         znazwa := Space( 200 )
         zadres := Space( 200 )
         zexport := 'N'
         zUE := 'N'
         ZKRAJ := 'PL'
         SET COLOR TO i
         @ 4, 24 SAY SubStr( zNR_IDENT, 1, 30 )
         @ 5, 24 SAY SubStr( znazwa, 1, 46 )
         @ 6, 24 SAY SubStr( zadres, 1, 40 )
         @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
      ENDIF
   ENDIF

/*
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
            znazwa := Space( 200 )
            zadres := Space( 200 )
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
         SELECT fakturyw
      ELSE
         IF znr_ident # fakturyw->nr_ident
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
               znazwa := Space( 200 )
               zadres := Space( 200 )
               zexport := 'N'
               zUE := 'N'
               ZKRAJ := 'PL'
               set color to i
               @ 4, 24 SAY zNR_IDENT
               @ 5, 24 SAY SubStr( znazwa, 1, 46 )
               @ 6, 24 SAY zadres
               @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
               @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
               @ 6, 77 SAY zKRAJ
               SET COLOR TO
            ENDIF
            SET ORDER TO 1
            SELECT fakturyw
         ENDIF
      ENDIF
   ENDIF
*/
   RETURN .T.

***************************************************
FUNCTION w1_3fw()
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
      IF LastKey() == K_ENTER .OR. LastKey() == K_LDBLCLK
         KontrahAktualizuj()
         znazwa := nazwa
         zadres := adres
         zNR_IDENT := NR_IDENT
         zexport := export
         zUE := UE
         ZKRAJ := KRAJ
         SET COLOR TO i
         @ 4, 24 SAY zNR_IDENT
         @ 5, 24 SAY SubStr( znazwa, 1, 46 )
         @ 6, 24 SAY SubStr( zadres, 1, 40 )
         @ 4, 77 SAY zEXPORT + iif( zEXPORT == 'T', 'ak', 'ie' )
         @ 5, 77 SAY zUE + iif( zUE == 'T', 'ak', 'ie' )
         @ 6, 77 SAY zKRAJ
         SET COLOR TO
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT fakturyw
   RETURN .T.
