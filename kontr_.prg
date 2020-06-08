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

FUNCTION Kontr_()

local getlist:={}
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,rec,fou
SZUK="del='+'.and.firma=ident_fir"
CurrCur=setcursor(0)
@ 1,47 say [          ]
if del#[+]
   kom(3,[*u],[ Brak kontrahent&_o.w w katalogu ])
   keyboard chr(27)
   inkey()
   return
endif
*################################# GRAFIKA ##################################
CURR=ColStd()
@  8, 0 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@  9, 0 say '°                                                                              °'
@ 10, 0 say '°                                                                              °'
@ 11, 0 say '°                                                                              °'
@ 12, 0 say '°                                                                              °'
@ 13, 0 say '°                                                                              °'
@ 14, 0 say '°                                                                              °'
@ 15, 0 say '°                                                                              °'
@ 16, 0 say '°                                                                              °'
@ 17, 0 say '°                                                                              °'
@ 18, 0 say '°                                                                              °'
@ 19, 0 say '°                                                                              °'
@ 20, 0 say '°                                                                              °'
@ 21, 0 say '°                                                                              °'
@ 22, 0 say '°Export/Import:°°°°°°°°°°°°°°Kod kraju:°°°°°°°°°°°°°°Obroty z UE:°°°°°°°°°°°°°°°'
ColInf()
if param_aut=[T]
   center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej","")+"  [Spacja]-nowy")
else
   center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej",""))
endif
ColStd()
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=1
_row_d=21
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-3,-9,247,28,13,32,7,46]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia15()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[linia15ko]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27.and.kl#13.and.kl#32
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
*############################### KASOWANIE #################################
   case kl=7.or.kl=46
        @ 1,47 say [          ]
        @ 23,0
        ColStb()
        center(23,[þ                   þ])
        ColSta()
        center(23,[K A S O W A N I E])
        ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           do BLOKADAR
           del()
           COMMIT
           unlock
           skip
           commit_()
           if &_bot
              skip -1
           endif
           if &_bot
              keyboard chr(27)
              inkey()
              exit
           endif
        endif
        @ 23,0
        ColInf()
        if param_aut=[T]
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej","")+"  [Spacja]-nowy")
        else
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej",""))
        endif
        ColStd()
*################################# SZUKANIE #################################
   case kl=-9.or.kl=247
        @ 1,47 say [          ]
        @ 23,0
        ColStb()
        center(23,[þ                 þ])
        ColSta()
        center(23,[S Z U K A N I E])
        ColStd()
        zzNAZWA=space(70)
        zzADRES=space(40)
        zzNR_IDENT=space(30)
        declare pp[3]
        *---------------------------------------
        pp[ 1]=' Nazwa:                                                                      '
        pp[ 2]=' Adres:                                                                      '
        pp[ 3]='   NIP:                                                                      '
        *---------------------------------------
        set color to N/W,W+/W,,,N/W
        i=3
        j=22
        do while i>0
           if type('pp[i]')#[U]
              center(j,pp[i])
              j=j-1
           endif
           i=i-1
        enddo
        setcursor(1)
        ColStd()
        @ 20,8 get zzNAZWA pict replicate('!',70)
        @ 21,8 get zzADRES pict replicate('!',40)
        @ 22,8 get zzNR_IDENT pict replicate('!',30)
        read
        setcursor(0)
        REC=recno()
        if lastkey()#27.and.lastkey()#28
           go top
           SZUK="del='+'.and.firma=ident_fir"
           seek '+'+ident_fir
           if zzNAZWA<>space(70)
              aNAZWA=alltrim(zzNAZWA)
              SZUK=SZUK+'.and.aNAZWA$upper(NAZWA)'
           endif
           if zzADRES<>space(40)
              aADRES=alltrim(zzADRES)
              SZUK=SZUK+'.and.aADRES$upper(ADRES)'
           endif
           if zzNR_IDENT<>space(30)
              aNR_IDENT=alltrim(zzNR_IDENT)
              SZUK=SZUK+'.and.aNR_IDENT$upper(NR_IDENT)'
           endif
           locate all for &SZUK
           if .not.found()
              go REC
           endif
        else
           go REC
        endif
        @ 23,0
        ColInf()
        if param_aut=[T]
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej","")+"  [Spacja]-nowy")
        else
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej",""))
        endif
        ColStd()
*################################# DALSZE SZUKANIE #################################
   case kl=-3
        REC=recno()
        if SZUK#"del='+'.and.firma=ident_fir"
           skip 1
           locate all for &SZUK rest
           if .not.found()
              go REC
           endif
        else
           do komun with 'Nie okreslono kryteriow poszukiwania. Wprowadz kryteria (klawisz F10)'
        endif
        @ 23,0
        ColInf()
        if param_aut=[T]
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej","")+"  [Spacja]-nowy")
        else
           center(23,"[Enter]-akceptacja  [F10]-szukanie"+iif(SZUK#"del='+'.and.firma=ident_fir","  [F4]-szukaj dalej",""))
        endif
        ColStd()
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
        p[ 5]='   [Del]...................kasowanie pozycji            '
        p[ 6]='   [Enter].................akceptacja                   '
        p[ 7]='   [F10]...................szukanie                     '
        p[ 8]='   [F4]....................szukanie - kontynuacja       '
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
setcursor(CurrCur)
setcolor(CURR)
*################################## FUNKCJE #################################
function linia15
return substr(NAZWA,1,32)+[ ]+substr(ADRES,1,29)+[ ]+substr(NR_IDENT,1,13)+[ ]+EXPORT
*****************************************************************************
proc linia15ko
@ 22,15 say iif(EXPORT='T','Tak','Nie')
@ 22,39 say KRAJ
@ 22,65 say iif(UE='T','Tak','Nie')
*############################################################################
