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

FUNCTION EwidWyp()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                                                                                '
@  4, 0 say padc('E W I D E N C J A   W Y P O S A &__Z. E N I A',80)
@  5, 0 say '                                                                                '
@  6, 0 say 'Data zakupu     Nr                                             Cena     Pozycja '
@  7, 0 say '(rrrr.mm.dd)  dowodu           Nazwa wyposa&_z.enia              zakupu     ksi&_e.gi '
@  8, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄ¿'
@  9, 0 say '³          ³          ³                                 ³               ³      ³'
@ 10, 0 say '³          ³          ³                                 ³               ³      ³'
@ 11, 0 say '³          ³          ³                                 ³               ³      ³'
@ 12, 0 say '³          ³          ³                                 ³               ³      ³'
@ 13, 0 say '³          ³          ³                                 ³               ³      ³'
@ 14, 0 say '³          ³          ³                                 ³               ³      ³'
@ 15, 0 say '³          ³          ³                                 ³               ³      ³'
@ 16, 0 say '³          ³          ³                                 ³               ³      ³'
@ 17, 0 say '³          ³          ³                                 ³               ³      ³'
@ 18, 0 say '³          ³          ³                                 ³               ³      ³'
@ 19, 0 say '³          ³          ³                                 ³               ³      ³'
@ 20, 0 say '³          ³          ³                                 ³               ³      ³'
@ 21, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
if dostep('WYPOSAZ')
   do setind with 'WYPOSAZ'
   seek [+]+ident_fir
else
   close_()
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=1
_row_d=20
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28,13]
_top=[del#'+'.or.firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia62()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[linia62s]
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
              zROK=param_rok
              zMC='  '
              zDZIEN='  '
              zNUMER=space(10)
              zNAZWA=space(40)
              zCENA=0
              zPOZYCJA=0
              zDATAKAS=ctod('    .  .  ')
              zPRZYCZYNA=space(30)
           else
              zROK=ROK
              zMC=MC
              zDZIEN=DZIEN
              zNUMER=NUMER
              zNAZWA=NAZWA
              zCENA=CENA
              zPOZYCJA=POZYCJA
              zDATAKAS=DATAKAS
              zPRZYCZYNA=PRZYCZYNA
           endif
           *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
           @ 22, 0 say 'LIKWIDACJA - data:           przyczyna:                                         '
           @ wiersz,1 get zROK picture '9999'
           @ wiersz,6 get zMC picture '99' valid val(zMC)>=1 .and. val(zMC)<=12
           @ wiersz,9 get zDZIEN picture '99' valid vDZIEN()
           @ wiersz,12 get zNUMER picture '!!!!!!!!!!'
           @ wiersz,23 get zNAZWA picture '@S33 !'+repl('X',39)
           @ wiersz,57 get zCENA picture '   999999999.99'
           @ wiersz,73 get zPOZYCJA picture '999999'
           @ 22,18 get zDATAKAS picture '9999.99.99'
           @ 22,39 get zPRZYCZYNA picture '!'+repl('X',29)
           read_()
           if lastkey()=27
              exit
           endif
           *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
           if ins
              app()
           endif
           do BLOKADAR
           repl_([FIRMA],ident_fir)
           repl_([ROK],zROK)
           repl_([MC],str(val(zMC),2))
           repl_([DZIEN],str(val(zDZIEN),2))
           repl_([NUMER],zNUMER)
           repl_([NAZWA],zNAZWA)
           repl_([CENA],zCENA)
           repl_([POZYCJA],zPOZYCJA)
           repl_([DATAKAS],zDATAKAS)
           repl_([PRZYCZYNA],zPRZYCZYNA)
           commit_()
           unlock
           *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [          ³          ³                                 ³               ³      ]
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
        center(23,[þ                   þ])
ColSta()
        center(23,[K A S O W A N I E])
ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           do BLOKADAR
           dele
*          pack
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
        center(23,[þ                 þ])
ColSta()
        center(23,[S Z U K A N I E])
ColStd()
        f10=[    ]
        ColStd()
        @ _row,1 get f10 picture [9999]
        read_()
        _disp=left(f10,4)#[  ].and.lastkey()#27
        if _disp
           seek [+]+ident_fir+str(val(left(f10,4)),4)
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
              RECS=recno()
              do ewidwypw
              go RECS
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
        p[ 5]='   [Ins]...................dopisanie pozycji            '
        p[ 6]='   [M].....................modyfikacja pozycji          '
        p[ 7]='   [Del]...................kasowanie pozycji            '
        p[ 8]='   [F10]...................szukanie                     '
        p[ 9]='   [Enter].................wydruk ewidencji             '
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
func vDZIEN
if zdzien=[  ]
   zdzien=str(day(date()),2)
   set color to i
   @ wiersz,9 say zDZIEN
   set color to
endif
if val(zdzien)<1.or.val(zdzien)>msc(val(zMC))
   zdzien=[  ]
   return .f.
endif
return .t.
*############################################################################
function linia62
return ROK+'.'+MC+'.'+DZIEN+[³]+NUMER+[³]+SUBSTR(NAZWA,1,33)+[³]+kwota(CENA,15,2)+[³]+str(POZYCJA,6)
*############################################################################
function linia62s
if dtoc(DATAKAS)<>'    .  .  ' .or. len(alltrim(PRZYCZYNA))>0
   @ 22, 0 say 'LIKWIDACJA - data:           przyczyna:                                         '
   set color to w+
   @ 22,18 SAY DATAKAS
   @ 22,39 SAY PRZYCZYNA
   set color to
else
   @ 22,0 clear
endif
return
*############################################################################
