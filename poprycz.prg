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

para OKRES,MMIESIAC
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
*################################ OBLICZENIA ################################
sele spolka
********************** udzialy w miesiacach
zm=[  0/1  ]
for i=1 to 12
    zm1=[udzial]+ltrim(str(i))
    if [   /   ]#&zm1
       zm=&zm1
    endif
    zm2=[udz]+ltrim(str(i))
    &zm2 =zm
next
**********************
select suma_mc
if OKRES='M'
   seek [+]+ident_fir+mmiesiac
else
   seek [+]+ident_fir+mc_rozp
endif
przychodu=0
przychodp=0
przychodh=0
do while del=[+].and.firma=ident_fir.and.mc<=mmiesiac
   zm=[udz]+ltrim(mc)
   przychodu=przychodu+USLUGI*val(left(&zm ,3))/val(right(&zm ,3))
   przychodp=przychodp+WYR_TOW*val(left(&zm ,3))/val(right(&zm ,3))
   przychodh=przychodh+HANDEL*val(left(&zm ,3))/val(right(&zm ,3))
   przychr20=przychr20+RY20*val(left(&zm ,3))/val(right(&zm ,3))
   przychr17=przychr17+RY17*val(left(&zm ,3))/val(right(&zm ,3))
   przychr10=przychr10+RY10*val(left(&zm ,3))/val(right(&zm ,3))
   skip
enddo
select spolka
k1=_round(przychodu,2)
k1a=_round(przychr20,2)
k1b=_round(przychr17,2)
k1c=_round(przychr10,2)
k2=_round(przychodp,2)
k3=_round(przychodh,2)
k4=k1+k2+k3+k1a+k1b+k1c
*------------------------------------ dane_mc
zident=str(recno(),5)
select dane_mc
if OKRES='M'
   seek [+]+zident+mmiesiac
else
   seek [+]+zident+mc_rozp
endif
store 0 to dochody,wydatki,zwolniony,zaliczki,zaaa,zbbb
store 0 to zpit566,zpit567,zpit569,zpit5104,zpit5105
do while del=[+].and.ident=zident.and.mc<=mmiesiac
   dochody=dochody+_round((g_przych1-g_koszty1)*val(left(g_udzial1,2))/val(right(g_udzial1,3)),2)+_round((g_przych2-g_koszty2)*val(left(g_udzial2,2))/val(right(g_udzial2,3)),2)
   dochody=dochody+_round((n_przych1-n_koszty1)*val(left(n_udzial1,2))/val(right(n_udzial1,3)),2)+_round((n_przych2-n_koszty2)*val(left(n_udzial2,2))/val(right(n_udzial2,3)),2)
   k5=straty+straty_n+powodz+rentalim+skladki+skladkiw+organy+zwrot_ren+zwrot_swi+rehab+kopaliny+darowiz+wynagro+inne+budowa+inwest11+dochzwol
   wydatki=wydatki+k5
   zaaa=zaaa+aaa
   zbbb=zbbb+bbb
   zaliczki=zaliczki+zaliczka
   zpit566=zpit566+pit566
   zpit567=zpit567+pit567
   zpit569=zpit569+pit569
   zpit5104=zpit5104+pit5104
   if pit5105>0
      if zpit5105=0
         zpit5105=pit5105
      else
         zpit5105=(zpit5105+pit5105)/2
      endif
   endif
   skip
enddo
select spolka
*------------------------------------
reman=(zpit5104*(zpit5105/100))*0.1
zwol=0
procent1=k4/100
k6=_round(przychodu/procent1,iif(okres='M',2,0))
k6a=_round(przychr20/procent1,iif(okres='M',2,0))
k6b=_round(przychr17/procent1,iif(okres='M',2,0))
*k6c=_round(przychr10/procent1,iif(okres='M',2,0))
k6c=0
k7=_round(przychodp/procent1,iif(okres='M',2,0))
k8=_round(przychodh/procent1,iif(okres='M',2,0))
if k6+k6a+k6b+k6c+k7+k8<100
   k6a=100-(k6+k6b+k6c+k7+k8)
else
   k8=100-(k6+k6a+k6b+k6c+k7)
endif
k55=iif(OKRES='M',k5,wydatki)
k9 =_round(k55*(k6/100),2)
k9a=_round(k55*(k6a/100),2)
k9b=_round(k55*(k6b/100),2)
k9c=_round(k55*(k6c/100),2)
k10=_round(k55*(k7/100),2)
k11=_round(k55*(k8/100),2)
k12=_round(k1-k9,0)
k12a=_round(k1a-k9a,0)
k12b=_round(k1b-k9b,0)
k12c=_round(k1c-k9c,0)
k13=_round(k2-k10,0)
k14=_round(k3-k11,0)
k15=_round(k12*staw_uslu,1)
k15a=_round(k12a*staw_ry20,1)
k15b=_round(k12b*staw_ry17,1)
k15c=_round(k12c*staw_ry10,1)
k16=_round(k13*staw_prod,1)
k17=_round(k14*staw_hand,1)
k18=_round(k15+k15a+k15b+k15c+k16+k17,1)
podatek=k18
select spolka
*---------------
k19=_round(zaaa,1)+_round(zbbb,1)
k21=_round(max(0,k18-k19),1)
k21a=_round(max(0,k18-k19),1)
k22=_round(zaliczki,1)
k23=_round(k21a-k22,1)
if OKRES='N'
   wartprzek=k23
else
   wartprzek=k21
endif
if OKRES='N'
   return k23
else
   return k21
endif
