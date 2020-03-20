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
*±±±±±± TAB_RYCZ ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul stawek podatku zrycz. przechowywanych w pliku TAB_RYCZ.MEM          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Tab_Rycz()

if .not.file([tab_rycz.mem])
   public staw_hand,staw_prod,staw_uslu,staw_ry20,staw_ry17,staw_ry10
   staw_hand=0.03
   staw_prod=0.055
   staw_uslu=0.085
   staw_ry20=0.2
   staw_ry17=0.17
   staw_ry10=0.1
   save to tab_rycz all like staw_*
   return
endif
zstaw_hand=staw_hand*100
zstaw_prod=staw_prod*100
zstaw_uslu=staw_uslu*100
zstaw_ry20=staw_ry20*100
zstaw_ry17=staw_ry17*100
zstaw_ry10=staw_ry10*100
*################################# GRAFIKA ##################################
ColStd()
@ 3,42 clear to 22,79
@  9,48 say 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
@ 10,48 say 'º   Rodzaj  ³  Stawka º'
@ 11,48 say 'º sprzeda&_z.y ³    %    º'
@ 12,48 say 'ºÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄº'
@ 13,48 say 'º Handel    ³         º'
@ 14,48 say 'º Produkcja ³         º'
@ 15,48 say 'º Us&_l.ugi    ³         º'
@ 16,48 say 'º Wolne zaw.³         º'
@ 17,48 say 'º Inne us&_l.u.³         º'
@ 18,48 say 'º Prawa maj.³         º'
@ 19,48 say 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
*################################# OPERACJE #################################
do say_r
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
           *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
           @ 13,63 get zstaw_hand pict '99.99'
           @ 14,63 get zstaw_prod pict '99.99'
           @ 15,63 get zstaw_uslu pict '99.99'
           @ 16,63 get zstaw_ry20 pict '99.99'
           @ 17,63 get zstaw_ry17 pict '99.99'
           @ 18,63 get zstaw_ry10 pict '99.99'
           ****************************
           clear type
           read_()
           if lastkey()=27
              break
           endif
           *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
           staw_hand=zstaw_hand/100
           staw_prod=zstaw_prod/100
           staw_uslu=zstaw_uslu/100
           staw_ry20=zstaw_ry20/100
           staw_ry17=zstaw_ry17/100
           staw_ry10=zstaw_ry10/100
           save to tab_rycz all like staw_*
     *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
     end
     do say_r
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
close_()
*################################## FUNKCJE #################################
procedure say_r
clear type
set color to w+
@ 13,63 say zstaw_hand pict '99.99'
@ 14,63 say zstaw_prod pict '99.99'
@ 15,63 say zstaw_uslu pict '99.99'
@ 16,63 say zstaw_ry20 pict '99.99'
@ 17,63 say zstaw_ry17 pict '99.99'
@ 18,63 say zstaw_ry10 pict '99.99'
ColStd()
*############################################################################
