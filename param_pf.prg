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
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_P.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_PF()

   LOCAL bZusPodMieW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 say PadC( "P - poprzedni miesi¥c      B - bie¾¥cy miesi¥c", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bZusPodMieV := { | |
      LOCAL lRes, cKolor
      IF ( lRes := zzuspodmie $ 'BP' )
         @ 24, 0
         cKolor := SetColor( 'w+' )
         @ 4, 63 SAY iif( zzuspodmie == 'B', 'ie¾¥cy miesi¥c  ', 'oprzedni miesi¥c' )
      ENDIF
      RETURN lRes
   }
   LOCAL bZusPodNarW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 say PadC( "M - miesi©cznie            N - narastaj¥co", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bZusPodNarV := { | |
      LOCAL lRes, cKolor
      IF ( lRes := zzuspodnar $ 'MN' )
         @ 24, 0
         cKolor := SetColor( 'w+' )
         @ 5, 63 SAY iif( zzuspodnar == 'N', 'arastaj¥co', 'iesi©cznie' )
      ENDIF
      RETURN lRes
   }
   LOCAL bZusSklMieW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 say PadC( "B - bie¾¥cy miesi¥c      N - nast©pny miesi¥c", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bZusSklMieV := { | |
      LOCAL lRes, cKolor
      IF ( lRes := zzussklmie $ 'BN' )
         @ 24, 0
         cKolor := SetColor( 'w+' )
         @ 6, 63 SAY iif( zzussklmie == 'B', 'ie¾¥cy miesi¥c ', 'ast©pny miesi¥c' )
      ENDIF
      RETURN lRes
   }
   LOCAL bZusDekZMW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 say PadC( "D - wd parametr¢w programu     B - bie¾¥cy miesi¥c      W - miesi¥c wypˆaty", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bZusDekZMV := { | |
      LOCAL lRes, cKolor
      IF ( lRes := zzusdzm $ 'BDW' )
         @ 24, 0
         cKolor := SetColor( 'w+' )
         @ 17, 72 SAY iif( zzusdzm == 'B', 'ie¾¥cy  ', iif( zzusdzm == 'W', 'ypˆaty  ', 'omy˜lnie' ) )
      ENDIF
      RETURN lRes
   }


*############################# PARAMETRY POCZATKOWE #########################
if .not.file([param_p.mem])
   save to param_p all like parap_*
   return
endif
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
@  3,42 say 'ÍÍ Podstawa do zdrowotnego ÍÍÍÍÍÍÍÍÍÍÍ'
@ 10,42 say 'ÍÍ Stawki na ubezpieczenie wypadkowe Í'
@ 16,42 say 'ÍÍ Parametry deklaracji ZUS ÍÍÍÍÍÍÍÍÍÍ'
@ 11,42 say '                    finansuje: P&_l.atnik'
set colo to /w+
@ 11,73 say 'P&_l.atnik'
set colo to
@  4,42 say ' Doch¢d za                            '
@  5,42 say ' Doch¢d naliczaj                      '
@  6,42 say ' Skˆadki odliczaj w                   '

@ 12,42 say ' Na ubezpieczenia wypadkowe:          '
@ 13,42 say ' pracownik&_o.w                          '
@ 14,42 say ' w&_l.a&_s.cicieli                          '
@ 17,42 say ' Deklaracja za miesi¥c (B/W):         '
*################################# OPERACJE #################################
do say_pfirmy
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
zparap_puw=A->parap_puw
zparap_fuw=A->parap_fuw
zparap_fww=A->parap_fww
zzuspodmie := iif( A->zuspodmie $ 'BP', A->zuspodmie, 'P' )
zzuspodnar := iif( A->zuspodnar $ 'MN', A->zuspodnar, 'N' )
zzussklmie := iif( A->zussklmie $ 'BN', A->zussklmie, 'N' )
zzusdzm := iif( A->zusdzm $ 'BDW', A->zusdzm, 'D' )
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  4,62 get zzuspodmie PICTURE '!' WHEN Eval( bZusPodMieW ) VALID Eval( bZusPodMieV )
@  5,62 get zzuspodnar PICTURE '!' WHEN Eval( bZusPodNarW ) VALID Eval( bZusPodNarV )
@  6,62 get zzussklmie PICTURE '!' WHEN Eval( bZusSklMieW ) VALID Eval( bZusSklMieV )
*@ 15,65 get zparap_puw picture "99.99"
@ 13,75 get zparap_fuw picture "99.99"
@ 14,75 get zparap_fww picture "99.99"
@ 17,71 get zzusdzm PICTURE '!' WHEN Eval( bZusDekZMW ) VALID Eval( bZusDekZMV )
****************************
clear type
read_()
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
do BLOKADAR
repl_([A->parap_puw],0)
repl_([A->parap_fuw],zparap_fuw)
repl_([A->parap_fww],zparap_fww)
repl_([A->zuspodmie],zzuspodmie)
repl_([A->zuspodnar],zzuspodnar)
repl_([A->zussklmie],zzussklmie)
repl_([A->zusdzm],zzusdzm)

commit_()
unlock

m->parap_puw=zparap_puw
m->parap_fuw=zparap_fuw
m->parap_fww=zparap_fww
//m->zuspodmie=zzuspodmie
pzparap_dzm := iif( zzusdzm $ 'BW', zzusdzm, parap_dzm )
****************************
save to param_p all like parap_*
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do say_pfirmy
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
procedure say_pfirmy
clear type
set colo to w+
@ 4,62 say iif( A->zuspodmie == 'B', 'Bie¾¥cy miesi¥c  ', 'Poprzedni miesi¥c' )
@ 5,62 say iif( A->zuspodnar == 'N', 'Narastaj¥co', 'Miesi©cznie' )
@ 6,62 say iif( A->zussklmie == 'B', 'Bie¾¥cy miesi¥c ', 'Nast©pny miesi¥c' )
*@ 15,65 say parap_puw picture "99.99"
@ 13,75 say parap_fuw picture "99.99"
@ 14,75 say parap_fww picture "99.99"
@ 17,71 say iif( A->zusdzm == 'B', 'Bie¾¥cy  ', iif( A->zusdzm == 'W', 'Wypˆaty  ', 'Domy˜lnie' ) )
ColStd()
*############################################################################
