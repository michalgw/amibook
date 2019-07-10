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

para mieum
mieum=strtran(mieum,' ','0')
reccur=recno()
private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=104
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.f.
      *------------------------------
      _szerokosc=104
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
      mon_drk(padc([UMORZENIE &__S.RODK&__O.W TRWA&__L.YCH W MIESI&__A.CU ]+mieum+'.'+param_rok+[        FIRMA: ]+SYMBOL_FIR,104))
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³  Data   ³  Numer   ³                  Nazwa                 ³        ³Stawka³ Spos&_o.b ³Mno&_z.³  Warto&_s.&_c. ³])
   mon_drk([³przyj&_e.c. ³ewidencyj.³             &_s.rodka trwa&_l.ego            ³  KST   ³  %%  ³umorzen.³DEGR³ umorzenia³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      sumum=0
      do while .not.&_koniec
         k1=dtoc(data_zak)
         k2=krst
         k3=nrewid
         K4=nazwa
         K7=str(stawka,6,2)
         K8=iif(sposob='L','Liniowo ','Degresyw')
         K9=str(wspdeg,4,2)
         recst=str(rec_no,5)
         sele amort
         seek '+'+recst+param_rok
         if found().and.mc&mieum#0
            sumum=sumum+mc&mieum
            K10=transform(mc&mieum,'@E  999 999.99')
            vWART_AKT=WART_AKT
            vODPIS_SUM=ODPIS_SUM
            mon_drk(k1+[ ]+k3+[ ]+k4+[ ]+k2+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+k10)
            sele kartst
            if substr(dtos(DATA_LIK),1,6)==param_rok+mieum
               if len(alltrim(dtos(DATA_LIK)))=8
                  if len(alltrim(dtos(DATA_SPRZ)))=8
                     mon_drk([     &__S.rodek trwa&_l.y zosta&_l. zbyty dnia........]+dtoc(DATA_SPRZ)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami:]+transform(vWART_AKT-vODPIS_SUM,'@E  999 999.99'))
                  else
                     mon_drk([     &__S.rodek trwa&_l.y zosta&_l. zlikwidowany dnia.]+dtoc(DATA_LIK)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami:]+transform(vWART_AKT-vODPIS_SUM,'@E  999 999.99'))
                  endif
               endif
            endif
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         endif
         sele kartst
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=0
         _grupa=.f.
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(repl([Ä],104))
      mon_drk([                                                            Suma umorze&_n. &_s.rodk&_o.w trwa&_l.ych    ]+transform(sumum,'@E  999 999.99'))
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
sele KARTST
go reccur
