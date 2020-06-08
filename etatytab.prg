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
para mieskart
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,kluc,ins,nr_rec,wiersz,f10,rec,fou,mieslok
public z_dowyp
zData_wwyp=date()
zkwota_wwyp=0
mieslok=mieskart
for x=1 to 12
    xx=strtran(str(x,2),' ','0')
    zP4RC4&XX=0
    zP4RC5&XX=0
    zP4RC6&XX=0
    zP4RC7&XX=0
    zP4RC8&XX=0
next
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say padc('D O D A T K O W E   D A N E   D O   P I T - 4 R',80)
@  4, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ C4-Zal.na pod.kt&_o.rych pob&_o.r zosta&_l. ogr.Art32ust2'
@  5, 0 say '³                             ³ C5-Zal.do pobr.w zwi&_a.zku z ogr.zal.w poprz.mies.'
@  6, 0 say '³                             ³ C6-Dodat.pobrany pod.wynikaj&_a.cy z rozl.za rok.ub'
@  7, 0 say '³                             ³ C7-Nadp&_l..z rozl.za rok ubieg&_l.y i zwrot nadp&_l.at  '
@  8, 0 say '³                             ³ C8-Pobrany pod.na PFRON i zak&_l.adowy FRON        '
@  9, 0 say '³                             ³ M-c SekcjaC4 SekcjaC5 SekcjaC6 SekcjaC7 SekcjaC8'
@ 10, 0 say '³                             ³  1                                              '
@ 11, 0 say '³                             ³  2                                              '
@ 12, 0 say '³                             ³  3                                              '
@ 13, 0 say '³                             ³  4                                              '
@ 14, 0 say '³                             ³  5                                              '
@ 15, 0 say '³                             ³  6                                              '
@ 16, 0 say '³                             ³  7                                              '
@ 17, 0 say '³                             ³  8                                              '
@ 18, 0 say '³                             ³  9                                              '
@ 19, 0 say '³                             ³ 10                                              '
@ 20, 0 say '³                             ³ 11                                              '
@ 21, 0 say '³                             ³ 12                                              '
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙSUMA                                             '
ColInf()
@  9,43 say '4'
@  9,52 say '5'
@  9,61 say '6'
@  9,70 say '7'
@  9,79 say '8'
set colo to w
@  4,35 say 'Zal.na pod.kt&_o.rych pob&_o.r zosta&_l. ogr.Art32ust2'
@  5,35 say 'Zal.do pobr.w zwi&_a.zku z ogr.zal.w poprz.mies.'
@  6,35 say 'Dodat.pobrany pod.wynikaj&_a.cy z rozl.za rok.ub'
@  7,35 say 'Nadp&_l..z rozl.za rok ubieg&_l.y i zwrot nadp&_l.at  '
@  8,35 say 'Pobrany pod.na PFRON i zak&_l.adowy FRON        '
set colo to
*ColStd()
*############################### OTWARCIE BAZ ###############################
select 2
do while.not.dostep('ETATY')
enddo
do setind with 'ETATY'
seek [+]+ident_fir
select 1
do while.not.dostep('PRAC')
enddo
do setind with 'PRAC'
set orde to 2
SET FILTER TO prac->aktywny == 'T'
seek [+]+ident_fir+[+]
if eof().or.del#'+'.or.firma#ident_fir.or.status>'U'
   kom(3,[*u],[ Brak pracownik&_o.w etatowych ])
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=5
_col_l=1
_row_d=21
_col_p=29
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,13,247,75,107,7,28,52,53,54,55,56]
_top=[firma#ident_fir.or.status>'U']
_bot=[del#'+'.or.firma#ident_fir.or.status>'U']
_stop=[+]+ident_fir+[+]
_sbot=[+]+ident_fir+[+]+[þ]
_proc=[say41er()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say41esr]
_disp=.t.
_cls=''
*----------------------
kl=0
siacpla='  '
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   case kl=107.or.kl=75
        save scre to robs
        Kartot_W( mieslok )
        rest scre from robs
   *################################### POMOC ##################################
   case kl=28
        save screen to scr_
        @ 1,47 say [          ]
        declare p[20]
        *---------------------------------------
        p[ 1]='                                                                       '
        p[ 2]='  ['+chr(24)+'/'+chr(25)+']...........poprzedni/nast&_e.pny pracownik                         '
        p[ 3]='  [Home/End]......pierwszy/ostatni pracownik                           '
        if mieslok='C'
           p[ 4]='  [K].............kartoteka wynagrodze&_n. - ca&_l.y rok                     '
        else
           p[ 4]='  [K].............kartoteka dodruk za m-c '+mieslok+'                           '
        endif
        p[ 5]='  [4].............edycja sekcji C.4. PIT-4R                            '
        p[ 6]='  [5].............edycja sekcji C.5. PIT-4R                            '
        p[ 7]='  [6].............edycja sekcji C.6. PIT-4R                            '
        p[ 8]='  [7].............edycja sekcji C.7. PIT-4R                            '
        p[ 9]='  [8].............edycja sekcji C.8. PIT-4R                            '
        p[10]='  [Esc]...........wyjscie                                              '
        p[11]='                                                                       '
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
   case kl=52
* klawisz 4
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               @ 9+x,36 prompt transform(zP4RC4&XX,'99999')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
               @ 9+mieda,36 get zP4RC4&XX pict '@R 99999'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([PIT4RC4],zP4RC4&XX)
                     COMMIT
                     unlock
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   case kl=53
* klawisz 5
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               @ 9+x,45 prompt transform(zP4RC5&XX,'99999')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
               @ 9+mieda,45 get zP4RC5&XX pict '@R 99999'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([PIT4RC5],zP4RC5&XX)
                     COMMIT
                     unlock
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   case kl=54
* klawisz 6
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               @ 9+x,54 prompt transform(zP4RC6&XX,'99999')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13 .and. mieda<=4
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
               @ 9+mieda,54 get zP4RC6&XX pict '@R 99999' when mieda<=4
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([PIT4RC6],zP4RC6&XX)
                     COMMIT
                     unlock
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   case kl=55
* klawisz 7
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               @ 9+x,63 prompt transform(zP4RC7&XX,'99999')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
               @ 9+mieda,63 get zP4RC7&XX pict '@R 99999'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([PIT4RC7],zP4RC7&XX)
                     COMMIT
                     unlock
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   case kl=56
* klawisz 8
        if zRYCZALT='T'
           sele 100
           do while.not.dostep('EWID')
           enddo
           do SETIND with 'EWID'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        else
           sele 100
           do while.not.dostep('OPER')
           enddo
           do SETIND with 'OPER'
           seek [+]+ident_fir
           mc_rozp=iif(del=[+].and.firma=ident_fir,mc,[  ])
           seek [+]+ident_fir+[þ]
           skip -1
           aktualny=iif(del=[+].and.firma=ident_fir,mc,[  ])
           use
        endif
        sele prac
        siacpla=iif(siacpla=[  ],aktualny,siacpla)
        mieda=val(siacpla)
        do while .t.
           set curs off
           ColPro()
           for x=1 to 12
               xx=strtran(str(x,2),' ','0')
               @ 9+x,72 prompt transform(zP4RC8&XX,'99999')
           next
           mieda=menu(mieda)
           ColStd()
           if lastkey()=27
              exit
           endif
           if lastkey()=13
               ColStb()
               center(23,[þ                       þ])
               ColSta()
               center(23,  [M O D Y F I K A C J A])
               ColStd()
               xx=strtran(str(mieda,2),' ','0')
               @ 9+mieda,72 get zP4RC8&XX pict '@R 99999'
               set conf on
               set curs on
               read
               set curs off
               set conf off
               if lastkey()=13
                  zidp=str(rec_no,5)
                  sele etaty
                  seek [+]+ident_fir+zidp+str(mieda,2)
                  if found()
                     do BLOKADAR
                     repl_([PIT4RC8],zP4RC8&XX)
                     COMMIT
                     unlock
                  endif
                  sele prac
               endif
               @ 23,0
           endif
        enddo
   endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say41er
znazwisko=padr(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),29)
return znazwisko
*##############################################################################
procedure say41esr
zP4RC4SUM=0
zP4RC5SUM=0
zP4RC6SUM=0
zP4RC7SUM=0
zP4RC8SUM=0
clear type
set color to +w
zidp=str(rec_no,5)
sele etaty
seek [+]+ident_fir+zidp+' 1'
if found()
   for x=1 to 12
       xx=strtran(str(x,2),' ','0')
       zP4RC4&XX=PIT4RC4
       zP4RC5&XX=PIT4RC5
       zP4RC6&XX=PIT4RC6
       zP4RC7&XX=PIT4RC7
       zP4RC8&XX=PIT4RC8
       zP4RC4SUM=zP4RC4SUM+PIT4RC4
       zP4RC5SUM=zP4RC5SUM+PIT4RC5
       zP4RC6SUM=zP4RC6SUM+PIT4RC6
       zP4RC7SUM=zP4RC7SUM+PIT4RC7
       zP4RC8SUM=zP4RC8SUM+PIT4RC8
       set color to +w
       @ 9+x,36 say zP4RC4&XX pict '99999'
       @ 9+x,45 say zP4RC5&XX pict '99999'
       @ 9+x,54 say zP4RC6&XX pict '99999'
       @ 9+x,63 say zP4RC7&XX pict '99999'
       @ 9+x,72 say zP4RC8&XX pict '99999'
       skip 1
   next
   @ 22,36 say zP4RC4SUM pict '99999'
   @ 22,45 say zP4RC5SUM pict '99999'
   @ 22,54 say zP4RC6SUM pict '99999'
   @ 22,63 say zP4RC7SUM pict '99999'
   @ 22,72 say zP4RC8SUM pict '99999'
endif
sele prac
set color to
return
*############################################################################
