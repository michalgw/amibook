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
private _t1,_t2,_t3,_t4,_t5,_t6,_t7,_t8,_t9,_t10,_t11,_t12,_t13,_t14,_t15
save screen to scrbor
begin sequence
      @ 1,47 say space(10)
      *-----parametry wewnetrzne-----
      _papsz=1
      _lewa=1
      _prawa=121
      _strona=.t.
      _czy_mon=.t.
      _czy_close=.t.
      czesc=1
      *------------------------------
      _szerokosc=121
      _koniec="del#[+].or.firma#ident_fir.or.strtran(mc+[.]+dzien,' ','0')<od_dnia_.or.strtran(mc+[.]+dzien,' ','0')>do_dnia_.or.NormalizujNipPL(nr_ident)<>NormalizujNipPL(od_kontr)"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      il_kontr=0
      od_dnia=ctod(param_rok+[.01.01])
      do_dnia=ctod(param_rok+'.'+substr(dtoc(date()),6))
      od_kontr=space(13)
      do_kontr=space(13)
      @ 21,2 clear to 22,76
      @ 21,2 say [Od dnia] get od_dnia pict '@D'
      @ 22,2 say [Do dnia] get do_dnia pict '@D'
      @ 21,21 say [Dla NIP......:] get od_kontr picture repl('!',13)
*      @ 22,21 say [Do kontrahenta] get do_kontr picture repl('!',40)
      read_()
      if lastkey()=27
         break
      endif
      od_kontr=alltrim(strtran(strtran(od_kontr,' ',''),'-',''))

*     od_kontr=alltrim(od_kontr)
*     od_kontr=strtran(od_kontr,' ','')
*     od_kontr=strtran(od_kontr,'-','')
      if od_dnia>do_dnia.or.year(od_dnia)#val(param_rok).or.year(do_dnia)#val(param_rok)
         kom(3,[*u],[ Nieprawid&_l.owy zakres ])
         break
      endif
      od_dnia_=substr(dtoc(od_dnia),6)
      do_dnia_=substr(dtoc(do_dnia),6)
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ö]+procname())
      k1=dtoc(od_dnia)
      k2=dtoc(do_dnia)
      mon_drk([ ZESTAWIENIE OBROT&__O.W Z KONTRAHENTEM  (dla NIP:]+od_kontr+[)  za okres od  ]+k1+[  do  ]+k2)
      mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
      mon_drk([³                                 ³   Data   ³   Numer  ³           N E T T O           ³          B R U T T O          ³])
      mon_drk([³       Kontrahent                ³ dokumentu³ dokumentu³    Przych&_o.d   ³     Rozch&_o.d   ³    Przych&_o.d   ³     Rozch&_o.d   ³])
      mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
      store 0 to s0_4,s0_5,s0_6,s0_7
      store 0 to s1_4,s1_5,s1_6,s1_7
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 1
      if zRYCZALT<>'T'.and.dostepex('OPER')
         index on del+firma+iif(strtran(mc+[.]+dzien,' ','0')>=od_dnia_.and.strtran(mc+[.]+dzien,' ','0')<=do_dnia_,[+],[-])+NormalizujNipPL(nr_ident)+mc+dzien to &raptemp
         if dostep('OPER')
            set inde to &raptemp
            seek [+]+ident_fir+'+'+od_kontr
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            if .not. &_koniec
               mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
               mon_drk([³                 O B R O T Y   Z   K S I &__E. G I                ³])
               mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
               _grupa1=NormalizujNipPL(nr_ident)
               store [] to _t1,_t2
               _grupa=.t.
               do while .not.&_koniec
                  if substr(numer,1,3)<>'RZ-' .and. substr(numer,1,3)<>'RS-'
                     if _grupa.or._grupa1#NormalizujNipPL(nr_ident)
                        _grupa1=NormalizujNipPL(nr_ident)
                        _grupa=.t.
                        *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                        il_kontr=0
                        store 0 to s1_4,s1_5,s1_6,s1_7
                        *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     endif
                     *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
                     il_kontr=il_kontr+1
                     k1=substr(nazwa,1,33)
                     k3=param_rok+[.]+mc+[.]+dzien
                     k3a=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer)
                     if WYR_tow+USLUGI>0
                        K4=iif(WYR_TOW+USLUGI>0,WYR_tow+USLUGI,0)
                        k5=0
                        K6=iif(WYR_TOW+USLUGI>0,WYR_tow+USLUGI,0)
                        k7=0
                     else
                        k4=0
                        K5=ZAKUP+UBOCZNE+WYNAGR_G+WYDATKI
                        k6=0
                        K7=ZAKUP+UBOCZNE+WYNAGR_G+WYDATKI
                     endif
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     s1_4=s1_4+k4
                     s1_5=s1_5+k5
                     s1_6=s1_6+k6
                     s1_7=s1_7+k7
                     kk4=kwota(k4,14,2)
                     kk5=kwota(k5,14,2)
                     kk6=kwota(k6,14,2)
                     kk7=kwota(k7,14,2)
                     if _grupa.or.k1#_t1
                        _grupa=.t.
                        _t1=k1
                     else
                        k1=space(len(k1))
                     endif
                     if _grupa.or.k2#_t2
                        _grupa=.t.
                        _t2=k2
                     else
                        k2=space(len(k2))
                     endif
                     mon_drk([ ]+k1+[ ]+strtran(k3,' ','0')+[ ]+k3a+[  ]+kk4+[  ]+kk5+[  ]+kk6+[  ]+kk7)
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
                  skip
                  _numer=1
                  if (substr(numer,1,3)<>'RZ-' .and. substr(numer,1,3)<>'RS-'.AND.NormalizujNipPL(nr_ident)#_grupa1).or.&_koniec
                     _numer=0
                  endif
                  _grupa=.f.
                  if _numer<1
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     if il_kontr>1
                        mon_drk([               R a z e m   k o n t r a h e n t            ]+kwota(s1_4,14,2)+[  ]+kwota(s1_5,14,2)+[  ]+kwota(s1_6,14,2)+[  ]+kwota(s1_7,14,2))
                        mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
                     endif
                     s0_4=s0_4+s1_4
                     s0_5=s0_5+s1_5
                     s0_6=s0_6+s1_6
                     s0_7=s0_7+s1_7
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
               enddo
            endif
         endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      select 1
      if dostepex('REJS')
         index on del+firma+iif(strtran(mc+[.]+dzien,' ','0')>=od_dnia_.and.strtran(mc+[.]+dzien,' ','0')<=do_dnia_,[+],[-])+NormalizujNipPL(nr_ident)+mc+dzien to &raptemp
         if dostep('REJS')
            set inde to &raptemp
            seek [+]+ident_fir+'+'+od_kontr
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            if .not. &_koniec
               mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
               mon_drk([³     O B R O T Y   Z   R E J E S T R U   S P R Z E D A &__Z. Y    ³])
               mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
               _grupa1=NormalizujNipPL(nr_ident)
               store [] to _t1,_t2
               _grupa=.t.
               do while .not.&_koniec
                  if _grupa.or._grupa1#NormalizujNipPL(nr_ident)
                     _grupa1=NormalizujNipPL(nr_ident)
                     _grupa=.t.
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     il_kontr=0
                     store 0 to s1_4,s1_5,s1_6,s1_7
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
                  *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
                  il_kontr=il_kontr+1
                  k1=substr(nazwa,1,33)
                  k3=param_rok+[.]+mc+[.]+dzien
                  k3a=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer)
                  zm1=WARTZW+WART00+WART02+WART07+WART22+WART12
                  zm2=WARTZW+WART00+WART02+WART07+WART22+WART12+VAT02+VAT07+VAT22+VAT12
*                 if zm1<>0
                     K4=zm1
                     k5=0
                     K6=zm2
                     k7=0
*                 endif
                  skip
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  s1_4=s1_4+k4
                  s1_5=s1_5+k5
                  s1_6=s1_6+k6
                  s1_7=s1_7+k7
                  kk4=kwota(k4,14,2)
                  kk5=kwota(k5,14,2)
                  kk6=kwota(k6,14,2)
                  kk7=kwota(k7,14,2)
                  if _grupa.or.k1#_t1
                     _grupa=.t.
                     _t1=k1
                  else
                     k1=space(len(k1))
                  endif
                  if _grupa.or.k2#_t2
                     _grupa=.t.
                     _t2=k2
                  else
                     k2=space(len(k2))
                  endif
                  mon_drk([ ]+k1+[ ]+strtran(k3,' ','0')+[ ]+k3a+[  ]+kk4+[  ]+kk5+[  ]+kk6+[  ]+kk7)
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  _numer=1
                  do case
                  CASE NormalizujNipPL(nr_ident)#_grupa1.or.&_koniec
                       _numer=0
                  endcase
                  _grupa=.f.
                  if _numer<1
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     if il_kontr>1
                        mon_drk([               R a z e m   k o n t r a h e n t            ]+kwota(s1_4,14,2)+[  ]+kwota(s1_5,14,2)+[  ]+kwota(s1_6,14,2)+[  ]+kwota(s1_7,14,2))
                     endif
                     mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
                     s0_4=s0_4+s1_4
                     s0_5=s0_5+s1_5
                     s0_6=s0_6+s1_6
                     s0_7=s0_7+s1_7
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
               enddo
            endif
         endif
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      select 1
      if dostepex('REJZ')
         index on del+firma+iif(strtran(mc+[.]+dzien,' ','0')>=od_dnia_.and.strtran(mc+[.]+dzien,' ','0')<=do_dnia_,[+],[-])+NormalizujNipPL(nr_ident)+mc+dzien to &raptemp
         if dostep('REJZ')
            set inde to &raptemp
            seek [+]+ident_fir+'+'+od_kontr
            *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            if .not. &_koniec
               mon_drk([ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿])
               mon_drk([³       O B R O T Y   Z   R E J E S T R U   Z A K U P &__O. W      ³])
               mon_drk([ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ])
               _grupa1=NormalizujNipPL(nr_ident)
               store [] to _t1,_t2
               _grupa=.t.
               do while .not.&_koniec
                  if _grupa.or._grupa1#NormalizujNipPL(nr_ident)
                     _grupa1=NormalizujNipPL(nr_ident)
                     _grupa=.t.
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     il_kontr=0
                     store 0 to s1_4,s1_5,s1_6,s1_7
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
                  *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
                  il_kontr=il_kontr+1
                  k1=substr(nazwa,1,33)
                  k3=param_rok+[.]+mc+[.]+dzien
                  k3a=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer)
                  zm1=WARTZW+WART00+WART07+WART22+WART12+WART02
                  zm2=WARTZW+WART00+WART07+WART22+WART12+WART02+VAT07+VAT22+VAT02+VAT12
*                 if zm1<>0
                     K4=0
                     k5=zm1
                     K6=0
                     k7=zm2
*                 endif
                  skip
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@ REKORD @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  s1_4=s1_4+k4
                  s1_5=s1_5+k5
                  s1_6=s1_6+k6
                  s1_7=s1_7+k7
                  kk4=kwota(k4,14,2)
                  kk5=kwota(k5,14,2)
                  kk6=kwota(k6,14,2)
                  kk7=kwota(k7,14,2)
                  if _grupa.or.k1#_t1
                     _grupa=.t.
                     _t1=k1
                  else
                     k1=space(len(k1))
                  endif
                  if _grupa.or.k2#_t2
                     _grupa=.t.
                     _t2=k2
                  else
                     k2=space(len(k2))
                  endif
                  mon_drk([ ]+k1+[ ]+strtran(k3,' ','0')+[ ]+k3a+[  ]+kk4+[  ]+kk5+[  ]+kk6+[  ]+kk7)
                  *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  _numer=1
                  do case
                  CASE NormalizujNipPL(nr_ident)#_grupa1.or.&_koniec
                       _numer=0
                  endcase
                  _grupa=.f.
                  if _numer<1
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                     if il_kontr>1
                        mon_drk([               R a z e m   k o n t r a h e n t            ]+kwota(s1_4,14,2)+[  ]+kwota(s1_5,14,2)+[  ]+kwota(s1_6,14,2)+[  ]+kwota(s1_7,14,2))
                     endif
                     mon_drk([ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ])
                     s0_4=s0_4+s1_4
                     s0_5=s0_5+s1_5
                     s0_6=s0_6+s1_6
                     s0_7=s0_7+s1_7
                     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                  endif
               enddo
            endif
         endif
      endif
      use
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([                                   O g &_o. l e m            ]+kwota(s0_4,14,2)+[  ]+kwota(s0_5,14,2)+[  ]+kwota(s0_6,14,2)+[  ]+kwota(s0_7,14,2))
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      mon_drk([ş])
end
rest screen from scrbor
if _czy_close
   close_()
endif

IF File( RAPTEMP + '.cdx' )
   DELETE FILE &RAPTEMP..cdx
ENDIF
