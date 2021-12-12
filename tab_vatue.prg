/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

FUNCTION Tab_VatUE()

   LOCAL bKrajV := { | |
      LOCAL cKolor := ColStd(), lRes
      IF ( lRes := KrajUE( zKRAJ ) )
         @ 22, 38 SAY 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
         @ 22, 38 SAY KrajUENazwa( zKRAJ )
      ENDIF
      SetColor( cKolor )
      RETURN lRes
   }

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, _top_bot

   @  1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   //@  3, 42 CLEAR TO 22,79
   @  3, 36 SAY 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
   @  4, 36 SAY 'ºKraj³  Stawka  ³   A  ³   B  ³   C  ³  D  º'
   @  5, 36 SAY 'º    ³ od dnia  ³podsta³obnizo³dodatk³dod.2º'
   @  6, 36 SAY 'ºÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄº'
   @  7, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @  8, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @  9, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 10, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 11, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 12, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 13, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 14, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 15, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 16, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 17, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 18, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 19, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 20, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 21, 36 SAY 'º    ³          ³      ³      ³      ³     º'
   @ 22, 36 SAY 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'

   *############################### OTWARCIE BAZ ###############################
   DO WHILE .NOT. Dostep( 'TAB_VATUE' )
   ENDDO
   SetInd( 'TAB_VATUE' )

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 7
   _col_l := 37
   _row_d := 21
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,22,42,78,109,7,46,28,68,100'
   _top := '.F.'
   _bot := "del#'+'"
   _stop := ''
   _sbot := '-'
   _proc := 'Tab_VatUELinia()'
   _row := int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'Tab_VatUEKraj'
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
      *############################ INSERT/MODYFIKACJA ############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 77 .AND. kl # 109 ) .OR. &_top_bot
         IF ins
            ColStb()
            Center( 23, 'þ                     þ' )
            ColSta()
            Center( 23, 'W P I S Y W A N I E' )
            ColStd()
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            ColStb()
            Center( 23, 'þ                       þ' )
            ColSta()
            Center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            wiersz := _row
         ENDIF
         DO WHILE .T.
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zODDNIA := Date()
               zKRAJ := '  '
               zSTAWKA_A := 0
               zSTAWKA_B := 0
               zSTAWKA_C := 0
               zSTAWKA_D := 0
            ELSE
               zODDNIA := tab_vatue->oddnia
               zKRAJ := tab_vatue->kraj
               zSTAWKA_A := tab_vatue->stawka_a
               zSTAWKA_B := tab_vatue->stawka_b
               zSTAWKA_C := tab_vatue->stawka_c
               zSTAWKA_D := tab_vatue->stawka_d
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð-
            @ wiersz, 38 GET zKRAJ     PICTURE "!!" VALID Eval( bKrajV )
            @ wiersz, 42 GET zODDNIA   PICTURE "@D 9999.99.99" VALID Tab_VatUEValid()
            @ wiersz, 54 GET zSTAWKA_A PICTURE "99.99"
            @ wiersz, 61 GET zSTAWKA_B PICTURE "99.99"
            @ wiersz, 68 GET zSTAWKA_C PICTURE "99.99"
            @ wiersz, 74 GET zSTAWKA_D PICTURE "99.99"
            read_()
            SET CURSOR OFF
            IF LastKey() == 27
               EXIT
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               app()
            ENDIF
            BlokadaR()
            tab_vatue->kraj := zKRAJ
            tab_vatue->oddnia := zODDNIA
            tab_vatue->stawka_a := zSTAWKA_A
            tab_vatue->stawka_b := zSTAWKA_B
            tab_vatue->stawka_c := zSTAWKA_C
            tab_vatue->stawka_d := zSTAWKA_D
            commit_()
            UNLOCK
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               EXIT
            ENDIF
            @ _row_d, _col_l SAY &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '          ³      ³      ³      ³     '
         ENDDO
         _disp := ins.or.lastkey()#27
         kl := iif(lastkey()=27.and._row=-1,27,kl)
         @ 23,0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         @ 1, 47 SAY '          '
         ColStb()
         Center( 23, 'þ                   þ' )
         ColSta()
         Center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            BlokadaR()
            DELETE
            UNLOCK
            SKIP
            commit_()
            IF &_bot
               SKIP -1
            ENDIF
         ENDIF
         @ 23, 0
      *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                                        '
         p[ 2 ] := '   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
         p[ 3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[ 4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[ 5 ] := '   [Ins]...................wpisywanie                   '
         p[ 6 ] := '   [M].....................modyfikacja pozycji          '
         p[ 7 ] := '   [D].....................przywr¢† warto˜ci domy˜lne   '
         p[ 8 ] := '   [Del]...................kasowanie pozycji            '
         p[ 9 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 10 ] := '                                                        '
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

      CASE kl == Asc( 'D' ) .OR. kl == Asc( 'd' )
         IF TNEsc( , "Czy przywr¢ci† domy˜ln¥ tabel© stawek ? (Tak/Nie)" )
            DomParPrzywroc_TabVatUE( .F., DomParRok() )
         ENDIF

      ******************** ENDCASE
      ENDCASE
   ENDDO
   close_()

   RETURN NIL

*################################## FUNKCJE #################################

FUNCTION Tab_VatUELinia()

   RETURN ' ' + tab_vatue->kraj + ' ³' + DToC( tab_vatue->oddnia ) + '³ ' ;
      + Str( tab_vatue->stawka_a, 5, 2 ) + '³ ' + Str( tab_vatue->stawka_b, 5, 2 ) ;
      + '³ ' + Str( tab_vatue->stawka_c, 5, 2 ) + '³' + Str( tab_vatue->stawka_d, 5, 2 )

***************************************************

PROCEDURE Tab_VatUEKraj()

   LOCAL cKolor := ColStd()

   @ 22, 38 SAY 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   @ 22, 38 SAY KrajUENazwa( tab_vatue->kraj )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Tab_VatUEValid()

   LOCAL nr_rec := tab_vatue->( RecNo() )
   LOCAL fou, rec

   tab_vatue->( dbSeek( del + zKRAJ + DToS( zODDNIA ) ) )
   fou := Found()
   rec := RecNo()
   tab_vatue->( dbGoto( nr_rec ) )
   IF fou .AND. ( ins .OR. rec # nr_rec )
      SET CURSOR OFF
      Kom( 3, '*u', 'Takie dane ju&_z. istniej&_a.' )
      SET CURSOR ON
      RETURN .F.
   ENDIF
   RETURN .T.

*############################################################################

FUNCTION Tab_VatUEZnajdz( cKraj, dData )

   LOCAL aDane := { 'a' => 0, 'b' => 0, 'c' => 0, 'd' => 0 }

   //IF tab_vatue->( dbSeek( '+' + cKraj + Str( Descend( dData ) ), .T., .T. ) )
   IF tab_vatue->( dbSeek( '+' + cKraj ) )
      DO WHILE tab_vatue->oddnia > dData .AND. tab_vatue->kraj == cKraj .AND. ! tab_vatue->( Eof() )
         tab_vatue->( dbSkip() )
      ENDDO
      IF tab_vatue->kraj == cKraj .AND. dData >= tab_vatue->oddnia
         aDane[ 'a' ] := tab_vatue->stawka_A
         aDane[ 'b' ] := tab_vatue->stawka_B
         aDane[ 'c' ] := tab_vatue->stawka_C
         aDane[ 'd' ] := tab_vatue->stawka_D
      ENDIF
   ENDIF

   RETURN aDane

/*----------------------------------------------------------------------*/

