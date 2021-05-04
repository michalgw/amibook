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

PROCEDURE Prac_()

   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   *±Obsluga podstawowych operacji na bazie ......                             ±
   *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
   @ 1, 47 SAY '          '
   RECS := RecNo()
   IF RecCount() == 0
      kom( 3, '*u', ' Brak pracownik&_o.w w katalogu ' )
      KEYBOARD Chr( 27 )
      Inkey()
      GO RECS
      RETURN
   ENDIF
   GO RECS
   CURR := ColStd()

   *################################# GRAFIKA ##################################
   @  8, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
   @  9, 0 SAY '°                                                                              °'
   @ 10, 0 SAY '°                                                                              °'
   @ 11, 0 SAY '°                                                                              °'
   @ 12, 0 SAY '°                                                                              °'
   @ 13, 0 SAY '°                                                                              °'
   @ 14, 0 SAY '°                                                                              °'
   @ 15, 0 SAY '°                                                                              °'
   @ 16, 0 SAY '°                                                                              °'
   @ 17, 0 SAY '°                                                                              °'
   @ 18, 0 SAY '°                                                                              °'
   @ 19, 0 SAY '°                                                                              °'
   @ 20, 0 SAY '°                                                                              °'
   @ 21, 0 SAY '°                                                                              °'
   @ 22, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 9
   _col_l := 1
   _row_d := 21
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,28,13,32,7,46,1006'
   _top := "firma#ident_fir.or.status<'U'"
   _bot := "del#'+'.or.firma#ident_fir.or.status<'U'"
   _stop := '+' + ident_fir + '+'
   _sbot := '+' + ident_fir + '+' + 'þ'
   _proc := 'linia161()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := ''
   _disp := .T.
   _cls := ''
   *----------------------
   kl := 0
   DO WHILE kl # 27 .AND. kl # 13 .AND. kl # 1006
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      SET COLOR TO
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
   ENDDO
   IF kl == 13 .OR. kl == 1006
      zident := Str( rec_no, 5 )
   ENDIF
   SetColor( CURR )

   RETURN

*################################## FUNKCJE #################################
FUNCTION linia161()

   RETURN NAZWISKO + '³' + IMIE1 + '³' + IMIE2 + '³' + iif( STATUS <> 'U', iif( STATUS = 'E', 'Etatowy        ', 'Zleceniowy     ' ), 'Uniwersalny    ' )
*############################################################################
