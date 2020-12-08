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
szP4RC1a=0
szP4RC1b=0
szP4RC2=0
szP4RC3=0
szP4RC4=0
szP4RC5=0
szP4RC6=0
szP4RC7=0
szP4RC8=0
szP4RC9=0
szP4RC10=0
szP4RC11=0
szP4RC12=0
szP4RC13=0
stP4RC1a=0
stP4RC1b=0
stP4RC2=0
stP4RC3=0
stP4RC4=0
stP4RC5=0
stP4RC6=0
stP4RC7=0
stP4RC8=0
stP4RC9=0
stP4RC10=0
stP4RC11=0
stP4RC12=0
stP4RC13=0
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
* dane z SUMA_MC
    sele SUMA_MC
    seek [+]+ident_fir+str(xa,2)
    zP4RC1a&XXa=P4il_pod
    zP4RC1b&XXa=P4sum_zal
    zP4RC2&XXa=P4nalzal33
*    zP4RC3&XXa=0
    zP4RC4&XXa=P4ogrzal
    zP4RC5&XXa=P4ogrzal33
    zP4RC6&XXa=P4dodzal
    zP4RC7&XXa=P4nadzwr
    zP4RC8&XXa=P4pfron
    zP4RC9&XXa=P4aktyw
    zP4RC10&XXa=P4zal13
*    zP4RC11&XXa=0
    zP4RC12a&XXa=P4potrac
    zP4RC12&XXa=P4wynagr
*    zP4RC13&XXa=0
* dane z tabeli PIT-4R
    sele TABPIT4R
    seek [+]+ident_fir+str(xa,2)
    tP4RC1a&XXa=Ilpod
    tP4RC1b&XXa=Nalzal
    tP4RC2&XXa=Nalzal33
*    tP4RC3&XXa=0
    tP4RC4&XXa=Ogrzal
    tP4RC5&XXa=Ogrzal32
    tP4RC6&XXa=Dodzal
    tP4RC7&XXa=Nadzwr
    tP4RC8&XXa=Pfron
    tP4RC9&XXa=Aktyw
    tP4RC10&XXa=Zal13
*    tP4RC11&XXa=0
*    tP4RC12&XXa=Wynagr
*    tP4RC13&XXa=0
next
//P4menu=array(4)
//P4menu[1]:=' Sekcja C.1 do C.3 - ilo&_s.&_c. podatnik&_o.w, nale&_z.ne zaliczki i suma zaliczek   '
//P4menu[2]:=' Sekcje C.4 do C.7 - ograniczenia, dodatkowe pobrania, nadp&_l.aty i zwroty  '
//P4menu[3]:=' Sekcje C.8 do C.11 - PFRON, dzia&_l.alno&_s.&_c. z art.13, aktywizacja i suma     '
//P4menu[4]:=' Sekcje C.12 i C.13 - wynagrodzenie za terminow&_a. wp&_l.at&_e. i kwota do wp&_l.aty '

P4menu=Array(5)
P4menu[1]:=' Sekcja C.1 do C.2 - ilo&_s.&_c. podatnik&_o.w, nale&_z.ne zaliczki                   '
P4menu[2]:=' Sekcja C.3 do C.5 - dzia&_l.alno&_s.&_c. z art.13, aktywizacja i suma             '
P4menu[3]:=' Sekcje C.6 do C.8 - ograniczenia, dodatkowe pobrania                     '
P4menu[4]:=' Sekcje C.9 i C.10 - PFRON i suma                                         '
P4menu[5]:=' Sekcje C.11 i C.12 - wynagrodzenie za terminow&_a. wp&_l.at&_e. i kwota do wp&_l.aty '

@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say padc('E D Y C J A   P &__O. L   P I T - 4 R',80)
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
P4sekcja=1
*ColPro()
set colo to w+
@ 9,5 say 'Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '
set colo to w
P4infotab(1)
P4sekcja=achoice(4,3,9,76,P4menu,.t.,"P4infosek",1)
ColStd()
*################################# OPERACJE #################################
*kl=lastkey()
*siacpla='  '
*close_()
*################################## FUNKCJE #################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± P4infosek ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o sekcjach PIT-4R                                    ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func P4infosek(nMode,nCurEl,nRowPos)
   local nRetVal:=AC_CONT
   local nKey:=lastkey()

   do case
   case nMode==AC_IDLE
        P4infotab(nCurEl)
        nRetVal:=AC_CONT
   case nMode==AC_EXCEPT
        do case
*        case nKey=13
*             nRetVal:=AC_SELECT
        case nCurEl=1.and.(nKey=73.or.nKey=105)
              do PrcP4RC1a
              nRetVal:=AC_CONT
        case nCurEl=1.and.(nKey=90.or.nKey=122)
              do PrcP4RC1b
              nRetVal:=AC_CONT
        case nCurEl=1.and.nKey=50
              do PrcP4RC2
              nRetVal:=AC_CONT
        CASE nCurEl = 2 .AND. nKey = Asc('3')
              do PrcP4RC10
              nRetVal:=AC_CONT
        CASE nCurEl = 2 .AND. nKey = Asc('4')
              do PrcP4RC9
              nRetVal:=AC_CONT
        case nCurEl=3.and.nKey=54
              do PrcP4RC4
              nRetVal:=AC_CONT
        case nCurEl=3.and.nKey=55
              do PrcP4RC5
              nRetVal:=AC_CONT
        case nCurEl=3.and.nKey=56
              do PrcP4RC6
              nRetVal:=AC_CONT
//        case nCurEl=3.and.nKey=57
//              do PrcP4RC7
//              nRetVal:=AC_CONT
        case nCurEl=4.and.nKey=57
              do PrcP4RC8
              nRetVal:=AC_CONT
//        case nCurEl=4.and.nKey=48
//              do PrcP4RC9
//              nRetVal:=AC_CONT
//        case nCurEl=4.and.nKey=57
//              do PrcP4RC10
//              nRetVal:=AC_CONT
        case nCurEl=5.and.(nKey=37.or.nKey=53)
              do PrcP4RC12a
              nRetVal:=AC_CONT
        case nKey=27
             nRetVal:=AC_ABORT
        other
             nRetVal:=AC_GOTO
        endcase
   endcase
return nRetVal
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± P4infotab ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje z tabel PIT-4R                                       ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func P4infotab(nCurEl)

szP4RC1a=0
szP4RC1b=0
szP4RC2=0
szP4RC3=0
szP4RC4=0
szP4RC5=0
szP4RC6=0
szP4RC7=0
szP4RC8=0
szP4RC9=0
szP4RC10=0
szP4RC11=0
szP4RC12=0
szP4RC13=0

stP4RC1a=0
stP4RC1b=0
stP4RC2=0
stP4RC3=0
stP4RC4=0
stP4RC5=0
stP4RC6=0
stP4RC7=0
stP4RC8=0
stP4RC9=0
stP4RC10=0
stP4RC11=0
stP4RC12=0
stP4RC13=0

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')

         stP4RC1a=stP4RC1a+tP4RC1a&XXa
         szP4RC1a=szP4RC1a+zP4RC1a&XXa
         stP4RC1b=stP4RC1b+tP4RC1b&XXa
         szP4RC1b=szP4RC1b+zP4RC1b&XXa
         stP4RC2=stP4RC2+tP4RC2&XXa
         szP4RC2=szP4RC2+zP4RC2&XXa

         stP4RC4=stP4RC4+tP4RC4&XXa
         szP4RC4=szP4RC4+zP4RC4&XXa
         stP4RC5=stP4RC5+tP4RC5&XXa
         szP4RC5=szP4RC5+zP4RC5&XXa
         stP4RC6=stP4RC6+tP4RC6&XXa
         szP4RC6=szP4RC6+zP4RC6&XXa
         stP4RC7=stP4RC7+tP4RC7&XXa
         szP4RC7=szP4RC7+zP4RC7&XXa

         stP4RC8=stP4RC8+tP4RC8&XXa
         szP4RC8=szP4RC8+zP4RC8&XXa
         stP4RC9=stP4RC9+tP4RC9&XXa
         szP4RC9=szP4RC9+zP4RC9&XXa
         stP4RC10=stP4RC10+tP4RC10&XXa
         szP4RC10=szP4RC10+zP4RC10&XXa

         szP4RC12=szP4RC12+zP4RC12&XXa
        next
set colo to w+
@ 9,5 clear to 22,79
do case
case nCurEl=1
*@  9, 0 say ' M-c Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '
     @ 9,5 say 'Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2                      '

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
         //@ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
     next
     @ 22,8  say stP4RC1a pict '999'
     @ 22,17 say szP4RC1a pict '999'
     @ 22,23 say stP4RC1b pict '99999'
     @ 22,32 say szP4RC1b pict '99999'
     @ 22,41 say stP4RC2 pict '99999'
     @ 22,50 say szP4RC2 pict '99999'
     //@ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
case nCurEl=2
*@  9, 0 say ' M-c Il.podat Il.podat Zaliczki Zaliczki SekcjaC2 SekcjaC2 SekcjaC3             '
     @ 9,5 say 'SekcjaC3 SekcjaC3 SekcjaC4 SekcjaC4 SekcjaC5                               '

     ColInf()
     @ 9,21 say '3'
     @ 9,39 say '4'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say tP4RC10&XXa  pict '99999'
         @ 9+xa,14 say zP4RC10&XXa  pict '99999'
         @ 9+xa,23 say tP4RC9&XXa pict '99999'
         @ 9+xa,32 say zP4RC9&XXa pict '99999'
*        zP4RC3&XXa=0
         @ 9+xa,41 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa pict '99999'
     next
     @ 22,5  say stP4RC10 pict '99999'
     @ 22,14 say szP4RC10 pict '99999'
     @ 22,23 say stP4RC9 pict '99999'
     @ 22,32 say szP4RC9 pict '99999'
     @ 22,41 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2+szP4RC9+stP4RC9+szP4RC10+stP4RC10 pict '99999'
case nCurEl=3
     @ 9,5 say 'SekcjaC6 SekcjaC6 SekcjaC7 SekcjaC7 SekcjaC8 SekcjaC8                      '

     ColInf()
     @ 9,21 say '6'
     @ 9,39 say '7'
     @ 9,57 say '8'
//     @ 9,75 say '9'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say tP4RC4&XXa pict '99999'
         @ 9+xa,14 say zP4RC4&XXa pict '99999'
         @ 9+xa,23 say tP4RC5&XXa pict '99999'
         @ 9+xa,32 say zP4RC5&XXa pict '99999'
         @ 9+xa,41 say tP4RC6&XXa pict '99999'
         @ 9+xa,50 say zP4RC6&XXa pict '99999'
//         @ 9+xa,59 say tP4RC7&XXa pict '99999'
//         @ 9+xa,68 say zP4RC7&XXa pict '99999'
     next
     @ 22,5  say stP4RC4 pict '99999'
     @ 22,14 say szP4RC4 pict '99999'
     @ 22,23 say stP4RC5 pict '99999'
     @ 22,32 say szP4RC5 pict '99999'
     @ 22,41 say stP4RC6 pict '99999'
     @ 22,50 say szP4RC6 pict '99999'
//     @ 22,59 say stP4RC7 pict '99999'
//     @ 22,68 say szP4RC7 pict '99999'
case nCurEl=4
     @ 9,5 say 'SekcjC9  SekcjC9  SekcjC10                                                 '

     ColInf()
     @ 9,20 say '9'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say tP4RC8&XXa  pict '99999'
         @ 9+xa,14 say zP4RC8&XXa  pict '99999'
         @ 9+xa,23 say ((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa) pict '99999'
     next
     @ 22,5  say stP4RC8 pict '99999'
     @ 22,14 say szP4RC8 pict '99999'
     @ 22,23 say ((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8) pict '99999'
case nCurEl=5
     @ 9,5 say 'SekcjC10 % wynagr SekcjC11 SekcjC12                                                 '

     ColInf()
     @ 9,14 say '%'
     set colo to w+

     for xa=1 to 12
         xxa=strtran(str(xa,2),' ','0')
         @ 9+xa,5  say ((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa) pict '99999'
         @ 9+xa,17 say zP4RC12a&XXa pict '99.99'
         @ 9+xa,23 say zP4RC12&XXa pict '99999'
         @ 9+xa,32 say _round((((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa))-zP4RC12&XXa,0) pict '99999'
     next
     @ 22,5  say ((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8) pict '99999'
     @ 22,23 say szP4RC12 pict '99999'
     @ 22,32 say _round((((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8))-szP4RC12,0) pict '99999'
endcase
set colo to w
return
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC1a ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC1a
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC1a&XXa,'999')
       @ 9+xa,17 prompt rob
   next
   korekP4=menu(korekP4)
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
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,17 get zP4RC1a&XXa pict '@R 999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4il_pod],zP4RC1a&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC1a=0
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC1a=szP4RC1a+zP4RC1a&XXa
   next
   set colo to w+
   @ 22,17 say szP4RC1a pict '999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,17 say zP4RC1a&XXa pict '999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC1b ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC1b
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC1b&XXa,'99999')
       @ 9+xa,32 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,32 get zP4RC1b&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4sum_zal],zP4RC1b&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC1b=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC1b=szP4RC1b+zP4RC1b&XXa
       @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
   next
   @ 22,32 say szP4RC1b pict '99999'
   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,32 say zP4RC1b&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC2  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC2
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC2&XXa,'99999')
       @ 9+xa,50 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,50 get zP4RC2&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4nalzal33],zP4RC2&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC2=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC2=szP4RC2+zP4RC2&XXa
       @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
   next
   @ 22,50 say szP4RC2 pict '99999'
   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,50 say zP4RC2&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC4  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC4
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC4&XXa,'99999')
       @ 9+xa,14 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,14 get zP4RC4&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4ogrzal],zP4RC4&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC4=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC4=szP4RC4+zP4RC4&XXa
*       @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
   next
   @ 22,14 say szP4RC4 pict '99999'
*   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,14 say zP4RC4&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC5  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC5
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC5&XXa,'99999')
       @ 9+xa,32 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,32 get zP4RC5&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4ogrzal33],zP4RC5&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC5=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC5=szP4RC5+zP4RC5&XXa
*       @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
   next
   @ 22,32 say szP4RC5 pict '99999'
*   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,32 say zP4RC5&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC6  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC6
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC6&XXa,'99999')
       @ 9+xa,50 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,50 get zP4RC6&XXa pict '@R 99999' when korekP4<=4
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4dodzal],zP4RC6&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC6=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC6=szP4RC6+zP4RC6&XXa
*       @ 9+xa,59 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa pict '99999'
   next
   @ 22,50 say szP4RC6 pict '99999'
*   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,50 say zP4RC6&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC7  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC7
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC7&XXa,'99999')
       @ 9+xa,68 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,68 get zP4RC7&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4nadzwr],zP4RC7&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC7=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC7=szP4RC7+zP4RC7&XXa
*       @ 9+x,59 say zP4RC1b&XX+tP4RC1b&XX+zP4RC2&XX+tP4RC2&XX pict '99999'
   next
   @ 22,68 say szP4RC7 pict '99999'
*   @ 22,59 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,68 say zP4RC7&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC8  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC8
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC8&XXa,'99999')
       @ 9+xa,14 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,14 get zP4RC8&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4pfron],zP4RC8&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC8=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC8=szP4RC8+zP4RC8&XXa
       @ 9+xa,59 say ((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa) pict '99999'
   next
   @ 22,14 say szP4RC8 pict '99999'
   @ 22,59 say ((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8) pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,14 say zP4RC8&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC9  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC9
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC9&XXa,'99999')
       @ 9+xa,32 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,32 get zP4RC9&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4aktyw],zP4RC9&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC9=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC9=szP4RC9+zP4RC9&XXa
       @ 9+xa,41 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa pict '99999'
   next
   @ 22,32 say szP4RC9 pict '99999'
   @ 22,41 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2+szP4RC9+stP4RC9+szP4RC10+stP4RC10 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,32 say zP4RC9&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC10 ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC10
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC10&XXa,'99999')
       @ 9+xa,14 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,14 get zP4RC10&XXa pict '@R 99999'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4zal13],zP4RC10&XXa)
            COMMIT
            unlock
         endif
      endif
      @ 23,0
   endif
   szP4RC10=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC10=szP4RC10+zP4RC10&XXa
       @ 9+xa,41 say zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa pict '99999'
   next
   @ 22,14 say szP4RC10 pict '99999'
   @ 22,41 say szP4RC1b+stP4RC1b+szP4RC2+stP4RC2+szP4RC9+stP4RC9+szP4RC10+stP4RC10 pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,14 say zP4RC10&XXa pict '99999'
next
setcolor(CURR)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PrcP4RC12a ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga wprowadzania korekt ilosci podatnikow                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc PrcP4RC12a
korekP4=val(miesiac)
CURR=ColPro()
do while .t.
   ColPro()
   set curs off
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       rob=transform(zP4RC12a&XXa,'99.99')
       @ 9+xa,17 prompt rob
   next
   korekP4=menu(korekP4)
   if lastkey()=27
      exit
   endif
   if lastkey()=13
      ColStb()
      center(23,[þ                       þ])
      ColSta()
      center(23,  [M O D Y F I K A C J A])
      ColStd()
      xxa=strtran(str(korekP4,2),' ','0')
      @ 9+korekP4,17 get zP4RC12a&XXa pict '@R  9.99'
      set conf on
      set curs on
      read
      set curs off
      set conf off
      if lastkey()=13
         zP4RC12&XXa=_round((zP4RC12a&XXa/100)*(((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa)),0)
         sele SUMA_MC
         seek [+]+ident_fir+str(korekP4,2)
         if found()
            do BLOKADAR
            repl_([P4potrac],zP4RC12a&XXa)
            repl_([P4wynagr],zP4RC12&XXa)
            COMMIT
            unlock
         endif
         @ 9+xa,23 say zP4RC12&XXa pict '99999'
      endif
      @ 23,0
   endif
   szP4RC12a=0
   szP4RC12=0
   set colo to w+
   for xa=1 to 12
       xxa=strtran(str(xa,2),' ','0')
       szP4RC12a=szP4RC12a+zP4RC12a&XXa
       szP4RC12=szP4RC12+zP4RC12&XXa
       @ 9+xa,17 say zP4RC12a&XXa pict '99.99'
       @ 9+xa,23 say zP4RC12&XXa pict '99999'
       @ 9+xa,32 say _round((((zP4RC1b&XXa+tP4RC1b&XXa+zP4RC2&XXa+tP4RC2&XXa)+(zP4RC5&XXa+tP4RC5&XXa+zP4RC6&XXa+tP4RC6&XXa+zP4RC9&XXa+tP4RC9&XXa+zP4RC10&XXa+tP4RC10&XXa))-(zP4RC4&XXa+tP4RC4&XXa+zP4RC7&XXa+tP4RC7&XXa+zP4RC8&XXa+tP4RC8&XXa))-zP4RC12&XXa,0) pict '99999'
   next
   @ 22,17 say szP4RC12a pict '99.99'
   @ 22,23 say szP4RC12 pict '99999'
   @ 22,32 say _round((((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8))-szP4RC12,0) pict '99999'
enddo
set colo to w+
for xa=1 to 12
    xxa=strtran(str(xa,2),' ','0')
    @ 9+xa,17 say zP4RC12a&XXa pict '99.99'
    @ 9+xa,23 say zP4RC12&XXa pict '99999'
next
setcolor(CURR)
*############################################################################

*    zP4RC12a&XX=P4potrac
*    zP4RC12&XX=P4wynagr
*         @ 9+x,5  say ((zP4RC1b&XX+tP4RC1b&XX+zP4RC2&XX+tP4RC2&XX)+(zP4RC5&XX+tP4RC5&XX+zP4RC6&XX+tP4RC6&XX+zP4RC9&XX+tP4RC9&XX+zP4RC10&XX+tP4RC10&XX))-(zP4RC4&XX+tP4RC4&XX+zP4RC7&XX+tP4RC7&XX+zP4RC8&XX+tP4RC8&XX) pict '99999'
*         @ 9+x,17 say zP4RC12a&XX pict '99.99'
*         @ 9+x,23 say zP4RC12&XX pict '99999'
*         @ 9+x,32 say (((zP4RC1b&XX+tP4RC1b&XX+zP4RC2&XX+tP4RC2&XX)+(zP4RC5&XX+tP4RC5&XX+zP4RC6&XX+tP4RC6&XX+zP4RC9&XX+tP4RC9&XX+zP4RC10&XX+tP4RC10&XX))-(zP4RC4&XX+tP4RC4&XX+zP4RC7&XX+tP4RC7&XX+zP4RC8&XX+tP4RC8&XX))-zP4RC12&XX pict '99999'
*     next
*     @ 22,5  say ((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8) pict '99999'
*     @ 22,23 say szP4RC12 pict '99999'
*     @ 22,32 say (((szP4RC1b+stP4RC1b+szP4RC2+stP4RC2)+(szP4RC5+stP4RC5+szP4RC6+stP4RC6+szP4RC9+stP4RC9+szP4RC10+stP4RC10))-(szP4RC4+stP4RC4+szP4RC7+stP4RC7+szP4RC8+stP4RC8))-szP4RC12 pict '99999'
