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
*±±±±±± TAB_KOLO ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul zmiany kolorow                                                      ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Tab_Kolo()

*############################# PARAMETRY POCZATKOWE #########################
*################################# GRAFIKA ##################################
*ColSta()
*@  2,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
*################################# OPERACJE #################################
kl=0
*ColSta()
*@ 1,47 say '[F1]-pomoc'
*ColStd()
do while kl#27
ColStd()
@  3,42 clear to 24,79
@  3,42 say '    Ustawienie kolorow:               '
@  3,66 get KINESKOP picture '!' when wKINE(3,66) valid vKINE(3,66)
clear type
read_()
if lastkey()=27
   return
endif
if KINESKOP$'KM'
   save to KOLOR all like KINESKOP
   zmienkolor()
   return
else

@  4,42 say '    Wpisz nowy symbol koloru   Symbole'
@  5,42 say ' 1.xxx -> xxx    6.xxx -> xxx  N  :   '
@  6,42 say ' 2.    ->        7.    ->      N+ :   '
@  7,42 say ' 3.    ->        8.    ->      B  :   '
@  8,42 say ' 4.    ->        9.    ->      B+ :   '
@  9,42 say ' 5.    ->       10.    ->      G  :   '
@ 10,42 say '    Schematy kolor.w programie G+ :   '
@ 11,42 say ' Err                           BG :   '
@ 12,42 say ' Inf                           BG+:   '
@ 13,42 say ' Inb                           R  :   '
@ 14,42 say ' Dlg                           R+ :   '
@ 15,42 say ' Std                           RB :   '
@ 16,42 say ' Sta                           RB+:   '
@ 17,42 say ' Sti                           GR :   '
@ 18,42 say ' Stb                           GR+:   '
@ 19,42 say ' Pro                           W  :   '
@ 20,42 say ' Inv                           W+ :   '
@ 21,42 say '                                      '
@ 22,42 say '        Uzyc nowe kolory (T/N)        '
set colo to N/N
@ 5,77 say 'T '
set colo to W/N
@ 5,79 say 'T'
set colo to N+/W
@ 6,77 say 'T '
set colo to N+/N
@ 6,79 say 'T'
set colo to N/B
@ 7,77 say 'T '
set colo to W/B
@ 7,79 say 'T'
set colo to B+/W
@ 8,77 say 'T  '
set colo to B+/N
@ 8,79 say 'T'
set colo to N/G
@ 9,77 say 'T '
set colo to W/G
@ 9,79 say 'T'
set colo to G+/W
@ 10,77 say 'T '
set colo to G+/N
@ 10,79 say 'T'
set colo to N/BG
@ 11,77 say 'T '
set colo to W/BG
@ 11,79 say 'T'
set colo to BG+/W
@ 12,77 say 'T '
set colo to BG+/N
@ 12,79 say 'T'
set colo to N/R
@ 13,77 say 'T '
set colo to W/R
@ 13,79 say 'T'
set colo to R+/W
@ 14,77 say 'T '
set colo to R+/N
@ 14,79 say 'T'
set colo to N/RB
@ 15,77 say 'T '
set colo to W/RB
@ 15,79 say 'T'
set colo to RB+/W
@ 16,77 say 'T '
set colo to RB+/N
@ 16,79 say 'T'
set colo to N/GR
@ 17,77 say 'T '
set colo to W/GR
@ 17,79 say 'T'
set colo to GR+/W
@ 18,77 say 'T '
set colo to GR+/N
@ 18,79 say 'T'
set colo to N/W
@ 19,77 say 'T '
set colo to W/W
@ 19,79 say 'T'
set colo to W+/W
@ 20,77 say 'T '
set colo to W+/N
@ 20,79 say 'T'

   say_kolt()
*   kl=inkey()
*   do case
   *############################### MODYFIKACJA ################################
*   case kl=109.or.kl=77
        @ 1,47 say [          ]
        ColStb()
        center(23,[þ                       þ])
        ColSta()
        center(23,[M O D Y F I K A C J A])
        ColStd()
        begin sequence
        *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
              zCCCN=padr(CCCN,3)
              zCCCW=padr(CCCW,3)
              zCCCG=padr(CCCG,3)
              zCCCGR=padr(CCCGR,3)
              zCCCGRJ=padr(CCCGRJ,3)
              zCCCR=padr(CCCR,3)
              zCCCRB=padr(CCCRB,3)
              zCCCRBJ=padr(CCCRBJ,3)
              zCCCBG=padr(CCCBG,3)
              zCCCB=padr(CCCB,3)
              *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
              @  5,52 get zCCCN picture '!!!'
              @  6,52 get zCCCW picture '!!!'
              @  7,52 get zCCCG picture '!!!'
              @  8,52 get zCCCGR picture '!!!'
              @  9,52 get zCCCGRJ picture '!!!'
              @  5,68 get zCCCR picture '!!!'
              @  6,68 get zCCCRB picture '!!!'
              @  7,68 get zCCCRBJ picture '!!!'
              @  8,68 get zCCCBG picture '!!!'
              @  9,68 get zCCCB picture '!!!'
              ****************************
              clear type
              read_()
              if lastkey()=27
                 break
              endif
              *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
              CCCN=alltrim(zCCCN)
              CCCW=alltrim(zCCCW)
              CCCG=alltrim(zCCCG)
              CCCGR=alltrim(zCCCGR)
              CCCGRJ=alltrim(zCCCGRJ)
              CCCR=alltrim(zCCCR)
              CCCRB=alltrim(zCCCRB)
              CCCRBJ=alltrim(zCCCRBJ)
              CCCBG=alltrim(zCCCBG)
              CCCB=alltrim(zCCCB)
              *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
        say_kolt()
              zSAVEUSCOL=' '
              @ 22,73 get zSAVEUSCOL picture '!' valid zSAVEUSCOL$'TN'
              ****************************
              clear type
              read_()
              if lastkey()=27
                 KINESKOP='K'
                 zmienkolor()
                 break
              endif
              if zSAVEUSCOL='T'
                 KINESKOP='U'
                 save to KOLOR all like KINESKOP
                 save to KOLUZYT all like CCC*
                 zmienkolor()
                 break
              else
                 KINESKOP='K'
                 zmienkolor()
                 break
              endif
        end
        @ 23,0
        *################################### POMOC ##################################
*   endcase
endif
enddo
close_()
*################################## FUNKCJE #################################
function say_kolt
clear type
*set colo to w+
set colo to w+/&CCCN
@ 5,45 say padr(CCCN,3)
set colo to w+/&CCCW
@ 6,45 say padr(CCCW,3)
set colo to w+/&CCCG
@ 7,45 say padr(CCCG,3)
set colo to w+/&CCCGR
@ 8,45 say padr(CCCGR,3)
set colo to w+/&CCCGRJ
@ 9,45 say padr(CCCGRJ,3)

set colo to w+/&CCCR
@ 5,61 say padr(CCCR,3)
set colo to w+/&CCCRB
@ 6,61 say padr(CCCRB,3)
set colo to w+/&CCCRBJ
@ 7,61 say padr(CCCRBJ,3)
set colo to w+/&CCCBG
@ 8,61 say padr(CCCBG,3)
set colo to w+/&CCCB
@ 9,61 say padr(CCCB,3)

       CColErr='&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
       CColInf='&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
       CColInb='&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
       CColDlg='&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCW'
       CColStd='&CCCGR/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCW'
       CColSta='&CCCG/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
       CColSti='&CCCN/&CCCG,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
       CColStb='&CCCG*/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
       CColPro='&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCGR'
       CColInv='&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'

ColErr()
@ 11,47 say padc('Przykladowy napis',20)
ColInf()
@ 12,47 say padc('Przykladowy napis',20)
ColInb()
@ 13,47 say padc('Przykladowy napis',20)
ColDlg()
@ 14,47 say padc('Przykladowy napis',20)
ColStd()
@ 15,47 say padc('Przykladowy napis',20)
ColSta()
@ 16,47 say padc('Przykladowy napis',20)
ColSti()
@ 17,47 say padc('Przykladowy napis',20)
ColStb()
@ 18,47 say padc('Przykladowy napis',20)
ColPro()
@ 19,47 say padc('Przykladowy napis',20)
ColInv()
@ 20,47 say padc('Przykladowy napis',20)

ColStd()
return .t.
***************************************************
function colvp_1
return .not.[ ]$alltrim(zparam_has)
***************************************************
function colvp_2
if lastkey()=5
return .t.
endif
return .not.[ ]$zparam_rok
***************************************************
function colvp_3
if lastkey()=5
return .t.
endif
   if .not.zparam_aut$[TN]
   zparam_aut=param_aut
   return .f.
   endif
set colo to w+
@ 10,57 say iif(zparam_aut=[T],[ak],[ie])
ColStd()
return .t.
***************************************************
/*function colvp_3v
if lastkey()=5
return .t.
endif
   if .not.zparam_vis$[TN]
   zparam_vis=param_vis
   return .f.
   endif
set colo to w+
@ 10,70 say iif(zparam_vis=[T],[ak],[ie])
ColStd()
return .t.*/
***************************************************
function colvp_41
if lastkey()=5
return .t.
endif
   if zparam_dru#'IBM'.and.zparam_dru#'PCL'
      kom(2,[*u],[ Wpisz "IBM" lub "PCL" ])
      return .f.
   endif
   if zparam_dru='PCL'
      zparam_cal=10
   endif
return .t.
***************************************************
function colvp_4
if lastkey()=5
return .t.
endif
   if zparam_cal#10.and.zparam_cal#15
   kom(2,[*u],[ 10 lub 15 ])
   return .f.
   endif
return .t.
***************************************************
function colvp_5
if lastkey()=5
return .t.
endif
   if .not.zparam_lp$[TN]
   zparam_lp=param_lp
   return .f.
   endif
set colo to w+
@ 19,61 say iif(zparam_lp=[T],[ak],[ie])
ColStd()
return .t.
*************************************
func wKINE
*************************************
para wik,kok
ColInf()
@ 24,0 say padc('Wpisz: K - kolory standardowe , M - czarno-biale menu, U - uzytkownika',80,' ')
ColStd()
@ wik,kok+1 say iif(KINESKOP='K','olory     ',iif(KINESKOP='M','ono       ','zytkownika'))
return .t.
*************************************
func vKINE
*************************************
para wik,kok
R=.f.
if KINESKOP$'KMU'
   ColStd()
   @ wik,kok+1 say iif(KINESKOP='K','olory     ',iif(KINESKOP='M','ono       ','zytkownika'))
   @ 24,0 clear
   R=.t.
endif
return R

*############################################################################
