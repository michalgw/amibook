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

FUNCTION rejzst( ewid_rzs,ewid_rzk,ewid_rzi,ewid_rzz )

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
   _prawa=252
   _strona=.f.
   _czy_mon=.t.
   _czy_close=.t.
   *------------------------------
   _szerokosc=252
   _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   stronap=1
   stronak=99999
   JEST=0
   *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
   OPRE=''
   select 7
   if ewid_rzi<>'**'
      DO WHILE.NOT.dostep('KAT_ZAK')
      ENDDO
      SetInd( 'KAT_ZAK' )
      seek [+]+ident_fir+ewid_rzi
      if found()
         OPRE=alltrim(opis)
      endif
   else
      OPRE='WSZYSTKIE REJESTRY RAZEM'
   endif
   use
   select 3
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele 1
         break
      endif
   zstrusprob=strusprob
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
   //param_cal=10
*  if param_cal=10
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
*  else
*     S1=1
*     S2=1
*  endif
   mon_drk([ö]+procname())
   for czesc=iif(_mon_drk#2,1,S1) to iif(_mon_drk#2,1,S2)
       if _mon_drk=2.and.czesc=1
          liczba=0
          liczba_=liczba
          _lewa=1
*          if param_cal=10
             _prawa=130
*          else
*             _prawa=252
*          endif
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
          _prawa=252
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
      store 0 to s0_8,s0_9,s0_9D,s0_10,s0_11,s0_11D,s0_12,s0_13,s0_14,s0_15,s0_16,s0_17,s0_66,s0_99,s0_66v,s0_netto
      store 0 to s0_kpojazdy,s0_kodlistru
      store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
      store 0 to snormalnet,snormalvat,suenet,suevat,stowarnet,stowarvat,susluganet,suslugavat,swewdosnet,swewdosvat
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      k1=dos_p(upper(miesiac(val(miesiac))))
      k2=param_rok
      _grupa1=int(strona/max(1,_druk_2-11))
      _grupa=.t.
      _numer=1
      zapzap=1
      zsumzap=0
      do while .not.&_koniec
         store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
         K66=0
         K66v=0
         K9=0
         K9D=0
         K10=0
         k11=0
         k11D=0
         k12=0
         kodlistru=0
         k99=0
         knetto=0
         kpojazdy=iif(SP22='S'.and. WART22<>0.00 .and.pojazdy<>0.00,pojazdy,0)
         K88=0
         do case
         case RACH='R'
              K66=iif(SPZW='S',WARTZW,0)+iif(SP00='S',WART00,0)+iif(SP02='S',WART02,0)+iif(SP07='S',WART07,0)+iif(SP22='S',WART22,0)+iif(SP12='S',WART12,0)
              K66v=iif(SP02='S',VAT02,0)+iif(SP07='S',VAT07,0)+iif(SP22='S',VAT22,0)+iif(SP12='S',VAT12,0)
              K9=0
              K10=0
              k11=0
              k12=0
              kodlistru=0
              k99=0
              knetto=0
         case RACH='F'
              K66=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)
              K66v=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)
              K9=iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)
              K9D=iif(SP02='S'.and.ZOM02='O'.and.VAT02<>0,WART02,0)+iif(SP07='S' .and. ZOM07='O'.and.VAT07<>0,WART07,0)+iif(SP22='S' .and. ZOM22='O'.and.VAT22<>0,WART22,0)+iif(SP12='S'.and. ZOM12='O'.and.VAT12<>0,WART12,0)+;
                  iif(SP00='S' .and. ZOM00='O',WART00,0)
              K10=iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)
              k11=iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
              k11D=iif(SP02='S'.and.ZOM02='M'.and.VAT02<>0,WART02,0)+iif(SP07='S'.and.ZOM07='M'.and.VAT07<>0,WART07,0)+iif(SP22='S' .and. ZOM22='M'.and.VAT22<>0,WART22,0)+iif(SP12='S' .and. ZOM12='M'.and.VAT12<>0,WART12,0)+;
                   iif(SP00='S' .and. ZOM00='M',WART00,0)
              k12=iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)
              kodlistru=k12*(zstrusprob/100)
              if param_rok>='2009'
                 do case
                 case SEK_CV7=='WT'
                      kuenet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kuevat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 case SEK_CV7=='IT'
                      ktowarnet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      ktowarvat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 case SEK_CV7=='IU'
                      kusluganet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kuslugavat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 case SEK_CV7=='PN'
                      kwewdosnet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kwewdosvat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 endcase
              else
                 do case
                 case UE='T'.and.WEWDOS<>'T'
                      kuenet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kuevat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 case EXPORT='T'.and.UE<>'T'.and.USLUGAUE='T'.and.WEWDOS<>'T'
                      kusluganet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kuslugavat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 case EXPORT='T'.and.WEWDOS='T'
                      kwewdosnet=iif(SPZW='S',WARTZW,0)+iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S' .and. ZOM22='Z',WART22,0)+iif(SP12='S' .and. ZOM12='Z',WART12,0)+iif(SP00='S' .and. ZOM00='Z',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S' .and. ZOM07='O',WART07,0)+iif(SP22='S' .and. ZOM22='O',WART22,0)+iif(SP12='S' .and. ZOM12='O',WART12,0)+iif(SP00='S' .and. ZOM00='O',WART00,0)+;
                             iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S' .and. ZOM22='M',WART22,0)+iif(SP12='S' .and. ZOM12='M',WART12,0)+iif(SP00='S' .and. ZOM00='M',WART00,0)
                      kwewdosvat=iif(SP02='S'.and.ZOM02='Z',VAT02,0)+iif(SP07='S'.and.ZOM07='Z',VAT07,0)+iif(SP22='S' .and. ZOM22='Z',VAT22,0)+iif(SP12='S' .and. ZOM12='Z',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='O',VAT02,0)+iif(SP07='S'.and.ZOM07='O',VAT07,0)+iif(SP22='S' .and. ZOM22='O',VAT22,0)+iif(SP12='S' .and. ZOM12='O',VAT12,0)+;
                             iif(SP02='S'.and.ZOM02='M',VAT02,0)+iif(SP07='S'.and.ZOM07='M',VAT07,0)+iif(SP22='S' .and. ZOM22='M',VAT22,0)+iif(SP12='S' .and. ZOM12='M',VAT12,0)+paliwa+pojazdy
                 endcase
              endif
              k99=k66v+k10+k12+kpojazdy
              knetto=netto
         endcase

         k88=k66+k66v+k9+k10+k11+k12+kpojazdy
         if (_grupa.or._grupa1#int(strona/max(1,_druk_2-11))) .and. k88#0 .and. iif(ewid_rzk='N',rejz->KOREKTA='N',iif(ewid_rzk='T',rejz->KOREKTA='T',.t.)).and.iif(ewid_rzi<>'**',rejz->symb_rej=ewid_rzi,.t.).and.zapzap=1
            _grupa1=int(strona/max(1,_druk_2-11))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
            k1=dos_p(upper(miesiac(val(miesiac))))
            k2=param_rok
            select firma
            ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
            select rejz
            k3=ks+space(100-len(ks))
            k4=int(strona/max(1,_druk_2-11))+1
            k5=k1
            k6=k2
            k7=ks+space(100-len(ks))
            k8=k4
            zapzap=0
            rz_kol=iif(ewid_rzs='B','BRUTTO','NETTO ')
mon_drk([      REJESTR ZAKUPU - &__S.RODKI TRWA&__L.E (]+ewid_rzi+[ - ]+opre+[) za miesiac ]+k1+[.]+k2)
mon_drk([      ]+k3+[str.]+str(k4,3)+space(20)+k3+[str.]+str(k4,3))
if param_rok>='2009'
   mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³    ³     ³          ³ RO-³       ³                              ³                 ³Za³                                  ³Sek³SY³            ³              ZAKUPY TOWAR&__O.W I US&__L.UG ZALICZANYCH DO SRODK&__O.W TRWA&__L.YCH               ³           ³            ³])
   mon_drk([³    ³DZIE&__N.³   DATA   ³DZAJ³ NUMER ³                              ³      NUMER      ³ku³                                  ³cja³MB³   OG&__O.LNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ Ksiegowano³   OG&__O.LNA   ³])
   mon_drk([³L.p.³     ³          ³    ³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU           ³Dek³OL³   WARTO&__S.&__C.  ³Zaku.niepodl.odliczeni.³Zaku.opod.do sprz.opod.³Zakupy opodat.do sprzedazy mieszan.³     do    ³   WARTO&__S.&__C.  ³])
   mon_drk([³    ³WP&__L.Y-³  WYSTA-  ³DOWO³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                                  ³lar³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´   ksiegi  ³     VAT    ³])
   mon_drk([³    ³ WU  ³  WIENIA  ³ DU ³       ³                              ³                 ³UE³                                  ³VAT³J.³            ³warto&_s.&_c. NET³warto&_s.&_c. VAT³warto&_s.&_c. NET³warto&_s.&_c. VAT³warto&_s.&_c. NET³warto&_s.&_c. VAT³VAT odlicz.³           ³            ³])
   mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
else
   mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³    ³     ³          ³ RO-³       ³                              ³                 ³Za³                              ³Imp³Pod³SY³            ³              ZAKUPY TOWAR&__O.W I US&__L.UG ZALICZANYCH DO SRODK&__O.W TRWA&__L.YCH               ³INFO DODAT.³            ³])
   mon_drk([³    ³DZIE&__N.³   DATA   ³DZAJ³ NUMER ³                              ³      NUMER      ³ku³                              ³ort³atn³MB³   OG&__O.LNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´   OG&__O.LNA   ³])
   mon_drk([³L.p.³     ³          ³    ³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU       ³   ³Nab³OL³   WARTO&__S.&__C.  ³Zaku.niepodl.odliczeni.³Zaku.opod.do sprz.opod.³Zakupy opodat.do sprzedazy mieszan.³VAT zaplaco³   WARTO&__S.&__C.  ³])
   mon_drk([³    ³WP&__L.Y-³  WYSTA-  ³DOWO³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                              ³Usl³ywc³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´od pojazdow³     VAT    ³])
   mon_drk([³    ³ WU  ³  WIENIA  ³ DU ³       ³                              ³                 ³UE³                              ³ugi³a  ³J.³            ³warto&_s.&_c. NET³warto&_s.&_c. VAT³warto&_s.&_c. NET³warto&_s.&_c. VAT³warto&_s.&_c. NET³warto&_s.&_c. VAT³VAT odlicz.³nie odliczo³            ³])
   mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
endif
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         endif
*@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         k2=strtran(dzien,' ','0')+'.'+strtran(miesiac,' ','0')
         k22=strtran(DZIENS,' ','0')+'.'+strtran(MCS,' ','0')+'.'+ROKS
         k23=iif(RACH='F','Fakt','Rach')
         aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 7 )
         //k3=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2,7),substr(numer,1,7))
         k3 := aNumerWiersze[ 1 ]
         k4=SUBSTR(nazwa,1,30)
         k5=substr(nr_ident,1,17)
         kue=iif(UE='T','UE','  ')
         k6=tresc
         if param_rok>='2009'
            ksekcja=SEK_CV7
         else
            kuslugaue=iif(USLUGAUE='T','TAK','   ')
            kwewdos=iif(WEWDOS='T','TAK','   ')
         endif
         kk6=symb_rej
         zKOREKTA=KOREKTA
         zNUMER=NUMER
         zSYMB_REJ=SYMB_REJ
         zzaplata=zaplata
         zkwota=kwota
         skip
         dozapl=iif(zzaplata#'1',k88-zkwota,0)
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         if k88#0 .and.zKOREKTA=iif(ewid_rzk='N','N',iif(ewid_rzk='T','T',zKOREKTA)).and.iif(ewid_rzi<>'**',zSYMB_REJ=ewid_rzi,.t.).and.(ewid_rzz$'NW'.or.(ewid_rzz='D'.and.zzaplata$'23').or.(ewid_rzz='Z'.and.zzaplata='1'))
            strona=strona+1
            liczba=liczba+1
            k1=dos_c(str(liczba,4))
            k7=k1
            if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
               if ewid_rzs='B'
                  s0_8=s0_8+k88
               else
                  s0_8=s0_8+k9+k11+k66
               endif
               s0_9=s0_9+k9
               s0_9D=s0_9D+k9D
               s0_10=s0_10+k10
               s0_11=s0_11+k11
               s0_11D=s0_11D+k11D
               s0_12=s0_12+k12
               s0_kodlistru=s0_kodlistru+kodlistru
               s0_66=s0_66+k66
               s0_66v=s0_66v+k66v
               s0_99=s0_99+k99
               s0_netto=s0_netto+knetto
               s0_kpojazdy=s0_kpojazdy+kpojazdy
               suenet=suenet+kuenet
               stowarnet=stowarnet+ktowarnet
               susluganet=susluganet+kusluganet
               swewdosnet=swewdosnet+kwewdosnet
               suevat=suevat+kuevat
               stowarvat=stowarvat+ktowarvat
               suslugavat=suslugavat+kuslugavat
               swewdosvat=swewdosvat+kwewdosvat
            endif
            if k88=0
               k88=space(12)
            else
               if ewid_rzs='B'
                  k88=str(k88,12,2)
               else
                  k88=str(k9+k11+k66,12,2)
               endif
            endif
            if k9=0
               k9=space(11)
            else
               k9=str(k9,11,2)
            endif
            if k10=0
               k10=space(11)
            else
               k10=str(k10,11,2)
            endif
            if k11=0
               k11=space(11)
            else
               k11=str(k11,11,2)
            endif
            if k12=0
               k12=space(11)
            else
               k12=str(k12,11,2)
            endif
            if kodlistru=0
               kodlistru=space(11)
            else
               kodlistru=str(kodlistru,11,2)
            endif
            if k66=0
               k66=space(11)
            else
               k66=str(k66,11,2)
            endif
            if k66v=0
               k66v=space(11)
            else
               k66v=str(k66v,11,2)
            endif
            if k99=0
               k99=space(12)
            else
               k99=str(k99,12,2)
            endif
            if knetto=0
               knetto=space(11)
            else
               knetto=str(knetto,11,2)
            endif
            if kpojazdy=0
               kpojazdy=space(11)
            else
               kpojazdy=str(kpojazdy,11,2)
            endif
            if param_rok>='2009'
               mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+[   ]+[ ]+ksekcja+[  ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+k66+[ ]+k66v+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+kodlistru+[ ]+knetto+[ ]+k99)
               IF Len( aNumerWiersze ) > 1
                  FOR i := 2 TO Len( aNumerWiersze )
                     mon_drk( "                            " + aNumerWiersze[ i ] )
                  NEXT
               ENDIF
            else
               mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+kuslugaue+[ ]+kwewdos+[ ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+k66+[ ]+k66v+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+kodlistru+[ ]+kpojazdy+[ ]+k99)
            endif
            zapzap=1
            if ewid_rzz='D' .or. ewid_rzz='W'
               if zzaplata<>'1'
                  strona=strona+1
                  mon_drk(space(130)+[do zaplaty ]+str(dozapl,12,2))
                  zsumzap=zsumzap+dozapl
               endif
            endif
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer=1
            do case
            case int(strona/max(1,_druk_2-11))#_grupa1
                 _numer=0
            endcase
            _grupa=.f.
         endif
         if _numer<1
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
            mon_drk([                     U&_z.ytkownik programu komputerowego])
            mon_drk([             ]+dos_c(code()))
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            _numer=1
         endif
      enddo
      IF _NUMER>=1
         mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      ENDIF
      if param_rok>='2009'
         mon_drk(space(124)+[RAZEM  ]+str(s0_8,11,2)+[ ]+str(s0_66,11,2)+[ ]+str(s0_66v,11,2)+[ ]+str(s0_9,11,2)+[ ]+str(s0_10,11,2)+[ ]+str(s0_11,11,2)+[ ]+str(s0_12,11,2)+[ ]+str(s0_kodlistru,11,2)+[ ]+str(s0_netto,11,2)+[ ]+str(s0_99,12,2))
      else
         mon_drk(space(124)+[RAZEM  ]+str(s0_8,11,2)+[ ]+str(s0_66,11,2)+[ ]+str(s0_66v,11,2)+[ ]+str(s0_9,11,2)+[ ]+str(s0_10,11,2)+[ ]+str(s0_11,11,2)+[ ]+str(s0_12,11,2)+[ ]+str(s0_kodlistru,11,2)+[ ]+str(s0_kpojazdy,11,2)+[ ]+str(s0_99,12,2))
      endif
      mon_drk(space(124)+[       ]+[            Z zakupow do sprzedazy mieszanej wyliczono   Opodatkowane  ]+[ ]+str(s0_kodlistru,11,2)+[ (]+str(zstrusprob,3)+[%)])
      mon_drk(space(124)+[       ]+[                        wg struktury sprzedazy za ]+str(val(param_rok)-1,4)+[:  Zwolnione     ]+[ ]+str(s0_12-s0_kodlistru,11,2)+[ (]+str(100-zstrusprob,3)+[%)])
      mon_drk(space(124)+[       ]+[W ZAKUPACH WYKAZANO:               ])
      mon_drk(space(125)+[       ]+[           ]+[ ]+[   NETTO   ]+[ ]+[    VAT    ]              +[ ]+[           ]+[ ]+[           ]+[ ]+[SUMA nabyci]+[a]+[ srod.trwal.])
      mon_drk(space(125)+[       ]+[WNT (UE)   ]+[ ]+str(suenet,11,2)+[ ]+str(suevat,11,2)        +[ ]+[           ]+[ ]+[           ]+[ ]+[    (do dek]+[l]+[aracji)     ])
      if param_rok>='2009'
         mon_drk(space(125)+[       ]+[Import tow.]+[ ]+str(stowarnet,11,2)+[ ]+str(stowarvat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+[   NETTO   ]+[ ]+[     VAT    ])
         mon_drk(space(125)+[       ]+[Import usl.]+[ ]+str(susluganet,11,2)+[ ]+str(suslugavat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+str(s0_9D+s0_11D,11,2)+[ ]+str(s0_10+s0_kodlistru,11,2))
         mon_drk(space(125)+[       ]+[Podat.naby.]+[ ]+str(swewdosnet,11,2)+[ ]+str(swewdosvat,11,2))
      else
         mon_drk(space(125)+[       ]+[Import usl.]+[ ]+str(susluganet,11,2)+[ ]+str(suslugavat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+[   NETTO   ]+[ ]+[     VAT    ])
         mon_drk(space(125)+[       ]+[Podat.naby.]+[ ]+str(swewdosnet,11,2)+[ ]+str(swewdosvat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+str(s0_9D+s0_11D,11,2)+[ ]+str(s0_10+s0_kodlistru,11,2))
      endif
      if ewid_rzz='D' .or. ewid_rzz='W'
         mon_drk(space(130)+[do zaplaty ]+str(zsumzap,12,2))
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([                     U&_z.ytkownik programu komputerowego])
      mon_drk([             ]+dos_c(code()))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   next
   mon_drk([þ])
end
if _czy_close
   close_()
endif
