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
      _prawa=80
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      *------------------------------
      _szerokosc=80
      _koniec="eof()"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      @  3,42 say '                                      '
      @  4,42 say '                                      '
      @  5,42 say '                                      '
      @  6,42 say ' - - - - - - - - - - - - - - - - - - -'
      @  7,42 say '    Kwota odpis&_o.w amortyzacyjnych     '
      @  8,42 say '   srodk&_o.w trwa&_l.ych (podatnik nie     '
      @  9,42 say ' ksi&_e.gowa&_l. rat miesi&_e.cznych w kol.13) '
      @ 10,42 say '                                      '
      @ 11,42 say ' - - - - - - - - - - - - - - - - - - -'
      @ 12,42 say '   Kwota wydatk&_o.w na zakup surowc&_o.w   '
      @ 13,42 say '    materia&_l.&_o.w wy&_l.&_a.czonych z obrotu   '
      @ 14,42 say '                                      '
      @ 15,42 say ' - - - - - - - - - - - - - - - - - - -'
      @ 16,42 say '     Warto&_s.&_c. wynagrodze&_n. w naturze    '
      @ 17,42 say '   ujetych w innych rubrykach ksi&_e.gi  '
      @ 18,42 say '                                      '
      @ 19,42 say ' - - - - - - - - - - - - - - - - - - -'
      @ 20,42 say '                                      '
      @ 21,42 say '                                      '
      @ 22,42 say '                                      '
      store 0 to k8,k9,k10
      @ 10,53 get k8  picture [   99999999.99]
      @ 14,53 get k9  picture [   99999999.99]
      @ 18,53 get k10 picture [   99999999.99]
      read_()
      if lastkey()=27
         break
      endif
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 3
      if dostep('FIRMA')
         set inde to firma
      else
         break
      endif
      go val(ident_fir)
      select 2
      if dostep('OPER')
         do SETIND with 'OPER'
         set orde to 3
      else
         break
      endif
      select 1
      if dostep('SUMA_MC')
         set inde to suma_mc
      else
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=param_rok
         *-----remanenty-----
         store 0 to rem_p,rem_k
         select oper
         seek [+]+ident_fir
         mc_rozp=mc
         seek [+]+ident_fir+mc_rozp+chr(1)
         rem_p=iif(found(),ZAKUP+UBOCZNE+WYNAGR_G+WYDATKI,0)
         seek [+]+ident_fir+[þ]
         skip -1
         miesiac=mc
         seek [+]+ident_fir+miesiac+chr(254)
         rem_k=iif(found(),ZAKUP+UBOCZNE+WYNAGR_G+WYDATKI,0)
         *-------------------
         k3=rem_p
         k6=rem_k
         select suma_mc
         seek [+]+ident_fir
         store 0 to k2,k4,k5,k7
         do while del=[+].and.firma=ident_fir
            k2=k2+wyr_tow+uslugi
            k4=k4+zakup
            k5=k5+uboczne
            k7=k7+WYNAGR_G+WYDATKI
            skip
         enddo
         k11=k3+k4+k5-k6+k7+k8-k9-k10
         k12=k2
         k13=k11
         k14=k12-k13
         go bottom
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         k2=kwota(k2,14,2)
         k3=kwota(k3,14,2)
         k4=kwota(k4,14,2)
         k5=kwota(k5,14,2)
         k6=kwota(k6,14,2)
         k7=kwota(k7,14,2)
         k8=kwota(k8,14,2)
         k9=kwota(k9,14,2)
         k10=kwota(k10,14,2)
         k11=kwota(k11,14,2)
         k12=kwota(k12,14,2)
         k13=kwota(k13,14,2)
         k14=kwota(k14,14,2)
         mon_drk([                    OBLICZENIE DOCHODU W ROKU PODATKOWYM  ]+k1)
         mon_drk(padc(alltrim(firma->nazwa)+' '+firma->nip,80))
         mon_drk([])
         mon_drk([1. Przych&_o.d (kol.9).......................................... ]+k2+[ z&_l..])
         mon_drk([])
         mon_drk([2. Wysoko&_s.&_c. koszt&_o.w uzyskania przychod&_o.w poniesionych w roku podatkowym:])
         mon_drk([])
         mon_drk([   warto&_s.&_c. spisu z natury na poczatek roku podatkowego....... ]+k3+[ z&_l..])
         mon_drk([   plus wydatki na zakup towar&_o.w handlowych i materia&_l.&_o.w])
         mon_drk([        (kol.10)............................................. ]+k4+[ z&_l..])
         mon_drk([   plus wydatki na koszty uboczne zakupu (kol.11)............ ]+k5+[ z&_l..])
         mon_drk([   minus warto&_s.&_c. spisu z natury na koniec roku podatkowego... ]+k6+[ z&_l..])
         mon_drk([   plus kwota pozosta&_l.ych wydatk&_o.w (kol.14).................. ]+k7+[ z&_l..])
         mon_drk([   plus roczna kwota odpis&_o.w amortyzacyjnych srodk&_o.w trwa&_l.ych])
         mon_drk([        (podatnik nie ksi&_e.gowal rat miesi&_e.cznych w kol.14)... ]+k8+[ z&_l..])
         mon_drk([   minus kwota wydatk&_o.w na zakup surowc&_o.w i materia&_l.&_o.w])
         mon_drk([        wy&_l.&_a.czonych z obrotu................................. ]+k9+[ z&_l..])
         mon_drk([   minus warto&_s.&_c. wynagrodze&_n. w naturze ujetych w innych])
         mon_drk([        kolumnach ksi&_e.gi..................................... ]+k10+[ z&_l..])
         mon_drk([])
         mon_drk([   Razem koszty uzyskania przychodu.......................... ]+k11+[ z&_l..])
         mon_drk([])
         mon_drk([3. Ustalenie dochodu osi&_a.gni&_e.tego w roku podatkowym:])
         mon_drk([])
         mon_drk([   a) przych&_o.d (pkt 1)....................................... ]+k12+[ z&_l..])
         mon_drk([   b) minus koszty uzyskania (pkt 2)......................... ]+k13+[ z&_l..])
         mon_drk([                                                            ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
         mon_drk([                                            Doch&_o.d (a-b)      ]+k14+[ z&_l..])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         do case
         endcase
         _grupa=.f.
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
