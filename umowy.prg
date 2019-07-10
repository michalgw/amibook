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
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
zNAZWISKO=space(62)
zTYT='Z'
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say padc('EWIDENCJA  INNYCH  UM&__O.W  i  INNYCH  &__X.R&__O.DE&__L.  PRZYCHOD&__O.W',80)
@  4, 0 say '    Data    Numer   Termin      Data       Data                                 '
@  5, 0 say '   umowy    umowy  wykonania  rachunku   wyp&_l.aty           Opis prac            '
@  6, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@  7, 0 say '³          ³     ³          ³          ³          ³                            ³'
@  8, 0 say '³          ³     ³          ³          ³          ³                            ³'
@  9, 0 say '³          ³     ³          ³          ³          ³                            ³'
@ 10, 0 say '³          ³     ³          ³          ³          ³                            ³'
@ 11, 0 say '³          ³     ³          ³          ³          ³                            ³'
*@ 12, 0 say '³          ³     ³          ³          ³          ³                            ³'
@ 12, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ 13, 0 say '³                                                                              ³'
@ 14, 0 say '³ Opis...                                                                      ³'
@ 15, 0 say '³ prac...                                                                      ³'
//002a nowe pole
@ 16, 0 say '³                                                                              ³'
@ 17, 0 say '³ Przychody opodatkowane =                 Z jakiego tytu&_l.u ?                  ³'
@ 18, 0 say '³ Sk&_l.adki wykonawcy      =     %             Przych&_o.d netto=                   ³'
@ 19, 0 say '³ Koszt uzyskania        =  %              Do opodatkowania=                   ³'
@ 20, 0 say '³ Wyliczenie podatku     =  %                    DO WYP&__L.ATY=                   ³'
@ 21, 0 say '³ Sk&_l.adki zleceniodawcy  =     %                 Fundusze  =     %             ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 4
do while.not.dostep('FIRMA')
enddo
set inde to firma
go val(ident_fir)
select 3
do while.not.dostep('TAB_DOCH')
enddo
set inde to tab_doch
select 2
do while.not.dostep('UMOWY')
enddo
do setind with 'UMOWY'
set orde to 2
seek [+]+ident_fir
select 1
do while.not.dostep('PRAC')
enddo
do setind with 'PRAC'
set orde to 3
SET FILTER TO prac->aktywny == 'T'
seek [+]+ident_fir+[+]
if eof().or.del#'+'.or.firma#ident_fir.or.status<'U'
   kom(3,[*u],[ Brak pracownik&_o.w pracuj&_a.cych na umowy ])
   return
endif
sele umowy
*################################# OPERACJE #################################
*----- parametry ------
_row_g=7
_col_l=1
_row_d=11
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,13,247,22,48,77,109,7,46,28,82,114,85,117,87,119]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[say41()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say41s]
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
*########################### INSERT/MODYFIKACJA #############################
              case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
@ 1,47 say [          ]
ins=(kl#109.and.kl#77).OR.&_top_bot
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
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
if ins
   zIDENT=space(5)
   zNUMER=space(8)
   zDATA_UMOWY=ctod('    .  .  ')
   zTEMAT1=space(70)
   zTEMAT2=space(70)
   zTERMIN=ctod('    .  .  ')
   zDATA_RACH=ctod('    .  .  ')
   zDATA_WYP=ctod('    .  .  ')
   zNAZWISKO=space(62)
   zSTAW_PODAT=parap_pod
//002a nowa zmienna
   zTYT=('Z')
else
   zIDENT=IDENT
   zNUMER=NUMER
   zDATA_UMOWY=DATA_UMOWY
   zTEMAT1=TEMAT1
   zTEMAT2=TEMAT2
   zTERMIN=TERMIN
   zDATA_RACH=DATA_RACH
   zDATA_WYP=DATA_WYP
   zSTAW_PODAT=STAW_PODAT
//002a i tu tez
   do case
*  case TYTUL='0'
*       zTYT='O' //organy stanowiace
   case TYTUL='1'
        zTYT='A' //aktywizacja
   case TYTUL='2'
        zTYT='C' //czlonkowstwo w spoldzielni
   case TYTUL='3'
        zTYT='E' //emerytury i renty zagraniczne
   case TYTUL='4'
        zTYT='F' //swiadczenia z funduszu pracy i GSP
   case TYTUL='9'
        zTYT='S' //obowiazki spoleczne
   case TYTUL='6'
        zTYT='P' //prawa autorskie
   case TYTUL='7'
        zTYT='I' //inne zrodla
   case TYTUL='8'
        zTYT='R' //kontrakty menadzerskie
   CASE TYTUL = '10'
      zTYT := 'O'
   other
        zTYT='Z' //umowy zlecenia i o dzielo 5
   endcase
   sele prac
   set orde to 4
   seek val(zident)
   set orde to 3
   zNAZWISKO=NAZWISKO+','+IMIE1+','+IMIE2
   sele umowy
endif
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ wiersz,1  get zDATA_UMOWY
@ wiersz,12 get zNUMER picture "XXXXX"
@ wiersz,18 get zTERMIN
@ wiersz,29 get zDATA_RACH
@ wiersz,40 get zDATA_WYP
@ 13, 9 get zNAZWISKO picture "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX,XXXXXXXXXXXXXXX,XXXXXXXXXXXXXXX" valid v4_141()
@ 14, 9 get zTEMAT1   picture replicate('X',70)
@ 15, 9 get zTEMAT2   picture replicate('X',70)
read_()
if lastkey()=27
   break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
if ins
   app()
endif
do BLOKADAR
repl_([FIRMA],IDENT_FIR)
repl_([IDENT],zIDENT)
repl_([NUMER],zNUMER)
repl_([DATA_UMOWY],zDATA_UMOWY)
repl_([TEMAT1],zTEMAT1)
repl_([TEMAT2],zTEMAT2)
repl_([TERMIN],zTERMIN)
repl_([DATA_RACH],zDATA_RACH)
repl_([DATA_WYP],zDATA_WYP)
repl_([STAW_PODAT],zSTAW_PODAT)

do case
*case zTYT='O'
*     zTYTUL:='0'
case zTYT='A'
     zTYTUL:='1'
case zTYT='C'
     zTYTUL:='2'
case zTYT='E'
     zTYTUL:='3'
case zTYT='F'
     zTYTUL:='4'
case zTYT='S'
     zTYTUL:='9'

case zTYT='P'
     zTYTUL:='6'
case zTYT='I'
     zTYTUL:='7'
case zTYT='R'
     zTYTUL:='8'
CASE zTYT = 'O'
   zTYTUL := '10'
otherwise
     zTYTUL :='5' //<--= brak danych
endcase
repl_([TYTUL],zTYTUL)
commit_()
unlock
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
_row=int((_row_g+_row_d)/2)
if .not.ins
   break
endif
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say '          ³     ³          ³          ³          ³                            '
                             end
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
*################################### WYBOR POZYCJI ##########################
case kl=13
     save screen to scr_
     @ 1,47 say [          ]
     store 'A' to zAKOSZT,;
                  zAPUZ,;
                  zAPUE,;
                  zAPUR,;
                  zAPUC,;
                  zAPUW,;
                  zAPFP,;
                  zAPFG,;
                  zAPF3,;
                  zAFUZ,;
                  zAFUE,;
                  zAFUR,;
                  zAFUC,;
                  zAFUW,;
                  zAFFP,;
                  zAFFG,;
                  zAFF3,;
                  zAPZK
     store 0 to zBRUT_ZASAD,;
           zKOSZT     ,;
           zKOSZTY    ,;
           zSTAW_PUE  ,;
           zSTAW_PUR  ,;
           zSTAW_PUC  ,;
           zSTAW_PSUM ,;
           zWAR_PUE   ,;
           zWAR_PUR   ,;
           zWAR_PUC   ,;
           zWAR_PSUM  ,;
           oWAR_PUE   ,;
           oWAR_PUR   ,;
           oWAR_PUC   ,;
           oWAR_PSUM  ,;
           zSTAW_PODAT,;
           zSTAW_PUZ  ,;
           zSTAW_PZK  ,;
           zWAR_PUZ   ,;
           zWAR_PZK   ,;
           zWAR_PUZO  ,;
           oWAR_PUZ   ,;
           oWAR_PZK   ,;
           oWAR_PUZO  ,;
           zSTAW_FUE  ,;
           zSTAW_FUR  ,;
           zSTAW_FUW  ,;
           zSTAW_FFP  ,;
           zSTAW_FFG  ,;
           zSTAW_FSUM ,;
           zWAR_FUE   ,;
           zWAR_FUR   ,;
           zWAR_FUW   ,;
           zWAR_FFP   ,;
           zWAR_FFG   ,;
           zWAR_FSUM  ,;
           oWAR_FUE   ,;
           oWAR_FUR   ,;
           oWAR_FUW   ,;
           oWAR_FFP   ,;
           oWAR_FFG   ,;
           oWAR_FSUM  ,;
           zBRUT_RAZEM,;
           zDOCHOD    ,;
           zDOCHODPOD ,;
           zPENSJA    ,;
           zPODATEK   ,;
           zNETTO     ,;
           zDO_WYPLATY,;
           zUWAGI     ,;
           B5         ,;
           SKLADN
*           zZAOPOD    ,;
*     zJAKZAO='Z'
     zTYTUL=TYTUL


     do case
*     case TYTUL='0'
*          zTYT='O' //organy stanowiace
     case TYTUL='1'
          zTYT='A' //aktywizacja
     case TYTUL='2'
          zTYT='C' //czlonkowstwo w spoldzielni
     case TYTUL='3'
          zTYT='E' //emerytury i renty zagraniczne
     case TYTUL='4'
          zTYT='F' //swiadczenia z funduszu pracy i GSP
     case TYTUL='9'
          zTYT='S' //obowiazki spoleczne
     case TYTUL='6'
          zTYT='P' //prawa autorskie
     case TYTUL='7'
          zTYT='I' //inne zrodla
     case TYTUL='8'
          zTYT='R' //kontrakty menadzerskie
     CASE TYTUL = '10'
          zTYT := 'O'
     other
          zTYT='Z' //umowy zlecenia i o dzielo 5
     endcase

//002a 2 nowe linie-/\
     do podstawu
     save scre to scr_sklad
*     set curs on
*     @ 16,32 get zJAKZAO pict '!' when wJAKZAOu(16,33) valid vJAKZAOu(16,33)
*     read
*     set curs off
*     rest scre from scr_sklad
*     if lastkey()#27
*        if zJAKZAO='Z'
*           zZAOPOD=0
*        else
*           zZAOPOD=1
*        endif
*        oblplu()
*        do BLOKADAR
*        do zapiszplau
*        unlock
*        _infoskl_u()
*     endif

     do while .t.
        ColStd()
        @ 17, 1 prompt ' Przychody opodatkowane '
//002a nowa linia
        @ 17,42 prompt ' Z jakiego tytu&_l.u ?'
        @ 18, 1 prompt ' Sk&_l.adki wykonawcy      '
        @ 19, 1 prompt ' Koszt uzyskania        '
        @ 20, 1 prompt ' Wyliczenie podatku     '
        @ 21, 1 prompt ' Sk&_l.adki zleceniodawcy  '
        skladn=menu(skladn)
        ColStd()
        if lastkey()=27
           exit
        endif
        do podstawu
        do case
        case skladn=1
             save scre to scr_sklad
             set curs on
             @ 17,26 get zBRUT_ZASAD pict '999999.99' valid oblplu()
             read
             set curs off
             rest scre from scr_sklad
        case skladn=2
             save scre to scr_sklad
             set curs on
             @ 17,62 get zTYT pict '!' when jaki_tytul() valid zTYT$'AZPICEFSRO'
             read
             set curs off
             rest scre from scr_sklad
        case skladn=3
             save scre to scr_sklad
             set curs on
             @ 16,25 clear to 22,66
             @ 16,25 to 22,66
             @ 17,26 say 'SK&__L.ADKI    %stawki wart.obli. wart.odli.'
             @ 18,26 say 'Emerytalna ' get zSTAW_PUE pict '99.99' valid OBLPLu()
             @ 18,45 get oWAR_PUE pict '999999.99' when oblplu().and..f.
             @ 18,55 get zAPUE pict '!' when oblplu().and.wAUTOKOM() valid zAPUE$'AR'.and.vAUTOKOM()
             @ 18,57 get zWAR_PUE pict '999999.99' when oblplu()
             @ 19,26 say 'Rentowa    ' get zSTAW_PUR pict '99.99' valid OBLPLu()
             @ 19,45 get oWAR_PUR pict '999999.99' when oblplu().and..f.
             @ 19,55 get zAPUR pict '!' when oblplu().and.wAUTOKOM() valid zAPUR$'AR'.and.vAUTOKOM()
             @ 19,57 get zWAR_PUR pict '999999.99' when oblplu()
             @ 20,26 say 'Chorobowa  ' get zSTAW_PUC pict '99.99' valid OBLPLu()
             @ 20,45 get oWAR_PUC pict '999999.99' when oblplu().and..f.
             @ 20,55 get zAPUC pict '!' when oblplu().and.wAUTOKOM() valid zAPUC$'AR'.and.vAUTOKOM()
             @ 20,57 get zWAR_PUC pict '999999.99' when oblplu()
             @ 21,26 say 'RAZEM      ' get zSTAW_PSUM pict '99.99' when oblplu().and..f.
             @ 21,45 get oWAR_PSUM pict '999999.99' when oblplu().and..f.
             @ 21,57 get zWAR_PSUM pict '999999.99' when oblplu().and..f.
             read
             set curs off
             rest scre from scr_sklad
        case skladn=4
             save scre to scr_sklad
             set curs on
             @ 19,26 get zKOSZTY  pict '99' valid oblplu()
             @ 19,30 get zAKOSZT pict '!' when oblplu().and.wAUTOKOM() valid zAKOSZT$'AR'.and.vAUTOKOM()
             @ 19,33 get zKOSZT pict '999999.99' valid oblplu()
             read
             set curs off
             rest scre from scr_sklad
        case skladn=5
             save scre to scr_sklad
             set curs on
             @ 17,25 clear to 22,75
             @ 17,25 to 22,75
             @ 18,26 say 'Podatek stawka..........%.='
             @ 18,45 get zSTAW_PODAT pict '99' valid oblplu()
             @ 18,66 get B5          pict '999999.99' when oblplu().and..f.
             @ 19,26 say 'Ubezp.zdrow. do ZUS.....%.='
             @ 19,45 get zSTAW_PUZ pict '99.99' valid oblplu()
             @ 19,54 get oWAR_PUZ  pict '999999.99' when oblplu().and..f.
             @ 19,64 get zAPUZ pict '!' when oblplu().and.wAUTOKOM() valid zAPUZ$'AR'.and.vAUTOKOM()
             @ 19,66 get zWAR_PUZ  pict '999999.99' when oblplu()
             @ 20,26 say '             do odlicz..%.='
             @ 20,45 get zSTAW_PZK pict '99.99' valid oblplu()
             @ 20,54 get oWAR_PZK  pict '999999.99' when oblplu().and..f.
             @ 20,64 get zAPZK pict '!' when oblplu().and.wAUTOKOM() valid zAPZK$'AR'.and.vAUTOKOM()
             @ 20,66 get zWAR_PZK  pict '999999.99' when oblplu()
             @ 21,26 say 'Podatek do zap&_l.aty........:'
             @ 21,66 get zPODATEK    pict '999999.99' when oblplu().and..f.
             read
             set curs off
             rest scre from scr_sklad
        case skladn=6
             save scre to scr_sklad
             set curs on
             @ 13,25 clear to 22,66
             @ 13,25 to 22,66
             @ 14,26 say 'SK&__L.ADKI    %stawki wart.obli. wart.odli.'
             @ 15,26 say 'Emerytalna ' get zSTAW_FUE pict '99.99' valid OBLPLu()
             @ 15,45 get oWAR_FUE pict '999999.99' when oblplu().and..f.
             @ 15,55 get zAFUE pict '!' when oblplu().and.wAUTOKOM() valid zAFUE$'AR'.and.vAUTOKOM()
             @ 15,57 get zWAR_FUE pict '999999.99' when oblplu()
             @ 16,26 say 'Rentowa    ' get zSTAW_FUR pict '99.99' valid OBLPLu()
             @ 16,45 get oWAR_FUR pict '999999.99' when oblplu().and..f.
             @ 16,55 get zAFUR pict '!' when oblplu().and.wAUTOKOM() valid zAFUR$'AR'.and.vAUTOKOM()
             @ 16,57 get zWAR_FUR pict '999999.99' when oblplu()
             @ 17,26 say 'Wypadkowa  ' get zSTAW_FUW pict '99.99' valid OBLPLu()
             @ 17,45 get oWAR_FUW pict '999999.99' when oblplu().and..f.
             @ 17,55 get zAFUW pict '!' when oblplu().and.wAUTOKOM() valid zAFUW$'AR'.and.vAUTOKOM()
             @ 17,57 get zWAR_FUW pict '999999.99' when oblplu()
             @ 18,26 say 'FUNDUSZE   %stawki wart.obli. wart.odli.'
             @ 19,26 say 'Pracy      ' get zSTAW_FFP pict '99.99' valid OBLPLu()
             @ 19,45 get oWAR_FFP pict '999999.99' when oblplu().and..f.
             @ 19,55 get zAFFP pict '!' when oblplu().and.wAUTOKOM() valid zAFFP$'AR'.and.vAUTOKOM()
             @ 19,57 get zWAR_FFP pict '999999.99' when oblplu()
             @ 20,26 say 'G&__S.P        ' get zSTAW_FFG pict '99.99' valid OBLPLu()
             @ 20,45 get oWAR_FFG pict '999999.99' when oblplu().and..f.
             @ 20,55 get zAFFG pict '!' when oblplu().and.wAUTOKOM() valid zAFFG$'AR'.and.vAUTOKOM()
             @ 20,57 get zWAR_FFG pict '999999.99' when oblplu()
             @ 21,26 say 'RAZEM      ' get zSTAW_FSUM pict '99.99' when oblplu().and..f.
             @ 21,45 get oWAR_FSUM pict '999999.99' when oblplu().and..f.
             @ 21,57 get zWAR_FSUM pict '999999.99' when oblplu().and..f.
             read
             set curs off
             rest scre from scr_sklad
        endcase
//002a zmiana skladn z 2 na 3
        if lastkey()#27.or.skladn=3
           oblplu()
           do BLOKADAR
           do ZAPISZPLAU
           unlock
        endif
        _infoskl_u()
     enddo
     @ 17, 1 say ' Przychody opodatkowane '
//002a nowa linia
     @ 17,42 say ' Z jakiego tytu&_l.u ?'
     @ 18, 1 say ' Sk&_l.adki wykonawcy      '
     @ 19, 1 say ' Koszt uzyskania        '
     @ 20, 1 say ' Wyliczenie podatku     '
     @ 21, 1 say ' Sk&_l.adki zleceniodawcy  '
     restore screen from scr_
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                                        '
p[ 2]='   ['+chr(24)+'/'+chr(25)+']...................poprzednia/nast&_e.pna pozycja  '
p[ 3]='   [Home/End]..............pierwsza/ostatnia pozycja    '
p[ 4]='   [Enter].................zmiana wyliczonych kwot      '
p[ 5]='   [Ins]...................dopisanie przychodu          '
p[ 6]='   [M].....................modyfikacja przychodu        '
p[ 7]='   [Del]...................kasowanie przychodu          '
p[ 8]='   [U].....................drukowanie tytu&_l.u przychodu  '
p[ 9]='   [R].....................drukowanie rachunku za prac&_e. '
p[10]='   [W].....................drukowanie dowodu wyp&_l.aty    '
p[11]='   [Esc]...................wyj&_s.cie                      '
p[12]='                                                        '
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
*############################## DRUK RACHUNKU ###############################
case kl=82 .or. kl=114
     do wybzbior with 'RACH*.TXT'
*############################## DRUK UMOWA ##################################
case kl=85 .or. kl=117
     do wybzbior with 'UMOW*.TXT'
*############################## DRUK WYPLATY ################################
case kl=87 .or. kl=119
     do wybzbior with 'WYPL*.TXT'
******************** ENDCASE
endcase
enddo
close_()
*****************************************************************************
proc TRANTEK
*****************************************************************************
     //set cons off
     //set device to print
     //set print on
     TEKSTDR:=strtran(TEKSTDR,'@DZISIAJ',dtoc(DATE()))
     TEKSTDR:=strtran(TEKSTDR,'#DZISIAJ',dtoc(DATE()))
     sele prac
     TEKSTDR:=strtran(TEKSTDR,'@NAZWISKO',NAZWISKO)
     TEKSTDR:=strtran(TEKSTDR,'#NAZWISKO',alltrim(NAZWISKO))
     TEKSTDR:=strtran(TEKSTDR,'@IMIE1',IMIE1)
     TEKSTDR:=strtran(TEKSTDR,'#IMIE1',alltrim(IMIE1))
     TEKSTDR:=strtran(TEKSTDR,'@IMIE2',IMIE2)
     TEKSTDR:=strtran(TEKSTDR,'#IMIE2',alltrim(IMIE2))
     TEKSTDR:=strtran(TEKSTDR,'@IMIE_O',IMIE_O)
     TEKSTDR:=strtran(TEKSTDR,'#IMIE_O',alltrim(IMIE_O))
     TEKSTDR:=strtran(TEKSTDR,'@IMIE_M',IMIE_M)
     TEKSTDR:=strtran(TEKSTDR,'#IMIE_M',alltrim(IMIE_M))
     TEKSTDR:=strtran(TEKSTDR,'@MIEJSC_UR',MIEJSC_UR)
     TEKSTDR:=strtran(TEKSTDR,'#MIEJSC_UR',alltrim(MIEJSC_UR))
     TEKSTDR:=strtran(TEKSTDR,'@DATA_UR',dtoc(DATA_UR))
     TEKSTDR:=strtran(TEKSTDR,'#DATA_UR',dtoc(DATA_UR))
     TEKSTDR:=strtran(TEKSTDR,'@ZATR',ZATRUD)
     TEKSTDR:=strtran(TEKSTDR,'#ZATR',alltrim(ZATRUD))
     TEKSTDR:=strtran(TEKSTDR,'@PESEL',PESEL)
     TEKSTDR:=strtran(TEKSTDR,'#PESEL',alltrim(PESEL))
     TEKSTDR:=strtran(TEKSTDR,'@NIP',NIP)
     TEKSTDR:=strtran(TEKSTDR,'#NIP',alltrim(NIP))
     TEKSTDR:=strtran(TEKSTDR,'@MIEJSC_ZAM',MIEJSC_ZAM)
     TEKSTDR:=strtran(TEKSTDR,'#MIEJSC_ZAM',alltrim(MIEJSC_ZAM))
     TEKSTDR:=strtran(TEKSTDR,'@KOD',KOD_POCZT)
     TEKSTDR:=strtran(TEKSTDR,'#KOD',alltrim(KOD_POCZT))
     TEKSTDR:=strtran(TEKSTDR,'@GMINA',GMINA)
     TEKSTDR:=strtran(TEKSTDR,'#GMINA',alltrim(GMINA))
     TEKSTDR:=strtran(TEKSTDR,'@ULICA',ULICA)
     TEKSTDR:=strtran(TEKSTDR,'#ULICA',alltrim(ULICA))
     TEKSTDR:=strtran(TEKSTDR,'@DOM',NR_DOMU)
     TEKSTDR:=strtran(TEKSTDR,'#DOM',alltrim(NR_DOMU))
     TEKSTDR:=strtran(TEKSTDR,'@LOKAL',NR_MIESZK)
     TEKSTDR:=strtran(TEKSTDR,'#LOKAL',alltrim(NR_MIESZK))
     TEKSTDR:=strtran(TEKSTDR,'@DOWOD',DOWOD_OSOB)
     TEKSTDR:=strtran(TEKSTDR,'#DOWOD',alltrim(DOWOD_OSOB))
     sele firma
     TEKSTDR:=strtran(TEKSTDR,'@FIRMA',NAZWA)
     TEKSTDR:=strtran(TEKSTDR,'#FIRMA',alltrim(NAZWA))
     TEKSTDR:=strtran(TEKSTDR,'@UL_FIRMY',ULICA+' '+NR_DOMU+'/'+NR_MIESZK)
     TEKSTDR:=strtran(TEKSTDR,'#UL_FIRMY',alltrim(ULICA)+' '+alltrim(NR_DOMU)+'/'+alltrim(NR_MIESZK))
     TEKSTDR:=strtran(TEKSTDR,'@ADR_FIRMY',MIEJSC)
     TEKSTDR:=strtran(TEKSTDR,'#ADR_FIRMY',alltrim(MIEJSC))
     sele umowy
     TEKSTDR:=strtran(TEKSTDR,'@UMOWA',NUMER)
     TEKSTDR:=strtran(TEKSTDR,'#UMOWA',alltrim(NUMER))
     TEKSTDR:=strtran(TEKSTDR,'@DATA_UM',dtoc(DATA_UMOWY))
     TEKSTDR:=strtran(TEKSTDR,'#DATA_UM',dtoc(DATA_UMOWY))
     TEKSTDR:=strtran(TEKSTDR,'@DATA_WYP',dtoc(DATA_WYP))
     TEKSTDR:=strtran(TEKSTDR,'#DATA_WYP',dtoc(DATA_WYP))
     TEKSTDR:=strtran(TEKSTDR,'@DATA_RA',dtoc(DATA_RACH))
     TEKSTDR:=strtran(TEKSTDR,'#DATA_RA',dtoc(DATA_RACH))
     TEKSTDR:=strtran(TEKSTDR,'@BRUTTO',kwota(BRUT_RAZEM,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#BRUTTO',alltrim(kwota(BRUT_RAZEM,11,2)))
     WW1=slownie(BRUT_RAZEM)
     TEKSTDR:=strtran(TEKSTDR,'@BSLOW',WW1)
     TEKSTDR:=strtran(TEKSTDR,'#BSLOW',WW1)
     TEKSTDR:=strtran(TEKSTDR,'@%KOSZT',str(KOSZTY,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#%KOSZT',alltrim(str(KOSZTY,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@KOSZT',kwota(KOSZT,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#KOSZT',alltrim(kwota(KOSZT,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@DOCHOD',kwota(DOCHOD,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#DOCHOD',alltrim(kwota(DOCHOD,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@%PODATEK',str(STAW_PODAT,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#%PODATEK',alltrim(str(STAW_PODAT,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@PODATEK',kwota(PODATEK,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#PODATEK',alltrim(kwota(PODATEK,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@NETTO',kwota(DO_WYPLATY,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#NETTO',alltrim(kwota(DO_WYPLATY,11,2)))
     WW5=slownie(DO_WYPLATY)
     TEKSTDR:=strtran(TEKSTDR,'@NSLOW',WW5)
     TEKSTDR:=strtran(TEKSTDR,'#NSLOW',alltrim(WW5))
     TEKSTDR:=strtran(TEKSTDR,'@TEMAT1',TEMAT1)
     TEKSTDR:=strtran(TEKSTDR,'#TEMAT1',alltrim(TEMAT1))
     TEKSTDR:=strtran(TEKSTDR,'@TEMAT2',TEMAT2)
     TEKSTDR:=strtran(TEKSTDR,'#TEMAT2',alltrim(TEMAT2))
     TEKSTDR:=strtran(TEKSTDR,'@TERMIN',dtoc(TERMIN))
     TEKSTDR:=strtran(TEKSTDR,'#TERMIN',dtoc(TERMIN))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PUE',kwota(STAW_PUE,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PUE',alltrim(kwota(STAW_PUE,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PUR',kwota(STAW_PUR,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PUR',alltrim(kwota(STAW_PUR,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PUC',kwota(STAW_PUC,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PUC',alltrim(kwota(STAW_PUC,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PSUM',kwota(STAW_PSUM,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PSUM',alltrim(kwota(STAW_PSUM,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PUW',kwota(STAW_PUW,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PUW',alltrim(kwota(STAW_PUW,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PUZ',kwota(STAW_PUZ,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PUZ',alltrim(kwota(STAW_PUZ,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_PZK',kwota(STAW_PZK,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_PZK',alltrim(kwota(STAW_PZK,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FUE',kwota(STAW_FUE,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FUE',alltrim(kwota(STAW_FUE,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FUR',kwota(STAW_FUR,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FUR',alltrim(kwota(STAW_FUR,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FUC',kwota(STAW_FUC,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FUC',alltrim(kwota(STAW_FUC,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FUW',kwota(STAW_FUW,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FUW',alltrim(kwota(STAW_FUW,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FUZ',kwota(STAW_FUZ,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FUZ',alltrim(kwota(STAW_FUZ,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FSUM',kwota(STAW_FSUM,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FSUM',alltrim(kwota(STAW_FSUM,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PUE',kwota(WAR_PUE,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PUE',alltrim(kwota(WAR_PUE,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PUR',kwota(WAR_PUR,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PUR',alltrim(kwota(WAR_PUR,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PUC',kwota(WAR_PUC,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PUC',alltrim(kwota(WAR_PUC,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PSUM',kwota(WAR_PSUM,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PSUM',alltrim(kwota(WAR_PSUM,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PUW',kwota(WAR_PUW,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PUW',alltrim(kwota(WAR_PUW,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PUZ',kwota(WAR_PUZ,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PUZ',alltrim(kwota(WAR_PUZ,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_PZK',kwota(WAR_PZK,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_PZK',alltrim(kwota(WAR_PZK,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FUE',kwota(WAR_FUE,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FUE',alltrim(kwota(WAR_FUE,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FUR',kwota(WAR_FUR,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FUR',alltrim(kwota(WAR_FUR,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FUC',kwota(WAR_FUC,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FUC',alltrim(kwota(WAR_FUC,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FUW',kwota(WAR_FUW,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FUW',alltrim(kwota(WAR_FUW,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FUZ',kwota(WAR_FUZ,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FUZ',alltrim(kwota(WAR_FUZ,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FSUM',kwota(WAR_FSUM,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FSUM',alltrim(kwota(WAR_FSUM,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FFP',kwota(STAW_FFP,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FFP',alltrim(kwota(STAW_FFP,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@STAW_FFG',kwota(STAW_FFG,5,2))
     TEKSTDR:=strtran(TEKSTDR,'#STAW_FFG',alltrim(kwota(STAW_FFG,5,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FFP',kwota(WAR_FFP,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FFP',alltrim(kwota(WAR_FFP,11,2)))
     TEKSTDR:=strtran(TEKSTDR,'@WAR_FFG',kwota(WAR_FFG,11,2))
     TEKSTDR:=strtran(TEKSTDR,'#WAR_FFG',alltrim(kwota(WAR_FFG,11,2)))
     //?tekstdr
     //ejec
     //set print off
     //set device to scre
     //set cons on
     DrukujNowyProfil(TEKSTDR)

*################################## FUNKCJE #################################
procedure say41
return dtoc(DATA_UMOWY)+[³]+NUMER+[³]+dtoc(TERMIN)+[³]+dtoc(DATA_RACH)+[³]+dtoc(DATA_WYP)+[³]+substr(TEMAT1,1,28)
*############################################################################
procedure say41s
clear type
set color to +w
sele prac
set orde to 4
seek val(umowy->ident)
set orde to 3
znazwisko=nazwisko+','+imie1+','+imie2
sele umowy
@ 13, 9 say zNAZWISKO
@ 14, 9 say TEMAT1
@ 15, 9 say TEMAT2
_infoskl_u()
set color to
return
***************************************************
function v4_141
if lastkey()=5
   return .f.
endif
save screen to scr2
select prac
set orde to 1
seek [+]+ident_fir+substr(znazwisko,1,30)+substr(znazwisko,32,15)+substr(znazwisko,48)
if del#[+].or.ident_fir#umowy->firma.or.nazwisko#substr(znazwisko,1,30).or.imie1#substr(znazwisko,32,15).or.imie2#substr(znazwisko,48)
   set orde to 3
   seek [+]+ident_fir+[+]
   if .not. found()
      restore screen from scr2
      sele umowy
      return .f.
   endif
endif
set orde to 3
do prac_
restore screen from scr2
if lastkey()=13
   znazwisko=nazwisko+','+imie1+','+imie2
   set color to i
   @ 14,9 say znazwisko
   set color to
   pause(.5)
endif
select umowy
return .not.empty(znazwisko)
***************************************************
proc WYBZBIOR
***************************************************
para SKRYPT
save scre to WYSKR
     _ilm=adir(SKRYPT)
     declare a[_ilm]
     adir(SKRYPT,a)
     asort(a)
     ZZ=0
     if _ilm>21
        _ilm=21
     endif
     CURR=ColPro()
     @ 21-_ilm,0 to 22,13
     ZZ=achoice(21-(_ilm-1),1,21,12,a,.t.,.t.,ZZ)
     if ZZ<>0
        TEKSTDR:=memoread(alltrim(a[ZZ]))
        do TRANTEK
     endif
     setcolor(CURR)
rest scre from WYSKR
*############################################################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± _infoskl_u  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o skladnikach placowych                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func _infoskl_u
     CURR=ColStd()
     set color to w+
*     @ 16,32 say iif(ZAOPOD=1,'Dziesiec groszy','Zlotowka       ')
     @ 17,26 say BRUT_ZASAD pict '999999.99'
//002a nowe linie

     do case
*     case TYTUL='0'
*          zTYT='O' //organy stanowiace
     case TYTUL='1'
          zTYT='A' //aktywizacja
     case TYTUL='2'
          zTYT='C' //czlonkowstwo w spoldzielni
     case TYTUL='3'
          zTYT='E' //emerytury i renty zagraniczne
     case TYTUL='4'
          zTYT='F' //swiadczenia z funduszu pracy i GSP
     case TYTUL='9'
          zTYT='S' //obowiazki spoleczne

     case TYTUL='6'
          zTYT='P' //prawa autorskie
     case TYTUL='7'
          zTYT='I' //inne zrodla
     case TYTUL='8'
          zTYT='R' //kontrakty menadzerskie
     CASE TYTUL = '10'
          zTYT := 'O'
     other
          zTYT='Z' //umowy zlecenia i o dzielo 5
     endcase

     @ 17,62 say zTYT+iif(zTYT='I','nne             ',;
                      iif(zTYT='A','ktywizacja umowa',;
                      iif(zTYT='C','zlonkow.spoldzi.',;
                      iif(zTYT='E','meryt.i ren.zagr',;
                      iif(zTYT='F','P i FGSP wyplaty',;
                      iif(zTYT='S','polecz.obowiazki',;
                      iif(zTYT='P','rawo autorskie  ',;
                      iif(zTYT='R','yczalt do 200zl ',;
                      iif(zTYT='O','bcokrajowiec    ',;
                                   'lecenia i dzie&_l.a')))))))))
//002a do tad
     @ 18,26 say STAW_PSUM pict '99.99'
     @ 18,33 say WAR_PSUM pict '999999.99'
     @ 18,60 say BRUT_ZASAD-WAR_PSUM pict '999999.99'
     @ 19,26 say KOSZTY pict '99'
     @ 19,30 say AKOSZT pict '!'
     @ 19,33 say KOSZT pict '999999.99'
     @ 19,60 say DOCHOD pict '999999.99'
     @ 20,26 say STAW_PODAT picture "99"
     @ 20,33 say PODATEK picture "999999.99"
     @ 20,60 say DO_WYPLATY picture "999999.99"
     @ 21,26 say STAW_FUE+STAW_FUR+STAW_FUW pict '99.99'
     @ 21,33 say WAR_FUE+WAR_FUR+WAR_FUW pict '999999.99'
     @ 21,60 say STAW_FFP+STAW_FFG pict '99.99'
     @ 21,67 say WAR_FFP+WAR_FFG pict '999999.99'
     setcolor(CURR)
return
*############################################################################
func oblplu
     if zTYT='R' .OR. zTYT == 'O'
      zPENSJA=zBRUT_ZASAD
      zBRUT_RAZEM=zPENSJA
      oWAR_PUE=_round(zPENSJA*(zSTAW_PUE/100),2)
      oWAR_PUR=_round(zPENSJA*(zSTAW_PUR/100),2)
      oWAR_PUC=_round(zPENSJA*(zSTAW_PUC/100),2)
      oWAR_PSUM=oWAR_PUE+oWAR_PUR+oWAR_PUC
      if zAPUE#'R'
         zWAR_PUE=_round(zPENSJA*(zSTAW_PUE/100),2)
      endif
      if zAPUR#'R'
         zWAR_PUR=_round(zPENSJA*(zSTAW_PUR/100),2)
      endif
      if zAPUC#'R'
         zWAR_PUC=_round(zPENSJA*(zSTAW_PUC/100),2)
      endif
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC
      if zAKOSZT#'R'
         zKOSZT=_round((zBRUT_ZASAD-zWAR_PSUM)*(zKOSZTY/100),2)
      endif
      zDOCHOD=zBRUT_RAZEM
      zDOCHODPOD=_round(zDOCHOD,0)
      B5=_round(zBRUT_RAZEM*(zSTAW_PODAT/100),0)
      oWAR_PUZ=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PUZ/100),2))
      oWAR_PZK=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PZK/100),2))
      if zAPUZ#'R'
         zWAR_PUZ=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PUZ/100),2))
      endif
      if zAPZK#'R'
         zWAR_PZK=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PZK/100),2))
      endif
      zWAR_PUZO=zWAR_PZK
      zPODATEK=_round(zBRUT_RAZEM*(zSTAW_PODAT/100),0)
      zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ)
      zDO_WYPLATY=zNETTO
      oWAR_FUE=_round(zPENSJA*(zSTAW_FUE/100),2)
      oWAR_FUR=_round(zPENSJA*(zSTAW_FUR/100),2)
      oWAR_FUW=_round(zPENSJA*(zSTAW_FUW/100),2)
      oWAR_FFP=_round(zPENSJA*(zSTAW_FFP/100),2)
      oWAR_FFG=_round(zPENSJA*(zSTAW_FFG/100),2)
      oWAR_FSUM=oWAR_FUE+oWAR_FUR+oWAR_FUW+oWAR_FFP+oWAR_FFG
      if zAFUE#'R'
         zWAR_FUE=_round(zPENSJA*(zSTAW_FUE/100),2)
      endif
      if zAFUR#'R'
         zWAR_FUR=_round(zPENSJA*(zSTAW_FUR/100),2)
      endif
      if zAFUW#'R'
         zWAR_FUW=_round(zPENSJA*(zSTAW_FUW/100),2)
      endif
      if zAFFP#'R'
         zWAR_FFP=_round(zPENSJA*(zSTAW_FFP/100),2)
      endif
      if zAFFG#'R'
         zWAR_FFG=_round(zPENSJA*(zSTAW_FFG/100),2)
      endif
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG
      zSTAW_FSUM=zSTAW_FUE+zSTAW_FUR+zSTAW_FUW+zSTAW_FFP+zSTAW_FFG
      zSTAW_PSUM=zSTAW_PUE+zSTAW_PUR+zSTAW_PUC
     else
      zPENSJA=zBRUT_ZASAD
      zBRUT_RAZEM=zPENSJA
      oWAR_PUE=_round(zPENSJA*(zSTAW_PUE/100),2)
      oWAR_PUR=_round(zPENSJA*(zSTAW_PUR/100),2)
      oWAR_PUC=_round(zPENSJA*(zSTAW_PUC/100),2)
      oWAR_PSUM=oWAR_PUE+oWAR_PUR+oWAR_PUC
      if zAPUE#'R'
         zWAR_PUE=_round(zPENSJA*(zSTAW_PUE/100),2)
      endif
      if zAPUR#'R'
         zWAR_PUR=_round(zPENSJA*(zSTAW_PUR/100),2)
      endif
      if zAPUC#'R'
         zWAR_PUC=_round(zPENSJA*(zSTAW_PUC/100),2)
      endif
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC
      if zAKOSZT#'R'
         zKOSZT=_round((zBRUT_ZASAD-zWAR_PSUM)*(zKOSZTY/100),2)
      endif
      zDOCHOD=max(0,zBRUT_RAZEM-(zKOSZT+zWAR_PSUM))
      zDOCHODPOD=_round(zDOCHOD,0)
      B5=zDOCHODPOD*(zSTAW_PODAT/100)
      oWAR_PUZ=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PUZ/100),2))
      oWAR_PZK=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PZK/100),2))
      if zAPUZ#'R'
         zWAR_PUZ=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PUZ/100),2))
      endif
      if zAPZK#'R'
         zWAR_PZK=min(B5,_round((zBRUT_RAZEM-zWAR_PSUM)*(zSTAW_PZK/100),2))
      endif
      zWAR_PUZO=zWAR_PZK
      zPODATEK=max(0,_round(B5-zWAR_PZK,0))
      zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ)
      zDO_WYPLATY=zNETTO
      oWAR_FUE=_round(zPENSJA*(zSTAW_FUE/100),2)
      oWAR_FUR=_round(zPENSJA*(zSTAW_FUR/100),2)
      oWAR_FUW=_round(zPENSJA*(zSTAW_FUW/100),2)
      oWAR_FFP=_round(zPENSJA*(zSTAW_FFP/100),2)
      oWAR_FFG=_round(zPENSJA*(zSTAW_FFG/100),2)
      oWAR_FSUM=oWAR_FUE+oWAR_FUR+oWAR_FUW+oWAR_FFP+oWAR_FFG
      if zAFUE#'R'
         zWAR_FUE=_round(zPENSJA*(zSTAW_FUE/100),2)
      endif
      if zAFUR#'R'
         zWAR_FUR=_round(zPENSJA*(zSTAW_FUR/100),2)
      endif
      if zAFUW#'R'
         zWAR_FUW=_round(zPENSJA*(zSTAW_FUW/100),2)
      endif
      if zAFFP#'R'
         zWAR_FFP=_round(zPENSJA*(zSTAW_FFP/100),2)
      endif
      if zAFFG#'R'
         zWAR_FFG=_round(zPENSJA*(zSTAW_FFG/100),2)
      endif
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG
      zSTAW_FSUM=zSTAW_FUE+zSTAW_FUR+zSTAW_FUW+zSTAW_FFP+zSTAW_FFG
      zSTAW_PSUM=zSTAW_PUE+zSTAW_PUR+zSTAW_PUC
      endif
return .t.
***************************************************************************
proc PODSTAWu
***************************************************************************
zAKOSZT=AKOSZT
zAPUZ=APUZ
zAPUE=APUE
zAPUR=APUR
zAPUC=APUC
zAPUW=APUW
zAPFP=APFP
zAPFG=APFG
zAPF3=APF3
zAFUZ=AFUZ
zAFUE=AFUE
zAFUR=AFUR
zAFUC=AFUC
zAFUW=AFUW
zAFFP=AFFP
zAFFG=AFFG
zAFF3=AFF3
zAPZK=APZK

zBRUT_ZASAD=BRUT_ZASAD

zKOSZT=KOSZT
zKOSZTY=KOSZTY

zSTAW_PUE=STAW_PUE
zSTAW_PUR=STAW_PUR
zSTAW_PUC=STAW_PUC
zSTAW_PSUM=STAW_PSUM
zWAR_PUE=WAR_PUE
zWAR_PUR=WAR_PUR
zWAR_PUC=WAR_PUC
zWAR_PSUM=WAR_PSUM

zSTAW_PODAT=STAW_PODAT
zSTAW_PUZ=STAW_PUZ
zWAR_PUZ=WAR_PUZ
zSTAW_PZK=STAW_PZK
zWAR_PZK=WAR_PZK
zWAR_PUZO=WAR_PUZO

zSTAW_FUE=STAW_FUE
zSTAW_FUR=STAW_FUR
zSTAW_FUW=STAW_FUW
zSTAW_FFP=STAW_FFP
zSTAW_FFG=STAW_FFG
zSTAW_FSUM=STAW_FSUM
zWAR_FUE=WAR_FUE
zWAR_FUR=WAR_FUR
zWAR_FUW=WAR_FUW
zWAR_FFP=WAR_FFP
zWAR_FFG=WAR_FFG
zWAR_FSUM=WAR_FSUM

zBRUT_RAZEM=BRUT_RAZEM
zDOCHOD=DOCHOD
zDOCHODPOD=DOCHODPOD
*zZAOPOD=ZAOPOD
*zJAKZAO=iif(zZAOPOD=1,'D','Z')
zPENSJA=PENSJA
zPODATEK=PODATEK
zNETTO=NETTO
zDO_WYPLATY=DO_WYPLATY

B5=zDOCHODPOD*(zSTAW_PODAT/100)
//002a nowa linia

do case
*case TYTUL='0'
*     zTYT='O' //organy stanowiace
case TYTUL='1'
     zTYT='A' //aktywizacja
case TYTUL='2'
     zTYT='C' //czlonkowstwo w spoldzielni
case TYTUL='3'
     zTYT='E' //emerytury i renty zagraniczne
case TYTUL='4'
     zTYT='F' //swiadczenia z funduszu pracy i GSP
case TYTUL='9'
     zTYT='S' //obowiazki spoleczne

case TYTUL='6'
     zTYT='P' //prawa autorskie
case TYTUL='7'
     zTYT='I' //inne zrodla
case TYTUL='8'
     zTYT='R' //kontrakty menadzerskie
CASE TYTUL = '10'
     zTYT := 'O'
other
     zTYT='Z' //umowy zlecenia i o dzielo 5
endcase

zTYTUL=TYTUL
***************************************************************************
proc ZAPISZPLAu
***************************************************************************
repl_('AKOSZT',zAKOSZT)
repl_('APUZ',zAPUZ)
repl_('APUE',zAPUE)
repl_('APUR',zAPUR)
repl_('APUC',zAPUC)
repl_('APUW',zAPUW)
repl_('APFP',zAPFP)
repl_('APFG',zAPFG)
repl_('APF3',zAPF3)
repl_('AFUZ',zAFUZ)
repl_('AFUE',zAFUE)
repl_('AFUR',zAFUR)
repl_('AFUC',zAFUC)
repl_('AFUW',zAFUW)
repl_('AFFP',zAFFP)
repl_('AFFG',zAFFG)
repl_('AFF3',zAFF3)
repl_('APZK',zAPZK)

repl_('BRUT_ZASAD',zBRUT_ZASAD)
repl_('KOSZT',     zKOSZT     )
repl_('KOSZTY',    zKOSZTY    )
repl_('STAW_PUE',  zSTAW_PUE  )
repl_('STAW_PUr',  zSTAW_PUr  )
repl_('STAW_PUc',  zSTAW_PUc  )
repl_('STAW_PSUM', zSTAW_PSUM )
repl_('WAR_pUE',   zWAR_pUE  )
repl_('WAR_pUr',   zWAR_pUr  )
repl_('WAR_pUc',   zWAR_pUc  )
repl_('WAR_psum',  zWAR_psum )
repl_('STAW_PODAT',zSTAW_PODAT)
repl_('STAW_PUz',  zSTAW_PUz  )
repl_('WAR_pUz',   zWAR_pUz  )
repl_('STAW_Pzk',  zSTAW_Pzk  )
repl_('WAR_pzk',   zWAR_pzk  )
repl_('WAR_pUzO',  zWAR_pUzO )
repl_('STAW_fUE',  zSTAW_fUE  )
repl_('STAW_fUr',  zSTAW_fUr  )
repl_('STAW_fUw',  zSTAW_fUw  )
repl_('STAW_ffp',  zSTAW_ffp  )
repl_('STAW_ffg',  zSTAW_ffg  )
repl_('STAW_fsum', zSTAW_fsum )
repl_('WAR_fUE',   zWAR_fUE  )
repl_('WAR_fUr',   zWAR_fUr  )
repl_('WAR_fUw',   zWAR_fUw  )
repl_('WAR_ffp',   zWAR_ffp  )
repl_('WAR_ffg',   zWAR_ffg  )
repl_('WAR_fsum',  zWAR_fsum )
repl_('BRUT_RAZEM',zBRUT_RAZEM)
repl_('DOCHOD',    zDOCHOD    )
repl_('DOCHODPOD', zDOCHODPOD )
*repl_('ZAOPOD',    zZAOPOD    )
repl_('PENSJA',    zPENSJA    )
repl_('PODATEK',   zPODATEK   )
repl_('NETTO',     zNETTO     )
repl_('DO_WYPLATY',zDO_WYPLATY)
//002a nowa linia

do case
*case zTYT='O'
*     zTYTUL:='0'
case zTYT='A'
     zTYTUL:='1'
case zTYT='C'
     zTYTUL:='2'
case zTYT='E'
     zTYTUL:='3'
case zTYT='F'
     zTYTUL:='4'
case zTYT='S'
     zTYTUL:='9'

case zTYT='P'
     zTYTUL:='6'
case zTYT='I'
     zTYTUL:='7'
case zTYT='R'
     zTYTUL:='8'
CASE zTYT = 'O'
     zTYTUL := '10'
otherwise
     zTYTUL :='5' //<--= brak danych
endcase

repl_('TYTUL',     zTYTUL)

//002a nowe funkcje
func jaki_tytul
   ColInf()
   @  4,50 clear to 16,79
   @  4,50 to 16,79
   @  5,51 say padc('Wpisz:',28)
   @  6,51 say 'Z - umowy zlecenia i o dziel'
   @  7,51 say 'P - prawa autorskie i inne  '
*   @  8,51 say 'K - kontrakty menedzerskie  '
   @  8,51 say 'I - inne zrodla             '
   @  9,51 say 'C - czlonkowstwo w spoldziel'
   @ 10,51 say 'E - emerytury,renty zagrani.'
   @ 11,51 say 'F - swiadczenia z FP i FGSP '
   @ 12,51 say 'S - spoleczne obowiazki     '
*   @ 14,51 say 'O - organy stanowiace       '
   @ 13,51 say 'A - aktywizacyjna umowa     '
   @ 14,51 say 'R - ryczalt do 200zl        '
   @ 15,51 say 'O - obcokrajowiec           '
*  @ 24,0 say padc('Wpisz: A-rtyst.dzia&_l.alno&_s.&_c.,Z-lecenia i dzie&_l.a,P-rawa autorskie,K-ontrakty,I-nne',80,' ')
return .t.
func wAUTOKOM
   ColInf()
   @ 24,0 say padc('Wpisz: A-automatyczne wyliczanie kwoty, R-r&_e.czna aktualizacja kwot',80,' ')
return .t.
func vAUTOKOM
   ColStd()
   @ 24,0 clear
return .t.
***************************************************
*function wJAKZAOu
*para x,y
*ColInf()
*@ 24,0 say padc('Jak zaokraglic podatek: Z-do zlotowki   lub   D-do dziesieciu groszy',80,' ')
*ColStd()
*@ x,y say iif(zJAKZAO='D','ziesiec groszy','lotowka       ')
*return .t.
***************************************************
*function vJAKZAOu
*para x,y
*R=.f.
*if zJAKZAO$'DZ'
*   ColStd()
*   @ x,y say iif(zJAKZAO='D','ziesiec groszy','lotowka       ')
*   @ 24,0
*   R=.t.
*endif
*return R
***************************************************
