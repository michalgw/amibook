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
      _prawa=260
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
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
      startl=liczba
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
      /*
      mon_drk([ö]+procname())
      if _mon_drk=2
         _lewa=1
         _prawa=130
      endif
      */

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
      store 0 to s0_5,s0_6,s0_7,s0_8,s0_9,s0_10,s0_11,s0_12,s0_13,s0_14
      store 0 to s1_5,s1_6,s1_7,s1_8,s1_9,s1_10,s1_11,s1_12,s1_13,s1_14
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
            k5st=kwota(staw_ry20*100,5,2)
            k6st=kwota(staw_ry17*100,5,2)
            k7st=kwota(staw_rk09*100,5,2)
            k8st=kwota(staw_uslu*100,5,2)
            k9st=kwota(staw_rk10*100,5,2)
            k10st=kwota(staw_prod*100,5,2)
            k11st := Kwota( staw_hand * 100, 5, 2 )
            k12st := Kwota( staw_rk07 * 100, 5, 2 )
            k13st := Kwota( staw_ry10 * 100, 5, 2 )

            k5opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory20, 1, 9 ) ) ) + ')', 13 )
            k6opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory17, 1, 9 ) ) ) + ')', 13 )
            k7opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork09, 1, 9 ) ) ) + ')', 13 )
            k8opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ouslu, 1, 9 ) ) ) + ')', 13 )
            k9opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork10, 1, 9 ) ) ) + ')', 13 )
            k10opis := PadC( '(' + Lower( AllTrim( SubStr( staw_oprod, 1, 9 ) ) ) + ')', 13 )
            k11opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ohand, 1, 9 ) ) ) + ')', 13 )
            k12opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ork07, 1, 9 ) ) ) + ')', 13 )
            k13opis := PadC( '(' + Lower( AllTrim( SubStr( staw_ory10, 1, 9 ) ) ) + ')', 13 )

            p_folio5  := s1_5
            p_folio6  := s1_6
            p_folio7  := s1_7
            p_folio8  := s1_8
            p_folio9  := s1_9
            p_folio10 := s1_10
            p_folio11 := s1_11
            p_folio12 := s1_12
            p_folio13 := s1_13
            p_folio14 := s1_14
            store 0 to s_folio5,s_folio6,s_folio7,s_folio8,s_folio9,s_folio10,s_folio11,s_folio12,s_folio13,s_folio14
            mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[                             str.]+str(k4,3) + [        ]+k1+[ ]+k2+[ ]+k3+[                             str.]+str(k4,3))
            mon_drk([ ]+kk3)
            mon_drk([ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³     ³   DATA   ³   Data   ³                              ³               Kwota przychodu opodatkowana wg stawki                ³³     ³        Kwota przychodu opodatkowana wg stawki         ³    Og¢ˆem   ³                                                    ³])
            mon_drk([³ Lp. ³   wpisu  ³uzyskania ³   Nr dowodu, na podstawie    ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ´³ Lp. ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ´  przych¢d   ³                                                    ³])
            mon_drk([³     ³          ³przychodu ³    kt¢rego dokonano wpisu    ³    ]+k5st+[    ³    ]+k6st+[    ³    ]+k7st+[    ³    ]+k8st+[    ³    ]+k9st+[    ³³     ³    ]+k10st+[    ³    ]+k11st+[    ³    ]+k12st+[    ³    ]+k13st+[    ³(5+6+7+8+9+10³                       Uwagi                        ³])
            mon_drk([³     ³          ³          ³                              ³] + k5opis + [³] + k6opis + [³] + k7opis + [³] + k8opis + [³] + k9opis + [³³     ³] + k10opis + [³] + k11opis + [³] + k12opis + [³] + k13opis + [³  +11+12+13) ³                                                    ³])
            mon_drk([³ (1) ³    (2)   ³    (3)   ³             (4)              ³     (5)     ³     (6)     ³     (7)     ³     (8)     ³     (9)     ³³ (1) ³    (10)     ³    (11)     ³     (12)    ³     (13)    ³     (14)    ³                        (15)                        ³])
            mon_drk([ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
         ENDIF
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona := strona + 1
         liczba := liczba + 1
         k1 := liczba
         k2 := param_rok + '.' + StrTran( miesiac + '.' + dzien, ' ', '0' )
         k3 := DToC( dataprzy )
         k4 := SubStr( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ) + [ ], numer ), 1, 30 )
         k5 := ry20
         k6 := ry17
         k7 := ryk09
         k8 := uslugi
         k9 := ryk10
         k10 := produkcja
         k11 := handel
         k12 := ryk07
         k13 := ry10

*         iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         k14 := iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k5 + k6 + k7 + k8 + k9 + k10 + k11 + k12 + k13 )
         k15 := SubStr( uwagi, 1, 52 )
         SKIP
         s_folio5  := s_folio5  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k5 )
         s_folio6  := s_folio6  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k6 )
         s_folio7  := s_folio7  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k7 )
         s_folio8  := s_folio8  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k8 )
         s_folio9  := s_folio9  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k9 )
         s_folio10 := s_folio10 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k10 )
         s_folio11 := s_folio11 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k11 )
         s_folio12 := s_folio12 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k12 )
         s_folio13 := s_folio13 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k13 )
         s_folio14 := s_folio14 + k14
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         s1_5  := s1_5   + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k5 )
         s1_6  := s1_6   + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k6 )
         s1_7  := s1_7   + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k7 )
         s1_8  := s1_8   + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k8 )
         s1_9  := s1_9   + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k9 )
         s1_10 := s1_10  + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k10 )
         s1_11 := s1_11 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k11 )
         s1_12 := s1_12 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k12 )
         s1_13 := s1_13 + iif( 'REM-P' $ k4 .OR. 'REM-K' $ k4, 0, k13 )
         s1_14 := s1_14 + k14

         k1 := Str( k1, 5 )
         k5 := tran( k5, '@ZE 99 999 999.99' )
         k6 := tran( k6, '@ZE 99 999 999.99' )
         k7 := tran( k7, '@ZE 99 999 999.99' )
         k8 := tran( k8, '@ZE 99 999 999.99' )
         k9 := tran( k9, '@ZE 99 999 999.99' )
         k10 := tran( k10, '@ZE 99 999 999.99' )
         k11 := tran( k11, '@ZE 99 999 999.99' )
         k12 := tran( k12, '@ZE 99 999 999.99' )
         k13 := tran( k13, '@ZE 99 999 999.99' )
         k14 := tran( k14, '@ZE 99 999 999.99' )

         mon_drk([³]+k1+[³]+k2+[³]+k3+[³]+k4+[³]+k5+[³]+k6+[³]+k7+[³]+k8+[³]+k9+[³³]+k1+[³]+k10+[³]+k11+[³]+k12+[³]+k13+[³]+k14+[³]+k15+[³])
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-18))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k5   := tran( s_folio5, '@ZE 99 999 999.99' )
            k6   := tran( s_folio6, '@ZE 99 999 999.99' )
            k7   := tran( s_folio7, '@ZE 99 999 999.99' )
            k8   := tran( s_folio8, '@ZE 99 999 999.99' )
            k9   := tran( s_folio9, '@ZE 99 999 999.99' )
            k10  := tran( s_folio10, '@ZE 99 999 999.99' )
            k11  := tran( s_folio11, '@ZE 99 999 999.99' )
            k12  := tran( s_folio12, '@ZE 99 999 999.99' )
            k13  := tran( s_folio13, '@ZE 99 999 999.99' )
            k14  := tran( s_folio14, '@ZE 99 999 999.99' )
            k5b  := tran( p_folio5, '@ZE 99 999 999.99' )
            k6b  := tran( p_folio6, '@ZE 99 999 999.99' )
            k7b  := tran( p_folio7, '@ZE 99 999 999.99' )
            k8b  := tran( p_folio8, '@ZE 99 999 999.99' )
            k9b  := tran( p_folio9, '@ZE 99 999 999.99' )
            k10b := tran( p_folio10, '@ZE 99 999 999.99' )
            k11b := tran( p_folio11, '@ZE 99 999 999.99' )
            k12b := tran( p_folio12, '@ZE 99 999 999.99' )
            k13b := tran( p_folio13, '@ZE 99 999 999.99' )
            k14b := tran( p_folio14, '@ZE 99 999 999.99' )
            k29=dos_c(code())
            mon_drk([ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                    Podsumowanie strony                    ³]+k5+[³]+k6+[³]+k7+[³]+k8+[³]+k9+[³³     ³]+k10+[³]+k11+[³]+k12+[³]+k13+[³]+k14+[³                                                    ³])
            mon_drk([                                                           ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
            mon_drk([                    Przeniesienie z poprzedniej strony     ³]+k5b+[³]+k6b+[³]+k7b+[³]+k8b+[³]+k9b+[³³     ³]+k10b+[³]+k11b+[³]+k12b+[³]+k13b+[³]+k14b+[³                                                    ³])
            mon_drk([                                                           ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄ´ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
            if .not.&_koniec
               sumtex='strony do przeniesienia'
               sumtex1=space(20)
            else
               sumtex='przychodow za miesiac  '
               sumtex1=padr(alltrim(k28),20)
            endif
            k5   := tran( s1_5, '@ZE 99 999 999.99' )
            k6   := tran( s1_6, '@ZE 99 999 999.99' )
            k7   := tran( s1_7, '@ZE 99 999 999.99' )
            k8   := tran( s1_8, '@ZE 99 999 999.99' )
            k9   := tran( s1_9, '@ZE 99 999 999.99' )
            k10  := tran( s1_10, '@ZE 99 999 999.99' )
            k11  := tran( s1_11, '@ZE 99 999 999.99' )
            k12  := tran( s1_12, '@ZE 99 999 999.99' )
            k13  := tran( s1_13, '@ZE 99 999 999.99' )
            k14  := tran( s1_14, '@ZE 99 999 999.99' )
            mon_drk([                    Suma ]+sumtex+[           ³]+k5+[³]+k6+[³]+k7+[³]+k8+[³]+k9+[³³     ³]+k10+[³]+k11+[³]+k12+[³]+k13+[³]+k14+[³                                                    ³])
            mon_drk([                    ]+sumtex1+[                   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            mon_drk([                    U&_z.ytkownik programu komputerowego])
            mon_drk([                    ]+k29)
            s0_5 =s0_5 +s1_5
            s0_6 =s0_6 +s1_6
            s0_7 =s0_7 +s1_7
            s0_8 =s0_8 +s1_8
            s0_9 =s0_9 +s1_9
            s0_10=s0_10+s1_10
            s0_11=s0_11+s1_11
            s0_12=s0_12+s1_12
            s0_13=s0_13+s1_13
            s0_14=s0_14+s1_14
         endif
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      next
      mon_drk([ş])
end
if _czy_close
   close_()
endif
