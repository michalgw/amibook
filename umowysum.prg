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
private typ //<--= //002a nowa zmienna
save screen to scrbor
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=130
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=130
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      il_kontr=0
      od_dnia=ctod(param_rok+[.01.01])
      do_dnia=ctod(param_rok+[.12.31])
      od_kontr=space(30)
      od_kontr1=space(15)
      zTYT='*'
      klucz=''
      sort=1
      @ 20,1  clear to 22,75
      @ 20,1  say [Od dnia] get od_dnia
      @ 21,1  say [Do dnia] get do_dnia
      @ 20,20 say [Nazwisko] get od_kontr picture repl('!',30)
      @ 20,60 say [Imi&_e.] get od_kontr1 picture repl('!',15)
      @ 21,20 say [(je&_z.eli zestawienie dla wszystkich to zostaw puste pola)]
      @ 22,1  say [W/w daty dotycza: zawarcia umowy(1),wyplaty(2) ?] get sort pict '9' range 1,2
      @ 22,54 say [Tylko umowy typu:] get zTYT pict '!' when jakitytul2() valid zTYT$'*AZPICEFSRO'
      read_()
      if lastkey()=27
         break
      endif
      if od_dnia>do_dnia.or.year(od_dnia)#val(param_rok).or.year(do_dnia)#val(param_rok)
         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
         break
      endif
      if .not.empty(od_kontr)
         klucz=od_kontr+alltrim(od_kontr1)
      endif
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      KONIEC1=.f.
      zIDENT=0
      select 2
      if dostep('PRAC')
         do setind with 'PRAC'
         seek '+'+IDENT_FIR+klucz
         KONIEC1=&_koniec
         if .not.KONIEC1
*            zIDENT=recno()
            zident=rec_no
         endif
      else
         break
      endif
      select 1
      if dostepex('UMOWY')
         if sort=1
            index on del+firma+ident+dtos(data_umowy) to &raptemp
            dat1='Data umowy'
            dat2='Data wyp&_l..'
            fdat1='DATA_UMOWY'
            fdat2='DATA_WYP'
         else
            index on del+firma+ident+dtos(data_wyp) to &raptemp
            dat1='Data wyp&_l..'
            dat2='Data umowy'
            fdat1='DATA_WYP'
            fdat2='DATA_UMOWY'
         endif
         if dostep('UMOWY')
            set inde to &raptemp
         else
            break
         endif
         seek '+'+IDENT_FIR
         KONIEC1=&_koniec
      else
         break
      endif
      sele prac
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if KONIEC1 .and. &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*     od_dnia_=str(month(od_dnia),2)+[-]+str(day(od_dnia),2)
*     do_dnia_=str(month(do_dnia),2)+[-]+str(day(do_dnia),2)
      store 0 to s0_10,s0_11,s0_12,s0_12b,s0_13,s0_14
      store 0 to s1_10,s1_11,s1_12,s1_12b,s1_13,s1_14
      store 0 to s0_20,s0_21,s0_22,s0_23,s0_24,s0_25,s0_26,s0_27,s0_28,s0_29,s0_30
      store 0 to s1_20,s1_21,s1_22,s1_23,s1_24,s1_25,s1_26,s1_27,s1_28,s1_29,s1_30
      k1=dtoc(od_dnia)
      k2=dtoc(do_dnia)
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ö]+procname())
      TytulOpis='wszystkie umowy'
      do case
      case zTYT='A'
           TytulOpis='umowy aktywizacyjne'
      case zTYT='C'
           TytulOpis='czlonkowstwo w spoldzielniach'
      case zTYT='E'
           TytulOpis='emerytury i renty zagraniczne'
      case zTYT='F'
           TytulOpis='swiadczenia z FP i FGSP'
      case zTYT='Z'
           TytulOpis='umowy zlecenia i o dzielo'
      case zTYT='P'
           TytulOpis='prawa autorskie i podobne'
      case zTYT='I'
           TytulOpis='inne zrodla'
      case zTYT='R'
           TytulOpis='ryczalty do 200zl'
      case zTYT='S'
           TytulOpis='obowiazki spoleczne'
      case zTYT='O'
           TytulOpis='obcokrajowcy'
      endcase

      mon_drk([ ZESTAWIENIE UMOW i INNYCH WYPLAT za okres od  ]+k1+[  do  ]+k2+[   (]+TytulOpis+[)        FIRMA: ]+SYMBOL_FIR)
      if .not.empty(od_kontr)
         mon_drk([ DLA:  ]+od_kontr)
      endif
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³                              ³Mi³                              I N F O R M A C J E   O   Z L E C E N I U                       ³])
      mon_drk([³      Nazwisko i imiona       ³esÃÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³                              ³¥c³Numer³]+dat1+  [³]+dat2+  [³Rodz³Przych¢d³  Koszty ³  Doch¢d  ³ZUS zdrow³ Podatek ³Do wypˆaty ³])
      mon_drk([³                              ³  ÃÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÂÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÂÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´])
      mon_drk([³                              ³  ³      Skladki ZUS wykonawcy        ³     Skladki ZUS zleceniodawcy     ³       Fundusze       ³])
      mon_drk([³                              ³  ³Emeryt. ³Rentowa ³Chorob ³  SUMA   ³Emeryt. ³Rentowa ³Wypadk ³  SUMA   ³ Pracy ³  GSP ³ SUMA  ³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ])
      sele prac
      set exact off
      do while .not.&_koniec .and.nazwisko+imie1=klucz
         set exact on
         nazi=0
         store 0 to s1_10,s1_11,s1_12,s1_13,s1_14
         k3=nazwisko
         k4=imie1
         k5=imie2
         kk3=padr(alltrim(k3)+[ ]+alltrim(k4)+[ ]+alltrim(k5),30)
*         kk5=recno()
         kk5=rec_no
         sele umowy
         do case
         case zTYT='A'
              set filter to TYTUL='1'
         case zTYT='C'
              set filter to TYTUL='2'
         case zTYT='E'
              set filter to TYTUL='3'
         case zTYT='F'
              set filter to TYTUL='4'
         case zTYT='Z'
              set filter to TYTUL='5'
         case zTYT='P'
              set filter to TYTUL='6'
         case zTYT='I'
              set filter to TYTUL='7'
         case zTYT='R'
              set filter to TYTUL='8'
         case zTYT='S'
              set filter to TYTUL='9'
         case zTYT='O'
              set filter to TYTUL='10'
         endcase
         go top
         seek '+'+IDENT_FIR+str(kk5,5)
         do while.not.eof().and..not.&_koniec .and.ident=str(kk5,5)
            if dtos(&fdat1)>=dtos(od_dnia).and.dtos(&fdat1)<=dtos(do_dnia)
//002a obsluga nowej zmiennej
               do case
               case TYTUL='0'
                    typ='O' //organy stanowiace
               case TYTUL='1'
                    typ='A' //aktywizacja
               case TYTUL='2'
                    typ='C' //czlonkowstwo w spoldzielni
               case TYTUL='3'
                    typ='E' //emerytury i renty zagraniczne
               case TYTUL='4'
                    typ='F' //swiadczenia z funduszu pracy i GSP
               case TYTUL='9'
                    typ='S' //obowiazki spoleczne

               case TYTUL='6'
                    typ='P' //prawa autorskie
               case TYTUL='7'
                    typ='I' //inne zrodla
               case TYTUL='8'
                    typ='R' //kontrakty menadzerskie
               case TYTUL='10'
                    typ='O' //kontrakty menadzerskie
               other
                    typ='Z' //umowy zlecenia i o dzielo 5
               endcase

//002a do tad
               k6=str(month(&fdat1),2)
               k7=numer
               k8=dtoc(&fdat1)
               k9=dtoc(&fdat2)
               k10=brut_zasad
               k11=koszt
               k12=dochod
               k12b := war_puz
               k13=podatek
               k14=do_wyplaty
               k20=war_pue
               k21=war_pur
               k22=war_puc
               k23=war_psum
               k24=war_fue
               k25=war_fur
               k26=war_fuw
               k27=war_fsum
               k28=war_ffp
               k29=war_ffg
               k30=war_ffp+war_ffg
//002a dodanie nowej zmiennej do tabeli
               if nazi=0
                  mon_drk([ ]+kk3+[ ]+k6+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+typ+[ ]+str(k10,11,2)+[ ]+str(k11,9,2)+[ ]+str(k12,10,2)+[ ]+str(k12b,9,2)+[ ]+str(k13,9,2)+[ ]+str(k14,11,2))
               else
                  mon_drk(Space(32)+k6+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+typ+[ ]+str(k10,11,2)+[ ]+str(k11,9,2)+[ ]+str(k12,10,2)+[ ]+str(k12b,9,2)+[ ]+str(k13,9,2)+[ ]+str(k14,11,2))
               endif
               mon_drk(Space(35)+str(k20,8,2)+[ ]+str(k21,8,2)+[ ]+str(k22,7,2)+[ ]+str(k23,9,2)+[ ]+str(k24,8,2)+[ ]+str(k25,8,2)+[ ]+str(k26,7,2)+[ ]+str(k27,9,2)+[ ]+str(k28,7,2)+[ ]+str(k29,6,2)+[ ]+str(k30,7,2))
               s0_10=s0_10+k10
               s0_11=s0_11+k11
               s0_12=s0_12+k12
               s0_12b := s0_12b + k12b
               s0_13=s0_13+k13
               s0_14=s0_14+k14

               s1_10=s1_10+k10
               s1_11=s1_11+k11
               s1_12=s1_12+k12
               s1_12b := s1_12b + k12b
               s1_13=s1_13+k13
               s1_14=s1_14+k14

               s0_20=s0_20+k20
               s0_21=s0_21+k21
               s0_22=s0_22+k22
               s0_23=s0_23+k23
               s0_24=s0_24+k24
               s0_25=s0_25+k25
               s0_26=s0_26+k26
               s0_27=s0_27+k27
               s0_28=s0_28+k28
               s0_29=s0_29+k29
               s0_30=s0_30+k30

               s1_20=s1_20+k20
               s1_21=s1_21+k21
               s1_22=s1_22+k22
               s1_23=s1_23+k23
               s1_24=s1_24+k24
               s1_25=s1_25+k25
               s1_26=s1_26+k26
               s1_27=s1_27+k27
               s1_28=s1_28+k28
               s1_29=s1_29+k29
               s1_30=s1_30+k30

               nazi++
            endif
            sele umowy
            skip 1
         enddo
         if nazi>1
            mon_drk([                                R A Z E M                        ]+str(s1_10,11,2)+[ ]+str(s1_11,9,2)+[ ]+str(s1_12,10,2)+[ ]+str(s1_12b,9,2)+[ ]+str(s1_13,9,2)+[ ]+str(s1_14,11,2))
            mon_drk(Space(35)+str(s1_20,8,2)+[ ]+str(s1_21,8,2)+[ ]+str(s1_22,7,2)+[ ]+str(s1_23,9,2)+[ ]+str(s1_24,8,2)+[ ]+str(s1_25,8,2)+[ ]+str(s1_26,7,2)+[ ]+str(s1_27,9,2)+[ ]+str(s1_28,7,2)+[ ]+str(s1_29,6,2)+[ ]+str(s1_30,7,2))
            mon_drk([                                          ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
         endif
         if nazi=1
            mon_drk([                                          ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
         endif
         store 0 to s1_10,s1_11,s1_12,s1_13,s1_14,s1_12b
         store 0 to s1_20,s1_21,s1_22,s1_23,s1_24,s1_25,s1_26,s1_27,s1_28,s1_29,s1_30
         sele prac
         skip 1
         set exact off
      enddo
      set exact on
      use
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk(repl('=',130))
      mon_drk([                                OG&__O.&__L.EM ZA OKRES                  ]+str(s0_10,11,2)+[ ]+str(s0_11,9,2)+[ ]+str(s0_12,10,2)+[ ]+str(s0_12b,9,2)+[ ]+str(s0_13,9,2)+[ ]+str(s0_14,11,2))
      mon_drk(Space(35)+str(s0_20,8,2)+[ ]+str(s0_21,8,2)+[ ]+str(s0_22,7,2)+[ ]+str(s0_23,9,2)+[ ]+str(s0_24,8,2)+[ ]+str(s0_25,8,2)+[ ]+str(s0_26,7,2)+[ ]+str(s0_27,9,2)+[ ]+str(s0_28,7,2)+[ ]+str(s0_29,6,2)+[ ]+str(s0_30,7,2))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
rest screen from scrbor
if _czy_close
   close_()
endif
func jakitytul2
   ColInf()
   @  8,50 clear to 21,79
   @  8,50 to 21,79
   @  9,51 say padc('Wpisz:',28)
   @ 10,51 say '* - wszystkie rodzaje       '
   @ 11,51 say 'Z - umowy zlecenia i o dziel'
   @ 12,51 say 'P - prawa autorskie i inne  '
   @ 13,51 say 'I - inne zrodla             '
   @ 14,51 say 'C - czlonkowstwo w spoldziel'
   @ 15,51 say 'E - emerytury,renty zagrani.'
   @ 16,51 say 'F - swiadczenia z FP i FGSP '
   @ 17,51 say 'S - spoleczne obowiazki     '
   @ 18,51 say 'A - aktywizacyjna umowa     '
   @ 19,51 say 'R - ryczalt do 200zl        '
   @ 20,51 say 'O - obcokrajowcy            '
return .t.
