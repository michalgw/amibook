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

FUNCTION Tresc()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                                                                                '
@  4, 0 say '          K A T A L O G    Z D A R Z E &__N.    G O S P O D A R C Z Y C H           '
@  5, 0 say '                                                                                '
@  6, 0 say '            Nazwa                    Stan         Rodzaj         Opcje      Kol.'
@  7, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ¿'
@  8, 0 say '³                             ³                ³          ³                 ³  ³'
@  9, 0 say '³                             ³                ³          ³                 ³  ³'
@ 10, 0 say '³                             ³                ³          ³                 ³  ³'
@ 11, 0 say '³                             ³                ³          ³                 ³  ³'
@ 12, 0 say '³                             ³                ³          ³                 ³  ³'
@ 13, 0 say '³                             ³                ³          ³                 ³  ³'
@ 14, 0 say '³                             ³                ³          ³                 ³  ³'
@ 15, 0 say '³                             ³                ³          ³                 ³  ³'
@ 16, 0 say '³                             ³                ³          ³                 ³  ³'
@ 17, 0 say '³                             ³                ³          ³                 ³  ³'
@ 18, 0 say '³                             ³                ³          ³                 ³  ³'
@ 19, 0 say '³                             ³                ³          ³                 ³  ³'
@ 20, 0 say '³                             ³                ³          ³                 ³  ³'
@ 21, 0 say '³                             ³                ³          ³                 ³  ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 1
do while.not.dostep('TRESC')
enddo
set inde to tresc
seek [+]+ident_fir
*################################# OPERACJE #################################
*----- parametry ------
_row_g=8
_col_l=1
_row_d=21
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia14()]
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
   zTRESC=space(30)
   zSTAN=0
   zRODZAJ := "O"
   zOPCJE := " "
   zKOLUMNA := "  "
else
   zTRESC=TRESC
   zSTAN=STAN
   zRODZAJ := RODZAJ
   zOPCJE := OPCJE
   zKOLUMNA := KOLUMNA
endif
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ wiersz, 2 get zTRESC PICTURE "@S27 " + Replicate( 'X', 512 ) valid v14_1()
@ wiersz,32 get zSTAN picture "   99999999.99"
@ wiersz,48 get zRODZAJ PICTURE "!" WHEN w14_2() valid v14_2()
@ wiersz,59 get zOPCJE PICTURE "!" WHEN w14_3() valid v14_3()
@ wiersz,77 get zKOLUMNA PICTURE "99" WHEN w14_4() valid v14_4()
read_()
@ 24, 0
if lastkey()=27
exit
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
if ins
   app()
   repl_([firma],ident_fir)
endif
do BLOKADAR
repl_([TRESC],zTRESC)
repl_([STAN],zSTAN)
repl_([RODZAJ],zRODZAJ)
repl_([OPCJE],zOPCJE)
repl_([KOLUMNA],zKOLUMNA)
commit_()
unlock
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
_row=int((_row_g+_row_d)/2)
if .not.ins
exit
endif
@ _row_d,_col_l say &_proc
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say [                             ³                ³          ³                 ³  ]
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
*################################# SZUKANIE #################################
                   case kl=-9.or.kl=247
@ 1,47 say [          ]
ColStb()
center(23,[þ                 þ])
ColSta()
  center(23,[S Z U K A N I E])
ColStd()
f10=space(30)
@ _row,16 get f10
read_()
_disp=.not.empty(f10).and.lastkey()#27
if _disp
   seek [+]+ident_fir+f10
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
function linia14
   LOCAL cRodzaj, cOpcje
   cRodzaj := rodzaj2str(RODZAJ)
   cOpcje := "                 "
   IF RODZAJ == "Z"
      IF OPCJE $ "27P"
         cOpcje := "Paliwo (50%VAT)  "
      ENDIF
   ELSE
   ENDIF
return [ ]+Left(TRESC,27)+[ ³ ]+kwota(STAN,14,2)+[ ³]+cRodzaj+[³]+cOpcje+[³]+KOLUMNA
***************************************************
function v14_1
if empty(zTRESC)
return .f.
endif
nr_rec=recno()
seek [+]+ident_fir+zTRESC
fou=found()
rec=recno()
go nr_rec
   if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],[ Takie zdarzenie ju&_z. istnieje ])
   set cursor on
   return .f.
   endif
return .t.
*############################################################################
FUNCTION v14_2()
   LOCAL lRes := zRODZAJ$"OSZ"
   IF lRes
      IF zRODZAJ <> "Z"
         zOPCJE := " "
      ENDIF
      ColStd()
      @ wiersz, 48 SAY rodzaj2str(zRODZAJ)
      @ 24, 0
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_2()
   ColInf()
   @ 24,0 say padc('Wpisz: S - sprzeda¾ , Z - zakup lub O - oba (zakup / sprzeda¾)',80,' ')
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION v14_3()
   LOCAL lRes := zOPCJE$" 27P"
   IF lRes
      ColStd()
      @ 24, 0
      @ wiersz, 48 SAY rodzaj2str(zRODZAJ)
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_3()
   LOCAL lRes := zRODZAJ=="Z"
   IF lRes
      ColInf()
      @ 24,0 say padc('Wpisz: P - zakup paliwa itp (50% kwoty VAT) lub pozostaw puste',80,' ')
      ColStd()
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION wv14_4_kol( cRodzaj )

   LOCAL aRes

   DO CASE
   CASE cRodzaj == "S"
      IF zRYCZALT == 'T'
         aRes := { "5", "6", "7", "8", "9", "10", "11", "12", "13" }
      ELSE
         aRes := { "7", "8" }
      ENDIF
   CASE cRodzaj == "Z"
      IF zRYCZALT == 'T'
         aRes := {}
      ELSE
         aRes := { "10", "11", "12", "13", "16" }
      ENDIF
   OTHERWISE
      IF zRYCZALT == 'T'
         aRes := { "5", "6", "7", "8", "9", "10", "11", "12", "13" }
      ELSE
         aRes := { "7", "8", "10", "11", "12", "13", "16" }
      ENDIF
   ENDCASE

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION v14_4()

   LOCAL lRes := Empty( zKOLUMNA ) .OR. AScan( wv14_4_kol( zRODZAJ ), AllTrim( zKOLUMNA ) ) > 0

   IF lRes
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION w14_4()

   LOCAL aKol
   LOCAL lRes := .NOT. ( zRODZAJ == "Z" .AND. zRYCZALT == 'T' )
   LOCAL cKol := ""

   IF lRes
      aKol := wv14_4_kol( zRODZAJ )
      AEval( aKol, { | cItem | cKol := cKol + iif( cKol <> "", ', ', '' ) + cItem } )

      ColInf()
      @ 24, 0 say PadC( 'Wpisz: ' + cKol, 80, ' ' )
      ColStd()
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION rodzaj2str(cRodzaj)
   LOCAL cRes := "          "
   SWITCH cRodzaj
      CASE "O"
         cRes := "Oba (z/s) "
         EXIT
      CASE "S"
         cRes := "Sprzeda¾  "
         EXIT
      CASE "Z"
         cRes := "Zakup     "
   ENDSWITCH
   RETURN cRes

/*----------------------------------------------------------------------*/

