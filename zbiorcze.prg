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

FUNCTION Zbiorcze()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Zbiorcze zestawienia sprzedazy                                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, _stop, _sbot
   PRIVATE _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou, _top_bot

   sprawdzVAT( 10, CToD( param_rok + '.' + StrTran( miesiac, ' ', '0' ) + '.01' ) )

   @  1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3, 0 CLEAR TO 22, 79
   @  3, 10 SAY 'Dzie&_n. Nr zest. Nr dowodu  Warto&_s.&_c. Netto Staw  Warto&_s.&_c. VAT  '
   @  4, 10 SAY 'ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
   @  5, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @  6, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @  7, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @  8, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @  9, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @ 10, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @ 11, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @ 12, 10 SAY '³  ³          ³          ³              ³  ³              ³'
   @ 13, 10 SAY 'ÃÍÍÅÍÍÍÍÍÍÍÍÍÍÅÍÍÍÍÍÍÍÍÍÍÅÍÍÍÍÍÍÍÍÍÍÍÍÍÍÅÍÍÅÍÍÍÍÍÍÍÍÍÍÍÍÍÍ´  Brutto  '
   @ 14, 10 SAY '³  ³          ³  RAZEM   ³              ³ÍÍ³              ³'
   @ 15, 10 SAY 'ÀÍÍÁÍÍÍÍÍÍÍÍÍÍÁÍÍÍÍÍÍÍÍÍÍÅÍÍÍÍÍÍÍÍÍÍÍÍÍÍÅÍÍÅÍÍÍÍÍÍÍÍÍÍÍÍÍÍ´'
   @ 16, 10 SAY '                         ³              ³' + Str( vat_A, 2 ) + '³              ³'
   @ 17, 10 SAY '               wg stawek ³              ³' + Str( vat_B, 2 ) + '³              ³'
   @ 18, 10 SAY '              podatku VAT³              ³ 0³              ³'
   @ 19, 10 SAY '                         ³              ³ZW³              ³'
   @ 20, 10 SAY '                         ³              ³' + Str( vat_C, 2 )+'³              ³'
   @ 21, 10 SAY '                         ³              ³  ³              ³'
   @ 22, 10 SAY '                         ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   DO WHILE ! dostep( 'DZIENNE' )
   ENDDO
   setind( 'DZIENNE' )
   SEEK '+' + ident_fir + miesiac

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 5
   _col_l := 11
   _row_d := 12
   _col_p := 67
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,13'
   _top := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + 'þ'
   _proc := 'linia61d()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'linia61ds'
   _disp := .t.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   DOPISEK := Space( 60 )
   zDZIEN := '  '
   zNUMER := Space( 10 )
   zNUMER_RACH := Space( 10 )
   zNETTO := 0
   zWARTVAT := 0
   zSTAWKA := '  '

   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
         *################################## INSERT ##################################
         CASE kl == K_INS .OR. kl == Asc( '0' ) .OR. _row == -1 .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' )

            @ 1,47 say [          ]
            ins := ( kl # Asc( 'M' ) .AND. kl # Asc( 'm' ) ) .OR. &_top_bot
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

            DO WHILE .T.
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               IF ins
                  zNETTO := 0
                  zWARTVAT := 0
                  zSTAWKA := '  '
               ELSE
                  zDZIEN := DZIEN
                  zNUMER := NUMER
                  zNUMER_RACH := NUMER_RACH
                  zNETTO := NETTO
                  zWARTVAT := WARTVAT
                  zSTAWKA := STAWKA
               ENDIF

               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               @ wiersz, 11 GET zDZIEN PICTURE '@K 99' VALID v1_1d()
               @ wiersz, 14 GET zNUMER PICTURE '@K !!!!!!!!!!'
               @ wiersz, 25 GET zNUMER_RACH PICTURE '@K !!!!!!!!!!'
               @ wiersz, 36 GET zNETTO PICTURE '   99999999.99'
               @ wiersz, 51 GET zSTAWKA PICTURE '!!' VALID vSTAWKA()
               @ wiersz, 54 GET zWARTVAT PICTURE '   99999999.99' WHEN wWARTVAT()
               read_()
               IF LastKey() == K_ESC
                  EXIT
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               IF ins
                  app()
               ENDIF
               BlokadaR()
               repl_( 'FIRMA', ident_fir )
               repl_( 'MC', miesiac )
               repl_( 'DZIEN', zDZIEN )
               repl_( 'NUMER', zNUMER )
               repl_( 'NUMER_RACH', zNUMER_RACH )
               repl_( 'NETTO', zNETTO )
               repl_( 'WARTVAT', zWARTVAT )
               repl_( 'STAWKA', AllTrim( zSTAWKA ) )
               commit_()
               UNLOCK
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
               _row := Int( ( _row_g + _row_d ) / 2 )
               IF ! ins
                  EXIT
               ENDIF
               @ _row_d, _col_l SAY &_proc
               Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
               @ _row_d, _col_l SAY '  ³          ³          ³              ³  ³              '
            ENDDO
            _disp := ins .OR. LastKey() # K_ESC
            kl := iif( LastKey() == K_ESC .AND. _row = -1, K_ESC, kl )
            @ 23, 0
            @ 24, 0

         *################################ KASOWANIE #################################
         case kl == K_DEL .OR. kl == Asc( '.' )
            RECS := RecNo()
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                   þ' )
            ColSta()
            center( 23, 'K A S O W A N I E' )
            ColStd()
            _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
            IF _disp
               BlokadaR()
               DELE
               UNLOCK
               SKIP
               commit_()
               IF &_bot
                  SKIP -1
               ENDIF
            ENDIF
            @ 23, 0

         *################################# SZUKANIE #################################
         CASE kl == K_F10 .OR. kl == 247  // - co to 247?
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                 þ' )
            ColSta()
            center( 23, 'S Z U K A N I E' )
            ColStd()
            f10 := '  '
            @ _row, 11 GET f10 PICTURE '99'
            read_()
            _disp := Left( f10, 2 ) # '  ' .AND. LastKey() # K_ESC
            IF _disp
               SEEK '+' + ident_fir + miesiac + Str( Val( Left( f10, 2 ) ), 2 )
               IF &_bot
                  SKIP -1
               ENDIF
               _row := Int( ( _row_g + _row_d ) / 2 )
            ENDIF
            @ 23, 0

         *############################### WYDRUK ZESTAWIENIA #########################
         CASE kl == K_ENTER
            BEGIN SEQUENCE
               SAVE SCREEN TO scr_
               reczb := RecNo()
               DzienWyd( zdzien, znumer )
               GO reczb
               RESTORE SCREEN FROM scr_
            END

         *################################### POMOC ##################################
         CASE kl == K_F1
              SAVE SCREEN TO scr_
              @ 1, 47 SAY '          '
              DECLARE p[ 20 ]
              *---------------------------------------
              p[  1 ] := '                                                        '
              p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
              p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
              p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
              p[  5 ] := '   [Ins]...................nanoszenie dowodu sprzeda&_z.y  '
              p[  6 ] := '   [M].....................modyfikacja pozycji          '
              p[  7 ] := '   [Del]...................kasowanie pozycji            '
              p[  8 ] := '   [F10]...................szukanie                     '
              p[  9 ] := '   [Enter].................wydruk zestawienia za dzie&_n.  '
              p[ 10 ] := '   [Esc]...................wyj&_s.cie                      '
              p[ 11 ] := '                                                        '
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
              IF LastKey() # K_ESC .AND. LastKey() # K_F1
                 KEYBOARD Chr( LastKey() )
              ENDIF
              RESTORE SCREEN FROM scr_
              _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()
   RETURN NIL

*################################## FUNKCJE #################################
FUNCTION linia61d()

   RETURN DZIEN + '³' + NUMER + '³' + NUMER_RACH + '³' + kwota( NETTO, 14, 2 ) + '³' + STAWKA + '³' + kwota( WARTVAT, 14, 2 )

*############################################################################
FUNCTION linia61ds()

   rr := Row()
   cc := Col()
   zDZIEN := DZIEN
   zNUMER := NUMER
   zNUMER_RACH := NUMER_RACH
   nRAZEM := 0
   vRAZEM := 0
   n22 := 0
   n12 := 0
   n7 := 0
   n2 := 0
   n0 := 0
   nzw := 0
   nin := 0
   v22 := 0
   v12 := 0
   v7 := 0
   v2 := 0
   vin := 0
   reczb := RecNo()
   SEEK '+' + ident_fir + miesiac + zdzien + znumer
   DO WHILE ! &_bot .AND. dzien == zdzien .AND. numer == znumer .AND. ! Eof()
      DO CASE
         CASE STAWKA == Str( vat_A, 2 )
            n22 := n22 + netto
            v22 := v22 + wartvat
         CASE AllTrim( STAWKA ) == Str( vat_B, 1 )
            n7 := n7 + netto
            v7 := v7 + wartvat
         CASE AllTrim( STAWKA ) == Str( vat_C, 1 )
            n2 := n2 + netto
            v2 := v2 + wartvat
         CASE STAWKA == '0 '
            n0 := n0 + netto
         CASE STAWKA == 'ZW'
            nzw := nzw + netto
         OTHERWISE
            nin := nin + netto
            vin := vin + wartvat
      ENDCASE
      nrazem := nrazem + netto
      vrazem := vrazem + wartvat
      SKIP 1
   ENDDO
   GO reczb
   SET COLOR TO w+
   @ 14, 11 SAY DZIEN PICTURE '99'
   @ 14, 14 SAY NUMER PICTURE '!!!!!!!!!!'
   @ 14, 36 SAY nrazem PICTURE '999 999 999.99'
   @ 14, 54 SAY vrazem PICTURE '999 999 999.99'
   @ 14, 69 SAY nrazem + vrazem PICTURE '99999999.99'
   @ 16, 36 SAY n22    PICTURE '999 999 999.99'
   @ 16, 54 SAY v22    PICTURE '999 999 999.99'
   @ 17, 36 SAY n7     PICTURE '999 999 999.99'
   @ 17, 54 SAY v7     PICTURE '999 999 999.99'
   @ 18, 36 SAY n0     PICTURE '999 999 999.99'
   @ 19, 36 SAY nzw    PICTURE '999 999 999.99'
   @ 20, 36 SAY n2     PICTURE '999 999 999.99'
   @ 20, 54 SAY v2     PICTURE '999 999 999.99'
   *@ 21,36 say n12    picture '999 999 999.99'
   *@ 21,54 say v12    picture '999 999 999.99'
   *@ 21,36 say nin    picture '999 999 999.99'
   *@ 21,54 say vin    picture '999 999 999.99'
   SET COLOR TO
   @ rr, cc SAY ''
   RETURN

***************************************************
FUNCTION v1_1d()
***************************************************
   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ wiersz, 11 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF
   RETURN .T.

****************************************
FUNCTION vSTAWKA()
****************************************
   R := .F.
   STA := Val( zSTAWKA )
   IF STA == vat_A .OR. STA == vat_B .OR. STA == 0 .OR. STA == vat_C .OR. zSTAWKA == 'ZW'
      R := .T.
   ENDIF
   RETURN R

****************************************
FUNCTION wWARTVAT()
****************************************
   IF zWARTVAT == 0
      zWARTVAT := _round( zNETTO * ( Val( zSTAWKA ) / 100 ), 2 )
   ENDIF
   RETURN .T.

*############################################################################
