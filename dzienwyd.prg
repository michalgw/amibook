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

para zadzien,zestnr
private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=132
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=132
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac.or.dzien#zadzien.or.numer#zestnr"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      strona=0
      liczba=0
      select 3
      do while.not.dostep('FIRMA')
      enddo
      go val(ident_fir)
      sele dzienne
      save scre to dops
      @ 22,0 clea to 24,79
      @ 22,0 to 24,79
      set curs on
      dopisek=space(60)
      @ 23,1 say 'OPIS ZESTAWIENIA:' get dopisek pict repl('!',60)
      read
      set curs off
      rest scre from dops
      if lastkey()=27
         keyb chr(13)
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ö]+procname())
      if _mon_drk=2
         _lewa=1
         _prawa=132
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_6,s0_7,s0_8,s0_9,s0_10,s0_11,s0_12,s0_13,s0_14,s0_15,s0_16,s0_17,s1_9,s1_11,s1_13,s1_14,s1_15,s2_9,s2_11,s2_13,s2_14,s2_15
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dos_p(zadzien)
      k2=dos_p(upper(miesiac(val(miesiac))))
      _grupa1=int(strona/max(1,_druk_2-11))
      _grupa=.t.
      _numer=1
      seek [+]+ident_fir+miesiac+zadzien+zestnr
      numpocz=numer_rach
      numkon=numpocz
      do while .not.&_koniec
         if (_grupa.or._grupa1#int(strona/max(1,_druk_2-11)))
            _grupa1=int(strona/max(1,_druk_2-11))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(zadzien)
            k2=alltrim(upper(miesiac(val(miesiac))))
            select firma
            ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
            select dzienne
            k3=ks+space(100-len(ks))
            k4=int(strona/max(1,_druk_2-11))+1
            mon_drk([    ]+space(30)+[Dzienne zestawienie sprzeda&_z.y nr ]+zestnr+[ z dnia ]+k1+[.]+k2+[.]+param_rok)
            mon_drk([    ]+k3+[           str. ]+str(k4,3))
            mon_drk([    ]+DOPISEK)
            mon_drk([ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³  ³          ³ OGOLNA  ³ OGOLNA  ³SPRZEDAZ wg staw]+str(vat_A,2)+[%³SPRZEDAZ wg staw]+str(vat_B,1)+[%³SPRZEDAZ wg staw]+str(vat_C,1)+[%³SPRZEDAZ wg staw]+str(vat_D,1)+[%³SPRZEDAZ ³ SPRZEDAZ³])
            mon_drk([³Lp³  NUMER   ³ WARTOSC ³ WARTOSC ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´wg stawki³ZWOLNIONA³])
            mon_drk([³  ³  DOWODU  ³  NETTO  ³PODAT.VAT³  NETTO  ³   VAT   ³  NETTO  ³   VAT  ³  NETTO  ³   VAT  ³  NETTO  ³   VAT  ³   0 %   ³OD PODAT.³])
            mon_drk([ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
         endif
*        *@@*@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k3=numer_rach
         nRAZEM=0
         vRAZEM=0
         n22=0
         n7=0
         n2=0
         n12=0
         n0=0
         nzw=0
         nin=0
         v22=0
         v7=0
         v2=0
         v12=0
         vin=0
         do while .not. &_bot .and. dzien==zadzien .and. numer==zestnr .and. numer_rach=k3 .and. .not. eof()
            do case
            case STAWKA=str(vat_A,2)
                 n22=n22+netto
                 v22=v22+wartvat
            case STAWKA=str(vat_B,1)+' '
                 n7=n7+netto
                 v7=v7+wartvat
            case STAWKA=str(vat_C,1)+' '
                 n2=n2+netto
                 v2=v2+wartvat
            case STAWKA=str(vat_D,1)+' '
                 n12=n12+netto
                 v12=v12+wartvat
            case STAWKA='0 '
                 n0=n0+netto
            case STAWKA='ZW'
                 nzw=nzw+netto
            other
                 nin=nin+netto
                 vin=vin+wartvat
            endcase
            nrazem=nrazem+netto
            vrazem=vrazem+wartvat
            skip 1
         enddo
         k87=v22+v12+v7+v2+vin
         k89=nZW+n0+n2+n7+n22+n12+nin
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         liczba=liczba+1
         k1=str(liczba,3)
         s0_8=s0_8+k89
         s0_9=s0_9+n22
         s0_10=s0_10+v22
         s0_6=s0_6+n12
         s0_7=s0_7+v12
         s0_11=s0_11+n7
         s0_12=s0_12+v7
         s0_13=s0_13+n0
         s0_14=s0_14+nzw
         s0_15=s0_15+k87
         s0_16=s0_16+n2
         s0_17=s0_17+v2
         k7 =transform(k87,'@Z 999999.99')
         k8 =transform(k89,'@Z 999999.99')
         k9 =transform(n22,'@Z 999999.99')
         k10=transform(v22,'@Z 999999.99')
         k9a=transform(n12,'@Z 999999.99')
         k10a=transform(v12,'@Z 99999.99')
         k11 =transform(n7,'@Z 999999.99')
         k12 =transform(v7,'@Z 99999.99')
         k13 =transform(n0,'@Z 999999.99')
         k14=transform(nzw,'@Z 999999.99')
         k15 =transform(n2,'@Z 999999.99')
         k16 =transform(v2,'@Z 99999.99')
         mon_drk(k1+[ ]+k3+[ ]+k8+[ ]+k7+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+k15+[ ]+k16+[ ]+k9a+[ ]+k10a+[ ]+k13+[ ]+k14)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-11))#_grupa1
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1 .and. .not. &_koniec
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            mon_drk([                   U&_z.ytkownik programu komputerowego])
            mon_drk([           ]+dos_c(code()))
            if _mon_drk=2 .or. _mon_drk=3
*              ejec
            endif
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
         numkon=k3
      enddo
*     IF _NUMER>=1
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
         mon_drk(space(4)+[RAZEM      ]+str(s0_8,9,2)+[ ]+str(s0_15,9,2)+[ ]+str(s0_9,9,2)+[ ]+str(s0_10,9,2)+[ ]+str(s0_11,9,2)+[ ]+str(s0_12,8,2)+[ ]+str(s0_16,9,2)+[ ]+str(s0_17,8,2)+[ ]+str(s0_6,9,2)+[ ]+str(s0_7,8,2)+[ ]+str(s0_13,9,2)+[ ]+str(s0_14,9,2))
         mon_drk([    DOWODY SPRZEDA&__Z.Y od nr ]+numpocz+[ do nr ]+numkon)
*     ENDIF
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
