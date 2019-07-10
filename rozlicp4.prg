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
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15,koniep
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      nr_strony=0
      _papsz=1
      _lewa=1
      _prawa=87
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=87
      _koniec="del#[+].or.firma#ident_fir"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
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

      paras_rp4='Rozliczone w PIT-4'
      if .not.file([param_sp.mem])
         save to param_sp all like paras_*
      else
         restore from param_sp addi
      endif
      zparas_rp4=paras_rp4+space(40-len(paras_rp4))
*      mcod=val(miesiac)
*      mcdo=val(miesiac)
      zdopit4=param_rok+strtran(miesiac,' ','0')
      @ 23,0  clear to 23,79
      @ 23,0 say [Okres PIT-4] get zdopit4 pict '@R 9999.99'
*      @ 23,10 say [do] get mcdo
      @ 23,22 say [Nag&_l.&_o.wek] get zparas_rp4 pict repl('X',40)
      read_()
      if lastkey()=27
         break
      endif
      paras_rp4=alltrim(zparas_rp4)
      save to param_sp all like paras_*
*      if mcod>mcdo
*         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
*         break
*      endif
      sele etaty
      set filt to (DO_WYPLATY<>0.or.(BRUT_RAZEM-WAR_PSUM)<>0.or.PODATEK<>0).and.do_pit4==zdopit4
***********************
*      (DOD.and.DDO)
***********************
*      set filt to do_pit4==zdopit4
      go top

      sele prac

      do while .not. &_koniec .and. .not. eof()
         sele etaty
         seek '+'+ident_fir+str(prac->rec_no,5)
         if found()
            znazimie=alltrim(prac->nazwisko)+' '+alltrim(prac->imie1)+' '+alltrim(prac->imie2)
            zpesel=prac->pesel
            do while del+firma+ident=='+'+ident_fir+str(prac->rec_no,5) .and. .not. eof()
               sele ROBWYP
               appe blan
               repl NAZWISKO with znazimie,;
                    PESEL with zPESEL,;
                    MCWYP with etaty->MC,;
                    DOWYPLATY with etaty->do_wyplaty,;
                    WYPLACONO with etaty->brut_razem-etaty->war_psum,;
                    PODATEK with etaty->podatek,;
                    DOPIT4 with etaty->do_pit4
               sele etaty
               skip
            enddo
         endif
         sele prac
         skip
      enddo

*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
sele ROBWYP
go top
strona=0
glowka=padc(alltrim(paras_rp4)+[ za ]+transform(zdopit4,'@R 9999.99'),61,' ')
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
   do glrozlicp4
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
   if sumkklicz=0
      mon_drk2('glrozlicp4','strozlicp4',[ ]+k1+[ ]+k2+[ ]+k3+[ ]+k6+[ ]+k4+[ ]+k10+[ ]+k11+[ ])
   else
      mon_drk2('glrozlicp4','strozlicp4',[ ]+space(32)+[ ]+space(11)+[ ]+k3+[ ]+k6+[ ]+k4+[ ]+k10+[ ]+k11+[ ])
   endif
   skip
   sumkk6mc=sumkk6mc+val(k6)
   sumkk4mc=sumkk4mc+val(k4)
   sumkk10mc=sumkk10mc+val(k10)
   sumkklicz=sumkklicz+1
   if substr(nazwisko,1,32)+pesel<>kk1+kk2 .or. eof()
      if sumkklicz>1
         mon_drk2('glrozlicp4','strozlicp4',space(46)+repl('-',41))
         mon_drk2('glrozlicp4','strozlicp4',[ ]+space(32)+[ ]+kk2+[ ]+space(2)+[ ]+transform(sumkk6mc,'999999.99')+[ ]+transform(sumkk4mc,'999999.99')+[ ]+transform(sumkk10mc,'999999.99'))
         mon_drk2('glrozlicp4','strozlicp4',space(34)+repl('=',53))
         sumkk6=sumkk6+sumkk6mc
         sumkk4=sumkk4+sumkk4mc
         sumkk10=sumkk10+sumkk10mc
         sumkk6mc=0
         sumkk4mc=0
         sumkk10mc=0
         sumkklicz=0
      else
         sumkk6=sumkk6+sumkk6mc
         sumkk4=sumkk4+sumkk4mc
         sumkk10=sumkk10+sumkk10mc
         sumkk6mc=0
         sumkk4mc=0
         sumkk10mc=0
         sumkklicz=0
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
   do strozlicp4
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk(repl('=',87))
mon_drk2('glrozlicp4','strozlicp4',[ ]+space(32)+[ ]+space(11)+[ ]+space(2)+transform(sumkk6,'9999999.99')+transform(sumkk4,'9999999.99')+transform(sumkk10,'9999999.99'))
*mon_drk(space(48)+transform(allkk4,'9999999.99')+[ ]+space(10)+transform(allkk6,'9999999.99')+[ ]+space(10)+transform(allkk8,'9999999.99')+transform(allkk4-(allkk6+allkk8),'9999999.99')+transform(allkk10,'9999999.99'))
mon_drk(repl('*',87))
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
proc glrozlicp4
***************************************************
if _grupa.or._grupa1#int(strona/max(1,_druk_2-6))
   _grupa1=int(strona/max(1,_druk_2-6))
   _grupa=.f.
   nr_strony=nr_strony+1
   *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
   mon_drk([ FIRMA:]+SYMBOL_FIR+[ ]+glowka+[ str.]+str(nr_strony,2))
   mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³                                ³           ³MC³  Kwota  ³  Kwota  ³     PODATEK     ³])
   mon_drk([³ N A Z W I S K O  i  I M I O N A³   PESEL   ³wy³    do   ³    do   ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ´])
   mon_drk([³                                ³           ³pl³  PIT-4  ³ wyplaty ³  Kwota  ³ w PIT4³])
   mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ])
*  strona=6
endif
***************************************************
proc strozlicp4
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
