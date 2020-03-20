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

private _koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private druk
para RodzWyd
begin sequence
   @ 1,47 say space(10)
   *-----parametry wewnetrzne-----
   _papsz=1
   _lewa=1
   _prawa=95
   _strona=.f.
   _czy_mon=.t.
   _czy_close=.f.
   czesc=1
   *------------------------------
   _szerokosc=95
*   _koniec="del#[+]"
*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   select 1
*   do while .not. dostep('ROBPRZEL')
*   enddo
*   index on del+nazwisko+imie1+imie2 to robprzel
   go top
   if eof()
      kom(3,[*w],[b r a k   d a n y c h])
      break
   endif
   SumWyp=0
   SumPrzel=0
   z_LP=1
   mon_drk([ö]+procname())
   if RodzWyd='L'
      mon_drk([FIRMA: ]+SYMBOL_FIR+[       Przelewy wyp&_l.at na konta pracownik&_o.w w miesi&_a.cu ]+miesiac+'.'+param_rok)
      mon_drk([ÚL.p.ÂÄÄÄÄÄÄÄNazwisko i imionaÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄNumer kontaÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄwyp&_l.ataÄÂÄprzelewÄ¿])
   else
      mon_drk(padc([BANKOWY ZBIORCZY DOW&__O.D OBCI&__A.&__Z.ENIOWY],95))
      mon_drk(padc([(zalacznik do przelewu wynagrodzen do banku: ]+alltrim(BANK)+[ )],95))
      mon_drk(' W CIEZAR RACHUNKU:')
      mon_drk('   Nazwa: '+zNazwa)
      mon_drk('    Bank: '+zBankFir)
      mon_drk('   Konto: '+iif(substr(zNrKontaFir,1,2)=='  ',substr(zNrKontaFir,4),zNrKontaFir))
      mon_drk(' NA DOBRO RACHUNKOW:')
      mon_drk([ÚL.p.ÂÄÄÄÄÄÄÄÄÄÄÄÄNazwisko i imionaÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄNumer kontaÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄKwotaÄÄ¿])
   endif
//003 nowa pozycja w tabeli
   do while .not.eof()
      if RodzWyd='L'
         druk='³'+str(z_LP,4)+'³'+padr(alltrim(NAZWISKO)+' '+alltrim(IMIE1)+' '+alltrim(IMIE2),32)+'³'+iif(substr(NrKonta,1,2)=='  ',substr(NrKonta,4)+'   ',NrKonta)+[³]+str(DO_WYPLATY,9,2)+[³]+str(PRZEL_NAKO,9,2)+'³'
      else
         druk='³'+str(z_LP,4)+'³'+padr(alltrim(NAZWISKO)+' '+alltrim(IMIE1)+' '+alltrim(IMIE2),42)+'³'+iif(substr(NrKonta,1,2)=='  ',substr(NrKonta,4)+'   ',NrKonta)+[³]+str(PRZEL_NAKO,9,2)+'³'
      endif
      mon_drk(druk)
      SumWyp=SumWyp+DO_WYPLATY
      SumPrzel=SumPrzel+PRZEL_NAKO
      z_LP++
      skip
   enddo
   if RodzWyd='L'
      mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
      mon_drk([                                                                     RAZEM ]+str(SumWyp,9,2)+' '+str(SumPrzel,9,2))
      mon_drk([                U&_z.ytkownik programu komputerowego])
      mon_drk([        ]+dos_c(code()))
   else
      mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
      mon_drk([                                                                               RAZEM ]+str(SumPrzel,9,2))
   endif
   mon_drk([ş])
end
if _czy_close
   close_()
endif
