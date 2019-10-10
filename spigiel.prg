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
publ czesc
czesc=1
begin sequence
   @ 1,47 say space(10)
   *-----parametry wewnetrzne-----
   _papsz=2
   _lewa=1
   _prawa=177
   _strona=.t.
   _czy_mon=.t.
   _czy_close=.t.
   *------------------------------
   _szerokosc=177
   _koniec="del#[+].or.firma#ident_fir.or.strtran(mc+[.]+dzien,' ','0')<od_dnia_.or.strtran(mc+[.]+dzien,' ','0')>do_dnia_.or.nazwa>do_kontr"
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   stronap=1
   stronak=99999
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   od_dnia=ctod(param_rok+[.01.01])
   do_dnia=ctod(param_rok+'.'+substr(dtoc(date()),6))
   od_kontr=[                                        ]
   do_kontr=[ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ]
   @ 21,1  clear to 22,75
   @ 21,1  say [Od dnia] get od_dnia
   @ 22,1  say [Do dnia] get do_dnia
   @ 21,20 say [Od kontrahenta] get od_kontr picture [!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]
   @ 22,20 say [Do kontrahenta] get do_kontr picture [!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]
   read_()
   if lastkey()=27
      break
   endif
   if od_dnia>do_dnia.or.year(od_dnia)#val(param_rok).or.year(do_dnia)#val(param_rok)
      kom(3,[*u],[ Nieprawid&_l.owy zakres ])
      break
   endif
   od_dnia_=substr(dtoc(od_dnia),6)
   do_dnia_=substr(dtoc(do_dnia),6)
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   select 2
   if dostep('POZYCJE')
      set inde to pozycje
   else
      sele 1
      break
   endif
   select 1
   if dostepex('FAKTURY')
      set color to *w
      center(24,[Prosz&_e. czeka&_c....])
      set color to
      index on del+firma+iif(strtran(mc+[.]+dzien,' ','0')>=od_dnia_.and.strtran(mc+[.]+dzien,' ','0')<=do_dnia_,[+],[-])+substr(nazwa,1,15)+substr(adres,1,15)+mc+dzien to rob
      seek [+]+ident_fir+[+]+od_kontr
   else
      sele 1
      break
   endif
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   if &_koniec
      kom(3,[*w],[b r a k   d a n y c h])
      break
   endif
   strona=0
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   STRL=1
   @ 24,0
   IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'szercal']=10
      _papsz=1
      @ 24,15 prompt '[ Wszystkie ]'
      @ 24,30 prompt '[ Lewe ]'
      @ 24,41 prompt '[ Prawe ]'
      clear type
      menu to STRL
      do case
      case STRL=1
           S1=1
           S2=2
      case STRL=2
           S1=1
           S2=1
      case STRL=3
           S1=2
           S2=2
      endcase
      if lastkey()=27
         break
      endif
   else
      S1=1
      S2=1
   endif
   mon_drk([ö]+procname())
   for czesc=iif(_mon_drk#2,1,S1) to iif(_mon_drk#2,1,S2)
       if _mon_drk=2.and.czesc=1
          _lewa=1
         IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'szercal']=10
             _prawa=130
          else
             _prawa=177
          endif
       endif
       if _mon_drk=2.and.czesc=2
          seek [+]+ident_fir+[+]+od_kontr
          strona=0
          //eject
          IF Len(buforDruku) > 0 .AND. buforDruku != kodStartDruku
             buforDruku = buforDruku + kod_eject
             IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'podzialstr'] == .T.
                drukujNowy(buforDruku, 1)
                buforDruku := ''
             ENDIF
             buforDruku = buforDruku + kodStartDruku
          ENDIF
          _lewa=131
          _prawa=177
          _wiersz=_druk_2
          STRONAB=_wiersz/_druk_2+1
          if _mon_drk=2 .and.(_druk_1=1 .or. _druk_1=2)
             //set device to screen
             do while .not.entesc([*i]," Teraz b&_e.dzie drukowana prawa cz&_e.&_s.&_c. rejestru - zmie&_n. papier i naci&_s.nij [Enter] ")
                if lastkey()=27
                   exit
                endif
             enddo
             /*do while .not.isprinter()
                if .not.entesc([*u],' Uruchom drukark&_e. i naci&_s.nij [Enter] ')
                   exit
                endif
             enddo*/
             set color to *w
             center(24,[Prosz&_e. czeka&_c....])
             set color to
             //set device to print
*            @ 0,_druk_4 say chr(15)+chr(27)+chr(51)+iif(_druk_3=1,chr(23),chr(34))
          endif
       endif
       *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
       k1=dtoc(od_dnia)
       k2=dtoc(do_dnia)
       mon_drk([ ZESTAWIENIE FAKTUR WG KONTRAHENTA za okres od  ]+k1+[  do  ]+k2)
       mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
       mon_drk([³                                                              ³    Data   ³ Numer ³                                             ³              ³      Cena     ³    Warto&_s.&_c.    ³])
       mon_drk([³       Kontrahent                       Adres                 ³  faktury  ³faktury³                  Nazwa towaru               ³     Ilo&_s.&_c.    ³     brutto    ³    brutto     ³])
       mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
       store 0 to s0_8
       *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
       _grupa1=nazwa+adres
       _grupa2=rec_no
       store [] to _t1,_t2
       _grupa=.t.
       do while .not.&_koniec
          zRACH=RACH
          if _grupa.or._grupa1#nazwa+adres
             _grupa1=nazwa+adres
             _grupa=.t.
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             il_fakt=1
             store 0 to s1_8
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          endif
          if _grupa.or._grupa2#rec_no
             _grupa2=rec_no
             _grupa=.t.
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             zident=[+]+str(rec_no,8)
             select pozycje
             seek zident
             select 1
             il_poz=1
             store 0 to s2_8
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          endif
          *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
          if il_fakt=1
             k1=substr(nazwa,1,40)
             k2=adres
          else
             k1=space(40)
             k2=space(40)
          endif
          k3=param_rok+[.]+strtran(mc,[ ],[0])+[.]+strtran(dzien,[ ],[0])
          zRACH=RACH
          k4=zRACH+'-'+str(numer,5)
          zident=[+]+str(rec_no,8)
          select pozycje
          k5=left(towar,44)
          **************ilosc**************
          if ilosc=0
             k6=space(13)
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
             k6=zm
          endif
          *********************************
          k7=iif(ilosc=0,space(14),kwota(cena*(1+(val(VAT)/100)),14,2))
          k8=wartosc*(1+(val(VAT)/100))
          skip
          if del+ident=zident
             il_poz=il_poz+1
          else
             select 1
             zm=del+nazwa+adres
             skip
             if del+nazwa+adres=zm
                il_fakt=il_fakt+1
             endif
          endif
          select 1
          *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          s2_8=s2_8+k8
          k8=kwota(k8,14,2)
          if _grupa.or.k1#_t1
             _grupa=.t.
             _t1=k1
          else
             k1=space(len(k1))
          endif
          if _grupa.or.k2#_t2
             _grupa=.t.
             _t2=k2
          else
             k2=space(len(k2))
          endif
          mon_drk([ ]+k1+[ ]+substr(k2,1,21)+[  ]+k3+[ ]+k4+[ ]+k5+[   ]+k6+[  ]+k7+[  ]+k8)
          *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          _numer=2
          do case
          case nazwa+adres#_grupa1.or.&_koniec
               _numer=0
          case rec_no#_grupa2
               _numer=1
          endcase
          _grupa=.f.
          if _numer<2
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             if il_poz>1
                mon_drk([                                                                                                                                        R a z e m   f a k t u r a ]+kwota(s2_8,14,2))
             endif
             if il_fakt>1
                mon_drk([                                                              ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
             endif
             s1_8=s1_8+s2_8
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          endif
          if _numer<1
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             if il_fakt>1
                mon_drk([                                                                                                                                  R A Z E M   K O N T R A H E N T ]+kwota(s1_8,14,2))
             endif
             mon_drk(repl('=',177))
             s0_8=s0_8+s1_8
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          endif
       enddo
       *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
       mon_drk([                                                                                                                                                      O G &__O. &__L. E M ]+kwota(s0_8,14,2))
       *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   next
   mon_drk([ş])
end
if _czy_close
   close_()
endif
