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

PROCEDURE Organy_()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
RECS=recno()
if reccount()=0
   kom(3,[*u],[ Brak Organ&_o.w Rejestrowych w katalogu ])
   keyboard chr(27)
   inkey()
   go RECS
   return
endif
go RECS
*################################# GRAFIKA ##################################
CURR=ColStd()
@ 12, 8 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@ 13, 8 say '°                                                            °'
@ 14, 8 say '°                                                            °'
@ 15, 8 say '°                                                            °'
@ 16, 8 say '°                                                            °'
@ 17, 8 say '°                                                            °'
@ 18, 8 say '°                                                            °'
@ 19, 8 say '°                                                            °'
@ 20, 8 say '°                                                            °'
@ 21, 8 say '°                                                            °'
@ 22, 8 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
*################################# OPERACJE #################################
*----- parametry ------
_row_g=13
_col_l=9
_row_d=21
_col_p=68
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13,32,7,46,1006]
_top=[bof()]
_bot=[del#'+']
_stop=[+]
_sbot=[+]+[þ]
_proc=[linia251()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27.and.kl#13 .AND. kl # 1006
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   setcolor(CURR)
   kl=lastkey()
enddo
if kl=13 .OR. kl == 1006
   zorgan=recno()
endif
setcolor(CURR)
*################################## FUNKCJE #################################
function linia251
return NAZWA_ORG
*############################################################################
