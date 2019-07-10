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

FUNCTION Tab_Doch()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@ 3,42 clear to 22,79
@  5,30 clear TO 20,79
@  6,32 say 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
@  7,32 say 'º Podstawa ³Pd³Odl. od ³Deg³  Kwota  ³  Kwota  º'
@  8,32 say 'ºopodatkow.³% ³podatku ³   ³ degr.#1 ³ degr.#2 º'
@  9,32 say 'ºÄÄÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄº'
@ 10,32 say 'º          ³  ³        ³   ³         ³         º'
@ 11,32 say 'º          ³  ³        ³   ³         ³         º'
@ 12,32 say 'º          ³  ³        ³   ³         ³         º'
@ 13,32 say 'º          ³  ³        ³   ³         ³         º'
@ 14,32 say 'º          ³  ³        ³   ³         ³         º'
@ 15,32 say 'º          ³  ³        ³   ³         ³         º'
@ 16,32 say 'º          ³  ³        ³   ³         ³         º'
@ 17,32 say 'º          ³  ³        ³   ³         ³         º'
@ 18,32 say 'º          ³  ³        ³   ³         ³         º'
@ 19,32 say 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
*############################### OTWARCIE BAZ ###############################
do while.not.dostep('TAB_DOCH')
enddo
set inde to tab_doch
*################################# OPERACJE #################################
*----- parametry ------
_row_g=10
_col_l=33
_row_d=18
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,22,48,77,109,7,46,28]
_top=[.f.]
_bot=[del#'+']
_stop=[]
_sbot=[-]
_proc=[linia2()]
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
   zPODSTAWA=0
   zPROCENT=0
   zKWOTAZMN := 0
   zDEGRES := 'N'
   zKWOTADE1 := 0
   zKWOTADE2 := 0
else
   zPODSTAWA=PODSTAWA
   zPROCENT=PROCENT
   zKWOTAZMN := KWOTAZMN
   zDEGRES := iif( DEGRES, 'T', 'N' )
   zKWOTADE1 := KWOTADE1
   zKWOTADE2 := KWOTADE2
endif
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ wiersz,33 get zPODSTAWA picture "9999999.99" valid v2_1()
@ wiersz,44 get zPROCENT picture "99" valid v2_2()
@ wiersz,47 GET zKWOTAZMN picture "99999.99"
@ wiersz,57 GET zDEGRES picture "!" valid v2_3()
@ wiersz,60 GET zKWOTADE1 picture "999999.99"
@ wiersz,70 GET zKWOTADE2 picture "999999.99"
read_()
set cursor off
if lastkey()=27
exit
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
if ins
   app()
endif
do BLOKADAR
repl_([PODSTAWA],zPODSTAWA)
repl_([PROCENT],zPROCENT)
repl_([KWOTAZMN],zKWOTAZMN)
repl_([DEGRES],iif( zDEGRES == 'T', .T., .F. ) )
repl_([KWOTADE1],zKWOTADE1)
repl_([KWOTADE2],zKWOTADE2)
commit_()
unlock
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
_row=int((_row_g+_row_d)/2)
if .not.ins
exit
endif
@ _row_d,_col_l say &_proc
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say [          ³  ³        ³   ³         ³         ]
                             enddo
_disp=ins.or.lastkey()#27
kl=iif(lastkey()=27.and._row=-1,27,kl)
@ 23,0
*################################ KASOWANIE #################################
                   case kl=7.or.kl=46
@ 1,47 say [          ]
ColStb()
center(23,[þ                   þ])
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
p[ 8]='   [Esc]...................wyj&_s.cie                      '
p[ 9]='                                                        '
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
function linia2
   RETURN kwota(PODSTAWA,10,2) + "³" + str(PROCENT,2) +  "³" + kwota( kwotazmn, 8, 2 ) + "³ " +iif( degres, "T", "N" ) +  " ³" + kwota( kwotade1, 9, 2 ) + "³" + kwota( kwotade2, 9, 2 )
//return [   ]+kwota(PODSTAWA,14,2)+[    ³   ]+str(PROCENT,2)+[    ]
***************************************************
function v2_1
if zpodstawa<0
return .f.
endif
nr_rec=recno()
seek [+]+str(zPODSTAWA,11,2)
fou=found()
rec=recno()
go nr_rec
   if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Takie dane ju&_z. istniej&_a.')
   set cursor on
   return .f.
   endif
return .t.
***************************************************
function v2_2
return zPROCENT>0
***************************************************
FUNCTION v2_3()
   RETURN zDEGRES$'TN'

/*----------------------------------------------------------------------*/

FUNCTION TabDochPobierz( nKwota, ncWorkspace )

   LOCAL aRes := {}
   LOCAL lZamknij := .F.
   LOCAL nPod

   IF Empty( ncWorkspace )
      ncWorkspace := 'tab_doch_pob'
      lZamknij := .T.
      DO WHILE ! DostepEx( 'tab_doch', 'tab_doch', .T., ncWorkspace )
      ENDDO
   ENDIF

   ( ncWorkspace )->( dbSeek( '-' ) )
   ( ncWorkspace )->( dbSkip( -1 ) )

   DO WHILE ( ncWorkspace )->podstawa >= nKwota .AND. ! ( ncWorkspace )->( Bof() )
      ( ncWorkspace )->( dbSkip( -1 ) )
   ENDDO

   AAdd( aRes, ( ncWorkspace )->podstawa )
   AAdd( aRes, ( ncWorkspace )->procent )
   AAdd( aRes, ( ncWorkspace )->kwotazmn )
   AAdd( aRes, ( ncWorkspace )->degres )
   AAdd( aRes, ( ncWorkspace )->kwotade1 )
   AAdd( aRes, ( ncWorkspace )->kwotade2 )

   IF lZamknij
      ( ncWorkspace )->( dbCloseArea() )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION TabDochPodatek( nKwota, ncWorkspace )

   LOCAL nRes := 0
   LOCAL aTab

   aTab := TabDochPobierz( nKwota, ncWorkspace )

   IF Len( aTab ) > 0
      nRes := nKwota * aTab[ 2 ] / 100
      IF aTab[ 4 ]
         nRes := nRes - Max( 0, ( aTab[ 3 ] - aTab[ 5 ] * ( nKwota - aTab[ 1 ] - 1 ) / aTab[ 6 ] ) )
      ELSE
         nRes := nRes - aTab[ 3 ]
      ENDIF
   ENDIF

   RETURN Max( 0, nRes )

/*----------------------------------------------------------------------*/

FUNCTION TabDochProcent( nPodstawa, ncWorkspace )

   LOCAL aTab := {}
   LOCAL nRes := 0

   aTab := TabDochPobierz( nPodstawa, ncWorkspace )
   IF Len( aTab ) > 0
      nRes := aTab[ 2 ]
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/


*############################################################################
