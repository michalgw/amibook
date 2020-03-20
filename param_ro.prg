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
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_R.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_Ro()

*############################# PARAMETRY POCZATKOWE #########################
if .not.file([param_r.mem])
   save to param_r all like parar_*
   return
endif
@  3,42 clear to 22,79
*################################# GRAFIKA ##################################
@  4,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@  5,42 say '    PARAMETRY DO OBLICZANIA KOREKT    '
@  6,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@  7,42 say '                                      '
@  8,42 say ' Krotkie terminy zaplaty do:     dni  '
@  9,42 say ' Korekta VAT gdy uplynie...:     dni  '
@ 10,42 say '                                      '
@ 11,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 12,42 say '                                      '
@ 13,42 say ' Korekta dla krotkich terminow        '
@ 14,42 say ' po terminie zaplaty        +    dni  '
@ 15,42 say '                                      '
@ 16,42 say ' Korekta dla dluzszych terminow       '
@ 17,42 say ' po zaliczeniu w koszty     +    dni  '
@ 18,42 say '                                      '
@ 19,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
*################################# OPERACJE #################################
do say_parroz
kl=0
do while kl#27
ColSta()
@ 1,47 say '[F1]-pomoc'
ColStd()
kl=inkey(0)
do case
*############################### MODYFIKACJA ################################
              case kl=109.or.kl=77
@ 1,47 say [          ]
   ColStb()
   center(23,[þ                       þ])
   ColSta()
     center(23,[M O D Y F I K A C J A])
     ColStd()
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
zparar_ter=parar_ter
zparar_vat=parar_vat
zparar_kok=parar_kok
zparar_kod=parar_kod
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  8,71 get zparar_ter picture "999"
@  9,71 get zparar_vat picture "999"
@ 14,71 get zparar_kok picture "999"
@ 17,71 get zparar_kod picture "999"
****************************
clear type
read_()
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
parar_ter=zparar_ter
parar_vat=zparar_vat
parar_kok=zparar_kok
parar_kod=zparar_kod
****************************
save to param_r all like parar_*
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do say_parroz
@ 23,0
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                             '
p[ 2]='     [M].....................modyfikacja     '
p[ 3]='     [Esc]...................wyj&_s.cie         '
p[ 4]='                                             '
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
ColStd()
pause(0)
if lastkey()#27.and.lastkey()#28
keyboard chr(lastkey())
endif
restore screen from scr_
_disp=.f.
******************** ENDCASE
endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say_parroz
clear type
set colo to w+
@  8,71 say parar_ter picture "999"
@  9,71 say parar_vat picture "999"
@ 14,71 say parar_kok picture "999"
@ 17,71 say parar_kod picture "999"
ColStd()
*############################################################################
