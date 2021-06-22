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

para VATOWY
               private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
               private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
               begin sequence
               @ 1,47 say space(10)
               *-----parametry wewnetrzne-----
               _papsz=1
               _lewa=1
               _prawa=122
               _strona=.f.
               _czy_mon=.f.
               _czy_close=.f.
               czesc=1
               *------------------------------
               _szerokosc=122
               _koniec="del#[+].or.ident#zident"
*@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
zident=str(rec_no,8)
select pozycje
seek [+]+zident
   nr_rec=recno()
   licznik=0
   do while del=[+].and.ident=zident
   licznik=licznik+1
   skip
   enddo
   go nr_rec
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               if &_koniec
               kom(3,[*w],[b r a k   d a n y c h])
               break
               endif
               mon_drk([ö]+procname())
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
select firma
zm=scal(alltrim(nazwa)+[, ]+miejsc+[, ]+ulica+[ ]+nr_domu+iif(.not.empty(nr_mieszk),[/],[ ])+nr_mieszk)
zNIP=NIP
select 1
k2=dos_p(iif(len(alltrim(firma->fakt_miej))=0,firma->miejsc,firma->fakt_miej))
*k2=dos_p(firma->miejsc)
k3=strtran(param_rok+[.]+faktury->mc+[.]+faktury->dzien,' ','0')
k6 := StrTran( Str( faktury->numer, 5 ), ' ', '0' ) + '/' + param_rok
k8=[ODBIORCA: ]+alltrim(faktury->nazwa)+[ ]+alltrim(faktury->adres)
k08=[          ]+'Nr ident.-'+alltrim(faktury->NR_IDENT)
mon_drk([])
mon_drk([                                                                      ]+k2+[ , dnia ]+k3)
mon_drk([ ])
IF faktury->rach == 'R'
   mon_drk([ ]+space(25)+[                   R A C H U N E K     Nr  S-]+k6)
ELSE
   mon_drk([ ]+space(25)+[                     F A K T U R A     Nr  S-]+k6)
ENDIF
*mon_drk([ ]+space(25)+[                           orygina&_l. / kopia  ])
mon_drk([DOSTAWCA: ]+zm)
mon_drk([          Nr ident.:]+zNIP)
mon_drk(k8)
mon_drk(k08)
mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³                                                ³             ³Jedn.³     Cena     ³     Warto&_s.&_c.                        ³])
mon_drk([³                    Nazwa towaru (us&_l.ugi)       ³    Ilo&_s.&_c.    ³miary³ jednostkowa  ³     towar¢w (usˆug)                ³])
mon_drk([ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
store 0 to s0_5
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               _grupa=.t.
               do while .not.&_koniec
*@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
k1=substr(towar,1,46)
if wartosc=0
   k2=space(13)
else
   zm=kwota(ilosc,13,3)
   if right(zm,1)=[0]
      zm=[ ]+left(zm,12)
      if right(zm,1)=[0]
         zm=[ ]+left(zm,12)
      endif
      if right(zm,1)=[0]
         zm=[  ]+left(zm,11)
      endif
   endif
   k2=zm
endif
k3=jm
k4=iif(wartosc=0,space(14),kwota(cena,14,2))
k5=wartosc
skip
*@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
s0_5=s0_5+k5
k5=iif(k5=0,space(14),kwota(k5,14,2))
mon_drk([³ ]+k1+[ ³]+k2+[³]+k3+[³]+k4+[³]+k5+[                      ³])
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               _numer=0
               do case
               endcase
               _grupa=.f.
               enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
s0_5=_round(s0_5,2)
zm=wyraz(slownie(s0_5),50)
zm=zm+space(150-len(zm))
k1=left(zm,50)
k2=substr(zm,51,50)
k4=right(zm,50)
do case
   case faktury->sposob_p=1
        k5=[P&_l.atne przelewem w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni na konto ]+iif(substr(firma->nr_konta,1,2)=='  ',substr(firma->nr_konta,4),firma->nr_konta)
        k6=space(10)+firma->bank
   case faktury->sposob_p=2
        k6=space(50)
        if faktury->termin_z=0
           k5=[Zap&_l.acono got&_o.wk&_a.]
        else
           if faktury->kwota=0
              k5=[P&_l.atne got&_o.wk&_a. w ci&_a.gu ]+str(faktury->termin_z,2)+[ dni]
           else
              k5=[Zap&_l.acono got&_o.wk&_a. ]+ltrim(kwota(faktury->kwota,13,2))
              k6=[Do zap&_l.aty ]+ltrim(kwota(s0_5-faktury->kwota,13,2))+[ w terminie ]+str(faktury->termin_z,2)+[ dni]
           endif
        endif
   case faktury->sposob_p=3
        k5=[Zap&_l.acono czekiem]
        k6=space(50)
   endcase
   k7=code()
   mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
   mon_drk([ DO ZAP&__L.ATY     :  ]+kwota(s0_5,14,2)+[                                             Razem ³]+kwota(s0_5,14,2)+[                      ³])
   mon_drk([ S&__L.OWNIE Z&__L.OTYCH:  ]+k1+[               ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
   mon_drk([                   ]+k2)
   mon_drk([                   ]+k4)
   mon_drk([])
   mon_drk([ ]+k5)
   mon_drk([ ]+k6)
   if VATOWY='T'
      mon_drk([ Sprzeda&_z. zapas&_o.w z inwentaryzacji na dzie&_n. 4.07.1993r.])
   endif
   mon_drk([])
   mon_drk([])
   mon_drk([                                                                      ]+ewid_wyst)
   mon_drk([                   ................................                   .....................................     ])
   mon_drk([                   rachunek odebra&_l. (data i podpis)                     rachunek wystawi&_l. (data i podpis)])
   mon_drk([])
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   mon_drk([ş])
end
if _czy_close
   close_()
endif
