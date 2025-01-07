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

               private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
               private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep
               begin sequence
               @ 1,47 say space(10)
               *-----parametry wewnetrzne-----
               _papsz=1
               _lewa=1
               _prawa=116
               _strona=.t.
               _czy_mon=.t.
               _czy_close=.t.
               czesc=1
               *------------------------------
               _szerokosc=116
               _koniec="del#[+].or.firma#ident_fir.or.substr(dtos(DATA_WYP),1,6)#PARAM_ROK+strtran(MIESIAC,' ','0')"
*@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
sele 2
if .not.dostep('PRAC')
   break
else
   do SETIND with 'PRAC'
   set orde to 4
endif
sele 1
if dostep('UMOWY')
   do SETIND with 'UMOWY'
else
   break
endif
set orde to 4
seek [+]+ident_fir+param_rok+strtran(MIESIAC,' ','0')
if &_koniec
   kom(3,[*w],[b r a k   d a n y c h])
   break
endif
mon_drk([ö]+procname())
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk([ FIRMA: ]+SYMBOL_FIR+[        Lista innych wyp&_l.at w miesi&_a.cu ]+miesiac+'.'+param_rok)
mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³   Data   ³ Nr  ³   Data   ³  Warto&_s.&_c.  ³    Do     ³         N A Z W I S K O        ³     I M I E     ³   PESEL   ³])
mon_drk([³  wyp&_l.aty ³umowy³   umowy  ³   brutto  ³  wyp&_l.aty  ³                                ³                 ³           ³])
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ])
store 0 to suma1,suma2
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
do while .not.&_koniec
   *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
*  set century off
   k1=dtoc(data_wyp)
   k2= SubStr( numer, 1, 5 )
   k3=dtoc(data_umowy)
*  set century on
   W1=brut_razem
   W2=koszty
   W3=dochod
   W4=podatek
   W5=do_wyplaty
   sele prac
*   go val(umowy->ident)
   //seek val(umowy->ident)
   seek ident_fir + umowy->ident
   k6=nazwisko
   k7=imie1
   k8=pesel
   suma1=suma1+W1
   suma2=suma2+W5
   sele umowy
   skip
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   k4=kwota(W1,11,2)
   k5=kwota(W5,11,2)
   mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[  ]+k6+[   ]+k7+[  ]+k8)
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   _numer=0
   _grupa=.f.
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
k1=suma1
k2=suma2
mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³         R A Z E M         ³]+KWOTA(K1,11,2)+[³]+KWOTA(K2,11,2)+[³])
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ])
mon_drk([                U&_z.ytkownik programu komputerowego])
mon_drk([        ]+dos_c(code()))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([ş])
               end
               if _czy_close
               close_()
               endif
