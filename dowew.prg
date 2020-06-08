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
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@  1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say padc('D O W &__O. D   W E W N &__E. T R Z N Y',80)
@  4, 0 say 'Zes Nr                                                 Zestaw drukow.jako  Druk '
@  5, 0 say 'taw kol.          Opis pozycji               Wartosc     Data     Nr dok.  owac '
      KKOLG='ÚÄÄÂÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄ¿'
      KKOL ='³  ³  ³                                   ³          ³          ³          ³   ³'
      KKOLS='ÀÄÄÁÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÙ'
@  6, 0 say KKOLG
for x=7 to 20
    @ x, 0 say KKOL
next
@ 21, 0 say KKOLS
@ 22, 0 say space(80)
*############################### OTWARCIE BAZ ###############################
sele 1
if dostep('DOWEW')
   do setind with 'DOWEW'
   seek [+]+ident_fir
else
   close_()
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=7
_col_l=1
_row_d=20
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,68,100,22,48,77,109,7,46,28,13]
_top=[del#'+'.or.firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia622a()]
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
              zDATA=ctod('    .  .  ')
              zNRDOK=space(10)
              zZESTAW='  '
              zNRKOL='  '
              zOPIS=space(100)
              zWARTOSC=0
              zDRUKOWAC=.t.
           else
              zDATA=DATA
              zNRDOK=NRDOK
              zZESTAW=ZESTAW
              zNRKOL=NRKOL
              zOPIS=OPIS
              zWARTOSC=WARTOSC
              zDRUKOWAC=DRUKOWAC
           endif
           *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
           @ wiersz,1  get zZESTAW picture '!!'
           @ wiersz,4  get zNRKOL picture '!!'
           @ wiersz,7  get zOPIS  picture '@S35 X'+repl('X',100)
           @ wiersz,43 get zWARTOSC picture '9999999.99'
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
           repl_([DATA],zDATA)
           repl_([NRDOK],zNRDOK)
           repl_([ZESTAW],zZESTAW)
           repl_([NRKOL],zNRKOL)
           repl_([OPIS],zOPIS)
           repl_([WARTOSC],zWARTOSC)
           repl_([DRUKOWAC],zDRUKOWAC)
           commit_()
           unlock
           *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              exit
           endif
           @ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [  ³  ³                                     ³        ³          ³          ³   ]
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
           COMMIT
           unlock
           skip
           commit_()
           if &_bot
              skip -1
           endif
        endif
        @ 23,0
   *############################### WYDRUK EWIDENCJI ###########################
   case kl=13
        begin sequence
              save screen to scr_
              RECS=recno()
              do doweww
              go RECS
              restore screen from scr_
        end
   *############################### WYDRUK EWIDENCJI ###########################
   case kl=68.or.kl=100
        do BLOKADAR
        repl drukowac with .not.drukowac
        COMMIT
        unlock
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
        p[ 7]='   [D].....................drukowa&_c./nie drukowa&_c. pozycje'
        p[ 8]='   [Del]...................kasowanie pozycji            '
        p[ 9]='   [Enter].................wydruk dowodu wewn&_e.trznego   '
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
*############################################################################
function linia622a
return ZESTAW+[³]+NRKOL+[³]+substr(OPIS,1,35)+[³]+str(WARTOSC,10,2)+[³]+dtoc(DATA)+[³]+NRDOK+[³]+iif(DRUKOWAC,'Tak','Nie')
*############################################################################
