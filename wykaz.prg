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
               _strona=.t.
               _czy_mon=.t.
               _czy_close=.t.
               *------------------------------
               _szerokosc=80
               _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
*@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
czesc=1
*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
select 3
if dostep('FIRMA')
   go val(ident_fir)
else
   break
endif
select 2
if dostep('SUMA_MC')
   set inde to suma_mc
   seek [+]+ident_fir+mc_rozp
   liczba=firma->liczba-1
   do while del=[+].and.firma=ident_fir.and.mc<miesiac
      liczba=liczba+pozycje
      skip
   enddo
else
   break
endif
select 1
if dostep('OPER')
   do SETIND with 'OPER'
   seek [+]+ident_fir+miesiac
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
k1=dos_p(upper(miesiac(val(miesiac))))
k2=param_rok
mon_drk([ Zestawienie pomocnicze za ]+k1+[.]+k2+[ Sporz&_a.dz.dnia-]+dtoc(date())+[ godz-]+substr(time(),1,5))
mon_drk([ FIRMA: ]+SYMBOL_FIR)
mon_drk([ÚÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³     ³ Nr ³    Nr    ³                          ³              ³              ³])
mon_drk([³ Lp  ³dnia³  dowodu  ³          Kontrahent      ³    Przych&_o.d  ³    Rozch&_o.d   ³])
mon_drk([ÀÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
store 0 to s0_5,s0_6,SS,SI,SZ,SU,SR,SW,SK,SZr,SUr,SRr,SWr,SKr
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               _grupa=.t.
               do while .not.&_koniec
*@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
liczba=liczba+1
k1=dos_c(str(liczba,5))
k2=dzien
k3=SubStr( iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer), 1, 10 )
k4=nazwa
K5=WYR_TOW+USLUGI
K6=ZAKUP+UBOCZNE+REKLAMA+WYNAGR_G+WYDATKI
P=' '
R=' '
if WYR_TOW<>0
   P='s'
   SS=SS+WYR_TOW
endif
if USLUGI<>0
   P='i'
   SI=SI+USLUGI
endif
if ZAKUP<>0
   R='z'
   if left(NUMER,3)='RZ-'
      SZr=SZr+ZAKUP
   else
      SZ=SZ+ZAKUP
   endif
endif
if UBOCZNE<>0
   R='u'
   if left(NUMER,3)='RZ-'
      SUr=SUr+UBOCZNE
   else
      SU=SU+UBOCZNE
   endif
endif
if REKLAMA<>0
   R='r'
   if left(NUMER,3)='RZ-'
      SRr=SRr+REKLAMA
   else
      SR=SR+REKLAMA
   endif
endif
if WYNAGR_G<>0
   R='w'
   if left(NUMER,3)='RZ-'
      SWr=SWr+WYNAGR_G
   else
      SW=SW+WYNAGR_G
   endif
endif
if WYDATKI<>0
   R='k'
   if left(NUMER,3)='RZ-'
      SKr=SKr+WYDATKI
   else
      SK=SK+WYDATKI
   endif
endif
znumer=numer
skip
*@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
   s0_5=s0_5+k5
   s0_6=s0_6+k6
endif
k4=substr(k4,1,26)
if k5=0
   k5=space(14)
else
   k5=kwota(k5,14,2)
endif
if k6=0
   k6=space(14)
else
   k6=kwota(k6,14,2)
endif
mon_drk([ ]+k1+[  ]+k2+[  ]+k3+[ ]+k4+[ ]+k5+P+k6+R)
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               _numer=0
               do case
               endcase
               _grupa=.f.
               enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
mon_drk([                     R A Z E M                    ]+kwota(s0_5,14,2)+[ ]+kwota(s0_6,14,2))
mon_drk([])
mon_drk([        s - sprzeda&_z. towar&_o.w i us&_l.ug (kol. 7)     ]+kwota(SS,14,2))
mon_drk([        i - inne przychody           (kol. 8)     ]+kwota(SI,14,2))
mon_drk([                                                  --------------])
mon_drk([                                      PRZYCHODY   ]+kwota(SS+SI,14,2))
mon_drk([])
         mon_drk([                                                 KSI&__E.GA     REJESTR    RAZEM   ])
   mon_drk([        z - zakup towar&_o.w i materia&_l..(kol.10)  ]+kwota(SZ,10,2)+[ ]+kwota(SZr,10,2)+[ ]+kwota(sz+SZr,10,2))
         mon_drk([        u - uboczne koszty zakupu    (kol.11)  ]+kwota(SU,10,2)+[ ]+kwota(SUr,10,2)+[ ]+kwota(su+SUr,10,2))
         mon_drk([        r - koszty reprez.i reklamy  (kol.12)  ]+kwota(SR,10,2)+[ ]+kwota(SRr,10,2)+[ ]+kwota(sr+SRr,10,2))
         mon_drk([        w - wynagrodzenia            (kol.13)  ]+kwota(SW,10,2)+[ ]+kwota(SWr,10,2)+[ ]+kwota(sw+SWr,10,2))
      mon_drk([        k - koszty pozosta&_l.e         (kol.14)  ]+kwota(SK,10,2)+[ ]+kwota(SKr,10,2)+[ ]+kwota(sk+SKr,10,2))
         mon_drk([                                               ---------- ---------- ----------])
         mon_drk([                                      ROZCHODY ]+kwota(SZ+SU+SR+SW+SK,10,2)+[ ]+kwota(SZr+SUr+SRr+SWr+SKr,10,2)+[ ]+kwota(SZ+SU+SR+SW+SK+SZr+SUr+SRr+SWr+SKr,10,2))
mon_drk([])
mon_drk([                     U&_z.ytkownik programu komputerowego])
mon_drk([             ]+dos_c(code()))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([þ])
               end
               if _czy_close
               close_()
               endif
