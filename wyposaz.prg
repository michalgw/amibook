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
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                                                                                '
@  4, 0 say padc('E W I D E N C J A   W Y P O S A &__Z. E N I A - A K T U A L I Z A C J A',80)
@  5, 0 say '                                                                                '
@  6, 0 say ' Dzie&_n.   Nr                                                    Cena     Pozycja '
@  7, 0 say ' zakup dowodu               Nazwa wyposa&_z.enia                 zakupu     ksi&_e.gi '
@  8, 0 say ' �����������������������������������������������������������������������������Ŀ'
@  9, 0 say ' �  �          �                                        �               �      �'
@ 10, 0 say ' �  �          �                                        �               �      �'
@ 11, 0 say ' �  �          �                                        �               �      �'
@ 12, 0 say ' �  �          �                                        �               �      �'
@ 13, 0 say ' �  �          �                                        �               �      �'
@ 14, 0 say ' �  �          �                                        �               �      �'
@ 15, 0 say ' �  �          �                                        �               �      �'
@ 16, 0 say ' �  �          �                                        �               �      �'
@ 17, 0 say ' �  �          �                                        �               �      �'
@ 18, 0 say ' �  �          �                                        �               �      �'
@ 19, 0 say ' �  �          �                                        �               �      �'
@ 20, 0 say ' �  �          �                                        �               �      �'
@ 21, 0 say ' �  �          �                                        �               �      �'
@ 22, 0 say ' �������������������������������������������������������������������������������'
*############################### OTWARCIE BAZ ###############################
do while.not.dostep('WYPOSAZ')
enddo
do setind with 'WYPOSAZ'
seek [+]+ident_fir+param_rok+miesiac
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=2
_row_d=21
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28,13]
_top=[del#'+'.or.firma#ident_fir.or.rok#param_rok.or.mc#miesiac]
_bot=[del#'+'.or.firma#ident_fir.or.rok#param_rok.or.mc#miesiac]
_stop=[+]+ident_fir+param_rok+miesiac
_sbot=[+]+ident_fir+param_rok+miesiac+[�]
_proc=[linia61()]
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
   *################################## INSERT ##################################
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
              zDZIEN='  '
              zNUMER=space(10)
              zNAZWA=space(40)
              zCENA=0
              zPOZYCJA=0
           else
              zDZIEN=DZIEN
              zNUMER=NUMER
              zNAZWA=NAZWA
              zCENA=CENA
              zPOZYCJA=POZYCJA
           endif
           *�������������������������������� GET ����������������������������������
           @ wiersz,2 get zDZIEN picture '99'
           @ wiersz,5 get zNUMER picture '!!!!!!!!!!'
           @ wiersz,16 get zNAZWA picture '!'+repl('X',39)
           @ wiersz,57 get zCENA picture '   999999999.99'
           @ wiersz,73 get zPOZYCJA picture '999999'
           read_()
           if lastkey()=27
              exit
           endif
           *�������������������������������� REPL ���������������������������������
           if ins
              app()
           endif
           do BLOKADAR
           repl_([FIRMA],ident_fir)
           repl_([ROK],param_rok)
           repl_([MC],miesiac)
           repl_([DZIEN],zDZIEN)
           repl_([NUMER],zNUMER)
           repl_([NAZWA],zNAZWA)
           repl_([CENA],zCENA)
           repl_([POZYCJA],zPOZYCJA)
           commit_()
           unlock
           *�����������������������������������������������������������������������
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [  �          �                                        �               �      ]
        enddo
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
        @ 24,0
   *################################ KASOWANIE #################################
   case kl=7.or.kl=46
        RECS=recno()
        @ 1,47 say [          ]
   ColStb()
        center(23,[�                   �])
   ColSta()
        center(23,[K A S O W A N I E])
   ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           do BLOKADAR
           dele
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
   ColStd()
        f10=[  ]
        @ _row,2 get f10 picture [99]
        read_()
        _disp=left(f10,2)#[  ].and.lastkey()#27
        if _disp
           seek [+]+ident_fir+param_rok+miesiac+str(val(left(f10,2)),2)
           if &_bot
              skip -1
           endif
           _row=int((_row_g+_row_d)/2)
        endif
        @ 23,0
   *############################### WYDRUK WYPOSAZENIA #########################
   case kl=13
        begin sequence
              save screen to scr_
              do wypos
              restore screen from scr_
        end
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
        p[ 5]='   [Ins]...................nanoszenie zap&_l.aty           '
        p[ 6]='   [M].....................modyfikacja pozycji          '
        p[ 7]='   [Del]...................kasowanie pozycji            '
        p[ 8]='   [F10]...................szukanie                     '
        p[ 9]='   [Enter].................wydruk ewidencji za miesi&_a.c  '
        p[10]='   [Esc]...................wyj&_s.cie                      '
        p[11]='                                                        '
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
function linia61
return DZIEN+[�]+NUMER+[�]+NAZWA+[�]+kwota(CENA,15,2)+[�]+str(POZYCJA,6)
*############################################################################
