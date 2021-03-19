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

*################################# GRAFIKA ##################################
@  3,0 clear to 22,79
ColInf()
@  3,0 say '[ESC]-wyjscie                                                  [D]-wydruk ekranu'
ColStd()
*@  0,0 clear to 0,60
*@  3,0 say '                                                                                '
@  4,0 say '         ROZLICZENIE  U&__Z.YWANIA  PRYWATNEGO  SAMOCHODU  NR REJ. 99999999         '
@  5,0 say '                                                                                '
@  6,0 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
@  7,0 say 'M-C      LIMIT KM w Z&__L..         WYDATKI UDOKUMENTOWANE   KSI&__E.GOWANO  DO KSI&__E.GOW.'
@  8,0 say '     w miesi&_a.cu  narastaj&_a.co   w miesi&_a.cu  narastaj&_a.co  narastaj&_a.co   w miesi&_a.cu'
@  9,0 say '  1  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 10,0 say '  2  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 11,0 say '  3  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 12,0 say '  4  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 13,0 say '  5  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 14,0 say '  6  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 15,0 say '  7  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 16,0 say '  8  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 17,0 say '  9  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 18,0 say ' 10  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 19,0 say ' 11  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 20,0 say ' 12  úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú   úúú úúú.úú'
@ 21,0 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
@ 22,0 say '                                                                                '
*################################ OBLICZENIA ################################
select 4
if dostep('TAB_POJ')
   set inde to tab_poj
   seek [+]
   if eof().or.del#'+'
      kom(3,[*u],[ Najpierw wprowad&_z. informacje o stawkach za 1km ])
      return
   endif
else
   close_()
   return
endif
sele 3
if dostep('RACHPOJ')
   do setind with 'RACHPOJ'
else
   close_()
   return
endif
sele 2
if dostep('SAMOCHOD')
   set inde to samochod
   seek [+]+ident_fir
   if eof().or.del#'+'.or.firma#ident_fir
      kom(3,[*u],[ Najpierw wprowad&_z. informacje o u&_z.ywanych samochodach ])
      return
   endif
else
   close_()
   return
endif
sele 1
if dostep('EWIDPOJ')
   do setind with 'EWIDPOJ'
else
   close_()
   return
endif
zNRREJ=space(8)
do while .t.
   set curs on
   @ 4,63 get zNRREJ picture '!!! !!!!' valid v1_31()
   read
   if lastkey()=27
      set curs off
      exit
   endif
   set curs off
   select samochod
   seek '+'+ident_fir+znrrej
   @ 5,0 clear to 5,79
   if found()
      @ 5,9 say alltrim(marka)+' do cel&_o.w s&_l.u&_z.bowych za miesi&_a.c '+dos_p(upper(miesiac(val(miesiac))))+'.'+param_rok
   else
      kom(3,[*u],[ Brak tego samochodu w katalogu ])
      exit
   endif
   sumkm=0
   sumrach=0
   ksiegnar=0
   for x=1 to 12
       dozak=0
       if x>val(miesiac)
          exit
       endif
       do rozpoj1 with str(x,2)
       do rozpoj2 with str(x,2)
       @ 8+x,57 say ksiegnar pict '999 999.99'
       dozak=min(sumkm,sumrach)-ksiegnar
       @ 8+x,70 say dozak pict '999 999.99'
       ksiegnar=ksiegnar+dozak
   next
*   kom(1,[*u],[ Klawisz PrintScreen - wydruk rozliczenia ])
   @ 22,0 say '[D lub PrintScreen]-drukowanie ekranu    [Inny klawisz]-wpisanie nowych wartosci'
   kkk=inkey(0)
   if kkk=68.or.kkk=100
      DrukujEkran( , , 4, 20 )
   endif
   @ 22,0 say '                                                                                '
enddo
close data
*****************************************************************************
proc rozpoj1
*****************************************************************************
para miesx
_koniec="del#[+].or.firma#ident_fir.or.mc#miesx.or.nrrej#znrrej"
s9=0
sele ewidpoj
set orde to 2
seek [+]+ident_fir+miesx+znrrej
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*if &_koniec
*   @ 8+val(miesx),5 say s9 pict '999 999.99'
*   return
*endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sele samochod
seek [+]+ident_fir+znrrej
K4=pojemnosc
sele ewidpoj
do while .not.&_koniec
   sele ewidpoj
   k7=km
   zoddnia=param_rok+strtran(miesx+dzien,' ','0')
   sele tab_poj
   seek [+]+zoddnia
   if .not.found()
      skip -1
   endif
   if k4<=900
      k8=poj_900
   else
      k8=poj_901
   endif
   sele ewidpoj
   k9=_round(k8*k7,2)
   skip
   s9=s9+k9
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
@ 8+val(miesx),5 say s9 pict '999 999.99'
sumkm=sumkm+s9
@ 8+val(miesx),18 say sumkm pict '999 999.99'
return
*****************************************************************************
proc rozpoj2
*****************************************************************************
para miesx
_koniec="del#[+].or.firma#ident_fir.or.mc#miesx.or.nrrej#znrrej"
s5=0
s6=0
s7=0
sele rachpoj
set orde to 2
seek [+]+ident_fir+miesx+znrrej
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*if &_koniec
*   @ 8+val(miesx),31 say s7 pict '999 999.99'
*   return
*endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sele rachpoj
do while .not.&_koniec
   K5=netto
   K6=wartvat
   k7=k5+k6
   skip
   s5=s5+k5
   s6=s6+k6
   s7=s7+k7
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
@ 8+val(miesx),31 say s7 pict '999 999.99'
sumrach=sumrach+s7
@ 8+val(miesx),44 say sumrach pict '999 999.99'
return
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
