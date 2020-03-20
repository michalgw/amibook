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
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
para typpit
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
select 1
if dostep('SPOLKA')
   do setind with 'SPOLKA'
   seek [+]+ident_fir
else
   close_()
   return
endif
if del#[+].or.firma#ident_fir
   kom(5,[*u],[ Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ])
   close_()
   return
endif
*--------------------------------------
skip
spolka=(del=[+].and.firma=ident_fir)
skip -1
*--------------------------------------
nr_rec=recno()
spolka_=.t.
do while del=[+].and.firma=ident_fir
   **********************
   udzial=[  0/1  ]
   for i=1 to val(miesiac)
       zm=[udzial]+ltrim(str(i))
       if [   /   ]#&zm
          udzial=&zm
       endif
   next
   **********************
   if udzial=[  1/1  ]
      spolka_=.f.
      nr_rec=recno()
      exit
   endif
   skip
enddo
go nr_rec
*--------------------------------------
@ 3,42 clear to 22,79
if .not.spolka
   opcja1p=1
   if SPOSOB='L'
      save scre to ROBSO1P
      do while .t.
         *=============================
         ColPro()
         @ 12,44 to 14,77
         @ 13,45 prompt [ Raport obl.podatku liniowo     ]
*        @ 13,45 prompt [ L - PIT-5L (3) (GZELLA  I/2006)]
*        @ 14,45 prompt [ P - PIT-5L (1) (UNIPAP  I/2004)]
         opcja1p=menu(opcja1p)
         ColStd()
         if lastkey()=27
            exit
         endif
         *=============================
         save screen to scr2P
         papier='R'
         do case
         case opcja1p=1
*             set curs on
*             ColStd()
*             @ 13,57 say space(20)
*             @ 13,64 get papier pict '!' when wKART2(13,64) valid vKART2(13,64)
*             read
*             set curs off
*             @ 24,0
              if lastkey()<>27
                 typpit='L'
                 exit
              endif
         case opcja1p=2
              set curs on
              ColStd()
              @ 14,57 say space(20)
              @ 14,64 get papier pict '!' when wKART(14,64) valid vKART(14,64)
              read
              set curs off
              @ 24,0
              if lastkey()<>27
                 typpit='P'
                 exit
              endif
         endcase
*         close_()
         rest scre from SCR2P
      enddo
      rest scre from ROBSO1P
   else
      save scre to ROBSO1P
      do while .t.
         *=============================
         ColPro()
         @ 12,44 to 14,77
         @ 13,45 prompt [ Raport obl.podatku progresywnie]
*        @ 14,45 prompt [ 0 - PIT-5  (13)(UNIPAP  I/2004)]
         opcja1p=menu(opcja1p)
         ColStd()
         if lastkey()=27
            exit
         endif
         *=============================
         save screen to scr2P
         papier='R'
         do case
         case opcja1p=1
*             set curs on
*             ColStd()
*             @ 13,57 say space(20)
*             @ 13,64 get papier pict '!' when wKART2(13,64) valid vKART2(13,64)
*             read
*             set curs off
*             @ 24,0
              if lastkey()<>27
                 typpit='5'
                 exit
              endif
         case opcja1p=2
              set curs on
              ColStd()
              @ 14,57 say space(20)
              @ 14,64 get papier pict '!' when wKART(14,64) valid vKART(14,64)
              read
              set curs off
              @ 24,0
              if lastkey()<>27
                 typpit='Z'
                 exit
              endif
         endcase
*         close_()
         rest scre from SCR2P
      enddo
      rest scre from ROBSO1P
   endif

   do case
   case typpit='5'
      do case
      case papier='K'
         do pit_5 with 0,0,1,'K'
      case papier='F'
         afill(nazform,'')
         afill(strform,0)
         nazform[1]='PIT-5'
         strform[1]=4
         form(nazform,strform,1)
      case papier='R'
         do pit_5 with 0,0,1,'R'
      endcase
   case typpit='Z'
      if papier='K'
         do pit_5z with 0,0,1,'K'
      else
         afill(nazform,'')
         afill(strform,0)
         nazform[1]='PIT-5z'
         strform[1]=4
         form(nazform,strform,1)
      endif
   case typpit='L'
      do case
      case papier='K'
         do pit_5l with 0,0,1,'K'
      case papier='F'
         afill(nazform,'')
         afill(strform,0)
         nazform[1]='PIT-5L'
         strform[1]=3
         form(nazform,strform,1)
      case papier='R'
         do pit_5l with 0,0,1,'R'
      endcase
   case typpit='P'
      if papier='K'
         do pit_5lp with 0,0,1,'K'
      else
         afill(nazform,'')
         afill(strform,0)
         nazform[1]='PIT-5Lp'
         strform[1]=3
         form(nazform,strform,1)
      endif
   endcase
   close_()
   return
endif
*################################# GRAFIKA ##################################
@ 3,42 clear to 22,79
ColStd()
@  3,44 say '            Podatnik:             '
@  4,44 say 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
@  5,44 say 'º                                º'
@  6,44 say 'º                                º'
@  7,44 say 'º                                º'
@  8,44 say 'º                                º'
@  9,44 say 'º                                º'
@ 10,44 say 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
*################################# OPERACJE #################################
*----- parametry ------
_row_g=5
_col_l=45
_row_d=9
_col_p=76
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia51()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27
ColSta()
   @ 1,47 say '[F1]-pomoc'
set colo to
   _row=wybor(_row)
   kl=lastkey()
   do case
   *################################### DOCH ###################################
   case kl=13
        opcja1p=1
        if SPOSOB='L'
           save scre to ROBSO1P
           do while .t.
              *=============================
              ColPro()
              @ 12,44 to 14,77
              @ 13,45 prompt [ Raport obl.podatku liniowo     ]
*             @ 14,45 prompt [ L - PIT-5L (1) (UNIPAP  I/2004)]
              opcja1p=menu(opcja1p)
              ColStd()
              if lastkey()=27
                 exit
              endif
              *=============================
              save screen to scr2P
              papier='R'
              do case
              case opcja1p=1
*                  set curs on
*                  ColStd()
*                  @ 13,57 say space(20)
*                  @ 13,64 get papier pict '!' when wKART2(13,64) valid vKART2(13,64)
*                  read
*                  set curs off
*                  @ 24,0
                   if lastkey()<>27
                      typpit='L'
                      exit
                   endif
              case opcja1p=2
                   set curs on
                   ColStd()
                   @ 14,57 say space(20)
                   @ 14,64 get papier pict '!' when wKART(14,64) valid vKART(14,64)
                   read
                   set curs off
                   @ 24,0
                   if lastkey()<>27
                      typpit='P'
                      exit
                   endif
              endcase
*              close_()
              rest scre from SCR2P
           enddo
           rest scre from ROBSO1P
        else
           save scre to ROBSO1P
           do while .t.
              *=============================
              ColPro()
              @ 12,44 to 14,77
              @ 13,45 prompt [ Raport obl.podatku progresywnie]
*             @ 14,45 prompt [ 0 - PIT-5  (13)(UNIPAP  I/2004)]
              opcja1p=menu(opcja1p)
              ColStd()
              if lastkey()=27
                 exit
              endif
              *=============================
              save screen to scr2P
              papier='R'
              do case
              case opcja1p=1
*                  set curs on
*                  ColStd()
*                  @ 13,57 say space(20)
*                  @ 13,64 get papier pict '!' when wKART2(13,64) valid vKART2(13,64)
*                  read
*                  set curs off
*                  @ 24,0
                   if lastkey()<>27
                      typpit='5'
                      exit
                   endif
              case opcja1p=2
                   set curs on
                   ColStd()
                   @ 14,57 say space(20)
                   @ 14,64 get papier pict '!' when wKART(14,64) valid vKART(14,64)
                   read
                   set curs off
                   @ 24,0
                   if lastkey()<>27
                      typpit='Z'
                      exit
                   endif
              endcase
*              close_()
              rest scre from SCR2P
           enddo
           rest scre from ROBSO1P
        endif

        save screen to scr2
        nr_rec=recno()
        do case
        case typpit='5'
             do case
             case papier='K'
                do pit_5 with 0,0,1,'K'
             case papier='F'
                afill(nazform,'')
                afill(strform,0)
                nazform[1]='PIT-5'
                strform[1]=4
                form(nazform,strform,1)
             case papier='R'
                do pit_5 with 0,0,1,'R'
             endcase
        case typpit='Z'
             if papier='K'
                do pit_5z with 0,0,1,'K'
             else
                afill(nazform,'')
                afill(strform,0)
                nazform[1]='PIT-5z'
                strform[1]=4
                form(nazform,strform,1)
             endif
        case typpit='L'
             do case
             case papier='K'
                do pit_5l with 0,0,1,'K'
             case papier='F'
                afill(nazform,'')
                afill(strform,0)
                nazform[1]='PIT-5L'
                strform[1]=3
                form(nazform,strform,1)
             case papier='R'
                do pit_5l with 0,0,1,'R'
             endcase
        case typpit='P'
             if papier='K'
                do pit_5lp with 0,0,1,'K'
             else
                afill(nazform,'')
                afill(strform,0)
                nazform[1]='PIT-5Lp'
                strform[1]=3
                form(nazform,strform,1)
             endif
        endcase
        select 1
        do while.not.dostep('SPOLKA')
        enddo
        do setind with 'SPOLKA'
        go nr_rec
        restore screen from scr2
        _disp=.f.
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
        p[ 5]='   [Enter].................akceptacja                   '
        p[ 6]='   [Esc]...................wyj&_s.cie                      '
        p[ 7]='                                                        '
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
function linia51
return ' '+dos_c(naz_imie)+' '
*############################################################################
