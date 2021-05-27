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

#include "box.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

PROCEDURE Pracow()

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,menuDrkDek,_top_bot
   PRIVATE _prac_aktywny := 'T'
   PRIVATE cEkranTmp

   @ 1, 47 SAY '          '

   *################################# GRAFIKA ##################################
   @  3, 0 SAY '                 I N F O R M A C J E   O   P R A C O W N I K A C H              '
   @  4, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÄNazwiskoÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄImi© 1ÄÄÄÄÂÄÄÄÄImi© 2ÄÄÄÄÂStatusÄÂÄPˆecÄÄÂKr¿'
   @  5, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @  6, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @  7, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @  8, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @  9, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @ 10, 0 SAY '³                             ³              ³              ³       ³       ³  ³'
   @ 11, 0 SAY 'ÃÄ(       )ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄ´'
   @ 12, 0 SAY '³ Nr PESEL..             NIP..                 Dokument.          nr:          ³'
   @ 13, 0 SAY '³ Urodzony/a dnia..           w                Nazwisko rodowe.                ³'
   @ 14, 0 SAY '³ Imiona: ojca.             matki.             Obywatelstwo....                ³'
   @ 15, 0 SAY '³ Miejsce zamieszkania.                        Kod..        Poczta..           ³'
   @ 16, 0 SAY '³ Ulica,dom,lokal......                              /        Tel...           ³'
   @ 17, 0 SAY '³ Gmina.                   Powiat.                   Wojew.                    ³'
   @ 18, 0 SAY '³ Urz¥d Skarbowy.                                                  O˜w.<26r:   ³'
   @ 19, 0 SAY '³ Miejsce zatrudnienia.                                                 PPK:   ³'
   @ 20, 0 SAY '³ Bank:                Konto:                Kwota przelewu:                   ³'
   @ 21, 0 SAY '³ Nr id. podat.                  Rodzaj nr id.                                 ³'
   @ 22, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   SELECT 7
   IF Dostep( 'ZALICZKI' )
      SetInd( 'ZALICZKI' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 6
   IF Dostep( 'WYPLATY' )
      SetInd( 'WYPLATY' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 5
   IF Dostep( 'NIEOBEC' )
      SetInd( 'NIEOBEC' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 4
   IF Dostep( 'ETATY' )
      SetInd( 'ETATY' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 3
   IF Dostep( 'UMOWY' )
      SetInd( 'UMOWY' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 2
   IF Dostep( 'URZEDY' )
      SetInd( 'URZEDY' )
   ELSE
      close_()
      RETURN
   ENDIF
   SELECT 1
   IF Dostep( 'PRAC' )
      SetInd( 'PRAC' )
      SET FILTER TO prac->aktywny == _prac_aktywny
      GO TOP
      SEEK '+' + ident_fir
   ELSE
      close_()
      RETURN
   ENDIF

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 5
   _col_l := 1
   _row_d := 10
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,13,28,65,97,-4'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.OR.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'say31()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'say31s'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot

   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         KTOROPER()
         IF ins
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            wiersz := _row
         ENDIF
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zNREWID := Space( 11 )
               zNAZWISKO := Space( 30 )
               zIMIE1 := Space( 15 )
               zIMIE2 := Space( 15 )
               zIMIE_O := Space( 15 )
               zIMIE_M := Space( 15 )
               zPLEC := ' '
               zPESEL := Space( 11 )
               zNIP := Space( 13 )
               zMIEJSC_UR := Space( 20 )
               zDATA_UR := CToD( '    .  .  ' )
               zNAZW_RODU := Space( 30 )
               zOBYWATEL := PadR( 'POLSKIE', 22 )
               zMIEJSC_ZAM := Space( 20 )
               zGMINA := Space( 20 )
               zULICA := Space( 20 )
               zNR_DOMU := Space( 5 )
               zNR_MIESZK := Space( 5 )
               zKOD_POCZT := '  -   '
               zPOCZTA := Space( 20 )
               zTELEFON := Space( 15 )
               zSKARB := 0
               zURZAD := Space( 45 )
               zZATRUD := Space( 70 )
               zDOWOD := Space( 9 )
               zRODZ_DOK := 'D'
               zSTATUS := 'U'
               zPARAM_WOJ := M->PARAM_WOJ
               zPARAM_POW := M->PARAM_POW
               zBANK := Space( 30 )
               zKONTO := Space( 32 )
               //002 dwie nowe linie
               zJAKI_PRZEL := 'N'
               zKW_PRZELEW := 0
               zAKTYWNY := 'T'
               zRODZOBOW := '1'
               zDOKIDKRAJ := 'PL'
               zZAGRNRID := Space( 20 )
               zDOKIDROZ := ' '
               zOSWIAD26R := 'N'
               zPPK := 'N'
               zPPKZS1 := 0
               zPPKZS2 := 0
               zPPKPS2 := 0
               zPPKIDKADR := Pad( AllTrim( Str( RecNo(), 10 ) ), 10 )
               zPPKIDEPPK := Space( 20 )
               zPPKIDPZIF := Space( 50 )
            else
               zNREWID := NREWID
               zNAZWISKO := NAZWISKO
               zIMIE1 := IMIE1
               zIMIE2 := IMIE2
               zIMIE_O := IMIE_O
               zIMIE_M := IMIE_M
               zPLEC := PLEC
               zPESEL := PESEL
               zNIP := NIP
               zMIEJSC_UR := MIEJSC_UR
               zDATA_UR := DATA_UR
               zNAZW_RODU := NAZW_RODU
               zOBYWATEL := OBYWATEL
               zMIEJSC_ZAM := MIEJSC_ZAM
               zGMINA := GMINA
               zULICA := ULICA
               zNR_DOMU := NR_DOMU
               zNR_MIESZK := NR_MIESZK
               zKOD_POCZT := KOD_POCZT
               zPOCZTA := POCZTA
               zTELEFON := TELEFON
               zSKARB := SKARB
               zZATRUD := ZATRUD
               zDOWOD := DOWOD_OSOB
               zRODZ_DOK := RODZ_DOK
               zSTATUS := STATUS
               zPARAM_WOJ := PARAM_WOJ
               zPARAM_POW := PARAM_POW
               zBANK := BANK
               zKONTO := KONTO
               zAKTYWNY := AKTYWNY
               zRODZOBOW := RODZOBOW
               //002 NOWE LINIE
               zJAKI_PRZEL := JAKI_PRZEL
               IF zJAKI_PRZEL == ' '
                  zJAKI_PRZEL := 'N'
               ENDIF
               zKW_PRZELEW := KW_PRZELEW

               //002 DO T¤D
               zDOKIDKRAJ := DOKIDKRAJ
               zZAGRNRID := ZAGRNRID
               zDOKIDROZ := DOKIDROZ

               zOSWIAD26R := iif( OSWIAD26R = ' ', 'N', OSWIAD26R )

               zPPK := iif( PPK == ' ', 'N', PPK )
               zPPKZS1 := PPKZS1
               zPPKZS2 := PPKZS2
               zPPKPS2 := PPKPS2
               zPPKIDKADR := iif( Len( AllTrim( PPKIDKADR ) ) == 0, Pad( AllTrim( Str( RecNo(), 10 ) ), 10 ), PPKIDKADR )
               zPPKIDEPPK := PPKIDEPPK
               zPPKIDPZIF := PPKIDPZIF

               SELECT urzedy
               GO zSKARB
               zURZAD := miejsc_us + ' - ' + urzad
               SELECT prac
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 1  GET zNAZWISKO  PICTURE "@S29 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" VALID v3_111()
            @ wiersz, 31 GET zIMIE1     PICTURE "@S14 !!!!!!!!!!!!!!!" VALID v3_121()
            @ wiersz, 46 GET zIMIE2     PICTURE "@S14 !!!!!!!!!!!!!!!"
            @ wiersz, 61 GET zSTATUS    PICTURE "!" WHEN w3_131() VALID v3_131()
            @ wiersz, 69 GET zPLEC      PICTURE "!" WHEN w3_132() VALID v3_132()
            @ wiersz, 77 GET zDOKIDKRAJ PICTURE "!!"

            @ 12, 12 GET zPESEL      PICTURE "99999999999"
            @ 12, 30 GET zNIP        PICTURE "!!!!!!!!!!!!!"
            @ 12, 56 GET zRODZ_DOK   PICTURE "!" WHEN w3_133() VALID v3_133()
            @ 12, 69 GET zDOWOD      PICTURE "!!!999999"
            @ 13, 19 GET zDATA_UR    PICTURE '@D'
            @ 13, 32 GET zMIEJSC_UR  PICTURE "@S14 !!!!!!!!!!!!!!!!!!!!"
            @ 13, 63 GET zNAZW_RODU  PICTURE '@S15 ' + repl( '!', 30 ) WHEN rod()
            @ 14, 15 GET zIMIE_O     PICTURE "@S12 !!!!!!!!!!!!!!!"
            @ 14, 34 GET zIMIE_M     PICTURE "@S12 !!!!!!!!!!!!!!!"
            @ 14, 63 GET zOBYWATEL   PICTURE '@S16 ' + repl( '!', 22 )
            @ 15, 23 GET zMIEJSC_ZAM PICTURE "!!!!!!!!!!!!!!!!!!!!"
            @ 15, 52 GET zKOD_POCZT  PICTURE "99-999"
            @ 15, 68 GET zPOCZTA     PICTURE "@S10 !!!!!!!!!!!!!!!!!!!!"
            @ 16, 23 GET zULICA      PICTURE "!!!!!!!!!!!!!!!!!!!!"
            @ 16, 47 GET zNR_DOMU    PICTURE "!!!!!"
            @ 16, 55 GET zNR_MIESZK  PICTURE "!!!!!"
            @ 16, 68 GET zTELEFON    PICTURE "@S10 !!!!!!!!!!!!!!!"
            @ 17,  8 GET zGMINA      PICTURE "@S17 !!!!!!!!!!!!!!!!!!!!"
            @ 17, 34 GET zPARAM_POW  PICTURE "@S17 !!!!!!!!!!!!!!!!!!!!"
            @ 17, 59 GET zPARAM_WOJ  PICTURE "!!!!!!!!!!!!!!!!!!!!"
            @ 18, 17 GET zURZAD      PICTURE "!!!!!!!!!!!!!!!!!!!! - !!!!!!!!!!!!!!!!!!!!!!!!!" VALID v3_141()
            @ 18, 76 GET zOSWIAD26R  PICTURE "!" VALID ValidPracOswiad26r()
            @ 19, 23 GET zZATRUD     PICTURE '@S45 ' + Replicate( '!', 70 )
            @ 19, 76 GET zPPK        PICTURE '!' VALID etatyvppk( 19, 77 )
            //002 zawezone parametry banku
            @ 20,  7 GET zBANK       PICTURE '@S15 ' + repl( '!', 30 )
            @ 20, 29 GET zKONTO      PICTURE '@S15 ' + repl( '!', 32 )
            //002 DWIE NOWE LINIE
            @ 20, 60 GET zJAKI_PRZEL PICTURE "!" WHEN wyb_przel() VALID war_przel()
            @ 20, 71 GET zKW_PRZELEW PICTURE "99999.99" WHEN wyl_przel() VALID wyl_przel()
            @ 21, 16 GET zZAGRNRID   PICTURE "!!!!!!!!!!!!!!!!!!!!"
            @ 21, 47 GET zDOKIDROZ   PICTURE "9" WHEN PracDokidrozWhen() VALID PracDokidrozValid()

            read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               SET ORDER TO 4
               Blokada()
               GO BOTTOM
               IDPR := rec_no + 1
               SET ORDER TO 1
               app()
               repl_( 'FIRMA', IDENT_FIR )
               repl_( 'REC_NO', IDPR )
               SELECT etaty
               FOR i := 1 TO 12
                   CURR := ColInf()
                   @ 24, 0
                   center( 24, 'Dopisuje miesi&_a.c ' + Str( i, 2 ) )
                   SetColor( CURR )
                   app()
                   REPLACE firma WITH ident_fir, ;
                      ident WITH Str( idpr, 5 ), ;
                      mc WITH Str( i, 2 )
                   COMMIT
                   UNLOCK
               NEXT
               @ 24, 0
            ENDIF
            SELECT prac
            BlokadaR()
            REPLACE NREWID WITH zNREWID, ;
               NAZWISKO WITH zNAZWISKO, ;
               IMIE1 WITH zIMIE1, ;
               IMIE2 WITH zIMIE2, ;
               IMIE_O WITH zIMIE_O, ;
               IMIE_M WITH zIMIE_M, ;
               PLEC WITH zPLEC, ;
               PESEL WITH zPESEL, ;
               NIP WITH zNIP, ;
               MIEJSC_UR WITH zMIEJSC_UR, ;
               DATA_UR WITH zDATA_UR, ;
               NAZW_RODU WITH zNAZW_RODU, ;
               OBYWATEL WITH zOBYWATEL, ;
               MIEJSC_ZAM WITH zMIEJSC_ZAM, ;
               GMINA WITH zGMINA, ;
               ULICA WITH zULICA, ;
               NR_DOMU WITH zNR_DOMU, ;
               NR_MIESZK WITH zNR_MIESZK, ;
               KOD_POCZT WITH zKOD_POCZT, ;
               POCZTA WITH zPOCZTA, ;
               TELEFON WITH zTELEFON, ;
               PARAM_WOJ WITH zPARAM_WOJ, ;
               PARAM_POW WITH zPARAM_POW, ;
               SKARB WITH zSKARB, ;
               ZATRUD WITH zZATRUD, ;
               DOWOD_OSOB WITH zDOWOD, ;
               RODZ_DOK WITH zRODZ_DOK, ;
               STATUS WITH zSTATUS, ;
               BANK WITH zBANK, ;
               KONTO WITH zKONTO, ;
               JAKI_PRZEL WITH zJAKI_PRZEL, ;
               AKTYWNY WITH zAKTYWNY, ;
               RODZOBOW WITH zRODZOBOW, ;
               DOKIDKRAJ WITH zDOKIDKRAJ, ;
               DOKIDROZ WITH zDOKIDROZ, ;
               ZAGRNRID WITH zZAGRNRID, ;
               OSWIAD26R WITH zOSWIAD26R, ;
               PPK WITH zPPK, ;
               PPKZS1 WITH zPPKZS1, ;
               PPKZS2 WITH zPPKZS2, ;
               PPKPS2 WITH zPPKPS2, ;
               PPKIDKADR WITH zPPKIDKADR, ;
               PPKIDEPPK WITH zPPKIDEPPK, ;
               PPKIDPZIF WITH zPPKIDPZIF

            IF (zJAKI_PRZEL = 'P' ) .AND. ( zKW_PRZELEW > 100 )
               SaveScreen()
               Tone( 500, 4 )
               Tone( 500, 4 )
               zKW_PRZELEW := 100
               ColErr()
               @ 24, 0 SAY PadC( 'Nie mo&_z.e by&_c. wi&_e.cej niz 100 procent', 80, ' ' )
               pause( 0 )
               czysc()
               RestScreen()
            ENDIF
            IF zKW_PRZELEW < 0
               SaveScreen()
               Tone( 500, 4 )
               Tone( 500, 4 )
               zKW_PRZELEW := 0
               ColErr()
               @ 24, 0 SAY PadC( 'Warto&_s.&_c. przelewu nie mo&_z.e by&_c. warto&_s.ci&_a. ujemn&_a.', 80, ' ' )
               pause( 0 )
               czysc()
               RestScreen()
            ENDIF
            REPLACE KW_PRZELEW WITH zKW_PRZELEW
            //002 powyzej obsluga kwot przelewu
            //002 UWAGA!!! jesli procentowy & kwota>100 to kwota = 100
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               BREAK
            ENDIF
            *@ _row_d,_col_l say &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '                             ³              ³              ³       ³       ³  '
         END
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() = 27 .AND. _row = -1, 27, kl )
         @ 23, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         RECS := rec_no
         SELECT umowy
         seek '+' + Str( RECS, 5 )
         IF .NOT. Found() .AND. ;
            ( Empty( prac->data_przy ) .OR. ( .NOT. Empty( prac->data_przy ) .AND. Str( Year( prac->data_przy ), 4 ) < param_rok ) .AND. ( .NOT. Empty( prac->data_zwol ) .AND. Str( Year( prac->data_zwol ), 4 ) < param_rok ) ) .AND. ;
            ( Empty( prac->data_zwol ) .OR. ( .NOT. Empty( prac->data_zwol ) .AND. Str( Year( prac->data_zwol ), 4 ) < param_rok ) )
            SELECT prac
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                   þ' )
            ColSta()
            center( 23, 'K A S O W A N I E' )
            ColStd()
            _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
            IF _disp
               BlokadaR()
               del()
               *repl del with '-'
               COMMIT
               UNLOCK
               SEEK '+' + ident_fir

               SELECT etaty
               SEEK '+' + ident_fir + Str( RECS, 5 )
               DO WHILE del = '+' .AND. firma = ident_fir .AND. ident = Str( RECS, 5 )
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT nieobec
               SEEK '+' + ident_fir + Str( RECS, 5 )
               DO WHILE del = '+' .AND. firma = ident_fir .AND. ident = Str( RECS, 5 )
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT wyplaty
               SEEK '+' + ident_fir + Str( RECS, 5 )
               DO WHILE del = '+' .AND. firma = ident_fir .AND. ident = Str( RECS, 5 )
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT zaliczki
               SEEK '+' + ident_fir + Str( RECS, 5 )
               DO WHILE del = '+' .AND. firma = ident_fir .AND. ident = Str( RECS, 5 )
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
               SELECT umowy
               SEEK '+' + ident_fir + Str( RECS, 5 )
               DO WHILE del = '+' .AND. firma = ident_fir .AND. ident = Str( RECS, 5 )
                  BlokadaR()
                  del()
                  COMMIT
                  UNLOCK
                  SKIP
               ENDDO
            ENDIF
            *====================================
         ELSE
            kom( 3, '*u', ' Kasowanie niemo&_z.liwe. Pracownik pracowa&_l. lub pracuje dla firmy ' )
            KEYBOARD Chr( 27 )
            Inkey()
         ENDIF
         SELECT prac
         @ 23, 0
        *################################# SZUKANIE #################################
      CASE kl == -9 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := Space( 30 )
         @ _row, 1 GET f10 PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
         read_()
         _disp := .NOT. Empty( f10 ) .AND. LastKey() # 27
         IF _disp
            SEEK '+' + ident_fir + dos_l( f10 )
            IF &_bot
               SKIP -1
            ENDIF
            _row := Int( ( _row_g + _row_d ) / 2 )
         ENDIF
         @ 23, 0
      *############################### WYDRUK EWIDENCJI ###########################
      CASE kl == 13
         IF prac->dokidkraj == 'PL' .OR. prac->dokidkraj == '  '
           menuDrkDek := menuDeklaracjaDruk( 6, .F. )
           IF LastKey() != 27
              SAVE SCREEN TO scr_
              pit_811( 0, 0, 1, menuDrkDek )
              RESTORE SCREEN FROM scr_
           ENDIF
         ELSE
            SWITCH MenuEx( 6, 4, { "P - Deklaracja PIT-11", "I - Deklaracja IFT-1/IFT-1R" }, 1 )
            CASE 1
               menuDrkDek  :=  menuDeklaracjaDruk( 6, .F. )
               IF LastKey() != 27
                  SAVE SCREEN TO scr_
                  pit_811( 0, 0, 1, menuDrkDek )
                  RESTORE SCREEN FROM scr_
               ENDIF
               EXIT
            CASE 2
               menuDrkDek  :=  menuDeklaracjaDruk( 6, .F. )
               IF LastKey() != 27
                  SAVE SCREEN TO scr_
                  IFT1_Rob( menuDrkDek == 'X' )
                  Select( 'PRAC' )
                  RESTORE SCREEN FROM scr_
               ENDIF
               EXIT
            ENDSWITCH
         ENDIF
      *################################### USTAW AKTYWNY/NIEAKTYWNY ###############
      CASE ( kl == 65 .OR. kl == 97 )//.AND.(.NOT.&_top_bot)
         IF .NOT. Empty( prac->data_zwol )
            IF tnesc( '*i', '   Czy ukry&_c. pracownika? (T/N)   ' )
               SELECT prac
               BlokadaR()
               REPLACE aktywny WITH iif( aktywny == 'T', 'N', 'T' )
               commit_()
               SEEK '+' + ident_fir
            ENDIF
         ELSE
            kom( 3, '*u', ' Ukrywanie niemo&_z.liwe. Pracownik pracuje dla firmy ' )
            KEYBOARD Chr( 27 )
            Inkey()
         ENDIF
      *################################### FILTR AKTYWNY/NIEAKTYWNY ###############
      CASE kl == -4
         _prac_aktywny := iif( _prac_aktywny == 'T', 'N', 'T' )
         SELECT prac
         SET FILTER TO prac->aktywny == _prac_aktywny
         GO TOP
         IF _prac_aktywny == 'T'
            @  3, 0 say '           '
         ELSE
            popKolor = ColStb()
            @  3, 0 say 'NIEAKTYWNI'
            SetColor( popKolor )
         ENDIF
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         declare p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Enter].................deklaracja PIT-11 lub PIT-8B '
         p[  6 ] := '   [Ins]...................wpisywanie                   '
         p[  7 ] := '   [M].....................modyfikacja pozycji          '
         p[  8 ] := '   [Del]...................kasowanie pozycji            '
         p[  9 ] := '   [F10]...................szukanie                     '
         p[ 10 ] := '   [A].....................aktywny / nieaktywny         '
         p[ 11 ] := '   [F5]....................pokaz aktywnych/nieaktywnych '
         p[ 12 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 13 ] := '                                                        '
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
         _disp := .f.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN

*################################## FUNKCJE #################################
PROCEDURE say31()

   RETURN SubStr( NAZWISKO, 1, 29 ) + '³' + SubStr( IMIE1, 1, 14 ) + '³' + SubStr( IMIE2, 1, 14 ) + '³' + iif( STATUS <> 'U', iif( STATUS = 'E', 'Etatowy', 'Zlecen.' ), 'Uniwers' ) + '³' + iif( PLEC = 'M', 'M&_e.&_z.czyz', 'Kobieta' ) + '³' + DOKIDKRAJ

*############################################################################
PROCEDURE say31s()

   LOCAL cRodzajDokIdStr

   CLEAR TYPE
   SET COLOR TO +w
   *_iledni=year(date()-DATA_UR)
   *_newdate=_iledni/365
   @ 11, 4  SAY Transform( Str( Int( ( Date() - DATA_UR ) / 365 ), 2 ), '99' ) + ' lat'

   @ 12, 12 SAY PESEL
   @ 12, 30 SAY NIP
   @ 12, 56 SAY RODZ_DOK + iif( RODZ_DOK = 'D', 'ow&_o.d   ', 'aszport' )
   @ 12, 69 SAY DOWOD_OSOB
   @ 13, 19 SAY DATA_UR
   @ 13, 32 SAY SubStr( MIEJSC_UR, 1, 14 )
   @ 13, 63 SAY SubStr( NAZW_RODU, 1, 15 )
   @ 14, 15 SAY SubStr( IMIE_O, 1, 12 )
   @ 14, 34 SAY SubStr( IMIE_M, 1, 12 )
   @ 14, 63 SAY SubStr( OBYWATEL, 1, 16 )
   @ 15, 23 SAY MIEJSC_ZAM
   @ 15, 52 SAY KOD_POCZT
   @ 15, 68 SAY SubStr( POCZTA, 1, 10 )
   @ 16, 23 SAY ULICA
   @ 16, 47 SAY NR_DOMU
   @ 16, 55 SAY NR_MIESZK
   @ 16, 68 SAY SubStr( TELEFON, 1, 10 )
   @ 17,  8 SAY SubStr( GMINA, 1, 17 )
   @ 17, 34 SAY SubStr( PARAM_POW, 1, 17 )
   @ 17, 59 SAY PARAM_WOJ
   @ 18, 76 SAY iif( iif( OSWIAD26R = ' ', 'N', OSWIAD26R ) = 'T', 'Tak', 'Nie' )
   SELECT urzedy
   GO prac->skarb
   zurzad := miejsc_us + ' - ' + urzad
   @ 18, 17 SAY zURZAD
   SELECT prac
   @ 19, 23 SAY SubStr( ZATRUD, 1, 45 )
   @ 19, 76 SAY iif( iif( PPK == ' ', 'N', PPK ) == 'T', 'Tak', 'Nie' )
   //002 skrocenia pol banku
   @ 20,  7 SAY SubStr( BANK, 1, 15 )
   @ 20, 29 SAY substr( KONTO,1, 15 )
   //002 nowe linie
   IF JAKI_PRZEL==' '
      @ 20, 60 SAY 'N'
   ELSE
      @ 20, 60 SAY JAKI_PRZEL
   ENDIF
   @ 20, 61 SAY iif( JAKI_PRZEL = 'K', 'wotowo:   ', iif( JAKI_PRZEL = 'P', 'rocentowo:', 'ie przel. ' ) )
   IF JAKI_PRZEL $ ' N' = .F.
      @ 20, 71 SAY KW_PRZELEW
   ELSE
      @ 20, 71 SAY Space( 8 )
   ENDIF
            //002 DO T¤D
   @ 21, 16 SAY prac->zagrnrid
   @ 21, 47 SAY prac->dokidroz + ' - ' + SubStr( PadR( PracDokRodzajStr( prac->dokidroz ), 28 ), 1, 28 )

   SET COLOR TO

   RETURN

***************************************************
FUNCTION v3_111()

   IF Empty( zNAZWISKO )
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION v3_121()

   IF Empty( zIMIE1 )
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION w3_131()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: E - pracownik etatowy , Z - pracownik na zlecenie lub U - uniwersalny', 80, ' ' )
   ColStd()
   @ wiersz, 62 SAY iif( zSTATUS <> 'U', iif( zSTATUS = 'E', 'tatowy', 'lecen.' ), 'niwers' )

   RETURN .T.

***************************************************
FUNCTION v3_131()

   R := .F.
   IF zSTATUS $ 'EZU'
      ColStd()
      @ wiersz, 62 SAY iif( zSTATUS <> 'U', iif( zSTATUS = 'E', 'tatowy', 'lecen.' ), 'niwers' )
      @ 24, 0
      IF zSTATUS <> 'Z'
         zDOKIDKRAJ := 'PL'
      ENDIF
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION w3_132()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: M - m&_e.&_z.czyzna lub K - kobieta', 80, ' ' )
   ColStd()
   @ wiersz, 70 SAY iif( zPLEC = 'M', '&_e.&_z.czyz', 'obieta' )

   RETURN .T.

***************************************************
FUNCTION v3_132()

   R := .F.
   IF zPLEC $ 'MK'
      ColStd()
      @ wiersz, 70 SAY iif( zPLEC = 'M', '&_e.&_z.czyz', 'obieta' )
      @ 24, 0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION w3_133()

   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: D - dow&_o.d osobisty lub P - paszport', 80, ' ' )
   ColStd()
   @ 12, 57 SAY iif( zRODZ_DOK = 'D', 'ow&_o.d   ', 'aszport' )

   RETURN .T.

***************************************************
FUNCTION v3_133()

   R := .F.
   if zRODZ_DOK$'DP'
      ColStd()
      @ 12, 57 SAY iif( zRODZ_DOK = 'D', 'ow&_o.d   ', 'aszport' )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION v3_141()

   IF LastKey() == 5
      RETURN .T.
   ENDIF
   SAVE SCREEN TO scr2
   SELECT urzedy
   SEEK '+' + SubStr( zurzad, 1, 20 ) + SubStr( zurzad, 24 )
   IF del # '+' .OR. miejsc_us # SubStr( zurzad, 1, 20 ) .OR. urzad # SubStr( zurzad, 24 )
      SKIP -1
   ENDIF
   urzedy_()
   RESTORE SCREEN FROM scr2
   IF LastKey() == 13 .OR. LastKey() == 1006
      zurzad := miejsc_us + ' - ' + urzad
      SET COLOR TO i
      @ 18, 17 SAY zurzad
      SET COLOR TO
      pause( .5 )
   ENDIF
   SELECT prac

   RETURN .NOT. Empty( zurzad )

FUNCTION ValidPracOswiad26r()

   LOCAL R := .F.

   IF zOSWIAD26R $ 'NT'
      R := .T.
      SET COLOR TO w+
      @ 18, 77 SAY iif( zOSWIAD26R == 'T', 'ak', 'ie' )
      SET COLOR TO
   ENDIF

   RETURN R

***************************************************
FUNCTION rod()

   IF Empty( zNAZW_RODU )
      zNAZW_RODU := zNAZWISKO
   ENDIF

   RETURN .T.

***************************************************
//002 nowe funkcje
FUNCTION wyb_przel()

   IF Empty( zBANK ) .OR. Empty( zKONTO ) .OR. zKONTO = '  -        -'
      zJAKI_PRZEL := 'N'
      zKW_PRZELEW := 0
   ELSE
      @ 20, 61 SAY iif( zJAKI_PRZEL = 'K', 'wotowo:   ', iif( zJAKI_PRZEL = 'P', 'rocentowo:', 'ie przel. ' ) )
   ENDIF
   war_przel()
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: K - kwotowo, P - w procentach lub N - nie przelewa&_c', 80, ' ' )

   RETURN .T.

***************************************************
FUNCTION war_przel()

   IF zJAKI_PRZEL $ 'KPN'
      ColStd()
      @ 20, 61 SAY iif( zJAKI_PRZEL = 'K', 'wotowo:   ', iif( zJAKI_PRZEL = 'P', 'rocentowo:', 'ie przel. ' ) )
      @ 24,  0
      IF ( Empty( zBANK ) .OR. Empty( zKONTO ) ) .AND. ( zJAKI_PRZEL <> 'N' )
         Tone( 500, 4 )
         Tone( 500, 4 )
         ColErr()
         @24, 0 SAY PadC( 'Niekompletne dane banku. Musisz wybra&_c opcj&_e "N"', 80, ' ' )
         zJAKI_PRZEL := 'N'
         R := .F.
      ELSE
         R := .T.
      ENDIF
   ELSE
      zJAKI_PRZEL := 'N'
      R := .F.
   ENDIF

   RETURN R

***************************************************
FUNCTION wyl_przel()

   IF zJAKI_PRZEL = 'N'
      zKW_PRZELEW := 0
   ENDIF
   czysc()

   RETURN .T.

***************************************************
FUNCTION czysc()

   ColStd()
   @ 24, 0

   RETURN .T.

*############################################################################

/*----------------------------------------------------------------------*/

FUNCTION PracDokidrozWhen()

   LOCAL cKolorTmp

   cEkranTmp := SaveScreen( 13, 10, 20, 60 )
   cKolorTmp := ColInf()
   @ 13, 10 CLEAR TO 20, 60
   @ 13, 10, 20, 60 BOX B_SINGLE + Space( 1 )
   @ 14, 12 SAY '1 - NUMER IDENTYFIKACYJNY TIN'
   @ 15, 12 SAY '2 - NUMER UBEZPIECZENIOWY'
   @ 16, 12 SAY '3 - PASZPORT'
   @ 17, 12 SAY '4 - URZ¨DOWY DOKUMENT STWIERDZAJ¤CY TO½SAMO—'
   @ 18, 12 SAY '8 - INNY RODZAJ IDENTYFIKACJI PODATKOWEJ'
   @ 19, 12 SAY '9 - INNY DOKUMENT POTWIERDZAJ¤CY TO½SAMO—'
   SetColor( cKolorTmp )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION PracDokidrozValid()

   LOCAL lRes := zDOKIDROZ $ '123489 '
      IF lRes
         RestScreen( 13, 10, 20, 60, cEkranTmp )
         @ 21, 48 SAY ' - ' + SubStr( PadR( PracDokRodzajStr( zDOKIDROZ ), 28 ), 1, 28 )
      ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION PracDokRodzajStr( cRodzaj )

   LOCAL cRodzajDokIdStr

   IF ! HB_ISCHAR( cRodzaj ) .OR. Len( cRodzaj ) == 0
      RETURN ''
   ENDIF
   DO CASE
   CASE cRodzaj == '1'
      cRodzajDokIdStr := 'NUMER IDENTYFIKACYJNY TIN'
   CASE cRodzaj == '2'
      cRodzajDokIdStr := 'NUMER UBEZPIECZENIOWY'
   CASE cRodzaj == '3'
      cRodzajDokIdStr := 'PASZPORT'
   CASE cRodzaj == '4'
      cRodzajDokIdStr := 'URZ¨DOWY DOKUMENT STWIERDZAJ¤CY TO½SAMO—'
   CASE cRodzaj == '8'
      cRodzajDokIdStr := 'INNY RODZAJ IDENTYFIKACJI PODATKOWEJ'
   CASE cRodzaj == '9'
      cRodzajDokIdStr := 'INNY DOKUMENT POTWIERDZAJ¤CY TO½SAMO—'
   OTHERWISE
      cRodzajDokIdStr := ''
   ENDCASE

   RETURN cRodzajDokIdStr

/*----------------------------------------------------------------------*/

FUNCTION CzyPracowPonizej26R( nMiesiac, nRok )

   LOCAL lRes := .F.
   LOCAL nLata := nRok - Year( prac->data_ur )

   IF nLata <= 26
      IF nLata == 26
         IF nMiesiac <= Month( prac->data_ur )
            lRes := .T.
         ENDIF
      ELSE
         lRes := .T.
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

