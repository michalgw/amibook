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
*set cent off
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
*@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@ 17, 0 say 'ÚData zmianÂKwota(+/-)ÄOpis zmian¿'
@ 18, 0 say '³          ³         ³           ³'
@ 19, 0 say '³          ³         ³           ³'
@ 20, 0 say '³          ³         ³           ³'
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ'
*@ 18,1  say 'ÚOdÂDoÂPrzyczyna nieob¿'
*@  9,42 say '³  ³  ³               ³'
*@ 10,42 say '³  ³  ³               ³'
*@ 11,42 say '³  ³  ³               ³'
*@ 12,42 say '³  ³  ³               ³'
*@ 13,42 say 'ÀÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
ColInf()
@ 17,6 say 'Z'
set colo to
*############################### OTWARCIE BAZ ###############################
seek [+]+zidp
*################################# OPERACJE #################################
*----- parametry ------
_row_g=18
_col_l=1
_row_d=20
_col_p=32
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
_top=[del#'+'.or.ident#zidp]
_bot=[del#'+'.or.ident#zidp]
_stop=[+]+zidp
_sbot=[+]+zidp+[þ]
*_sbot=[+]+ident_fir+_zident_+mmmie
_proc=[say41__()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
_top_bot=_top+[.or.]+_bot
*----------------------
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
*########################### INSERT/MODYFIKACJA #############################
   case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
        ins=(kl#109.and.kl#77).OR.&_top_bot
        rrer=recno()
        skip 1
        if ins=.f..and..not.eof().and.del='+'.and.ident==zidp
           go rrer
           kom(3,[*u],[ Modyfikowa&_c. mo&_z.na tylko ostatni wpis ])
        else
           go rrer
           @ 1,47 say [          ]
           if ins
              ColStb()
              center(23,[þ                     þ])
              ColSta()
              center(23,[W P I S Y W A N I E])
              ColStd()
              restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
              wiersz=_row_d
           else
              ColStb()
              center(23,[þ                       þ])
              ColSta()
              center(23,[M O D Y F I K A C J A])
              ColStd()
              wiersz=_row
           endif
           begin sequence
           *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
                 if ins
                    zDATA_MOD=date()
                    zWART_MOD=0
                    zOPIS_MOD=space(60)
                 else
                    zDATA_MOD1=DATA_MOD
                    zWART_MOD1=WART_MOD
                    zDATA_MOD=DATA_MOD
                    zWART_MOD=WART_MOD
                    zOPIS_MOD=OPIS_MOD
                 endif
        *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
*                 if ins
                    @ wiersz,_col_l    get zDATA_MOD pict '@D'
*                 endif
                 @ wiersz,_col_l+11 get zWART_MOD pict '999999.99'
                 @ wiersz,_col_l+21 get zOPIS_MOD pict '@S11 '+repl('X',60)
                 read_()
                 if lastkey()=27
                    break
                 endif
                 ColStd()
                 @ 24,0
                 set color to
                 *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                 rrer=recno()
                 _zrob=.f.
*                 set soft on
                 seek [+]+zidp+dtos(zDATA_MOD)
*                 wait del+ident+dtos(data_mod)
                 if .not.eof().and.del='+'.and.ident==zidp.and.iif(ins,DATA_MOD>=zDATA_MOD,recno()#rrer)
                    kom(3,[*u],[ Zmiany warto&_s.ci &_s.rodka trwa&_l.ego musz&_a. by&_c. wprowadzane chronologicznie ])
                 else
                    _zrob=.t.
                 endif
*                 set soft off
                 go rrer
                 if _zrob=.f.
                    break
                 endif
                 if ins
                    app()
                    repl_([IDENT],zIDP)
                 endif
                 do BLOKADAR
                 repl_([DATA_MOD],zDATA_MOD)
                 repl_([WART_MOD],zWART_MOD)
                 repl_([OPIS_MOD],zOPIS_MOD)
                 commit_()
                 unlock
                 *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                 if ins
                    do modyst with zdata_mod,zwart_mod
                 else
                    do modyst with zdata_mod1,zwart_mod1*(-1)
                    do modyst with zdata_mod1,0
                    do modyst with zdata_mod,zwart_mod
                 endif

                 _row=int((_row_g+_row_d)/2)
                 kl=27
                 if .not.ins
                    break
                 endif
                 * @ _row_d,_col_l say &_proc
                 scroll(_row_g,_col_l,_row_d,_col_p,1)
                 @ _row_d,_col_l say '          ³         ³           '
           end
           _disp=ins.or.lastkey()#27
           kl=iif(lastkey()=27.and._row=-1,27,kl)
           @ 23,0
        endif
*################################ KASOWANIE #################################
   case kl=7.or.kl=46
        rrer=recno()
        skip 1
        if .not.eof().and.del='+'.and.ident==zidp
           go rrer
           kom(3,[*u],[ Usuwa&_c. mo&_z.na tylko ostatni wpis ])
        else
           go rrer
           @ 1,47 say [          ]
           ColStb()
           center(23,[þ                   þ])
           ColSta()
           center(23,[K A S O W A N I E])
           ColStd()
           _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
           if _disp
              zDATA_MOD1=DATA_MOD
              zWART_MOD1=WART_MOD
              do modyst with zdata_mod1,zwart_mod1*(-1)
              do modyst with zdata_mod1,0
              do BLOKADAR
              del()
              unlock
              skip
              commit_()
              if &_bot
                 skip -1
              endif
              kl=27
           endif
           @ 23,0
        endif
*################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                        '
        p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
        p[ 3]='   [Home/End]..............pierwsza/ostatnia pozycja    '
        p[ 4]='   [Ins]...................wpisywanie                   '
        p[ 5]='   [M].....................modyfikacja pozycji          '
        p[ 6]='   [Del]...................kasowanie pozycji            '
        p[ 7]='   [Esc]...................wyj&_s.cie                      '
        p[ 8]='                                                        '
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
   ******************** ENDCASE
   endcase
enddo
*close_()
*set cent on
*################################## FUNKCJE #################################
procedure say41__
return transform(DATA_MOD,'@D')+[³]+str(WART_MOD,9,2)+[³]+substr(OPIS_MOD,1,11)
*############################################################################
proc modyst
***********************
para da_mo_,wa_mo_
sele amort
do BLOKADA
zodro=str(year(DA_MO_)+1,4)
seek '+'+zIDP+zODRO
if found()
  do while del+ident=='+'+zIDP .and. ROK>=zODRO .and. .not. eof()
     dele
     skip
  enddo
endif
seek '+'+zIDP+substr(dtos(DA_MO_),1,4)
if found()
              repl wart_mod with wart_mod+wa_mo_
              kon=.f.
              zwart_pocz=wart_pocz
              zprzel=przel
              zstawka=stawka
              zwspdeg=wspdeg
              zwart_akt=(zwart_pocz*zprzel)+wart_mod
              zodpis_sum=umorz_akt
              zodpis_rok=0
              zumorz_akt=zodpis_sum*zprzel
              zliniowo=_round(zwart_akt*(zstawka/100),2)
              zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
              zodpis_mie=iif(A->SPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
              odm=month(da_mo_)
              odr=year(da_mo_)
              for i=1 to odm
                  zmcn=strtran(str(i,2),' ','0')
                  zodpis_rok=zodpis_rok+mc&zmcn
                  zodpis_sum=zodpis_sum+mc&zmcn
              next
              for i=odm to 12
                  if month(da_mo_)=i.and.year(da_mo_)=odr
                  else
                     zmcn=strtran(str(i,2),' ','0')
                     repl mc&zmcn with 0
                  endif
              next
              do while .t.
                 CURR=ColInf()
                 @ 24,0
                 center(24,'Dopisuj&_e. rok '+str(odr,4))
                 setcolor(CURR)
                 seek '+'+zIDP+str(ODR,4)
                 if .not.found()
                    app()
                 endif
                 repl firma with ident_fir,;
                      ident with zidp,;
                      rok with str(odr,4),;
                      wart_pocz with zwart_pocz,;
                      przel with zprzel,;
                      wart_akt with zwart_akt,;
                      umorz_akt with zumorz_akt,;
                      stawka with zstawka,;
                      wspdeg with zwspdeg,;
                      liniowo with zliniowo,;
                      degres with zdegres
                 for i=odm to 12
                     zmcn=strtran(str(i,2),' ','0')
                     if month(da_mo_)=i.and.year(da_mo_)=odr
                     else
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
                     endif
                 next
                 repl odpis_rok with zodpis_rok,;
                      odpis_sum with zodpis_sum
                 unlock
                 if kon
                    exit
                 else
                    odm=1
                    odr++
                    zwart_pocz=zwart_akt
                    zprzel=1
                    zwart_akt=zwart_akt*zprzel
                    zodpis_rok=0
                    zumorz_akt=zodpis_sum*zprzel
                    zliniowo=_round(zwart_akt*(zstawka/100),2)
                    zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
                    zodpis_mie=iif(A->SPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
                 endif
              enddo
              unlock
endif
sele kartstmo
@ 24,0
