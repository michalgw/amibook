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

* max 999 firm

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou
@ 1,47 say [          ]
public symbol_fir,ident_fir
*,DETALISTA,VAT,RYCZALT
*################################# GRAFIKA ##################################
@  3,42 say [ÉÍÍÍÍÍÍÍÍÍÍPe&_l.na nazwa firmyÍÍÍÍÍÍÍÍÍ»]
@  4,42 say [º   ..............................   º]
@  5,42 say [º   ..............................   º]
@  6,42 say [ÌÍÍSYMBOLÍÍËÍÍÍÍÍÍÍÍMiejscowo&_s.&_c.ÍÍÍÍÍÍ¼]
@  7,42 say [º          º  ³ .................... ³]
@  8,42 say [º          º  ÃÄÄÄDzielnica/GminaÄÄÄÄ´]
@  9,42 say [º          º  ³ .................... ³]
@ 10,42 say [º          º  ÃÄÄÄÄÄÄÄÄUlicaÄÄÄÄÄÄÄÄÄ´]
@ 11,42 say [º          º  ³ .................... ³]
@ 12,42 say [º          º  ÃÄÄNr domuÄÄÄNr mieszkÄ´]
@ 13,42 say [º          º  ³   .....       .....  ³]
@ 14,42 say [º          º  ÃKod pocztÄÄÄÄPocztaÄÄÄ´]
@ 15,42 say [º          º  ³...... ...............³]
@ 16,42 say [º          º  ÃÄÄÄÄTelÄÄÄÄÄÄÄÄFaxÄÄÄÄ´]
@ 17,42 say [º          º  ³..........  ..........³]
@ 18,42 say [º          º  ÃÄÄÄKrajÄÄÄÄÄÄÄSp&_o.&_l.kaÄÄ´]
@ 19,42 say [º          º  ³..........     ...    ³]
@ 20,42 say [º          º  ÃÄÄÄData rozpocz&_e.ciaÄÄÄ´]
@ 21,42 say [ÈÍÍÍÍÍÍÍÍÍÍ¼  ³     dzia&_l.alno&_s.ci     ³]
@ 22,42 say [              ³      ..........      ³]
@ 23,42 say [              ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ]
*############################### OTWARCIE BAZ ###############################
select 2
if dostep('SUMA_MC')
   set inde to suma_mc
else
   sele 1
   close_()
   return
endif
select 1
if dostep('FIRMA')
   set inde to firma
else
   sele 1
   close_()
   return
endif
*################################# OPERACJE #################################
*----- parametry ------
_row_g=7
_col_l=43
_row_d=20
_col_p=52
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,77,109,28,13]
_top=[.f.]
_bot=[del#'+']
_stop=[]
_sbot=[-]
_proc=[linia25()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[firma__]
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
*############################ INSERT/MODYFIKACJA ############################
              case _row=-1.or.kl=77.or.kl=109
@ 1,47 say [          ]
ins=kl#77.and.kl#109
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
   zsymbol=space(10)
   znazwa=space(60)
   zmiejsc=space(20)
   zgmina=space(20)
   zulica=space(20)
   znr_domu=space(5)
   znr_mieszk=space(5)
   zkod_p=space(6)
   zpoczta=space(20)
   ztel=space(10)
   zfax=space(10)
   ztlx=space(10)
   zdata_zal=ctod('    .  .  ')
   zspolka='N'
else
   zsymbol=symbol
   znazwa=nazwa
   zmiejsc=miejsc
   zgmina=gmina
   zulica=ulica
   znr_domu=nr_domu
   znr_mieszk=nr_mieszk
   zkod_p=kod_p
   zpoczta=poczta
   ztel=tel
   zfax=fax
   ztlx=tlx+space(10-len(alltrim(tlx)))
   zdata_zal=data_zal
   zspolka=iif(spolka,'T','N')
endif
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@  4,43 clear to 5,78
ColStd()
@ wiersz,43 get zsymbol picture repl("!",10) valid v10_1()
@  4,43 get znazwa picture '@S36 '+repl("!",60)
@  7,58 get zmiejsc picture repl("!",20)
@  9,58 get zgmina picture  repl("!",20)
@ 11,58 get zulica picture  repl("!",20)
@ 13,60 get znr_domu picture [!!!!!]
@ 13,72 get znr_mieszk picture [!!!!!]
@ 15,57 get zkod_p picture [99-999]
@ 15,64 get zpoczta picture '@S15 '+repl("!",20)
@ 17,57 get ztel picture [!!!!!!!!!!]
@ 17,69 get zfax picture [!!!!!!!!!!]
@ 19,57 get ztlx picture [!!!!!!!!!!]
@ 19,72 get zspolka picture [!] when w3_1323() valid v3_1323()
@ 22,63 get zdata_zal picture [@D 9999.99.99]
read_()
if lastkey()=27
exit
endif
zsymbol=dos_l(zsymbol)
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
   if ins
   app()
   zero_(3)
   repl_([nr_fakt],1)
   repl_([nr_faktw],1)
   repl_([nr_rach],1)
   repl_([liczba],1)
   repl_([liczba_wyp],1)
   repl_( "RODZNRKS", "R" )
   endif
   do BLOKADAR
   repl_([symbol],zsymbol)
   repl_([NAZWA    ],zNAZWA)
   repl_([MIEJSC   ],zMIEJSC   )
   repl_([GMINA    ],zGMINA    )
   repl_([ULICA    ],zULICA    )
   repl_([NR_DOMU  ],zNR_DOMU  )
   repl_([NR_MIESZK],zNR_MIESZK)
   repl_([KOD_P    ],zKOD_P    )
   repl_([POCZTA   ],zPOCZTA   )
   repl_([TEL      ],zTEL      )
   repl_([FAX      ],zFAX      )
   repl_([TLX      ],zTLX      )
   repl_([DATA_ZAL ],zDATA_ZAL )
   repl_([SPOLKA   ],iif(zspolka='T',.t.,.f.))
   COMMIT
   unlock
   ident=str(recno(),3)
   select suma_mc
   if ins
   for i=1 to 12
   app()
   repl_([firma],ident)
   repl_([mc],str(i,2))
   zero_(5)
   COMMIT
   unlock
   next
   endif
select firma
commit_()
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
_row=int((_row_g+_row_d)/2)
if .not.ins
exit
endif
@ _row_d,_col_l say &_proc
scroll(_row_g,_col_l,_row_d,_col_p,1)
@ _row_d,_col_l say [        ]
                             enddo
_disp=ins.or.lastkey()#27
kl=iif(lastkey()=27.and._row=-1,27,kl)
@ 23,0 say space(56)
*################################# SZUKANIE #################################
                   case kl=-9.or.kl=247
@ 1,47 say [          ]
ColStb()
center(23,[þ                 þ])
ColSta()
  center(23,[S Z U K A N I E])
f10=space(10)
ColStd()
@ _row,43 get f10 picture "!!!!!!!!!!"
read_()
_disp=.not.empty(f10).and.lastkey()#27
if _disp
   seek [+]+dos_l(f10)
   if &_bot
      skip -1
   endif
_row=int((_row_g+_row_d)/2)
endif
@ 23,0 say space(56)
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
p[ 5]='   [M].....................modyfikacja pozycji          '
p[ 6]='   [F10]...................szukanie                     '
p[ 7]='   [Enter].................akceptacja firmy             '
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
*################################### WYBOR ##################################
case kl=13
   zhaslo=space(10)
   if .not.empty(haslo)
      Cocul=ColErr()
      @ 24,0 clear
      @ 24,28 say 'Podaj haslo:'
      set curs on
      set colo to X/X,X/X
      @ 24,40 get zhaslo
      read
      set curs off
      set colo to cocul
      @ 24,0 clear
   endif
   if haslo==zhaslo
      symbol_fir=symbol
      ident_fir=str(recno(),3)
      Firma_RodzNrKs := firma->rodznrks
      restore screen from scr
      ColSta()
      @ 0,41 say 'Alt+K=kalkul. Alt+N=notes'
      @ 0,67 say [Symbol firmy]
      set color to +w
      @ 1,66 say [  ]+dos_c(symbol_fir)+[  ]
*      ZVAT=VAT
*      ZVATOKRES=iif(VATOKRES='K','K','M')
      zVAT=iif(VAT=' ','N',VAT)
      zVATOKRES=iif(VATOKRES=' ','M',VATOKRES)
      zVATOKRESDR=iif(VATOKRESDR=' ',VATOKRES,VATOKRESDR)
      if VATFORDR=='  '
         if zVATOKRES='M'
*            if zVATOKRESDR='M'
               zVATFORDR='7 '
*            else
*               zVATFORDR='7D'
*            endif
         else
            zVATFORDR='7K'
         endif
      else
         zVATFORDR=VATFORDR
      endif
      zUEOKRES=iif(UEOKRES='K','K','M')
      DETALISTA=DETAL
      ZRYCZALT=RYCZALT
      pzROZRZAPK=ROZRZAPK
      pzROZRZAPS=ROZRZAPS
      pzROZRZAPZ=ROZRZAPZ
      pzROZRZAPF=ROZRZAPF
*      m->parap_puw=parap_puw
      m->parap_fuw=parap_fuw
      m->parap_fww=parap_fww
      set color to
      @ 0,0 clear to 0,40
      @ 0,3 say iif(zVAT='T','VAT-'+zVATFORDR,'')+iif(zRYCZALT='T','Rycza&_l.t ','')+iif(DETALISTA='T','Detal ','')
      save screen to scr
      exit
   endif
   ******************** ENDCASE
endcase
enddo
close_()
*################################## FUNKCJE #################################
function linia25
return symbol
***************************************************
procedure firma__
@  4,43 clear to 5,78
set color to +w
@  4,46 say iif(empty(left(nazwa,30)),repl([.],30),dos_c(left(nazwa,30)))
@  5,46 say iif(empty(right(nazwa,30)),repl([.],30),dos_c(right(nazwa,30)))
@  7,58 say iif(empty(miejsc),repl([.],20),dos_c(miejsc))
@  9,58 say iif(empty(gmina),repl([.],20),dos_c(gmina))
@ 11,58 say iif(empty(ulica),repl([.],20),dos_c(ulica))
@ 13,60 say iif(empty(nr_domu),repl([.],5),dos_c(nr_domu))
@ 13,72 say iif(empty(nr_mieszk),repl([.],5),dos_c(nr_mieszk))
@ 15,57 say iif(empty(kod_p).or.kod_p=[  -   ],repl([.],6),kod_p)
@ 15,64 say iif(empty(poczta),repl([.],15),padc(alltrim(poczta),15))
@ 17,57 say iif(empty(tel),repl([.],10),dos_c(tel))
@ 17,69 say iif(empty(fax),repl([.],10),dos_c(fax))
@ 19,57 say iif(empty(tlx),repl([.],10),tlx)
@ 19,72 say iif(spolka,'Tak','Nie')
@ 22,63 say iif(empty(data_zal),repl([.],10),dos_c(dtoc(data_zal)))
zVAT=iif(VAT=' ','N',VAT)
zVATOKRES=iif(VATOKRES=' ','M',VATOKRES)
zVATOKRESDR=iif(VATOKRESDR=' ',VATOKRES,VATOKRESDR)
if VATFORDR=='  '
   if VATOKRES='M'
*      if VATOKRESDR='M'
         zVATFORDR='7 '
*      else
*         zVATFORDR='7D'
*      endif
   else
      zVATFORDR='7K'
   endif
else
   zVATFORDR=VATFORDR
endif
podatki=space(13)
podatki=iif(VAT='T','VAT'+zVATFORDR,'')+iif(RYCZALT='T','Rycz','')+iif(DETAL='T','Det','')
@ 22,42 say iif(empty(podatki),repl([ ],13),padc(podatki,13,' '))
do notes with .f.
set color to
***************************************************
function v25_1
if empty(zsymbol)
return .f.
endif
nr_rec=recno()
seek [+]+dos_l(zsymbol)
fou=found()
rec=recno()
go nr_rec
   if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Taki symbol ju&_z. istnieje')
   set cursor on
   return .f.
   endif
return .t.
***************************************************
function w3_1323
ColInf()
@ 24,0 say padc('Wpisz: T - je&_z.eli firma jest sp&_o.&_l.ka lub N - je&_z.eli osob&_a. fizyczn&_a.',80,' ')
ColStd()
@ 19,73 say iif(zSPOLKA='T','ak','ie')
return .t.
***************************************************
function v3_1323
R=.f.
if zSPOLKA$'TN'
   ColStd()
   @ 19,73 say iif(zSPOLKA='T','ak','ie')
   @ 24,0
   R=.t.
endif
return R
*############################################################################
