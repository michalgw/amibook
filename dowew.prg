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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

PROCEDURE DoWew()

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc
   PRIVATE _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl
   PRIVATE ins, nr_rec, wiersz, f10, rec, fou, _top_bot

   @  1, 47 SAY "          "
   *################################# GRAFIKA ##################################
   @  3,  0 SAY PadC( 'D O W &__O. D   W E W N &__E. T R Z N Y', 80 )
   @  4,  0 SAY 'Zes Nr                                                 Zestaw drukow.jako  Druk '
   @  5,  0 SAY 'taw kol.          Opis pozycji               Wartosc     Data     Nr dok.  owac '
      KKOLG := 'ÚÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄ¿'
      KKOL  := '³  ³  ³                                   ³          ³          ³          ³   ³'
      KKOLS := 'ÀÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÙ'
   @  6,  0 SAY KKOLG
   FOR x := 7 TO 20
      @ x,  0 SAY KKOL
   NEXT
   @ 21,  0 SAY KKOLS
   @ 22,  0 SAY Space( 80 )
   *############################### OTWARCIE BAZ ###############################
   SELECT 1
   IF Dostep( 'DOWEW' )
      SetInd( 'DOWEW' )
      SEEK '+' + ident_fir
   ELSE
      Close_()
      RETURN
   ENDIF
   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 7
   _col_l := 1
   _row_d := 20
   _col_p := 78
   _invers := [i]
   _curs_l := 0
   _curs_p := 0
   _esc := [27,68,100,22,48,77,109,7,46,28,13]
   _top := [del#'+'.or.firma#ident_fir]
   _bot := [del#'+'.or.firma#ident_fir]
   _stop := [+]+ident_fir
   _sbot := [+]+ident_fir+[þ]
   _proc := [linia622a()]
   _row := int((_row_g+_row_d)/2)
   _proc_spe := []
   _disp := .t.
   _cls := ''
   _top_bot := _top+[.or.]+_bot
   *----------------------
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := Wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *################################## INSERT ##################################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY "          "
         ins := ( kl # 77 .AND. kl # 109 ) .OR. &_top_bot
         IF ins
            ColStb()
            Center( 23, "þ                     þ" )
            ColSta()
            Center( 23, "W P I S Y W A N I E" )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            Center( 23, "þ                       þ" )
            ColSta()
            Center( 23, "M O D Y F I K A C J A" )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
         *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zDATA := CToD( '    .  .  ' )
               zNRDOK := Space( 10 )
               zZESTAW := '  '
               zNRKOL := '  '
               zOPIS := Space( 100 )
               zWARTOSC := 0
               zDRUKOWAC := .T.
            ELSE
               zDATA := DATA
               zNRDOK := NRDOK
               zZESTAW := ZESTAW
               zNRKOL := NRKOL
               zOPIS := OPIS
               zWARTOSC := WARTOSC
               zDRUKOWAC := DRUKOWAC
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz, 1  GET zZESTAW  PICTURE '!!'
            @ wiersz, 4  GET zNRKOL   PICTURE '!!'
            @ wiersz, 7  GET zOPIS    PICTURE '@S35 X' + repl( 'X', 100 )
            @ wiersz, 43 GET zWARTOSC PICTURE '9999999.99'
            read_()
            IF LastKey() == 27
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
            ENDIF
            BlokadaR()
            repl_( 'FIRMA', ident_fir )
            repl_( 'DATA', zDATA )
            repl_( 'NRDOK', zNRDOK )
            repl_( 'ZESTAW', zZESTAW )
            repl_( 'NRKOL', zNRKOL )
            repl_( 'OPIS', zOPIS )
            repl_( 'WARTOSC', zWARTOSC )
            repl_( 'DRUKOWAC', zDRUKOWAC )
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( (_row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d ,_col_p, 1 )
            @ _row_d, _col_l SAY "  ³  ³                                     ³        ³          ³          ³   "
         enddo
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0
         @ 24, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         RECS := RecNo()
         @ 1, 47 SAY "          "
         ColStb()
         Center( 23, "þ                   þ" )
         ColSta()
         Center( 23, "K A S O W A N I E" )
         ColStd()
         _disp := TNEsc( "*i", "   Czy skasowa&_c.? (T/N)   " )
         IF _disp
            BlokadaR()
            DELETE
            COMMIT
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0
      *############################### WYDRUK EWIDENCJI ###########################
      CASE kl == 13
         BEGIN SEQUENCE
            SAVE SCREEN TO scr_
            RECS := RecNo()
            DoWewW()
            GO RECS
            RESTORE SCREEN FROM scr_
         END
      *############################### WYDRUK EWIDENCJI ###########################
      CASE kl == 68 .OR. kl == 100
         BlokadaR()
         REPLACE drukowac WITH .NOT. drukowac
         COMMIT
         UNLOCK
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY "          "
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1] := '                                                        '
         p[ 2] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[ 4] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5] := '   [Ins]...................dopisanie pozycji            '
         p[ 6] := '   [M].....................modyfikacja pozycji          '
         p[ 7] := '   [D].....................drukowa&_c./nie drukowa&_c. pozycje'
         p[ 8] := '   [Del]...................kasowanie pozycji            '
         p[ 9] := '   [Enter].................wydruk dowodu wewn&_e.trznego   '
         p[10] := '   [Esc]...................wyj&_s.cie                      '
         p[11] := '                                                        '
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
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN

*############################################################################

FUNCTION linia622a()

   RETURN ZESTAW + '³' + NRKOL + '³' + SubStr( OPIS, 1, 35 ) + '³' ;
      + Str( WARTOSC, 10, 2 ) + '³' + DToC( DATA ) + '³' + NRDOK + '³' ;
      + iif( DRUKOWAC, 'Tak', 'Nie' )

*############################################################################
