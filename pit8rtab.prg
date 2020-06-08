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

#include "achoice.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
para mieskart
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,kluc,ins,nr_rec,wiersz,f10,rec,fou,mieslok
public z_dowyp
zData_wwyp=date()
zkwota_wwyp=0
mieslok=mieskart

for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
* dane z SUMA_MC
    sele SUMA_MC
    seek [+]+ident_fir+str(xa,2)
    zP8RC1&XXa=P8zlecry
    zP8RC2&XXa=P8wynagr
    zP8RC3&XXa=P8potrac
    zP8RC4&XXa=P8zlecin
* dane z tabeli PIT-4R
    sele TABPIT8R
    seek [+]+ident_fir+str(xa,2)
    tP8RC12&XXa=zlecrycz
    tP8RC13&XXa=wynagr
    tP8RC6&XXa := nalzal
next
P8menu=array(1)
P8menu[1]:=' Sekcje C.1 do C.16 - kwoty pobranego podatku, wynagrodzenie za wp&_l.aty    '
*P4menu[2]:=' Sekcje C.4 do C.7 - ograniczenia, dodatkowe pobrania, nadp&_l.aty i zwroty  '
*P4menu[3]:=' Sekcje C.8 do C.11 - PFRON, dzia&_l.alno&_s.&_c. z art.13, aktywizacja i suma     '
*P4menu[4]:=' Sekcje C.12 i C.13 - wynagrodzenie za terminow&_a. wp&_l.at&_e. i kwota do wp&_l.aty '
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say padc('E D Y C J A   P &__O. L   P I T - 8 AR',80)
@  4, 0 say '                                                                                '
@  5, 0 say '                                                                                '
@  6, 0 say '                                                                                '
@  7, 0 say '                                                                                '
@  8, 0 say '                                                                                '
*@  9, 0 say ' M-c Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '

@  9, 0 say ' M-c                                                                            '
@ 10, 0 say '  1                                                                             '
@ 11, 0 say '  2                                                                             '
@ 12, 0 say '  3                                                                             '
@ 13, 0 say '  4                                                                             '
@ 14, 0 say '  5                                                                             '
@ 15, 0 say '  6                                                                             '
@ 16, 0 say '  7                                                                             '
@ 17, 0 say '  8                                                                             '
@ 18, 0 say '  9                                                                             '
@ 19, 0 say ' 10                                                                             '
@ 20, 0 say ' 11                                                                             '
@ 21, 0 say ' 12                                                                             '
@ 22, 0 say 'SUMA                                                                            '
*ColInf()
*@  9,14 say 'I'
*@  9,32 say 'Z'
*@  9,57 say '2'
*ColStd()
P8sekcja=1
*ColPro()
set colo to w+
@ 9,5 say 'Sek.1-12 SekcjC13 SekcjC13 SekcjC14 % wynagr SekcjC15 SekcjC16                      '
*@ 9,5 say 'Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '
set colo to w
P8infotab(1)
P8sekcja=achoice(4,3,8,76,P8menu,.t.,"P8infosek",1)
ColStd()
*################################# OPERACJE #################################
*kl=lastkey()
*siacpla='  '
*close_()
*################################## FUNKCJE #################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± P8infosek ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o sekcjach PIT-8AR                                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func P8infosek(nMode,nCurEl,nRowPos)
   local nRetVal:=AC_CONT
   local nKey:=lastkey()

   do case
   case nMode==AC_IDLE
        P8infotab(nCurEl)
        nRetVal:=AC_CONT
   case nMode==AC_EXCEPT
        do case
*        case nKey=13
*             nRetVal:=AC_SELECT
        case nCurEl=1.and.nKey=49
              do PrcP8RC1
              nRetVal:=AC_CONT
        case nCurEl=1.and.nKey=51
              do PrcP8RC13
              nRetVal:=AC_CONT
        case nCurEl=1.and.(nKey=37.or.nKey=53)
              do PrcP8RC15a
              nRetVal:=AC_CONT
        case nKey=27
             nRetVal:=AC_ABORT
        other
             nRetVal:=AC_GOTO
        endcase
   endcase
return nRetVal
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± P8infotab ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje z tabel PIT-8AR                                      ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func P8infotab(nCurEl)

szP8RC1=0
szP8RC2=0
szP8RC3=0
szP8RC4=0
szP8RC12=0
szP8RC13=0
szP8RC13a=0
szP8RC6 := 0

stP8RC1=0
stP8RC2=0
stP8RC3=0
stP8RC4=0
stP8RC12=0
stP8RC13=0
stP8RC13a=0
stP8RC6 := 0

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')

         stP8RC12=stP8RC12+tP8RC12&XXa
         stP8RC13=stP8RC13+tP8RC13&XXa
         stP8RC6=stP8RC6+tP8RC6&XXa

         szP8RC1=szP8RC1+zP8RC1&XXa
         szP8RC2=szP8RC2+zP8RC2&XXa
         szP8RC3=szP8RC3+zP8RC3&XXa
         szP8RC4=szP8RC4+zP8RC4&XXa

        next

set colo to w+
@ 9,5 clear to 22,79
do case
case nCurEl=1
     @ 9,5 say 'Sek.1-12 SekcjC13 SekcjC13 SekcjC14 % wynagr SekcjC15 SekcjC16 SekcjaC6             '
*     @ 9,5 say 'SekcjC11 % wynagr SekcjC12 SekcjC13                                                 '

     ColInf()
     @ 9,9  say '1'
     @ 9,30 say '3'
     @ 9,41 say '%'
     set colo to w+

*   zP8RC1&XXa=P8zlecry
*   zP8RC2&XXa=P8wynagr
*   zP8RC3&XXa=P8potrac
*   zP8RC4&XXa=P8zlecin
* dane z tabeli PIT-4R
*   sele TABPIT8R
*   seek [+]+ident_fir+str(xa,2)
*   tP8RC12&XXa=zlecrycz
*   tP8RC13&XXa=wynagr

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,7  say zP8RC1&XXa pict '99999'
         @ 9+xa,16 say tP8RC12&XXa pict '99999'
         @ 9+xa,25 say zP8RC4&XXa pict '99999'
         @ 9+xa,34 say zP8RC1&XXa+tP8RC12&XXa+zP8RC4&XXa pict '99999'
         @ 9+xa,43 say zP8RC3&XXa pict '99.99'
         @ 9+xa,52 say zP8RC2&XXa pict '99999'
         @ 9+xa,61 say (zP8RC1&XXa+tP8RC12&XXa+zP8RC4&XXa)-zP8RC2&XXa pict '99999'
         @ 9+xa,70 say tP8RC6&XXa pict '99999'
     next
     @ 22,7  say szP8RC1 pict '99999'
     @ 22,16 say stP8RC12 pict '99999'
     @ 22,25 say szP8RC4 pict '99999'
     @ 22,34 say szP8RC1+stP8RC12+szP8RC4 pict '99999'
     @ 22,52 say szP8RC2 pict '99999'
     @ 22,61 say (szP8RC1+stP8RC12+szP8RC4)-szP8RC2 pict '99999'
     @ 22,70 say stP8RC6 pict '99999'

case nCurEl=2
*@  9, 0 say ' M-c Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '
     @ 9,5 say 'Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '

     ColInf()
     @ 9,14 say 'I'
     @ 9,32 say 'Z'
     @ 9,57 say '2'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,8  say tP4RC1a&XXa pict '999'
         @ 9+xa,17 say zP4RC1a&XXa pict '999'
         @ 9+xa,23 say tP4RC1b&XXa pict '99999'
         @ 9+xa,32 say zP4RC1b&XXa pict '99999'
         @ 9+xa,41 say tP4RC2&XXa pict '99999'
         @ 9+xa,50 say zP4RC2&XXa pict '99999'
*        zP4RC3&XXa=0
         @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
     next
     @ 22,8  say stP4RC1a pict '999'
     @ 22,17 say szP4RC1a pict '999'
     @ 22,23 say stP4RC1b pict '99999'
     @ 22,32 say szP4RC1b pict '99999'
     @ 22,41 say stP4RC2 pict '99999'
     @ 22,50 say szP4RC2 pict '99999'
     @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
case nCurEl=3
     @ 9,5 say 'SekcjaC4 SekcjaC4 SekcjaC5 SekcjaC5 SekcjaC6 SekcjaC6 SekcjaC7 SekcjaC7    '

     ColInf()
     @ 9,21 say '4'
     @ 9,39 say '5'
     @ 9,57 say '6'
     @ 9,75 say '7'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say tP4RC4&XXa pict '99999'
         @ 9+xa,14 say zP4RC4&XXa pict '99999'
         @ 9+xa,23 say tP4RC5&XXa pict '99999'
         @ 9+xa,32 say zP4RC5&XXa pict '99999'
         @ 9+xa,41 say tP4RC6&XXa pict '99999'
         @ 9+xa,50 say zP4RC6&XXa pict '99999'
         @ 9+xa,59 say tP4RC7&XXa pict '99999'
         @ 9+xa,68 say zP4RC7&XXa pict '99999'
     next
     @ 22,5  say stP4RC4 pict '99999'
     @ 22,14 say szP4RC4 pict '99999'
     @ 22,23 say stP4RC5 pict '99999'
     @ 22,32 say szP4RC5 pict '99999'
     @ 22,41 say stP4RC6 pict '99999'
     @ 22,50 say szP4RC6 pict '99999'
     @ 22,59 say stP4RC7 pict '99999'
     @ 22,68 say szP4RC7 pict '99999'
case nCurEl=4
     @ 9,5 say 'SekcjaC8 SekcjaC8 SekcjaC9 SekcjaC9 SekcjC10 SekcjC10 SekcjC11             '

     ColInf()
     @ 9,21 say '8'
     @ 9,39 say '9'
     @ 9,57 say '0'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say tP4RC8&XXa  pict '99999'
         @ 9+xa,14 say zP4RC8&XXa  pict '99999'
         @ 9+xa,23 say tP4RC10&XXa pict '99999'
         @ 9+xa,32 say zP4RC10&XXa pict '99999'
         @ 9+xa,41 say tP4RC9&XXa  pict '99999'
         @ 9+xa,50 say zP4RC9&XXa  pict '99999'
         @ 9+xa,59 say ((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa) pict '99999'
     next
     @ 22,5  say stP4RC8 pict '99999'
     @ 22,14 say szP4RC8 pict '99999'
     @ 22,23 say stP4RC10 pict '99999'
     @ 22,32 say szP4RC10 pict '99999'
     @ 22,41 say stP4RC9 pict '99999'
     @ 22,50 say szP4RC9 pict '99999'
     @ 22,59 say ((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8) pict '99999'
endcase
set colo to w
return
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP8RC1 ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP8RC1
korekP8=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP8RC1&XXa,'99999')
       @ 9+xa,7 prompt rob
   next
   korekP8=menu(korekP8)
*   ColStd()
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP8,2),' ','0')
      @ 9+korekP8,7 get zP8RC1&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP8,2)
         if found()
            do BLOKADAR
            repl_([P8zlecry],zP8RC1&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP8RC1=0
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP8RC1=szP8RC1+zP8RC1&XXa
   next
   set colo to w+
   @ 22,7 say szP8RC1 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,7 say zP8RC1&XXa pict '99999'
next
setcolor(CURR)

P8infotab(1)

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP8RC13 ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP8RC13
korekP8=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP8RC4&XXa,'99999')
       @ 9+xa,25 prompt rob
   next
   korekP8=menu(korekP8)
*   ColStd()
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP8,2),' ','0')
      @ 9+korekP8,25 get zP8RC4&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP8,2)
         if found()
            do BLOKADAR
            repl_([P8zlecin],zP8RC4&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP8RC4=0
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP8RC4=szP8RC4+zP8RC4&XXa
   next
   set colo to w+
   @ 22,25 say szP8RC4 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,25 say zP8RC4&XXa pict '99999'
next
setcolor(CURR)

P8infotab(1)

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP8RC15a ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP8RC15a
korekP8=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP8RC3&XXa,'99.99')
       @ 9+xa,43 prompt rob
   next
   korekP8=menu(korekP8)
*   ColStd()
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP8,2),' ','0')
      @ 9+korekP8,43 get zP8RC3&XXa pict '@R 99.99'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         zP8RC2&XXa=_round((zP8RC3&XXa/100)*(zP8RC1&XXa+zP8RC4&XXa+tP8RC12&XXa),0)
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP8,2)
         if found()
            do BLOKADAR
            repl_([P8potrac],zP8RC3&XXa)
            repl_([P8wynagr],zP8RC2&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP8RC2=0
   szP8RC3=0
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP8RC2=szP8RC2+zP8RC2&XXa
       szP8RC3=szP8RC3+zP8RC3&XXa
       @ 9+xa,43 say zP8RC3&XXa pict '99.99'
       @ 9+xa,52 say zP8RC2&XXa pict '99999'
   next
   set colo to w+
   @ 22,52 say szP8RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,43 say zP8RC3&XXa pict '99.99'
    @ 9+xa,52 say zP8RC2&XXa pict '99999'
next
setcolor(CURR)

P8infotab(1)

*############################################################################
