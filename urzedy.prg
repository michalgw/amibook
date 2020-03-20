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

FUNCTION Urzedy()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say space(80)
@  4, 0 say padc('K A T A L O G   U R Z E D &__O. W   S K A R B O W Y C H',80)
@  5, 0 say space(80)
@  6, 0 say '     Miejscowo&_s.&_c.           Urz&_a.d Skarbowy         Ulica       KodU  Dom    Kod  '
@  7, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄ¿'
@  8, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@  9, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 10, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 11, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 12, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 13, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 14, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 15, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 16, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 17, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 18, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 19, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 20, 0 say '³                    ³                       ³               ³    ³     ³      ³'
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÙ'
@ 22, 0 say 'Bank:                KONTA: P.Doch.-                    P.VAT-                  '
*############################### OTWARCIE BAZ ###############################
select 4
do while.not.dostep('FIRMA')
enddo
do setind with 'FIRMA'
select 3
do while.not.dostep('PRAC')
enddo
do setind with 'PRAC'
select 2
do while.not.dostep('SPOLKA')
enddo
do setind with 'SPOLKA'
set orde to 2
select 1
do while.not.dostep('URZEDY')
enddo
do setind with 'URZEDY'
seek [+]
*################################# OPERACJE #################################
*----- parametry ------
_row_g=8
_col_l=1
_row_d=20
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
_top=[bof()]
_bot=[del#'+']
_stop=[+]
_sbot=[+]+[þ]
_proc=[linia131()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[linia131s]
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
        do while .t.
           *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
           if ins
              zMIEJSC_US=space(20)
              zURZAD=space(25)
              zULICA=space(20)
              zNR_DOMU=space(5)
              zKOD_POCZT=space(6)
              zBANK=space(30)
              zKONTODOCH=space(32)
              zKONTOVAT=space(32)
              zKODURZEDU=space(4)
           else
              zMIEJSC_US=MIEJSC_US
              zURZAD=URZAD
              zULICA=ULICA
              zNR_DOMU=NR_DOMU
              zKOD_POCZT=KOD_POCZT
              zBANK=BANK
              zKONTODOCH=KONTODOCH
              zKONTOVAT=KONTOVAT
              ZKODURZEDU=KODURZEDU
           endif
           *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
           @ wiersz,1 get zMIEJSC_US picture repl('!',20) valid v131_1()
           @ wiersz,22 get zURZAD picture "@S23 "+repl('!',25) valid v131_2()
           @ wiersz,46 get zULICA picture "@S15 "+repl('!',20) valid v131_3()
           @ wiersz,62 get zKODURZEDU picture '9999'
           @ wiersz,67 get zNR_DOMU picture 'XXXXX'
           @ wiersz,73 get zKOD_POCZT picture '99-999'
           @ 22,5  get zBANK picture "@S15 "+repl('!',30)
           @ 22,36 get zKONTODOCH picture "@S18 "+repl('!',32)
           @ 22,62 get zKONTOVAT picture "@S18 "+repl('!',32) when KONVA()
           read_()
           if lastkey()=27
              exit
           endif
           *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
           if ins
              app()
           endif
           do BLOKADAR
           repl_([MIEJSC_US],zMIEJSC_US)
           repl_([URZAD],zURZAD)
           repl_([ULICA],zULICA)
           repl_([NR_DOMU],zNR_DOMU)
           repl_([KOD_POCZT],zKOD_POCZT)
           repl_([BANK],zBANK)
           repl_([KONTODOCH],zKONTODOCH)
           repl_([KONTOVAT],zKONTOVAT)
           repl_([KODURZEDU],zKODURZEDU)
           commit_()
           unlock
           *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [                    ³                       ³               ³    ³     ³      ]
        enddo
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
   *################################ KASOWANIE #################################
   case kl=7.or.kl=46
        RECS=recno()
        sele firma
        locate all for skarb=RECS
        if .not. found()
           sele spolka
           locate all for skarb=RECS
           if .not. found()
              sele prac
              locate all for SKARB=RECS
              if .not. found()
                 sele urzedy
                 @ 1,47 say [          ]
   ColStb()
                 center(23,[þ                   þ])
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
                       skip -1
                    endif
                 endif
              else
                 kom(3,[*u],[ Kasowanie niemo&_z.liwe. S&_a. pracownicy przypisani do tego urz&_e.du ])
                 keyboard chr(27)
                 inkey()
              endif
           else
              kom(3,[*u],[ Kasowanie niemo&_z.liwe. S&_a. w&_l.a&_s.ciciele przypisani do tego urz&_e.du ])
              keyboard chr(27)
              inkey()
           endif
        else
           kom(3,[*u],[ Kasowanie niemo&_z.liwe. S&_a. firmy przypisane do tego urz&_e.du ])
           keyboard chr(27)
           inkey()
        endif
        sele urzedy
        @ 23,0
   *################################# SZUKANIE #################################
   case kl=-9.or.kl=247
        @ 1,47 say [          ]
   ColStb()
        center(23,[þ                 þ])
   ColSta()
        center(23,[S Z U K A N I E])
   ColStd()
        f10=space(20)
        @ _row,1 get f10 picture "!!!!!!!!!!!!!!!!!!!!"
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
function linia131
return MIEJSC_US+[³]+substr(URZAD,1,23)+[³]+substr(ULICA,1,15)+[³]+KODURZEDU+[³]+NR_DOMU+[³]+KOD_POCZT
*############################################################################
procedur linia131s
set color to w+
@ 22,5 say substr(BANK,1,15)
@ 22,36 say substr(KONTODOCH,1,18)
@ 22,62 say substr(KONTOVAT,1,18)
set color to
return
***************************************************
function v131_1
if empty(zMIEJSC_US)
   return .f.
endif
return .t.

***************************************************
function v131_2
if empty(zURZAD)
   return .f.
endif
nr_rec=recno()
seek [+]+zMIEJSC_US+zURZAD
fou=found()
rec=recno()
go nr_rec
if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Taki Urz&_a.d Skarbowy ju&_z. istnieje')
   set cursor on
   return .f.
endif
return .t.
***************************************************
function v131_3
return .not.empty(zULICA)
***************************************************
function KONVA
if empty(zKONTOVAT)
   zKONTOVAT=zKONTODOCH
endif
return .t.
*############################################################################
