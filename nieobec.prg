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
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  8,42 say 'ÚOdÂDoÂPrzyczyna nieob¿'
@  9,42 say '³  ³  ³               ³'
@ 10,42 say '³  ³  ³               ³'
@ 11,42 say '³  ³  ³               ³'
@ 12,42 say '³  ³  ³               ³'
@ 13,42 say 'ÀÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
sele prac
_zident_=str(rec_no,5)
sele nieobec
mmmie=etaty->mc
seek [+]+ident_fir+_zident_+mmmie
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=43
_row_d=12
_col_p=63
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
_top=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#mmmie]
_bot=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#mmmie]
_stop=[+]+ident_fir+_zident_+mmmie
*_sbot=[+]+ident_fir+_zident_+mmmie+[þ]
_sbot=[+]+ident_fir+_zident_+mmmie
_proc=[say41_()]
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
@ 1,47 say [          ]
ins=(kl#109.and.kl#77).OR.&_top_bot
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
   zDDOD=day(date())
   zDDDO=day(date())
   zPRZYCZYNA=space(15)
else
   zDDOD=DDOD
   zDDDO=DDDO
   zPRZYCZYNA=PRZYCZYNA
endif
zPRZYCZ=substr(zPRZYCZYNA,1,1)
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ wiersz,_col_l   get zDDOD  pict '99' range 1,31
@ wiersz,_col_l+3 get zDDDO  pict '99' range 1,31
@ wiersz,_col_l+6 get zPRZYCZ pict '!' when wPOKAPRZY() valid vPOKAPRZY(zPRZYCZ)
read_()
if lastkey()=27
   break
endif
ColStd()
@ 24,0
set color to
do case
case zPRZYCZ='I'
     zPRZYCZYNA='Inne url.(okol)'
case zPRZYCZ='U'
     zPRZYCZYNA='Urlop wypoczynk'
case zPRZYCZ='C'
     zPRZYCZYNA='Choroba (L-4)'
case zPRZYCZ='Z'
     zPRZYCZYNA='Zawod.chor,itp.'
case zPRZYCZ='O'
     zPRZYCZYNA='Opieka'
case zPRZYCZ='W'
     zPRZYCZYNA='Wychowawczy url'
case zPRZYCZ='B'
     zPRZYCZYNA='Bezplatny urlop'
case zPRZYCZ='N'
     zPRZYCZYNA='NN'
case zPRZYCZ='M'
     zPRZYCZYNA='Macierzynski ur'
ENDCASE
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
if ins
   app()
   repl_([FIRMA],IDENT_FIR)
   repl_([IDENT],_zIDENT_)
   repl_([MC],mmmie)
endif
do BLOKADAR
repl_([DDOD],zDDOD)
repl_([DDDO],zDDDO)
repl_([PRZYCZYNA],zPRZYCZYNA)
commit_()
unlock
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
_row=int((_row_g+_row_d)/2)
if .not.ins
   break
endif
* @ _row_d,_col_l say &_proc
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say '  ³  ³               '
                             end
_disp=ins.or.lastkey()#27
kl=iif(lastkey()=27.and._row=-1,27,kl)
@ 23,0
*################################ KASOWANIE #################################
              case kl=7.or.kl=46
@ 1,47 say [          ]
ColStb()
center(23,[þ                   þ])
ColSta()
center(23,[K A S O W A N I E])
ColStd()
_disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
if _disp
   do BLOKADAR
   del()
   unlock
   skip
   commit_()
   if &_bot
      skip -1
   endif
endif
@ 23,0
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
procedure say41_
return str(DDOD,2)+[³]+str(DDDO,2)+[³]+PRZYCZYNA
*############################################################################
func wPOKAPRZY
*************************************
ColInf()
@ 24,0 say padc('C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz',80,' ')
ColStd()
return .t.
*******************************************************
func vPOKAPRZY
*******************************************************
para VSP
if .not.VSP$'IUCZOWBMN'
   kom(1,[*u],padc([C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz],80))
   ColInf()
   @ 24,0 say padc('C-80%,Z-100%,O-opieka,N-NN,urlopy:U-wypocz,I-okolicz,W-wychow,B-bezpl,M-macierz',80,' ')
   ColStd()
   zPRZYCZ=substr(zPRZYCZYNA,1,1)
   return .f.
else
   @ 24,0
endif
return .t.
