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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION TabAm( mieskart )

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,mieslok
mieslok=mieskart
@ 1,47 say [          ]
*set cent off
*################################# GRAFIKA ##################################
@  3, 0 say '      T A B E L E   A M O R T Y Z A C J I   &__S. R O D K &__O. W   T R W A &__L. Y C H     '
@  4, 0 say 'ÚData OT/LTÂÄÄNrEwidÄÄÂÄÄÄKSTÄÄÄÄ¿M-c/Rok                                       '
@  5, 0 say '³          ³          ³          ³Wartosc                                       '
@  6, 0 say '³          ³          ³          ³Przelicz.                                     '
@  7, 0 say '³          ³          ³          ³WartAkt                                       '
@  8, 0 say '³          ³          ³          ³Umorz                                         '
@  9, 0 say '³          ³          ³          ³ 1                                            '
@ 10, 0 say '³          ³          ³          ³ 2                                            '
@ 11, 0 say '³          ³          ³          ³ 3                                            '
@ 12, 0 say '³          ³          ³          ³ 4                                            '
@ 13, 0 say '³          ³          ³          ³ 5                                            '
@ 14, 0 say '³          ³          ³          ³ 6                                            '
@ 15, 0 say '³          ³          ³          ³ 7                                            '
@ 16, 0 say '³          ³          ³          ³ 8                                            '
@ 17, 0 say 'ÚData ZmianÂKwota(+/-)ÄOpis zmian¿ 9                                            '
@ 18, 0 say '³          ³         ³           ³10                                            '
@ 19, 0 say '³          ³         ³           ³11                                            '
@ 20, 0 say '³          ³         ³           ³12                                            '
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙRAZEM  999999.99 999999.99 999999.99 999999.99'
@ 22, 0 say 'NAZWA:                                          OPIS:                           '
ColInf()
@  4,6 say 'O'
@  4,9 say 'L'
@ 17,6 say 'Z'
set colo to
*############################### OTWARCIE BAZ ###############################
select 3
do while.not.dostep('KARTSTMO')
enddo
do setind with 'KARTSTMO'
select 2
do while.not.dostep('AMORT')
enddo
do setind with 'AMORT'
select 1
do while.not.dostep('KARTST')
enddo
do setind with 'KARTST'
seek [+]+ident_fir
if eof().or.del#'+'.or.firma#ident_fir
   kom(3,[*u],[ Brak srodk&_o.w trwa&_l.ych ])
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=5
_col_l=1
_row_d=16
_col_p=32
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,13,247,77,109,90,122,79,111,76,108,7,28]
_top=[firma#ident_fir]
_bot=[eof().or.del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[say41est()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say41esst]
_disp=.t.
_cls=''
*----------------------
kl=0
OL='O'
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   ROK1=space(6)
   ROK2=space(6)
   ROK3=space(6)
   ROK4=space(6)
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   case (kl=77.or.kl=109).and.len(alltrim(dtos(data_lik)))=0
        save scre to robs
        wybrok=1
        CoCu=ColPro()
        for x=0 to 3
            nrrok=str(x+1,1)
            if ROK&NRROK#space(6)
               @ 4,44+(x*10) prompt ROK&NRROK
            endif
        next
        wybrok=menu(wybrok)
        swybr=str(wybrok,1)
        zidp=str(rec_no,5)
        ZPRZE=space(6)
        ZMC=space(10)
        zSPOSOB=SPOSOB
        if wybrok#0
           if val(param_rok)>val(alltrim(ROK&swybr))
              kom(3,[*u],[ Nie mo&_z.esz aktualizowa&_c. poprzednich lat ])
              wybrok=0
           else
              sele KARTSTMO
              seek '+'+zidp+alltrim(ROK&swybr)
*              if found()
              if .not.eof().and.del=='+'.and.ident==zidp.and.substr(dtos(DATA_MOD),1,4)>=alltrim(ROK&swybr)
                 kom(3,[*u],[ Zmiany musz&_a. by&_c. dokonywane chronologicznie. S&_a. ju&_z. p&_o.&_z.niejsze modyfikacje ])
                 wybrok=0
              endif
              sele KARTST
           endif
           if wybrok#0
              sele AMORT
              seek '+'+zidp+alltrim(ROK&swybr)
              if found()
                 wybpol=1
                 ZPRZE=transform(PRZEL,'999.99')
                 NMC=MC01
                 ZMC=transform(MC01,'@Z 999999.99')
                 @ 6,44+((wybrok-1)*10) prompt Zprze
                 @ 9,41+((wybrok-1)*10) prompt ZMC
                 wybpol=menu(wybpol)
                 swybp=strtran(str(wybpol-1,2),' ','0')
                 ColStd()
                 modya=0
                 do case
                 case wybpol=1
                      zprze=val(zprze)
                      set curs on
                      @ 6,44+((wybrok-1)*10) get Zprze pict '999.99' valid zprze#0
                      read
                      set curs off
                      if lastkey()#27
                         MODYA=1
                         do BLOKADAR
                         repl PRZEL with zPRZE
                         unlock
                      endif
                      ZPRZE=transform(zPRZE,'999.99')
                 case wybpol#1.and.wybpol#0
                      set curs on
                      @ 9,41+((wybrok-1)*10) get NMC pict '999999.99' valid NMC#0
                      read
                      set curs off
                      if lastkey()#27
                         MODYA=2
                         do BLOKADAR
                         repl MC01 with NMC
                         unlock
                      endif
                 endcase
                 kon=.f.
                 if MODYA#0
                    ZMC=MC01
                    zprzel=przel
                    zwart_pocz=WART_POCZ
                    zwart_akt=zwart_pocz*zprzel
                    zodpis_rok=0
                    reccu=recno()
                    skip -1
                    if .not.bof().and.del+ident='+'+zidp
                       zodpis_sum=odpis_sum
                    else
                       zodpis_sum=0
                    endif
                    go reccu
                    zumorz_akt=zodpis_sum*zprzel
                    zodpis_sum=zumorz_akt
                    zliniowo=_round(zwart_akt*(stawka/100),2)
                    zdegres=_round((zwart_akt-zumorz_akt)*((stawka*wspdeg)/100),2)
                    zodpis_mie=iif(modya=1,iif(zSPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2)),zmc)
                    do BLOKADAR
                    repl przel with zprzel,;
                         wart_akt with zwart_akt,;
                         umorz_akt with zumorz_akt,;
                         liniowo with zliniowo,;
                         degres with zdegres
                    for i=1 to 12
                        zmcn=strtran(str(i,2),' ','0')
                        if kon
                           repl mc&zmcn with 0
                        else
                           if zodpis_mie>zwart_akt-zodpis_sum
                              repl mc&zmcn with zwart_akt-zodpis_sum
                              zodpis_rok=zodpis_rok+(zwart_akt-zodpis_sum)
                              zodpis_sum=zodpis_sum+(zwart_akt-zodpis_sum)
                              kon=.t.
                           else
                              repl mc&zmcn with zodpis_mie
                              zodpis_rok=zodpis_rok+zodpis_mie
                              zodpis_sum=zodpis_sum+zodpis_mie
                           endif
                        endif
                    next
                    repl odpis_rok with zodpis_rok,;
                         odpis_sum with zodpis_sum
                    unlock
                    odr=val(ROK)+1
                    zprzel=1
                    zstawka=stawka
                    zwspdeg=wspdeg
                    zliniowo=_round(zwart_akt*(zstawka/100),2)
                    zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
                    zodpis_mie=iif(zSPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
                    zodpis_rok=0
                    skip
                    if .not.eof().and.del+ident='+'+zidp
                       do BLOKADA
                       dele rest while del+ident='+'+zidp
                    endif
                    if .not.kon
                       do while .t.
                          CURR=ColInf()
                          @ 24,0
                          center(24,'Aktualizuje ')
                          setcolor(CURR)
                          app()
                          repl firma with ident_fir,;
                               ident with zidp,;
                               rok with str(odr,4),;
                               wart_pocz with zwart_akt,;
                               przel with zprzel,;
                               wart_akt with zwart_akt,;
                               umorz_akt with zodpis_sum,;
                               stawka with zstawka,;
                               wspdeg with zwspdeg,;
                               liniowo with zliniowo,;
                               degres with zdegres
                          for i=1 to 12
                              zmcn=strtran(str(i,2),' ','0')
                              if zodpis_mie>zwart_akt-zodpis_sum
                                 repl mc&zmcn with zwart_akt-zodpis_sum
                                 zodpis_rok=zodpis_rok+(zwart_akt-zodpis_sum)
                                 zodpis_sum=zodpis_sum+(zwart_akt-zodpis_sum)
                                 kon=.t.
                                 exit
                              else
                                 repl mc&zmcn with zodpis_mie
                                 zodpis_rok=zodpis_rok+zodpis_mie
                                 zodpis_sum=zodpis_sum+zodpis_mie
                              endif
                          next
                          repl odpis_rok with zodpis_rok,;
                               odpis_sum with zodpis_sum
                          unlock
                          if kon
                             exit
                          else
                             odr++
                             zwart_pocz=zwart_akt
                             zprzel=1
                             zwart_akt=zwart_pocz*zprzel
                             zodpis_rok=0
                             zumorz_akt=zodpis_sum*zprzel
                             zliniowo=_round(zwart_akt*(zstawka/100),2)
                             zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
                             zodpis_mie=iif(zSPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
                          endif
                       enddo
                       unlock
                    endif
                 endif
              endif
           endif
        endif
        sele KARTST
        set orde to 2
        seek val(zidp)
        set orde to 1
        setcolor(CoCu)
        rest scre from robs
   case (kl=90.or.kl=122).and.len(alltrim(dtos(data_lik)))=0
        save scre to robs
        zidp=str(rec_no,5)
        sele kartstmo
*       seek '+'+zidp
        do kartstmo
        sele kartst
        rest scre from robs
   case kl=79.or.kl=111
        OL='O'
   case kl=76.or.kl=108
        OL='L'
   case kl=13
        save scre to robs
        if mieslok='C'
           do tabamw
        else
           do umorz with mieslok
        endif
        rest scre from robs
   *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                       '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']..............poprzednia/nast&_e.pna pozycja      '
        p[ 3]='   [Home/End].........pierwsza/ostatnia pozycja        '
        if mieslok='C'
           p[ 4]='   [Enter]............wydruk tabeli amortyzacji        '
        else
           p[ 4]='   [Enter]............wydruk listy umorze&_n. w miesi&_a.cu  '
        endif
        p[ 5]='   [M]................przeszacowanie &_s.rodka trwa&_l.ego   '
        p[ 6]='   [O]................informacja o dacie przyj&_e.cia     '
        p[ 7]='   [L]................informacja o dacie likwidacji    '
        p[ 8]='   [Z]................zmiana warto&_s.ci pocz&_a.tkowej      '
        p[ 9]='   [Esc]..............wyj&_s.cie                          '
        p[10]='                                                       '
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
   endcase
enddo
*set cent on
close_()
*################################## FUNKCJE #################################
procedure say41est
wierszyk=space(32)
if OL='O'
   wierszyk=dtoc(DATA_ZAK)+[³]+NREWID+[³ ]+KRST+' '
else
   wierszyk=dtoc(DATA_LIK)+[³]+NREWID+[³ ]+KRST+' '
endif
return wierszyk
*##############################################################################
procedure say41esst
clear type
set color to +w
@ 4,44 clear to 4,79
@ 5,41 clear to 5,79
@ 6,44 clear to 6,79
@ 7,41 clear to 21,79
zidp=str(rec_no,5)
sele amort
seek [+]+zidp
if found()
   ofrok=0
   do while .not.eof().and.del+ident==[+]+zidp
      if val(PARAM_ROK)>val(ROK)+1
         skip
      else
         @ 4,44+(ofrok*10) say ROK
         @ 5,41+(ofrok*10) say wart_pocz pict '@E 999999.99'
         @ 6,44+(ofrok*10) say przel     pict    '@E 999.99'
         @ 7,41+(ofrok*10) say wart_akt pict  '@E 999999.99'
         @ 8,41+(ofrok*10) say umorz_akt pict '@E 999999.99'
         for x=1 to 12
             MCS=strtran(str(x,2),' ','0')
             @ 8+x,41+(ofrok*10) say MC&MCS pict '@EZ 999999.99'
         next
         @ 21,41+(ofrok*10) say odpis_rok pict '@E 999999.99'
         ofrok++
         NRROK=str(ofrok,1)
         ROK&NRROK=' '+ROK+' '
         if ofrok=4
            exit
         endif
         skip
      endif
   enddo
endif
sele kartstmo
seek [+]+zidp
ilmod=0
@ 18,1 say space(10)+[³]+space(9)+[³]+space(11)
@ 19,1 say space(10)+[³]+space(9)+[³]+space(11)
@ 20,1 say space(10)+[³]+space(9)+[³]+space(11)
*if found().and.ilmod<3.and.[+]+zidp==A->del+str(A->rec_no,5).and..not.eof()
   do while    ilmod<3.and.del+ident==[+]+zidp.and..not.eof()
      @ 18+ilmod,1 say transform(DATA_MOD,'@D')+[³]+str(WART_MOD,9,2)+[³]+substr(OPIS_MOD,1,11)
      ilmod++
      skip
   enddo
*endif
sele kartst
@ 22,7 say NAZWA
@ 22,53 say OPIS
set color to
return
*############################################################################
