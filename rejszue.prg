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

FUNCTION rejszue( ewid_rzs, ewid_rzk, ewid_rzi )

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
      _prawa=259
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      *------------------------------
      _szerokosc=259
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      JEST=0
      if file('rejszuep.mem')
         restore from rejszuep additive
      else
         if .not.file([rejszuep.mem])
            for x=1 to 10
                for y=1 TO 8
                    xx=strtran(str(x,2),' ','0')
                    yy=strtran(str(y,2),' ','0')
                    rspz_&xx&yy='T'
                next
            next
            save to rejszuep all like rspz_*
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
      @ 13,42 say '12-Wynagr.w got.³                     '
      @ 14,42 say '13-Pozostale wyd³                     '
      @ 15,42 say '16-Koszty badaw.³                     '
      @ 16,42 say '   NIEKSIEGOWANE³                     '
      @ 17,42 say 'RACHUNKI (T/N) ?³                     '
      @ 18,42 say 'FAKTURY  (T/N) ?³                     '
      @ 19,42 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
      @ 20,42 say space(38)
      @ 21,42 say space(38)
      @ 22,42 say space(38)
//      @ 22,42 say space(38)
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
              QQSS=strtran(str(QQS,2),' ','0')
              exit
         case QQR=2
              set curs on
              QQSS=strtran(str(QQS,2),' ','0')
              for y=1 TO 8
                  yy=strtran(str(y,2),' ','0')
                  @ 10+y,58+(QQS*2) get rspz_&QQSS&yy pict '!' valid rspz_&QQSS&yy$'TN'
              next
              read
              save to rejszuep all like rspz_*
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
      select 3
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele 1
         break
      endif
*      zstrusprob=strusprob
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
             _prawa=259
             _wiersz=_druk_2
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
                do czekaj
                //set device to print
             endif
         endif
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         store 0 to s0_8,s0_13,s0_14,s0_15,s0_16,s0_17
         store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
         store 0 to snormalnet,snormalvat,suenet,suevat,stowarnet,stowarvat,susluganet,suslugavat,swewdosnet,swewdosvat,sumvat
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         k1=dos_p(upper(miesiac(val(miesiac))))
         k2=param_rok
         _grupa1=int(strona/max(1,_druk_2-8))
         _grupa=.t.
         _numer=1
         KOLKS:={'10','11','12','13','16','  '}
         KOLWAR=''
         for y=1 TO 6
             yy=strtran(str(y,2),' ','0')
             if rspz_&QQSS&yy='T'
                KKK=KOLKS[y]
                KOLWAR=KOLWAR+'.or.KOLUMNA="'+KKK+'"'
             endif
         next
         KOLWAR=substr(KOLWAR,5)
         if len(KOLWAR)=0
            KOLWAR='.t.'
         endif
*         wait kolwar
         RACHKS:={'R','F'}
         RACHWAR=''
         for y=7 TO 8
             yy=strtran(str(y,2),' ','0')
             if rspz_&QQSS&yy='T'
                KKK=RACHKS[y-6]
                RACHWAR=RACHWAR+'.or.RACH="'+KKK+'"'
             endif
         next
         RACHWAR=substr(RACHWAR,5)
         if len(RACHWAR)=0
            RACHWAR='.t.'
         endif
*         wait rachwar
         zapzap=1
         zsumzap=0
         do while .not.&_koniec
            store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
            if ( &KOLWAR ) .and. ( &RACHWAR )
               if param_rok>='2009'
                  do case
                  case SEK_CV7=='WT'
                       kuenet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kuevat=VAT02+VAT07+VAT22+VAT12
                  case SEK_CV7=='IT'
                       ktowarnet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       ktowarvat=VAT02+VAT07+VAT22+VAT12
                  case SEK_CV7=='IU'
                       kusluganet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kuslugavat=VAT02+VAT07+VAT22+VAT12
                  case SEK_CV7=='PN'.OR.SEK_CV7=='PU'
                       kwewdosnet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kwewdosvat=VAT02+VAT07+VAT22+VAT12
                  endcase
               else
                  do case
                  case UE='T'.and.WEWDOS<>'T'
                       kuenet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kuevat=VAT02+VAT07+VAT22+VAT12
                  case EXPORT='T'.and.UE<>'T'.and.USLUGAUE='T'.and.WEWDOS<>'T'
                       kusluganet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kuslugavat=VAT02+VAT07+VAT22+VAT12
                  case EXPORT='T'.and.WEWDOS='T'
                       kwewdosnet=WARTZW+WART02+WART07+WART22+WART12+WART00
                       kwewdosvat=VAT02+VAT07+VAT22+VAT12
                  endcase
               endif
               k88=kuenet+kuevat+ktowarnet+ktowarvat+kusluganet+kuslugavat+kwewdosnet+kwewdosvat
               wk88=abs(kuenet)+abs(kuevat)+abs(ktowarnet)+abs(ktowarvat)+abs(kusluganet)+abs(kuslugavat)+abs(kwewdosnet)+abs(kwewdosvat)
               if (_grupa.or._grupa1#int(strona/max(1,_druk_2-8))).and.wk88#0.and.iif(ewid_rzk='N',rejz->KOREKTA='N',iif(ewid_rzk='T',rejz->KOREKTA='T',.t.)).and.iif(ewid_rzi<>'**',rejz->symb_rej=ewid_rzi,.t.).and.zapzap=1
                  _grupa1=int(strona/max(1,_druk_2-8))
                  _grupa=.t.
                  *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
                  k1=dos_p(upper(miesiac(val(miesiac))))
                  k2=param_rok
                  select firma
                  ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
                  select rejz
                  k3=ks+space(110-len(ks))
                  k4=int(strona/max(1,_druk_2-8))+1
                  k5=k1
                  k6=k2
                  k7=ks+space(90-len(ks))
                  k8=k4
                  zapzap=0
                  rz_kol=iif(ewid_rzs='B','BRUTTO','NETTO ')
mon_drk([      REJESTR SPRZEDAZY - NABYCIA UE,itp  (]+ewid_rzi+[ - ]+opre+[) za miesiac ]+k1+[.]+k2)
*if param_cal=10
   mon_drk([      ]+k3+[str. ]+str(k4,3)+space(98)+[str. ]+str(k4,3))
*else
*   mon_drk([      ]+k3+space(88)+[str. ]+str(k4,3))
*endif
if param_rok>='2009'
mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³    ³     ³          ³Ro³Ko³       ³                              ³                 ³Za³                                      ³SY³            ³                            NABYCIA UE,itp                                                     ³     ³            ³])
mon_drk([³    ³DZIEN³   DATA   ³dz³lu³ NUMER ³                              ³      NUMER      ³ku³                                      ³MB³   OGOLNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ Czy ³            ³])
mon_drk([³L.p.³     ³          ³aj³mn³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU               ³OL³   WARTOSC  ³Wewnatrzwspl.nab.towar.³     Import towarow    ³     Import uslug      ³  Podatnikiem nabywca  ³korek³   WARTOSC  ³])
mon_drk([³    ³WPLY-³  WYSTA-  ³Do³a ³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                                      ³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´ ta  ³     VAT    ³])
mon_drk([³    ³ WU  ³  WIENIA  ³ku³Ks³       ³                              ³                 ³UE³                                      ³J.³            ³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³  ?  ³            ³])
mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
else
mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
mon_drk([³    ³     ³          ³Ro³Ko³       ³                              ³                 ³Za³                              ³Imp³Pod³SY³            ³                            NABYCIA UE,itp                             ³           ³            ³])
mon_drk([³    ³DZIEN³   DATA   ³dz³lu³ NUMER ³                              ³      NUMER      ³ku³                              ³ort³atn³MB³   OGOLNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´    Czy    ³            ³])
mon_drk([³L.p.³     ³          ³aj³mn³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU       ³   ³Nab³OL³   WARTOSC  ³Wewnatrzwspl.nab.towar.³     Import uslug      ³  Podatnikiem nabywca  ³  korekta  ³   WARTOSC  ³])
mon_drk([³    ³WPLY-³  WYSTA-  ³Do³a ³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                              ³Usl³ywc³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´ TAK/NIE ? ³     VAT    ³])
mon_drk([³    ³ WU  ³  WIENIA  ³ku³Ks³       ³                              ³                 ³UE³                              ³ugi³a  ³J.³            ³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³           ³            ³])
mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
endif
*                 *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               endif
               *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
               k2=strtran(dzien,' ','0')+'.'+strtran(miesiac,' ','0')
               k22=strtran(DZIENS,' ','0')+'.'+strtran(MCS,' ','0')+'.'+ROKS
               k23=iif(RACH='F','Fa','Ra')
               if KOLUMNA='  ' .or. KOLUMNA=' 0'
                  K24='  '
               else
                  k24=padc(str(val(KOLUMNA),2),2)
               endif
               aNumerWiersze := PodzielNaWiersze( AllTrim( iif( Left( numer, 1 ) == Chr( 1 ) .OR. Left( numer, 1 ) == Chr( 254 ), SubStr( numer, 2 ), numer ) ), 7 )
               //k3=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2,7),substr(numer,1,7))
               k3 := aNumerWiersze[ 1 ]
               k4=SUBSTR(nazwa,1,30)
               k5=substr(nr_ident,1,17)
               kue=iif(UE='T','UE','  ')
               k6=tresc
               if param_rok>='2009'
                  ktowarue=iif(SEK_CV7=='IT','IT ','   ')
                  kuslugaue=iif(SEK_CV7=='IU','IU ','   ')
                  kwewdos=iif(SEK_CV7=='PN'.or.SEK_CV7=='PU','PN ','   ')
               else
                  kuslugaue=iif(USLUGAUE='T','TAK','   ')
                  kwewdos=iif(WEWDOS='T','TAK','   ')
               endif
               kk6=symb_rej
               zKOREKTA=KOREKTA
               zNUMER=NUMER
               zSYMB_REJ=SYMB_REJ
               skip
               *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               if wk88#0.and.zKOREKTA=iif(ewid_rzk='N','N',iif(ewid_rzk='T','T',zKOREKTA)).and.iif(ewid_rzi<>'**',zSYMB_REJ=ewid_rzi,.t.)
                  strona=strona+1
                  liczba=liczba+1
                  k1=dos_c(str(liczba,4))
                  k7=k1
                  kvat=k88-(kuenet+ktowarnet+kusluganet+kwewdosnet)
                  if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                     if ewid_rzs='B'
                        s0_8=s0_8+k88
                     else
                        s0_8=s0_8+kuenet+ktowarnet+kusluganet+kwewdosnet
                     endif
                     suenet=suenet+kuenet
                     stowarnet=stowarnet+ktowarnet
                     susluganet=susluganet+kusluganet
                     swewdosnet=swewdosnet+kwewdosnet
                     suevat=suevat+kuevat
                     stowarvat=stowarvat+ktowarvat
                     suslugavat=suslugavat+kuslugavat
                     swewdosvat=swewdosvat+kwewdosvat
                     sumvat=sumvat+kvat
                  endif
                  if wk88=0
                     k88=space(12)
                  else
                     if ewid_rzs='B'
                        k88=str(k88,12,2)
                     else
                        k88=str(kuenet+ktowarnet+kusluganet+kwewdosnet,12,2)
                     endif
                  endif
                  if kuenet=0
                     kkuenet=space(11)
                  else
                     kkuenet=str(kuenet,11,2)
                  endif
                  if kuevat=0
                     kkuevat=space(11)
                  else
                     kkuevat=str(kuevat,11,2)
                  endif
                  if ktowarnet=0
                     kktowarnet=space(11)
                  else
                     kktowarnet=str(ktowarnet,11,2)
                  endif
                  if ktowarvat=0
                     kktowarvat=space(11)
                  else
                     kktowarvat=str(ktowarvat,11,2)
                  endif
                  if kusluganet=0
                     kkusluganet=space(11)
                  else
                     kkusluganet=str(kusluganet,11,2)
                  endif
                  if kuslugavat=0
                     kkuslugavat=space(11)
                  else
                     kkuslugavat=str(kuslugavat,11,2)
                  endif
                  if kwewdosnet=0
                     kkwewdosnet=space(11)
                  else
                     kkwewdosnet=str(kwewdosnet,11,2)
                  endif
                  if kwewdosvat=0
                     kkwewdosvat=space(11)
                  else
                     kkwewdosvat=str(kwewdosvat,11,2)
                  endif
                  if kvat=0
                     kkvat=space(12)
                  else
                     kkvat=str(kvat,12,2)
                  endif
                  if param_rok>='2009'
                     mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+'   '+[ ]+'   '+[ ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+kkuenet+[ ]+kkuevat+[ ]+kktowarnet+[ ]+kktowarvat+[ ]+kkusluganet+[ ]+kkuslugavat+[ ]+kkwewdosnet+[ ]+kkwewdosvat+[ ]+iif(zKOREKTA='T',' TAK ',' NIE ')+[ ]+kkvat)
                     IF Len( aNumerWiersze ) > 1
                        FOR i := 2 TO Len( aNumerWiersze )
                           mon_drk( "                             " + aNumerWiersze[ i ] )
                        NEXT
                     ENDIF
                  else
                     mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+kuslugaue+[ ]+kwewdos+[ ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+kkuenet+[ ]+kkuevat+[ ]+kkusluganet+[ ]+kkuslugavat+[ ]+kkwewdosnet+[ ]+kkwewdosvat+[ ]+iif(zKOREKTA='T','    TAK    ','    NIE    ')+[ ]+kkvat)
                  endif
                  zapzap=1
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  _numer=1
                  do case
                  case int(strona/max(1,_druk_2-8))#_grupa1
                       _numer=0
                  endcase
                  _grupa=.f.
               endif
               if _numer<1
                  if param_rok>='2009'
                  mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
                  else
                  mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
                  endif
                  mon_drk([])
                  *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
                  mon_drk([                     Uzytkownik programu komputerowego])
                  mon_drk([             ]+dos_c(code()))
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  _numer=1
               endif
            else
               skip 1
            endif
         enddo
         IF _NUMER>=1
            if param_rok>='2009'
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            else
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            endif
         ENDIF
         if suenet=0
            ssuenet=space(11)
         else
            ssuenet=str(suenet,11,2)
         endif
         if suevat=0
            ssuevat=space(11)
         else
            ssuevat=str(suevat,11,2)
         endif
         if stowarnet=0
            sstowarnet=space(11)
         else
            sstowarnet=str(stowarnet,11,2)
         endif
         if stowarvat=0
            sstowarvat=space(11)
         else
            sstowarvat=str(stowarvat,11,2)
         endif
         if susluganet=0
            ssusluganet=space(11)
         else
            ssusluganet=str(susluganet,11,2)
         endif
         if suslugavat=0
            ssuslugavat=space(11)
         else
            ssuslugavat=str(suslugavat,11,2)
         endif
         if swewdosnet=0
            sswewdosnet=space(11)
         else
            sswewdosnet=str(swewdosnet,11,2)
         endif
         if swewdosvat=0
            sswewdosvat=space(11)
         else
            sswewdosvat=str(swewdosvat,11,2)
         endif
         if sumvat=0
            ssumvat=space(12)
         else
            ssumvat=str(sumvat,12,2)
         endif
         if param_rok>='2009'
            mon_drk(space(125)+[RAZEM  ]+str(s0_8,11,2)+[ ]+ssuenet+[ ]+ssuevat+[ ]+sstowarnet+[ ]+sstowarvat+[ ]+ssusluganet+[ ]+ssuslugavat+[ ]+sswewdosnet+[ ]+sswewdosvat+[ ]+space(5)+[ ]+ssumvat)
         else
            mon_drk(space(125)+[RAZEM  ]+str(s0_8,11,2)+[ ]+ssuenet+[ ]+ssuevat+[ ]+ssusluganet+[ ]+ssuslugavat+[ ]+sswewdosnet+[ ]+sswewdosvat+[ ]+space(11)+[ ]+ssumvat)
         endif
         *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
         mon_drk([                     Uzytkownik programu komputerowego])
         mon_drk([             ]+dos_c(code()))
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      next
      mon_drk([þ])
end
if _czy_close
   close_()
endif
