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
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=130
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=130
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac.or.nrrej#znrrej"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 5
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele ewidpoj
         break
      endif
      liczba=0
      sele ewidpoj
      set orde to 2
      seek [+]+ident_fir+mc+znrrej
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_7,s0_9
      store 0 to s1_7,s1_9
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa1=int(strona/max(1,_druk_2-15))
      _grupa=.t.
      do while .not.&_koniec
         if _grupa.or._grupa1#int(strona/max(1,_druk_2-15))
            _grupa1=int(strona/max(1,_druk_2-15))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(upper(miesiac(val(miesiac))))
            k2=param_rok
            k28=k1+' '+k2
            select samochod
            seek '+'+ident_fir+znrrej
            if found()
               k3='W&_l.a&_s.ciciel pojazdu: '+wlascic+space(44)+'Nr rejestracyjny pojazdu: '+znrrej
               k31='Nazwa firmy: '+firma->nazwa+space(32)+'Pojemno&_s.&_c. silnika: '+str(pojemnosc,4)
            else
               k3=''
               k31=''
            endif
            k4=int(strona/max(1,_druk_2-15))+1
            p_folio1 =s1_7
            p_folio2 =s1_9
            store 0 to s_folio1,s_folio2
            mon_drk([ ]+k3)
            mon_drk([ ]+k31)
            mon_drk([                                    EWIDENCJA PRZEBIEGU POJAZDU za okres ]+k1+[ ]+k2+[                                 str.]+str(k4,3))
            mon_drk([ÚÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³L.p³Dz-³                                   ³                                   ³ Il.³Stawka³Wartosc³    Podpis    ³             ³])
            mon_drk([³   ³ien³  Opis trasy wyjazdu (skad-dokad)  ³           Cel wyjazdu             ³ km ³za 1km³kol.5*6³  pracodawcy  ³    UWAGI    ³])
            mon_drk([³(1)³(2)³                (3)                ³                (4)                ³ (5)³  (6) ³  (7)  ³     (8)      ³     (9)     ³])
            mon_drk([ÀÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         liczba=liczba+1
         k1=str(liczba,3)
         k2=dzien
         k3=nrrej
         sele samochod
         seek [+]+ident_fir+k3
         k4=str(pojemnosc,4)
         sele ewidpoj
         K5=trasa
         K6=cel
         k7=str(km,4)
         zoddnia=param_rok+strtran(mc+dzien,' ','0')
         sele tab_poj
         seek [+]+zoddnia
         if .not.found()
            skip -1
         endif
         if val(k4)<=900
            k8=str(poj_900,6,4)
         else
            k8=str(poj_901,6,4)
         endif
         sele ewidpoj
         k9=str(_round(val(k8)*val(k7),2),7,2)
         skip
         s_folio1 =s_folio1 +val(k7)
         s_folio2 =s_folio2 +val(k9)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s1_7=s1_7+val(k7)
         s1_9=s1_9+val(k9)
         mon_drk([ ]+k1+[ ]+k2+[  ]+k5+[ ]+k6+[ ]+k7+[ ]+k8+[ ]+k9)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-15))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k7 =s_folio1
            k9 =s_folio2
            k77=p_folio1
            k99=p_folio2
            k29=dos_c(code())
            mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
            mon_drk([                                                          Suma folio         ³]+kwota(k7,7)+[³   ³]+kwota(k9,10,2)+[³])
            mon_drk([            U&_z.ytkownik programu komputerowego                                ÃÄÄÄÄÄÄÄ´   ÃÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                                                          Z przeniesienia    ³]+kwota(k77,7)+[³   ³]+kwota(k99,10,2)+[³])
            mon_drk([     ]+k29+[                      ÃÄÄÄÄÄÄÄ´   ÃÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                                                          RAZEM              ³]+kwota(s1_7,7)+[³   ³]+kwota(s1_9,10,2)+[³])
            mon_drk([                                                                             ÀÄÄÄÄÄÄÄÙ   ÀÄÄÄÄÄÄÄÄÄÄÙ])
            s0_7=s0_7+s1_7
            s0_9=s0_9+s1_9
         endif
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
sele firma
use
sele ewidpoj
set orde to 1
