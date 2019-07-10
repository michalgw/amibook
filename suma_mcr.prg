/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=117
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=117
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 2
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele 1
         break
      endif
      select 1
      if dostep('SUMA_MC')
         set inde to suma_mc
         seek [+]+ident_fir
      else
         sele 1
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      if _mon_drk#1
         _lewa=1
         _prawa=117
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      select firma
      k1=alltrim(nazwa)
      kk1=scal(miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
      select suma_mc
*      k1=k1+space(80-len(k1))
      SUSLUGI=str(STAW_USLU*100,5,2)
      SPROD=str(STAW_PROD*100,5,2)
      SHANDEL=str(STAW_HAND*100,5,2)
      SRY20=str(STAW_RY20*100,5,2)
      SRY17=str(STAW_RY17*100,5,2)
      SRY10=str(STAW_RY10*100,5,2)
      mon_drk([            ]+k1)
      mon_drk([            ]+kk1)
      mon_drk([           ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([ Rok       ³                 Kwota przychodu opodatkowanego wg stawki                 ³              ³Kwota przychod³])
      mon_drk([ ewiden-   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´    Og&_o.&_l.em    ³ opodatkowana ³])
      mon_drk([ cyjny     ³    ]+sRY20+[ %   ³    ]+sRY17+[ %   ³   ]+sUSLUGI+[ %    ³   ]+sPROD+[ %    ³   ]+sHANDEL+[ %    ³  przychody   ³  wg.stawki   ³])
      mon_drk([ ]+param_rok+[      ³(wolne zawody)³ (inne uslugi)³   (uslugi)   ³   (wyroby)   ³   (towary)   ³ (5+6+7+8+9)  ³    ]+sRY10+[ %   ³])
      mon_drk([           ³      (5)     ³      (6)     ³      (7)     ³      (8)     ³      (9)     ³     (10)     ³      (11)    ³])
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      store 0 to s0_2,s0_3,s0_4,s0_4a,s0_4b,s0_4c,s0_5
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=miesiac(val(mc))
         k2=uslugi
         k3=wyr_tow
         k4=handel
         k4a=ry20
         k4b=ry17
         k4c=ry10
         k5=k2+k3+k4+k4a+k4b
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_2=s0_2+k2
         s0_3=s0_3+k3
         s0_4=s0_4+k4
         s0_4a=s0_4a+k4a
         s0_4b=s0_4b+k4b
         s0_4c=s0_4c+k4c
         s0_5=s0_5+k5
         k2=str(k2,12,2)
         k3=str(k3,12,2)
         k4=str(k4,12,2)
         k4a=str(k4a,12,2)
         k4b=str(k4b,12,2)
         k4c=str(k4c,12,2)
         k5=str(k5,12,2)
         mon_drk(k1+[³ ]+k4a+[ ³ ]+k4b+[ ³ ]+k2+[ ³ ]+k3+[ ³ ]+k4+[ ³ ]+k5+[ ³ ]+k4c+[ ³])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         _grupa=.f.
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([R A Z E M  ³ ]+str(s0_4a,12,2)+[ ³ ]+str(s0_4b,12,2)+[ ³ ]+str(s0_2,12,2)+[ ³ ]+str(s0_3,12,2)+[ ³ ]+str(s0_4,12,2)+[ ³ ]+str(s0_5,12,2)+[ ³ ]+str(s0_4c,12,2)+[ ³])
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
