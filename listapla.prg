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
               private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep
               begin sequence
               @ 1,47 say space(10)
               *-----parametry wewnetrzne-----
               _papsz=1
               _lewa=1
               _prawa=130
               _strona=.f.
               _czy_mon=.t.
               _czy_close=.t.
               *------------------------------
               _szerokosc=130
               _koniec="del#[+].or.firma#ident_fir"
*@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      czesc=1
*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
sele 2
if dostep('PRAC')
   do SETIND with 'PRAC'
else
   break
endif
sele 1
if dostep('ETATY')
   do SETIND with 'ETATY'
else
   break
endif
sele prac
seek '+'+ident_fir
      strona=0
if .not.found()
   kom(3,[*w],[b r a k   d a n y c h])
   break
endif
mon_drk([ö]+procname())
      _grupa1=int(strona/max(1,_druk_2-7))
      _grupa=.t.
//002 nowa suma i k(k8 nie wyzerowane, czy tak ma byc?)
store 0 to suma1,suma2,suma3,suma4,suma5,suma6,k3,k4,k5,k6,k7,k9
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
sele prac
do while .not.&_koniec
*   REC=recno()
   REC=rec_no
   k1=padr(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),40)
   k2=pesel
   sele etaty
   seek '+'+ident_fir+str(REC,5)+miesiac
   store .f. to DOD
   store .t. to DDO
   if .not.empty(PRAC->DATA_PRZY)
      DOD=substr(dtos(PRAC->DATA_PRZY),1,6)<=param_rok+strtran(miesiac,' ','0')
   endif
   if .not.empty(PRAC->DATA_ZWOL)
      DDO=substr(dtos(PRAC->DATA_ZWOL),1,6)>=param_rok+strtran(miesiac,' ','0')
   endif
   if found().and.(DO_WYPLATY<>0.or.(DOD.and.DDO))
      if _grupa.or._grupa1#int(strona/max(1,_druk_2-7))
         _grupa1=int(strona/max(1,_druk_2-7))
         _grupa=.t.
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk([ FIRMA: ]+SYMBOL_FIR+[   Skr&_o.cona lista wyp&_l.at pracownik&_o.w etatowych w miesi&_a.cu ]+miesiac+'.'+param_rok)
         //002 NOWE ROZMIARY RAMKI
         mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
         mon_drk([³                                        ³           ³          ³         ³         ³         ³          ³          ³ Potwierdzam³])
         mon_drk([³             N A Z W I S K O            ³   PESEL   ³ Przychody- Podatek + Dop&_l.aty -Potr&_a.cen.- Przelew  =   Do     ³   odbi&_o.r   ³])
         mon_drk([³             i  I M I O N A             ³           ³  brutto  ³         ³         ³         ³ na konto ³ wyp&_l.aty  ³   got&_o.wki  ³])
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      endif
      k3=BRUT_RAZEM
      k4=PODATEK
      k5=DOPL_NIEOP
      k6=ODL_NIEOP
      k7=DO_WYPLATY-PRZEL_NAKO
//002 nowa linia
      k9=PRZEL_NAKO
      k8=slownie(iif(k7<0,0,k7))
      suma1=suma1+k3
      suma2=suma2+k4
      suma3=suma3+k5
      suma4=suma4+k6
      suma5=suma5+k7
//002 nowa linia
      suma6=suma6+k9
      k3=kwota(k3,11,2)
      k4=kwota(k4,10,2)
      k5=kwota(k5,10,2)
      k6=kwota(k6,10,2)
      k7=kwota(k7,11,2)
//002 nowa linia i zmiana w nastepnej
      k9=kwota(k9,11,2)
      mon_drk([  ]+k1+k2+k3+k4+k5+k6+k9+k7)
      mon_drk([ Do wyp&_l.aty: ]+k8)
      mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
      strona=strona+3
      _numer=1
      do case
      case int(strona/max(1,_druk_2-7))#_grupa1.or.&_koniec
           _numer=0
           _grupa=.t.
      other
           _grupa=.f.
      endcase
   endif
   sele prac
   skip
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
k3=kwota(suma1,11,2)
k4=kwota(suma2,10,2)
k5=kwota(suma3,10,2)
k6=kwota(suma4,10,2)
k7=kwota(suma5,11,2)
//002 nowa linia i zmiana w nastepnej
k9=kwota(suma6,11,2)
mon_drk([                                         ³ R A Z E M ]+K3+K4+K5+K6+K9+k7)
mon_drk([                                         ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ])
*mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
mon_drk([                U&_z.ytkownik programu komputerowego])
mon_drk([        ]+dos_c(code()))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([ş])
               end
               if _czy_close
               close_()
               endif
