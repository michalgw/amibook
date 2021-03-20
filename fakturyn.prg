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

PROCEDURE FakturyN()

   LOCAL nKsieguj
   LOCAL aKsiegWybor := { "1. Zaksi©guj w bie¾¥cym miesi¥cu", ;
      "2. Nie wprowadzaj do ksi©gi", "3. Zaksi©guj w poprzednim miesi¥cu" }

   SAVE SCREEN TO scr_1

   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±Obsluga podstawowych operacji na bazie ......                             ±
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, _stop, _sbot
   PRIVATE _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou, _top_bot

   PRIVATE nPopKsgData, dPopDataTrans

   *********************** lp
   m->liczba := 1
   lpstart()

   sprawdzVAT( 10, CToD( param_rok + '.' + strtran( miesiac, ' ', '0' ) + '.01' ) )

   @  1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3, 0 SAY 'Faktura  Nr       z dnia                 data                                   '
   @  4, 0 SAY 'NABYWCA: Nr ident.(NIP).                                 SplitPay.:      Exp:   '
   @  5, 0 SAY '         Nazwa..........                                                  UE:   '
   @  6, 0 SAY '         Adres..........                                                Kraj:   '
   @  7, 0 SAY 'UWAGI....                                         Zlecenie.                     '
   @  8, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄ¿'
   @  9, 0 SAY '³         Nazwa towaru/us&_l.ugi          ³  Ilo&_s.&_c.  ³ JM  ³Cena nett³Wart.netto³VA³'
   @ 10, 0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄ´'
   @ 11, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   @ 12, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   @ 13, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   @ 14, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÂÄÄÄÄÁÄÄÄÄÄÅÄÄÂÄÄÄÄÄÄÁÄÄÂÄÄÄÄÄÄÄÁÄÄ´'
   @ 15, 0 SAY 'Oznaczenie:         Procedura:              ³          ³' + Str( vat_A, 2 ) + '³         ³          ³'
   @ 16, 0 SAY 'TYP FAKT.(opis typu/podstawy fakturowania): ³          ³' + Str( vat_B, 2 ) + '³         ³          ³'
   @ 17, 0 SAY '                                            ³          ³' + Str( vat_C, 2 ) + '³         ³          ³'
   @ 18, 0 SAY 'ODBIORCA:                                   ³          ³' + Str( vat_D, 2 ) + '³         ³          ³'
   @ 19, 0 SAY 'Nazwa.                                      ³          ³ 0³         ³          ³'
   @ 20, 0 SAY 'Adres.                                      ³          ³ZW³         ³          ³'
   @ 21, 0 SAY '                                            ³          ³  ³         ³          ³'
   @ 22, 0 SAY '                                       RAZEMÀÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ'
   @ 23, 0 SAY 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
   *if NR_UZYTK=800
   *   @ 20,0  say 'Opl.skarb.'
   *   @ 21,0  say 'Od darowiz.'
   *   @ 21,22 say 'Od czynnos.'
   *endif

   *############################### OTWARCIE BAZ ###############################
   SELECT 9
   IF Dostep( 'ROZR' )
      SetInd( 'ROZR' )
   ELSE
      SELECT 2
      close_()
      RETURN
   ENDIF

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
   _proc := 'say260vn'
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
      ster()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
         CASE kl == K_INS .OR. kl == Asc( '0' ) .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' ) .OR. &_top_bot
            @ 1, 47 SAY '          '
            ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
            ktoroper()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *-------------------
               IF ins .AND. Month( Date() ) # Val( miesiac ) .AND. del == '+' .AND. firma == ident_fir .AND. mc == miesiac
                  IF ! tnesc( '*u', ' Jest ' + Upper( RTrim( miesiac( Month( Date( ) ) ) ) ) + ' - jeste&_s. pewny? (T/N) ' )
                     BREAK
                  ENDIF
               ENDIF
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               IF ins
                  @  4, 78 CLEAR TO 5, 79
                  @ 11, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
                  @ 12, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
                  @ 13, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
                  @ 16, 45 CLEAR TO 21, 54
                  @ 16, 59 CLEAR TO 21, 67
                  @ 16, 69 CLEAR TO 21, 78
                  zrach := 'F'
                  zNUMERF := firma->nr_fakt
                  zDZIEN := Str( Day( Date( ) ), 2 )
                  zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
    *              zdataz=ctod('    .  .  ')
                  znazwa := Space( 200 )
                  zADRES := Space( 200 )
                  znr_ident := Space( 30 )
    *              zsposob_pp=2
    *              ztermin_z=0
    *              zkwota=0
                  zKOMENTARZ := Space( 60 )
                  zzamowienie := Space( 30 )
                  zSplitPay := 'N'
                  zexport := 'N'
                  zkraj := 'PL'
                  zUE := 'N'
                  zDATA2TYP := firma->DATA2TYP
                  zFAKTTYP := Space( 60 )
                  zROZRZAPF := pzROZRZAPF
                  zZAP_TER := 0
                  zZAP_DAT := Date()
                  zZAP_WART := 0
                  zOPCJE := Space( 32 )
                  zPROCEDUR := Space( 32 )
                  zKSGDATA := 0
               ELSE
                  zRACH := RACH
                  zNUMER&zRACH := NUMER
                  zDZIEN := DZIEN
                  zDATAS := DATAS
    *              zDATAZ := DATAZ
                  znazwa := nazwa
                  zADRES := ADRES
                  zNR_IDENT := NR_IDENT
    *              zsposob_pp=sposob_p
    *              zkwota=kwota
    *              ztermin_z=termin_z
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
                  zSplitPay := splitpay
                  zexport := export
                  zUE := ue
                  zKRAJ := KRAJ
                  zDATA2TYP := DATA2TYP
                  zFAKTTYP := FAKTTYP
                  zROZRZAPF := ROZRZAPF
                  zZAP_TER := ZAP_TER
                  zZAP_DAT := ZAP_DAT
                  zZAP_WART := ZAP_WART
                  zOPCJE := OPCJE
                  zPROCEDUR := PROCEDUR
                  zKSGDATA := KSGDATA
                  nPopKsgData := KSGDATA
                  dPopDataTrans := DATAS
    *             endif
               ENDIF
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               @ 23, 0
               SELECT faktury
               SET CURSOR ON
    *           @ 3,0  say 'Faktura VAT'
               @ 3, 25 GET zDZIEN PICTURE "99" WHEN v26_00vn() VALID v26_10vn()
               @ 3, 46 GET zDATA2TYP PICTURE '!' WHEN wDATA2TYPv() VALID vDATA2TYPv()
               @ 3, 70 GET zDATAS PICTURE "@D" WHEN w26_20vn() VALID v26_20vn()
    *           @ 3,63 get zDATAZ picture "@D"
               @ 4, 24 GET zNR_IDENT PICTURE repl( '!', 30 ) VALID vv1_3fn()
               @ 5, 24 GET znazwa PICTURE "@S46 " + repl( '!', 200 ) VALID w1_3fn()
               @ 6, 24 GET zADRES PICTURE "@S40 " + repl( '!', 200 )
    *          if ins
                  @ 4,67 get zSplitPay PICTURE '!' WHEN wfSplitPay() VALID vfSplitPay()
                  @ 4,77 get zexport picture '!' when wfEXIM( 4, 78 ) valid vfEXIM( 4, 78 )
                  @ 5,77 get zUE picture '!' when wfUE( 5, 78 ) valid vfUE( 5, 78 )
                  @ 6,77 get zKRAJ picture '!!'
    *          endif
               @  7,  9 GET zKOMENTARZ PICTURE "@S38" + repl( '!', 60 )
               @  7, 59 GET zZAMOWIENIE PICTURE "@S20" + repl( '!', 30 )
               @ 15, 11 GET zOPCJE PICTURE "@S8 " + Repl( '!', 32 ) WHEN KRejSWhOpcje() VALID KRejSVaOpcje()
               @ 15, 30 GET zPROCEDUR PICTURE "@S14 " + Repl( '!', 32 ) WHEN KRejSWhProcedur() VALID KRejSVaProcedur()
               @ 17,  0 GET zFAKTTYP PICTURE "@S40" + repl( '!', 60 )
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
                  repl_( 'nr_fakt', nr_fakt + 1 )
                  COMMIT
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
    *           repl_( 'DATAZ',zDATAZ)
               repl_( 'nazwa', znazwa )
               repl_( 'ADRES', zADRES )
               repl_( 'NR_IDENT', zNR_IDENT )
               repl_( 'KOMENTARZ', zKOMENTARZ )
               repl_( 'ZAMOWIENIE', zZAMOWIENIE )
               repl_( 'SPLITPAY', zSplitPay )
               repl_( 'EXPORT', zEXPORT )
               repl_( 'UE', zUE )
               repl_( 'KRAJ', zKRAJ )
               repl_( 'DATA2TYP', zDATA2TYP )
               repl_( 'OPCJE', zOPCJE )
               repl_( 'PROCEDUR', zPROCEDUR )
               repl_( 'FAKTTYP', zFAKTTYP )
               COMMIT
               UNLOCK
               zident_poz := Str( rec_no, 8 )

               FaPozN()
               SELECT faktury

               nKsieguj := 0

               IF zDATAS < hb_Date( Val( param_rok ), Val( miesiac ), 1 )
                  IF Val( miesiac ) == 1 .OR. Val( miesiac ) - Month( zDATAS ) <> 1
                     hb_ADel( aKsiegWybor, 3, .T. )
                  ENDIF
                  ColInf()
                  @ 24, 0
                  @ 24, 0 SAY PadC( 'Transakcja dokonana w poprzednim miesi¥cu. Wybierz opcje ksi©gowania.', 80 )
                  DO WHILE nKsieguj == 0
                     nKsieguj := MenuEx( 18, 20, aKsiegWybor, zKSGDATA + 1, .T. )
                  ENDDO
                  ColStd()
                  @ 24, 0
                  zKSGDATA := nKsieguj - 1
               ELSE
                  zKSGDATA := 0 // Ksieguj w aktualnym miesiacu
               ENDIF


               *-----------------------------------

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

                     CASE VAT == 'NP' .OR. VAT == 'PN' .OR. VAT == 'PU'
                        zWART08 := zWART08 + WARTOSC
                        IF VAT == 'PN' .OR. VAT == 'PU'
                           zSEK_CV7 := VAT
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

               IF zSplitPay == 'T'
                  zSEK_CV7 := 'SP'
               ENDIF

               zVAT07 := _round( zWART07 * ( vat_B / 100 ), 2 )
               zVAT02 := _round( zWART02 * ( vat_C / 100 ), 2 )
               zVAT22 := _round( zWART22 * ( vat_A / 100 ), 2 )
               zVAT12 := _round( zWART12 * ( vat_D / 100 ), 2 )
               razem := zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12

               @ 23, 0
               ColStd()
               @ 23,  0 SAY 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
               @ 23, 16 GET zROZRZAPF PICTURE '!' WHEN wROZRget() VALID vROZRget( 'zROZRZAPF', 23, 16 )
               @ 23, 36 GET zZAP_TER PICTURE '999'
               @ 23, 41 GET zZAP_DAT PICTURE '@D' WHEN wZAP_DAT() VALID vZAP_DAT()
               @ 23, 67 GET zZAP_WART PICTURE FPIC
* valid zZAP_WART>=0.0 .and. zZAP_WART<=abs(razem+zVAT22+zVAT12+zVAT07+zVAT02)
               read_()

               SELECT faktury
               BlokadaR()
               repl_('ROZRZAPF', zROZRZAPF )
               repl_('ZAP_TER', zZAP_TER )
               repl_('ZAP_DAT', zZAP_DAT )
               repl_('ZAP_WART', zZAP_WART )
               repl_( 'KSGDATA', zKSGDATA )
               REKZAK := rec_no
               COMMIT
               unlock


*para fZRODLO,fJAKIDOK,fNIP,fNRDOK,fDATAKS,fDATADOK,fTERMIN,fDNIPLAT,fRECNO,fKWOTA,fTRESC,fKWOTAVAT
* JAKIDOK: FS i FZ (faktury zakupu i sprzedazy), ZS i ZZ (zaplaty za sprzedaz i zakupy)

*              select 5
*              do while.not.dostep('ROZR')
*              enddo
*              do setind with 'ROZR'

               zTRESC := 'sprzedaz udokumentowana'
               SELECT rozr
               IF ins
                  IF zROZRZAPF == 'T'
                     dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0') )
                     IF ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
                        RozrApp( 'F', 'FS' ,zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ), ;
                           dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), ;
                           zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
                     ENDIF
                     IF zZAP_WART > 0.0
                        RozrApp( 'F', 'ZS', zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ), ;
                           dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
                     ENDIF
                  ENDIF
               ELSE
                  SET ORDER TO 2
                  SEEK ident_fir + param_rok + 'F' + Str( REKZAK, 10 )
                  IF Found()
                     IF zROZRZAPF == 'T'
                        SELECT rozr
                        RozrDel( 'F', REKZAK )
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        IF ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
                           RozrApp( 'F', 'FS', zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ), ;
                              dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), ;
                              zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
                        ENDIF
                        IF zZAP_WART > 0.0
                           RozrApp( 'F', 'ZS', zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0'), ;
                              dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
                        ENDIF
                     ELSE
                        SELECT rozr
                        RozrDel( 'F', REKZAK )
                     ENDIF
                  ELSE
                     if zROZRZAPF == 'T'
                        SELECT rozr
                        RozrDel( 'F', REKZAK )
                        dddat := CToD( StrTran( param_rok + '.' + miesiac + '.' + zdzien, ' ', '0' ) )
                        IF ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ) <> 0.0
                           RozrApp( 'F', 'FS', zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ), ;
                              dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, ( razem + zVAT22 + zVAT12 + zVAT07 + zVAT02 ), ;
                              zTRESC, ( zVAT22 + zVAT12 + zVAT07 + zVAT02 ) )
                        ENDIF
                        IF zZAP_WART > 0.0
                           RozrApp( 'F', 'ZS', zNR_IDENT, zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ), ;
                              dddat, dddat, zZAP_DAT, zZAP_TER, REKZAK, zZAP_WART, zTRESC, 0 )
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF

               *========================= Ksiegowanie ========================

               // Czy zapis do ksiegi i rejestru?
               IF zKSGDATA <> 1

                  IF  ! ins .AND. ( zKSGDATA <> nPopKsgData .OR. ( zKSGDATA == 2 .AND. Month( zDATAS ) <> Month( dPopDataTrans ) ) )
                     Faktury_UsunKsieg( nPopKsgData, Str( Month( dPopDataTrans ), 2 ) )
                  ENDIF

                  SELECT rejs
                  REC := RecNo()
                  SET INDEX TO
                  GO BOTTOM
                  ILREK := RecNo()
                  SET INDEX TO rejs2, rejs, rejs1, rejs3, rejs4
                  GO REC
                  IF ins
                     app()
                     repl_( 'firma', ident_fir )
                     repl_( 'mc', Faktury_McKsieg( zKSGDATA, miesiac ) )
                     repl_( 'RACH', zRACH )
                     repl_( 'numer', zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ) + '/' + param_rok )
                     repl_( 'tresc', 'Sprzedaz udokumentowana' )
                     IF zRYCZALT == 'T'
                        repl_( 'KOLUMNA', ' 0' )
                     ELSE
                        repl_( 'KOLUMNA', ' 7' )
                     ENDIF
                     repl_( 'KOREKTA', 'N' )
                     repl_( 'UWAGI', Space( 20 ) )
                     COMMIT
                     UNLOCK
                     razem_ := 0
                  ELSE
                     SEEK '+' + ident_fir + Faktury_McKsieg( zKSGDATA, miesiac ) + zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ) //+ '/' + param_rok
                     IF Found()
                        razem_ := netto
                     ELSE
                        app()
                        repl_( 'firma', ident_fir )
                        repl_( 'mc', miesiac )
                        repl_( 'RACH', zRACH )
                        repl_( 'numer', zRACH + '-' + StrTran( Str( znumer&zRACH, 5 ), ' ', '0' ) + '/' + param_rok )
                        repl_( 'tresc', 'Sprzedaz udokumentowana' )
                        IF zRYCZALT == 'T'
                           repl_( 'KOLUMNA', ' 0' )
                        ELSE
                           repl_( 'KOLUMNA', ' 7' )
                        ENDIF
                        repl_( 'KOREKTA', 'N' )
                        repl_( 'UWAGI', Space( 20 ) )
                        COMMIT
                        UNLOCK
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
                  //IF KVA <> 'N'
                     repl_( 'WARTZW', zWARTZW)
                     repl_( 'WART08', zWART08)
                     repl_( 'WART00', zWART00)
                     repl_( 'WART07', zWART07)
                     repl_( 'WART02', zWART02)
                     repl_( 'WART22', zWART22)
                     repl_( 'WART12', zWART12)
                     repl_( 'VAT07', zVAT07)
                     repl_( 'VAT02', zVAT02)
                     repl_( 'VAT22', zVAT22)
                     repl_( 'VAT12', zVAT12)
                  /*ELSE
                     repl_( 'WARTZW', 0)
                     repl_( 'WART08', 0)
                     repl_( 'WART00', 0)
                     repl_( 'WART07', 0)
                     repl_( 'WART02', 0)
                     repl_( 'WART22', 0)
                     repl_( 'WART12', 0)
                     repl_( 'VAT07', 0)
                     repl_( 'VAT02', 0)
                     repl_( 'VAT22', 0)
                     repl_( 'VAT12', 0)
                  ENDIF*/
                  IF zRYCZALT <> 'T'
                     repl_( 'NETTO', razem )
                  ENDIF
                  repl_( 'ROKS', Str( Year( zDATAS ), 4 ) )
                  repl_( 'MCS', Str( Month( zDATAS ), 2 ) )
                  repl_( 'DZIENS', Str( Day( zDATAS ), 2 ) )
                  repl_( 'DATATRAN', hb_Date( Val( param_rok ), Val( miesiac ), Val( zdzien ) ) )
                  repl_( 'OPCJE', zOPCJE )
                  repl_( 'PROCEDUR', zPROCEDUR )
   *           if zsposob_p=1.or.zsposob_p=3
   *              if zsposob_p=3.and.nr_uzytk=6
   *                 repl_([zaplata],[1])
   *              else
   *                 repl_([zaplata],[3])
   *              endif
   *           else
   *              if ztermin_z=0
   *                 repl_([zaplata],[1])
   *              else
   *                 if zkwota=0
   *                    repl_([zaplata],[3])
   *                 else
   *                    repl_([zaplata],[2])
   *                 endif
   *              endif
   *           endif
   *           repl_([kwota],zkwota)
                  COMMIT
                  UNLOCK
                  IF zRYCZALT <> 'T'
                  ************* ZAPIS REJESTRU DO KSIEGI *******************
                     SELECT oper
                     SET ORDER TO 3
                     IF ! ins
                        SEEK '+' + ident_fir + Faktury_McKsieg( zKSGDATA, miesiac ) + 'RS-7'
                        IF Found()
                           BlokadaR()
                           repl_( 'wyr_tow', wyr_tow - razem_ )
                           COMMIT
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
       *                    repl_([zaplata],'1')
       *                   repl_([kwota],zkwota)
                           COMMIT
                           UNLOCK
                           *********************** lp
                           SET ORDER TO 1
                           IF nr_uzytk >= 0
                              IF param_lp == 'T'
                                 IF param_kslp == '3'
                                    SET ORDER TO 4
                                 ENDIF
                                 Blokada()
                                 Czekaj()
                                 rec := RecNo()

                                 SKIP -1
                                 IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # Faktury_McKsieg( zKSGDATA, miesiac ), .F. )
                                    zlp := liczba
                                 ELSE
                                    zlp := lp + 1
                                 ENDIF
                                 GO rec
                                 DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == Faktury_McKsieg( zKSGDATA, miesiac ), .T. )
                                    repl_( 'lp', zlp )
                                    zlp := zlp + 1
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
                           COMMIT
                           UNLOCK
                        ***********************
                        ENDIF
                     ENDIF
                     SET ORDER TO 3
                     SEEK '+' + ident_fir + Faktury_McKsieg( zKSGDATA, miesiac ) + 'RS-7'
                     IF Found()
                        BlokadaR()
                        repl_( 'wyr_tow', wyr_tow + razem )
                        COMMIT
                        UNLOCK
                        SELECT suma_mc
                        SEEK '+' + ident_fir + Faktury_McKsieg( zKSGDATA, miesiac )
                        BlokadaR()
                        repl_( 'wyr_tow', wyr_tow - razem_ )
                        repl_( 'wyr_tow', wyr_tow + razem )
                        COMMIT
                        UNLOCK
                     ELSE
                        *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                        SELECT oper
                        app()
                        repl_( 'firma', ident_fir )
                        repl_( 'mc', Faktury_McKsieg( zKSGDATA, miesiac ) )
                        repl_( 'DZIEN', DAYM )
                        repl_( 'NUMER', 'RS-7' )
                        repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
                        repl_( 'WYR_TOW', RAZEM )
       *                 repl_([zaplata],'1')
       *                repl_([kwota],zkwota)
                        COMMIT
                        UNLOCK
                        *********************** lp
                        SET ORDER TO 1
                        IF nr_uzytk >= 0
                           IF param_lp == 'T'
                              IF param_kslp == '3'
                                 SET ORDER TO 4
                              ENDIF
                              Blokada()
                              Czekaj()
                              rec := RecNo()

                              SKIP -1
                              IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # Faktury_McKsieg( zKSGDATA, miesiac ), .F. )
                                 zlp := liczba
                              ELSE
                                 zlp := lp + 1
                              ENDIF
                              GO rec
                              DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == Faktury_McKsieg( zKSGDATA, miesiac ), .T. )
                                 repl_( 'lp', zlp )
                                 zlp := zlp + 1
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
                        COMMIT
                        UNLOCK
                        ***********************
                        SELECT suma_mc
                        SEEK '+' + ident_fir + Faktury_McKsieg( zKSGDATA, miesiac )
                        BlokadaR()
                        repl_( 'wyr_tow', wyr_tow - razem_ )
                        repl_( 'wyr_tow', wyr_tow + razem )
                        repl_( 'pozycje', pozycje + 1 )
                        COMMIT
                        UNLOCK
                     ENDIF
                     ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
                     SET ORDER TO 1
                  ENDIF
               ENDIF
               SELECT faktury
               commit_()
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            END
*     @ 23,0
            IF &_top_bot
               EXIT
            ELSE
               DO &_proc
            ENDIF
*     @ 23,0
            @ 24, 0

         *################################ KASOWANIE #################################
         CASE kl == K_DEL .OR. kl == Asc( '.' )
            @ 1, 47 SAY '          '
            ColStb()
            center( 24, 'þ                   þ' )
            ColSta()
            center( 24, 'K A S O W A N I E' )
            ColStd()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *-------------------
               IF ! tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
                  BREAK
               ENDIF
               zident_poz := Str( rec_no, 8 )
               IF KSGDATA <> 1
                  Faktury_UsunKsieg( Faktury_McKsieg( KSGDATA, miesiac ) )
               ENDIF
               *==============================================================
               IF faktury->numer == firma->nr_fakt - 1
                  SELECT firma
                  BlokadaR()
                  repl_( 'nr_fakt', nr_fakt - 1 )
                  COMMIT
                  UNLOCK
               ENDIF
               SELECT pozycje
               SEEK '+' + zident_poz
               DO WHILE del == '+' .AND. ident == zident_poz
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT faktury
               rrrec := rec_no
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
               commit_()

               SELECT rozr
               RozrDel( 'F', rrrec )
               SELECT faktury

               IF &_bot
                  SKIP -1
               ENDIF
               IF ! &_bot
                  DO &_proc
               ENDIF
            END
*     @ 23,0
            @ 24, 0
            IF &_top_bot
               EXIT
            ENDIF

         *################################# SZUKANIE dnia#############################
         CASE kl == K_F10 .OR. kl == 247
            @ 1, 47 SAY '          '
            ColStb()
            center( 24, 'þ                 þ' )
            ColSta()
            center( 24, 'S Z U K A N I E' )
            f10 := '  '
            ColStd()
            @ 3,25 GET f10 PICTURE "99"
            read_()
            IF ! Empty( f10 ) .AND. LastKey() # K_ESC
               SEEK '+' + ident_fir + miesiac + Str( Val( f10 ), 2 )
               IF &_bot
                  SKIP -1
               ENDIF
            ENDIF
            DO &_proc
            @ 24,0

         *################################# SZUKANIE numeru###########################
         CASE kl = K_F9
            @ 1, 47 SAY '          '
            ColStb()
            center( 24, 'þ                 þ' )
            ColSta()
            center( 24, 'S Z U K A N I E' )
            frach := 'F'
            fnum := 0
            ColStd()
            @ 3,12 GET fnum PICTURE '99999'
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
            @ 24, 0

         *############################### WYDRUK FAKTURY #############################
         CASE kl == K_ENTER
            @ 1, 47 SAY '          '
            BEGIN SEQUENCE
               IF NR_UZYTK == 800
                  zoplskarb := oplskarb
                  zpoddarow := poddarow
                  zpodcywil := podcywil
               ENDIF
               zodbnazwa := iif( Empty( odbnazwa ), nazwa, odbnazwa )
               zodbadres := iif( Empty( odbadres ), adres, odbadres )
               zodbosoba := iif( Empty( odbosoba ), Space( 30 ), odbosoba )
               zduplikat := 'N'
               zduplikatd := Date()
               SET CURSOR ON
               @ 19,  6 GET zodbnazwa PICTURE '@S30 ' + repl( '!', 200 )
               @ 20,  6 GET zodbADRES PICTURE '@S30 ' + repl( '!', 200 )
               @ 21,  0 SAY 'Duplikat (T/N) ?' GET zDUPLIKAT PICTURE '!' VALID zDUPLIKAT $ 'TN'
               @ 21, 20 SAY 'z dnia' GET zduplikatd PICTURE '@D' WHEN zduplikat == 'T'
    *           @ 21,6  get zodbosoba pict '!'+repl('X',29)
               IF NR_UZYTK=800
                  @ 20, 11 GET zoplskarb PICTURE '999999.99'
                  @ 21, 11 GET zpoddarow PICTURE '999999.99'
                  @ 21, 33 GET zpodcywil PICTURE '999999.99'
               ENDIF
               READ
               SET CURSOR OFF
               IF LastKey() <> K_ESC
                  BlokadaR()
                  REPLACE odbnazwa WITH zodbnazwa, odbadres WITH zodbadres, odbosoba WITH zodbosoba
                  if NR_UZYTK == 800
                     REPLACE oplskarb WITH zoplskarb, poddarow WITH zpoddarow, podcywil WITH zpodcywil
                  ENDIF
                  COMMIT
                  UNLOCK
                  SET COLOR TO w+
                  @ 19, 6 SAY SubStr( ODBNAZWA, 1, 30 )
                  @ 20, 6 SAY SubStr( ODBADRES, 1, 30 )
    *             @ 21, 6 SAY ODBOSOBA
                  IF NR_UZYTK == 800
                     @ 20, 11 SAY zoplskarb PICTURE '999999.99'
                     @ 21, 11 SAY zpoddarow PICTURE '999999.99'
                     @ 21, 33 SAY zpodcywil PICTURE '999999.99'
                  ENDIF
                  SAVE SCREEN TO fff
                  IF firma_rodzajdrfv == 'G'
                     FakturyN_DrukGraf()
                  ELSE
                     Fakt2New()
                  ENDIF
                  RESTORE SCREEN FROM fff
               ENDIF
               SELECT faktury
            END

         *################################### POMOC ##################################
         CASE kl == K_F1
            @ 1, 47 SAY '          '
            save screen to scr_
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
PROCEDURE say260vn()

   CLEAR TYPE
   SELECT faktury
   zrach := rach
   *  set cent off
   ColStd()
   @ 23, 0 SAY 'Kontrola zaplat....  Termin zaplaty.... (..........) Juz zaplacono.             '
   SET COLOR TO +w
   *@ 3,0  say iif(RACH='F','Faktura VAT','Rachunek   ')
   @ 3, 12 SAY StrTran( Str( NUMER, 5 ), ' ', '0' )
   @ 3, 25 SAY DZIEN
   @ 3, 46 SAY DATA2TYP
   @ 3, 48 SAY iif( DATA2TYP == 'D', 'dokonanie dost.towar.', ;
      iif( DATA2TYP == 'T', 'zakonczenie dost.tow.', ;
      iif( DATA2TYP == 'U', 'wykonanie uslugi     ', ;
      iif( DATA2TYP == 'Z', 'zaliczka             ', 'dokonanie dost.towar.' ) ) ) )
   @ 3, 70 SAY DATAS

   sprawdzVAT( 10, DATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   *@ 3,63 say DATAZ
   @  4, 24 SAY nr_ident
   @  5, 24 SAY substr(nazwa,1,46)
   @  6, 24 SAY SubStr( adres, 1, 40 )
   @  4, 67 SAY SPLITPAY + iif( SPLITPAY == 'T', 'ak', 'ie' )
   @  4, 77 SAY EXPORT+iif(EXPORT='T','ak','ie')
   @  5, 77 SAY UE+iif(UE='T','ak','ie')
   @  6, 77 SAY KRAJ
   //003 nowa linia
   @  7,  9 SAY SubStr( KOMENTARZ, 1, 38 )
   @  7, 59 SAY SubStr( ZAMOWIENIE, 1, 20 )
   @ 15, 11 SAY SubStr( OPCJE, 1, 8 )
   @ 15, 30 SAY SubStr( PROCEDUR, 1, 14 )
   @ 17,  0 SAY SubStr( FAKTTYP, 1, 40 )
   @ 19,  6 SAY SubStr( ODBNAZWA, 1, 30 )
   @ 20,  6 SAY SubStr( ODBADRES, 1, 30 )
   @ 21,  0 SAY Space( 40 )
   *@ 21,6 say ODBOSOBA
   IF NR_UZYTK == 800
      @ 20, 11 SAY oplskarb PICTURE '999999.99'
      @ 21, 11 SAY poddarow PICTURE '999999.99'
      @ 21, 33 SAY podcywil PICTURE '999999.99'
   ENDIF
   *@ 22,0 say space(44)
   *do case
   *case sposob_p=1
   *     @ 22,0 say [P&_l.atne przelewem w ci&_a.gu ]+str(termin_z,2)+[ dni]
   *case sposob_p=2
   *     if termin_z=0
   *        @ 22,0 say [Zap&_l.acono got&_o.wk&_a.]
   *     else
   *        if kwota=0
   *           @ 22,0 say [P&_l.atne got&_o.wk&_a. w terminie ]+str(termin_z,2)+[ dni]
   *        else
   *           @ 22,0 say [Zap&_l.acono ]+str(kwota,8,2)+[, reszta w terminie ]+str(termin_z,2)+[ dni]
   *        endif
   *     endif
   *case sposob_p=3
   *     @ 22,0 say [Zap&_l.acono czekiem]
   *endcase

   *@ 22, 0 say 'Kontrola zaplat....  .................. (..........) ..............             '
   @ 23, 16 SAY ROZRZAPF + iif( ROZRZAPF =='T', 'ak', 'ie' )
   *if ROZRZAPF='T'
   @ 23, 36 SAY ZAP_TER PICTURE '999'
   @ 23, 41 SAY ZAP_DAT PICTURE '@D'
   @ 23, 67 SAY ZAP_WART PICTURE FPIC
   *else
   *   set color to
   *   @ 23,36 say '...'
   *   @ 23,41 say '..........'
   *   @ 23,67 say space(13)
   *endif

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
   @ 11, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   @ 12, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   @ 13, 0 SAY '³                                      ³         ³     ³         ³          ³  ³'
   SET COLOR TO +w
   DO WHILE del == '+' .AND. ident == zident_poz
      IF i < 3
         i := i + 1
         @ 10 + i, 1 SAY Left( towar, 38 )
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

         CASE VAT == 'NP' .OR. VAT == 'PN' .OR. VAT == 'PU'
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
   @ 22, 69 SAY zWARTZW + zWART08 + zWART00 + zWART07 + zWART22 + zWART02 + zWART12 + zVAT07 + zVAT22 + zVAT02 + zVAT12 PICTURE "999 999.99"
   SELECT faktury
   SET COLOR TO
   *  set cent on
   RETURN

***************************************************
FUNCTION v26_00vn()

   R := .T.
   IF zRACH <> 'F' .AND. zRACH <> 'R'
      R := .F.
   ELSE
      SET COLOR TO +w
      @ 3, 12 SAY StrTran( Str( zNUMER&zRACH, 5 ), ' ', '0' )
      SET COLOR TO
   ENDIF
   RETURN R

***************************************************
FUNCTION v26_10vn()

   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ 3, 25 SAY zDZIEN
      SET COLOR TO
   ENDIF

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.' + StrTran( zDZIEN, ' ', '0' ) ) )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )

   RETURN Val( zdzien ) >= 1 .AND. Val( zdzien ) <= msc( Val( miesiac ) )

***************************************************
*function v26_100vn
*if ztermin_z<0
*return .f.
*endif
*   if ztermin_z=0
*   zkwota=0
*   keyboard chr(13)
*   endif
*return .t.
***************************************************
FUNCTION w26_20vn()
   IF zDATAS > CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
      zDATAS := CToD( param_rok + '.' + miesiac + '.' + zDZIEN )
   ENDIF
   RETURN .T.

***************************************************
FUNCTION v26_20vn()

   sprawdzVAT( 10, zDATAS )
   @ 15, 56 SAY Str( vat_A, 2 )
   @ 16, 56 SAY Str( vat_B, 2 )
   @ 17, 56 SAY Str( vat_C, 2 )
   @ 18, 56 SAY Str( vat_D, 2 )
   RETURN .T.

*############################################################################
FUNCTION Vv1_3fn()
***************************************************
   LOCAL aDane := hb_Hash()

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF

   IF ( ins .AND. Len( AllTrim( znr_ident ) ) > 0 ) .OR. ( ! ins .AND. znr_ident # faktury->nr_ident )
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
            SELECT faktury
         ENDIF
      ENDIF
   ENDIF
*/
   RETURN .T.

***************************************************
FUNCTION w1_3fn()
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
   SELECT faktury
   RETURN .T.

***************************************************
FUNCTION wDATA2TYPv()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz:D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka', 80, ' ' )
   ColStd()
   RETURN .T.

***************************************************
FUNCTION vDATA2TYPv()

   R := .T.
   IF zDATA2TYP <> 'D' .AND. zDATA2TYP <> 'T' .AND. zDATA2TYP <> 'U' .AND. zDATA2TYP <> 'Z'
      ColInf()
      @ 24, 0 SAY PadC( 'Wpisz:D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka', 80, ' ' )
      ColStd()
      R := .F.
   ELSE
      @ 3,48 SAY iif( zDATA2TYP == 'D', 'dokonanie dost.towar.', ;
         iif( zDATA2TYP == 'T', 'zakonczenie dost.tow.', ;
         iif( zDATA2TYP == 'U', 'wykonanie uslugi     ', ;
         iif( zDATA2TYP == 'Z', 'zaliczka             ', 'dokonanie dost.towar.') ) ) )
      @ 24, 0 CLEAR
   ENDIF
   RETURN R

FUNCTION wfSplitPay()

   ColInf()
   @ 24, 0 SAY PadC( 'Mechanizm podzielonej pˆatno˜ci (split payment): T-tak   lub   N-nie', 80, ' ' )
   ColStd()
   @  4, 68 SAY iif( zSplitPay == 'T', 'ak', 'ie' )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION vfSplitPay()

   LOCAL R

   R := .F.
   IF zSplitPay $ 'TN'
      ColStd()
      @  4, 68 SAY iif( zSplitPay == 'T', 'ak', 'ie' )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

/*----------------------------------------------------------------------*/

FUNCTION Faktury_McKsieg( nKsgData, cMiesiac )

   RETURN iif( nKsgData == 2, Str( Val( cMiesiac ) - 1, 2 ), cMiesiac )

/*----------------------------------------------------------------------*/

PROCEDURE Faktury_UsunKsieg( cMiesiac )

   *========================= Ksiegowanie ========================
   SELECT rejs
   SEEK '+' + ident_fir + cMiesiac + faktury->RACH + '-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' ) // + '/' + param_rok
   IF Found()
      razem_ := netto
      REKZAK := RecNo()
      BlokadaR()
      repl_( 'del', '-' )
      commit_()
      UNLOCK
      SKIP
      IF zRYCZALT <> 'T'
         ************* ZAPIS REJESTRU DO KSIEGI *******************
         SELECT oper
         SET ORDER TO 3
         SEEK '+' + ident_fir + cMiesiac + 'RS-7'
         IF Found()
            BlokadaR()
            repl_( 'wyr_tow', wyr_tow - razem_ )
            COMMIT
            UNLOCK
            SELECT suma_mc
            SEEK '+' + ident_fir + cMiesiac
            BlokadaR()
            repl_( 'wyr_tow', wyr_tow - razem_ )
            COMMIT
            UNLOCK
         ELSE
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            SELECT &USEBAZ
            app()
            //ADDDOC
            repl_( 'FIRMA', ident_fir )
            repl_( 'MC', cMiesiac )
            repl_( 'DZIEN', DAYM )
            repl_( 'NUMER', 'RS-7' )
            repl_( 'TRESC', 'SUMA Z REJESTRU SPRZEDAZY' )
            repl_( 'WYR_TOW', -razem_ )
            COMMIT
            UNLOCK
            *********************** lp
            SET ORDER TO 1
            IF nr_uzytk >= 0
               IF param_lp == 'T'
                  IF param_kslp == '3'
                     SET ORDER TO 4
                  ENDIF
                  Blokada()
                  Czekaj()
                  rec := RecNo()

                  SKIP -1
                  IF Bof() .OR. firma # ident_fir .OR. iif( Firma_RodzNrKs == "M", mc # cMiesiac, .F. )
                     zlp := liczba
                  ELSE
                     zlp := lp + 1
                  ENDIF
                  GO rec
                  DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == cMiesiac, .T. )
                     repl_( 'lp', zlp )
                     zlp := zlp + 1
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
            SELECT suma_mc
            SEEK '+' + ident_fir + cMiesiac
            BlokadaR()
            repl_( 'wyr_tow', wyr_tow - razem_ )
            repl_( 'pozycje', pozycje + 1 )
            COMMIT
            UNLOCK
         ENDIF
      ELSE
         SELECT EWID
         SET ORDER TO 5
         SEEK '+' + Str( REKZAK, 5 ) + 'RS-'
         IF Found()
            BlokadaR()
            DELETE
            COMMIT
            UNLOCK
            SET ORDER TO 1
            *********************** lp
            IF nr_uzytk >= 0
               IF param_lp == 'T' .AND. del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == cMiesiac, .T. )
                  IF param_kslp == '3'
                     SET ORDER TO 4
                  ENDIF
                  Blokada()
                  Czekaj()
                  rec := RecNo()
                  DO WHILE del == '+' .AND. firma == ident_fir .AND. iif( Firma_RodzNrKs == "M", mc == cMiesiac, .T. )
                     repl_( 'lp', lp - 1 )
                     SKIP
                  ENDDO
                  GO rec
                  COMMIT
                  UNLOCK
                  IF param_kslp == '3'
                     SET ORDER TO 1
                  ENDIF
                  @ 24, 0
               ENDIF
            ENDIF
            *******************************
         ENDIF
      ************* KONIEC ZAPISU REJESTRU DO KSIEGI *******************
      ENDIF
   ENDIF
   SELECT FAKTURY
   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE FakturyN_DrukGraf()

   LOCAL aDane := {=>}, aPoz, aSuma, nIdx, nWartosc := 0
   LOCAL cFakturyId := Str( faktury->rec_no, 8 )

   aDane[ 'nr_dok' ] := faktury->rach + '-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' ) + '/' + param_rok
   aDane[ 'data_dok' ] := hb_Date( Val( param_rok ), Val( faktury->mc ), Val( faktury->dzien ) )
   aDane[ 'data_trans' ] := faktury->datas
   IF ! Empty( faktury->datas )
      DO CASE
      CASE faktury->data2typ == 'D'
         aDane[ 'data_rodzaj' ] := 'Data dokonania dostawy towaru'
      CASE faktury->data2typ == 'T'
         aDane[ 'data_rodzaj' ] := 'Data zakoäczenia dostawy towaru'
      CASE faktury->data2typ == 'U'
         aDane[ 'data_rodzaj' ] := 'Data wykonania usˆugi'
      CASE faktury->data2typ == 'Z'
         aDane[ 'data_rodzaj' ] := 'Data zaliczki'
      OTHERWISE
         aDane[ 'data_rodzaj' ] := 'Data dokonania dostawy towaru'
      ENDCASE
   ELSE
      aDane[ 'data_rodzaj' ] := ''
   ENDIF
   aDane[ 'k_nazwa' ] := AllTrim( faktury->nazwa )
   aDane[ 'k_adres' ] := AllTrim( faktury->adres )
   aDane[ 'k_nip' ] := AllTrim( faktury->nr_ident )
   IF ( ! Empty( faktury->odbnazwa ) .AND. ! Empty( faktury->odbadres ) ) .AND. ( AllTrim( faktury->nazwa ) <> AllTrim( faktury->odbnazwa ) .OR. AllTrim( faktury->adres ) <> AllTrim( faktury->odbadres ) )
      aDane[ 'odbiorca' ] := 1
      aDane[ 'o_nazwa' ] := AllTrim( faktury->odbnazwa )
      aDane[ 'o_adres' ] := AllTrim( faktury->odbadres )
   ELSE
      aDane[ 'odbiorca' ] := 0
      aDane[ 'o_nazwa' ] := ""
      aDane[ 'o_adres' ] := ""
   ENDIF
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
   aDane[ 'rodzaj' ] := iif( faktury->rach == 'F', 'FAKTURA', 'RACHUNEK UPROSZCZONY' )
   aDane[ 'typ_faktury' ] := AllTrim( faktury->fakttyp )
   aDane[ 'duplikat' ] := iif( zduplikat == 'T', 1, 0 )
   aDane[ 'duplikat_data' ] := iif( zduplikat == 'T', zduplikatd, Date() )

   aDane[ 'pozycje' ] := {}
   aDane[ 'sumy' ] := {}
   pozycje->( dbSeek( '+' + cFakturyId ) )
   DO WHILE pozycje->del == '+' .AND. pozycje->ident == cFakturyId
      IF pozycje->wartosc == 0 .AND. Len( aDane[ 'pozycje' ] ) > 0
         aPoz := ATail( aDane[ 'pozycje' ] )
         aPoz[ 'towar' ] := aPoz[ 'towar' ] + hb_eol() + AllTrim( pozycje->towar )
      ELSE
         aPoz := {=>}
         aPoz[ 'wartosc_netto' ] := pozycje->wartosc
         aPoz[ 'towar' ] := AllTrim( pozycje->towar )
         aPoz[ 'ilosc' ] := pozycje->ilosc
         aPoz[ 'jm' ] := AllTrim( pozycje->jm )
         aPoz[ 'cena' ] := pozycje->cena
         //aPoz[ 'sww' ] := AllTrim( pozycje->sww )
         aPoz[ 'vat' ] := AllTrim( pozycje->vat )
         aPoz[ 'wartosc_vat' ] := round( ( Val( pozycje->vat ) / 100 ) * pozycje->wartosc, 2 )
         IF ( nIdx := hb_AScan( aDane[ 'sumy' ], { | aS | aS[ 'vat' ] == AllTrim( pozycje->vat ) } ) ) > 0
            aDane[ 'sumy' ][ nIdx ][ 'w_netto' ] := aDane[ 'sumy' ][ nIdx ][ 'w_netto' ] + pozycje->wartosc
            aDane[ 'sumy' ][ nIdx ][ 'w_vat' ] := aDane[ 'sumy' ][ nIdx ][ 'w_vat' ] + aPoz[ 'wartosc_vat' ]
         ELSE
            AAdd( aDane[ 'sumy' ], { 'vat' => AllTrim( pozycje->vat ), ;
               'w_netto' => pozycje->wartosc, 'w_vat' => aPoz[ 'wartosc_vat' ] } )
         ENDIF
         nWartosc := nWartosc + aPoz[ 'wartosc_netto' ] + aPoz[ 'wartosc_vat' ]
         AAdd( aDane[ 'pozycje' ], aPoz )
      ENDIF
      pozycje->( dbSkip() )
   ENDDO

   aDane[ 'naglowki' ] := {}

   IF aDane[ 'duplikat' ] <> 0
      AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'DUPLIKAT', 'dane' => 'wystawiono dnia ' ;
         + DToC( aDane[ 'duplikat_data' ] ) } )
   ENDIF
   AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Sprzedawca', ;
      'dane' => aDane[ 'f_nazwa' ] + hb_eol() + aDane[ 'f_kod_poczt' ] + ' ' ;
      + aDane[ 'f_miejscowosc' ] + ', ' + aDane[ 'f_ulica' ] + ' ' + aDane[ 'f_nr_domu' ] ;
      + iif( ! Empty( aDane[ 'f_nr_lokalu' ] ), '/' + aDane[ 'f_nr_lokalu' ], '' ) ;
      + hb_eol() + 'NIP: ' + aDane[ 'f_nip' ] + '    REGON: ' + aDane[ 'f_regon' ] ;
      + iif( ! Empty( aDane[ 'f_tel' ] ), '    tel.: ' + aDane[ 'f_tel' ], '' ) ;
      + iif( ! Empty( aDane[ 'f_fax' ] ), '    fax: ' + aDane[ 'f_fax' ], '' ) } )
   AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Nabywca', ;
      'dane' => aDane[ 'k_nazwa' ] + hb_eol() + aDane[ 'k_adres' ] + hb_eol() ;
      + 'NIP: ' + aDane[ 'k_nip' ] } )
   IF aDane[ 'odbiorca' ] <> 0
      AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Odbiorca', ;
        'dane' => aDane[ 'o_nazwa' ] + hb_eol() + aDane[ 'o_adres' ] } )
   ENDIF
   IF ! Empty( aDane[ 'zamowienie' ] )
      AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Zam¢wienie', 'dane' => aDane[ 'zamowienie' ] } )
   ENDIF
   IF ! Empty( aDane[ 'uwagi' ] )
      AAdd( aDane[ 'naglowki' ], { 'nazwa' => 'Uwagi', 'dane' => aDane[ 'uwagi' ] } )
   ENDIF

   IF faktury->splitpay == 'T'
      aDane[ 'dopisek' ] := 'Mechanizm podzielonej pˆatno˜ci'
   ELSE
      aDane[ 'dopisek' ] := ''
   ENDIF

   aDane[ 'wartosc' ] := nWartosc
   aDane[ 'slownie' ] := slownie( nWartosc )
   aDane[ 'zaplacono' ] := faktury->zap_wart
   IF _round( nWartosc, 2 ) <> _round( faktury->zap_wart, 2 )
      aDane[ 'do_zaplaty' ] := nWartosc - faktury->zap_wart
   ELSE
      aDane[ 'do_zaplaty' ] := 0
   ENDIF
   aDane[ 'termin' ] := faktury->zap_ter
   aDane[ 'termin_str' ] := AllTrim( Str( faktury->zap_ter ) )
   aDane[ 'termin_data' ] := faktury->zap_dat

   aDane[ 'wystawil' ] := AllTrim( ewid_wyst )

   FRDrukuj( 'frf\fv.frf', aDane )

   RETURN NIL

/*----------------------------------------------------------------------*/

