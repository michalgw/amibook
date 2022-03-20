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

PROCEDURE Ksiega13()

   LOCAL aNumerWiersze

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
publ czesc
czesc=0
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=260
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      *------------------------------
      _szerokosc=260
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 3
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele 1
         break
      endif
      select 2
      if dostep('SUMA_MC')
         set inde to suma_mc
      else
         sele 1
         break
      endif
      seek [+]+ident_fir+mc_rozp
      startl=firma->liczba-1
      do while del=[+].and.firma=ident_fir.and.mc<miesiac
         startl=startl+pozycje
         skip
      enddo
      liczba=startl
      liczba_=startl
      select 1
      if dostep('OPER')
         do SETIND with 'OPER'
      else
         sele 1
         break
      endif
      seek [+]+ident_fir+miesiac
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      STRL=1
      @ 24,0
      @ 24,15 prompt '[ Wszystke ]'
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
      mon_drk([ö]+procname())
      for czesc=iif(_mon_drk#2,1,S1) to iif(_mon_drk#2,1,S2)
          if _mon_drk=2.and.czesc=1
             _lewa=1
             _prawa=130
             liczba=startl
             liczba_=startl
          endif
          if _mon_drk=2.and.czesc=2
             seek [+]+ident_fir+miesiac
             liczba=startl
             liczba_=startl
*             liczba=liczba_-1
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
             _prawa=260
            IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'szercal']<>10
                _wiersz=0
             else
                _wiersz=_druk_2
             endif
             STRONAB=_wiersz/_druk_2+1
             if _mon_drk=2 .and.(_druk_1=1 .or. _druk_1=2)
                //set device to screen
                do while .not.entesc([*i]," Teraz b&_e.dzie drukowana prawa cz&_e.&_s.&_c. ksi&_e.gi - zmie&_n. papier i naci&_s.nij [Enter] ")
                   if lastkey()=27
                      exit
                   endif
                enddo
                /*do while .not.isprinter()
                   if .not.entesc([*u],' Uruchom drukark&_e. i naci&_s.nij [Enter] ')
                      exit
                   endif
                enddo*/
                do czekaj
                //set device to print
*               @ 0,_druk_4 say chr(15)+chr(27)+chr(51)+iif(_druk_3=1,chr(23),chr(34))
             endif
          endif
          *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
          store 0 to s0_7,s0_8,s0_9,s0_10,s0_11,s0_13,s0_14,s0_15,s0_16
          store 0 to s1_7,s1_8,s1_9,s1_10,s1_11,s1_13,s1_14,s1_15,s1_16
          *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          _grupa1=int(strona/max(1,_druk_2-18))
          _grupa=.t.
          do while .not.&_koniec
             if _grupa.or._grupa1#int(strona/max(1,_druk_2-18))
                _grupa1=int(strona/max(1,_druk_2-18))
                _grupa=.t.
                *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                k1=dos_p(upper(miesiac(val(miesiac))))
                k2=param_rok
                select firma
                k3=alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk
                k3=k3+space(130-len(k3))
                select oper
                k4=int(strona/max(1,_druk_2-18))+1
                p5=k1
                p6=k2
                p7=k3+space(130-len(k3))
                p8=k4
                p_folio1 =s1_7
                p_folio2 =s1_8
                p_folio3 =s1_9
                p_folio4 =s1_10
                p_folio5 =s1_11
                p_folio7 =s1_13
                p_folio8 =s1_14
                p_folio9 =s1_15
                p_folio10=s1_16
                store 0 to s_folio1,s_folio2,s_folio3,s_folio4,s_folio5,s_folio7,s_folio8,s_folio9,s_folio10
                _glow='Ksi&_e.ga Przychod&_o.w i Rozchod&_o.w za miesi&_a.c '+alltrim(k1)+','+alltrim(k2)
mon_drk([ ]+padc(_glow,118)+[   str.]+str(k4,3)+[ ]+padc(_glow,116)+[ str.]+str(p8,3))
mon_drk([ ]+k3+p7)
mon_drk([ÚÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]+;
[ÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³     ³Dzi³          ³                                 Kontrahent                                 ³                              ³³     ³              Przych&_o.d             ³    Zakup    ³           ³           Wydatki (koszty)         ]+;
[         ³              ³])
mon_drk([³     ³ie&_n.³   Nr     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´                              ³³     ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´   towar&_o.w   ³  Koszty   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂ]+;
[ÄÄÄÄÄÄÄÄÄ´              ³])
mon_drk([³     ³zda³ dowodu   ³                                      ³                                     ³        Opis  zdarzenia       ³³     ³  wartosc  ³           ³   razem   ³  handlowych ³  uboczne  ³  Wynagro- ³           ³   razem   ³]+;
[         ³      Uwagi   ³])
mon_drk([³ Lp. ³rze³ ksiego-  ³           Imie i nazwisko            ³                 Adres               ³         gospodarczego        ³³ Lp. ³sprzedanych³ pozostale ³  przychod ³  i material ³  zakupu   ³   dzenia  ³ pozostale ³  wydatki  ³]+;
[         ³              ³])
mon_drk([³     ³nia³  wego    ³                (firma)               ³                                     ³                              ³³     ³  towarow  ³ przychody ³   (7+8)   ³    wg cen   ³           ³ w got&_o.wce ³  wydatki  ³  (12+13)  ³]+;
[         ³              ³])
mon_drk([³     ³gos³          ³                                      ³                                     ³                              ³³     ³  i uslug  ³           ³           ³    zakupu   ³           ³i w naturze³           ³           ³]+;
[         ³              ³])
mon_drk([³ (1) ³(2)³    (3)   ³                  (4)                 ³                  (5)                ³              (6)             ³³ (1) ³    (7)    ³    (8)    ³    (9)    ³     (10)    ³   (11)    ³    (12)   ³    (13)   ³    (14)   ³]+;
[   (15)  ³      (16)    ³])
mon_drk([ÃÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅ]+;
[ÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
                *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             endif
             *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
             strona=strona+1
             liczba=liczba+1
             //k1=liczba
             k1=lp
             k2=dzien
             aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 10 )
             //k3=SubStr( iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer), 1, 10 )
             k3 := aNumerWiersze[ 1 ]
             k4=substr(nazwa,1,38)
             k5=substr(adres,1,37)
             k6=tresc
             k7=wyr_tow
             k8=uslugi
             k9=k7+k8
             k10=zakup
             k11=uboczne
             k13=wynagr_g
             k14=wydatki
             k15=k13+k14
             k16=pusta
             k17=uwagi
             znumer=numer
             skip
             if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                s_folio1 =s_folio1 +k7
                s_folio2 =s_folio2 +k8
                s_folio3 =s_folio3 +k9
                s_folio4 =s_folio4 +k10
                s_folio5 =s_folio5 +k11
                s_folio7 =s_folio7 +k13
                s_folio8 =s_folio8 +k14
                s_folio9 =s_folio9 +k15
                s_folio10=s_folio10+k16
             endif
             *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                s1_7 =s1_7+k7
                s1_8 =s1_8+k8
                s1_9 =s1_9+k9
                s1_10=s1_10+k10
                s1_11=s1_11+k11
                s1_13=s1_13+k13
                s1_14=s1_14+k14
                s1_15=s1_15+k15
                s1_16=s1_16+k16
             endif
             k1=str(k1,5)
             l7 =tran(k7 ,'@ZE 99999999.99')
             l8 =tran(k8 ,'@ZE 99999999.99')
             l9 =tran(k9 ,'@ZE 99999999.99')
             l10=tran(k10,'@ZE 99 999 999.99')
             l11=tran(k11,'@ZE 99999999.99')
             l13=tran(k13,'@ZE 99999999.99')
             l14=tran(k14,'@ZE 99999999.99')
             l15=tran(k15,'@ZE 99999999.99')
             l16=tran(k16,'@ZE 999999.99')
             mon_drk([³]+k1+[³]+k2+[ ³]+k3+[³]+k4+[³]+k5+[³]+k6+[³³]+k1+[³]+l7+[³]+l8+[³]+l9+[³]+l10+[³]+l11+[³]+l13+[³]+l14+[³]+l15+[³]+l16+[³]+k17+[³])
             IF Len( aNumerWiersze ) > 1
                FOR i := 2 TO Len( aNumerWiersze )
                   mon_drk( "³     ³   ³" + aNumerWiersze[ i ] + "³                                      ³                                     ³                              ³³     ³           ³           ³           ³             ³           ³           ³           ³           ³         ³              ³" )
                NEXT
             ENDIF
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             _numer=1
             do case
             case int(strona/max(1,_druk_2-18))#_grupa1.or.&_koniec
                  _numer=0
             endcase
             _grupa=.f.
             if _numer<1
                *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                l1 =tran(s_folio1 ,'@ZE 99999999.99')
                l2 =tran(s_folio2 ,'@ZE 99999999.99')
                l3 =tran(s_folio3 ,'@ZE 99999999.99')
                l4 =tran(s_folio4 ,'@ZE 99 999 999.99')
                l5 =tran(s_folio5 ,'@ZE 99999999.99')
                l7 =tran(s_folio7 ,'@ZE 99999999.99')
                l8 =tran(s_folio8 ,'@ZE 99999999.99')
                l9 =tran(s_folio9 ,'@ZE 99999999.99')
                l10=tran(s_folio10,'@ZE 999999.99')
                l15=tran(p_folio1 ,'@ZE 99999999.99')
                l16=tran(p_folio2 ,'@ZE 99999999.99')
                l17=tran(p_folio3 ,'@ZE 99999999.99')
                l18=tran(p_folio4 ,'@ZE 99 999 999.99')
                l19=tran(p_folio5 ,'@ZE 99999999.99')
                l21=tran(p_folio7 ,'@ZE 99999999.99')
                l22=tran(p_folio8 ,'@ZE 99999999.99')
                l23=tran(p_folio9 ,'@ZE 99999999.99')
                l24=tran(p_folio10,'@ZE 999999.99')
                l35=tran(s1_7 ,'@ZE 99999999.99')
                l36=tran(s1_8 ,'@ZE 99999999.99')
                l37=tran(s1_9 ,'@ZE 99999999.99')
                l38=tran(s1_10,'@ZE 99 999 999.99')
                l39=tran(s1_11,'@ZE 99999999.99')
                l41=tran(s1_13,'@ZE 99999999.99')
                l42=tran(s1_14,'@ZE 99999999.99')
                l43=tran(s1_15,'@ZE 99999999.99')
                l44=tran(s1_16,'@ZE 999999.99')
                k29=PadR( dos_c( code() ), 50 )
mon_drk([ÀÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅ]+;
[ÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
mon_drk([                                                                                                  ³           Suma folio         ³³ XXX ³]+l1+[³]+l2+[³]+l3+[³]+l4+[³]+l5+[³]+l7+[³]+l8+[³]+l9+[³]+l10+[³])
mon_drk([                                                                                                  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅ]+;
[ÄÄÄÄÄÄÄÄÄ´])
mon_drk([                              U&_z.ytkownik programu komputerowego                                   ³           Przen. z folio     ³³ XXX ³]+l15+[³]+l16+[³]+l17+[³]+l18+[³]+l19+[³]+l21+[³]+l22+[³]+l23+[³]+l24+[³])
mon_drk([                      ]+k29+                                           [                          ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅ]+;
[ÄÄÄÄÄÄÄÄÄ´])
mon_drk([                                                                                                  ³            Razem             ³³ XXX ³]+l35+[³]+l36+[³]+l37+[³]+l38+[³]+l39+[³]+l41+[³]+l42+[³]+l43+[³]+l44+[³])
mon_drk([                                                                                                  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁ]+;
[ÄÄÄÄÄÄÄÄÄÙ])
                s0_7=s0_7+s1_7
                s0_8=s0_8+s1_8
                s0_9=s0_9+s1_9
                s0_10=s0_10+s1_10
                s0_11=s0_11+s1_11
                s0_13=s0_13+s1_13
                s0_14=s0_14+s1_14
                s0_15=s0_15+s1_15
                s0_16=s0_16+s1_16
                *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             endif
          enddo
          *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
          *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      next
      mon_drk([þ])
end
if _czy_close
   close_()
endif
