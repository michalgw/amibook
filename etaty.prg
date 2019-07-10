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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Etaty( mieskart )

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,kluc,ins,nr_rec,wiersz,f10,rec,fou,mieslok
public z_dowyp
zData_wwyp=date()
zkwota_wwyp=0
mieslok=mieskart
for x=1 to 12
    xx=strtran(str(x,2),' ','0')
    zK_WYP&XX=0
    zK_ZAL&XX=0
    zDO_PIT4&XX='    .  '
    zD_ZAL&XX=ctod('    .  .  ')
next
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '        K A R T O T E K I   W Y N A G R O D Z E &__N.   P R A C O W N I K &__O. W       '
@  4, 0 say 'ÚÄÄÄÄÄWyp&_l.a&_c. wszystkim...ÄÄÄÄÄ¿ Przyj&_e.to:             Zwolniono.:               '
@  5, 0 say '³                             ³ Odlicza&_c. podatek:                               '
@  6, 0 say '³                             ³ Wykszta&_l.c:                                      '
@  7, 0 say '³                             ³ Zaw&_o.d....:                                      '
@  8, 0 say '³                             ³ M-c PRZYCH. DO WYP&__L.A. Wyp&_l.aty Wp&_l..podat. Do PIT4'
@  9, 0 say '³                             ³  1                                              '
@ 10, 0 say '³                             ³  2                                              '
@ 11, 0 say '³                             ³  3                                              '
@ 12, 0 say '³                             ³  4                                              '
@ 13, 0 say '³                             ³  5                                              '
@ 14, 0 say '³                             ³  6                                              '
@ 15, 0 say '³                             ³  7                                              '
@ 16, 0 say '³                             ³  8                                              '
@ 17, 0 say '³                             ³  9                                              '
@ 18, 0 say '³                             ³ 10                                              '
@ 19, 0 say '³                             ³ 11                                              '
@ 20, 0 say '³                             ³ 12                                              '
@ 21, 0 say 'ÀÄ(       )ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙSUMA                                             '
@ 22, 0 say ' UWAGI:                                                                         '
ColInf()
@  4, 7 say 'y'
@  8,54 say 'W'
@  8,66 say 'p'
@  8,79 say '4'
set colo to
*ColStd()
*############################### OTWARCIE BAZ ###############################
select 5
do while.not.dostep('ZALICZKI')
enddo
do setind with 'ZALICZKI'
seek [+]+ident_fir
select 4
do while.not.dostep('WYPLATY')
enddo
do setind with 'WYPLATY'
seek [+]+ident_fir
select 3
do while.not.dostep('NIEOBEC')
enddo
do setind with 'NIEOBEC'
seek [+]+ident_fir
select 2
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
seek [+]+ident_fir
select 1
do while.not.dostep('PRAC')
enddo
do setind with 'PRAC'
set orde to 2
SET FILTER TO prac->aktywny == 'T'
seek [+]+ident_fir+[+]
if eof().or.del#'+'.or.firma#ident_fir.or.status>'U'
   kom(3,[*u],[ Brak pracownik&_o.w etatowych ])
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=5
_col_l=1
_row_d=20
_col_p=29
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,13,247,75,107,77,109,7,28,80,87,89,112,119,121,52]
_top=[firma#ident_fir.or.status>'U']
_bot=[del#'+'.or.firma#ident_fir.or.status>'U']
_stop=[+]+ident_fir+[+]
_sbot=[+]+ident_fir+[+]+[þ]
_proc=[say41e()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say41es]
_disp=.t.
_cls=''
*----------------------
kl=0
siacpla='  '
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   case kl=13
        save scre to robs
        if empty(data_przy)
           kom(3,[*u],[ Brak daty przyj&_e.cia do pracy ])
        else
           do etaty1
        endif
        rest scre from robs
   case kl=107.or.kl=75
        save scre to robs
        Kartot_W( mieslok )
        rest scre from robs
   *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                                       '
        p[ 2]='  ['+chr(24)+'/'+chr(25)+']...........poprzedni/nast&_e.pny pracownik                         '
        p[ 3]='  [Home/End]......pierwszy/ostatni pracownik                           '
        p[ 4]='  [Enter].........ustalenie p&_l.acy miesi&_e.cznej                          '
        p[ 5]='  [M].............modyfikacja danych kadrowych                         '
        if mieslok='C'
           p[ 6]='  [K].............kartoteka wynagrodze&_n. - ca&_l.y rok                     '
        else
           p[ 6]='  [K].............kartoteka dodruk za m-c '+mieslok+'                           '
        endif
        p[ 7]='  [Y].............dokonywane wyp&_l.aty - aktualizacja grupowa            '
        p[ 8]='  [W].............dokonywane wyp&_l.aty/zaliczki - aktualizacja wybranego '
        p[ 9]='  [P].............data wp&_l.aty zaliczki na podatek dochodowy            '
        p[10]='  [4].............okres PIT-4 i PIT-11/8B w kt&_o.rym uwzgl&_e.dni&_c. podatek   '
        p[11]='  [Esc]...........wyj&_s.cie                                              '
        p[12]='                                                                       '
        *---------------------------------------
        set color to i
        i=20
        j=24
        do while i>0
           if type('p[i]')#[U]
              center(j,p[i])
              j=j-1
           endif
           i=i-1
        enddo
        set color to
        pause(0)
        if lastkey()#27.and.lastkey()#28
           keyboard chr(lastkey())
        endif
        restore screen from scr_
        _disp=.f.
   case kl=77.or.kl=109
        ColStb()
        center(23,[þ                       þ])
        ColSta()
        center(23,[M O D Y F I K A C J A])
        ColStd()
        zDATA_PRZY=DATA_PRZY
        zDATA_ZWOL=DATA_ZWOL
        zODLICZENIE=ODLICZENIE
        zWYKSZTALC=WYKSZTALC
        zZAWOD_WYU=ZAWOD_WYU
        zUWAGI=UWAGI
        @  4,42 get zdata_przy pict '@D' valid .not.empty(zdata_przy)
        @  4,68 get zdata_zwol pict '@D'
        @  5,49 get zodliczenie pict '!' valid vodlicz()
        @  6,43 get zwyksztalc pict '@S37 '+repl('X',40)
        @  7,43 get zzawod_wyu pict '@S37 '+repl('X',40)
        @ 22,8 get zuwagi
        set curs on
        read
        set curs off
        if lastkey()=13
           do BLOKADAR
           repl_([DATA_PRZY],zDATA_PRZY)
           repl_([DATA_ZWOL],zDATA_ZWOL)
           repl_([ODLICZENIE],zODLICZENIE)
           repl_([WYKSZTALC],zWYKSZTALC)
           repl_([ZAWOD_WYU],zZAWOD_WYU)
           repl_([UWAGI],zUWAGI)
           unlock
        endif
        @ 23,0
   case kl=87.or.kl=119
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               zSUMA_WYP=transform(zK_WYP&XX+zK_ZAL&XX,'99999.99')
               @ 8+x,53 prompt zSUMA_WYP
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
              _tak='P'
              _mieda_=strtran(str(mieda,2),' ','0')
              save scre to scr_sklad
              @ 11,40 clear to 19,75
              @ 11,40 to 19,75
              @ 12,41 say '  Wprowadzanie wyplat dokonanych  '
              @ 13,41 say '         za okres 9999.99         '
              @ 14,41 say 'Suma wyplaconych zaliczek.'+transform(zK_ZAL&_mieda_,'99999.99')
              @ 15,41 say 'Suma wyplaconych plac.....'+transform(zK_WYP&_mieda_,'99999.99')
              @ 16,41 say 'RAZEM wyplacono...........'+transform(zK_WYP&_mieda_+zK_ZAL&_mieda_,'99999.99')
              @ 17,41 say '                                  '
              @ 18,41 say 'Wprowadzasz Zaliczke/Place (Z/P) !'
              set colo to w+
              @ 13,59 say param_rok+'.'+_mieda_
              @ 14,67 say transform(zK_ZAL&_mieda_,'99999.99')
              @ 15,67 say transform(zK_WYP&_mieda_,'99999.99')
              @ 16,67 say transform(zK_WYP&_mieda_+zK_ZAL&_mieda_,'99999.99')
              @ 18,74 get _tak pict '!' valid _tak$'ZP'
              set conf on
              read
              set conf off
              if lastkey()=13
                 if _tak=='P'
                    do wyplaty
                 else
                    do zaliczki
                 endif
              endif
              sele prac
              rest scre from scr_sklad
              do say41es
           endif
        enddo
   case kl=122.or.kl=90
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               zSUMA_ZAL=transform(zK_ZAL&XX,'99999.99')
               @ 8+x,63 prompt zSUMA_ZAL
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
              save scre to scr_sklad
              do zaliczki
              sele prac
              rest scre from scr_sklad
              do say41es
           endif
        enddo
   case kl=80.or.kl=112
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               zDATA_ZAL=dtoc(zD_ZAL&XX)
               @ 8+x,62 prompt zDATA_ZAL
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
*               zDATA_ZAL=zD_ZAL&XX
               @ 8+mieda,62 get zD_ZAL&XX pict '@D'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([DATA_ZAL],zD_ZAL&XX)
                     unlock
                  endif
                  _pisac=tnesc([*i],[   Czy wpisa&_c. tak&_a. sam&_a. dat&_e. innym pracownikom firmy ? (T/N)   ])
                  if _pisac
                     sele prac
                     set orde to 4
                     sele etaty
                     set orde to 2
                     go top
                     kluc=[+]+ident_fir+str(mieda,2)
                     seek kluc
                     if found()
                        do while .not.eof().and.del+firma+mc==kluc
                           sele prac
                           seek val(etaty->ident)
                           if found() .and. del=='+'.and.firma==ident_fir.and.rec_no=val(etaty->ident).and.status<='U'
                              sele etaty
                              do BLOKADAR
                              repl_([DATA_ZAL],zD_ZAL&XX)
                              unlock
                           endif
                           sele etaty
                           skip
                        enddo
                     endif
                     set orde to 1
                     go top
                     sele prac
                     set orde to 2
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo

   case kl=121.or.kl=89
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        ColDlg()
        _miewyp=mieda
        _dzienwyp=eom(ctod(param_rok+'.'+str(_miewyp,2)+'.'+'01'))
        _dopit4=substr(dtos(_dzienwyp),1,6)
        _sposob=1
        _sposproc=100
        _sposwart=0
        _tak=' '
        save scre to scr_sklad
        @  8,40 clear to 21,75
        @  8,40 to 21,75
        @  9,41 say '  Nanie&_s.&_c. wyp&_l.aty dla wszystkich  '
        @ 11,41 say 'Wyp&_l.aty za miesi&_a.c..........:99   '
        @ 12,41 say 'Wyp&_l.acono dnia.........:9999.99.99'
        @ 13,41 say 'Uwzgl&_e.dni&_c. w PIT-4 za..:9999.99   '
        @ 15,41 say ' W jaki spos&_o.b nanie&_s.c (1/2/3):9  '
        @ 16,41 say '1.kwoty pozosta&_l.e do wyp&_l.aty      '
        @ 17,41 say '2.% kwoty pozosta&_l.ej do wyp&_l.a.:999'
        @ 18,41 say '3.okre&_s.lona wskazana kwota..:99999'
        @ 20,41 say '     ZATWIERDZAM (Tak/Nie):!      '
        @ 11,70 get _miewyp pict '99' range 1,12
        @ 12,65 get _dzienwyp pict '@D' when v_dzienwyp()
        @ 13,65 get _dopit4 pict '@R 9999.99' when v_dopit4()
        @ 15,72 get _sposob pict '9' range 1,3
        @ 17,72 get _sposproc pict '999' range 0,100 when _sposob=2
        @ 18,70 get _sposwart pict '99999' range 0,99999 when _sposob=3
        @ 20,68 get _tak pict '!' valid _tak$'TN'
        set conf on
        read
        set conf off
        if lastkey()=13 .and. _tak=='T'
           mmmie=str(_miewyp,2)
           do case
           case _sposob=1
                ColInf()
                @ 24,0
                Center(24,'Prosz&_e. czeka&_c....')
                sele prac
                nurek_=recno()
                seek [+]+ident_fir+[+]
                do while .not. eof().and.del=='+'.and.firma==ident_fir.and.status<='U'
                   _zident_=str(rec_no,5)
                   sele ETATY
                   seek [+]+ident_fir+_zident_+mmmie
                   z_dowyp=DO_WYPLATY
                   do inswyp
                   zdata_wwyp=_dzienwyp
                   if zkwota_wwyp>0.0
                      ins=.t.
                      do zapiszwyp
                      sele ETATY
                      do BLOKADAR
                      repl_([DO_PIT4],_dopit4)
                      commit_()
                      unlock
                   endif
                   sele prac
                   skip
                enddo
                go nurek_
           case _sposob=2
                if _sposproc>0
                   ColInf()
                   @ 24,0
                   Center(24,'Prosz&_e. czeka&_c....')
                   sele prac
                   nurek_=recno()
                   seek [+]+ident_fir+[+]
                   do while .not. eof().and.del=='+'.and.firma==ident_fir.and.status<='U'
                      _zident_=str(rec_no,5)
                      sele ETATY
                      seek [+]+ident_fir+_zident_+mmmie
                      z_dowyp=DO_WYPLATY
                      do inswyp
                      zdata_wwyp=_dzienwyp
                      if zkwota_wwyp>0.0
                         if _round(zkwota_wwyp*(_sposproc/100),2)>0.0 .and. min(zkwota_wwyp,_round(zkwota_wwyp*(_sposproc/100),2))>0.0
                            zkwota_wwyp=min(zkwota_wwyp,_round(zkwota_wwyp*(_sposproc/100),2))
                            ins=.t.
                            do zapiszwyp
                            sele ETATY
                            do BLOKADAR
                            repl_([DO_PIT4],_dopit4)
                            commit_()
                            unlock
                         endif
                      endif
                      sele prac
                      skip
                   enddo
                   go nurek_
                else
                   kom(5,'*u','Podano 0%. Nie naniesiono wyp&_l.at.')
                endif
           case _sposob=3
                if _sposwart>0
                   ColInf()
                   @ 24,0
                   Center(24,'Prosz&_e. czeka&_c....')
                   sele prac
                   nurek_=recno()
                   seek [+]+ident_fir+[+]
                   do while .not. eof().and.del=='+'.and.firma==ident_fir.and.status<='U'
                      _zident_=str(rec_no,5)
                      sele ETATY
                      seek [+]+ident_fir+_zident_+mmmie
                      z_dowyp=DO_WYPLATY
                      do inswyp
                      zdata_wwyp=_dzienwyp
                      if zkwota_wwyp>0.0
                         if min(zkwota_wwyp,_sposwart)>0.0
                            zkwota_wwyp=min(zkwota_wwyp,_sposwart)
                            ins=.t.
                            do zapiszwyp
                            sele ETATY
                            do BLOKADAR
                            repl_([DO_PIT4],_dopit4)
                            commit_()
                            unlock
                         endif
                      endif
                      sele prac
                      skip
                   enddo
                   go nurek_
                else
                   kom(5,'*u','Podano kwot&_e. 0z&_l.. Nie naniesiono wyp&_l.at.')
                endif
           endcase
        endif
        ColStd()
        @ 24,0
        sele prac
        rest scre from scr_sklad
        do say41es
   case kl=52
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
*               zDO_PIT4=transform(zK_WYP&XX,'99999.99')
               @ 8+x,73 prompt transform(zDO_PIT4&XX,'@R 9999.99')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
*              save scre to scr_sklad
*              do wyplaty
*              sele prac
*              rest scre from scr_sklad
*              do say41es

               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
*               SUMA_WYP=zK_WYP&XX
               @ 8+mieda,73 get zDO_PIT4&XX pict '@R 9999.99'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([DO_PIT4],zDO_PIT4&XX)
                     unlock
                  endif
                  _pisac=tnesc([*i],[   Czy wpisa&_c. tak&_a. sam&_a. dat&_e. innym pracownikom firmy ? (T/N)   ])
                  if _pisac
                     sele prac
                     set orde to 4
                     sele etaty
                     set orde to 2
                     go top
                     kluc=[+]+ident_fir+str(mieda,2)
                     seek kluc
                     if found()
                        do while .not.eof().and.del+firma+mc==kluc
                           sele prac
                           seek val(etaty->ident)
                           if found() .and. del=='+'.and.firma==ident_fir.and.rec_no=val(etaty->ident).and.status<='U'
                              sele etaty
                              do BLOKADAR
                              repl_([DO_PIT4],zDO_PIT4&XX)
                              unlock
                           endif
                           sele etaty
                           skip
                        enddo
                     endif
                     set orde to 1
                     go top
                     sele prac
                     set orde to 2
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say41e
znazwisko=padr(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),29)
return znazwisko
*##############################################################################
procedure say41es
clear type
set color to +w
@  4,42 say data_przy
@  4,68 say data_zwol
@  5,49 say iif(odliczenie='T','Tak','Nie')
@  6,43 say substr(wyksztalc,1,37)
@  7,43 say substr(zawod_wyu,1,37)
zidp=str(rec_no,5)
sele etaty
seek [+]+ident_fir+zidp
if found()
   store 0 to w1,w2,w3,w4
   for x=1 to 12
       xx=strtran(str(x,2),' ','0')
       zK_WYP&XX=0
       zK_ZAL&XX=0
       @ 8+x,35 say BRUT_RAZEM pict '99999.99'
       do jakiewyp
       do jakiezal
*      do jakipit4
       sele etaty
       if str(DO_WYPLATY,10,2)<>str(zK_WYP&XX+zK_ZAL&XX,10,2)
          ColErr()
       else
          set color to +w
       endif
       @ 8+x,44 say DO_WYPLATY pict '99999.99'
       @ 8+x,53 say zK_WYP&XX+zK_ZAL&XX pict '99999.99'
       set color to +w
       zD_ZAL&XX=DATA_ZAL
       zDO_PIT4&XX=DO_PIT4
       @ 8+x,62 say zD_ZAL&XX pict '@D'
       @ 8+x,73 say zDO_PIT4&XX pict '@R 9999.99'
       w1=w1+BRUT_RAZEM
       w2=w2+DO_WYPLATY
       w3=w3+zK_WYP&XX+zK_ZAL&XX
       skip 1
   next
   @ 21,4  say transform(str(int((date()-A->DATA_UR)/365),2),'99')+' lat'
   @ 21,35 say w1 pict '99999.99'
   @ 21,44 say w2 pict '99999.99'
   @ 21,53 say w3 pict '99999.99'
endif
sele prac
@ 22,8 say uwagi
set color to
return
***************************************************
func vodlicz
R=.f.
if zodliczenie$'TN'
   @ 5,50 say iif(zodliczenie='T','ak','ie')
   R=.t.
endif
return R
***************************************************
*       @ 8+x,55 say DATA_WYP   pict '@D'
*       @ 8+x,66 say DATA_ZAL   pict '@D'
***************************************************
proc jakiewyp
xy=str(x,2)
sele WYPLATY
seek [+]+ident_fir+zidp+xy
if found()
   do while del=='+' .and. firma==ident_fir .and. ident==zidp .and. mc==xy .and. .not. eof()
      zK_WYP&XX=zK_WYP&XX+kwota
      skip
   enddo
endif
***************************************************
proc jakiezal
xy=str(x,2)
sele ZALICZKI
seek [+]+ident_fir+zidp+xy
if found()
   do while del=='+' .and. firma==ident_fir .and. ident==zidp .and. mc==xy .and. .not. eof()
      zK_ZAL&XX=zK_ZAL&XX+kwota
      skip
   enddo
endif
***************************************************
proc jakiPIT4
xy=str(x,2)
sele ETATY
NRREKO=recno()
seek [+]+ident_fir+zidp+xy
if found()
   do while del=='+' .and. firma==ident_fir .and. ident==zidp .and. mc==xy .and. .not. eof()
      zDO_PIT4&XX=DO_PIT4
      skip
   enddo
endif
go NRREKO
******************************************************
func v_dzienwyp
_dzienwyp=eom(ctod(param_rok+'.'+str(_miewyp,2)+'.'+'01'))
return .t.
*******************************************************
func v_dopit4
_dopit4=substr(dtos(_dzienwyp),1,6)
return .t.
*############################################################################
