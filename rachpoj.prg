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

PROCEDURE RachPoj()

   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *± Zbiorcze zestawienia sprzedazy                                           ±
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, _bot, _stop, ;
      _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, wiersz, f10, rec, fou, _top_bot

   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   @  3, 0 CLEAR TO 22, 79
   @  3, 0 SAY 'Dzie&_n. Nr rej.  Nr rach.       Rodzaj poniesionego wydatku  Wart.Netto Wart. VAT '
   KKOLG := 'ÚÄÄÂ' + repl( 'Ä', 8 ) + 'Â' + repl( 'Ä', 10 ) + 'Â' + repl( 'Ä', 35 ) + 'Â' + repl( 'Ä', 9 ) + 'Â' + repl( 'Ä', 9 ) + '¿'
   KKOL  := '³  ³' + Space( 8 ) + '³' + Space( 10 ) + '³' + Space( 35 ) + '³' + Space( 9 ) + '³' + Space( 9 ) + '³'
   KKOLS := 'ÀÄÄÁ' + repl( 'Ä', 8 ) + 'Á' + repl( 'Ä', 10 ) + 'Á' + repl( 'Ä', 35 ) + 'Á' + repl( 'Ä', 9 ) + 'Á' + repl( 'Ä', 9 ) + 'Ù'
   @  4, 0 SAY KKOLG
   FOR x := 5 TO 21
      @ x, 0 SAY KKOL
   NEXT
   @ 22, 0 SAY KKOLS
   *############################### OTWARCIE BAZ ###############################
   SELECT 2
   IF Dostep( 'SAMOCHOD' )
      SET INDEX TO samochod
      seek '+' + ident_fir
      IF Eof() .OR. del # '+' .OR. firma # ident_fir
         Kom( 3, '*u', ' Najpierw wprowad&_z. informacj&_e. o u&_z.ywanych samochodach ' )
         RETURN
      ENDIF
   ELSE
      Close_()
      RETURN
   ENDIF

   SELECT 1
   DO WHILE ! Dostep( 'RACHPOJ' )
   ENDDO
   SetInd( 'RACHPOJ' )
   SEEK '+' + ident_fir + miesiac
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 5
   _col_l := 1
   _row_d := 21
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,13'
   _top := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _bot := "del#'+'.or.firma#ident_fir.or.mc#miesiac"
   _stop := '+' + ident_fir + miesiac
   _sbot := '+' + ident_fir + miesiac + 'þ'
   _proc := 'linia71d()'
   _row := Int( (_row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot
   *----------------------
   kl := 0
   zDZIEN := '  '
   zNUMER := Space( 10 )
   zNETTO := 0
   zWARTVAT := 0
   zRODZAJ := Space( 40 )
   zNRREJ := Space( 8 )
   DO WHILE kl # K_ESC
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *################################## INSERT ##################################
      CASE kl == K_INS .OR. kl == Asc( '0' ) .OR. _row == -1 .OR. kl == Asc( 'M' ) .OR. kl == Asc( 'm' )
         @ 1, 47 SAY '          '
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
            center( 23,'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
         *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zDZIEN := '  '
               zNUMER := Space( 10 )
               zRODZAJ := 'Zakup paliwa' + Space( 28 )
               zNETTO := 0
               zWARTVAT := 0
            ELSE
               zDZIEN := DZIEN
               zNUMER := NUMER
               zNETTO := NETTO
               zWARTVAT := WARTVAT
               zRODZAJ := RODZAJ
               zNRREJ := NRREJ
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 1  GET zDZIEN PICTURE '@K 99' VALID v7_1d()
            @ wiersz, 4  GET zNRREJ PICTURE '!!! !!!!' WHEN w1_71() VALID v1_71()
            @ wiersz, 13 GET zNUMER PICTURE '@K !!!!!!!!!!'
            @ wiersz, 24 GET zRODZAJ PICTURE '@KS35 !' + repl( 'X', 39 )
            @ wiersz, 60 GET zNETTO PICTURE ' 99999.99'
            @ wiersz, 70 GET zWARTVAT PICTURE ' 99999.99'
            Read_()
            IF LastKey() == K_ESC
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               App()
            ENDIF
            BlokadaR()
            repl_( 'FIRMA', ident_fir )
            repl_( 'MC', miesiac )
            repl_( 'DZIEN', zDZIEN )
            repl_( 'NRREJ', zNRREJ )
            repl_( 'NUMER', zNUMER )
            repl_( 'RODZAJ', zRODZAJ )
            repl_( 'NETTO', zNETTO )
            repl_( 'WARTVAT', zWARTVAT )
            Commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF ! ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '  ³        ³          ³                                   ³         ³         '
         ENDDO
         _disp := ins .OR. LastKey() # K_ESC
         kl := iif( LastKey() == K_ESC .AND. _row == -1, K_ESC, kl )
         @ 23, 0
         @ 24, 0
      *################################ KASOWANIE #################################
      CASE kl == K_DEL .OR. kl == Asc( '.' )
         RECS := RecNo()
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := TNEsc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            DELETE
            UNLOCK
            SKIP
            Commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0
      *################################# SZUKANIE #################################
      CASE kl == K_F10 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := '  '
         @ _row, 1 GET f10 PICTURE '99'
         Read_()
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
            zNRREJ := nrrej
            RachPojW()
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
         p[  2 ] := '  [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja   '
         p[  3 ] := '  [PgUp/PgDn].............poprzednia/nast&_e.pna strona    '
         p[  4 ] := '  [Home/End]..............pierwsza/ostatnia pozycja     '
         p[  5 ] := '  [Ins]...................nanoszenie dowodu sprzeda&_z.y   '
         p[  6 ] := '  [M].....................modyfikacja pozycji           '
         p[  7 ] := '  [Del]...................kasowanie pozycji             '
         p[  8 ] := '  [F10]...................szukanie                      '
         p[  9 ] := '  [Enter].................wydruk zestawienia za miesi&_a.c '
         p[ 10 ] := '  [Esc]...................wyj&_s.cie                       '
         p[ 11 ] := '                                                        '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               Center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         SET COLOR TO
         Pause( 0 )
         IF LastKey() # K_ESC .AND. LastKey() # K_F1
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   Close_()

*################################## FUNKCJE #################################
FUNCTION linia71d()

   RETURN DZIEN + '³' + NRREJ + '³' + NUMER + '³' + SubStr( RODZAJ, 1, 35 ) + '³' + kwota(NETTO, 9, 2 ) + '³' + kwota( WARTVAT, 9, 2 )

***************************************************
FUNCTION v7_1d()
***************************************************
   IF zdzien == '  '
      zdzien := Str( Day( Date() ), 2 )
      SET COLOR TO i
      @ wiersz, 1 SAY zDZIEN
      SET COLOR TO
   ENDIF
   IF Val( zdzien ) < 1 .OR. Val( zdzien ) > msc( Val( miesiac ) )
      zdzien := '  '
      RETURN .F.
   ENDIF
   zDZIEN := Str( Val( zDZIEN ), 2 )
   RETURN .T.

***************************************************
FUNCTION w1_71()
***************************************************
   SAVE SCREEN TO scr2
   SELECT samochod
   SEEK '+' + ident_fir + znrrej
   IF del == '+' .AND. firma == ident_fir
      Samocho_()
      RESTORE SCREEN FROM scr2
      IF LastKey() == K_ENTER
         znrrej := nrrej
         KEYBOARD Chr( K_ENTER )
      ENDIF
   ENDIF
   SELECT rachpoj
   RETURN .T.

***************************************************
FUNCTION V1_71()
***************************************************
   SELECT samochod
   SEEK '+' + ident_fir + znrrej
   IF ! Found()
      SAVE SCREEN TO scr2
      GO TOP
      SEEK '+' + ident_fir
      IF del == '+' .AND. firma == ident_fir
         Samocho_()
         RESTORE SCREEN FROM scr2
         DO CASE
         CASE LastKey() == K_ENTER
            znrrej := nrrej
            KEYBOARD Chr( K_ENTER )
         OTHERWISE
              RETURN .F.
         ENDCASE
      ENDIF
   ENDIF
   SELECT rachpoj
   RETURN .T.

*############################################################################
