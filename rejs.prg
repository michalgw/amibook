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

FUNCTION rejs( ewid_rss, ewid_rsk, ewid_rsi, ewid_rzz, aFiltr )

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
   JEST=0
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@

   sprawdzVAT(10,ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.01'))

   OPRE=''
   select 8
   do while.not.dostep('ROZR')
   enddo
   do setind with 'ROZR'

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
*!!!
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
         if iif(ewid_rsk<>'R',rejs->korekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',rejs->SYMB_REJ=ewid_rsi,.t.)
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
   liczba=0
   liczba_=liczba
          _lewa=1
          _prawa=130
       endif
       if _mon_drk=2.and.czesc=2
          seek [+]+ident_fir+miesiac
*!!!
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
          endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_8,s0_9,s0_10,s0_891,s0_8101,s0_200,s0_201,s0_11,s0_12,s0_13,s0_14,s0_14a,s0_15,s0_15a,s0_16,s1_9,s1_891,s1_200,s1_11,s1_13,s1_14,s1_14a,s1_15,s1_15a,s2_9,s2_891,s2_200,s2_11,s2_13,s2_14,s2_14a,s2_15,s2_15a
      store 0 to s0_8PN,s0_9PN,s0_10PN,s0_891PN,s0_8101PN,s0_200PN,s0_201PN,s0_11PN,s0_12PN,s0_13PN,s0_14PN,s0_14aPN,s0_15PN,s0_15aPN,s0_16PN,s1_9PN,s1_891PN,s1_200PN,s1_11PN,s1_13PN,s1_14PN,s1_14aPN,s1_15PN,s1_15aPN,s2_9PN,;
                 s2_891PN,s2_200PN,s2_11PN,s2_13PN,s2_14PN,s2_14aPN,s2_15PN,s2_15aPN
      store 0 to K9PN,K10PN,k891PN,k8101PN,k11PN,k12PN,K200PN,K201PN,k13PN,k14PN,k14aPN,k15PN,k15aPN
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dos_p(upper(miesiac(val(miesiac))))
      k2=param_rok
      _grupa1=int(strona/max(1,_druk_2-11))
      _grupa=.t.
      _numer=1
      zapzap=1
      zsumzap=0
      do while .not.&_koniec
         if (_grupa.or._grupa1#int(strona/max(1,_druk_2-11))).and.iif(ewid_rsk<>'R',rejs->korekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',rejs->SYMB_REJ=ewid_rsi,.t.).and.zapzap=1 ;
            .AND. ( aFiltr[ 'rodzaj' ] == "*"  .OR. aFiltr[ 'rodzaj' ] == AllTrim( rejs->rodzdow ) ) ;
            .AND. ( Len( aFiltr[ 'opcje' ] ) == 0 .OR. ( AllTrim( rejs->opcje ) <> "" .AND. Len( AMerge( aFiltr[ 'opcje' ], hb_ATokens( AllTrim( rejs->opcje ), ',' ) ) ) > 0 ) ) ;
            .AND. ( aFiltr[ 'procedura' ] == "" .OR. aFiltr[ 'procedura' ] == "MPP" .OR. ( AllTrim( rejs->procedur ) == aFiltr[ 'procedura' ] ) ) ;
            .AND. ( aFiltr[ 'procedura' ] <> "MPP" .OR. rejs->sek_cv7 == "SP" )

            _grupa1=int(strona/max(1,_druk_2-11))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(upper(miesiac(val(miesiac))))
            k2=param_rok
            select firma
            ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
            select rejs
            k3=ks+space(100-len(ks))
            k4=int(strona/max(1,_druk_2-11))+1
            k5=k1
            k6=k2
            k7=ks+space(90-len(ks))
            k8=k4
            zapzap=0
            rs_kol=iif(ewid_rss='B','BRUTTO','NETTO ')
mon_drk([     REJESTR SPRZEDAZY (ewidencja sprzedazy dla KPIR) za miesiac ]+k1+[.]+k2+[ (]+ewid_rsi+[ - ]+padr(opre,40)+[)         REJESTR SPRZEDAZY (ewidencja sprzedazy dla KPIR) za miesiac ]+k1+[.]+k2+[ (]+ewid_rsi+[ - ]+padr(opre,40)+[)])
mon_drk([     ]+k3+[         str. ]+str(k4,3)+[          ]+k7+[          str. ]+str(k8,3))
mon_drk([ÚÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ¿ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³     ³     ³   DATA   ³       ³KOL³          ³                              ³      NUMER      ³                              ³SY³³     ³   OGOLNA    ³SPRZEDAZ wg stawki ]+str(vat_A,2)+[lub]+str(vat_A-1,2)+[%³SPRZEDAZ wg stawki ]+str(vat_B,2)+[lub]+str(vat_B-1,2)+[%³  SPRZEDAZ wg 0% kraj/WDT  ³]+;
         [   SPRZEDAZ ³   RAZEM   ³])
mon_drk([³     ³     ³          ³       ³MNA³          ³                              ³                 ³                              ³M.³³     ³             ³SPRZEDAZ wg stawki ]+str(vat_D,2)+[%     ³SPRZEDAZ wg stawki ]+str(vat_C,2)+[lub]+str(vat_C-2,2)+[%³  SPRZEDAZ wg 0% eksport   ³]+;
         [  ZWOLNIONA ³           ³])
mon_drk([³ L.p.³ DATA³  SPRZE-  ³ RODZAJ³KSI³  NUMER   ³       NAZWA ODBIORCY         ³                 ³                OPIS          ³RE³³ L.p.³   WARTOSC   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÅ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄ´  WARTOSC  ³])
mon_drk([³     ³WYST.³   DAZY   ³ DOWODU³EGI³  DOWODU  ³                              ³ IDENTYFIKACYJNY ³             ZDARZENIA        ³J.³³     ³   ]+rs_kol+[    ³wartosc NETTO³ wartosc VAT ³wartosc NETTO³ wartosc VAT ³0%kraj       ³0% WDT/0%Expo³]+;
         [NIE PODL.VAT³  PODATKU  ³])
mon_drk([ÀÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÙÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁ]+;
         [ÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ])
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
*@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k2=strtran(dzien,' ','0')+'.'+strtran(miesiac,' ','0')
         k22=strtran(DZIENS,' ','0')+'.'+strtran(MCS,' ','0')+'.'+ROKS
         k23=iif(RACH='F','Faktura','Rachun.')
         if KOLUMNA=' 0'
            K24='   '
         else
            k24=padc(str(val(KOLUMNA),1),3)
         endif
         aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 10 )
         //k3=SubStr( iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer), 1, 10 )
         k3 := aNumerWiersze[ 1 ]
         k4=substr(nazwa,1,30)
         k5=substr(nr_ident,1,17)
         k6=tresc
         k66=symb_rej
         K9=wart22
         K10=vat22
*         k891=0
*         k8101=0
         k891=wart12
         k8101=vat12
         k11=wart07
         k12=vat07
         K200=wart02
         K201=vat02
         if WART00<>0.00
            if UE='T'
               k13=0
               k14=0
               k14a=rejs->wart00
            endif
            if UE<>'T'.and.EXPORT='T'
               k13=0
               k14=rejs->wart00
               k14a=0
            endif
            if UE<>'T'.and.EXPORT<>'T'
               k13=rejs->wart00
               k14=0
               k14a=0
            endif
         else
            k13=0
            k14=0
            k14a=0
         endif
         k15=wartzw
         k15a=wart08
         if SEK_CV7=='PN'.OR.SEK_CV7=='PU'
            K9PN=wart22
            K10PN=vat22
            k891PN=wart12
            k8101PN=vat12
            k11PN=wart07
            k12PN=vat07
            K200PN=wart02
            K201PN=vat02
            if WART00<>0.00
               if UE='T'
                  k13PN=0
                  k14PN=0
                  k14aPN=rejs->wart00
               endif
               if UE<>'T'.and.EXPORT='T'
                  k13PN=0
                  k14PN=rejs->wart00
                  k14aPN=0
               endif
               if UE<>'T'.and.EXPORT<>'T'
                  k13PN=rejs->wart00
                  k14PN=0
                  k14aPN=0
               endif
            else
               k13PN=0
               k14PN=0
               k14aPN=0
            endif
            k15PN=wartzw
            k15aPN=wart08
         else
            K9PN=0
            K10PN=0
            k891PN=0
            k8101PN=0
            k11PN=0
            k12PN=0
            K200PN=0
            K201PN=0
            k13PN=0
            k14PN=0
            k14aPN=0
            k15PN=0
            k15aPN=0
         endif
         k16=k10+k8101+k201+k12
         k16PN=k10PN+k8101PN+k201PN+k12PN
         zKOREKTA=KOREKTA
         zSYMB_REJ=SYMB_REJ
*         zzaplata=zaplata
         zkwota=kwota
         znumer=numer
         zrach=rach
         k88=rejs->WARTZW+rejs->WART08+rejs->WART00+rejs->WART02+rejs->WART07+rejs->WART22+rejs->WART12+rejs->VAT02+rejs->VAT07+rejs->VAT22+rejs->VAT12
*         dozapl=iif(zzaplata#'1',k88-zkwota,0)
		
         FS=0
         ZS=0
         STATSLEDZ=ROZRZAPS
		 if STATSLEDZ=='T'
            REKZAK=recno()
		    sele 8
            set orde to 2
            seek ident_fir+param_rok+'S'+str(REKZAK,10)
            if found()
               kluczstat=ident_fir+NIP+WYR
               set orde to 1
			   seek kluczstat
               FS=0
               ZS=0
               do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                  do case
                  case RODZDOK='FS'
                       FS=FS+(MNOZNIK*KWOTA)
                  case RODZDOK='ZS'
                       ZS=ZS+(MNOZNIK*KWOTA)
                  endcase
                  skip
               enddo
		
		    endif
		 endif
		
		 sele 1
         skip
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         if iif(ewid_rsk<>'R',zkorekta=ewid_rsk,.t.).and.iif(ewid_rsi<>'**',zSYMB_REJ=ewid_rsi,.t.).and.(ewid_rzz$'NW'.or.(ewid_rzz='D'.and.(FS+ZS)<>0.0).or.(ewid_rzz='Z'.and.(FS+ZS)=0.0)) ;
            .AND. ( aFiltr[ 'rodzaj' ] == "*"  .OR. aFiltr[ 'rodzaj' ] == AllTrim( rejs->rodzdow ) ) ;
            .AND. ( Len( aFiltr[ 'opcje' ] ) == 0 .OR. ( AllTrim( rejs->opcje ) <> "" .AND. Len( AMerge( aFiltr[ 'opcje' ], hb_ATokens( AllTrim( rejs->opcje ), ',' ) ) ) > 0 ) ) ;
            .AND. ( aFiltr[ 'procedura' ] == "" .OR. aFiltr[ 'procedura' ] == "MPP" .OR. ( AllTrim( rejs->procedur ) == aFiltr[ 'procedura' ] ) ) ;
            .AND. ( aFiltr[ 'procedura' ] <> "MPP" .OR. rejs->sek_cv7 == "SP" )

            strona=strona+1
            liczba=liczba+1
            k1l=dos_c(str(liczba,5))
            k1p=k1l
            if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254) .AND. ( AllTrim( rejs->rodzdow ) <> "FP" .OR. aFiltr[ 'sumujFP' ] )
               if ewid_rss='B'
                  s0_8=s0_8+k88
               else
                  s0_8=s0_8+k9+k891+k11+k200+k13+k14+k14a+k15+k15a
               endif
               s0_9=s0_9+k9
               s0_10=s0_10+k10
               s0_891=s0_891+k891
               s0_8101=s0_8101+k8101
               s0_11=s0_11+k11
               s0_12=s0_12+k12
               s0_200=s0_200+k200
               s0_201=s0_201+k201
               s0_13=s0_13+k13
               s0_14=s0_14+k14
               s0_14a=s0_14a+k14a
               s0_15=s0_15+k15
               s0_15a=s0_15a+k15a
               s0_16=s0_16+k16

               s1_9=s1_9+k9+k10
               s1_891=s1_891+k891+k8101
               s1_11=s1_11+k11+k12
               s1_200=s1_200+k200+k201
               s1_13=s1_13+k13
               s1_14=s1_14+k14
               s1_14a=s1_14a+k14a
               s1_15=s1_15+k15
               s1_15a=s1_15a+k15a
               s2_9=s2_9+k9
               s2_11=s2_11+k11
               s2_891=s2_891+k891
               s2_200=s2_200+k200
               s2_13=s2_13+k13
               s2_14=s2_14+k14
               s2_14a=s2_14a+k14a
               s2_15=s2_15+k15
               s2_15a=s2_15a+k15a

               s0_8PN=s0_8PN+k9PN+k891PN+k11PN+k200PN+k13PN+k14PN+k14aPN+k15PN+k15aPN
               s0_9PN=s0_9PN+k9PN
               s0_10PN=s0_10PN+k10PN
               s0_891PN=s0_891PN+k891PN
               s0_8101PN=s0_8101PN+k8101PN
               s0_11PN=s0_11PN+k11PN
               s0_12PN=s0_12PN+k12PN
               s0_200PN=s0_200PN+k200PN
               s0_201PN=s0_201PN+k201PN
               s0_13PN=s0_13PN+k13PN
               s0_14PN=s0_14PN+k14PN
               s0_14aPN=s0_14aPN+k14aPN
               s0_15PN=s0_15PN+k15PN
               s0_15aPN=s0_15aPN+k15aPN
               s0_16PN=s0_16PN+k16PN

               s1_9PN=s1_9PN+k9PN+k10PN
               s1_891PN=s1_891PN+k891PN+k8101PN
               s1_11PN=s1_11PN+k11PN+k12PN
               s1_200PN=s1_200PN+k200PN+k201PN
               s1_13PN=s1_13PN+k13PN
               s1_14PN=s1_14PN+k14PN
               s1_14aPN=s1_14aPN+k14aPN
               s1_15PN=s1_15PN+k15PN
               s1_15aPN=s1_15aPN+k15aPN

               s2_9PN=s2_9PN+k9PN
               s2_11PN=s2_11PN+k11PN
               s2_891PN=s2_891PN+k891PN
               s2_200PN=s2_200PN+k200PN
               s2_13PN=s2_13PN+k13PN
               s2_14PN=s2_14PN+k14PN
               s2_14aPN=s2_14aPN+k14aPN
               s2_15PN=s2_15PN+k15PN
               s2_15aPN=s2_15aPN+k15aPN

            endif
            if k88=0
               k88=space(13)
            else
               if ewid_rss='B'
                  k88=kwota(k88,13,2)
               else
                  k88=kwota(k9+k891+k11+k200+k13+k14+k14a+k15+k15a,13,2)
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
            ART8=k891+k8101
            if k891=0
               k891=space(13)
            else
               k891=kwota(k891,13,2)
            endif
            if k8101=0
               k8101=space(13)
            else
               k8101=kwota(k8101,13,2)
            endif
            ART2=k200+k201
            if k200=0
               k200=space(13)
            else
               k200=kwota(k200,13,2)
            endif
            if k201=0
               k201=space(13)
            else
               k201=kwota(k201,13,2)
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
            if k13=0
               k13=space(13)
            else
               k13=kwota(k13,13,2)
            endif
            ART81=k14+k15a
            if k14=0
               k14=space(13)
            else
               k14=kwota(k14,13,2)
            endif
            if k14a=0
               k14a=space(13)
            else
               k14a=kwota(k14a,13,2)
            endif
            if k15=0
               k15=space(12)
            else
               k15=str(k15,12,2)
            endif
            if k15a=0
               k15a=space(12)
            else
               k15a=str(k15a,12,2)
            endif
            if k16=0
               k16=space(11)
            else
               k16=str(k16,11,2)
            endif
            if ART81=0.and.ART2=0.and.ART8=0
               mon_drk([ ]+k1l+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k66+[  ]+k1p+[ ]+k88+iif(zKOREKTA='T','k',[ ])+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+k13+[ ]+k14a+[ ]+k15+[ ]+k16)
               IF Len( aNumerWiersze ) > 1
                  FOR i := 2 TO Len( aNumerWiersze )
                     mon_drk( "                                    " + aNumerWiersze[ i ] )
                  NEXT
               ENDIF
               if ewid_rzz='D'.or.ewid_rzz='W'
                  if STATSLEDZ=='T' .and. (FS+ZS)<>0.0
                     strona=strona+1
                     mon_drk(space(235)+[stan rozr.:]+str(FS+ZS,13,2))
                     zsumzap=zsumzap+(FS+ZS)
*				  else
*                     strona=strona+1
*                     mon_drk(space(235)+[brak kontroli rozr.])
				  endif
               endif
            else
               mon_drk([ ]+k1l+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k66+[  ]+k1p+[ ]+space(14)+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+k13+[ ]+k14a+[ ]+k15)
               strona=strona+1
               wiedru=space(130)+[       ]+k88+iif(zKOREKTA='T','k',[ ])+k891+[ ]+k8101+[ ]+k200+[ ]+k201+[ ]+space(13)+[ ]+k14+[ ]+k15a+[ ]+k16
               if ewid_rzz='D'.or.ewid_rzz='W'
                  if STATSLEDZ=='T' .and. (FS+ZS)<>0.0
                     mon_drk(wiedru+space(44)+[stan rozr.:]+str(FS+ZS,13,2))
                     zsumzap=zsumzap+(FS+ZS)
				  else
                     mon_drk(wiedru)
				  endif
               else
                  mon_drk(wiedru)
               endif
*               mon_drk(space(130)+[       ]+k88+iif(zKOREKTA='T','k',[ ])+[                            ]+k200+[ ]+k201+[ ]+k891+[ ]+k8101+space(14)+k16)
            endif
            zapzap=1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer=1
            do case
            case int(strona/max(1,_druk_2-11))#_grupa1
                 _numer=0
            endcase
            _grupa=.f.
         endif
         if _numer<1
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]+;
[ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
            mon_drk([                     Uzytkownik programu komputerowego])
            mon_drk([             ]+dos_c(code()))
            if _mon_drk=2 .or. _mon_drk=3
*              ejec
            endif
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
      enddo
      IF _NUMER>=1
mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]+;
[ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      ENDIF
mon_drk(space(124)+[RAZEM        ]+kwota(s0_8,13,2)+[ ]+kwota(s0_9,13,2)+[ ]+kwota(s0_10,13,2)+[ ]+kwota(s0_11,13,2)+[ ]+kwota(s0_12,13,2)+[ ]+kwota(s0_13,13,2)+[ ]+kwota(s0_14a,13,2)+[ ]+str(s0_15,12,2)+[ ]+str(s0_16,11,2))
                  wiedru=space(151)+kwota(s0_891,13,2)+[ ]+kwota(s0_8101,13,2)+[ ]+kwota(s0_200,13,2)+[ ]+kwota(s0_201,13,2)+[ ]+space(13)+[ ]+kwota(s0_14,13,2)+[ ]+str(s0_15a,12,2)
                  if ewid_rzz='D'.or.ewid_rzz='W'
                     mon_drk(wiedru)
                     mon_drk(space(235)+[stan rozr.:]+str(zsumzap,13,2))
                  else
                     mon_drk(wiedru)
                  endif
mon_drk(space(102)+[W TYM:"PODATNIKIEM NABYWCA"        ]+kwota(s0_8PN,13,2)+[ ]+kwota(s0_9PN,13,2)+[ ]+kwota(s0_10PN,13,2)+[ ]+kwota(s0_11PN,13,2)+[ ]+kwota(s0_12PN,13,2)+[ ]+kwota(s0_13PN,13,2)+[ ]+kwota(s0_14aPN,13,2)+[ ]+str(s0_15PN,12,2)+[ ]+str(s0_16PN,11,2))
                  wiedru=space(151)+kwota(s0_891PN,13,2)+[ ]+kwota(s0_8101PN,13,2)+[ ]+kwota(s0_200PN,13,2)+[ ]+kwota(s0_201PN,13,2)+[ ]+space(13)+[ ]+kwota(s0_14PN,13,2)+[ ]+str(s0_15aPN,12,2)
                  mon_drk(wiedru)
procent1=(s1_9+s1_891+s1_200+s1_11+s1_13+s1_14+s1_14a+s1_15)/100
proc1=_round(s1_9/procent1,2)
proc200=_round(s1_200/procent1,2)
proc2=_round(s1_11/procent1,2)
proc3=_round(s1_13/procent1,2)
proc4=_round(s1_14/procent1,2)
proc4a=_round(s1_14a/procent1,2)
proc5=_round(s1_15/procent1,2)
proc6=_round(s1_891/procent1,2)
if PROC1+PROC200+PROC2+PROC3+PROC4+PROC4a+PROC5+PROC6<>100
   RESZTA=100-(PROC1+PROC200+PROC2+PROC3+PROC4+PROC4a+PROC5+PROC6)
   do case
   case PROC1<>0
        PROC1=PROC1+RESZTA
   case PROC2<>0
        PROC2=PROC2+RESZTA
   case PROC200<>0
        PROC200=PROC200+RESZTA
   case PROC3<>0
        PROC3=PROC3+RESZTA
   case PROC4a<>0
        PROC4a=PROC4a+RESZTA
   case PROC4<>0
        PROC4=PROC4+RESZTA
   case PROC5<>0
        PROC5=PROC5+RESZTA
   case PROC6<>0
        PROC6=PROC6+RESZTA
   endcase
endif
mon_drk(space(130)+[ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk(space(20)+padc([Uzytkownik programu komputerowego],50)+space(60)+[³STRUKTURA brutto   ³ ]+str(vat_A,2)+[%  ]+kwota(PROC1,7,2)+[³ ]+str(vat_D,2)+[%  ]+kwota(PROC6,7,2)+[³]+str(vat_B,2)+[% ]+;
        kwota(PROC2,9,2)+[³]+str(vat_C,2)+[% ]+kwota(PROC200,9,2)+[³ 0%kraj]+kwota(PROC3,6,2)+[³ 0% WDT]+kwota(PROC4a,6,2)+[³ ZW   ]+str(PROC5,6,2)+[³0%exp]+str(PROC4,6,2)+[³])
procent1=(s2_9+s2_891+s2_200+s2_11+s2_13+s2_14+s2_14a+s2_15)/100
proc1=_round(s2_9/procent1,2)
proc200=_round(s2_200/procent1,2)
proc2=_round(s2_11/procent1,2)
proc3=_round(s2_13/procent1,2)
proc4=_round(s2_14/procent1,2)
proc4a=_round(s2_14a/procent1,2)
proc5=_round(s2_15/procent1,2)
proc6=_round(s2_891/procent1,2)
if PROC1+PROC200+PROC2+PROC3+PROC4+PROC4a+PROC5+PROC6<>100
   RESZTA=100-(PROC1+PROC200+PROC2+PROC3+PROC4+PROC4a+PROC5+PROC6)
   do case
   case PROC1<>0
        PROC1=PROC1+RESZTA
   case PROC2<>0
        PROC2=PROC2+RESZTA
   case PROC200<>0
        PROC200=PROC200+RESZTA
   case PROC3<>0
        PROC3=PROC3+RESZTA
   case PROC4<>0
        PROC4=PROC4+RESZTA
   case PROC4a<>0
        PROC4a=PROC4a+RESZTA
   case PROC5<>0
        PROC5=PROC5+RESZTA
   case PROC6<>0
        PROC6=PROC6+RESZTA
   endcase
endif
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk(space(20)+padc(alltrim(code()),50)+space(60)+[³STRUKTURA netto    ³      ]+kwota(PROC1,7,2)+[³      ]+kwota(PROC6,7,2)+[³    ]+;
        kwota(PROC2,9,2)+[³    ]+kwota(PROC200,9,2)+[³       ]+kwota(PROC3,6,2)+[³       ]+kwota(PROC4a,6,2)+[³      ]+str(PROC5,6,2)+[³     ]+str(PROC4,6,2)+[³])
mon_drk(space(130)+[ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ])
   if _mon_drk=2 .or. _mon_drk=3
*     ejec
   endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   next
   mon_drk([ş])
end
if _czy_close
   close_()
endif
