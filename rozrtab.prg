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
      filstr='_99999_'
      filstr2='_99999_'
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=124
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.f.
      czesc=1
      *------------------------------
      _szerokosc=124
      _koniec="eof()"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      stronap=1
      stronak=99999
        save screen to SCRINSZAPL
        zKORDATS=date()
        @ 14,19 clear to 17,59
        @ 14,19 to 17,59 double
        @ 15,20 say padc('NA JAKI DZIEN OBLICZAC',38)
        @ 16,26 say 'Data korekt...:'
        @ 16,42 get zKORDATS picture '@D'
        read_()
        rest screen from SCRINSZAPL
        if lastkey()=27
           break
        endif
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      liczba=0
      select 1
      do while.not.dostep('ROZR')
      enddo
      do setind with 'ROZR'
      seek ident_fir
      if eof().or.firma#ident_fir
         kom(3,[*u],[ Brak dokumentow rozrachunkowych dla tej firmy ])
         break
      endif
      filstr='_'+strtran(str(seconds(),5),' ','0')+'_'
      create &filstr
      append blank
      replace field_name with "NIP",field_type with "C",field_len with 13,field_dec with 0
      append blank
      replace field_name with "WYR",field_type with "C",field_len with 15,field_dec with 0
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
      index on dtos(DZIENKOR)+dtos(DATADOK)+NIP+WYR to &filstr2

      select 2
      do while.not.dostep('ROZR')
      enddo
      do setind with 'ROZR'
      set filter to firma=ident_fir.and.(rodzdok='FZ'.or.rodzdok='ZZ')
      go top
           do czekaj
           do while .not.eof()
              kluczstat=ident_fir+NIP+WYR
              zNIP=NIP
              zWYR=WYR
              zILDNI=DNIPLAT
              zDATADOK=DATADOK
              FZ=0.0
              ZZ=0.0
              ZZT=0.0
* zaplacono w terminie faktury
              ZZU=0.0
* zaplacono w terminie urzedowym nie wymagajacym korekt
              ZZP=0.0
* zaplacono po terminie urzedowym wymagajacym korekt
              do while .not.eof().and.FIRMA+NIP+WYR==kluczstat
                 do case
                 case RODZDOK='FZ'
                      zTERMIN=TERMIN
                      if DNIPLAT<=parar_ter
                         zTERMINKOR=TERMIN+parar_kok
                      else
                         zTERMINKOR=DATADOK+parar_kod
                      endif
                      FZ=FZ+(MNOZNIK*KWOTA)
                 case RODZDOK='ZZ'
                      ZZ=ZZ+(MNOZNIK*KWOTA)
                      if DATAKS<=zTERMIN
                         ZZT=ZZT+(MNOZNIK*KWOTA)
                      else
                         if DATAKS<=zTERMINKOR
                            ZZU=ZZU+(MNOZNIK*KWOTA)
                         else
                            ZZP=ZZP+(MNOZNIK*KWOTA)
                         endif
                      endif
                 endcase
                 skip
              enddo
              if (zTERMINKOR<=zKORDATS).and.(ZZP<>0.0.or.FZ+ZZ<>0.0)
                 sele 1
                 do DOPAP
                 repl NIP with zNIP,WYR with zWYR,DOZAPLATY with FZ,WTERMINIE with zTERMIN,ZAPLWTERM with ZZT,ZAPLWTERU with ZZU,ZAPLPOTER with ZZP,DZIENKOR with zTERMINKOR,KWOTAKOR with FZ+ZZT+ZZU,DNIZAPL with zILDNI,DATADOK with zDATADOK
                 commit
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
      mon_drk([ö]+procname())
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
*      store 0 to s0_5,s0_6,s0_7
*      store 0 to s1_5,s1_6,s1_7
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      _grupa1=int(strona/max(1,_druk_2-14))
      _grupa=.t.
      do while .not.&_koniec
         if _grupa.or._grupa1#int(strona/max(1,_druk_2-14))
            _grupa1=int(strona/max(1,_druk_2-14))
            _grupa=.t.
            *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
            k4=int(strona/max(1,_druk_2-14))+1
*            p_folio1 =s1_5
*            p_folio2 =s1_6
*            p_folio3 =s1_7
*            store 0 to s_folio1,s_folio2,s_folio3
            mon_drk([                             RAPORT DO KOREKTY KOSZTOW DLA DLUZNIKOW NA DZIEN ]+dtoc(zKORDATS)+[                  FIRMA: ]+SYMBOL_FIR)
            mon_drk([                                                                                                            str.]+str(k4,3))
            mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
            mon_drk([³Dz.korekty³Data doku.³     NIP     ³Wyroznik dokum.³ Do zaplaty ³ Do dnia  ³Dni³Zapl.w term.³Zapl.po ter.³Kwota do korekty³])
            mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
            mon_drk([                                                                                ³Zapl.po terminie korekty ³Pozostalo do zap³])
            mon_drk([                                                                                ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
         endif
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         strona=strona+1
         liczba=liczba+1
         k1=dtoc(DZIENKOR)
         k2=dtoc(DATADOK)
         k3=NIP
         K4=WYR
         K5=DOZAPLATY
         K6=dtoc(WTERMINIE)
         k7=DNIZAPL
         k8=ZAPLWTERM
         k9=ZAPLWTERU
         k10=KWOTAKOR
         k11=ZAPLPOTER
         k12=DOZAPLATY+ZAPLWTERM+ZAPLWTERU+ZAPLPOTER
         skip
*         s_folio1 =s_folio1 +k5
*         s_folio2 =s_folio2 +k6
*         s_folio3 =s_folio3 +k7
         *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
*         s1_5=s1_5+k5
*         s1_6=s1_6+k6
*         s1_7=s1_7+k7
         mon_drk([ ]+k1+[ ]+k2+[ ]+k3+[ ]+k4+[ ]+str(k5,12,2)+[ ]+k6+[ ]+str(k7,3)+[ ]+str(k8,12,2)+[ ]+str(k9,12,2)+[   ]+str(k10,12,2))
         mon_drk(space(94)+str(k11,12,2)+[   ]+str(k12,12,2))
         *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
         _numer=1
         do case
         case int(strona/max(1,_druk_2-14))#_grupa1.or.&_koniec
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
            mon_drk(repl('Ä',124))
            mon_drk([ ]+k29)
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
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
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
*sele rachpoj
*set orde to 1
