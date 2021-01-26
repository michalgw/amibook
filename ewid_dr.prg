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

PROCEDURE ewid_dr()

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=130
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=130
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
         set index to suma_mc
         seek [+]+ident_fir+mc_rozp
         liczba=firma->liczba-1
         do while del=[+].and.firma=ident_fir.and.mc<miesiac
            liczba=liczba+pozycje
            skip
         enddo
         liczba_=liczba
      else
         sele 1
         break
      endif
      select 1
      if dostep('EWID')
         do SETIND with 'EWID'
         seek [+]+ident_fir+miesiac
      else
         break
      endif
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      mon_drk([ö]+procname())
      if _mon_drk=2
         _lewa=1
         _prawa=130
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_4,s0_4a,s0_4b,s0_4c,s0_5,s0_6,s0_7,s0_4d
      store 0 to s1_4,s1_4a,s1_4b,s1_4c,s1_5,s1_6,s1_7,s1_4d
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
            k28=k1+' '+k2
            select firma
            k3=alltrim(nazwa)
            kk3=scal(miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
            select ewid
            k3=k3+space(70-len(k3))
            k4=int(strona/max(1,_druk_2-18))+1
            k4a=kwota(staw_ry20*100,5,2)
            k4b=kwota(staw_ry17*100,5,2)
            k4c=kwota(staw_ry10*100,5,2)
            k5=kwota(staw_hand*100,5,2)
            k6=kwota(staw_prod*100,5,2)
            k7=kwota(staw_uslu*100,5,2)
            rk7 := Kwota( staw_rk07 * 100, 5, 2 )

            k5opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory20, 1, 9 ) ) ) + ')', 11 )
            k6opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory17, 1, 9 ) ) ) + ')', 11 )
            k7opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ouslu, 1, 9 ) ) ) + ')', 11 )
            k8opis := PadC( '(' + Lower( AllTrim( SubStr( staw_oprod, 1, 9 ) ) ) + ')', 11 )
            k9opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ohand, 1, 9 ) ) ) + ')', 11 )
            k10opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork07, 1, 9 ) ) ) + ')', 11 )
            k11opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory10, 1, 9 ) ) ) + ')', 11 )

            p_folio1 =s1_4
            p_folio1a=s1_4a
            p_folio1b=s1_4b
            p_folio1c=s1_4c
            p_folio2 =s1_5
            p_folio3 =s1_6
            p_folio4 =s1_7
            p_folio1d=s1_4d
            store 0 to s_folio1,s_folio1a,s_folio1b,s_folio1c,s_folio2,s_folio3,s_folio4,s_folio1d
            mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[ str.]+str(k4,3))
            mon_drk([ ]+kk3)
            mon_drk([ÚÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³     ³ Data³   Data   ³Nr dowodu ³                      Kwota przychodu opodatkowana wg stawk&_a.                       ³   Og&_o.&_l.em ³])
            mon_drk([³ Lp. ³wpisu³uzyskania ³na podsta-ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´ przych&_o.d ³])
            mon_drk([³     ³     ³przychodu ³wie kt&_o.re-³   ]+k4a+[   ³   ]+k4b+[   ³   ]+k7+[   ³   ]+k6+[   ³   ]+k5+[   ³   ]+rk7+[   ³   ]+k4c+[   ³(5+6+7+8+9³])
            mon_drk([³     ³     ³          ³go ksi&_e.go.³] + k5opis + [³] + k6opis + [³] + k7opis + [³] + k8opis + [³] + k9opis + [³] + k10opis + [³] + k11opis + [³  +10+11) ³])
            mon_drk([³ (1) ³ (2) ³    (3)   ³    (4)   ³     (5)   ³     (6)   ³     (7)   ³    (8)    ³    (9)    ³   (10)    ³   (11)    ³   (12)   ³])
            mon_drk([ÃÄÄÄÄÄÅÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´])
         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         liczba=liczba+1
         k1=liczba
         k2=strtran(dzien+'.'+miesiac,' ','0')
         k2a=dtoc(dataprzy)
         k3=SubStr( iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer), 1, 10 )
         k4a=ry20
         k4b=ry17
         k4c=ry10
         k4=uslugi
         k5=produkcja
         k6=handel
         k4d=ryk07
*         iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         k7=iif('REM-P'$k3.or.'REM-K'$k3,0,k4)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k5)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k6)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         k8=uwagi
         skip
         s_folio1 =s_folio1 +iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         s_folio1a=s_folio1a+iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)
         s_folio1b=s_folio1b+iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)
         s_folio1c=s_folio1c+iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)
         s_folio2 =s_folio2 +iif('REM-P'$k3.or.'REM-K'$k3,0,k5)
         s_folio3 =s_folio3 +iif('REM-P'$k3.or.'REM-K'$k3,0,k6)
         s_folio1d=s_folio1d+iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         s_folio4 =s_folio4 +k7
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s1_4=s1_4+iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         s1_4a=s1_4a+iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)
         s1_4b=s1_4b+iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)
         s1_4c=s1_4c+iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)
         s1_5=s1_5+iif('REM-P'$k3.or.'REM-K'$k3,0,k5)
         s1_6=s1_6+iif('REM-P'$k3.or.'REM-K'$k3,0,k6)
         s1_4d=s1_4d+iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         s1_7=s1_7+k7
         k1=str(k1,5)
         k4=iif(k4#0,str(k4,11,2),space(11))
         k4a=iif(k4a#0,str(k4a,11,2),space(11))
         k4b=iif(k4b#0,str(k4b,11,2),space(11))
         k4c=iif(k4c#0,str(k4c,11,2),space(11))
         k5=iif(k5#0,str(k5,11,2),space(11))
         k6=iif(k6#0,str(k6,11,2),space(11))
         k7=iif(k7#0,str(k7,11,2),space(11))
         k4d=iif(k4d#0,str(k4d,11,2),space(11))
         mon_drk([³]+k1+[³]+k2+[³]+k2a+[³]+k3+[³]+k4a+[³]+k4b+[³]+k4+[³]+k5+[³]+k6+[³]+k4d+[³]+k4c+[³]+k7)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-18))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k1 =s_folio1
            k1a=s_folio1a
            k1b=s_folio1b
            k1c=s_folio1c
            k2 =s_folio2
            k3 =s_folio3
            k4 =s_folio4
            k1d=s_folio1d
            k6 =p_folio1
            k6a=p_folio1a
            k6b=p_folio1b
            k6c=p_folio1c
            k6d=p_folio1d
            k7 =p_folio2
            k8 =p_folio3
            k9 =p_folio4
            k29=dos_c(code())
            mon_drk([ÀÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([ Podsumowanie strony              ³]+str(k1a,11,2)+[³]+str(k1b,11,2)+[³]+str(k1,11,2)+[³]+str(k2,11,2)+[³]+str(k3,11,2)+[³]+str(k1d,11,2)+[³]+str(k1c,11,2)+[³]+str(k4,11,2))
            mon_drk([                                  ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([ Przeniesienie z poprzedniej      ³]+str(k6a,11,2)+[³]+str(k6b,11,2)+[³]+str(k6,11,2)+[³]+str(k7,11,2)+[³]+str(k8,11,2)+[³]+str(k6d,11,2)+[³]+str(k6c,11,2)+[³]+str(k9,11,2))
            mon_drk([ strony                           ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´])
            if .not.&_koniec
               sumtex='strony do przeniesienia'
               sumtex1=space(20)
            else
               sumtex='przychodow za miesiac  '
               sumtex1=padr(alltrim(k28),20)
            endif
            mon_drk([ Suma ]+sumtex+[     ³]+str(s1_4a,11,2)+[³]+str(s1_4b,11,2)+[³]+str(s1_4,11,2)+[³]+str(s1_5,11,2)+[³]+str(s1_6,11,2)+[³]+str(s1_4d,11,2)+[³]+str(s1_4c,11,2)+[³]+str(s1_7,11,2))
            mon_drk([ ]+sumtex1+[             ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ])
            mon_drk([                 U&_z.ytkownik programu komputerowego])
            mon_drk([         ]+k29)
            s0_4=s0_4+s1_4
            s0_4a=s0_4a+s1_4a
            s0_4b=s0_4b+s1_4b
            s0_4c=s0_4c+s1_4c
            s0_5=s0_5+s1_5
            s0_6=s0_6+s1_6
            s0_4d=s0_4d+s1_4d
            s0_7=s0_7+s1_7
         endif
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if _czy_close
   close_()
endif
