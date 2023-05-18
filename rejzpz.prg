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

FUNCTION rejzpz( ewid_rzs,ewid_rzk,ewid_rzi,ewid_rzz )

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
      _prawa=253
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      *------------------------------
      _szerokosc=253
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
      JEST=0
      if file('rejzpzze.mem')
         restore from rejzpzze additive
      else
         if .not.file([rejzpzze.mem])
            for x=1 to 10
                for y=1 TO 8
                    xx=strtran(str(x,2),' ','0')
                    yy=strtran(str(y,2),' ','0')
                    rspz_&xx&yy='T'
                next
            next
            save to rejzpzze all like rspz_*
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
              save to rejzpzze all like rspz_*
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
*     if param_cal=10
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
*     else
*        S1=1
*        S2=1
*     endif
      mon_drk([ö]+procname())
      for czesc=iif(_mon_drk#2,1,S1) to iif(_mon_drk#2,1,S2)
          if _mon_drk=2.and.czesc=1
             liczba=0
             liczba_=liczba
             _lewa=1
*             if param_cal=10
                _prawa=130
*             else
*                _prawa=253
*             endif
          endif
          if _mon_drk=2.and.czesc=2
             seek [+]+ident_fir+miesiac
*             liczba=liczba_-1
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
             _prawa=253
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
*  *            @ 0,_druk_4 say chr(15)+chr(27)+chr(51)+iif(_druk_3=1,chr(23),chr(34))
             endif
         endif
         *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
         store 0 to s0_8,s0_9,s0_9D,s0_10,s0_11,s0_11D,s0_12,s0_13,s0_14,s0_15,s0_16,s0_17,s0_66n,s0_66v,s0_99,s0_netto
         store 0 to s0_kpojazdy,s0_kpaliwa
         store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
         store 0 to snormalnet,snormalvat,suenet,suevat,stowarnet,stowarvat,susluganet,suslugavat,swewdosnet,swewdosvat
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         k1=dos_p(upper(miesiac(val(miesiac))))
         k2=param_rok
         _grupa1=int(strona/max(1,_druk_2-13))
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
         if rspz_&QQSS.04='T'
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
             if rspz_&QQSS&yy='T'
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
            store 0 to knormalnet,knormalvat,kuenet,kuevat,ktowarnet,ktowarvat,kusluganet,kuslugavat,kwewdosnet,kwewdosvat
            K66n=0
            K66v=0
            K9=0
            K9D=0
            K10=0
            k11=0
            K11D=0
            k12=0
            k99=0
            knetto=0
            kpojazdy=iif(SP22='P'.and. WART22<>0.00 .and.pojazdy<>0.00,pojazdy,0)
            kpaliwa=iif(SP22='P'.and. WART22<>0.00 .and.paliwa<>0.00,paliwa,0)
            if ( &KOLWAR ) .and. ( &RACHWAR )
               do case
               case RACH='R'
                    K66N=iif(SPZW='P',WARTZW,0)+iif(SP00='P',WART00,0)+iif(SP02='P',WART02,0)+iif(SP07='P',WART07,0)+iif(SP22='P',WART22,0)+iif(SP12='P',WART12,0)
                    K66V=iif(SP02='P',VAT02,0)+iif(SP07='P',VAT07,0)+iif(SP22='P',VAT22,0)+iif(SP12='P',VAT12,0)
                    K9=0
                    K10=0
                    k11=0
                    k12=0
                    k99=0
                    knetto=0
               case RACH='F'
                    K66N=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)
                    K66V=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)
                    K9=iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)
                    K9D=iif(SP02='P'.and.ZOM02='O'.and.VAT02<>0,WART02,0)+iif(SP07='P'.and.ZOM07='O'.and.VAT07<>0,WART07,0)+iif(SP22='P'.and.ZOM22='O'.and.VAT22<>0,WART22,0)+iif(SP12='P'.and.ZOM12='O'.and.VAT12<>0,WART12,0)+;
                        iif(SP00='P'.and.ZOM00='O',WART00,0)
                    K10=iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)
                    k11=iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                    k11D=iif(SP02='P'.and.ZOM02='M'.and.VAT02<>0,WART02,0)+iif(SP07='P'.and.ZOM07='M'.and.VAT07<>0,WART07,0)+iif(SP22='P'.and.ZOM22='M'.and.VAT22<>0,WART22,0)+iif(SP12='P'.and.ZOM12='M'.and.VAT12<>0,WART12,0)+;
                         iif(SP00='P'.and.ZOM00='M',WART00,0)
                    k12=iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)
                    if param_rok>='2009'
                       do case
                       case SEK_CV7=='WT'
                            kuenet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kuevat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       case SEK_CV7=='IT'
                            ktowarnet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            ktowarvat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       case SEK_CV7=='IU'
                            kusluganet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kuslugavat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       case SEK_CV7=='PN'
                            kwewdosnet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kwewdosvat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       endcase
                    else
                       do case
                       case UE='T'.and.WEWDOS<>'T'
                            kuenet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kuevat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       case EXPORT='T'.and.UE<>'T'.and.USLUGAUE='T'.and.WEWDOS<>'T'
                            kusluganet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kuslugavat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       case EXPORT='T'.and.WEWDOS='T'
                            kwewdosnet=iif(SPZW='P',WARTZW,0)+iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and.ZOM22='Z',WART22,0)+iif(SP12='P'.and.ZOM12='Z',WART12,0)+iif(SP00='P'.and.ZOM00='Z',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and.ZOM22='O',WART22,0)+iif(SP12='P'.and.ZOM12='O',WART12,0)+iif(SP00='P'.and.ZOM00='O',WART00,0)+;
                                   iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and.ZOM22='M',WART22,0)+iif(SP12='P'.and.ZOM12='M',WART12,0)+iif(SP00='P'.and.ZOM00='M',WART00,0)
                            kwewdosvat=iif(SP02='P'.and.ZOM02='Z',VAT02,0)+iif(SP07='P'.and.ZOM07='Z',VAT07,0)+iif(SP22='P'.and.ZOM22='Z',VAT22,0)+iif(SP12='P'.and.ZOM12='Z',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='O',VAT02,0)+iif(SP07='P'.and.ZOM07='O',VAT07,0)+iif(SP22='P'.and.ZOM22='O',VAT22,0)+iif(SP12='P'.and.ZOM12='O',VAT12,0)+;
                                   iif(SP02='P'.and.ZOM02='M',VAT02,0)+iif(SP07='P'.and.ZOM07='M',VAT07,0)+iif(SP22='P'.and.ZOM22='M',VAT22,0)+iif(SP12='P'.and.ZOM12='M',VAT12,0)+paliwa+pojazdy
                       endcase
                    endif
                    k99=k66v+k10+k12+kpojazdy+kpaliwa
                    knetto=netto
*                   k99=k10+k12+kpojazdy+kpaliwa
               endcase
               k88=k66n+k66v+k9+k10+k11+k12+kpojazdy+kpaliwa
*               k88=k66n+k66v+k9+k10+k11+k12
               wk88=abs(k66n)+abs(k66v)+abs(k9)+abs(k10)+abs(k11)+abs(k12)+abs(kpojazdy)+abs(kpaliwa)
               if (_grupa.or._grupa1#int(strona/max(1,_druk_2-13))).and.wk88#0.and.iif(ewid_rzk='N',rejz->KOREKTA='N',iif(ewid_rzk='T',rejz->KOREKTA='T',.t.)).and.iif(ewid_rzi<>'**',rejz->symb_rej=ewid_rzi,.t.).and.zapzap=1
                  _grupa1=int(strona/max(1,_druk_2-13))
                  _grupa=.t.
                  *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
                  k1=dos_p(upper(miesiac(val(miesiac))))
                  k2=param_rok
                  select firma
                  ks=scal(alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk)
                  select rejz
                  k3=ks+space(110-len(ks))
                  k4=int(strona/max(1,_druk_2-13))+1
                  k5=k1
                  k6=k2
                  k7=ks+space(90-len(ks))
                  k8=k4
                  zapzap=0
                  rz_kol=iif(ewid_rzs='B','BRUTTO','NETTO ')
mon_drk([      REJESTR ZAKUPU - POZOSTALE ZAKUPY (]+ewid_rzi+[ - ]+opre+[) za miesiac ]+k1+[.]+k2)
*if param_cal=10
   mon_drk([      ]+k3+[str. ]+str(k4,3)+space(110)+[str. ]+str(k4,3))
*else
*   mon_drk([      ]+k3+space(100)+[str. ]+str(k4,3))
*endif
if param_rok>='2009'
   mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³    ³     ³          ³Ro³Ko³       ³                              ³                 ³Za³                                  ³Sek³SY³            ³                       POZOSTALE ZAKUPY                                ³           ³            ³])
   mon_drk([³    ³DZIEN³   DATA   ³dz³lu³ NUMER ³                              ³      NUMER      ³ku³                                  ³cja³MB³   OGOLNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ Ksiegowano³   OGOLNA   ³])
   mon_drk([³L.p.³     ³          ³aj³mn³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU           ³Dek³OL³   WARTOSC  ³Zaku.niepodl.odliczeni.³Zak.opod.do sprzed.opod³Zak.opod.do sprzed.mies³     do    ³   WARTOSC  ³])
   mon_drk([³    ³WPLY-³  WYSTA-  ³Do³a ³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                                  ³lar³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´   ksiegi  ³     VAT    ³])
   mon_drk([³    ³ WU  ³  WIENIA  ³ku³Ks³       ³                              ³                 ³UE³                                  ³VAT³J.³            ³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³           ³            ³])
   mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
else
   mon_drk([ÚÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³    ³     ³          ³Ro³Ko³       ³                              ³                 ³Za³                              ³Imp³Pod³SY³            ³                       POZOSTALE ZAKUPY                                ³  INFORMACJE DODATKOWE ³            ³])
   mon_drk([³    ³DZIEN³   DATA   ³dz³lu³ NUMER ³                              ³      NUMER      ³ku³                              ³ort³atn³MB³   OGOLNA   ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´   OGOLNA   ³])
   mon_drk([³L.p.³     ³          ³aj³mn³       ³         NAZWA DOSTAWCY       ³                 ³p ³       PRZEDMIOT ZAKUPU       ³   ³Nab³OL³   WARTOSC  ³Zaku.niepodl.odliczeni.³Zak.opod.do sprzed.opod³Zak.opod.do sprzed.mies³VAT naliczo³VAT zaplaco³   WARTOSC  ³])
   mon_drk([³    ³WPLY-³  WYSTA-  ³Do³a ³ DOWODU³                              ³ IDENTYFIKACYJNY ³  ³                              ³Usl³ywc³RE³   ]+rz_kol+[   ÃÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ³od paliw kt³od pojazdow³     VAT    ³])
   mon_drk([³    ³ WU  ³  WIENIA  ³ku³Ks³       ³                              ³                 ³UE³                              ³ugi³a  ³J.³            ³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³wartosc NET³wartosc VAT³niepodl.odl³nieodliczon³            ³])
   mon_drk([ÀÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])
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
               dozapl=iif(zzaplata#'1',k88-zkwota,0)
               skip
               *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               if wk88#0.and.zKOREKTA=iif(ewid_rzk='N','N',iif(ewid_rzk='T','T',zKOREKTA)).and.iif(ewid_rzi<>'**',zSYMB_REJ=ewid_rzi,.t.).and.(ewid_rzz$'NW'.or.(ewid_rzz='D'.and.zzaplata$'23').or.(ewid_rzz='Z'.and.zzaplata='1'))
                  strona=strona+1
                  liczba=liczba+1
                  k1=dos_c(str(liczba,4))
                  k7=k1
                  if left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                     if ewid_rzs='B'
                        s0_8=s0_8+k88
                     else
                        s0_8=s0_8+k9+k11+k66n
*                        s0_8=s0_8+k9+k11+k66n
                     endif
                     s0_9=s0_9+k9
                     s0_9D=s0_9D+k9D
                     s0_10=s0_10+k10
                     s0_11=s0_11+k11
                     s0_11D=s0_11D+k11D
                     s0_12=s0_12+k12
                     s0_66n=s0_66n+k66n
                     s0_66v=s0_66v+k66v
                     s0_99=s0_99+k99
                     s0_netto=s0_netto+knetto
                     s0_kpojazdy=s0_kpojazdy+kpojazdy
                     s0_kpaliwa=s0_kpaliwa+kpaliwa
                     suenet=suenet+kuenet
                     stowarnet=stowarnet+ktowarnet
                     susluganet=susluganet+kusluganet
                     swewdosnet=swewdosnet+kwewdosnet
                     suevat=suevat+kuevat
                     stowarvat=stowarvat+ktowarvat
                     suslugavat=suslugavat+kuslugavat
                     swewdosvat=swewdosvat+kwewdosvat
                  endif
                  if wk88=0
                     k88=space(12)
                  else
                     if ewid_rzs='B'
                        k88=str(k88,12,2)
                     else
                        k88=str(k9+k11+k66n,12,2)
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
                  if k66n=0
                     k66n=space(11)
                  else
                     k66n=str(k66n,11,2)
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
                  if kpaliwa=0
                     kpaliwa=space(11)
                  else
                     kpaliwa=str(kpaliwa,11,2)
                  endif
                  if param_rok>='2009'
                     mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+[   ]+[ ]+ksekcja+[  ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+k66n+[ ]+k66v+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+knetto+[ ]+k99)
                     IF Len( aNumerWiersze ) > 1
                        FOR i := 2 TO Len( aNumerWiersze )
                           mon_drk( "                             " + aNumerWiersze[ i ] )
                        NEXT
                     ENDIF
                  else
                     mon_drk([ ]+k1+[ ]+k2+[ ]+k22+[ ]+k23+[ ]+k24+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+kue+[ ]+k6+[ ]+kuslugaue+[ ]+kwewdos+[ ]+kk6+[ ]+k88+iif(zKOREKTA='T','k',[ ])+k66n+[ ]+k66v+[ ]+k9+[ ]+k10+[ ]+k11+[ ]+k12+[ ]+kpaliwa+[ ]+kpojazdy+[ ]+k99)
                  endif
                  zapzap=1
                  if ewid_rzz='D'.or.ewid_rzz='W'
                     if zzaplata<>'1'
                        strona=strona+1
                        mon_drk(space(131)+[do zaplaty ]+str(dozapl,14,2))
                        zsumzap=zsumzap+dozapl
                     endif
                  endif
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  _numer=1
                  do case
                  case int(strona/max(1,_druk_2-13))#_grupa1
                       _numer=0
                  endcase
                  _grupa=.f.
               endif
               if _numer<1
                  if param_rok>='2009'
                     mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
                  else
                     mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
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
               mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            else
               mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            endif
         ENDIF
         if param_rok>='2009'
            mon_drk(space(125)+[RAZEM  ]+str(s0_8,11,2)+[ ]+str(s0_66n,11,2)+[ ]+str(s0_66v,11,2)+[ ]+str(s0_9,11,2)+[ ]+str(s0_10,11,2)+[ ]+str(s0_11,11,2)+[ ]+str(s0_12,11,2)+[ ]+str(s0_netto,11,2)+[ ]+str(s0_99,12,2))
         else
            mon_drk(space(125)+[RAZEM  ]+str(s0_8,11,2)+[ ]+str(s0_66n,11,2)+[ ]+str(s0_66v,11,2)+[ ]+str(s0_9,11,2)+[ ]+str(s0_10,11,2)+[ ]+str(s0_11,11,2)+[ ]+str(s0_12,11,2)+[ ]+str(s0_kpaliwa,11,2)+[ ]+str(s0_kpojazdy,11,2)+[ ]+str(s0_99,12,2))
         endif
         mon_drk(space(125)+[       ]+[            Z zakupow do sprzedazy mieszanej wyliczono   Opodatkowane  ]+[ ]+str(s0_12*(zstrusprob/100),11,2)+[ (]+str(zstrusprob,3)+[%)])
         mon_drk(space(125)+[       ]+[                        wg struktury sprzedazy za ]+str(val(param_rok)-1,4)+[:  Zwolnione     ]+[ ]+str(s0_12*((100-zstrusprob)/100),11,2)+[ (]+str(100-zstrusprob,3)+[%)])
         mon_drk(space(125)+[       ]+[W ZAKUPACH WYKAZANO:               ])
         mon_drk(space(125)+[       ]+[           ]+[ ]+[   NETTO   ]+[ ]+[    VAT    ]              +[ ]+[           ]+[ ]+[           ]+[ ]+[SUMA nabyci]+[a]+[ pozostalych])
         mon_drk(space(125)+[       ]+[WNT (UE)   ]+[ ]+str(suenet,11,2)+[ ]+str(suevat,11,2)        +[ ]+[           ]+[ ]+[           ]+[ ]+[    (do dek]+[l]+[aracji)     ])
         if param_rok>='2009'
            mon_drk(space(125)+[       ]+[Import tow.]+[ ]+str(stowarnet,11,2)+[ ]+str(stowarvat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+[   NETTO   ]+[ ]+[     VAT    ])
            mon_drk(space(125)+[       ]+[Import usl.]+[ ]+str(susluganet,11,2)+[ ]+str(suslugavat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+str(s0_9D+s0_11D,11,2)+[ ]+str(s0_10+(s0_12*(zstrusprob/100)),11,2))
            mon_drk(space(125)+[       ]+[Podat.naby.]+[ ]+str(swewdosnet,11,2)+[ ]+str(swewdosvat,11,2))
         else
            mon_drk(space(125)+[       ]+[Import usl.]+[ ]+str(susluganet,11,2)+[ ]+str(suslugavat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+[   NETTO   ]+[ ]+[     VAT    ])
            mon_drk(space(125)+[       ]+[Podat.naby.]+[ ]+str(swewdosnet,11,2)+[ ]+str(swewdosvat,11,2)+[ ]+[           ]+[ ]+[           ]+[ ]+str(s0_9D+s0_11D,11,2)+[ ]+str(s0_10+(s0_12*(zstrusprob/100)),11,2))
         endif
         if ewid_rzz='D'.or.ewid_rzz='W'
            mon_drk(space(131)+[do zaplaty ]+str(zsumzap,14,2))
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
