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
      _prawa=92
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=92
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac.or.nrrej#znrrej"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      liczba=0
      sele rachpoj
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
      store 0 to s0_5,s0_6,s0_7
      store 0 to s1_5,s1_6,s1_7
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa1=int(strona/max(1,_druk_2-14))
      _grupa=.t.
      do while .not.&_koniec
         if _grupa.or._grupa1#int(strona/max(1,_druk_2-14))
            _grupa1=int(strona/max(1,_druk_2-14))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(upper(miesiac(val(miesiac))))
            k2=param_rok
            k28=k1+' '+k2
            select samochod
            seek '+'+ident_fir+znrrej
            if found()
               k3='W&_l.a&_s.ciciel: '+wlascic+'  Marka: '+marka+'  Nr rej.: '+znrrej
            else
               k3=''
            endif
            k3=k3+space(84-len(k3))
            k4=int(strona/max(1,_druk_2-14))+1
            p_folio1 =s1_5
            p_folio2 =s1_6
            p_folio3 =s1_7
            store 0 to s_folio1,s_folio2,s_folio3
            mon_drk([      EWIDENCJA KOSZT&__O.W EKSPLOATACJI SAMOCHODU   ]+k1+[ ]+k2+[         FIRMA: ]+SYMBOL_FIR)
            mon_drk([ ]+k3+[ str.]+str(k4,3))
            mon_drk([ÚÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³    ³Dz-³   Numer  ³                                        ³ Warto&_s.&_c. ³ Warto&_s.&_c. ³ Warto&_s.&_c. ³])
            mon_drk([³L.p.³ie&_n.³ rachunku ³        Rodzaj poniesionego wydatku     ³  netto  ³   VAT   ³ brutto  ³])
            mon_drk([³(1) ³(2)³    (3)   ³                     (4)                ³   (5)   ³   (6)   ³   (7)   ³])
            mon_drk([ÀÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         liczba=liczba+1
         sele rachpoj
         k1=str(liczba,4)
         k2=dzien
         k3=numer
         K4=rodzaj
         K5=netto
         K6=wartvat
         k7=k5+k6
         skip
         s_folio1 =s_folio1 +k5
         s_folio2 =s_folio2 +k6
         s_folio3 =s_folio3 +k7
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s1_5=s1_5+k5
         s1_6=s1_6+k6
         s1_7=s1_7+k7
         mon_drk([ ]+k1+[ ]+k2+[  ]+k3+[ ]+k4+[ ]+str(k5,9,2)+[ ]+str(k6,9,2)+[ ]+str(k7,9,2))
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-14))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k5 =s_folio1
            k6 =s_folio2
            k7 =s_folio3
            k55=p_folio1
            k66=p_folio2
            k77=p_folio3
            k29=dos_c(code())
            mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([                                                 Suma folio  ³]+kwota(k5,9,2)+[³]+kwota(k6,9,2)+[³]+kwota(k7,9,2)+[³])
            mon_drk([            U&_z.ytkownik programu komputerowego                ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                                                 Z przenies. ³]+kwota(k55,9,2)+[³]+kwota(k66,9,2)+[³]+kwota(k77,9,2)+[³])
            mon_drk([ ]+k29+                                           [          ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                                                 RAZEM       ³]+kwota(s1_5,9,2)+[³]+kwota(s1_6,9,2)+[³]+kwota(s1_7,9,2)+[³])
            mon_drk([                                                             ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
            s0_5=s0_5+s1_5
            s0_6=s0_6+s1_6
            s0_7=s0_7+s1_7
         endif
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
sele rachpoj
set orde to 1
