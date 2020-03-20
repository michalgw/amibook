/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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

*����������������������������������������������������������������������������
*������ ......   ������������������������������������������������������������
*�Obsluga podstawowych operacji na bazie ......                             �
*����������������������������������������������������������������������������

FUNCTION Tab_Poj()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@ 3,42 clear to 22,79
@  6,45 say '������������������������������ͻ'
@  7,45 say '�   Stawka   �   do   �   od   �'
@  8,45 say '�  od dnia   � 900cm3 � 901cm3 �'
@  9,45 say '������������������������������ĺ'
@ 10,45 say '�            �        �        �'
@ 11,45 say '�            �        �        �'
@ 12,45 say '�            �        �        �'
@ 13,45 say '�            �        �        �'
@ 14,45 say '�            �        �        �'
@ 15,45 say '�            �        �        �'
@ 16,45 say '�            �        �        �'
@ 17,45 say '�            �        �        �'
@ 18,45 say '�            �        �        �'
@ 19,45 say '������������������������������ͼ'
*############################### OTWARCIE BAZ ###############################
do while.not.dostep('TAB_POJ')
enddo
set inde to tab_poj
*################################# OPERACJE #################################
*----- parametry ------
_row_g=10
_col_l=46
_row_d=18
_col_p=75
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,22,48,77,109,7,46,28]
_top=[.f.]
_bot=[del#'+']
_stop=[]
_sbot=[-]
_proc=[linia21()]
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
*############################ INSERT/MODYFIKACJA ############################
              case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
@ 1,47 say [          ]
ins=(kl#77.and.kl#109).OR.&_top_bot
if ins
ColStb()
center(23,[�                     �])
ColSta()
  center(23,[W P I S Y W A N I E])
ColStd()
restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
wiersz=_row_d
else
ColStb()
center(23,[�                       �])
ColSta()
  center(23,[M O D Y F I K A C J A])
ColStd()
wiersz=_row
endif
                             do while .t.
*������������������������������ ZMIENNE ��������������������������������
if ins
   zODDNIA=date()
   zPOJ_900=0
   zPOJ_901=0
else
   zODDNIA=ODDNIA
   zPOJ_900=POJ_900
   zPOJ_901=POJ_901
endif
*�������������������������������� GET ����������������������������������
@ wiersz,47 get zODDNIA picture "@D 9999.99.99" valid v2_11()
@ wiersz,60 get zPOJ_900 picture "9.9999" valid v2_21()
@ wiersz,69 get zPOJ_901 picture "9.9999" valid v2_31()
read_()
set cursor off
if lastkey()=27
exit
endif
*�������������������������������� REPL ���������������������������������
if ins
   app()
endif
do BLOKADAR
repl_([ODDNIA],zODDNIA)
repl_([POJ_900],zPOJ_900)
repl_([POJ_901],zPOJ_901)
commit_()
unlock
*�����������������������������������������������������������������������
_row=int((_row_g+_row_d)/2)
if .not.ins
exit
endif
@ _row_d,_col_l say &_proc
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say [            �        �        ]
                             enddo
_disp=ins.or.lastkey()#27
kl=iif(lastkey()=27.and._row=-1,27,kl)
@ 23,0
*################################ KASOWANIE #################################
                   case kl=7.or.kl=46
@ 1,47 say [          ]
ColStb()
center(23,[�                   �])
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
p[ 3]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
p[ 4]='   [Home/End]..............pierwsza/ostatnia pozycja    '
p[ 5]='   [Ins]...................wpisywanie                   '
p[ 6]='   [M].....................modyfikacja pozycji          '
p[ 7]='   [Del]...................kasowanie pozycji            '
p[ 8]='   [Esc]...................wyj&_s.cie                      '
p[ 9]='                                                        '
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
close_()
*################################## FUNKCJE #################################
function linia21
return [ ]+dtoc(ODDNIA)+[ � ]+str(POJ_900,6,4)+[ � ]+str(POJ_901,6,4)+[ ]
***************************************************
function v2_11
nr_rec=recno()
seek [+]+dtos(zODDNIA)
fou=found()
rec=recno()
go nr_rec
if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Takie dane ju&_z. istniej&_a.')
   set cursor on
   return .f.
endif
return .t.
***************************************************
function v2_21
return zPOJ_900>0
***************************************************
function v2_31
return zPOJ_901>0
*############################################################################
