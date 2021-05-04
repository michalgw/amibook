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

FUNCTION Spolka()

   private oGetKW

private _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '                 I N F O R M A C J E   O   W &__L. A &__S. C I C I E L U                '
@  4, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@  5, 0 say '³ Nazwisko i imiona.                                        Dokument.          ³'
@  6, 0 say '³ Nr PESEL..             NIP..              P&_l.e&_c...           nr dok.:          ³'
@  7, 0 say '³ Nazwisko rodowe...                Obyw-stwo.            UDZIA&__L. OD MIESI&__A.CA:  ³'
@  8, 0 say '³ Miejsce i data ur.                                      1 Stycze&_n.            ³'
@  9, 0 say '³ Imie ojca.........                matki.                2 Luty               ³'
@ 10, 0 say '³ Miejsce zamieszkania: Wojewodz...                       3 Marzec             ³'
@ 11, 0 say '³ Powiat............                     Kraj.            4 Kwiecie&_n.           ³'
@ 12, 0 say '³ Gmina.............                                      5 Maj                ³'
@ 13, 0 say '³ Miejscowosc.......                                      6 Czerwiec           ³'
@ 14, 0 say '³ Ulica, dom, lokal.                           /          7 Lipiec             ³'
@ 15, 0 say '³ Kod i poczta......                                      8 Sierpie&_n.           ³'
@ 16, 0 say '³ Telefon dom.......           Oblicz kw.wol(Tab/St)      9 Wrzesie&_n.           ³'
@ 17, 0 say '³ Rozliczac: Progresyw/Liniowo.  Podat.od kw.wol.        10 Pa&_x.dziernik        ³'
@ 18, 0 say '³ Jakie wyd.mieszk?.                                     11 Listopad           ³'
@ 19, 0 say '³ Jakie odl.od doch?                                     12 Grudzie&_n.           ³'
@ 20, 0 say '³ Jakie odl.od poda?                                     Kod tytulu ubezp.(ZUS)³'
@ 21, 0 say '³ Urz&_a.d Skarbowy....                                                           ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 3
do while.not.dostep('URZEDY')
enddo
do setind with 'URZEDY'
select 2
do while.not.dostep('DANE_MC')
enddo
set inde to dane_mc
select 1
do while.not.dostep('SPOLKA')
enddo
do setind with 'SPOLKA'
seek [+]+ident_fir
*################################# OPERACJE #################################
*----- parametry ------
_top=[firma#ident_fir]
_bot=[del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[say3]
*----------------------
_top_bot=_top+[.or.]+_bot
   if .not.&_top_bot
   do &_proc
   endif
kl=0
do while .t.
ColSta()
@ 1,47 say '[F1]-pomoc'
ColStd()
kl=inkey(0)
do ster
do case
*################################# WYJSCIE ##################################
              case kl=27
nr_rec=recno()
   seek [+]+ident_fir
   if .not.found()
   close_()
   return
   endif
      store 0 to suma1,suma2,suma3,suma4,suma5,suma6,suma7,suma8,suma9,suma10,suma11,suma12
      do while del=[+].and.firma=ident_fir
      **********************
      zm=[  0/1  ]
      for i=1 to 12
         zm1=[udzial]+ltrim(str(i))
         if [   /   ]#&zm1
         zm=&zm1
         endif
         zm2=[suma]+ltrim(str(i))
         &zm2=&zm2+100*val(left(zm,3))/val(right(zm,3))
      next
      **********************
      skip
      enddo
go nr_rec
begin sequence
   pk=.t.
   for i=1 to 12
       zm=[suma]+ltrim(str(i))
       if .not.pk.or.0#&zm
          pk=.f.
          if _round(&zm   ,0)#100
             kom(4,[*u],[ Suma udzial&_o.w w ka&_z.dym z miesi&_e.cy powinna wyno&_s.ic 1 ])
             _disp=.f.
             break
          endif
       endif
   next
   if pk
      kom(4,[*u],[ Brak udzia&_l.u ])
      _disp=.f.
      break
   endif
   close_()
   _disp=.t.
   break
end
if _disp=.t.
   return
endif
*########################### INSERT/MODYFIKACJA #############################
              case kl=22.or.kl=48.or.kl=109.or.kl=77.or.&_top_bot
@ 1,47 say [          ]
ins=(kl#109.and.kl#77).OR.&_top_bot
ktoroper()
                             begin sequence
*ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
if ins
   zNAZ_IMIE=space(30)
   zPESEL=space(11)
   zNIP=[             ]
   zPLEC=' '
   zRODZ_DOK='D'
   zDOWOD_OSOB=space(9)
   zNAZW_RODU=space(30)
   zOBYWATEL=padr('POLSKIE',22)
   zMIEJSC_UR=space(20)
   zDATA_UR=ctod([    .  .  ])
   zIMIE_O=space(15)
   zIMIE_M=space(15)
   zMIEJSC_ZAM=space(20)
   zGMINA=space(20)
   zULICA=space(20)
   zNR_DOMU=space(10)
   zNR_MIESZK=space(10)
   zKOD_POCZT=[  -   ]
   zPOCZTA=space(20)
   zTELEFON=space(10)
   zSKARB=0
   zURZAD=space(45)
   zSPOSOB='P'
   zKOD_TYTU='051000'
   zKRAJ='POLSKA'
   zPARAM_WOJ=m->param_woj
   zPARAM_POW=m->param_pow
   zPARAM_KW=m->param_kw
   zPARAM_KWD=m->param_kwd
   zPARAM_KW2=m->param_kw2
   zPARAM_KW3=iif( Date() < m->param_kwd, m->param_kw, m->param_kw2 )
   store space(30) to zODLICZ1,zODLICZ2,zS_RODZAJ
   store [   /   ] to zudzial1,zudzial2,zudzial3,zudzial4,zudzial5,zudzial6,zudzial7,zudzial8,zudzial9,zudzial10,zudzial11,zudzial12
   zOBLKWWOL := 'S'
else
   zNAZ_IMIE=NAZ_IMIE
   zPESEL=PESEL
   zNIP=NIP
   zPLEC=PLEC
   zRODZ_DOK=RODZ_DOK
   zDOWOD_OSOB=DOWOD_OSOB
   zNAZW_RODU=NAZW_RODU
   zOBYWATEL=OBYWATEL
   zMIEJSC_UR=MIEJSC_UR
   zDATA_UR=DATA_UR
   zIMIE_O=IMIE_O
   zIMIE_M=IMIE_M
   zMIEJSC_ZAM=MIEJSC_ZAM
   zGMINA=GMINA
   zULICA=ULICA
   zNR_DOMU=NR_DOMU
   zNR_MIESZK=NR_MIESZK
   zKOD_POCZT=KOD_POCZT
   zPOCZTA=POCZTA
   zTELEFON=TELEFON
   zODLICZ1=ODLICZ1
   zODLICZ2=ODLICZ2
   zS_RODZAJ=S_RODZAJ
   zKOD_TYTU=KOD_TYTU
   zKRAJ=KRAJ
   zPARAM_WOJ=param_woj
   zPARAM_POW=param_pow
   zSPOSOB=SPOSOB
   zPARAM_KW=param_kw
   zPARAM_KWD=param_kwd
   zPARAM_KW2=param_kw2
   zPARAM_KW3=iif( Date() < param_kwd, param_kw, param_kw2 )
   zSKARB=SKARB
   sele urzedy
   go zSKARB
   zURZAD=miejsc_us+' - '+urzad
   sele spolka
   zUDZIAL1=UDZIAL1
   zUDZIAL2=UDZIAL2
   zUDZIAL3=UDZIAL3
   zUDZIAL4=UDZIAL4
   zUDZIAL5=UDZIAL5
   zUDZIAL6=UDZIAL6
   zUDZIAL7=UDZIAL7
   zUDZIAL8=UDZIAL8
   zUDZIAL9=UDZIAL9
   zUDZIAL10=UDZIAL10
   zUDZIAL11=UDZIAL11
   zUDZIAL12=UDZIAL12
   zOBLKWWOL := iif( spolka->oblkwwol == ' ', 'S', spolka->oblkwwol )
endif
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
@ 5,20 get zNAZ_IMIE picture "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" valid v3_1()
@ 5,69 get zRODZ_DOK picture "!" when w3_1331() valid v3_1331()
@ 6,12 get zPESEL picture "!!!!!!!!!!!"
@ 6,30 get zNIP picture "!!!!!!!!!!!!!"
@ 6,50 get zPLEC   picture "!" when w3_1322() valid v3_1322()
@ 6,69 get zDOWOD_OSOB picture "!!!999999"
@ 7,20 get zNAZW_RODU picture '@S15 '+repl('!',30) when rod1()
@ 7,46 get zOBYWATEL pict '@S11 '+repl('!',22)
@ 8,20 get zMIEJSC_UR picture "!!!!!!!!!!!!!!!!!!!!"
@ 8,44 get zDATA_UR
@  9,20 get zIMIE_O picture repl('!',15)
@  9,42 get zIMIE_M picture repl('!',15)
@ 10,35 get zPARAM_WOJ picture repl('!',20)
@ 11,20 get zPARAM_POW picture repl('!',20)
@ 11,46 get zKRAJ pict repl('!',10)
@ 12,20 get zGMINA picture repl('!',20)
@ 13,20 get zMIEJSC_ZAM picture repl('!',20)
@ 14,20 get zULICA picture "!!!!!!!!!!!!!!!!!!!!"
@ 14,41 get zNR_DOMU picture "@S5 !!!!!!!!!!"
@ 14,49 get zNR_MIESZK picture "@S5 !!!!!!!!!!"
@ 15,20 get zKOD_POCZT picture "99-999"
@ 15,27 get zPOCZTA picture "!!!!!!!!!!!!!!!!!!!!"
@ 16,20 get zTELEFON picture "XXXXXXXXXX"
@ 16,52 get zOBLKWWOL PICTURE "!" WHEN spolka_w_oblkwwol() VALID spolka_v_oblkwwol()
@ 17,31 get zSPOSOB picture "!" valid zSPOSOB$'PL'
@ 17,49 get zPARAM_KW3 picture "9999.99" WHEN SpolkaWhenParamKW() //range 0,9999
oGetKW := ATail( GetList )
@ 18,20 get zODLICZ2 picture repl('!',30)
@ 19,20 get zODLICZ1 picture repl('!',30)
@ 20,20 get zS_RODZAJ picture repl('!',30)
@ 21,20 get zURZAD picture "!!!!!!!!!!!!!!!!!!!! - !!!!!!!!!!!!!!!!!!!!!!!!!" valid v3_14()
@  8,72 get zUDZIAL1  picture "999/999" valid v3_2()
@  9,72 get zUDZIAL2  picture "999/999" valid v3_3()
@ 10,72 get zUDZIAL3  picture "999/999" valid v3_4()
@ 11,72 get zUDZIAL4  picture "999/999" valid v3_5()
@ 12,72 get zUDZIAL5  picture "999/999" valid v3_6()
@ 13,72 get zUDZIAL6  picture "999/999" valid v3_7()
@ 14,72 get zUDZIAL7  picture "999/999" valid v3_8()
@ 15,72 get zUDZIAL8  picture "999/999" valid v3_9()
@ 16,72 get zUDZIAL9  picture "999/999" valid v3_10()
@ 17,72 get zUDZIAL10 picture "999/999" valid v3_11()
@ 18,72 get zUDZIAL11 picture "999/999" valid v3_12()
@ 19,72 get zUDZIAL12 picture "999/999" valid v3_13()
@ 21,73 get zKOD_TYTU picture "999999" valid len(alltrim(zKOD_TYTU))=6
clear type
read_()
if lastkey()=27
   break
endif
zudzial1 =iif(zudzial1 =[   /   ],zudzial1,str(val(left(zudzial1,3)),3)+[/]  +dos_l(str(val(right(zudzial1,3)),3)))
zudzial2 =iif(zudzial2 =[   /   ],zudzial2,str(val(left(zudzial2,3)),3)+[/]  +dos_l(str(val(right(zudzial2,3)),3)))
zudzial3 =iif(zudzial3 =[   /   ],zudzial3,str(val(left(zudzial3,3)),3)+[/]  +dos_l(str(val(right(zudzial3,3)),3)))
zudzial4 =iif(zudzial4 =[   /   ],zudzial4,str(val(left(zudzial4,3)),3)+[/]  +dos_l(str(val(right(zudzial4,3)),3)))
zudzial5 =iif(zudzial5 =[   /   ],zudzial5,str(val(left(zudzial5,3)),3)+[/]  +dos_l(str(val(right(zudzial5,3)),3)))
zudzial6 =iif(zudzial6 =[   /   ],zudzial6,str(val(left(zudzial6,3)),3)+[/]  +dos_l(str(val(right(zudzial6,3)),3)))
zudzial7 =iif(zudzial7 =[   /   ],zudzial7,str(val(left(zudzial7,3)),3)+[/]  +dos_l(str(val(right(zudzial7,3)),3)))
zudzial8 =iif(zudzial8 =[   /   ],zudzial8,str(val(left(zudzial8,3)),3)+[/]  +dos_l(str(val(right(zudzial8,3)),3)))
zudzial9 =iif(zudzial9 =[   /   ],zudzial9,str(val(left(zudzial9,3)),3)+[/]  +dos_l(str(val(right(zudzial9,3)),3)))
zudzial10=iif(zudzial10=[   /   ],zudzial10,str(val(left(zudzial10,3)),3)+[/]+dos_l(str(val(right(zudzial10,3)),3)))
zudzial11=iif(zudzial11=[   /   ],zudzial11,str(val(left(zudzial11,3)),3)+[/]+dos_l(str(val(right(zudzial11,3)),3)))
zudzial12=iif(zudzial12=[   /   ],zudzial12,str(val(left(zudzial12,3)),3)+[/]+dos_l(str(val(right(zudzial12,3)),3)))
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
if ins
   app()
   repl_([firma],ident_fir)
   zident=str(recno(),5)
   select dane_mc
   for i=1 to 12
       CURR=ColInf()
       @ 24,0
       center(24,'Dopisuje miesi&_a.c '+str(i,2))
       setcolor(CURR)
       app()
       repl ident with zident,;
            mc with str(i,2),;
            g_udzial1 with [ 1/1  ],;
            g_udzial2 with [ 1/1  ],;
            n_udzial1 with [ 1/1  ],;
            n_udzial2 with [ 1/1  ]
       COMMIT
       unlock
   next
   @ 24,0
endif
select spolka
do BLOKADAR
repl NAZ_IMIE with zNAZ_IMIE,;
     PESEL with zPESEL,;
     NIP with zNIP,;
     RODZ_DOK with zRODZ_DOK,;
     DOWOD_OSOB with zDOWOD_OSOB,;
     PLEC with zPLEC,;
     NAZW_RODU with zNAZW_RODU,;
     OBYWATEL with zOBYWATEL,;
     MIEJSC_UR with zMIEJSC_UR,;
     DATA_UR with zDATA_UR,;
     IMIE_O with zIMIE_O,;
     IMIE_M with zIMIE_M,;
     MIEJSC_ZAM with zMIEJSC_ZAM,;
     GMINA with zGMINA,;
     ULICA with zULICA,;
     NR_DOMU with zNR_DOMU,;
     NR_MIESZK with zNR_MIESZK,;
     KOD_POCZT with zKOD_POCZT,;
     POCZTA with zPOCZTA,;
     TELEFON with zTELEFON,;
     PARAM_WOJ with zPARAM_WOJ,;
     PARAM_POW with zPARAM_POW,;
     SPOSOB with zSPOSOB,;
     PARAM_KW with zPARAM_KW,;
     PARAM_KWD with zPARAM_KWD,;
     PARAM_KW2 with zPARAM_KW2,;
     ODLICZ1 with zODLICZ1,;
     ODLICZ2 with zODLICZ2,;
     S_RODZAJ with zS_RODZAJ,;
     KOD_TYTU with zKOD_TYTU,;
     KRAJ with zKRAJ,;
     SKARB with zSKARB,;
     UDZIAL1 with zUDZIAL1,;
     UDZIAL2 with zUDZIAL2,;
     UDZIAL3 with zUDZIAL3,;
     UDZIAL4 with zUDZIAL4,;
     UDZIAL5 with zUDZIAL5,;
     UDZIAL6 with zUDZIAL6,;
     UDZIAL7 with zUDZIAL7,;
     UDZIAL8 with zUDZIAL8,;
     UDZIAL9 with zUDZIAL9,;
     UDZIAL10 with zUDZIAL10,;
     UDZIAL11 with zUDZIAL11,;
     UDZIAL12 with zUDZIAL12,;
     OBLKWWOL WITH zOBLKWWOL
commit_()
unlock
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
if &_top_bot
exit
else
do &_proc
endif
@ 23,0
*################################ KASOWANIE #################################
              case kl=7.or.kl=46
@ 1,47 say [          ]
ColStb()
center(23,[þ                   þ])
ColSta()
  center(23,[K A S O W A N I E])
ColStd()
                   begin sequence
                   if .not.tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
                   break
                   endif
     zident=str(recno(),5)
     select dane_mc
     seek [+]+zident
     do while del=[+].and.ident=zident
        do BLOKADAR
        del()
        COMMIT
        unlock
        skip
     enddo
     select spolka
     do BLOKADAR
     repl del with '-'
COMMIT
unlock
skip
commit_()
if &_bot
skip -1
endif
   if .not.&_bot
   do &_proc
   endif
                   end
@ 23,0
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                                        '
p[ 2]='   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
p[ 3]='   [Home/End]..............pierwsza/ostatnia strona     '
p[ 4]='   [Ins]...................wpisywanie                   '
p[ 5]='   [M].....................modyfikacja                  '
p[ 6]='   [Del]...................kasowanie strony             '
p[ 7]='   [Esc]...................wyj&_s.cie                      '
p[ 8]='   Udzial=0/1..............odej&_s.cie wsp&_o.lnika           '
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
******************** ENDCASE
endcase
enddo
close_()
*################################## FUNKCJE #################################
procedure say3
clear type
set color to +w
@ 5,20 say NAZ_IMIE
@ 5,69 say RODZ_DOK+iif(RODZ_DOK='D','ow&_o.d   ','aszport')
@ 6,12 say PESEL
@ 6,30 say NIP
@ 6,50 say iif(PLEC='M','M&_e.&_z.czyzna','Kobieta  ')
@ 6,69 say DOWOD_OSOB
@ 7,20 say substr(NAZW_RODU,1,15)
@ 7,46 say substr(OBYWATEL,1,11)
@ 8,20 say MIEJSC_UR
@ 8,44 say dtoc(DATA_UR)
@  9,20 say IMIE_O
@  9,42 say IMIE_M
@ 10,35 say PARAM_WOJ
@ 11,20 say PARAM_POW
@ 11,46 say KRAJ
@ 12,20 say GMINA
@ 13,20 say MIEJSC_ZAM
@ 14,20 say ULICA
@ 14,41 say substr(NR_DOMU,1,5)
@ 14,49 say substr(NR_MIESZK,1,5)
@ 15,20 say KOD_POCZT
@ 15,27 say POCZTA
@ 16,20 say TELEFON
@ 16, 52 SAY spolka->oblkwwol
@ 17,31 say SPOSOB
@ 17,49 say iif( Date() < param_kwd, PARAM_KW, PARAM_KW2 ) picture "9999.99"
@ 18,20 say ODLICZ2
@ 19,20 say ODLICZ1
@ 20,20 say S_RODZAJ
sele urzedy
go spolka->skarb
zurzad=miejsc_us+' - '+urzad
@ 21,20 say zurzad
sele spolka
@  8,72 say UDZIAL1
@  9,72 say UDZIAL2
@ 10,72 say UDZIAL3
@ 11,72 say UDZIAL4
@ 12,72 say UDZIAL5
@ 13,72 say UDZIAL6
@ 14,72 say UDZIAL7
@ 15,72 say UDZIAL8
@ 16,72 say UDZIAL9
@ 17,72 say UDZIAL10
@ 18,72 say UDZIAL11
@ 19,72 say UDZIAL12
@ 21,73 say KOD_TYTU
set color to
***************************************************
function v3_1
if empty(zNAZ_IMIE)
return .f.
endif
nr_rec=recno()
seek [+]+ident_fir+zNAZ_IMIE
fou=found()
rec=recno()
go nr_rec
   if fou.and.(ins.or.rec#nr_rec)
   set cursor off
   kom(3,[*u],'Taka osoba ju&_z. istnieje')
   set cursor on
   return .f.
   endif
return .t.
***************************************************
function v3_2
if lastkey()=5
return .t.
endif
if zudzial1=[   /   ]
return .t.
endif
zm1=val(left(zudzial1,3))
zm2=val(right(zudzial1,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial1,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_3
if lastkey()=5
return .t.
endif
if zudzial2=[   /   ]
return .t.
endif
zm1=val(left(zudzial2,3))
zm2=val(right(zudzial2,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial2,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_4
if lastkey()=5
return .t.
endif
if zudzial3=[   /   ]
return .t.
endif
zm1=val(left(zudzial3,3))
zm2=val(right(zudzial3,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial3,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_5
if lastkey()=5
return .t.
endif
if zudzial4=[   /   ]
return .t.
endif
zm1=val(left(zudzial4,3))
zm2=val(right(zudzial4,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial4,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_6
if lastkey()=5
return .t.
endif
if zudzial5=[   /   ]
return .t.
endif
zm1=val(left(zudzial5,3))
zm2=val(right(zudzial5,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial5,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_7
if lastkey()=5
return .t.
endif
if zudzial6=[   /   ]
return .t.
endif
zm1=val(left(zudzial6,3))
zm2=val(right(zudzial6,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial6,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_8
if lastkey()=5
return .t.
endif
if zudzial7=[   /   ]
return .t.
endif
zm1=val(left(zudzial7,3))
zm2=val(right(zudzial7,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial7,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_9
if lastkey()=5
return .t.
endif
if zudzial8=[   /   ]
return .t.
endif
zm1=val(left(zudzial8,3))
zm2=val(right(zudzial8,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial8,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_10
if lastkey()=5
return .t.
endif
if zudzial9=[   /   ]
return .t.
endif
zm1=val(left(zudzial9,3))
zm2=val(right(zudzial9,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial9,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_11
if lastkey()=5
return .t.
endif
if zudzial10=[   /   ]
return .t.
endif
zm1=val(left(zudzial10,3))
zm2=val(right(zudzial10,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial10,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_12
if lastkey()=5
return .t.
endif
if zudzial11=[   /   ]
return .t.
endif
zm1=val(left(zudzial11,3))
zm2=val(right(zudzial11,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial11,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_13
if lastkey()=5
return .t.
endif
if zudzial12=[   /   ]
return .t.
endif
zm1=val(left(zudzial12,3))
zm2=val(right(zudzial12,3))
if (zm1=0.and.zm2#1).or.zm2=0.or.[ ]$alltrim(right(zudzial12,3)).or.(zm1=zm2.and.zm1#1)
return .f.
endif
   if zm1>zm2
   kom(3,[*u],[ Udzia&_l. nie powinien by&_c. wi&_e.kszy ni&_z. 100% ])
   return .f.
   endif
return .t.
***************************************************
function v3_14
if lastkey()=5
   return .t.
endif
save screen to scr2
select urzedy
seek [+]+substr(zurzad,1,20)+substr(zurzad,24)
if del#[+].or.miejsc_us#substr(zurzad,1,20).or.urzad#substr(zurzad,24)
   skip -1
endif
urzedy_()
restore screen from scr2
if lastkey()=13 .OR. LastKey() == 1006
   zurzad=miejsc_us+' - '+urzad
   set color to i
   @ 21,20 say zurzad
   set color to
   pause(.5)
endif
select spolka
return .not.empty(zurzad)
***************************************************
function w3_1322
ColInf()
@ 24,0 say padc('Wpisz: M - m&_e.&_z.czyzna lub K - kobieta',80,' ')
ColStd()
@ 6,51 say iif(zPLEC='M','ezczyzna','obieta  ')
return .t.
***************************************************
function v3_1322
R=.f.
if zPLEC$'MK'
   ColStd()
   @ 6,51 say iif(zPLEC='M','ezczyzna','obieta  ')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function w3_1331
ColInf()
@ 24,0 say padc('Wpisz: D - dow&_o.d osobisty lub P - paszport',80,' ')
ColStd()
@ 5,70 say iif(zRODZ_DOK='D','owod   ','aszport')
return .t.
***************************************************
function v3_1331
R=.f.
if zRODZ_DOK$'DP'
   ColStd()
   @ 5,70 say iif(zRODZ_DOK='D','owod   ','aszport')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function rod1
if empty(zNAZW_RODU)
   zNAZW_RODU=padr(substr(zNAZ_IMIE,1,at(' ',zNAZ_IMIE)),30)
endif
return .t.

FUNCTION spolka_w_oblkwwol()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: T - tabela pod. doch.    S - Staˆa warto˜†', 80, ' ' )
   ColStd()
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION spolka_v_oblkwwol()

   LOCAL lRes := .F.

   IF zOBLKWWOL$'ST'
      ColStd()
      @ 24, 0
      lRes := .T.
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION SpolkaWhenParamKW()

   LOCAL cScreen
   LOCAL GetList := {}

   SAVE SCREEN TO cScreen

   ColStd()

   @ 15, 42 CLEAR TO 18, 79
   @ 15, 42 TO 18, 79
   @ 16, 45 SAY '1. Kwota przed' GET zparam_kw PICTURE "9999999.99" range 0,9999999
   @ 17, 45 SAY '2. Od' GET zparam_kwd PICTURE "@D"
   @ 17, 62 SAY 'kwota' GET zparam_kw2 PICTURE "9999999.99" range 0,9999999
   READ

   zparam_kw3 := iif( Date() < zparam_kwd, zparam_kw, zparam_kw2 )

   RESTORE SCREEN FROM cScreen

   IF ! Empty( oGetKW )
      oGetKW:display()
   ENDIF

   RETURN .F.

/*----------------------------------------------------------------------*/

*############################################################################
