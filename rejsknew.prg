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

FUNCTION rejsknew( ewid_rss, ewid_rsk, ewid_rsi )

   LOCAL aNumerWiersze

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
publ czesc
ewid_rsd='*'
czesc=0
begin sequence
   @ 1,47 say space(10)
   *-----parametry wewnetrzne-----
   _papsz=1
   _lewa=1
   _prawa=245
   _strona=.f.
   _czy_mon=.t.
   _czy_close=.t.
   *------------------------------
   _szerokosc=245
   _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   stronap=1
   stronak=99999
   JEST=0
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   OPRE=''
   select 7
   if ewid_rsi<>'**'
      DO WHILE.NOT.dostep('KAT_SPR')
      ENDDO
      set inde to KAT_SPR
      seek [+]+ident_fir+ewid_rsi
      if found()
         OPRE=alltrim(opis)
      endif
   else
      OPRE='WSZYSTKIE REJESTRY RAZEM'
   endif
   use
   select 4
   if dostep('KONTR')
      do setind with 'KONTR'
   else
      sele 1
      break
   endif
   select 3
   if dostep('FIRMA')
      go val(ident_fir)
   else
      sele 1
      break
   endif
   liczba=0
   liczba_=liczba
   select 1
   if dostep('REJS')
      do SETIND with 'REJS'
      seek '+'+ident_fir+miesiac
   else
      sele 1
      break
   endif
   if eof().or.&_koniec
      kom(3,[*w],[b r a k   d a n y c h])
      break
   else
      seek '+'+ident_fir+miesiac
      do while .not.eof().and..not.&_koniec
         if iif(ewid_rsk<>'R',rejs->korekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',rejs->SYMB_REJ=ewid_rsi,.t.).and.iif(ewid_rsd<>'*',rejs->rach=ewid_rsd,.t.)
            JEST=1
            exit
         else
            skip 1
         endif
      enddo
      if JEST=0
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
   endif
   strona=0
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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
       endif
       if _mon_drk=2.and.czesc=2
          seek [+]+ident_fir+miesiac
          liczba=liczba_-1
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
          _prawa=245
         IF aProfileDrukarek[nWybProfilDrukarkiIdx, 'szercal']<>10
             _wiersz=0
          else
             _wiersz=_druk_2
          endif
          STRONAB=_wiersz/_druk_2+1
          if _mon_drk=2 .and.(_druk_1=1 .or. _druk_1=2)
             //set device to screen
             do while .not.entesc([*i]," Teraz bedzie drukowana prawa czesc rejestru - zmien papier i nacisnij [Enter] ")
                if lastkey()=27
                   exit
                endif
             enddo
             /*do while .not.isprinter()
                if .not.entesc([*u],' Uruchom drukarke i nacisnij [Enter] ')
                   exit
                endif
             enddo*/
             set color to *w
             center(24,[Prosze czekac...])
             set color to
             //set device to print
*            @ 0,_druk_4 say chr(15)+chr(27)+chr(51)+iif(_druk_3=1,chr(23),chr(34))
          endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_8,s0_9,s0_10,s0_11,s0_12,s0_13,s0_14,s1_9,s1_11,s1_13,s1_14,s2_9,s2_11,s2_13,s2_14
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dos_p(upper(miesiac(val(miesiac))))
      k2=param_rok
      _grupa1=int(strona/max(1,_druk_2-12))
      _grupa=.t.
      _numer=1
      do while .not.&_koniec
         if (_grupa.or._grupa1#int(strona/max(1,_druk_2-12))).and.iif(ewid_rsk<>'R',rejs->korekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',rejs->SYMB_REJ=ewid_rsi,.t.).and.iif(ewid_rsd<>'*',rejs->rach=ewid_rsd,.t.)
            _grupa1=int(strona/max(1,_druk_2-12))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(upper(miesiac(val(miesiac))))
            k2=param_rok
            select firma
            ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
            select rejs
            k3=ks+space(100-len(ks))
            k4=int(strona/max(1,_druk_2-12))+1
            k5=k1
            k6=k2
            k7=ks+space(90-len(ks))
            k8=k4
            rs_kol=iif(ewid_rss='B','BRUTTO','NETTO ')
mon_drk([     REJESTR SPRZEDAZY-KOREKTY (ewidenc. sprzedazy dla KPIR) za miesiac ]+k1+[.]+k2+[ (]+ewid_rsi+[ - ]+padr(opre,40)+[)  REJESTR SPRZEDAZY-KOREKTY (ewidenc. sprzedazy dla KPIR) za miesiac ]+k1+[.]+k2+[ (]+ewid_rsi+[ - ]+padr(opre,40)+[)])
mon_drk([     ]+k3+[         str. ]+str(k4,3)+[          ]+k7+[           str. ]+str(k8,3))
mon_drk([ÚÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³     ³ DATA³   DATA   ³        ³KOLU-³          ³                              ³      NUMER      ³                              ³³RE³    OGOLNA    ³    SPRZEDAZ OPODATKOWANA    ³ SPRZED.ZWOLN.³  RAZEM DOKUMENT KORYGUJACY  ³]+;
         [                    ³])
mon_drk([³ L.p.³WYST-³  SPRZE-  ³ RODZAJ ³ MNA ³  NUMER   ³       NAZWA ODBIORCY         ³                 ³                OPIS          ³³JE³    WARTOSC   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´]+;
         [     U W A G I      ³])
mon_drk([³     ³AWIE.³   DAZY   ³ DOWODU ³KSIEG³  DOWODU  ³                              ³ IDENTYFIKACYJNY ³             ZDARZENIA        ³³ST³    ]+rs_kol+[    ³wartosc NETTO ³ wartosc VAT  ³wartosc NETTO ³wartosc NETTO ³ wartosc VAT  ³]+;
         [                    ³])
mon_drk([ÀÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
*@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k2=strtran(dzien,' ','0')+'.'+strtran(miesiac,' ','0')
         k22=strtran(DZIENS,' ','0')+'.'+strtran(MCS,' ','0')+'.'+ROKS
         k23=iif(RACH='F','Faktura ','Rachunek')
         k24=padc(str(val(KOLUMNA),1),5)
         aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 10 )
         //k3=SubStr( iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer), 1, 10 )
         k3 := aNumerWiersze[ 1 ]
         k4=substr(nazwa,1,30)
         k5=substr(nr_ident,1,17)
         k6=tresc
         K66=SYMB_REJ
         K9=WART22+WART12+WART07+WART02+WART00
         K10=VAT22+VAT12+VAT07+VAT02
         k11=WARTZW
*        k12=iif(KOR='+',vatKOR,0)
         k13=k11+k9
         k14=k10
         sele rejs
         k15=uwagi
         zKOREKTA=KOREKTA
         zSYMB_REJ=SYMB_REJ
         znumer=numer
         zrach=rach
         k88=WART22+WART12+WART07+WART02+WART00+WARTZW+VAT22+VAT12+VAT07+VAT02
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         if iif(ewid_rsk<>'R',zkorekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',zSYMB_REJ=ewid_rsi,.t.).and.iif(ewid_rsd<>'*',zrach=ewid_rsd,.t.)
            strona=strona+1
            liczba=liczba+1
            k1=dos_c(str(liczba,5))
            k7=k1
            if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
               if ewid_rss='B'
                  s0_8=s0_8+k88
               else
                  s0_8=s0_8+k9+k11
               endif
               s0_9=s0_9+k9
               s0_10=s0_10+k10
               s0_11=s0_11+k11
*              s0_12=s0_12+k12
               s0_13=s0_13+k13
               s0_14=s0_14+k14
               s1_9=s1_9+k9+k10
               s1_11=s1_11+k11
               s1_13=s1_13+k13
               s1_14=s1_14+k14
               s2_9=s2_9+k9
               s2_11=s2_11+k11
               s2_13=s2_13+k13
               s2_14=s2_14+k14
            endif
            if k88=0
               k88=space(14)
            else
               if ewid_rss='B'
                  k88=kwota(k88,14,2)
               else
                  k88=kwota(k9+k11,14,2)
               endif
            endif
            if k9=0
               k9=space(14)
            else
               k9=kwota(k9,14,2)
            endif
            if k10=0
               k10=space(14)
            else
               k10=kwota(k10,14,2)
            endif
            if k11=0
               k11=space(14)
            else
               k11=kwota(k11,14,2)
            endif
            if k13=0
               k13=space(14)
            else
               k13=kwota(k13,14,2)
            endif
            if k14=0
               k14=space(14)
            else
               k14=kwota(k14,14,2)
            endif
            mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[  ]+K66+[ ]+k88+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k13+[ ]+k14+[ ]+k15)
            IF Len( aNumerWiersze ) > 1
               FOR i := 2 TO Len( aNumerWiersze )
                  mon_drk( "                                       " + aNumerWiersze[ i ] )
               NEXT
            ENDIF
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer=1
            do case
            case int(strona/max(1,_druk_2-12))#_grupa1
                 _numer=0
            endcase
            _grupa=.f.
         endif
         if _numer<1
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
            mon_drk([])
            mon_drk([                     Uzytkownik programu komputerowego])
            mon_drk([             ]+dos_c(code()))
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
      enddo
      IF _NUMER>=1
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      ENDIF
mon_drk(space(125)+[RAZEM    ]+kwota(s0_8,14,2)+[ ]+kwota(s0_9,14,2)+[ ]+kwota(s0_10,14,2)+[ ]+kwota(s0_11,14,2)+[ ]+kwota(s0_13,14,2)+[ ]+kwota(s0_14,14,2))
mon_drk(space(21)+padc([Uzytkownik programu komputerowego],50))
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk(space(21)+padc(alltrim(code()),50))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   next
   mon_drk([ş])
end
if _czy_close
   close_()
endif
