/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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
zid=str(rec_no,5)
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=128
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.f.
      *------------------------------
      _szerokosc=128
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      czesc=1
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      vZBYLIK='likwidac.'
      sele kartst
      if len(alltrim(dtos(DATA_LIK)))=8
         if len(alltrim(dtos(DATA_SPRZ)))=8
            vZBYLIK=' zbycia  '
         else
            vZBYLIK='likwidac.'
         endif
      endif
      mon_drk([�]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(padc([TABELA AMORTYZACJI &__S.RODKA TRWA&_L.EGO       FIRMA: ]+SYMBOL_FIR,128))
      mon_drk([������������������������������������������������������������������������������������������������������������������������������Ŀ])
      mon_drk([�   Data  �  Numer   �                  Nazwa                 �   Dow&_o.d  �        �Stawka� Spos&_o.b �Mno&_z.�     Cena    �  Data   �])
      mon_drk([�przyj&_e.cia�ewidencyj.�             &_s.rodka trwa&_l.ego            �  zakupu  �  KST   �  %%  �umorzen.�DEGR�    zakupu   �]+vZBYLIK+[�])
      mon_drk([��������������������������������������������������������������������������������������������������������������������������������])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa=.t.
      *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dtoc(data_zak)
      k2=krst
      k3=nrewid
      K4=nazwa
      K5=dowod_zak
      K7=str(stawka,6,2)
      K8=iif(sposob='L','Liniowo ',iif(sposob='J','Jednoraz','Degresyw'))
      K9=str(wspdeg,4,2)
      K10=transform(wartosc,'@E 999999999.99')
      K11=dtoc(data_lik)
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(k1+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k2+[ ]+k7+[ ]+k8+[ ]+k9+[  ]+k10+[ ]+k11)
      mon_drk(repl([�],128))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _koniec="del#[+].or.ident#zid"
      zid=str(rec_no,5)
      sele AMORT
      seek '+'+zid
      if found()
         startrok=rok
         do while .not.&_koniec
            endrok=rok
            skip
         enddo
         ilam=val(endrok)-val(startrok)
         for x=0 to 6
             seek '+'+zid+str(val(startrok)+(x*7),4)
             if found()
                k7=padr('Rok',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=padc(ROK,14)
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. pocz&_a.tkowa',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_POCZ,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Mno&_z.nik aktualizac.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(PRZEL,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. modyfikacji ',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_MOD,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Warto&_s.&_c. pocz.aktual.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(WART_AKT,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Umorzenie po aktual.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(UMORZ_AKT,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Roczny odpis liniowo',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(LINIOWO,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Roczny odpis degres.',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(DEGRES,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                mon_drk([])
                sele AMORT
                for mmm=1 to 12
                    mmn=strtran(str(mmm,2),' ','0')
                    k7=padr(miesiac(mmm),20)
                    for y=0 to 6
                        seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                        zm=str(y,1)
                        if found()
                           k&zm=transform(MC&MMN,'@EZ 999 999 999.99')
                        else
                           k&zm=space(14)
                        endif
                    next
                    mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                    sele AMORT
                next
                k7=padr('Odpis za rok',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(ODPIS_ROK,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk([])
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                sele AMORT
                k7=padr('Odpis narastaj&_a.co',20)
                for y=0 to 6
                    seek '+'+zid+str(val(startrok)+(x*7)+y,4)
                    zm=str(y,1)
                    if found()
                       k&zm=transform(ODPIS_SUM,'@E 999 999 999.99')
                    else
                       k&zm=space(14)
                    endif
                next
                mon_drk(k7+[ ]+k0+[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6)
                mon_drk(repl([�],128))
                sele AMORT
             endif
         next
         sele KARTSTMO
         seek [+]+zid
         if found().and.[+]+zid==A->del+str(A->rec_no,5).and..not.eof()
            mon_drk([Zmiany wartosci srodka trwalego:])
            sele KARTSTMO
            do while del+ident==[+]+zid.and..not.eof()
               zDATA_MOD=DATA_MOD
               zWART_MOD=WART_MOD
               zOPIS_MOD=OPIS_MOD
               mon_drk('Dnia '+transform(zDATA_MOD,'@D')+' na kwote '+str(zWART_MOD,9,2)+' z tytulu '+zOPIS_MOD)
               sele KARTSTMO
               skip
            enddo
         endif
         sele kartst
         if len(alltrim(dtos(DATA_LIK)))=8
            vROK_LIK=substr(dtos(DATA_LIK),1,4)
            sele AMORT
            seek '+'+zid+vROK_LIK
            vWART_AKT=WART_AKT
            vODPIS_SUM=ODPIS_SUM
            sele kartst
            if len(alltrim(dtos(DATA_SPRZ)))=8
* sprzedaz
               mon_drk([&__S.rodek trwa&_l.y zosta&_l. zbyty dnia........]+dtoc(DATA_SPRZ)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami: ]+str(vWART_AKT-vODPIS_SUM,12,2))
            else
               mon_drk([&__S.rodek trwa&_l.y zosta&_l. zlikwidowany dnia.]+dtoc(DATA_LIK)+[   Warto&_s.&_c. &_s.rodka nierozliczona ratami: ]+str(vWART_AKT-vODPIS_SUM,12,2))
            endif
         endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([])
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([�])
end
if _czy_close
   close_()
endif
sele KARTST
set orde to 2
seek val(ZID)
set orde to 1
