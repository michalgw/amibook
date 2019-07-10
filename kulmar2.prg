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
begin sequence
      filstr='_99999_'
      filstr2='_99999_'
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=129
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=129
      _koniec="eof()"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@

      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      sele 3
      do while.not.dostep('KONTR')
      enddo
      do setind with 'KONTR'
      set orde to 2

      select 1
      do while.not.dostep('ROZR')
      enddo
      do setind with 'ROZR'
      seek ident_fir
      if eof().or.firma#ident_fir
         kom(3,[*u],[ Brak dokumentow rozrachunkowych dla tej firmy ])
         break
      endif

      zSZUKZAP='N'
      zSZUKZAK='S'
      zSZUKNIP=space(13)
      zSZUKNAZ=space(70)
      save screen to SCRINSZAPL
      @  5,9 clear to 12,69
      @  5,9 to 12,69 double
      @  6,10 say padc('WPROWADZ KRYTERIA DO TWORZENIA WYDRUKU',58)
*      @  8,11 say 'Szukaj nr fakt:'
*      @  9,11 say 'Dokladnie taki numer/Zawarte w numerze faktury (D/Z ?)'
*      @ 10,11 say 'Szukac we wszystkich pozycjach/Od tej pozycji  (S/O ?)'

      @  7,11 say 'Kontrahent NIP:'
      @  7,41 say 'szukaj nazwy..:'
      @  8,11 say '(pozostaw NIP i nazwe puste jezeli wszyscy kontrahenci)'
      @  10,11 say 'Niezaplacone/Zaplacone/Wszystko ?'
      @  11,11 say 'Zakupy/Sprzedaz/Wszystko ?'

*      @  8,26 get zSZUKFAK picture repl('!',10)
*      @  9,66 get zSZUKOPT picture '!' valid zSZUKOPT$'DZ'
*      @ 10,66 get zSZUKOPT2 picture '!' valid zSZUKOPT2$'SO'

      @  7,26 get zSZUKNIP picture repl('!',13) valid vv1_3rozr()
      @  7,56 get zSZUKNAZ picture '@S13 '+repl('!',70) valid w1_3rozr()
      @  10,66 get zSZUKZAP picture '!' valid zSZUKZAP$'ZNW'
      @  11,66 get zSZUKZAK picture '!' valid zSZUKZAK$'ZSW'

      read_()
      rest screen from SCRINSZAPL
      if lastkey()=27
         break
      endif

      wydrukopis=''
      if zSZUKNIP<>space(13)
         wydrukopis=wydrukopis+':Tylko kontrahent NIP:'+alltrim(zSZUKNIP)
      else
         wydrukopis=wydrukopis+':Wszyscy kontrahenci'
      endif
      do case
      case zSZUKZAP='Z'
           wydrukopis=wydrukopis+':Tylko zaplacone'
      case zSZUKZAP='N'
           wydrukopis=wydrukopis+':Tylko niezaplacone'
      case zSZUKZAP='W'
           wydrukopis=wydrukopis+':Zaplacone i niezaplacone'
      endcase
      do case
      case zSZUKZAK='Z'
           wydrukopis=wydrukopis+':Tylko zakupy'
      case zSZUKZAK='S'
           wydrukopis=wydrukopis+':Tylko sprzedaz'
      case zSZUKZAK='W'
           wydrukopis=wydrukopis+':Sprzedaz i zakupy'
      endcase

      do czekaj

      filstr='_'+strtran(str(seconds(),5),' ','0')+'_'
      create &filstr
      append blank
      replace field_name with "NIP",field_type with "C",field_len with 13,field_dec with 0
      append blank
      replace field_name with "NAZWA",field_type with "C",field_len with 41,field_dec with 0
      append blank
      replace field_name with "WYR",field_type with "C",field_len with 15,field_dec with 0
      append blank
      replace field_name with "NRDOK",field_type with "C",field_len WITH 20,field_dec with 0
      append blank
      replace field_name with "DATADOK",field_type with "D",field_len with 8,field_dec with 0
      append blank
      replace field_name with "DOZAPLATY",field_type with "N",field_len with 12,field_dec with 2
      append blank
      replace field_name with "WTERMINIE",field_type with "D",field_len with 8,field_dec with 0
      append blank
      replace field_name with "ZAPLWTERM",field_type with "N",field_len with 12,field_dec with 2
      append blank
      replace field_name with "ZAPLWTERU",field_type with "N",field_len with 12,field_dec with 2
      append blank
      replace field_name with "ZAPLPOTER",field_type with "N",field_len with 12,field_dec with 2
      append blank
      replace field_name with "NIEDOPLAT",field_type with "N",field_len with 12,field_dec with 2
      append blank
      replace field_name with "DNIZAPL",field_type with "N",field_len with 3,field_dec with 0
      append blank
      replace field_name with "OPOZNIENI",field_type with "N",field_len with 3,field_dec with 0
      append blank
      replace field_name with "DZIENKOR",field_type with "D",field_len with 8,field_dec with 0
      append blank
      replace field_name with "KWOTAKOR",field_type with "N",field_len with 12,field_dec with 2
      close
      filstr2=filstr+'B'
      sele 1
      create &filstr2 from &filstr
      index on NAZWA+dtos(DATADOK)+NRDOK to &filstr2

      sele 3
      do while.not.dostep('KONTR')
      enddo
      do setind with 'KONTR'
      set orde to 2

      select 2
      do while.not.dostep('ROZR')
      enddo
      do setind with 'ROZR'
      if zSZUKNIP==space(13)
         set filter to firma=ident_fir
      else
         set filter to firma=ident_fir.and.NIP=zSZUKNIP
      endif
*      .and.(rodzdok='FZ'.or.rodzdok='ZZ')
      go top
           do czekaj
           do while .not.eof()
              kluczstat=ident_fir+NIP+WYR
              zNIP=NIP
              sele 3
              seek '+'+ident_fir+zNIP
              if found()
                 zNAZWA=NAZWA
              else
                 zNAZWA=space(41)
              endif
              sele 2
              zWYR=WYR
              zILDNI=DNIPLAT
              zDATADOK=DATADOK
              zNRDOK=NRDOK
              zTERMIN=TERMIN
              FZ=0.0
              FS=0.0
              ZZ=0.0
              ZS=0.0
              ZZT=0.0
* zaplacono w terminie faktury
              ZZU=0.0
* zaplacono w terminie urzedowym nie wymagajacym korekt
              ZZP=0.0
* zaplacono po terminie urzedowym wymagajacym korekt
              do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                 do case
                 case RODZDOK='FZ'
                      FZ=FZ+(MNOZNIK*KWOTA)
                 case RODZDOK='ZZ'
                      ZZ=ZZ+(MNOZNIK*KWOTA)
                 case RODZDOK='FS'
                      FS=FS+(MNOZNIK*KWOTA)
                 case RODZDOK='ZS'
                      ZS=ZS+(MNOZNIK*KWOTA)
                 endcase
                 skip
              enddo

              if zSZUKZAP='N'.or.zSZUKZAP='W'
                 if zSZUKZAK='Z'.or.zSZUKZAK='W'
                    if (FZ+ZZ)<>0.0
                       sele 1
                       do DOPAP
                       repl NIP with zNIP,NAZWA with zNAZWA,WYR with zWYR,DOZAPLATY with FZ,WTERMINIE with zTERMIN,ZAPLWTERM with ZZT,ZAPLWTERU with ZZU,ZAPLPOTER with ZZP,KWOTAKOR with ZZ,DNIZAPL with zILDNI,DATADOK with zDATADOK,NRDOK with zNRDOK
                       commit
                    endif
                 endif
                 if zSZUKZAK='S'.or.zSZUKZAK='W'
                    if (FS+ZS)<>0.0
                       sele 1
                       do DOPAP
                       repl NIP with zNIP,NAZWA with zNAZWA,WYR with zWYR,DOZAPLATY with FS,WTERMINIE with zTERMIN,ZAPLWTERM with ZZT,ZAPLWTERU with ZZU,ZAPLPOTER with ZZP,KWOTAKOR with ZS,DNIZAPL with zILDNI,DATADOK with zDATADOK,NRDOK with zNRDOK
                       commit
                    endif
                 endif
              endif

              if zSZUKZAP='Z'.or.zSZUKZAP='W'
                 if zSZUKZAK='Z'.or.zSZUKZAK='W'
                    if (FZ+ZZ)=0.0.and.(FZ<>0.0.or.ZZ<>0.0)
                       sele 1
                       do DOPAP
                       repl NIP with zNIP,NAZWA with zNAZWA,WYR with zWYR,DOZAPLATY with FZ,WTERMINIE with zTERMIN,ZAPLWTERM with ZZT,ZAPLWTERU with ZZU,ZAPLPOTER with ZZP,KWOTAKOR with ZZ,DNIZAPL with zILDNI,DATADOK with zDATADOK,NRDOK with zNRDOK
                       commit
                    endif
                 endif
                 if zSZUKZAK='S'.or.zSZUKZAK='W'
                    if (FS+ZS)=0.0.and.(FS<>0.0.or.ZS<>0.0)
                       sele 1
                       do DOPAP
                       repl NIP with zNIP,NAZWA with zNAZWA,WYR with zWYR,DOZAPLATY with FS,WTERMINIE with zTERMIN,ZAPLWTERM with ZZT,ZAPLWTERU with ZZU,ZAPLPOTER with ZZP,KWOTAKOR with ZS,DNIZAPL with zILDNI,DATADOK with zDATADOK,NRDOK with zNRDOK
                       commit
                    endif
                 endif
              endif

              sele 2
           enddo


      sele 1
      go top
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         kom(3,[*w],[b r a k   d a n y c h])
         break
      endif
      NIPsum=NIP
      NIPil=0
      NIPdozap=0
      NIPzapla=0
      NIPpozost=0
      SUMdozap=0
      SUMzapla=0
      SUMpozost=0

      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa1=int(strona/max(1,_druk_2-7))
      _grupa=.t.
      do while .not.&_koniec
         if _grupa.or._grupa1#int(strona/max(1,_druk_2-7))
            _grupa1=int(strona/max(1,_druk_2-7))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k4=int(strona/max(1,_druk_2-7))+1
*            p_folio1 =s1_5
*            p_folio2 =s1_6
*            p_folio3 =s1_7
*            store 0 to s_folio1,s_folio2,s_folio3

            mon_drk([                                    NIEZAP&__L.ACONE WG KONTRAHENTA na dzie&_n.  ]+dtoc(date())+[                            FIRMA: ]+SYMBOL_FIR)
*            mon_drk([])
            mon_drk(padr(wydrukopis,120)+[  str.]+str(k4,3))
            mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³                  NAZWA                        NIP     ³Data dok. ³Numer dok.³Termin zap³ Do zaplaty ³ Zaplacono  ³ Pozostalo  ³])
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÙ])

         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
*         liczba=liczba+1

         NIPsum=NIP
         NIPil=NIPil+1
         NIPdozap=NIPdozap+dozaplaty
         NIPzapla=NIPzapla+kwotakor
         NIPpozost=NIPpozost+(DOZAPLATY+KWOTAKOR)

         k1=NAZWA
         k2=NIP
         k3=dtoc(DATADOK)
         K4=NRDOK
         K5=dtoc(WTERMINIE)
         K6=DOZAPLATY
         k7=KWOTAKOR
         k8=DOZAPLATY+KWOTAKOR
         skip
*         s_folio1 =s_folio1 +k5
*         s_folio2 =s_folio2 +k6
*         s_folio3 =s_folio3 +k7
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*         s1_5=s1_5+k5
*         s1_6=s1_6+k6
*         s1_7=s1_7+k7
         mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+k5+[ ]+str(k6,12,2)+[ ]+str(k7,12,2)+[ ]+str(k8,12,2))
         if NIPsum<>NIP
            if NIPil>1.0
               mon_drk(space(62)+[RAZEM kontrahent ==========>]+str(NIPdozap,12,2)+[ ]+str(NIPzapla,12,2)+[ ]+str(NIPpozost,12,2))
            else
               mon_drk([])
            endif
            SUMdozap=SUMdozap+NIPdozap
            SUMzapla=SUMzapla+NIPzapla
            SUMpozost=SUMpozost+NIPpozost
            NIPsum=NIP
            NIPil=0
            NIPdozap=0
            NIPzapla=0
            NIPpozost=0
         endif
*         mon_drk(space(94)+str(k11,12,2)+[   ]+str(k12,12,2))
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-7))#_grupa1.or.&_koniec
              _numer=0
         endcase
         _grupa=.f.
         if _numer<1
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*            k5 =s_folio1
*            k6 =s_folio2
*            k7 =s_folio3
*            k55=p_folio1
*            k66=p_folio2
*            k77=p_folio3
            k29=dos_c(code())
            mon_drk(repl('Ä',129))
*            mon_drk([U&_z.ytkownik programu komputerowego: ]+k29)
*            mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
*            mon_drk([                                                 Suma folio  ³]+kwota(k5,9,2)+[³]+kwota(k6,9,2)+[³]+kwota(k7,9,2)+[³])
*            mon_drk([            U&_z.ytkownik programu komputerowego                ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´])
*            mon_drk([                                                 Z przenies. ³]+kwota(k55,9,2)+[³]+kwota(k66,9,2)+[³]+kwota(k77,9,2)+[³])
*            mon_drk([ ]+k29+                                           [          ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´])
*            mon_drk([                                                 RAZEM       ³]+kwota(s1_5,9,2)+[³]+kwota(s1_6,9,2)+[³]+kwota(s1_7,9,2)+[³])
*            mon_drk([                                                             ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
*            s0_5=s0_5+s1_5
*            s0_6=s0_6+s1_6
*            s0_7=s0_7+s1_7
         endif
      enddo
*      mon_drk(repl('=',129))
      mon_drk(space(61)+[RAZEM zestawienie ==========>]+str(SUMdozap,12,2)+[ ]+str(SUMzapla,12,2)+[ ]+str(SUMpozost,12,2))
      mon_drk(repl('=',129))
      mon_drk([U&_z.ytkownik programu komputerowego: ]+k29)
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([þ])
end
if file(filstr+'.dbf')
   delete file &filstr..dbf
endif
if file(filstr2+'.dbf')
   delete file &filstr2..dbf
endif
if file(filstr2+'.cdx')
   delete file &filstr2..cdx
endif
if _czy_close
   close_()
endif

