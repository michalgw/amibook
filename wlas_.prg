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

PROCEDURE Wlas_()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
RECS=recno()
if reccount()=0
   kom(3,[*u],[ Brak informacji o w&_l.a&_s.cicielach ])
   keyboard chr(27)
   inkey()
   go RECS
   return
endif
go RECS
*################################# GRAFIKA ##################################
CURR=ColStd()
@ 10,23 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@ 11,23 say '°                              °'
@ 12,23 say '°                              °'
@ 13,23 say '°                              °'
@ 14,23 say '°                              °'
@ 15,23 say '°                              °'
@ 16,23 say '°                              °'
@ 17,23 say '°                              °'
@ 18,23 say '°                              °'
@ 19,23 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
*################################# OPERACJE #################################
*----- parametry ------
_row_g=11
_col_l=24
_row_d=18
_col_p=53
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13,32,7,46,1006]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia261()]
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
   znazwisko=naz_imie
endif
setcolor(CURR)
*################################## FUNKCJE #################################
function linia261
return dos_c(SubStr(NAZ_IMIE, 1, 30))
*############################################################################
