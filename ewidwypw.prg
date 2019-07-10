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
      _prawa=130
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      *------------------------------
      _szerokosc=130
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 3
      if dostep('FIRMA')
         go val(ident_fir)
         liczba_=liczba_wyp
      else
         sele wyposaz
         break
      endif
      sele wyposaz
      seek [+]+ident_fir
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      store 0 to s0_4,s0_5
      mon_drk([ö]+procname())
      _grupa1=int(strona/max(1,_druk_2-5))
      _grupa=.t.
      do while .not.&_koniec
         if _grupa.or._grupa1#int(strona/max(1,_druk_2-5))
            _grupa1=int(strona/max(1,_druk_2-5))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
            mon_drk([                                      EWIDENCJA WYPOSA&__Z.ENIA                                                       FIRMA: ]+SYMBOL_FIR)
            mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³    ³   Data   ³    Nr    ³                                        ³     Cena   ³ Poz. ³   Data   ³                             ³])
            mon_drk([³L.p.³  zakupu  ³  dowodu  ³           Nazwa wyposa&_z.enia            ³    zakupu  ³ksi&_e.gi³likwidacji³      Przyczyna likwidacji   ³])
            mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         k1=str(liczba_,4)
         k2=strtran(rok+'.'+mc+'.'+dzien,' ','0')
         k3=numer
         K4=nazwa
         K5=str(cena,12,2)
         K6=str(pozycja,6)
         k7=dtoc(DATAKAS)
         k8=przyczyna
         s0_4=s0_4+cena
         if .not.empty(DATAKAS)
            s0_5=s0_5+cena
         endif
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k7+[ ]+k8)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         liczba_=liczba_+1
         _numer=1
         do case
         case int(strona/max(1,_druk_2-5))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(repl('Ä',130))
      mon_drk([                 R A Z E M  warto&_s.&_c. wyposa&_z.enia                      ]+str(s0_4,12,2))
      mon_drk([                            warto&_s.&_c. wyposa&_z.enia zlikwidowanego       ]+str(s0_5,12,2))
      mon_drk([                            --------------------------------------------------------])
      mon_drk([                            S A L D O                                ]+str(s0_4-s0_5,12,2))
      mon_drk([ş])
end
if _czy_close
   close_()
endif
sele wyposaz
