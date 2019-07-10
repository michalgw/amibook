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
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_P.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_P()

*############################# PARAMETRY POCZATKOWE #########################
if .not.file([param_p.mem])
   save to param_p all like parap_*
   return
endif
*################################# GRAFIKA ##################################
@  3,42 say ' Parametry og&_o.lne                     '
@  4,42 say '-koszt uzyskania przychodu            '
@  5,42 say '-miesi&_e.czne odliczenie podatku        '
@  6,42 say '-staw.zas.chorobowego (do33dni)     % '
@  7,42 say '-stawka podatku dochodowego         % '
@  8,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍUbezpieczonyÍP&_l.atnik'
set colo to /w+
@  8,60 say 'Ubezpieczony'
@  8,73 say 'P&_l.atnik'
set colo to
@  9,42 say ' Dla    podstawa do ZUS(51,53)        '
@ 10,42 say ' wlasc.          do zdrow.(52)        '
@ 11,42 say '-emerytalne                           '
@ 12,42 say '-rentowe                              '
@ 13,42 say '-zdrowotne do ZUS                     '
@ 14,42 say '-zdrowotne do odliczen                '
@ 15,42 say '-chorobowe                            '
@ 16,42 say '-wypadkowe - wpisz w parametrach firmy'
@ 17,42 say '-III filar                            '
@ 18,42 say ' Na fundusze:                         '
@ 19,42 say '-Fundusz Pracy                        '
@ 20,42 say '-Fundusz G&__S.P                          '
@ 21,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 22,42 say ' Domy&_s.lny symbol Kasy Chorych         '
*################################# OPERACJE #################################
do say_pr
kl=0
do while kl#27
ColSta()
@ 1,47 say '[F1]-pomoc'
ColStd()
kl=inkey(0)
do case
*############################### MODYFIKACJA ################################
              case kl=109.or.kl=77
@ 1,47 say [          ]
   ColStb()
   center(23,[þ                       þ])
   ColSta()
     center(23,[M O D Y F I K A C J A])
     ColStd()
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
zparap_p51=parap_p51
zparap_p52=parap_p52
zparap_kos=parap_kos
zparap_odl=parap_odl
zparap_pod=parap_pod
zparap_cho=parap_cho
zparap_puz=parap_puz
zparap_pzk=parap_pzk
zparap_pue=parap_pue
zparap_pur=parap_pur
zparap_puc=parap_puc
zparap_puw=parap_puw
zparap_pfp=parap_pfp
zparap_pfg=parap_pfg
zparap_pf3=parap_pf3
zparap_fuz=parap_fuz
zparap_fue=parap_fue
zparap_fur=parap_fur
zparap_fuc=parap_fuc
zparap_fuw=parap_fuw
zparap_fww=parap_fww
zparap_ffp=parap_ffp
zparap_ffg=parap_ffg
zparap_ff3=parap_ff3
zparap_rkc=parap_rkc
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  4,73 get zparap_kos picture "9999.99" range 0,9999
@  5,73 get zparap_odl picture "9999.99" range 0,9999
@  6,75 get zparap_cho picture '99'
@  7,75 get zparap_pod picture '99'
@  9,73 get zparap_p51 picture "9999.99" range 0,9999
@ 10,73 get zparap_p52 picture "9999.99" range 0,9999
@ 11,65 get zparap_pue picture "99.99"
@ 12,65 get zparap_pur picture "99.99"
@ 13,65 get zparap_puz picture "99.99"
@ 14,65 get zparap_pzk picture "99.99"
@ 15,65 get zparap_puc picture "99.99"
*@ 16,65 get zparap_puw picture "99.99"
@ 17,65 get zparap_pf3 picture "99.99"
@ 19,65 get zparap_pfp picture "99.99"
@ 20,65 get zparap_pfg picture "99.99"
@ 11,75 get zparap_fue picture "99.99"
@ 12,75 get zparap_fur picture "99.99"
@ 13,75 get zparap_fuz picture "99.99"
@ 15,75 get zparap_fuc picture "99.99"
*@ 15,75 get zparap_fuw picture "99.99"
*@ 16,75 get zparap_fww picture "99.99"
@ 17,75 get zparap_ff3 picture "99.99"
@ 19,75 get zparap_ffp picture "99.99"
@ 20,75 get zparap_ffg picture "99.99"
@ 22,75 get zparap_rkc picture "99!"
****************************
clear type
read_()
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
*do BLOKADAR
*repl_([A->parap_puw],zparap_puw)
*repl_([A->parap_fuw],zparap_fuw)
*repl_([A->parap_fww],zparap_fww)
*commit_()
*unlock

parap_p51=zparap_p51
parap_p52=zparap_p52
parap_kos=zparap_kos
parap_odl=zparap_odl
parap_pod=zparap_pod
parap_cho=zparap_cho
parap_puz=zparap_puz
parap_pzk=zparap_pzk
parap_pue=zparap_pue
parap_pur=zparap_pur
parap_puc=zparap_puc
parap_puw=zparap_puw
parap_pfp=zparap_pfp
parap_pfg=zparap_pfg
parap_pf3=zparap_pf3
parap_fuz=zparap_fuz
parap_fue=zparap_fue
parap_fur=zparap_fur
parap_fuc=zparap_fuc
parap_fuw=zparap_fuw
parap_fww=zparap_fww
parap_ffp=zparap_ffp
parap_ffg=zparap_ffg
parap_ff3=zparap_ff3
parap_rkc=zparap_rkc
****************************
save to param_p all like parap_*
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do say_pr
@ 23,0
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                             '
p[ 2]='     [M].....................modyfikacja     '
p[ 3]='     [Esc]...................wyj&_s.cie         '
p[ 4]='                                             '
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
ColStd()
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
procedure say_pr
clear type
set colo to w+
@  4,73 say parap_kos pict '9999.99'
@  5,73 say parap_odl pict '9999.99'
@  6,75 say parap_cho pict [99]
@  7,75 say parap_pod pict [99]
@  9,73 say parap_p51 picture "9999.99"
@ 10,73 say parap_p52 picture "9999.99"
@ 11,65 say parap_pue picture "99.99"
@ 12,65 say parap_pur picture "99.99"
@ 13,65 say parap_puz picture "99.99"
@ 14,65 say parap_pzk picture "99.99"
@ 15,65 say parap_puc picture "99.99"
*@ 15,65 say parap_puw picture "99.99"
@ 17,65 say parap_pf3 picture "99.99"
@ 19,65 say parap_pfp picture "99.99"
@ 20,65 say parap_pfg picture "99.99"
@ 11,75 say parap_fue picture "99.99"
@ 12,75 say parap_fur picture "99.99"
@ 13,75 say parap_fuz picture "99.99"
@ 15,75 say parap_fuc picture "99.99"
*@ 15,75 say parap_fuw picture "99.99"
*@ 16,75 say parap_fww picture "99.99"
@ 17,75 say parap_ff3 picture "99.99"
@ 19,75 say parap_ffp picture "99.99"
@ 20,75 say parap_ffg picture "99.99"
@ 22,75 say parap_rkc picture "99!"
ColStd()
*############################################################################
