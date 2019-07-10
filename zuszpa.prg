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

FUNCTION ZusZpa()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
select 6
if dostep('FIRMA')
   go val(ident_fir)
else
   return
endif
zORGAN=ORGAN
zNAZWA_ORG=''
select 5
if dostep('ORGANY')
   do setind with 'ORGANY'
   seek [+]
   if eof().or.del#'+'
      kom(3,[*u],[ Najpierw wprowad&_x. informacje o Organach Rejestrowych ])
      return
   endif
else
   close_()
   return
endif
if zORGAN<>0
   sele organy
   go zORGAN
   zNAZWA_ORG=NAZWA_ORG
endif
*--------------------------------------
sele firma
*--------------------------------------
@ 3,42 clear to 22,79
*################################# OPERACJE #################################
save screen to scr2
if f->spolka
   nr_rec=recno()
   param_zu()
   jeden=zus_zglo()
   if jeden#1
      close_()
      return
   endif
   set device to print
   set console off
   set print on
   NUFIR=val(alltrim(ident_fir))
   Nufir1=HI36(nufir)
   nufir2=LO36(nufir)
   NUPLA=recno()
   Nupla1=HI36(nupla)
   nupla2=LO36(nupla)
   PLIK_KDU=substr(param_rok,4,1)+;
         '0'+;
         iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
         iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
         '4'+;
         'F'+;
         iif(nufir1>9,chr(55+nufir1),str(nufir1,1))+;
         iif(nufir2>9,chr(55+nufir2),str(nufir2,1))+;
         '.kdu'
aaaa=alltrim(paraz_cel)+PLIK_KDU
set printer to &aaaa
kedu_pocz()
dp_pocz('ZPA')
?'<ZUSZPA>'
dozpf()
daip(F->NIP,substr(F->NR_REGON,3),F->nazwa_skr)
dapl(F->NAZWA,F->DATA_REJ,F->NUMER_REJ,zNAZWA_ORG,F->DATA_ZAL)
dorb(alltrim(F->NR_KONTA))
ido1()
aszp(F->KOD_P,F->MIEJSC,F->GMINA,F->ULICA,F->NR_DOMU,F->NR_MIESZK,F->TEL,F->FAX)
adkp()
dobr('','','')
opl2()
?'</ZUSZPA>'
dp_kon('ZPA')
kedu_kon()
set printer to
set print off
set console on
set devi to screen
kedu_rapo(plik_kdu)
go nr_rec
else
do komun with 'Firma nie jest sp&_o.&_l.k&_a.'
endif
restore screen from scr2
_disp=.f.
close_()
