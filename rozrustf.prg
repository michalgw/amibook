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
*±±±±±± USTAWIENIA KONTROLI ROZRACHUNKOW DOMYSLNE ±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku FIRMA.dbf               ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*############################# PARAMETRY POCZATKOWE #########################
select 1
if dostep('FIRMA')
   set inde to firma
   go val(ident_fir)
else
   close_()
   return
endif
@  3,42 clear to 22,79
*################################# GRAFIKA ##################################
@  3,42 say 'ÍÍÍÍÍÍÍÍÍ SLEDZENIE ZAPLAT ÍÍÍÍÍÍÍÍÍÍÍ'
@  4,42 say ' Ustaw tutaj najcz&_e.&_s.ciej wyst&_e.puj&_a.ce  '
@  5,42 say ' przypadki.Podczas ksi&_e.gowania mo&_z.esz '
@  6,42 say ' wybra&_c. inn&_a. opcj&_e.. Przyk&_l.ad: zwykle  '
@  7,42 say ' do ksi&_e.gi ksi&_e.gowane s&_a. jedynie dok. '
@  8,42 say ' zaplac.kt&_o.re nie wymagaj&_a. kontroli'
@  9,42 say ' Niepotrzebny nadmiar zapis&_o.w w kontr.'
@ 10,42 say ' rozrachunk&_o.w doda ci du&_z.o pracy przy '
@ 11,42 say ' nanoszeniu zap&_l.at oraz znacznie po-  '
@ 12,42 say ' wi&_e.kszy pliki co wp&_l.ynie na szybko&_s.&_c. '
@ 13,42 say ' pracy prog.r&_o.wnie&_z. podczas ksiegowa&_n..'
@ 14,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
@ 15,42 say ' Podczas ksi&_e.gowania do KSI&__E.GI        '
@ 16,42 say ' domy&_s.lnie kontrolowa&_c..:              '
@ 17,42 say ' Podczas ksi&_e.gowania do REJ.SPRZEDA&__Z.Y '
@ 18,42 say ' domy&_s.lnie kontrolowa&_c..:              '
@ 19,42 say ' Podczas ksi&_e.gowania do REJ.ZAKUP&__O.W   '
@ 20,42 say ' domy&_s.lnie kontrolowa&_c..:              '
@ 21,42 say ' Podczas wystawiania FAKTUR           '
@ 22,42 say ' domy&_s.lnie kontrolowa&_c..:              '
*################################# OPERACJE #################################
do say_rozrus
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
pzROZRZAPK=A->ROZRZAPK
pzROZRZAPS=A->ROZRZAPS
pzROZRZAPZ=A->ROZRZAPZ
pzROZRZAPF=A->ROZRZAPF
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ 16,67 get pzROZRZAPK picture "!" when wROZRJAK() valid vROZRJAK('pzROZRZAPK')
@ 18,67 get pzROZRZAPS picture "!" when wROZRJAK() valid vROZRJAK('pzROZRZAPS')
@ 20,67 get pzROZRZAPZ picture "!" when wROZRJAK() valid vROZRJAK('pzROZRZAPZ')
@ 22,67 get pzROZRZAPF picture "!" when wROZRJAK() valid vROZRJAK('pzROZRZAPF')
****************************
clear type
read_()
if lastkey()=27
   pzROZRZAPK=A->ROZRZAPK
   pzROZRZAPS=A->ROZRZAPS
   pzROZRZAPZ=A->ROZRZAPZ
   pzROZRZAPF=A->ROZRZAPF
   break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
do BLOKADAR
repl_([A->ROZRZAPK],pzROZRZAPK)
repl_([A->ROZRZAPS],pzROZRZAPS)
repl_([A->ROZRZAPZ],pzROZRZAPZ)
repl_([A->ROZRZAPF],pzROZRZAPF)
commit_()
unlock

                             end
do say_rozrus
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
procedure say_rozrus
clear type
set colo to w+
@ 16,67 say ROZRZAPK+iif(ROZRZAPK='T','ak           ',iif(ROZRZAPK='N','ie           ','Pytaj przy wp'))
@ 18,67 say ROZRZAPS+iif(ROZRZAPS='T','ak           ',iif(ROZRZAPS='N','ie           ','Pytaj przy wp'))
@ 20,67 say ROZRZAPZ+iif(ROZRZAPZ='T','ak           ',iif(ROZRZAPZ='N','ie           ','Pytaj przy wp'))
@ 22,67 say ROZRZAPF+iif(ROZRZAPF='T','ak           ',iif(ROZRZAPF='N','ie           ','Pytaj przy wp'))
ColStd()
*############################################################################
func wROZRJAK
ColInf()
@ 24,0 say padc('Wpisz: T-kontroluj stan zap&_l.at, N-nie kontroluj stanu zap&_l.at, Spacja-pytaj',80,' ')
ColStd()
return .t.
***************************************************
func vROZRJAK
para vrozrpole
R=.t.
if &vROZRPOLE.<>'T'.and.&vROZRPOLE.<>'N'.and.&vROZRPOLE.<>' '
   ColInf()
   @ 24,0 say padc('Wpisz: T-kontroluj stan zap&_l.at, N-nie kontroluj stanu zap&_l.at, Spacja-pytaj',80,' ')
   ColStd()
   R=.f.
else
   do case
   case vROZRPOLE='pzROZRZAPK'
        @ 16,68 say iif(pzROZRZAPK='T','ak           ',iif(pzROZRZAPK='N','ie           ','Pytaj przy wp'))
        @ 24,0 clear
   case vROZRPOLE='pzROZRZAPS'
        @ 18,68 say iif(pzROZRZAPS='T','ak           ',iif(pzROZRZAPS='N','ie           ','Pytaj przy wp'))
        @ 24,0 clear
   case vROZRPOLE='pzROZRZAPZ'
        @ 20,68 say iif(pzROZRZAPZ='T','ak           ',iif(pzROZRZAPZ='N','ie           ','Pytaj przy wp'))
        @ 24,0 clear
   case vROZRPOLE='pzROZRZAPF'
        @ 22,68 say iif(pzROZRZAPF='T','ak           ',iif(pzROZRZAPF='N','ie           ','Pytaj przy wp'))
        @ 24,0 clear
   endcase
endif
return R
