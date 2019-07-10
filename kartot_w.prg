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

FUNCTION Kartot_W( mmr )

private _koniec,_szerokosc,_lewa,_prawa,_strona,_czy_mon,_czy_close
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
*      zident=str(recno(),5)
      zident=str(rec_no,5)
      _koniec="del#[+].or.firma#ident_fir.or.ident#zident"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 6
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele prac
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=alltrim(nazwa)
      kk1=alltrim(miejsc)+[ ul.]+alltrim(ulica)+[ ]+alltrim(nr_domu)+iif(empty(nr_mieszk),[ ],[/])+alltrim(nr_mieszk)
      select prac
      p1=nazwisko
      p2=imie1
      p3=imie2
      p4=pesel
      p4a=NIP
      p5=imie_o
      p6=imie_m
      p7=miejsc_ur
      p8=data_ur
      p9=miejsc_zam
      p10=kod_poczt
      p11=gmina
      p12=ulica
      p13=nr_domu
      p14=nr_mieszk
      p16=telefon
      p17=data_przy
      p18=data_zwol
      mon_drk([ö]+procname())
      if mmr='C'.or.mmr=' 1'
         mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ K A R T A   P R Z Y C H O D &__O. W   P R A C O W N I K A  za rok  ]+param_rok+[ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
         mon_drk([            Firma: ]+k1+[     Adres: ]+kk1)
         mon_drk([            Nazwisko: ]+p1+[  Imie 1: ]+p2+[     Imie 2: ]+p3)
         mon_drk([            NIP: ]+p4a+[   PESEL: ]+p4+[   Telefon: ]+p16)
         mon_drk([            Imie ojca: ]+p5+[         Imie matki: ]+p6)
         mon_drk([            Miejsce ur.: ]+p7+[    Data ur.: ]+dtoc(p8))
         mon_drk([            Miejsce zam: ]+p9+[  Kod poczt.: ]+p10+[  Ulica: ]+p12+[  Nr domu: ]+p13+[  Nr mieszk.: ]+p14)
         mon_drk([            Data przyj&_e.cia: ]+dtoc(p17)+[    Data zwolnienia: ]+dtoc(p18))
         mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿])
         mon_drk([³  P&_l.aca   ³ Wyp&_l.acono³Wynagro- ³ Koszt ³  Sk&_l.adki na ZUS pracownika  ³ Doch&_o.d  ³Doch&_o.d od³ Nale&_z.na ³Sk&_l.adka³Zalicz.na³   Data   ³])
         mon_drk([³naliczona ³    dnia  ³ dzenie  ³uzyskanÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ´    3-   ³ pocz&_a.tku³zalicz.na³na ubez³podat.od ³przekazan.³])
         mon_drk([³za miesi&_a.c³          ³ brutto  ³przych.³emerytal.³ rentowa ³chorobowa³(4+5+6+7)³   roku  ³pod.doch.³zdrowot³pocz.roku³ zaliczki ³])
         mon_drk([³          ³Kod tytu&_l.u ubezpiecz³       ³         ³         ³         ³         ³         ³         ³       ³         ³          ³])
         mon_drk([³   (1)    ³    (2)   ³   (3)   ³  (4)  ³   (5)   ³   (6)   ³   (7)   ³   (8)   ³   (9)   ³   (10)  ³  (11) ³   (12)  ³    (13)  ³])
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ])
      else
         for x=1 to 14
             mon_drk([])
         next
      endif
      store 0 to s0_2,s0_3,s0_4,s0_5,s0_6,s0_7,s0_31a,s0_31b,s0_31c,s0_61
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      sele etaty
      seek [+]+ident_fir+zident
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k1=miesiac(val(mc))
         sele wyplaty
         seek '+'+ident_fir+zident+etaty->mc
         k1a=data_wyp
         sele etaty
         k1mc=mc
         k2=brut_razem
         k3=koszt
         k31a=war_pue
         k31b=war_pur
         k31c=war_puc
         k4=dochod
         k5=dochod+s0_4
         k6=podatek
         k61=war_puzo
         k7=podatek+s0_6
         k8=data_zal
         k9=kod_tytu
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s0_2=s0_2+k2
         s0_3=s0_3+k3
         s0_31a=s0_31a+k31a
         s0_31b=s0_31b+k31b
         s0_31c=s0_31c+k31c
         s0_4=s0_4+k4
         s0_6=s0_6+k6
         s0_61=s0_61+k61
         k1a=dtoc(k1a)
         k2 =tran(k2 ,'@EZ 999999.99')
         k3 =tran(k3 ,'@EZ 9999.99')
         k31a=tran(k31a,'@EZ 999999.99')
         k31b=tran(k31b,'@EZ 999999.99')
         k31c=tran(k31c,'@EZ 999999.99')
         k4 =tran(k4 ,'@EZ 999999.99')
         k5 =tran(k5 ,'@EZ 999999.99')
         k6 =tran(k6 ,'@EZ 999999.99')
         k61=tran(k61,'@EZ 9999.99')
         k7 =tran(k7 ,'@EZ 999999.99')
         k8 =dtoc(k8)
         do case
         case (len(alltrim(substr(dtos(p18),1,6)))<>0 .and. param_rok+strtran(k1mc,' ','0')>substr(dtos(p18),1,6))
              mon_drk(k1)
              mon_drk([])
              mon_drk([])
         case (len(alltrim(substr(dtos(p18),1,6)))=0 .or. param_rok+strtran(k1mc,' ','0')<=substr(dtos(p18),1,6)) .and. (k1=miesiac(val(mmr)).or.mmr='C')
              mon_drk(k1+[ ]+k1a+[ ]+k2+[ ]+k3+[ ]+k31a+[ ]+k31b+[ ]+k31c+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k61+[ ]+k7+[ ]+k8)
              mon_drk([                   ]+k9)
              mon_drk([])
         otherwise
              mon_drk([])
              mon_drk([])
              mon_drk([])
         endcase
         sele etaty
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      l2 =tran(s0_2 ,'@E 999999.99')
      l3 =tran(s0_3 ,'@E 9999.99')
      l31a=tran(s0_31a,'@E 999999.99')
      l31b=tran(s0_31b,'@E 999999.99')
      l31c=tran(s0_31c,'@E 999999.99')
      l4 =tran(s0_4 ,'@E 999999.99')
      l5 =k5
      l6 =tran(s0_6 ,'@E 999999.99')
      l61=tran(s0_61,'@E 9999.99')
      l7 =k7
      if mmr='12'.or.mmr='C'
         mon_drk(repl('Ä',130))
         mon_drk([R A Z E M              ]+l2+[ ]+l3+[ ]+l31a+[ ]+l31b+[ ]+l31c+[ ]+l4+[ ]+l5+[ ]+l6+[ ]+l61+[ ]+l7)
      else
         mon_drk([])
         mon_drk([])
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
sele firma
use
sele prac
