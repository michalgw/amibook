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
      _prawa=80
      _strona=.f.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=80
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
      inde on dtos(DATA)+mc to ROBWYPZA

*      sele prac

      paras_wwd='Wyp&_l.aty dokonane w okresie'
      if .not.file([param_sp.mem])
         save to param_sp all like paras_*
      else
         restore from param_sp addi
      endif
      zparas_wwd=paras_wwd+space(40-len(paras_wwd))
      data_od=ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.01')
      data_do=ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.'+strtran(str(lastdayom(data_od),2),' ','0'))
      @ 23,0  clear to 23,79
      @ 23,0 say [Dzie&_n. od] get data_od
      @ 23,20 say [do] get data_do
      @ 23,36 say [Nag&_l.&_o.wek] get zparas_wwd pict repl('X',40)
      read_()
      if lastkey()=27
         break
      endif
      paras_wwd=alltrim(zparas_wwd)
      save to param_sp all like paras_*
      if data_od>data_do
         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
         break
      endif

      sele wyplaty
      seek '+'+ident_fir
      if found()
         do while .not.eof().and.del='+'.and.firma==ident_fir
            if data_wyp>=data_od .and. data_wyp<=data_do
               sele ROBWYPZA
               appe blan
               repl DATA with WYPLATY->DATA_WYP,RODZAJ with 'W',KWOTA with WYPLATY->KWOTA,;
                    IDENT with WYPLATY->IDENT,MC with WYPLATY->MC
            endif
            sele wyplaty
            skip
         enddo
      endif
      sele zaliczki
      seek '+'+ident_fir
      if found()
         do while .not.eof().and.del='+'.and.firma==ident_fir
            if data_wyp>=data_od .and. data_wyp<=data_do
               sele ROBWYPZA
               appe blan
               repl DATA with ZALICZKI->DATA_WYP,RODZAJ with 'Z',KWOTA with ZALICZKI->KWOTA,;
                    IDENT with ZALICZKI->IDENT,MC with ZALICZKI->MC
            endif
            sele zaliczki
            skip
         enddo
      endif

      sele prac
      set orde to 4

      sele ROBWYPZA
      go top

      do while .not. eof()
         sele prac
         seek val(robwypza->ident)
         if found()
            znazimie=alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2)
            zpesel=pesel
         else
            znazimie='BRAK PRACOWNIKA W BAZIE DANYCH  '
            zpesel='? ? ? ? ? ?'
         endif

         sele ROBWYP
         appe blan
         repl NAZWISKO with znazimie,;
              PESEL with zPESEL,;
              MCWYP with robwypza->MC
         if ROBWYPZA->RODZAJ=='W'
            repl WYPLACONO with ROBWYPZA->KWOTA,DATAWYPLA with ROBWYPZA->DATA,DATA with ROBWYPZA->DATA
         endif
         if ROBWYPZA->RODZAJ=='Z'
            repl ZALICZKA with ROBWYPZA->KWOTA,DATAZALI with ROBWYPZA->DATA,DATA with ROBWYPZA->DATA
         endif
         sele robwypza
         skip
      enddo

*@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
sele ROBWYP
inde on dtos(DATA)+mcwyp+nazwisko+pesel to robwyp
go top
strona=0
glowka=padc(alltrim(paras_wwd)+[ ]+dtoc(data_od)+[-]+dtoc(data_do),62,' ')
mon_drk([ö]+procname())
      _grupa1=int(strona/max(1,_druk_2-6))
      _grupa=.t.
*@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
kk3a=dtoc(data)
kk3=mcwyp
kk1=substr(nazwisko,1,32)
kk2=pesel
kk2a=kk1+kk2
kk6=transform(wyplacono,'@Z 999999.99')
kk8=transform(zaliczka,'@Z 999999.99')
store 0 to sumkk6mc,sumkk6,sumkk8mc,sumkk8,sumkklicz,sumkkliczm
store 0 to allkk6,allkk8
*** wstawic gdy bedzie komplet petli***
do while .not.eof()
   do glwypldnia
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   k3a=dtoc(data)
   k3=mcwyp
   k1=substr(nazwisko,1,32)
   k2=pesel
   k6=transform(wyplacono,'@Z 999999.99')
   k8=transform(zaliczka,'@Z 999999.99')
   mon_drk2('glwypldnia','stwypldnia',[ ]+k3a+[ ]+k3+[ ]+k1+[ ]+k2+[ ]+k6+[ ]+k8+[ ])
   skip
   sumkk6mc=sumkk6mc+val(k6)
   sumkk8mc=sumkk8mc+val(k8)
   do stwypldnia
   *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
enddo
*@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
mon_drk(repl('=',80))
mon_drk(space(59)+transform(sumkk6mc,'9999999.99')+transform(sumkk8mc,'9999999.99'))
mon_drk(space(50)+'=====RAZEM====='+transform(sumkk6mc+sumkk8mc,'9999999.99'))
mon_drk(repl('*',80))
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
proc glwypldnia
***************************************************
if _grupa.or._grupa1#int(strona/max(1,_druk_2-6))
   _grupa1=int(strona/max(1,_druk_2-6))
   _grupa=.f.
   nr_strony=nr_strony+1
   *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
   mon_drk([ ]+SYMBOL_FIR+[ ]+glowka+[ s.]+str(nr_strony,1))
   mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿])
   mon_drk([³   Data   ³MC³                                ³           ³  Jako   ³   Jako  ³])
   mon_drk([³ dokonanej³wy³ N A Z W I S K O  i  I M I O N A³   PESEL   ³         ³         ³])
   mon_drk([³  wyplaty ³pl³                                ³           ³ wyplata ³ zaliczka³])
   mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ])
*  strona=6
endif
***************************************************
proc stwypldnia
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
