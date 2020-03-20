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
      _prawa=129
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.f.
      *------------------------------
      _szerokosc=129
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      sele kartst
      seek [+]+ident_fir
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(padc([KARTOTEKA SRODK&__O.W TRWA&__L.YCH       FIRMA: ]+SYMBOL_FIR,128))
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³   Data   ³  Numer   ³                  Nazwa                 ³   Dow&_o.d  ³        ³Stawka³ Spos&_o.b ³Mno&_z.³    Cena    ³Likwidacja³])
   mon_drk([³przyj&_e.cia ³ewidencyj.³             &_s.rodka trwa&_l.ego            ³  zakupu  ³  KST   ³  %%  ³umorze&_n..³DEGR³   zakupu   ³/ Zbycie  ³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ])
      SUMA_MOD=0
      SUMA_PRZED=0
      SUMA_PO=0
      SUMA_ZLIK=0
      SUMA_ZBYT=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=dtoc(data_zak)
         k2=krst
         k3=nrewid
         K4=nazwa
         K5=dowod_zak
         K7=str(stawka,6,2)
         K8=iif(sposob='L','Liniowo ','Degresyw')
         K9=str(wspdeg,4,2)
         K10=transform(wartosc,'@E 9 999 999.99')
         wartst=wartosc
         k11a=' '
         if len(alltrim(dtos(data_lik)))=0
            SUMA_PRZED=SUMA_PRZED+wartst
            k11a=' '
         else
            if len(alltrim(dtos(data_sprz)))=0
               SUMA_ZLIK=SUMA_ZLIK+wartst
               k11a='L'
            else
               SUMA_ZBYT=SUMA_ZBYT+wartst
               k11a='Z'
            endif
         endif
         K11=dtoc(data_lik)
         RECSs=rec_no
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk([ ]+k1+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k2+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+k10+[ ]+k11+k11a)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         _grupa=.f.
         BYLYMODYF=.f.
         select kartstmo
         seek [+]+str(RECSs,5)
         do while del=[+].and.ident=str(RECSs,5)
            BYLYMODYF=.t.
            moddat=dtoc(data_mod)
            modopi=opis_mod
            modwar=wart_mod
            mon_drk(space(12)+[-->]+modopi+[     dnia ]+moddat+[   o kwote]+transform(modwar,'@E 9 999 999.99'))
            select kartstmo
            wartst=wartst+modwar
            if len(alltrim(dtos(A->data_lik)))=0
               SUMA_MOD=SUMA_MOD+modwar
            else
               if len(alltrim(dtos(A->data_sprz)))=0
                  SUMA_ZLIK=SUMA_ZLIK+modwar
               else
                  SUMA_ZBYT=SUMA_ZBYT+modwar
               endif
            endif
            skip
         enddo
         if BYLYMODYF=.t.
            mon_drk(space(69)+[wartosc poczatkowa po modyfikacjach ]+transform(wartst,'@E 9 999 999.99'))
         endif
         sele KARTST
         skip
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(repl([Ä],129))
      mon_drk(space(29)+[                          RAZEM wartosc poczatkowa przed modyfikacjami      ]+transform(SUMA_PRZED,'@E 9 999 999.99'))
      mon_drk(space(29)+[&_s.rodki na stanie          RAZEM modyfikacje                                 ]+transform(SUMA_MOD,'@E 9 999 999.99'))
      mon_drk(space(29)+[                          RAZEM wartosc poczatkowa po modyfikacjach         ]+transform(SUMA_PRZED+SUMA_MOD,'@E 9 999 999.99'))
      mon_drk([])
      mon_drk(space(29)+[&_s.rodki zlikwidowane       RAZEM po modyfikacjach                            ]+transform(SUMA_ZLIK,'@E 9 999 999.99'))
      mon_drk(space(29)+[&_s.rodki zbyte              RAZEM po modyfikacjach                            ]+transform(SUMA_ZBYT,'@E 9 999 999.99'))
      mon_drk([])
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
seek [+]+ident_fir
