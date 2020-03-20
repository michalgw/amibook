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

#include "inkey.ch"
FUNCTION tresc_(cStartFiltr)
LOCAL cFiltr := 'O', cPopFiltr := '', lJestPusto := .F.
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
   IF !Empty(cStartFiltr) .AND. cStartFiltr$'OSZ'
      cFiltr := cStartFiltr
   ENDIF
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
CurrCur=setcursor(0)
CURR=ColStd()
@  8,11 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@  9,11 say '°   °                                                   °'
@ 10,11 say '°   °                                                   °'
@ 11,11 say '°   °                                                   °'
@ 12,11 say '°   °                                                   °'
@ 13,11 say '°   °                                                   °'
@ 14,11 say '°   °                                                   °'
@ 15,11 say '°   °                                                   °'
@ 16,11 say '°   °                                                   °'
@ 17,11 say '°   °                                                   °'
@ 18,11 say '°   °                                                   °'
@ 19,11 say '°   °                                                   °'
@ 20,11 say '°   °                                                   °'
@ 21,11 say '°   °                                                   °'
@ 22,11 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@ 23,0 clear
ColInf()
center(23,"  [Enter]-akceptacja    [F5]-filtrowanie  ")
ColStd()
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=12
_row_d=21
_col_p=66
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13,-4]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia16()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
*----------------------
   IF cFiltr <> "O"
      SET FILTER TO AllTrim(rodzaj) == AllTrim(cFiltr) .OR. AllTrim(rodzaj) == "O"
      GO TOP
      SEEK _stop
      IF .NOT.Found()
         SET FILTER TO
         GO TOP
         SEEK _stop
         cFiltr := "O"
      ENDIF
   ENDIF
kl=0
do while kl#27.and.kl#13
   @ 1,47 say '[F1]-pomoc'
   @ 8, 18 SAY 'Filtr: ' + rodzaj2str(cFiltr)
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
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']..........poprzednia/nast&_e.pna pozycja           '
        p[ 3]='   [PgUp/PgDn]....poprzednia/nast&_e.pna strona            '
        p[ 4]='   [Home/End].....pierwsza/ostatnia pozycja             '
        p[ 5]='   [Enter]........akceptacja                            '
        p[ 6]='   [Esc]..........wyj&_s.cie                               '
        p[ 7]='   [F5]...........filtrowanie zakup/sprzedaz/wszystko   '
        p[ 8]='                                                        '
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

   ******************** Filtrowanie
   CASE kl=K_F5
      cPopFiltr := cFiltr
      SWITCH cPopFiltr
      CASE "O"
         cFiltr := "Z"
         EXIT
      CASE "Z"
         cFiltr := "S"
         EXIT
      CASE "S"
         cFiltr := "O"
         EXIT
      ENDSWITCH
      IF cFiltr == "O"
         SET FILTER TO
      ELSE
         SET FILTER TO AllTrim(rodzaj) == AllTrim(cFiltr) .OR. AllTrim(rodzaj) == "O"
      ENDIF
      //@ 8, 18 SAY 'Filtr: ' + rodzaj2str(cFiltr)
      dbGoTop()
      SEEK _stop
      IF .NOT. Found()
         lJestPusto := .T.
         @  9,12 say '   °                                                   '
         @ 10,12 say '   °                                                   '
         @ 11,12 say '   °                                                   '
         @ 12,12 say '   °                                                   '
         @ 13,12 say '   °                                                   '
         @ 14,12 say '   °                                                   '
         @ 15,12 say '   °                                                   '
         @ 16,12 say '   °                                                   '
         @ 17,12 say '   °                                                   '
         @ 18,12 say '   °                                                   '
         @ 19,12 say '   °                                                   '
         @ 20,12 say '   °                                                   '
         @ 21,12 say '   °                                                   '
      ELSE
         lJestPusto := .F.
      ENDIF
      //CLEAR TYPEAHEAD
      //_disp := .F.
      //pause(0)
      //if lastkey()#27.and.lastkey()#28
      keyboard Chr(0)
      //endif
   CASE kl==13
      IF lJestPusto
         CLEAR TYPEAHEAD
         kl := 0
      ENDIF
      ******************** ENDCASE
   endcase
enddo
SET FILTER TO
setcursor(CurrCur)
setcolor(CURR)

RETURN

/*----------------------------------------------------------------------*/


*################################## FUNKCJE #################################
function linia16
RETURN " " + AllTrim(RODZAJ) + " ° " + TRESC+[     ]+kwota(STAN,14,2)+[ ]
*############################################################################
