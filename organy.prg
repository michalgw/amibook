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

FUNCTION Organy()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 clear to 22,79
@  4, 0 say padc('K A T A L O G   O R G A N &__O. W   R E J E S T R O W Y C H',80)
@  5, 8 say '                                                              '
@  6, 8 say '                   Nazwa Organu Rejestrowego                  '
@  7, 8 say '������������������������������������������������������������Ŀ'
@  8, 8 say '�                                                            �'
@  9, 8 say '�                                                            �'
@ 10, 8 say '�                                                            �'
@ 11, 8 say '�                                                            �'
@ 12, 8 say '�                                                            �'
@ 13, 8 say '�                                                            �'
@ 14, 8 say '�                                                            �'
@ 15, 8 say '�                                                            �'
@ 16, 8 say '�                                                            �'
@ 17, 8 say '�                                                            �'
@ 18, 8 say '�                                                            �'
@ 19, 8 say '�                                                            �'
@ 20, 8 say '�                                                            �'
@ 21, 8 say '�                                                            �'
@ 22, 8 say '��������������������������������������������������������������'
*############################### OTWARCIE BAZ ###############################
select 2
do while.not.dostep('FIRMA')
enddo
do setind with 'FIRMA'
select 1
do while.not.dostep('ORGANY')
enddo
do setind with 'ORGANY'
seek [+]
*################################# OPERACJE #################################
*----- parametry ------
_row_g=8
_col_l=9
_row_d=21
_col_p=68
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
*_top=[firma#ident_fir]
_top=[bof()]
_bot=[del#'+']
_stop=[+]
_sbot=[+]+[�]
_proc=[linia141()]
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
              zNAZWA_ORG=space(60)
           else
              zNAZWA_ORG=NAZWA_ORG
           endif
           *�������������������������������� GET ����������������������������������
           @ wiersz,9 get zNAZWA_ORG picture repl('!',60) valid v141_1()
           read_()
           if lastkey()=27
              exit
           endif
           *�������������������������������� REPL ���������������������������������
           if ins
              app()
           endif
           do BLOKADAR
           repl_([NAZWA_ORG],zNAZWA_ORG)
           commit_()
           unlock
           *�����������������������������������������������������������������������
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [                                                            ]
        enddo
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
   *################################ KASOWANIE #################################
   case kl=7.or.kl=46
        RECS=recno()
        sele firma
        locate all for ORGAN=RECS
        if .not. found()
           sele organy
           @ 1,47 say [          ]
   ColStb()
           center(23,[�                   �])
   ColSta()
           center(23,[K A S O W A N I E])
   ColStd()
           _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
           if _disp
              do BLOKADAR
              repl del with '-'
              unlock
              skip
              commit_()
              if &_bot
                 go top
              endif
           endif
        else
           kom(3,[*u],[ Kasowanie niemo&_z.liwe. S&_a. firmy przypisane do tego organu ])
           keyboard chr(27)
           inkey()
        endif
        sele organy
        @ 23,0
   *################################# SZUKANIE #################################
   case kl=-9.or.kl=247
        @ 1,47 say [          ]
   ColStb()
        center(23,[�                 �])
   ColSta()
        center(23,[S Z U K A N I E])
   ColStd()
        f10=space(60)
        @ _row,9 get f10 picture repl('!',60)
        read_()
        _disp=.not.empty(f10).and.lastkey()#27
        if _disp
           seek [+]+dos_l(f10)
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
        p[ 5]='   [Ins]...................dopisanie pozycji            '
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
function linia141
return NAZWA_ORG
***************************************************
function v141_1
if empty(zNAZWA_ORG)
   return .f.
endif
nr_rec=recno()
seek [+]+zNAZWA_ORG
fou=found()
rec=recno()
go nr_rec
if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Taki Organ Rejestrowy ju&_z. istnieje')
   set cursor on
   return .f.
endif
return .t.
*############################################################################
