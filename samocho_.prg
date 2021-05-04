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

PROCEDURE Samocho_()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
if del#[+]
   kom(3,[*u],[ Brak pojazdow w katalogu ])
   keyboard chr(27)
   inkey()
   return
endif
ColStd()
*################################# GRAFIKA ##################################
@  8, 3 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@  9, 3 say '°                                                                       °'
@ 10, 3 say '°                                                                       °'
@ 11, 3 say '°                                                                       °'
@ 12, 3 say '°                                                                       °'
@ 13, 3 say '°                                                                       °'
@ 14, 3 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
set color to
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=4
_row_d=13
_col_p=74
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13,1006]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia153()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27.and.kl#13 .AND. kl # 1006
   @ 1,47 say '[F1]-pomoc'
   _row=wybor(_row)
   kl=lastkey()
   do case
*################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                        '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
        p[ 3]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
        p[ 4]='   [Home/End]..............pierwsza/ostatnia pozycja    '
        p[ 5]='   [Enter].................akceptacja                   '
        p[ 6]='   [Esc]...................wyj&_s.cie                      '
        p[ 7]='                                                        '
        *---------------------------------------
        set color to i
        i=20
        j=24
        do while i>0
           if type('p[i]')#[U]
              center(j,p[i])
              j=j-1
           endif
           i=i-1
        enddo
        set color to
        pause(0)
        if lastkey()#27.and.lastkey()#28
           keyboard chr(lastkey())
        endif
        restore screen from scr_
        _disp=.f.
        ******************** ENDCASE
   endcase
enddo
*################################## FUNKCJE #################################
function linia153
return NRREJ+[  ]+MARKA+[  ]+str(POJEMNOSC,4)+[cm3  ]+WLASCIC
*############################################################################
