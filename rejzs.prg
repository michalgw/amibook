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

FUNCTION rejzs( ewid_rzs, ewid_rzk, ewid_rzi, ewid_rzz )

   LOCAL aNumerWiersze

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t112,_t122,_t12,_t13,_t14,_t15
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
   JEST=0
   if file('rejzsze.mem')
      restore from rejzsze additive
   else
      if .not.file([rejzsze.mem])
         for x=1 to 10
             for y=1 TO 8
                 xx=strtran(str(x,2),' ','0')
                 yy=strtran(str(y,2),' ','0')
                 rspz_&xx&yy='T'
             next
         next
         save to rejzsze all like rspz_*
      endif
   endif
   @  3,42 say space(38)
   @  4,42 say space(38)
   @  5,42 say space(38)
   @  6,42 say '                ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  7,42 say '                ³      WARIANTY       '
   @  8,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @  9,42 say ' KOLUMNY KSIEGI ³ 1 2 3 4 5 6 7 8 9 10'
   @ 10,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 11,42 say '10-Zakup towarow³                     '
   @ 12,42 say '11-Koszty ubocz.³                     '
   @ 13,42 say '12-Wynagrodzenia³                     '
   @ 14,42 say '13-Pozostale wyd³                     '
   @ 15,42 say '16-Koszty badaw.³                     '
   @ 16,42 say '   NIEKSIEGOWANE³                     '
   @ 17,42 say 'RACHUNKI (T/N) ?³                     '
   @ 18,42 say 'FAKTURY  (T/N) ?³                     '
   @ 19,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
   @ 20,42 say space(38)
   @ 21,42 say space(38)
   @ 22,42 say space(38)
   set color to w+
   for x=1 to 10
       for y=1 TO 8
           xx=strtran(str(x,2),' ','0')
           yy=strtran(str(y,2),' ','0')
           @ 10+y,58+(x*2) say rspz_&xx&yy pict '!'
       next
   next
   set color to
   QQS=1
   do while QQS<>0
      set color to w+
      for x=1 to 10
          for y=1 TO 8
              xx=strtran(str(x,2),' ','0')
              yy=strtran(str(y,2),' ','0')
              @ 10+y,58+(x*2) say rspz_&xx&yy pict '!'
          next
      next
      set color to
      @ 9,60 prompt '1 '
      @ 9,62 prompt '2 '
      @ 9,64 prompt '3 '
      @ 9,66 prompt '4 '
      @ 9,68 prompt '5 '
      @ 9,70 prompt '6 '
      @ 9,72 prompt '7 '
      @ 9,74 prompt '8 '
      @ 9,76 prompt '9 '
      @ 9,78 prompt '10'
      menu to QQS
      if lastkey()=27
         QQS=0
         exit
      endif
      QQR=1
      @ 21,42 prompt padc('DRUKOWANIE REJESTRU wg PARAMETROW',38)
      @ 22,42 prompt padc('MODYFIKACJA PARAMETROW',38)
      menu to QQR
      if lastkey()=27
         QQR=0
         exit
      endif
      do case
      case QQR=1
           Q=strtran(str(QQS,2),' ','0')
           exit
      case QQR=2
           set curs on
           Q=strtran(str(QQS,2),' ','0')
           for y=1 TO 8
               yy=strtran(str(y,2),' ','0')
               @ 10+y,58+(QQS*2) get rspz_&Q&yy pict '!' valid rspz_&Q&yy$'TN'
           next
           read
           save to rejzsze all like rspz_*
           set curs off
      endcase
      @ 21,42 clear to 21,79
      @ 22,42 clear to 22,79
   enddo
   if QQS=0.or.QQR=0
      break
   endif
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   OPRE=''

*      k1=dos_p(upper(miesiac(val(miesiac))))
*      k2=param_rok

* wait miesiac
   sprawdzVAT(10,ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.01'))

   select 8
   do while.not.dostep('ROZR')
   enddo
   do setind with 'ROZR'

   select 7
   if ewid_rzi<>'**'
      DO WHILE.NOT.dostep('KAT_ZAK')
      ENDDO
      set inde to KAT_ZAK
      seek [+]+ident_fir+ewid_rzi
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
   if dostep('REJZ')
      do SETIND with 'REJZ'
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
         do case
         case ewid_rzk='N'
              if KOREKTA='N'.and.iif(ewid_rzi<>'**',symb_rej=ewid_rzi,.t.)
                 JEST=1
                 exit
              else
                 skip 1
              endif
         case ewid_rzk='T'
              if KOREKTA='T'.and.iif(ewid_rzi<>'**',symb_rej=ewid_rzi,.t.)
                 JEST=1
                 exit
              else
                 skip 1
              endif
         other
              if iif(ewid_rzi<>'**',symb_rej=ewid_rzi,.t.)
                 JEST=1
                 exit
              else
                 skip 1
              endif
         endcase
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
   liczba=0
   liczba_=liczba
          _lewa=1
          _prawa=130
       endif
       if _mon_drk=2.and.czesc=2
          seek [+]+ident_fir+miesiac
*          liczba=liczba_-1
   liczba=0
   liczba_=liczba
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
      store 0 to s0_8,s0_9,s0_10,s0_11,s0_12,s0_112,s0_122,s0_112a,s0_122a,s0_13,s0_14,s0_15,s0_16,s0_17,s1_9,s1_11,s1_112,s1_112a,s1_13,s1_14,s1_15,s2_9,s2_11,s2_112,s2_112a,s2_13,s2_14,s2_15
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dos_p(upper(miesiac(val(miesiac))))
      k2=param_rok
      _grupa1=int(strona/max(1,_druk_2-12))
      _grupa=.t.
      _numer=1
      KOLKS:={'10','11','12','13','16','  '}
      KOLWAR=''
      for y=1 TO 6
          yy=strtran(str(y,2),' ','0')
          if rspz_&Q&yy='T'
             KKK=KOLKS[y]
             KOLWAR=KOLWAR+'.or.KOLUMNA="'+KKK+'"'
          endif
      next
      if rspz_&Q.04='T'
         KOLWAR=KOLWAR+'.or.KOLUMNA="14"'
      endif
      KOLWAR=alltrim(substr(KOLWAR,5))
      if len(KOLWAR)=0
         KOLWAR='.t.'
      endif
      RACHKS:={'R','F'}
      RACHWAR=''
      for y=7 TO 8
          yy=strtran(str(y,2),' ','0')
          if rspz_&Q&yy='T'
             KKK=RACHKS[y-6]
             RACHWAR=RACHWAR+'.or.RACH="'+KKK+'"'
          endif
      next
      RACHWAR=alltrim(substr(RACHWAR,5))
      if len(RACHWAR)=0
         RACHWAR='.t.'
      endif
      zapzap=1
      zsumzap=0
      do while .not.&_koniec
         if ( &KOLWAR ) .and. ( &RACHWAR )
            k88=rejz->WARTZW+rejz->WART00+rejz->WART02+rejz->WART07+rejz->WART22+rejz->WART12+rejz->VAT02+rejz->VAT07+rejz->VAT22+rejz->VAT12
            wk88=abs(rejz->WARTZW)+abs(rejz->WART00)+abs(rejz->WART02)+abs(rejz->WART07)+abs(rejz->WART22)+abs(rejz->WART12)+abs(rejz->VAT02)+abs(rejz->VAT07)+abs(rejz->VAT22)+abs(rejz->VAT12)
            if (_grupa.or._grupa1#int(strona/max(1,_druk_2-12))) .and. wk88#0 .and. iif(ewid_rzk='N',rejz->KOREKTA='N',iif(ewid_rzk='T',rejz->KOREKTA='T',.t.)).and.iif(ewid_rzi<>'**',rejz->symb_rej=ewid_rzi,.t.).and.zapzap=1
               _grupa1=int(strona/max(1,_druk_2-12))
               _grupa=.t.
               *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
               k1=dos_p(upper(miesiac(val(miesiac))))
               k2=param_rok
               select firma
               ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
               select rejz
               k3=ks+space(100-len(ks))
               k4=int(strona/max(1,_druk_2-12))+1
               k5=k1
               k6=k2
               k7=ks+space(90-len(ks))
               k8=k4
               zapzap=0
               rz_kol=iif(ewid_rzs='B','BRUTTO','NETTO ')
mon_drk([     REJESTR ZAKUPU wg STAWEK za miesiac ]+k1+[.]+k2+[ (]+ewid_rzi+[ - ]+padr(opre,40)+[)                                       REJESTR ZAKUPU wg STAWEK za miesiac ]+k1+[.]+k2+[ (]+ewid_rzi+[ - ]+padr(opre,40)+[)])
mon_drk([     ]+k3+[               str. ]+str(k4,3)+[         ]+k7+[            str. ]+str(k8,3))
mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿ÚÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³    ³ DATA³   DATA   ³DO³KO³       ³                              ³     NUMER    ³                              ³RE³   OGOLNA   ³³    ³ZAKUPY wg stawki ]+str(vat_A,2)+[ lub ]+str(vat_A-1,2)+[%³ZAKUPY wg stawki ]+str(vat_B,2)+[ lub ]+str(vat_B-1,2)+[%³    ZAKUPY   ³   ZAKUPY   ³   ZAKUPY   ³]+;
         [   ZAKUPY Z ODLICZENIAMI   ³])
mon_drk([³    ³     ³          ³  ³LU³       ³                              ³              ³                              ³RE³            ³³    ³ZAKUPY wg stawki ]+str(vat_C,2)+[ lub ]+str(vat_C-2,2)+[%³ZAKUPY wg stawki ]+str(vat_D,2)+[%       ³             ³            ³            ³]+;
         [                           ³])
mon_drk([³L.p.³WPLY-³  WYSTA-  ³WO³MN³ NUMER ³       NAZWA DOSTAWCY         ³              ³             OPIS             ³JE³   WARTOSC  ³³L.p.ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ´   wg stawki ³  ZWOLNIONE ³BEZ ODLICZENÃ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
mon_drk([³    ³ WU  ³  WIENIA  ³D ³A ³ DOWODU³                              ³IDENTYFIKACYJ.³          ZDARZENIA           ³ST³   ]+rz_kol+[   ³³    ³wartosc NETTO³ wartosc VAT ³wartosc NETTO³ wartosc VAT ³     0 %     ³ OD PODATKU ³(NETTO+VAT) ³]+;
         [    NETTO    ³     VAT     ³])
mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
               *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            endif
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k2=strtran(dzien,' ','0')+'.'+strtran(miesiac,' ','0')
            k22=strtran(DZIENS,' ','0')+'.'+strtran(MCS,' ','0')+'.'+ROKS
            k23=iif(RACH='F','Fa','Ra')
            if KOLUMNA='  ' .or. KOLUMNA=' 0'
               K24='  '
            else
               k24=str(val(KOLUMNA),2)
            endif
            aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 7 )
            //k3=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2,7)+[ ],substr(numer,1,7))
            k3 := aNumerWiersze[ 1 ]
            k4=substr(nazwa,1,30)
            k5=substr(nr_ident,1,14)
            k6=tresc
            k66=symb_rej
            K9=wart22
            K10=vat22
            k112=wart02
            k122=vat02
            k112a=wart12
            k122a=vat12
            k11=wart07
            k12=vat07
            k13=wart00
            k14=wartzw
            k15=iif(RACH='R',WART22+WART12+WART07+WART02+WART00+WARTZW+VAT22+VAT12+VAT07+VAT02,iif(ZOM02='Z',WART02+VAT02,0)+iif(ZOM07='Z',WART07+VAT07,0)+iif(ZOM22='Z',WART22+VAT22,0)+iif(ZOM12='Z',WART12+VAT12,0)+iif(ZOM00='Z',WART00,0)+WARTZW)
            k16=iif(RACH='R',0,iif(ZOM02<>'Z',VAT02,0)+iif(ZOM07<>'Z',VAT07,0)+iif(ZOM22<>'Z',VAT22,0)+iif(ZOM12<>'Z',VAT12,0))
            k17=iif(RACH='R',0,iif(ZOM02<>'Z',WART02,0)+iif(ZOM07<>'Z',WART07,0)+iif(ZOM22<>'Z',WART22,0)+iif(ZOM12<>'Z',WART12,0)+iif(ZOM00<>'Z',WART00,0))
            zKOREKTA=KOREKTA
            zSYMB_REJ=SYMB_REJ
*            zzaplata=zaplata
            zkwota=kwota
            znumer=numer
            k88=rejz->WARTZW+rejz->WART00+rejz->WART02+rejz->WART07+rejz->WART22+rejz->WART12+rejz->VAT02+rejz->VAT07+rejz->VAT22+rejz->VAT12
            wk88=abs(rejz->WARTZW)+abs(rejz->WART00)+abs(rejz->WART02)+abs(rejz->WART07)+abs(rejz->WART22)+abs(rejz->WART12)+abs(rejz->VAT02)+abs(rejz->VAT07)+abs(rejz->VAT22)+abs(rejz->VAT12)
*            dozapl=iif(zzaplata#'1',k88-zkwota,0)
		
         FZ=0
         ZZ=0
         STATSLEDZ=ROZRZAPZ
		 if STATSLEDZ=='T'
            REKZAK=recno()
		    sele 8
            set orde to 2
            seek ident_fir+param_rok+'Z'+str(REKZAK,10)
            if found()
               kluczstat=ident_fir+NIP+WYR
               set orde to 1
			   seek kluczstat
               FZ=0
               ZZ=0
               do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                  do case
                  case RODZDOK='FZ'
                       FZ=FZ+(MNOZNIK*KWOTA)
                  case RODZDOK='ZZ'
                       ZZ=ZZ+(MNOZNIK*KWOTA)
                  endcase
                  skip
               enddo
		
		    endif
		 endif
		
         sele 1
            skip
            *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            if wk88#0 .and.zKOREKTA=iif(ewid_rzk='N','N',iif(ewid_rzk='T','T',zKOREKTA)).and.iif(ewid_rzi<>'**',zSYMB_REJ=ewid_rzi,.t.).and.(ewid_rzz$'NW'.or.(ewid_rzz='D'.and.(FZ+ZZ)<>0.0).or.(ewid_rzz='Z'.and.(FZ+ZZ)=0.0))
               strona=strona+1
               liczba=liczba+1
               k1=padc(str(liczba,4),4)
               k7=k1
               if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                  if ewid_rzs='B'
                     s0_8=s0_8+k88
                  else
                     s0_8=s0_8+k9+k11+k112+k112a+k13+k14
                  endif
                  s0_9=s0_9+k9
                  s0_10=s0_10+k10
                  s0_11=s0_11+k11
                  s0_12=s0_12+k12
                  s0_112=s0_112+k112
                  s0_122=s0_122+k122
                  s0_112a=s0_112a+k112a
                  s0_122a=s0_122a+k122a
                  s0_13=s0_13+k13
                  s0_14=s0_14+k14
                  s0_15=s0_15+k15
                  s0_16=s0_16+k16
                  s0_17=s0_17+k17
                  s1_9=s1_9+k9+k10
                  s1_11=s1_11+k11+k12
                  s1_112=s1_112+k112+k122
                  s1_112a=s1_112a+k112a+k122a
                  s1_13=s1_13+k13
                  s1_14=s1_14+k14
                  s1_15=s1_15+k15
                  s2_9=s2_9+k9
                  s2_11=s2_11+k11
                  s2_112=s2_112+k112
                  s2_112a=s2_112a+k112a
                  s2_13=s2_13+k13
                  s2_14=s2_14+k14
                  s2_15=s2_15+k15
               endif
               if wk88=0
                  k88=space(12)
               else
                  if ewid_rzs='B'
                     k88=str(k88,12,2)
                  else
                     k88=str(k9+k11+k112+k112a+k13+k14,12,2)
                  endif
               endif
               if k9=0
                  k9=space(13)
               else
                  k9=kwota(k9,13,2)
               endif
               if k10=0
                  k10=space(13)
               else
                  k10=kwota(k10,13,2)
               endif
               if k11=0
                  k11=space(13)
               else
                  k11=kwota(k11,13,2)
               endif
               if k12=0
                  k12=space(13)
               else
                  k12=kwota(k12,13,2)
               endif
               ART8=k112+k122+k112a+k122a
               if k112=0
                  k112=space(13)
               else
                  k112=kwota(k112,13,2)
               endif
               if k122=0
                  k122=space(13)
               else
                  k122=kwota(k122,13,2)
               endif
               if k112a=0
                  k112a=space(13)
               else
                  k112a=kwota(k112a,13,2)
               endif
               if k122a=0
                  k122a=space(13)
               else
                  k122a=kwota(k122a,13,2)
               endif
               if k13=0
                  k13=space(13)
               else
                  k13=kwota(k13,13,2)
               endif
               if k14=0
                  k14=space(12)
               else
                  k14=str(k14,12,2)
               endif
               if k15=0
                  k15=space(12)
               else
                  k15=str(k15,12,2)
               endif
               if k16=0
                  k16=space(13)
               else
                  k16=kwota(k16,13,2)
               endif
               if k17=0
                  k17=space(13)
               else
                  k17=kwota(k17,13,2)
               endif
               if ART8=0
                  mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k66+[ ]+k88+iif(zKOREKTA='T','k',[ ])+[ ]+k1+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+k13+[ ]+k14+[ ]+k15+[ ]+k17+[ ]+k16)
                  IF Len( aNumerWiersze ) > 1
                     FOR i := 2 TO Len( aNumerWiersze )
                        mon_drk( "                             " + aNumerWiersze[ i ] )
                     NEXT
                  ENDIF
                  if ewid_rzz='D'.or.ewid_rzz='W'
                     if STATSLEDZ=='T' .and. (FZ+ZZ)<>0.0
                        strona=strona+1
                        mon_drk(space(195)+[stan rozr.:]+str(FZ+ZZ,14,2))
                        zsumzap=zsumzap+(FZ+ZZ)
				     endif
                  endif
               else
                  mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k66+[ ]+k88+iif(zKOREKTA='T','k',[ ])+[ ]+k1+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+k13+[ ]+k14+[ ]+k15+[ ]+k17+[ ]+k16)
                  strona=strona+1
                  wiedru=space(135)+[ ]+k112+[ ]+k122+[ ]+k112a+[ ]+k122a
                  if ewid_rzz='D'.or.ewid_rzz='W'
                     if STATSLEDZ=='T' .and. (FZ+ZZ)<>0.0
                        mon_drk(wiedru+space(4)+[stan rozr.:]+str(FZ+ZZ,14,2))
                        zsumzap=zsumzap+(FZ+ZZ)
                     else
                        mon_drk(wiedru)
                     endif
                  else
                     mon_drk(wiedru)
                  endif
               endif
               zapzap=1
               *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               _numer=1
               do case
               case int(strona/max(1,_druk_2-12))#_grupa1
                    _numer=0
               endcase
               _grupa=.f.
            endif
            if _numer<1
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]+;
[ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
               *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([])
               mon_drk([                     Uzytkownik programu komputerowego])
               mon_drk([             ]+dos_c(code()))
               *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            endif
         else
            skip 1
         endif
      enddo
      IF _NUMER>=1
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]+;
[ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      ENDIF
mon_drk(space(111)+[RAZEM ]+str(s0_8,12,2)+[       ]+kwota(s0_9,13,2)+[ ]+kwota(s0_10,13,2)+[ ]+kwota(s0_11,13,2)+[ ]+kwota(s0_12,13,2)+[ ]+kwota(s0_13,13,2)+[ ]+str(s0_14,12,2)+[ ]+str(s0_15,12,2)+[ ]+kwota(s0_17,13,2)+[ ]+kwota(s0_16,13,2))
*mon_drk(space(136)+str(s0_112,13,2)+[ ]+kwota(s0_122,13,2)+str(s0_112a,13,2)+[ ]+kwota(s0_122a,13,2))
                  wiedru=space(135)+[ ]+str(s0_112,13,2)+[ ]+kwota(s0_122,13,2)+[ ]+str(s0_112a,13,2)+[ ]+kwota(s0_122a,13,2)
                  if ewid_rzz='D'.or.ewid_rzz='W'
                     mon_drk(wiedru)
                     mon_drk(space(len(wiedru))+space(4)+[stan rozr.:]+str(FZ+ZZ,14,2))
                  else
                     mon_drk(wiedru)
                  endif
procent1=(s1_9+s1_11+s1_112+s1_112a+s1_13+s1_14)/100
proc1=_round(s1_9/procent1,2)
proc2=_round(s1_11/procent1,2)
proc22=_round(s1_112/procent1,2)
proc22a=_round(s1_112a/procent1,2)
proc3=_round(s1_13/procent1,2)
proc4=_round(s1_14/procent1,2)
if PROC1+PROC2+PROC22+PROC22a+PROC3+PROC4<>100
   RESZTA=100-(PROC1+PROC2+PROC22+PROC22a+PROC3+PROC4)
   do case
   case PROC1<>0
        PROC1=PROC1+RESZTA
   case PROC2<>0
        PROC2=PROC2+RESZTA
   case PROC22<>0
        PROC22=PROC22+RESZTA
   case PROC22a<>0
        PROC22a=PROC22a+RESZTA
   case PROC3<>0
        PROC3=PROC3+RESZTA
   case PROC4<>0
        PROC4=PROC4+RESZTA
   endcase
endif
mon_drk(space(130)+[ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk(space(18)+padc([Uzytkownik programu komputerowego],50)+space(62)+ [³STRUKTURA brutto  ³ ]+str(vat_A,2)+[%  ]+kwota(PROC1,7,2)+[³]+str(vat_B,2)+[%   ]+kwota(PROC2,7,2)+[³]+str(vat_C,2)+[%   ]+kwota(PROC22,7,2)+[³ 0%   ]+kwota(PROC3,7,2)+[³ ZW   ]+str(PROC4,6,2)+[³]+str(vat_D,2)+[%   ]+str(PROC22a,6,2)+[³])
procent1=(s2_9+s2_11+s2_112+s2_112a+s2_13+s2_14)/100
proc1=_round(s2_9/procent1,2)
proc2=_round(s2_11/procent1,2)
proc22=_round(s2_112/procent1,2)
proc22a=_round(s2_112a/procent1,2)
proc3=_round(s2_13/procent1,2)
proc4=_round(s2_14/procent1,2)
if PROC1+PROC2+PROC22+PROC22a+PROC3+PROC4<>100
   RESZTA=100-(PROC1+PROC2+PROC22+PROC22a+PROC3+PROC4)
   do case
   case PROC1<>0
        PROC1=PROC1+RESZTA
   case PROC2<>0
        PROC2=PROC2+RESZTA
   case PROC22<>0
        PROC22=PROC22+RESZTA
   case PROC22a<>0
        PROC22a=PROC22a+RESZTA
   case PROC3<>0
        PROC3=PROC3+RESZTA
   case PROC4<>0
        PROC4=PROC4+RESZTA
   endcase
endif
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk(space(18)+padc(alltrim(code()),50)+space(62)+[³ ZAKUPOW  netto   ³ ]+str(vat_A,2)+[%  ]+kwota(PROC1,7,2)+[³]+str(vat_B,2)+[%   ]+kwota(PROC2,7,2)+[³]+str(vat_C,2)+[%   ]+kwota(PROC22,7,2)+[³]+kwota(PROC3,13,2)+[³]+str(PROC4,12,2)+[³]+str(PROC22a,12,2)+[³])
mon_drk(space(130)+[ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
*if ewid_rzz='D'.or.ewid_rzz='W'
*   mon_drk(space(195)+[do zaplaty ]+str(zsumzap,14,2))
*endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   next
   mon_drk([ş])
end
if _czy_close
   close_()
endif
