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

FUNCTION Inne()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
*############################### OTWARCIE BAZ ###############################
select 2
if dostep('DANE_MC')
   set inde to dane_mc
else
   sele 1
   close_()
   return
endif
select 1
if dostep('SPOLKA')
   do setind with 'SPOLKA'
   seek [+]+ident_fir
else
   sele 1
   close_()
   return
endif
if del#[+].or.firma#ident_fir
   kom(5,[*u],[ Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej funkcji ])
   close_()
   return
endif
skip
spolka=(del=[+].and.firma=ident_fir)
skip -1
                                                          if .not.spolka
save screen to scr2
do inne_
restore screen from scr2
                                                          close_()
                                                          return
                                                          else
*################################# GRAFIKA ##################################
@ 3,42 clear to 22,79
ColStd()
@  7,44 say '            Podatnik:             '
@  8,44 say 'ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»'
@  9,44 say 'º                                º'
@ 10,44 say 'º                                º'
@ 11,44 say 'º                                º'
@ 12,44 say 'º                                º'
@ 13,44 say 'º                                º'
@ 14,44 say 'º                                º'
@ 15,44 say 'º                                º'
@ 16,44 say 'ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼'
*################################# OPERACJE #################################
*----- parametry ------
_row_g=9
_col_l=45
_row_d=15
_col_p=76
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,28,13]
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[linia24()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[]
_disp=.t.
_cls=''
*----------------------
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set color to
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
do case
*################################### INNE ###################################
              case kl=13
save screen to scr2
do inne_
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
                                                          endif
*################################## FUNKCJE #################################
function linia24
return ' '+dos_c(naz_imie)+' '
*############################################################################
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
procedure inne_
private _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
ColStd()
@  3, 0 say '                                                                                '
@  4, 0 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
@  5, 0 say '°            º 1.Rodzaj................                                        °'
@  6, 0 say '°Pozarolniczaº   Nr regon..............                      NIP:              °'
@  7, 0 say '° dzia&_l.alno&_s.&_c.º   Miejsce prowadzenia...                                        °'
@  8, 0 say '° gospodarczaº 2.Rodzaj................                                        °'
@  9, 0 say '°            º   Nr regon..............                      NIP:              °'
@ 10, 0 say '°            º   Miejsce prowadzenia...                                        °'
@ 11, 0 say '°            º 3.Rodzaj................                                        °'
@ 12, 0 say '°            º   Nr regon..............                      NIP:              °'
@ 13, 0 say '°            º   Miejsce prowadzenia...                                        °'
if sposob='L'
   @ 14, 0 say '°            º 4.Rodzaj................                                        °'
   @ 15, 0 say '°            º   Nr regon..............                      NIP:              °'
   @ 16, 0 say '°            º   Miejsce prowadzenia...                                        °'
else
   @ 14, 0 say '°            º                                                                 °'
   @ 15, 0 say '°            º                                                                 °'
   @ 16, 0 say '°            º                                                                 °'
endif
if sposob='L'
   @ 17, 0 say '°            º                                                                 °'
   @ 18, 0 say '°            º                                                                 °'
   @ 19, 0 say '°            º                                                                 °'
   @ 20, 0 say '°            º                                                                 °'
   @ 21, 0 say '°            º                                                                 °'
else
   @ 17, 0 say '°ÄÄÄÄÄÄÄÄÄÄÄÄ×ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ°'
   @ 18, 0 say '°    Najem   º 1.Przedmiot najmu.......                                        °'
   @ 19, 0 say '°     lub    º   Miejsce po&_l.o&_z.enia.....                                        °'
   @ 20, 0 say '°  dzier&_z.awa º 2.Przedmiot najmu.......                                        °'
   @ 21, 0 say '°            º   Miejsce po&_l.o&_z.enia.....                                        °'
endif
@ 22, 0 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
ColInf()
center(3,alltrim(naz_imie)+[ - INNE &__X.R&__O.D&__L.A PRZYCHOD&__O.W OD POCZ&__A.TKU ROKU])
ColStd()
*################################# OPERACJE #################################
*----- parametry ------
_proc=[say18]
*----------------------
   do &_proc
kl=0
do while kl#27
ColSta()
@ 1,47 say '[F1]-pomoc'
ColStd()
kl=inkey(0)
do case
*########################### INSERT/MODYFIKACJA #############################
              case kl=109.or.kl=77
@ 1,47 say [          ]
   ColStb()
   center(23,[þ                       þ])
   ColSta()
     center(23,[M O D Y F I K A C J A])
   ColStd()
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
   zG_RODZAJ1=G_RODZAJ1
   zG_REGON1=G_REGON1
   zG_NIP1=G_NIP1
   zG_MIEJSC1=G_MIEJSC1
   zG_RODZAJ2=G_RODZAJ2
   zG_REGON2=G_REGON2
   zG_NIP2=G_NIP2
   zG_MIEJSC2=G_MIEJSC2
   zG_RODZAJ3=G_RODZAJ3
   zG_REGON3=G_REGON3
   zG_NIP3=G_NIP3
   zG_MIEJSC3=G_MIEJSC3
   zG_RODZAJ4=G_RODZAJ4
   zG_REGON4=G_REGON4
   zG_NIP4=G_NIP4
   zG_MIEJSC4=G_MIEJSC4
   zN_PRZEDM1=N_PRZEDM1
   zN_MIEJSC1=N_MIEJSC1
   zN_PRZEDM2=N_PRZEDM2
   zN_MIEJSC2=N_MIEJSC2
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  5,39 get zG_RODZAJ1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
@  6,39 get zG_REGON1 picture  "@S20 !-999999999-99999999-99-9-999-99999" valid v18_1()
@  6,65 get zG_NIP1   picture  "!!!!!!!!!!!!!"
@  7,39 get zG_MIEJSC1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_2()
@  8,39 get zG_RODZAJ2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
@  9,39 get zG_REGON2 picture  "@S20 !-999999999-99999999-99-9-999-99999" valid v18_3()
@  9,65 get zG_NIP2   picture  "!!!!!!!!!!!!!"
@ 10,39 get zG_MIEJSC2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_4()
@ 11,39 get zG_RODZAJ3 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
@ 12,39 get zG_REGON3 picture  "@S20 !-999999999-99999999-99-9-999-99999" valid v18_1a()
@ 12,65 get zG_NIP3   picture  "!!!!!!!!!!!!!"
@ 13,39 get zG_MIEJSC3 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_2a()
if sposob='L'
   @ 14,39 get zG_RODZAJ4 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   @ 15,39 get zG_REGON4 picture  "@S20 !-999999999-99999999-99-9-999-99999" valid v18_3a()
   @ 15,65 get zG_NIP4   picture  "!!!!!!!!!!!!!"
   @ 16,39 get zG_MIEJSC4 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_4a()
endif
if sposob<>'L'
   @ 18,39 get zN_PRZEDM1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   @ 19,39 get zN_MIEJSC1 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_5()
   @ 20,39 get zN_PRZEDM2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   @ 21,39 get zN_MIEJSC2 picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v18_6()
endif
clear type
read_()
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
     zident=str(recno(),5)
     select dane_mc
     seek [+]+zident
     do while del=[+].and.ident=zident
        do BLOKADAR
        if empty(zg_rodzaj1)
           repl_([g_przych1],0)
           repl_([g_koszty1],0)
           repl_([g_udzial1],[ 1/1  ])
        endif
        if empty(zg_rodzaj2)
           repl_([g_przych2],0)
           repl_([g_koszty2],0)
           repl_([g_udzial2],[ 1/1  ])
        endif
        if empty(zg_rodzaj3)
           repl_([g_przych3],0)
           repl_([g_koszty3],0)
           repl_([g_udzial3],[ 1/1  ])
        endif
        if empty(zg_rodzaj4)
           repl_([g_przych4],0)
           repl_([g_koszty4],0)
           repl_([g_udzial4],[ 1/1  ])
        endif
        if empty(zn_przedm1)
           repl_([n_przych1],0)
           repl_([n_koszty1],0)
           repl_([n_udzial1],[ 1/1  ])
        endif
        if empty(zn_przedm2)
           repl_([n_przych2],0)
           repl_([n_koszty2],0)
           repl_([n_udzial2],[ 1/1  ])
        endif
        unlock
     skip
     enddo
     select spolka
     do BLOKADAR
     repl_([G_RODZAJ1],zG_RODZAJ1)
     repl_([G_REGON1],zG_REGON1)
     repl_([G_NIP1],zG_NIP1)
     repl_([G_MIEJSC1],zG_MIEJSC1)
     repl_([G_RODZAJ2],zG_RODZAJ2)
     repl_([G_REGON2],zG_REGON2)
     repl_([G_NIP2],zG_NIP2)
     repl_([G_MIEJSC2],zG_MIEJSC2)
     repl_([G_RODZAJ3],zG_RODZAJ3)
     repl_([G_REGON3],zG_REGON3)
     repl_([G_NIP3],zG_NIP3)
     repl_([G_MIEJSC3],zG_MIEJSC3)
     repl_([G_RODZAJ4],zG_RODZAJ4)
     repl_([G_REGON4],zG_REGON4)
     repl_([G_NIP4],zG_NIP4)
     repl_([G_MIEJSC4],zG_MIEJSC4)
     repl_([N_PRZEDM1],zN_PRZEDM1)
     repl_([N_MIEJSC1],zN_MIEJSC1)
     repl_([N_PRZEDM2],zN_PRZEDM2)
     repl_([N_MIEJSC2],zN_MIEJSC2)
     unlock
     commit_()
     *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do &_proc
ColStd()
@ 23,0 say repl([°],80)
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                                        '
p[ 2]='   [M].....................modyfikacja                  '
p[ 3]='   [Esc]...................wyj&_s.cie                      '
p[ 4]='                                                        '
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
******************** ENDCASE
endcase
enddo
*################################## FUNKCJE #################################
procedure say18
clear type
set color to +w
@  5,39 say G_RODZAJ1
@  6,39 say substr(G_REGON1,1,20)
@  6,65 say G_NIP1
@  7,39 say G_MIEJSC1
@  8,39 say G_RODZAJ2
@  9,39 say substr(G_REGON2,1,20)
@  9,65 say G_NIP2
@ 10,39 say G_MIEJSC2
@ 11,39 say G_RODZAJ3
@ 12,39 say substr(G_REGON3,1,20)
@ 12,65 say G_NIP3
@ 13,39 say G_MIEJSC3
if sposob='L'
   @ 14,39 say G_RODZAJ4
   @ 15,39 say substr(G_REGON4,1,20)
   @ 15,65 say G_NIP4
   @ 16,39 say G_MIEJSC4
endif
if sposob<>'L'
   @ 18,39 say N_PRZEDM1
   @ 19,39 say N_MIEJSC1
   @ 20,39 say N_PRZEDM2
   @ 21,39 say N_MIEJSC2
endif
ColStd()
****************************************
function v18_1
if lastkey()=5
   return .t.
endif
return .t.
****************************************
function v18_2
if lastkey()=5
return .t.
endif
return .not.empty(zg_rodzaj1).and..not.empty(zg_miejsc1).or.empty(zg_rodzaj1).and.empty(zg_miejsc1)
****************************************
function v18_3
if lastkey()=5
   return .t.
endif
return .t.
****************************************
function v18_4
if lastkey()=5
return .t.
endif
return .not.empty(zg_rodzaj2).and..not.empty(zg_miejsc2).or.empty(zg_rodzaj2).and.empty(zg_miejsc2)
****************************************
function v18_1a
if lastkey()=5
   return .t.
endif
return .t.
****************************************
function v18_2a
if lastkey()=5
return .t.
endif
return .not.empty(zg_rodzaj3).and..not.empty(zg_miejsc3).or.empty(zg_rodzaj3).and.empty(zg_miejsc3)
****************************************
function v18_3a
if lastkey()=5
   return .t.
endif
return .t.
****************************************
function v18_4a
if lastkey()=5
return .t.
endif
return .not.empty(zg_rodzaj4).and..not.empty(zg_miejsc4).or.empty(zg_rodzaj4).and.empty(zg_miejsc4)
****************************************
function v18_5
if lastkey()=5
return .t.
endif
return .not.empty(zn_przedm1).and..not.empty(zn_miejsc1).or.empty(zn_przedm1).and.empty(zn_miejsc1)
****************************************
function v18_6
if lastkey()=5
return .t.
endif
return .not.empty(zn_przedm2).and..not.empty(zn_miejsc2).or.empty(zn_przedm2).and.empty(zn_miejsc2)
*############################################################################
