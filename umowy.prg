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

PROCEDURE Umowy()

   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±Obsluga podstawowych operacji na bazie ......                             ±
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot

   zNAZWISKO := Space( 62 )
   zTYT := 'Z'
   @ 1, 47 SAY '          '

   *################################# GRAFIKA ##################################
   @  3, 0 SAY PadC( 'EWIDENCJA  INNYCH  UM&__O.W  i  INNYCH  &__X.R&__O.DE&__L.  PRZYCHOD&__O.W', 80 )
   @  4, 0 SAY '    Data    Numer   Termin      Data       Data                                 '
   @  5, 0 SAY '   umowy    umowy  wykonania  rachunku   wyp&_l.aty           Opis prac            '
   @  6, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
   @  7, 0 SAY '³          ³     ³          ³          ³          ³                            ³'
   @  8, 0 SAY '³          ³     ³          ³          ³          ³                            ³'
   @  9, 0 SAY '³          ³     ³          ³          ³          ³                            ³'
   @ 10, 0 SAY '³          ³     ³          ³          ³          ³                            ³'
   @ 11, 0 SAY '³          ³     ³          ³          ³          ³                            ³'
   @ 12, 0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
   @ 13, 0 SAY '³                                                                              ³'
   @ 14, 0 SAY '³ Opis...                                                                      ³'
   @ 15, 0 SAY '³ prac...                                                                      ³'
   //002a nowe pole
   @ 16, 0 say '³ Przychody opodatkowane =                 Z jakiego tytu&_l.u ?                  ³'
   @ 17, 0 say '³ Sk&_l.adki wykonawcy      =     %             Przych&_o.d netto=                   ³'
   @ 18, 0 say '³ Koszt uzyskania        =  %              Do opodatkowania=                   ³'
   @ 19, 0 say '³ Wyliczenie podatku     =     %                 DO WYP&__L.ATY=                   ³'
   @ 20, 0 say '³ Sk&_l.adki zleceniodawcy  =     %                 Fundusze  =     %             ³'
   @ 21, 0 say '³ Potr¥cenia po opodat.  =                                                     ³'
   @ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   SELECT 4
   DO WHILE .NOT. Dostep( 'FIRMA' )
   ENDDO
   SET INDEX TO firma
   GO Val( ident_fir )
   SELECT 3
   DO WHILE .NOT. Dostep( 'TAB_DOCH' )
   ENDDO
   SET INDEX TO tab_doch
   SELECT 2
   DO WHILE .NOT. Dostep( 'UMOWY' )
   ENDDO
   SetInd( 'UMOWY' )
   SET ORDER TO 2
   SEEK '+' + ident_fir
   SELECT 1
   DO WHILE .NOT. Dostep( 'PRAC' )
   ENDDO
   SetInd( 'PRAC' )
   SET ORDER TO 3
   SET FILTER TO prac->aktywny == 'T'
   SEEK '+' + ident_fir + '+'
   IF Eof() .OR. del # '+' .OR. firma # ident_fir .OR. status < 'U'
      kom( 3, '*u', ' Brak pracownik&_o.w pracuj&_a.cych na umowy ' )
      RETURN
   ENDIF
   SELECT umowy

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 7
   _col_l := 1
   _row_d := 11
   _col_p := 78
   _invers := [i]
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,13,247,22,48,77,109,7,46,28,82,114,85,117,87,119'
   _top := 'firma#ident_fir'
   _bot := "del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'say41()'
   _row := int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'say41s'
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
      kl := lastkey()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         IF ins
            ColStb()
            center( 23, 'þ                     þ' )
            ColSta()
            center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            center( 23, 'þ                       þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF

         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zIDENT := Space( 5 )
               zNUMER := Space( 8 )
               zDATA_UMOWY := CToD( '    .  .  ' )
               zTEMAT1 := Space( 70 )
               zTEMAT2 := Space( 70 )
               zTERMIN := CToD( '    .  .  ' )
               zDATA_RACH := CToD( '    .  .  ' )
               zDATA_WYP := CToD( '    .  .  ' )
               zNAZWISKO := Space( 62 )
               zSTAW_PODAT := parap_pod
               //002a nowa zmienna
               zTYT := ( 'Z' )
               zOSWIAD26R := 'N'
            ELSE
               zIDENT := IDENT
               zNUMER := NUMER
               zDATA_UMOWY := DATA_UMOWY
               zTEMAT1 := TEMAT1
               zTEMAT2 := TEMAT2
               zTERMIN := TERMIN
               zDATA_RACH := DATA_RACH
               zDATA_WYP := DATA_WYP
               zSTAW_PODAT := STAW_PODA2
               //002a i tu tez
               do case
               *  case TYTUL='0'
               *       zTYT='O' //organy stanowiace
               CASE TYTUL = '1'
                  zTYT := 'A' //aktywizacja
               CASE TYTUL = '2'
                  zTYT := 'C' //czlonkowstwo w spoldzielni
               CASE TYTUL = '3'
                  zTYT := 'E' //emerytury i renty zagraniczne
               CASE TYTUL = '4'
                  zTYT := 'F' //swiadczenia z funduszu pracy i GSP
               CASE TYTUL = '9'
                  zTYT := 'S' //obowiazki spoleczne
               CASE TYTUL = '6'
                  zTYT := 'P' //prawa autorskie
               CASE TYTUL = '7'
                  zTYT := 'I' //inne zrodla
               CASE TYTUL = '8'
                  zTYT := 'R' //kontrakty menadzerskie
               CASE TYTUL = '10'
                  zTYT := 'O'
               CASE TYTUL = '11'
                  zTYT := 'D' // umowa o dzielo
               OTHERWISE
                  zTYT := 'Z' //umowy zlecenia i o dzielo 5
               ENDCASE

               zOSWIAD26R := iif( OSWIAD26R = ' ', 'N', OSWIAD26R )

               SELECT prac
               SET ORDER TO 4
               SEEK Val( zident )
               SET ORDER TO 3
               zNAZWISKO := NAZWISKO+','+IMIE1+','+IMIE2
               SELECT umowy
            ENDIF

            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 1  GET zDATA_UMOWY
            @ wiersz, 12 GET zNUMER PICTURE "XXXXX"
            @ wiersz, 18 GET zTERMIN
            @ wiersz, 29 GET zDATA_RACH
            @ wiersz, 40 GET zDATA_WYP
            @ 13, 9 GET zNAZWISKO PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,XXXXXXXXXXXXXXX,XXXXXXXXXXXXXXX" valid v4_141()
            @ 14, 9 GET zTEMAT1   PICTURE Replicate( 'X', 70 )
            @ 15, 9 GET zTEMAT2   PICTURE Replicate( 'X', 70 )
            read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
            ENDIF
            BlokadaR()
            repl_( 'FIRMA', IDENT_FIR )
            repl_( 'IDENT', zIDENT )
            repl_( 'NUMER', zNUMER )
            repl_( 'DATA_UMOWY', zDATA_UMOWY )
            repl_( 'TEMAT1', zTEMAT1 )
            repl_( 'TEMAT2', zTEMAT2 )
            repl_( 'TERMIN', zTERMIN )
            repl_( 'DATA_RACH', zDATA_RACH )
            repl_( 'DATA_WYP', zDATA_WYP )
            repl_( 'STAW_PODA2', zSTAW_PODAT )

            DO CASE
            *case zTYT='O'
            *     zTYTUL:='0'
            CASE zTYT = 'A'
               zTYTUL := '1'
            CASE zTYT = 'C'
               zTYTUL := '2'
            CASE zTYT = 'E'
               zTYTUL := '3'
            CASE zTYT = 'F'
               zTYTUL := '4'
            CASE zTYT = 'S'
               zTYTUL := '9'
            CASE zTYT = 'P'
               zTYTUL := '6'
            CASE zTYT = 'I'
               zTYTUL := '7'
            CASE zTYT = 'R'
               zTYTUL := '8'
            CASE zTYT = 'O'
               zTYTUL := '10'
            CASE zTYT = 'D'
               zTYTUL := '11'
            OTHERWISE
               zTYTUL := '5' //<--= brak danych
            ENDCASE
            repl_( 'TYTUL', zTYTUL )
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               BREAK
            ENDIF
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '          ³     ³          ³          ³          ³                            '
         END
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
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
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0
      *################################### WYBOR POZYCJI ##########################
      CASE kl == 13
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         STORE 'A' TO zAKOSZT, ;
            zAPUZ, ;
            zAPUE, ;
            zAPUR, ;
            zAPUC, ;
            zAPUW, ;
            zAPFP, ;
            zAPFG, ;
            zAPF3, ;
            zAFUZ, ;
            zAFUE, ;
            zAFUR, ;
            zAFUC, ;
            zAFUW, ;
            zAFFP, ;
            zAFFG, ;
            zAFF3, ;
            zAPZK
         STORE 0 TO zBRUT_ZASAD, ;
            zKOSZT     , ;
            zKOSZTY    , ;
            zSTAW_PUE  , ;
            zSTAW_PUR  , ;
            zSTAW_PUC  , ;
            zSTAW_PSUM , ;
            zWAR_PUE   , ;
            zWAR_PUR   , ;
            zWAR_PUC   , ;
            zWAR_PSUM  , ;
            oWAR_PUE   , ;
            oWAR_PUR   , ;
            oWAR_PUC   , ;
            oWAR_PSUM  , ;
            zSTAW_PODAT, ;
            zSTAW_PUZ  , ;
            zSTAW_PZK  , ;
            zWAR_PUZ   , ;
            zWAR_PZK   , ;
            zWAR_PUZO  , ;
            oWAR_PUZ   , ;
            oWAR_PZK   , ;
            oWAR_PUZO  , ;
            zSTAW_FUE  , ;
            zSTAW_FUR  , ;
            zSTAW_FUW  , ;
            zSTAW_FFP  , ;
            zSTAW_FFG  , ;
            zSTAW_FSUM , ;
            zWAR_FUE   , ;
            zWAR_FUR   , ;
            zWAR_FUW   , ;
            zWAR_FFP   , ;
            zWAR_FFG   , ;
            zWAR_FSUM  , ;
            oWAR_FUE   , ;
            oWAR_FUR   , ;
            oWAR_FUW   , ;
            oWAR_FFP   , ;
            oWAR_FFG   , ;
            oWAR_FSUM  , ;
            zBRUT_RAZEM, ;
            zDOCHOD    , ;
            zDOCHODPOD , ;
            zPENSJA    , ;
            zPODATEK   , ;
            zNETTO     , ;
            zDO_WYPLATY, ;
            zUWAGI     , ;
            B5         , ;
            SKLADN     , ;
            zPOTRACENIA
            *zZAOPOD    ,;
            *zJAKZAO='Z'
         zTYTUL := TYTUL
         zOSWIAD26R := iif( OSWIAD26R = ' ', 'N', OSWIAD26R )

         DO CASE
         *case TYTUL='0'
         *zTYT='O' //organy stanowiace
         CASE TYTUL = '1'
            zTYT := 'A' //aktywizacja
         CASE TYTUL = '2'
            zTYT := 'C' //czlonkowstwo w spoldzielni
         CASE TYTUL = '3'
            zTYT := 'E' //emerytury i renty zagraniczne
         CASE TYTUL = '4'
            zTYT := 'F' //swiadczenia z funduszu pracy i GSP
         CASE TYTUL = '9'
            zTYT := 'S' //obowiazki spoleczne
         CASE TYTUL = '6'
            zTYT := 'P' //prawa autorskie
         CASE TYTUL = '7'
            zTYT := 'I' //inne zrodla
         CASE TYTUL = '8'
            zTYT := 'R' //kontrakty menadzerskie
         CASE TYTUL = '10'
            zTYT := 'O'
         CASE TYTUL = '11'
            zTYT := 'D'
         OTHERWISE
            zTYT := 'Z' //umowy zlecenia i o dzielo 5
         ENDCASE

         //002a 2 nowe linie-/\
         Podstawu()
         SAVE SCREEN TO scr_sklad
*     set curs on
*     @ 16,32 get zJAKZAO pict '!' when wJAKZAOu(16,33) valid vJAKZAOu(16,33)
*     read
*     set curs off
*     rest scre from scr_sklad
*     if lastkey()#27
*        if zJAKZAO='Z'
*           zZAOPOD=0
*        else
*           zZAOPOD=1
*        endif
*        oblplu()
*        do BLOKADAR
*        do zapiszplau
*        unlock
*        _infoskl_u()
*     endif

         DO WHILE .T.
            ColStd()
            @ 16,  1 PROMPT ' Przychody opodatkowane '
            //002a nowa linia
            @ 16, 42 PROMPT ' Z jakiego tytu&_l.u ?'
            @ 17,  1 PROMPT ' Sk&_l.adki wykonawcy      '
            @ 18,  1 PROMPT ' Koszt uzyskania        '
            @ 19,  1 PROMPT ' Wyliczenie podatku     '
            @ 20,  1 PROMPT ' Sk&_l.adki zleceniodawcy  '
            @ 21,  1 PROMPT ' Potr¥cenia po opodat.  '
            skladn := menu( skladn )
            ColStd()
            IF LastKey() == 27
               EXIT
            ENDIF
            podstawu()
            DO CASE
            CASE skladn == 1
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 16, 26 GET zBRUT_ZASAD PICTURE '999999.99' VALID oblplu()
               READ
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            CASE skladn == 2
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 16, 62 GET zTYT PICTURE '!' when jaki_tytul() VALID zTYT $ 'AZPICEFSROD'
               READ
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            CASE skladn == 3
               SAVE SCREEN TO scr_sklad
               SET CURSOR on
               @ 16, 25 CLEAR TO 22, 66
               @ 16, 25 TO 22, 66
               @ 17, 26 SAY 'SK&__L.ADKI    %stawki wart.obli. wart.odli.'
               @ 18, 26 SAY 'Emerytalna ' GET zSTAW_PUE PICTURE '99.99' VALID OBLPLu()
               @ 18, 45 GET oWAR_PUE PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 18, 55 GET zAPUE PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAPUE $ 'AR' .AND. vAUTOKOM()
               @ 18, 57 GET zWAR_PUE PICTURE '999999.99' WHEN oblplu()
               @ 19, 26 SAY 'Rentowa    ' GET zSTAW_PUR PICTURE '99.99' VALID OBLPLu()
               @ 19, 45 GET oWAR_PUR PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 19, 55 GET zAPUR PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAPUR $ 'AR' .AND. vAUTOKOM()
               @ 19, 57 GET zWAR_PUR PICTURE '999999.99' WHEN oblplu()
               @ 20, 26 SAY 'Chorobowa  ' GET zSTAW_PUC PICTURE '99.99' VALID OBLPLu()
               @ 20, 45 GET oWAR_PUC PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 20, 55 GET zAPUC PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAPUC $ 'AR' .AND. vAUTOKOM()
               @ 20, 57 GET zWAR_PUC PICTURE '999999.99' WHEN oblplu()
               @ 21, 26 SAY 'RAZEM      ' GET zSTAW_PSUM PICTURE '99.99' WHEN oblplu() .AND. .F.
               @ 21, 45 GET oWAR_PSUM PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 21, 57 GET zWAR_PSUM PICTURE '999999.99' WHEN oblplu() .AND. .F.
               READ
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            CASE skladn == 4
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 18, 26 GET zKOSZTY PICTURE '99' VALID oblplu()
               @ 18, 30 GET zAKOSZT PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAKOSZT $ 'AR' .AND. vAUTOKOM()
               @ 18, 33 GET zKOSZT PICTURE '999999.99' VALID oblplu()
               READ
               SET CURSOR OFF
               REST SCREEN FROM scr_sklad
            CASE skladn == 5
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 16, 25 CLEAR TO 22, 75
               @ 16, 25 TO 22, 75
               @ 17, 26 SAY 'O˜w. o zwol. od pod.<26 r.:' GET zOSWIAD26R PICTURE '!' WHEN CzyPracowPonizej26R( Month( Date() ), Year( Date() ) ) VALID zOSWIAD26R $ 'TN' .AND. oblplu()
               @ 18, 26 SAY 'Podatek stawka..........%.='
               @ 18, 45 GET zSTAW_PODAT PICTURE '99.99' VALID oblplu()
               @ 18, 66 GET B5          PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 19, 26 SAY 'Ubezp.zdrow. do ZUS.....%.='
               @ 19, 45 GET zSTAW_PUZ PICTURE '99.99' VALID oblplu()
               @ 19, 54 GET oWAR_PUZ  PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 19, 64 GET zAPUZ PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAPUZ $ 'AR' .AND. vAUTOKOM()
               @ 19, 66 GET zWAR_PUZ  PICTURE '999999.99' WHEN oblplu()
               @ 20, 26 SAY '             do odlicz..%.='
               @ 20, 45 GET zSTAW_PZK PICTURE '99.99' VALID oblplu()
               @ 20, 54 GET oWAR_PZK  PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 20, 64 GET zAPZK PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAPZK $ 'AR' .AND. vAUTOKOM()
               @ 20, 66 GET zWAR_PZK  PICTURE '999999.99' WHEN oblplu()
               @ 21, 26 SAY 'Podatek do zap&_l.aty........:'
               @ 21, 66 GET zPODATEK  PICTURE '999999.99' WHEN oblplu() .AND. .F.
               READ
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            CASE skladn == 6
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 13, 25 CLEAR TO 22, 66
               @ 13, 25 TO 22, 66
               @ 14, 26 SAY 'SK&__L.ADKI    %stawki wart.obli. wart.odli.'
               @ 15, 26 SAY 'Emerytalna ' GET zSTAW_FUE PICTURE '99.99' VALID OBLPLu()
               @ 15, 45 GET oWAR_FUE PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 15, 55 GET zAFUE PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAFUE $ 'AR' .AND. vAUTOKOM()
               @ 15, 57 GET zWAR_FUE PICTURE '999999.99' WHEN oblplu()
               @ 16, 26 SAY 'Rentowa    ' GET zSTAW_FUR PICTURE '99.99' VALID OBLPLu()
               @ 16, 45 GET oWAR_FUR PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 16, 55 GET zAFUR PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAFUR $ 'AR' .AND. vAUTOKOM()
               @ 16, 57 GET zWAR_FUR PICTURE '999999.99' WHEN oblplu()
               @ 17, 26 SAY 'Wypadkowa  ' GET zSTAW_FUW PICTURE '99.99' VALID OBLPLu()
               @ 17, 45 GET oWAR_FUW PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 17, 55 GET zAFUW PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAFUW $ 'AR' .AND. vAUTOKOM()
               @ 17, 57 GET zWAR_FUW PICTURE '999999.99' WHEN oblplu()
               @ 18, 26 SAY 'FUNDUSZE   %stawki wart.obli. wart.odli.'
               @ 19, 26 SAY 'Pracy      ' GET zSTAW_FFP PICTURE '99.99' VALID OBLPLu()
               @ 19, 45 GET oWAR_FFP PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 19, 55 GET zAFFP PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAFFP $ 'AR' .AND. vAUTOKOM()
               @ 19, 57 GET zWAR_FFP PICTURE '999999.99' WHEN oblplu()
               @ 20, 26 SAY 'G&__S.P        ' GET zSTAW_FFG PICTURE '99.99' VALID OBLPLu()
               @ 20, 45 GET oWAR_FFG PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 20, 55 GET zAFFG PICTURE '!' WHEN oblplu() .AND. wAUTOKOM() VALID zAFFG $ 'AR' .AND. vAUTOKOM()
               @ 20, 57 GET zWAR_FFG PICTURE '999999.99' WHEN oblplu()
               @ 21, 26 SAY 'RAZEM      ' GET zSTAW_FSUM PICTURE '99.99' WHEN oblplu() .AND. .F.
               @ 21, 45 GET oWAR_FSUM PICTURE '999999.99' WHEN oblplu() .AND. .F.
               @ 21, 57 GET zWAR_FSUM PICTURE '999999.99' WHEN oblplu() .AND. .F.
               read
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            CASE skladn == 7
               SAVE SCREEN TO scr_sklad
               SET CURSOR ON
               @ 21, 26 GET zPOTRACENIA PICTURE '999999.99' VALID oblplu()
               READ
               SET CURSOR OFF
               RESTORE SCREEN FROM scr_sklad
            ENDCASE
            //002a zmiana skladn z 2 na 3
            IF LastKey() # 27 .OR. skladn == 3
               oblplu()
               BlokadaR()
               ZapiszPLAU()
               COMMIT
               UNLOCK
            ENDIF
            _infoskl_u()
         ENDDO
         @ 16,  1 SAY ' Przychody opodatkowane '
         //002a nowa linia
         @ 16, 42 SAY ' Z jakiego tytu&_l.u ?'
         @ 17,  1 SAY ' Sk&_l.adki wykonawcy      '
         @ 18,  1 SAY ' Koszt uzyskania        '
         @ 19,  1 SAY ' Wyliczenie podatku     '
         @ 20,  1 SAY ' Sk&_l.adki zleceniodawcy  '
         @ 21,  1 SAY ' Potr¥cenia po opodat.  '
         RESTORE SCREEN FROM scr_
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         declare p[20]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  4 ] := '   [Enter].................zmiana wyliczonych kwot      '
         p[  5 ] := '   [Ins]...................dopisanie przychodu          '
         p[  6 ] := '   [M].....................modyfikacja przychodu        '
         p[  7 ] := '   [Del]...................kasowanie przychodu          '
         p[  8 ] := '   [U].....................drukowanie tytu&_l.u przychodu  '
         p[  9 ] := '   [R].....................drukowanie rachunku za prac&_e. '
         p[ 10 ] := '   [W].....................drukowanie dowodu wyp&_l.aty    '
         p[ 11 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 12 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO I
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
            keyboard Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      *############################## DRUK RACHUNKU ###############################
      CASE kl == 82 .OR. kl == 114
         wybzbior( 'RACH*.TXT' )
      *############################## DRUK UMOWA ##################################
      CASE kl == 85 .OR. kl == 117
         wybzbior( 'UMOW*.TXT' )
      *############################## DRUK WYPLATY ################################
      CASE kl == 87 .OR. kl == 119
         wybzbior( 'WYPL*.TXT' )
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN

*****************************************************************************
PROCEDURE TRANTEK()
*****************************************************************************
   //set cons off
   //set device to print
   //set print on
   TEKSTDR := StrTran( TEKSTDR, '@DZISIAJ', DToC( DATE() ) )
   TEKSTDR := StrTran( TEKSTDR, '#DZISIAJ', DToC( DATE() ) )
   SELECT prac
   TEKSTDR := StrTran( TEKSTDR, '@NAZWISKO', NAZWISKO )
   TEKSTDR := StrTran( TEKSTDR, '#NAZWISKO', AllTrim( NAZWISKO ) )
   TEKSTDR := StrTran( TEKSTDR, '@IMIE1', IMIE1 )
   TEKSTDR := StrTran( TEKSTDR, '#IMIE1', AllTrim( IMIE1 ) )
   TEKSTDR := StrTran( TEKSTDR, '@IMIE2', IMIE2 )
   TEKSTDR := StrTran( TEKSTDR, '#IMIE2', AllTrim( IMIE2 ) )
   TEKSTDR := StrTran( TEKSTDR, '@IMIE_O', IMIE_O )
   TEKSTDR := StrTran( TEKSTDR, '#IMIE_O', AllTrim( IMIE_O ) )
   TEKSTDR := StrTran( TEKSTDR, '@IMIE_M', IMIE_M )
   TEKSTDR := StrTran( TEKSTDR, '#IMIE_M', AllTrim( IMIE_M ) )
   TEKSTDR := StrTran( TEKSTDR, '@MIEJSC_UR', MIEJSC_UR )
   TEKSTDR := StrTran( TEKSTDR, '#MIEJSC_UR', AllTrim( MIEJSC_UR ) )
   TEKSTDR := StrTran( TEKSTDR, '@DATA_UR', DToC( DATA_UR ) )
   TEKSTDR := StrTran( TEKSTDR, '#DATA_UR', DToC( DATA_UR ) )
   TEKSTDR := StrTran( TEKSTDR, '@ZATR', ZATRUD )
   TEKSTDR := StrTran( TEKSTDR, '#ZATR', AllTrim( ZATRUD ) )
   TEKSTDR := StrTran( TEKSTDR, '@PESEL', PESEL )
   TEKSTDR := StrTran( TEKSTDR, '#PESEL', AllTrim( PESEL ) )
   TEKSTDR := StrTran( TEKSTDR, '@NIP', NIP )
   TEKSTDR := StrTran( TEKSTDR, '#NIP', AllTrim( NIP ) )
   TEKSTDR := StrTran( TEKSTDR, '@MIEJSC_ZAM', MIEJSC_ZAM )
   TEKSTDR := StrTran( TEKSTDR, '#MIEJSC_ZAM', AllTrim( MIEJSC_ZAM ) )
   TEKSTDR := StrTran( TEKSTDR, '@KOD', KOD_POCZT )
   TEKSTDR := StrTran( TEKSTDR, '#KOD', AllTrim( KOD_POCZT ) )
   TEKSTDR := StrTran( TEKSTDR, '@GMINA', GMINA )
   TEKSTDR := StrTran( TEKSTDR, '#GMINA', AllTrim( GMINA ) )
   TEKSTDR := StrTran( TEKSTDR, '@ULICA', ULICA )
   TEKSTDR := StrTran( TEKSTDR, '#ULICA', AllTrim( ULICA ) )
   TEKSTDR := StrTran( TEKSTDR, '@DOM', NR_DOMU )
   TEKSTDR := StrTran( TEKSTDR, '#DOM', AllTrim( NR_DOMU ) )
   TEKSTDR := StrTran( TEKSTDR, '@LOKAL', NR_MIESZK )
   TEKSTDR := StrTran( TEKSTDR, '#LOKAL', AllTrim( NR_MIESZK ) )
   TEKSTDR := StrTran( TEKSTDR, '@DOWOD', DOWOD_OSOB )
   TEKSTDR := StrTran( TEKSTDR, '#DOWOD', AllTrim( DOWOD_OSOB ) )
   SELECT firma
   TEKSTDR := StrTran( TEKSTDR, '@FIRMA', NAZWA )
   TEKSTDR := StrTran( TEKSTDR, '#FIRMA', AllTrim( NAZWA ) )
   TEKSTDR := StrTran( TEKSTDR, '@UL_FIRMY', ULICA + ' ' + NR_DOMU + '/' + NR_MIESZK )
   TEKSTDR := StrTran( TEKSTDR, '#UL_FIRMY', AllTrim( ULICA ) + ' ' + AllTrim( NR_DOMU ) + '/' + AllTrim( NR_MIESZK ) )
   TEKSTDR := StrTran( TEKSTDR, '@ADR_FIRMY', MIEJSC )
   TEKSTDR := StrTran( TEKSTDR, '#ADR_FIRMY', AllTrim( MIEJSC ) )
   SELECT umowy
   TEKSTDR := StrTran( TEKSTDR, '@UMOWA', NUMER )
   TEKSTDR := StrTran( TEKSTDR, '#UMOWA', AllTrim( NUMER ) )
   TEKSTDR := StrTran( TEKSTDR, '@DATA_UM', DToC( DATA_UMOWY ) )
   TEKSTDR := StrTran( TEKSTDR, '#DATA_UM', DToC( DATA_UMOWY ) )
   TEKSTDR := StrTran( TEKSTDR, '@DATA_WYP', DToC( DATA_WYP ) )
   TEKSTDR := StrTran( TEKSTDR, '#DATA_WYP', DToC( DATA_WYP ) )
   TEKSTDR := StrTran( TEKSTDR, '@DATA_RA', DToC( DATA_RACH ) )
   TEKSTDR := StrTran( TEKSTDR, '#DATA_RA', DToC( DATA_RACH ) )
   TEKSTDR := StrTran( TEKSTDR, '@BRUTTO', kwota( BRUT_RAZEM, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#BRUTTO', AllTrim( kwota( BRUT_RAZEM, 11, 2 ) ) )
   WW1 := slownie( BRUT_RAZEM )
   TEKSTDR := StrTran( TEKSTDR, '@BSLOW', WW1 )
   TEKSTDR := StrTran( TEKSTDR, '#BSLOW', WW1 )
   TEKSTDR := StrTran( TEKSTDR, '@%KOSZT', Str( KOSZTY, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#%KOSZT', AllTrim( Str( KOSZTY, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@KOSZT', kwota( KOSZT, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#KOSZT', AllTrim( kwota( KOSZT, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@DOCHOD', kwota( DOCHOD, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#DOCHOD', AllTrim( kwota( DOCHOD, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@%PODATEK', Str( STAW_PODA2, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#%PODATEK', AllTrim( Str( STAW_PODA2, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@PODATEK', kwota( PODATEK, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#PODATEK', AllTrim( kwota( PODATEK, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@NETTO', kwota( DO_WYPLATY, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#NETTO', AllTrim( kwota( DO_WYPLATY, 11, 2 ) ) )
   WW5 := slownie( DO_WYPLATY )
   TEKSTDR := StrTran( TEKSTDR, '@NSLOW', WW5 )
   TEKSTDR := StrTran( TEKSTDR, '#NSLOW', AllTrim( WW5 ) )
   TEKSTDR := StrTran( TEKSTDR, '@TEMAT1', TEMAT1 )
   TEKSTDR := StrTran( TEKSTDR, '#TEMAT1', AllTrim( TEMAT1 ) )
   TEKSTDR := StrTran( TEKSTDR, '@TEMAT2', TEMAT2 )
   TEKSTDR := StrTran( TEKSTDR, '#TEMAT2', AllTrim( TEMAT2 ) )
   TEKSTDR := StrTran( TEKSTDR, '@TERMIN', DToC( TERMIN ) )
   TEKSTDR := StrTran( TEKSTDR, '#TERMIN', DToC( TERMIN ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PUE', kwota( STAW_PUE, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PUE', AllTrim( kwota( STAW_PUE, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PUR', kwota( STAW_PUR, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PUR', AllTrim( kwota( STAW_PUR, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PUC', kwota( STAW_PUC, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PUC', AllTrim( kwota( STAW_PUC, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PSUM', kwota( STAW_PSUM, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PSUM', AllTrim( kwota( STAW_PSUM, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PUW', kwota( STAW_PUW, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PUW', AllTrim( kwota( STAW_PUW, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PUZ', kwota( STAW_PUZ, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PUZ', AllTrim( kwota( STAW_PUZ, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_PZK', kwota( STAW_PZK, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_PZK', AllTrim( kwota( STAW_PZK, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FUE', kwota( STAW_FUE, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FUE', AllTrim( kwota( STAW_FUE, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FUR', kwota( STAW_FUR, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FUR', AllTrim( kwota( STAW_FUR, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FUC', kwota( STAW_FUC, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FUC', AllTrim( kwota( STAW_FUC, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FUW', kwota( STAW_FUW, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FUW', AllTrim( kwota( STAW_FUW, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FUZ', kwota( STAW_FUZ, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FUZ', AllTrim( kwota( STAW_FUZ, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FSUM', kwota( STAW_FSUM, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FSUM', AllTrim( kwota( STAW_FSUM, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PUE', kwota( WAR_PUE, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PUE', AllTrim( kwota( WAR_PUE, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PUR', kwota( WAR_PUR, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PUR', AllTrim( kwota( WAR_PUR, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PUC', kwota( WAR_PUC, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PUC', AllTrim( kwota( WAR_PUC, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PSUM', kwota( WAR_PSUM, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PSUM', AllTrim( kwota( WAR_PSUM, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PUW', kwota( WAR_PUW, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PUW', AllTrim( kwota( WAR_PUW, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PUZ', kwota( WAR_PUZ, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PUZ', AllTrim( kwota( WAR_PUZ, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_PZK', kwota( WAR_PZK, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_PZK', AllTrim( kwota( WAR_PZK, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FUE', kwota( WAR_FUE, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FUE', AllTrim( kwota( WAR_FUE, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FUR', kwota( WAR_FUR, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FUR', AllTrim( kwota( WAR_FUR, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FUC', kwota( WAR_FUC, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FUC', AllTrim( kwota( WAR_FUC, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FUW', kwota( WAR_FUW, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FUW', AllTrim( kwota( WAR_FUW, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FUZ', kwota( WAR_FUZ, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FUZ', AllTrim( kwota( WAR_FUZ, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FSUM', kwota( WAR_FSUM, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FSUM', AllTrim( kwota( WAR_FSUM, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FFP', kwota( STAW_FFP, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FFP', AllTrim( kwota( STAW_FFP, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@STAW_FFG', kwota( STAW_FFG, 5, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#STAW_FFG', AllTrim( kwota( STAW_FFG, 5, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FFP', kwota( WAR_FFP, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FFP', AllTrim( kwota( WAR_FFP, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@WAR_FFG', kwota( WAR_FFG, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#WAR_FFG', AllTrim( kwota( WAR_FFG, 11, 2 ) ) )
   TEKSTDR := StrTran( TEKSTDR, '@POTRACENIA', kwota( POTRACENIA, 11, 2 ) )
   TEKSTDR := StrTran( TEKSTDR, '#POTRACENIA', AllTrim( kwota( POTRACENIA, 11, 2 ) ) )
   //?tekstdr
   //ejec
   //set print off
   //set device to scre
   //set cons on
   DrukujNowyProfil( TEKSTDR )

   RETURN NIL

*################################## FUNKCJE #################################
FUNCTION say41()
   RETURN DToC( DATA_UMOWY ) + '³' + NUMER + '³' + DToC( TERMIN ) + '³' + DToC( DATA_RACH ) + '³' + DToC( DATA_WYP ) + '³' + SubStr( TEMAT1, 1, 28 )

*############################################################################
PROCEDURE say41s()

   CLEAR TYPE
   SET COLOR TO +w
   SELECT prac
   SET ORDER TO 4
   SEEK Val( umowy->ident )
   SET ORDER TO 3
   znazwisko := nazwisko + ',' + imie1 + ',' + imie2
   SELECT umowy
   @ 13, 9 SAY zNAZWISKO
   @ 14, 9 SAY TEMAT1
   @ 15, 9 SAY TEMAT2
   _infoskl_u()
   SET COLOR TO
   RETURN

***************************************************
FUNCTION v4_141()

   IF LastKey() == 5
      RETURN .F.
   ENDIF
   SAVE SCREEN TO scr2
   SELECT prac
   SET ORDER TO 1
   SEEK '+' + ident_fir + SubStr( znazwisko, 1, 30 ) + SubStr( znazwisko, 32, 15 ) + SubStr( znazwisko, 48 )
   IF del # '+' .OR. ident_fir # umowy->firma .OR. nazwisko # SubStr( znazwisko, 1, 30 ) .OR. imie1 # SubStr( znazwisko, 32, 15 ) .OR. imie2 # SubStr( znazwisko, 48 )
      SET ORDER TO 3
      SEEK '+' + ident_fir + '+'
      IF .NOT. Found()
         RESTORE SCREEN FROM scr2
         SELECT umowy
         RETURN .F.
      ENDIF
   ENDIF
   SET ORDER TO 3
   prac_()
   RESTORE SCREEN FROM scr2
   IF LastKey() == 13
      znazwisko := nazwisko + ',' + imie1 + ',' + imie2
      IF ! Empty( zDATA_WYP )
         zOSWIAD26R := iif( CzyPracowPonizej26R( Month( zDATA_WYP ), Year( zDATA_WYP ) ) .AND. OSWIAD26R == 'T', 'T', 'N' )
      ENDIF
      SET COLOR TO i
      @ 14, 9 SAY znazwisko
      SET COLOR TO
      pause( .5 )
   ENDIF
   SELECT umowy
   RETURN .NOT. Empty( znazwisko )

***************************************************
PROCEDURE WYBZBIOR( SKRYPT )
***************************************************

   SAVE SCREEN TO WYSKR
   _ilm := ADir( SKRYPT )
   declare a[ _ilm ]
   ADir( SKRYPT, a )
   ASort( a )
   ZZ := 0
   IF _ilm > 21
      _ilm := 21
   ENDIF
   CURR := ColPro()
   @ 21 - _ilm, 0 TO 22, 13
   ZZ := AChoice( 21 - ( _ilm - 1 ), 1, 21, 12, a, .T., .T., ZZ )
   IF ZZ <> 0
      TEKSTDR := MemoRead( AllTrim( a[ZZ] ) )
      TRANTEK()
   ENDIF
   SetColor( CURR )
   RESTORE SCREEN FROM WYSKR

   RETURN

*############################################################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± _infoskl_u  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o skladnikach placowych                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION _infoskl_u()

   CURR := ColStd()
   SET COLOR TO w+
   *@ 16,32 say iif(ZAOPOD=1,'Dziesiec groszy','Zlotowka       ')
   @ 16, 26 SAY BRUT_ZASAD PICTURE '999999.99'
   //002a nowe linie
   DO CASE
    *     case TYTUL='0'
    *          zTYT='O' //organy stanowiace
   CASE TYTUL = '1'
      zTYT := 'A' //aktywizacja
   CASE TYTUL = '2'
      zTYT := 'C' //czlonkowstwo w spoldzielni
   CASE TYTUL = '3'
      zTYT := 'E' //emerytury i renty zagraniczne
   CASE TYTUL = '4'
      zTYT := 'F' //swiadczenia z funduszu pracy i GSP
   CASE TYTUL = '9'
      zTYT := 'S' //obowiazki spoleczne
   CASE TYTUL = '6'
      zTYT := 'P' //prawa autorskie
   CASE TYTUL = '7'
      zTYT := 'I' //inne zrodla
   CASE TYTUL = '8'
      zTYT := 'R' //kontrakty menadzerskie
   CASE TYTUL = '10'
      zTYT := 'O'
   CASE TYTUL = '11'
      zTYT := 'D'
   OTHERWISE
      zTYT := 'Z' //umowy zlecenia i o dzielo 5
   ENDCASE

   @ 16, 62 SAY zTYT + iif( zTYT = 'I', 'nne             ', ;
      iif( zTYT = 'A', 'ktywizacja umowa', ;
      iif( zTYT = 'C', 'zlonkow.spoldzi.', ;
      iif( zTYT = 'E', 'meryt.i ren.zagr', ;
      iif( zTYT = 'F', 'P i FGSP wyplaty', ;
      iif( zTYT = 'S', 'polecz.obowiazki', ;
      iif( zTYT = 'P', 'rawo autorskie  ', ;
      iif( zTYT = 'R', 'yczalt do 200zl ', ;
      iif( zTYT = 'O', 'bcokrajowiec    ', ;
      iif( zTYT = 'D', 'zieˆa           ', ;
      'lecenia         '))))))))))
   //002a do tad
   @ 17, 26 SAY STAW_PSUM PICTURE '99.99'
   @ 17, 33 SAY WAR_PSUM PICTURE '999999.99'
   @ 17, 60 SAY BRUT_ZASAD-WAR_PSUM PICTURE '999999.99'
   @ 18, 26 SAY KOSZTY PICTURE '99'
   @ 18, 30 SAY AKOSZT PICTURE '!'
   @ 18, 33 SAY KOSZT PICTURE '999999.99'
   @ 18, 60 SAY DOCHOD PICTURE '999999.99'
   @ 19, 26 SAY STAW_PODA2 PICTURE "99.99"
   @ 19, 33 SAY PODATEK PICTURE "999999.99"
   @ 19, 60 SAY DO_WYPLATY PICTURE "999999.99"
   @ 20, 26 SAY STAW_FUE + STAW_FUR + STAW_FUW PICTURE '99.99'
   @ 20, 33 SAY WAR_FUE + WAR_FUR + WAR_FUW PICTURE '999999.99'
   @ 20, 60 SAY STAW_FFP + STAW_FFG PICTURE '99.99'
   @ 20, 67 SAY WAR_FFP + WAR_FFG PICTURE '999999.99'
   @ 21, 26 SAY POTRACENIA PICTURE '999999.99'
   SetColor( CURR )

   RETURN

*############################################################################
FUNCTION oblplu()

   IF zTYT = 'R' .OR. zTYT == 'O'
      zPENSJA := zBRUT_ZASAD
      zBRUT_RAZEM := zPENSJA
      oWAR_PUE := _round( zPENSJA * ( zSTAW_PUE / 100 ), 2 )
      oWAR_PUR := _round( zPENSJA * ( zSTAW_PUR / 100 ), 2 )
      oWAR_PUC := _round( zPENSJA * ( zSTAW_PUC / 100 ), 2 )
      oWAR_PSUM := oWAR_PUE + oWAR_PUR + oWAR_PUC
      IF zAPUE # 'R'
         zWAR_PUE := _round( zPENSJA * ( zSTAW_PUE / 100 ), 2 )
      ENDIF
      IF zAPUR # 'R'
         zWAR_PUR := _round( zPENSJA * ( zSTAW_PUR / 100 ), 2 )
      ENDIF
      IF zAPUC # 'R'
         zWAR_PUC := _round( zPENSJA * ( zSTAW_PUC / 100 ), 2 )
      ENDIF
      zWAR_PSUM := zWAR_PUE + zWAR_PUR + zWAR_PUC
      IF zAKOSZT # 'R'
         zKOSZT := _round( ( zBRUT_ZASAD - zWAR_PSUM ) * ( zKOSZTY / 100 ), 2 )
      ENDIF
      zDOCHOD := zBRUT_RAZEM
      zDOCHODPOD := _round( zDOCHOD, 0 )
      B5 := _round( zBRUT_RAZEM*( zSTAW_PODAT / 100 ), 0 )
      oWAR_PZK := min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 ) )
      oWAR_PUZ := min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 ) )
      IF zAPUZ # 'R'
         zWAR_PUZ := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 ) )
      ENDIF
      IF zAPZK # 'R'
         zWAR_PZK := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 ) )
      ENDIF
      zWAR_PUZO := zWAR_PZK
      zPODATEK := _round( zBRUT_RAZEM * ( zSTAW_PODAT / 100 ), 0 )
      zNETTO := zBRUT_RAZEM - ( zPODATEK + zWAR_PSUM + zWAR_PUZ )
      zDO_WYPLATY := zNETTO - zPOTRACENIA
      oWAR_FUE := _round( zPENSJA * ( zSTAW_FUE / 100 ), 2 )
      oWAR_FUR := _round( zPENSJA * ( zSTAW_FUR / 100 ), 2 )
      oWAR_FUW := _round( zPENSJA * ( zSTAW_FUW / 100 ), 2 )
      oWAR_FFP := _round( zPENSJA * ( zSTAW_FFP / 100 ), 2 )
      oWAR_FFG := _round( zPENSJA * ( zSTAW_FFG / 100 ), 2 )
      oWAR_FSUM := oWAR_FUE + oWAR_FUR + oWAR_FUW + oWAR_FFP + oWAR_FFG
      IF zAFUE # 'R'
         zWAR_FUE := _round( zPENSJA * ( zSTAW_FUE / 100 ), 2 )
      ENDIF
      IF zAFUR # 'R'
         zWAR_FUR := _round( zPENSJA * ( zSTAW_FUR / 100 ), 2 )
      ENDIF
      IF zAFUW # 'R'
         zWAR_FUW := _round( zPENSJA * ( zSTAW_FUW / 100 ), 2 )
      ENDIF
      IF zAFFP # 'R'
         zWAR_FFP := _round( zPENSJA * ( zSTAW_FFP / 100 ), 2 )
      ENDIF
      IF zAFFG # 'R'
         zWAR_FFG := _round( zPENSJA * ( zSTAW_FFG / 100 ), 2 )
      ENDIF
      zWAR_FSUM := zWAR_FUE + zWAR_FUR + zWAR_FUW + zWAR_FFP + zWAR_FFG
      zSTAW_FSUM := zSTAW_FUE + zSTAW_FUR + zSTAW_FUW + zSTAW_FFP + zSTAW_FFG
      zSTAW_PSUM := zSTAW_PUE + zSTAW_PUR + zSTAW_PUC
   ELSE
      zPENSJA := zBRUT_ZASAD
      zBRUT_RAZEM := zPENSJA
      oWAR_PUE := _round( zPENSJA * ( zSTAW_PUE / 100 ), 2 )
      oWAR_PUR := _round( zPENSJA * ( zSTAW_PUR / 100 ), 2 )
      oWAR_PUC := _round( zPENSJA * ( zSTAW_PUC / 100 ), 2 )
      oWAR_PSUM := oWAR_PUE + oWAR_PUR + oWAR_PUC
      IF zAPUE # 'R'
         zWAR_PUE := _round( zPENSJA * ( zSTAW_PUE / 100 ), 2 )
      ENDIF
      IF zAPUR # 'R'
         zWAR_PUR := _round( zPENSJA * ( zSTAW_PUR / 100 ), 2 )
      ENDIF
      IF zAPUC # 'R'
         zWAR_PUC := _round( zPENSJA * ( zSTAW_PUC / 100 ), 2 )
      ENDIF
      zWAR_PSUM := zWAR_PUE + zWAR_PUR + zWAR_PUC
      IF zAKOSZT # 'R'
         zKOSZT := _round( ( zBRUT_ZASAD - zWAR_PSUM ) * ( zKOSZTY / 100 ), 2 )
      ENDIF
      zDOCHOD := Max( 0, zBRUT_RAZEM - ( zKOSZT + zWAR_PSUM ) )
      zDOCHODPOD := _round( zDOCHOD, 0 )
      IF zOSWIAD26R = 'T'
         B5 := 0.0
         oWAR_PUZ := _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 )
         oWAR_PZK := _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 )
         IF zAPUZ # 'R'
            zWAR_PUZ := _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 )
         ENDIF
         IF zAPZK # 'R'
            zWAR_PZK := _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 )
         ENDIF
         zWAR_PUZO := zWAR_PZK
         zPODATEK := 0.0
         zSTAW_PODAT := 0.0
      ELSE
         B5 := zDOCHODPOD * ( zSTAW_PODAT / 100 )
         oWAR_PUZ := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 ) )
         oWAR_PZK := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 ) )
         IF zAPUZ # 'R'
            zWAR_PUZ := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PUZ / 100 ), 2 ) )
         ENDIF
         IF zAPZK # 'R'
            zWAR_PZK := Min( B5, _round( ( zBRUT_RAZEM - zWAR_PSUM ) * ( zSTAW_PZK / 100 ), 2 ) )
         ENDIF
         zWAR_PUZO := zWAR_PZK
         zPODATEK := Max( 0, _round( B5 - zWAR_PZK, 0 ) )
      ENDIF
      zNETTO := zBRUT_RAZEM - ( zPODATEK + zWAR_PSUM + zWAR_PUZ )
      zDO_WYPLATY := zNETTO - zPOTRACENIA
      oWAR_FUE := _round( zPENSJA * ( zSTAW_FUE / 100 ), 2 )
      oWAR_FUR := _round( zPENSJA * ( zSTAW_FUR / 100 ), 2 )
      oWAR_FUW := _round( zPENSJA * ( zSTAW_FUW / 100 ), 2 )
      oWAR_FFP := _round( zPENSJA * ( zSTAW_FFP / 100 ), 2 )
      oWAR_FFG := _round( zPENSJA * ( zSTAW_FFG / 100 ), 2 )
      oWAR_FSUM := oWAR_FUE + oWAR_FUR + oWAR_FUW + oWAR_FFP + oWAR_FFG
      IF zAFUE # 'R'
         zWAR_FUE := _round( zPENSJA * ( zSTAW_FUE / 100 ), 2 )
      ENDIF
      IF zAFUR # 'R'
         zWAR_FUR := _round( zPENSJA * ( zSTAW_FUR / 100 ), 2 )
      ENDIF
      IF zAFUW # 'R'
         zWAR_FUW := _round( zPENSJA * ( zSTAW_FUW / 100 ), 2 )
      ENDIF
      IF zAFFP # 'R'
         zWAR_FFP := _round( zPENSJA * ( zSTAW_FFP / 100 ), 2 )
      ENDIF
      IF zAFFG # 'R'
         zWAR_FFG := _round( zPENSJA * ( zSTAW_FFG / 100 ), 2 )
      ENDIF
      zWAR_FSUM := zWAR_FUE + zWAR_FUR + zWAR_FUW + zWAR_FFP + zWAR_FFG
      zSTAW_FSUM := zSTAW_FUE + zSTAW_FUR + zSTAW_FUW + zSTAW_FFP + zSTAW_FFG
      zSTAW_PSUM := zSTAW_PUE + zSTAW_PUR + zSTAW_PUC
   ENDIF
   RETURN .T.

***************************************************************************
PROCEDURE PODSTAWu()
***************************************************************************
   zAKOSZT := AKOSZT
   zAPUZ := APUZ
   zAPUE := APUE
   zAPUR := APUR
   zAPUC := APUC
   zAPUW := APUW
   zAPFP := APFP
   zAPFG := APFG
   zAPF3 := APF3
   zAFUZ := AFUZ
   zAFUE := AFUE
   zAFUR := AFUR
   zAFUC := AFUC
   zAFUW := AFUW
   zAFFP := AFFP
   zAFFG := AFFG
   zAFF3 := AFF3
   zAPZK := APZK

   zBRUT_ZASAD := BRUT_ZASAD

   zKOSZT := KOSZT
   zKOSZTY := KOSZTY

   zSTAW_PUE := STAW_PUE
   zSTAW_PUR := STAW_PUR
   zSTAW_PUC := STAW_PUC
   zSTAW_PSUM := STAW_PSUM
   zWAR_PUE := WAR_PUE
   zWAR_PUR := WAR_PUR
   zWAR_PUC := WAR_PUC
   zWAR_PSUM := WAR_PSUM

   zSTAW_PODAT := STAW_PODA2
   zSTAW_PUZ := STAW_PUZ
   zWAR_PUZ := WAR_PUZ
   zSTAW_PZK := STAW_PZK
   zWAR_PZK := WAR_PZK
   zWAR_PUZO := WAR_PUZO

   zSTAW_FUE := STAW_FUE
   zSTAW_FUR := STAW_FUR
   zSTAW_FUW := STAW_FUW
   zSTAW_FFP := STAW_FFP
   zSTAW_FFG := STAW_FFG
   zSTAW_FSUM := STAW_FSUM
   zWAR_FUE := WAR_FUE
   zWAR_FUR := WAR_FUR
   zWAR_FUW := WAR_FUW
   zWAR_FFP := WAR_FFP
   zWAR_FFG := WAR_FFG
   zWAR_FSUM := WAR_FSUM

   zBRUT_RAZEM := BRUT_RAZEM
   zDOCHOD := DOCHOD
   zDOCHODPOD := DOCHODPOD
   *zZAOPOD := ZAOPOD
   *zJAKZAO := iif(zZAOPOD=1,'D','Z')
   zPENSJA := PENSJA
   zPODATEK := PODATEK
   zNETTO := NETTO
   zDO_WYPLATY := DO_WYPLATY

   B5 := zDOCHODPOD*(zSTAW_PODAT/100)
   //002a nowa linia

   DO CASE
   *case TYTUL='0'
   *     zTYT='O' //organy stanowiace
   CASE TYTUL = '1'
      zTYT := 'A' //aktywizacja
   CASE TYTUL = '2'
      zTYT := 'C' //czlonkowstwo w spoldzielni
   CASE TYTUL = '3'
      zTYT := 'E' //emerytury i renty zagraniczne
   CASE TYTUL = '4'
      zTYT := 'F' //swiadczenia z funduszu pracy i GSP
   CASE TYTUL = '9'
      zTYT := 'S' //obowiazki spoleczne

   CASE TYTUL = '6'
      zTYT := 'P' //prawa autorskie
   CASE TYTUL = '7'
      zTYT := 'I' //inne zrodla
   CASE TYTUL = '8'
      zTYT := 'R' //kontrakty menadzerskie
   CASE TYTUL = '10'
      zTYT := 'O'
   CASE TYTUL = '11'
      zTYT := 'D'
   OTHERWISE
      zTYT := 'Z' //umowy zlecenia i o dzielo 5
   ENDCASE

   zTYTUL := TYTUL

   zOSWIAD26R := iif( OSWIAD26R = ' ', 'N', OSWIAD26R )

   zPOTRACENIA := POTRACENIA

   RETURN

***************************************************************************
PROCEDURE ZAPISZPLAu()
***************************************************************************
   repl_( 'AKOSZT', zAKOSZT )
   repl_( 'APUZ', zAPUZ )
   repl_( 'APUE', zAPUE )
   repl_( 'APUR', zAPUR )
   repl_( 'APUC', zAPUC )
   repl_( 'APUW', zAPUW )
   repl_( 'APFP', zAPFP )
   repl_( 'APFG', zAPFG )
   repl_( 'APF3', zAPF3 )
   repl_( 'AFUZ', zAFUZ )
   repl_( 'AFUE', zAFUE )
   repl_( 'AFUR', zAFUR )
   repl_( 'AFUC', zAFUC )
   repl_( 'AFUW', zAFUW )
   repl_( 'AFFP', zAFFP )
   repl_( 'AFFG', zAFFG )
   repl_( 'AFF3', zAFF3 )
   repl_( 'APZK', zAPZK )

   repl_( 'BRUT_ZASAD', zBRUT_ZASAD )
   repl_( 'KOSZT',      zKOSZT      )
   repl_( 'KOSZTY',     zKOSZTY     )
   repl_( 'STAW_PUE',   zSTAW_PUE   )
   repl_( 'STAW_PUr',   zSTAW_PUr   )
   repl_( 'STAW_PUc',   zSTAW_PUc   )
   repl_( 'STAW_PSUM',  zSTAW_PSUM  )
   repl_( 'WAR_pUE',    zWAR_pUE   )
   repl_( 'WAR_pUr',    zWAR_pUr   )
   repl_( 'WAR_pUc',    zWAR_pUc   )
   repl_( 'WAR_psum',   zWAR_psum  )
   repl_( 'STAW_PODA2', zSTAW_PODAT )
   repl_( 'STAW_PUz',   zSTAW_PUz   )
   repl_( 'WAR_pUz',    zWAR_pUz   )
   repl_( 'STAW_Pzk',   zSTAW_Pzk  )
   repl_( 'WAR_pzk',    zWAR_pzk  )
   repl_( 'WAR_pUzO',   zWAR_pUzO )
   repl_( 'STAW_fUE',   zSTAW_fUE  )
   repl_( 'STAW_fUr',   zSTAW_fUr  )
   repl_( 'STAW_fUw',   zSTAW_fUw  )
   repl_( 'STAW_ffp',   zSTAW_ffp  )
   repl_( 'STAW_ffg',   zSTAW_ffg  )
   repl_( 'STAW_fsum',  zSTAW_fsum )
   repl_( 'WAR_fUE',    zWAR_fUE  )
   repl_( 'WAR_fUr',    zWAR_fUr  )
   repl_( 'WAR_fUw',    zWAR_fUw  )
   repl_( 'WAR_ffp',    zWAR_ffp  )
   repl_( 'WAR_ffg',    zWAR_ffg  )
   repl_( 'WAR_fsum',   zWAR_fsum )
   repl_( 'BRUT_RAZEM', zBRUT_RAZEM )
   repl_( 'DOCHOD',     zDOCHOD     )
   repl_( 'DOCHODPOD',  zDOCHODPOD  )
   *repl_('ZAOPOD',     zZAOPOD     )
   repl_( 'PENSJA',     zPENSJA     )
   repl_( 'PODATEK',    zPODATEK    )
   repl_( 'NETTO',      zNETTO      )
   repl_( 'DO_WYPLATY', zDO_WYPLATY )
   //002a nowa linia

   DO CASE
   *case zTYT='O'
   *     zTYTUL:='0'
   CASE zTYT = 'A'
      zTYTUL := '1'
   CASE zTYT = 'C'
      zTYTUL := '2'
   CASE zTYT = 'E'
      zTYTUL := '3'
   CASE zTYT = 'F'
      zTYTUL := '4'
   CASE zTYT = 'S'
      zTYTUL := '9'

   CASE zTYT = 'P'
      zTYTUL := '6'
   CASE zTYT = 'I'
      zTYTUL := '7'
   CASE zTYT = 'R'
      zTYTUL := '8'
   CASE zTYT = 'O'
      zTYTUL := '10'
   CASE zTYT = 'D'
      zTYTUL := '11'
   OTHERWISE
      zTYTUL :='5' //<--= brak danych
   ENDCASE

   repl_( 'TYTUL', zTYTUL )

   repl_( 'OSWIAD26R', zOSWIAD26R )

   repl_( 'POTRACENIA', zPOTRACENIA )

   RETURN

//002a nowe funkcje
FUNCTION jaki_tytul()
   ColInf()
   @  2, 50 CLEAR TO 15, 79
   @  2, 50 to 15, 79
   @  3, 51 SAY padc('Wpisz:',28)
   @  4, 51 SAY 'Z - umowy zlecenia          '
   @  5, 51 SAY 'D - umowy o dzieˆo          '
   @  6, 51 SAY 'P - prawa autorskie i inne  '
   *   @  8,51 SAY 'K - kontrakty menedzerskie  '
   @  7, 51 SAY 'I - inne zrodla             '
   @  8, 51 SAY 'C - czlonkowstwo w spoldziel'
   @  9, 51 SAY 'E - emerytury,renty zagrani.'
   @ 10, 51 SAY 'F - swiadczenia z FP i FGSP '
   @ 11, 51 SAY 'S - spoleczne obowiazki     '
   *   @ 14,51 SAY 'O - organy stanowiace       '
   @ 12, 51 SAY 'A - aktywizacyjna umowa     '
   @ 13, 51 SAY 'R - ryczalt do 200zl        '
   @ 14, 51 SAY 'O - obcokrajowiec           '
   *  @ 24,0 say padc('Wpisz: A-rtyst.dzia&_l.alno&_s.&_c.,Z-lecenia i dzie&_l.a,P-rawa autorskie,K-ontrakty,I-nne',80,' ')

   RETURN .T.

FUNCTION wAUTOKOM()
   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: A-automatyczne wyliczanie kwoty, R-r&_e.czna aktualizacja kwot', 80, ' ' )
   RETURN .T.

FUNCTION vAUTOKOM()
   ColStd()
   @ 24,0 clear
   RETURN .T.

***************************************************
*function wJAKZAOu
*para x,y
*ColInf()
*@ 24,0 say padc('Jak zaokraglic podatek: Z-do zlotowki   lub   D-do dziesieciu groszy',80,' ')
*ColStd()
*@ x,y say iif(zJAKZAO='D','ziesiec groszy','lotowka       ')
*return .t.
***************************************************
*function vJAKZAOu
*para x,y
*R=.f.
*if zJAKZAO$'DZ'
*   ColStd()
*   @ x,y say iif(zJAKZAO='D','ziesiec groszy','lotowka       ')
*   @ 24,0
*   R=.t.
*endif
*return R
***************************************************
