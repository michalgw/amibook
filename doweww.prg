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
      _prawa=119
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=119
      _koniec="del#[+].or.firma#ident_fir.or.zzestaw#zestaw"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      save scre to pardow
      zdata=data
      znrdok=nrdok
      zzestaw=zestaw
      set curs on
      @ 10,23 clear to 14,57
      @ 10,23 to 14,57
      @ 11,25 say '     Pozycje z zestawu '+zzestaw
      @ 12,25 say 'drukowa&_c. jako dow&_o.d wewn&_e.trzny'
      @ 13,25 say 'nr            z dnia           '
      @ 13,28 get znrdok pict '!!!!!!!!!!'
      @ 13,46 get zdata pict '@D'
      read
      set curs off
      rest scre from pardow
      stronap=1
      stronak=99999
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 5
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele dowew
         break
      endif
      liczba=0
      if lastkey()=27
         sele dowew
         break
      endif
      sele dowew
      seek [+]+ident_fir+zzestaw
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      do while .not.&_koniec
         if drukowac
            do blokadar
            repl data with zdata,nrdok with znrdok
            COMMIT
            unlock
         endif
         skip
      enddo
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to sum7
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      sele dowew
      seek [+]+ident_fir+zzestaw
      k1=dtoc(data)
      k2=nrdok
      k3=firma->nazwa
      k31=alltrim(firma->miejsc)
      k4=int(strona/max(1,_druk_2-9))+1
      MON_DRK([Firma: ]+k3+space(14)+padl(k31+[, ]+k1,37))
      mon_drk([                                            DOW&__O.D WEWN&__E.TRZNY NR ]+k2)
      mon_drk([ÚÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³L.p³                                                O P I S                                             ³   WARTO&__S.&__C.  ³])
      mon_drk([³(1)³                                                  (2)                                               ³     (3)    ³])
      mon_drk([ÀÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      sele dowew
      do while .not.&_koniec
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         if drukowac
            liczba=liczba+1
            k1=str(liczba,3)
            k2=opis
            k3=transform(wartosc,'9 999 999.99')
            k3w=wartosc
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            sum7=sum7+k3w
            mon_drk([ ]+k1+[ ]+k2+[ ]+k3)
         endif
         sele dowew
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      enddo
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k29=dos_c(code())
            mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([             U&_z.ytkownik programu komputerowego                                                           ³]+kwota(sum7,12,2)+[³])
            mon_drk([      ]+k29+space(49)+[ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
if _czy_close
   close_()
endif
sele firma
use
sele dowew
