/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha� Gawrycki (gmsystems.pl)

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

FUNCTION Samochod()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                                                                                '
@  4, 0 say '                   SAMOCHODY  PRYWATNE  DO  U&__Z.YTKU  S&__L.U&__Z.BOWEGO                  '
@  5, 0 say '                                                                                '
@  6, 0 say '    Nr rejestr.         Marka           cm3     Nazwisko i imi&_e. w&_l.a&_s.ciciela     '
@  7, 0 say '   �������������������������������������������������������������������������Ŀ  '
@  8, 0 say '   �          �                      �      �                                �  '
@  9, 0 say '   �          �                      �      �                                �  '
@ 10, 0 say '   �          �                      �      �                                �  '
@ 11, 0 say '   �          �                      �      �                                �  '
@ 12, 0 say '   �          �                      �      �                                �  '
@ 13, 0 say '   �          �                      �      �                                �  '
@ 14, 0 say '   �          �                      �      �                                �  '
@ 15, 0 say '   �          �                      �      �                                �  '
@ 16, 0 say '   �          �                      �      �                                �  '
@ 17, 0 say '   �          �                      �      �                                �  '
@ 18, 0 say '   �          �                      �      �                                �  '
@ 19, 0 say '   �          �                      �      �                                �  '
@ 20, 0 say '   �          �                      �      �                                �  '
@ 21, 0 say '   �          �                      �      �                                �  '
@ 22, 0 say '   ���������������������������������������������������������������������������  '
*############################### OTWARCIE BAZ ###############################
select 1
if dostep('samochod')
   set inde to SAMOCHOD
else
   close_()
   return
endif
seek [+]+ident_fir
*################################# OPERACJE #################################
*----- parametry ------
_row_g=8
_col_l=4
_row_d=21
_col_p=76
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[�]
_proc=[linia132()]
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
              zNRREJ=space(8)
              zMARKA=space(20)
              zPOJEMNOSC=0
              zWLASCIC=space(30)
           else
              zNRREJ=NRREJ
              zMARKA=MARKA
              zPOJEMNOSC=POJEMNOSC
              zWLASCIC=WLASCIC
           endif
           *�������������������������������� GET ����������������������������������
           @ wiersz,5 get zNRREJ picture "!!!!!!!!" valid v13_11()
           @ wiersz,16 get zMARKA picture "!XXXXXXXXXXXXXXXXXXX" valid v13_21()
           @ wiersz,39 get zPOJEMNOSC picture "9999" valid v13_31()
           @ wiersz,46 get zWLASCIC picture '!'+repl('X',29) valid v13_41()
           read_()
           if lastkey()=27
              exit
           endif
           *�������������������������������� REPL ���������������������������������
           if ins
              app()
              repl_([firma],ident_fir)
           endif
           do BLOKADAR
           repl_([NRREJ],zNRREJ)
           repl_([MARKA],zMARKA)
           repl_([POJEMNOSC],zPOJEMNOSC)
           repl_([WLASCIC],zWLASCIC)
           unlock
           commit_()
           *�����������������������������������������������������������������������
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [          �                      �      �                                ]
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
*################################# SZUKANIE #################################
   case kl=-9.or.kl=247
        @ 1,47 say [          ]
        ColStb()
        center(23,[�                 �])
        ColSta()
        center(23,[S Z U K A N I E])
        f10=space(8)
        ColStd()
        @ _row,5 get f10 picture "!!! !!!!"
        read_()
        _disp=.not.empty(f10).and.lastkey()#27
        if _disp
           seek [+]+ident_fir+f10
           if &_bot
              skip -1
           endif
           _row=int((_row_g+_row_d)/2)
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
        p[ 8]='   [F10]...................szukanie                     '
        p[ 9]='   [Esc]...................wyj&_s.cie                      '
        p[10]='                                                        '
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
function linia132
return [ ]+NRREJ+[ � ]+MARKA+[ � ]+str(POJEMNOSC,4)+[ � ]+WLASCIC+[ ]
***************************************************
function v13_11
if empty(zNRREJ)
   return .f.
endif
nr_rec=recno()
seek [+]+ident_fir+zNRREJ
fou=found()
rec=recno()
go nr_rec
if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Taki samoch&_o.d ju&_z. istnieje')
   set cursor on
   return .f.
endif
return .t.
***************************************************
function v13_21
return .not.empty(zMARKA)
***************************************************
function v13_31
return zPOJEMNOSC>0
***************************************************
function v13_41
return .not.empty(zWLASCIC)
*############################################################################
