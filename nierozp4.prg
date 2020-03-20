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

private _grupa1,_grupa2,_grupa3,_grupa4,_grupa5,_grupa,_koniec,_szerokosc,_numer,_lewa,_prawa,_strona,_czy_mon,_czy_close
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      nr_strony=0
      _papsz=1
      _lewa=1
      _prawa=129
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=129
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      select 5
      if dostep('ZALICZKI')
         do setind with 'ZALICZKI'
      else
         break
      endif
      select 4
      if dostep('WYPLATY')
         do setind with 'WYPLATY'
      else
         break
      endif
      *seek [+]+ident_fir
      sele 3
      if dostep('ETATY')
         do SETIND with 'ETATY'
      else
         break
      endif
      sele 2
      if dostep('PRAC')
         do SETIND with 'PRAC'
      else
         break
      endif
      seek '+'+ident_fir
      if .not.found()
         kom(3,[*w],[b r a k   p r a c o w n i k &_o. w])
         break
      endif

//tworzenie bazy roboczej
      if file('ROBWYP.dbf')=.f.
         dbcreate("ROBWYP",{;
                 {"NAZWISKO", "C",50, 0},;
                 {"PESEL",    "C",11, 0},;
                 {"MCWYP",    "C", 2, 0},;
                 {"DOWYPLATY","N", 9, 2},;
                 {"WYPLACONO","N", 9, 2},;
                 {"DATAWYPLA","D", 8, 0},;
                 {"ZALICZKA", "N", 9, 2},;
                 {"DATAZALI", "D", 8, 0},;
                 {"DATA",     "D", 8, 0},;
                 {"PODATEK",  "N", 9, 2},;
                 {"DOPIT4",   "C", 6, 0}})
      endif
      select 1
      if dostepex('ROBWYP')
         zap
      else
         break
      endif

      if file('ROBWYPZA.dbf')=.f.
         dbcreate("ROBWYPZA",{;
                 {"DATA",     "D", 8, 0},;
                 {"RODZAJ",   "C", 1, 0},;
                 {"KWOTA",    "N", 8, 2},;
                 {"IDENT",    "C", 5, 0},;
                 {"MC",       "C", 2, 0}})
      endif
      select 10
      if dostepex('ROBWYPZA')
         zap
      else
         break
      endif
      inde on dtos(DATA) to ROBWYPZA

*      sele prac

      paras_np4='Nierozliczone w PIT-4'
      if .not.file([param_sp.mem])
         save to param_sp all like paras_*
      else
         restore from param_sp addi
      endif
      zparas_np4=paras_np4+space(40-len(paras_np4))
      mcod=val(miesiac)
      mcdo=val(miesiac)
      @ 23,0  clear to 23,79
      @ 23,0 say [M-c od] get mcod
      @ 23,10 say [do] get mcdo
      @ 23,16 say [Nag&_l.&_o.wek] get zparas_np4 pict repl('X',40)
      read_()
      if lastkey()=27
         break
      endif
      paras_np4=alltrim(zparas_np4)
      save to param_sp all like paras_*
      if mcod>mcdo
         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
         break
      endif

      sele prac
      set orde to 4

      sele etaty
      set orde to 2
      set filt to mc>=str(mcod,2).and.mc<=str(mcdo,2).and.len(alltrim(do_pit4))=0
      go top
      seek '+'+ident_fir

      do while  &_koniec=.f. .and. .not. eof()
         sele prac
         seek val(etaty->ident)
         if found()
            znazimie=alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2)
            zpesel=pesel
         else
            znazimie='BRAK PRACOWNIKA W BAZIE DANYCH  '
            zpesel='? ? ? ? ? ?'
         endif
         sele ROBWYPZA
         zap
         sele wyplaty
         seek '+'+ident_fir+etaty->ident+etaty->mc
         if found()
            do while .not.eof().and.del='+'.and.firma==ident_fir.and.ident==etaty->ident.and.mc==etaty->mc
               sele ROBWYPZA
               appe blan
               repl DATA with WYPLATY->DATA_WYP,RODZAJ with 'W',KWOTA with WYPLATY->KWOTA
               sele wyplaty
               skip
            enddo
         endif
         sele zaliczki
         seek '+'+ident_fir+etaty->ident+etaty->mc
         if found()
            do while .not.eof().and.del='+'.and.firma==ident_fir.and.ident==etaty->ident.and.mc==etaty->mc
               sele ROBWYPZA
               appe blan
               repl DATA with ZALICZKI->DATA_WYP,RODZAJ with 'Z',KWOTA with ZALICZKI->KWOTA
               sele zaliczki
               skip
            enddo
         endif
         sele ROBWYP
         appe blan
         repl NAZWISKO with znazimie,;
              PESEL with zPESEL,;
              MCWYP with etaty->MC,;
              DOWYPLATY with etaty->do_wyplaty,;
              PODATEK with etaty->podatek,;
              DOPIT4 with etaty->do_pit4
         sele ROBWYPZA
         go top
         do while .not.eof()
            sele ROBWYP
            if ROBWYPZA->RODZAJ=='W'
               repl WYPLACONO with ROBWYPZA->KWOTA,DATAWYPLA with ROBWYPZA->DATA
            endif
            if ROBWYPZA->RODZAJ=='Z'
               repl ZALICZKA with ROBWYPZA->KWOTA,DATAZALI with ROBWYPZA->DATA
            endif
            sele ROBWYPZA
            skip
            if .not.eof()
               sele ROBWYP
               appe blan
            endif
         enddo
         sele etaty
         skip
      enddo

*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
sele ROBWYP
go top
strona=0
if mcdo-mcod=0
   glowka=padc(' '+paras_np4+' ',71,' ')+padl([ okres: ]+str(mcod,2)+'.'+param_rok,24,' ')
else
   glowka=padc(' '+paras_np4+' ',71,' ')+padl([ okres od ]+str(mcod,2)+[ do ]+str(mcdo,2)+[.]+param_rok,24,' ')
endif
mon_drk([ö]+procname())
      _grupa1=int(strona/max(1,_druk_2-6))
      _grupa=.t.
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
kk3=mcwyp
kk1=substr(nazwisko,1,32)
kk2=pesel
kk2a=kk1+kk2
kk4=transform(dowyplaty,'@Z 999999.99')
kk5=strtran(dtoc(datawypla),'    .  .  ',space(10))
kk6=transform(wyplacono,'@Z 999999.99')
kk7=strtran(dtoc(datazali),'    .  .  ',space(10))
kk8=transform(zaliczka,'@Z 999999.99')
kk9=space(9)
kk10=transform(podatek,'@Z 999999.99')
kk11=strtran(substr(dopit4,1,4)+'.'+substr(dopit4,5,2),'    .  ',space(7))
store 0 to sumkk4mc,sumkk4,sumkk6mc,sumkk6,sumkk8mc,sumkk8,sumkk9mc,sumkk9,sumkk10mc,sumkk10,sumkklicz,sumkkliczm
store 0 to allkk4,allkk6,allkk8,allkk9,allkk10
*** wstawic gdy bedzie komplet petli***
do while .not.eof()
   do glnierozp4
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   k3=mcwyp
   k1=substr(nazwisko,1,32)
   k2=pesel
   k4=transform(dowyplaty,'@Z 999999.99')
   k5=strtran(dtoc(datawypla),'    .  .  ',space(10))
   k6=transform(wyplacono,'@Z 999999.99')
   k7=strtran(dtoc(datazali),'    .  .  ',space(10))
   k8=transform(zaliczka,'@Z 999999.99')
   k9=transform(val(kk4)-(sumkk6mc+sumkk8mc+val(k6)+val(k8)),'999999.99')
   k10=transform(podatek,'@Z 999999.99')
   k11=strtran(substr(dopit4,1,4)+'.'+substr(dopit4,5,2),'    .  ',space(7))
*  if sumkklicz=0.and.sumkkliczm=0
      mon_drk2('glnierozp4','stnierozp4',[ ]+k3+[ ]+k1+[ ]+k2+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+k10+[ ]+k11+[ ])
*  else
*     mon_drk2('glnierozp4','stnierozp4',[ ]+space(2)+[ ]+space(32)+[ ]+k2+[ ]+k4+[ ]+k5+[ ]+k6+[ ]+k7+[ ]+k8+[ ]+k9+[ ]+k10+[ ]+k11+[ ])
*  endif
   skip
   sumkk6mc=sumkk6mc+val(k6)
   sumkk8mc=sumkk8mc+val(k8)
   sumkklicz=sumkklicz+1
   if mcod<>mcdo
      sumkkliczm=sumkkliczm+1
   endif
   if (mcwyp<>kk3.and.len(alltrim(mcwyp))>0).or. len(alltrim(substr(nazwisko,1,32)+pesel))>0 .or. eof()
      if sumkklicz>1
         mon_drk2('glnierozp4','stnierozp4',space(37)+repl('-',92))
         mon_drk2('glnierozp4','stnierozp4',space(37)+kk2+[ ]+kk4+[ ]+space(10)+[ ]+transform(sumkk6mc,'999999.99')+[ ]+space(10)+[ ]+transform(sumkk8mc,'999999.99')+[ ]+transform(val(kk4)-(sumkk6mc+sumkk8mc),'999999.99')+[ ]+kk10+[ ]+kk11+[ ])
         mon_drk2('glnierozp4','stnierozp4',space(37)+repl('=',92))
         sumkk4=sumkk4+val(kk4)
         sumkk6=sumkk6+sumkk6mc
         sumkk8=sumkk8+sumkk8mc
         sumkk9=sumkk9+val(kk4)-(sumkk6mc+sumkk8mc)
         sumkk10=sumkk10+val(kk10)
         sumkk6mc=0
         sumkk8mc=0
         sumkklicz=0
      else
         sumkk4=sumkk4+val(kk4)
         sumkk6=sumkk6+sumkk6mc
         sumkk8=sumkk8+sumkk8mc
         sumkk10=sumkk10+val(kk10)
         sumkk6mc=0
         sumkk8mc=0
         sumkklicz=0
      endif
      if (mcwyp<>kk3.and.len(alltrim(mcwyp))>0) .or. eof()
*        if sumkkliczm>1
            mon_drk2('glnierozp4','stnierozp4',repl('-',129))
            mon_drk2('glnierozp4','stnierozp4',[ ]+k3+[ ]+space(32)+[ ]+space(11)+[ ]+transform(sumkk4,'999999.99')+[ ]+space(10)+[ ]+transform(sumkk6,'999999.99')+[ ]+space(10)+[ ]+transform(sumkk8,'999999.99')+[ ]+transform(sumkk4-(sumkk6+sumkk8),'999999.99')+[ ]+transform(sumkk10,'999999.99'))
*           mon_drk2('glnierozp4','stnierozp4',space(34)+kk2+[    ]+transform(sumkk4,'999999.99')+[ ]+space(10)+[ ]+transform(sumkk6,'999999.99')+[ ]+space(10)+[ ]+transform(sumkk8,'999999.99')+[ ]+transform(sumkk4-(sumkk6+sumkk8),'999999.99')+[ ]+transform(sumkk10,'999999.99'))
            mon_drk2('glnierozp4','stnierozp4',repl('=',129))
            allkk4=allkk4+sumkk4
            allkk6=allkk6+sumkk6
            allkk8=allkk8+sumkk8
            allkk10=allkk10+sumkk10
            sumkk4=0
            sumkk6=0
            sumkk8=0
            sumkk10=0
            sumkkliczm=0
*        else
*           allkk4=allkk4+sumkk4
*           allkk6=allkk6+sumkk6
*           allkk8=allkk8+sumkk8
*           allkk10=allkk10+sumkk10
*           sumkk4=0
*           sumkk6=0
*           sumkk8=0
*           sumkk10=0
*           sumkkliczm=0
*        endif
      endif
      kk3=mcwyp
      kk1=substr(nazwisko,1,32)
      kk2=pesel
      kk2a=kk1+kk2
      kk4=transform(dowyplaty,'@Z 999999.99')
      kk5=strtran(dtoc(datawypla),'    .  .  ',space(10))
      kk6=transform(wyplacono,'@Z 999999.99')
      kk7=strtran(dtoc(datazali),'    .  .  ',space(10))
      kk8=transform(zaliczka,'@Z 999999.99')
      kk9=space(9)
      kk10=transform(podatek,'@Z 999999.99')
      kk11=strtran(substr(dopit4,1,4)+'.'+substr(dopit4,5,2),'    .  ',space(7))
   endif
*  if kk2a==k1+k2
*     if mcwyp==k3
*     else
*     endif
*  else
*     mon_drk(space(34)+repl('-',95))
*     mon_drk(space(49)+kk4+[ ]+space(10)+[ ]+kk6+[ ]+space(10)+[ ]+kk8+[ ]+kk9+[ ]+kk10+[ ]+kk11+[ ])
*     mon_drk(repl('-',129))
*     strona=strona+3
*
*     store 0 to sumkk4,sumkk6mc,sumkk6,sumkk8mc,sumkk8,kk9,sumkk10
*
*     kk1=substr(nazwisko,1,32)
*     kk2=pesel
*     kk2a=kk1+kk2
*     kk3=mcwyp
*     kk4=transform(dowyplaty,'@Z 999999.99')
*     kk5=strtran(dtoc(datawypla),'    .  .  ',space(10))
*     kk6=transform(wyplacono,'@Z 999999.99')
*     kk7=strtran(dtoc(datazali),'    .  .  ',space(10))
*     kk8=transform(zaliczka,'@Z 999999.99')
*     kk9=space(9)
*     kk10=transform(podatek,'@Z 999999.99')
*     kk11=strtran(substr(dopit4,1,4)+'.'+substr(dopit4,5,2),'    .  ',space(7))
*  endif
   do stnierozp4
*  _numer=1
*  do case
*  case int(strona/max(1,_druk_2-6))#_grupa1
*       _numer=0
*       _grupa=.t.
*  other
*       _grupa=.f.
*  endcase
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
if mcod=mcdo
   mon_drk(repl('=',129))
endif
mon_drk(space(48)+transform(allkk4,'9999999.99')+[ ]+space(10)+transform(allkk6,'9999999.99')+[ ]+space(10)+transform(allkk8,'9999999.99')+transform(allkk4-(allkk6+allkk8),'9999999.99')+transform(allkk10,'9999999.99'))
mon_drk(repl('*',129))
mon_drk([])
mon_drk([                U&_z.ytkownik programu komputerowego])
mon_drk([        ]+dos_c(code()))
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
               mon_drk([ş])
               end
               if _czy_close
               close_()
               endif
***************************************************
proc glnierozp4
***************************************************
if _grupa.or._grupa1#int(strona/max(1,_druk_2-6))
   _grupa1=int(strona/max(1,_druk_2-6))
   _grupa=.f.
   nr_strony=nr_strony+1
   *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
   mon_drk([ FIRMA: ]+SYMBOL_FIR+[   ]+glowka+[      str.]+str(nr_strony,2))
   mon_drk([ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³MC³                                ³           ³  Kwota  ³  WYPLATY DOKONANE  ³ WYPLACONE ZALICZKI ³POZOSTALO³     PODATEK     ³])
   mon_drk([³wy³ N A Z W I S K O  i  I M I O N A³   PESEL   ³    do   ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ´   do    ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´])
   mon_drk([³pl³                                ³           ³ wyplaty ³   Dnia   ³  Kwota  ³   Dnia   ³  Kwota  ³ wyplaty ³Nierozlicz.w PIT4³])
   mon_drk([ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
*  strona=6
endif
***************************************************
proc stnierozp4
***************************************************
   _numer=1
   do case
   case int(strona/max(1,_druk_2-6))#_grupa1
        _numer=0
        _grupa=.t.
   other
        _grupa=.f.
   endcase
***************************************************
*func mon_drk2    - udostepniono w PROC2.prg
***************************************************
*para _glmondrk2,_stmondrk2,_trmondrk2
*do &_glmondrk2
*mon_drk(_trmondrk2)
*strona=strona+1
*do &_stmondrk2
*return
