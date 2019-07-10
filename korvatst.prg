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

FUNCTION KorVatST()

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=130
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.t.
      *------------------------------
      _szerokosc=130
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 2
      if dostep('FIRMA')
         do setind with 'FIRMA'
      else
         break
      endif
      go val(ident_fir)
      zstrusprob=strusprob
      use
      select 1
      if dostep('KARTST')
         do setind with 'KARTST'
      else
         break
      endif
      seek [+]+ident_fir
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(padc([KOREKTA VAT DO ODLICZENIA W ROKU ]+param_rok+[ OD ZAKUPOW SRODKOW TRWALYCH DO SPRZEDAZY MIESZANEJ          FIRMA: ]+SYMBOL_FIR,128))
      mon_drk(padc([(Wyliczono wg struktury sprzedazy za rok ]+str(val(param_rok)-1,4)+[ gdzie sprzedaz opodatkowana stanowila ]+str(zstrusprob,3)+[% calej sprzedazy.)],128))
         mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³   Data   ³  Numer   ³                  Nazwa                 ³   Dow&_o.d  ³    VAT   ³    VAT   ³Lat³   Data   ³Opod³   Wartosc  ³])
mon_drk([³przyj&_e.cia ³ewidencyj.³             &_s.rodka trwa&_l.ego            ³  zakupu  ³ naliczony³ odliczony³kor³ sprzedazy³sprz³   korekty  ³])
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      SUMA_KOR=0
      SUMA_KORSP=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         if (val(param_rok)>=(year(data_zak)+1)).and.(val(param_rok)<=year(data_zak)+vatkorokr).and.VATZAKUP<>0.0.and.iif(len(alltrim(dtos(data_sprz)))=8,val(param_rok)<=year(data_sprz),.t.)
            k1=dtoc(data_zak)
            k3=nrewid
            K4=nazwa
            K5=dowod_zak
            Kvatnal=transform(VATZAKUP,'@E 999 999.99')
            Kvatodl=transform(VATODLI,'@E 999 999.99')
            kokrvat=str(VATkorokr,2)
            kdata_sprz=dtoc(DATA_SPRZ)
            kvatsprz=iif(VATSPRZ='Z','Zwol',iif(VATSPRZ='O','Opod','    '))
            kwartkor=_round(((VATZAKUP*(zstrusprob/100))-VATODLI)/VATkorokr,2)
            if val(param_rok)=year(data_sprz)
               if VATSPRZ='Z'
                  kwartkorsp=_round(((0-VATODLI)/VATkorokr)*(vatkorokr-(val(param_rok)-year(data_zak))),2)
               else
                  kwartkorsp=_round(((VATZAKUP-VATODLI)/VATkorokr)*(vatkorokr-(val(param_rok)-year(data_zak))),2)
               endif
            else
               kwartkorsp=0
            endif
            K10=transform(kwartkor,'@E 9 999 999.99')
            SUMA_KOR=SUMA_KOR+kwartkor
            SUMA_KORSP=SUMA_KORSP+kwartkorsp
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            mon_drk([ ]+k1+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kvatnal+[ ]+kvatodl+[  ]+kokrvat+[ ]+kdata_sprz+[ ]+kvatsprz+[ ]+k10)
            if kwartkorsp<>0.0
               mon_drk(space(30)+[                                                       korekta po sprzedazy srodka trw.]+transform(kwartkorsp,'@E 9 999 999.99'))
            endif
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer=0
            _grupa=.f.
         endif
         sele KARTST
         skip
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(repl([Ä],130))
      mon_drk(space(30)+[                                  RAZEM korekty VAT srodkow trwalych na I okres rozl.  ]+transform(SUMA_KOR,'@E 9 999 999.99'))
      mon_drk(space(30)+[                                  RAZEM korekty VAT srodkow trwalych po sprzedazy      ]+transform(SUMA_KORSP,'@E 9 999 999.99'))
      mon_drk(space(30)+[                                  RAZEM korekty VAT srodkow trwalych w calym roku      ]+transform(SUMA_KOR+SUMA_KORSP,'@E 9 999 999.99'))
      mon_drk([])
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
