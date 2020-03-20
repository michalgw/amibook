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

FUNCTION KartST()

private _row_g,_col_l,_row_d,_col_p,_invers,_curs_l,_curs_p,_esc,_top,_bot,_stop,_sbot,_proc,_row,_proc_spe,_disp,_cls,kl,ins,nr_rec,wiersz,f10,rec,fou,_top_bot
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
@  3, 0 say '               K A R T O T E K A   &__S. R O D K &__O. W   T R W A &__L. Y C H              '
@  4, 0 say '  DataPrzy   Nr Ewid            Nazwa &_s.rodka trwa&_l.ego            KST    StawAmor'
@  5, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄ¿'
@  6, 0 say '³          ³          ³                                        ³        ³      ³'
@  7, 0 say '³          ³          ³                                        ³        ³      ³'
@  8, 0 say '³          ³          ³                                        ³        ³      ³'
@  9, 0 say '³          ³          ³                                        ³        ³      ³'
@ 10, 0 say '³          ³          ³                                        ³        ³      ³'
@ 11, 0 say '³          ³          ³                                        ³        ³      ³'
@ 12, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ´'
@ 13, 0 say '³ Opis.............                                            Nr OT.          ³'
@ 14, 0 say '³ Nr dowodu zakupu.            Wart.zak.               Wart.ulg.               ³'
@ 15, 0 say '³ &__X.r&_o.d&_l.o zakupu....                                                            ³'
@ 16, 0 say '³ W&_l.asno&_s.&_c...       Przeznaczenie..           Spos&_o.b..            Wsp.degr..    ³'
@ 17, 0 say 'ÃÄInformacje do korekt VATÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ 18, 0 say '³ VAT z rej.zak.naliczony.             odliczony.             Okres kor.   lat ³'
@ 19, 0 say 'ÃÄInformacje o zbyciu/likwidacjiÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ 20, 0 say '³ Spos&_o.b..                Data zbycia.....            VAT sprzeda&_z.y..          ³'
@ 21, 0 say '³                         Data likwidacji.                     Nr LT.          ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
ColInf()
@ 17,2 say 'Informacje do korekt VAT'
@ 19,2 say 'Informacje o zbyciu/likwidacji'
ColStd()
select 3
if dostep('KARTSTMO')
   do setind with 'KARTSTMO'
else
   close_()
   return
endif
select 2
if dostep('AMORT')
   do setind with 'AMORT'
else
   close_()
   return
endif
select 1
if dostep('KARTST')
   do setind with 'KARTST'
else
   close_()
   return
endif
seek [+]+ident_fir
*################################# OPERACJE #################################
*----- parametry ------
_row_g=6
_col_l=1
_row_d=11
_col_p=78
_invers=[i]
_curs_l=0
_curs_p=0
_esc=[27,-9,247,22,48,77,109,7,46,28,13]
_top=[firma#ident_fir]
_bot=[eof().or.del#'+'.or.firma#ident_fir]
_stop=[+]+ident_fir
_sbot=[+]+ident_fir+[þ]
_proc=[say31st()]
_row=int((_row_g+_row_d)/2)
_proc_spe=[say31sst]
_disp=.t.
_cls=''
_top_bot=_top+[.or.]+_bot
*----------------------
kl=0
*set cent off
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   set colo to
   zSPOSOBLIK=' '
   _row=wybor(_row)
   ColStd()
   kl=lastkey()
   do case
   *########################### INSERT/MODYFIKACJA #############################
   case kl=22.or.kl=48.or._row=-1.or.kl=77.or.kl=109
        @ 1,47 say [          ]
        ins=(kl#109.and.kl#77).OR.&_top_bot
        KTOROPER()
        if ins
           restscreen(_row_g,_col_l,_row_d+1,_col_p,_cls)
           wiersz=_row_d
        else
           wiersz=_row
        endif
        begin sequence
           if len(alltrim(dtos(DATA_LIK)))=0 .and. len(alltrim(dtos(DATA_SPRZ)))=0
              zSPOSOBLIK=' '
           else
              if len(alltrim(dtos(DATA_LIK)))=8 .and. len(alltrim(dtos(DATA_SPRZ)))=0
                 zSPOSOBLIK='L'
              endif
              if len(alltrim(dtos(DATA_LIK)))=8 .and. len(alltrim(dtos(DATA_SPRZ)))=8
                 zSPOSOBLIK='Z'
              endif
           endif
           if .not.ins.and..not.empty(dtos(DATA_LIK))
              do komun with '&__S.rodek zlikwidowany/zbyty. Modyfikacja zabroniona'
              break
           endif
        *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
           if ins
              zNREWID=space(10)
              zNAZWA=space(40)
              zOPIS=space(60)
              zKRST=space(8)
              zDATA_ZAK=date()
              zDOWOD_ZAK=space(10)
              zZRODLO=space(60)
              zWARTOSC=0
              zWART_ULG=0
              zNR_OT=space(10)
              zNR_LT=space(10)
              zDATA_LIK=ctod('    .  .  ')
              zWLASNOSC='W'
              zPRZEZNACZ='P'
              zSPOSOB='L'
              zSTAWKA=0
              zWSPDEG=1
              zVATZAKUP=0
              zVATODLI=0
              zVATkorokr=1
              zDATA_SPRZ=ctod('    .  .  ')
              zVATSPRZ=' '
           else
              zNREWID=NREWID
              zNAZWA=NAZWA
              zOPIS=OPIS
              zKRST=KRST
              zDATA_ZAK=DATA_ZAK
              zDOWOD_ZAK=DOWOD_ZAK
              zZRODLO=ZRODLO
              zWARTOSC=WARTOSC
              zWART_ULG=WART_ULG
              zNR_OT=NR_OT
              zNR_LT=NR_LT
              zDATA_LIK=DATA_LIK
              zWLASNOSC=WLASNOSC
              zPRZEZNACZ=PRZEZNACZ
              zSPOSOB=SPOSOB
              zSTAWKA=STAWKA
              zWSPDEG=WSPDEG
              zVATZAKUP=VATZAKUP
              zVATODLI=VATODLI
              zVATkorokr=VATkorokr
              zDATA_SPRZ=DATA_SPRZ
              zVATSPRZ=VATSPRZ
           endif
           *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
           @ wiersz,1  get zDATA_ZAK when ins
           @ wiersz,12 get zNREWID picture "!!!!!!!!!!"
           @ wiersz,23 get zNAZWA picture repl("!",40) valid v3_111st()
           @ wiersz,64 get zKRST picture "!!!!!!!!"
           @ wiersz,73 get zSTAWKA picture '999.99' when ins valid zSTAWKA>=0.0
           @ 13,19 get zOPIS picture '@S40 '+repl("!",60)
           @ 13,69 get zNR_OT picture "!!!!!!!!!!"
           @ 14,19 get zDOWOD_ZAK picture "!!!!!!!!!!"
           @ 14,40 get zWARTOSC picture "  9999999.99" when ins valid zWARTOSC>0
           @ 14,64 get zWART_ULG picture "  9999999.99" when ins valid zWARTOSC>=zWART_ULG
           @ 15,19 get zZRODLO picture repl('!',60)
           @ 16,12 get zWLASNOSC picture "!" when w3_131st() valid v3_131st()
           @ 16,34 get zPRZEZNACZ picture "!" when w3_141st() valid v3_141st()
           @ 16,53 get zSPOSOB picture "!" when ins.and.w3_151st() valid v3_151st()
           @ 16,75 get zWSPDEG picture "9.99" when ins.and.zSPOSOB='D' valid zWSPDEG>0

           @ 18,26 get zVATZAKUP picture "  9999999.99"
           @ 18,49 get zVATODLI picture "  9999999.99" valid zVATZAKUP>=zVATODLI
           @ 18,72 get zVATkorokr picture "99" when wVATkorokr() valid vVATkorokr()

           @ 20,10 get zSPOSOBLIK picture "!" when .not. ins .and. w3_161st() valid v3_161st()
           @ 20,42 get zDATA_SPRZ when .not.ins .and. zSPOSOBLIK='Z' valid len(alltrim(dtos(zDATA_SPRZ)))=8
           @ 20,69 get zVATSPRZ picture "!" when .not.ins .and. zSPOSOBLIK='Z' .and. wVATSPRZ() valid vVATSPRZ()

           @ 21,42 get zDATA_LIK when .not.ins .and. zSPOSOBLIK='L' valid len(alltrim(dtos(zDATA_LIK)))=8
           @ 21,69 get zNR_LT picture "!!!!!!!!!!" when .not.ins .and. zSPOSOBLIK$'ZL'

           read_()
           if lastkey()=27
              break
           endif
           *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
           if ins
              set orde to 2
              do BLOKADA
              go bott
              IDPR=rec_no+1
              set orde to 1
              app()
              repl_([FIRMA],IDENT_FIR)
              repl_([REC_NO],IDPR)
              kon=.f.

              if zstawka>0.0
              sele amort
              zwart_pocz=zwartosc
              zprzel=1
              zwart_akt=zwart_pocz*zprzel
              zodpis_rok=0
              zodpis_sum=0
              zumorz_akt=zodpis_sum*zprzel
              zliniowo=_round(zwart_akt*(zstawka/100),2)
              zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
              zodpis_mie=iif(zSPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
              odm=month(zdata_zak)
              odr=year(zdata_zak)
              do while .t.
                 CURR=ColInf()
                 @ 24,0
                 center(24,'Dopisuj&_e. rok '+str(odr,4))
                 setcolor(CURR)
                 app()
                 repl firma with ident_fir,;
                      ident with str(idpr,5),;
                      rok with str(odr,4),;
                      wart_pocz with zwart_pocz,;
                      przel with zprzel,;
                      wart_akt with zwart_akt,;
                      umorz_akt with zumorz_akt,;
                      stawka with zstawka,;
                      wspdeg with zwspdeg,;
                      liniowo with zliniowo,;
                      degres with zdegres
                 for i=odm to 12
                     zmcn=strtran(str(i,2),' ','0')
                     if month(zdata_zak)=i.and.year(zdata_zak)=odr
                        if zwart_ulg=zwart_akt
                           repl mc&zmcn with zwart_ulg
                           zodpis_rok=zodpis_rok+zwart_ulg
                           zodpis_sum=zodpis_sum+zwart_ulg
                           kon=.t.
                           exit
                        else
                           repl mc&zmcn with zwart_ulg
                           zodpis_rok=zodpis_rok+zwart_ulg
                           zodpis_sum=zodpis_sum+zwart_ulg
                        endif
                     else
                        if zodpis_mie>zwart_akt-zodpis_sum
                           repl mc&zmcn with zwart_akt-zodpis_sum
                           zodpis_rok=zodpis_rok+(zwart_akt-zodpis_sum)
                           zodpis_sum=zodpis_sum+(zwart_akt-zodpis_sum)
                           kon=.t.
                           exit
                        else
                           repl mc&zmcn with zodpis_mie
                           zodpis_rok=zodpis_rok+zodpis_mie
                           zodpis_sum=zodpis_sum+zodpis_mie
                        endif
                     endif
                 next
                 repl odpis_rok with zodpis_rok,;
                      odpis_sum with zodpis_sum
                 unlock
                 if kon
                    exit
                 else
                    odm=1
                    odr++
                    zwart_pocz=zwart_akt
                    zprzel=1
                    zwart_akt=zwart_pocz*zprzel
                    zodpis_rok=0
                    zumorz_akt=zodpis_sum*zprzel
                    zliniowo=_round(zwart_akt*(zstawka/100),2)
                    zdegres=_round((zwart_akt-zumorz_akt)*((zstawka*zwspdeg)/100),2)
                    zodpis_mie=iif(zSPOSOB='L',_round(zliniowo/12,2),_round(iif(zliniowo>=zdegres,zliniowo/12,zdegres/12),2))
                 endif
              enddo
              unlock
              endif
           else
              if zSPOSOBLIK='Z'
                 zDATA_LIK=zDATA_SPRZ
              endif
              if zstawka>0.0
              IDPR=rec_no
              if .not.empty(dtos(zDATA_LIK))
                 sele AMORT
                 seek '+'+str(idpr,5)+str(year(zDATA_LIK),4)
                 if found()
                    ODLIK=0
                    ODROK=0
                    do BLOKADAR
                    if month(zDATA_LIK)<12
                       odm=month(zDATA_LIK)
                       for i=odm+1 to 12
                           zmcn=strtran(str(i,2),' ','0')
*                           ODLIK=ODLIK+mc&zmcn
                           repl MC&ZMCN with 0
                       next
*                       codm=strtran(str(odm,2),' ','0')
*                       repl MC&codm with wart_akt-(odpis_sum-odlik)
                    endif
                    for i=1 to 12
                        zmcn=strtran(str(i,2),' ','0')
                        ODrok=ODrok+mc&zmcn
                    next
                    repl odpis_rok with odrok,odpis_sum with umorz_akt+odrok
                    unlock
                    skip
                    if .not.eof().and.del+ident='+'+str(idpr,5)
                       do BLOKADA
                       dele rest while del+ident='+'+str(idpr,5)
                    endif
                    unlock
                 endif
              endif
              endif
           endif
           @ 24,0
           sele kartst
           do BLOKADAR
           repl NREWID with zNREWID,;
                NAZWA with zNAZWA,;
                OPIS with zOPIS,;
                KRST with zKRST,;
                DATA_ZAK with zDATA_ZAK,;
                DATA_LIK with zDATA_LIK,;
                DOWOD_ZAK with zDOWOD_ZAK,;
                ZRODLO with zZRODLO,;
                WARTOSC with zWARTOSC,;
                WART_ULG with zWART_ULG,;
                NR_OT with zNR_OT,;
                NR_LT with zNR_LT,;
                WLASNOSC with zWLASNOSC,;
                PRZEZNACZ with zPRZEZNACZ,;
                SPOSOB with zSPOSOB,;
                STAWKA with zSTAWKA,;
                WSPDEG with zWSPDEG,;
                VATZAKUP with zVATZAKUP,;
                VATODLI with zVATODLI,;
                VATkorokr with zVATkorokr,;
                DATA_SPRZ with zDATA_SPRZ,;
                VATSPRZ with zVATSPRZ
           unlock
           commit_()
           *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
           _row=int((_row_g+_row_d)/2)
           if .not.ins
              break
           endif
           *@ _row_d,_col_l say &_proc
           scroll(_row_g,_col_l,_row_d,_col_p,1)
           @ _row_d,_col_l say [        ³          ³                                          ³        ³      ]
        end
        _disp=ins.or.lastkey()#27
        kl=iif(lastkey()=27.and._row=-1,27,kl)
        @ 23,0
*################################ KASOWANIE #################################
   case kl=7.or.kl=46
        RECS=rec_no
        @ 1,47 say [          ]
        ColStb()
        center(23,[þ                   þ])
        ColSta()
        center(23,[K A S O W A N I E])
        ColStd()
        _disp=tnesc([*i],[   Czy skasowa&_c.? (T/N)   ])
        if _disp
           select amort
           seek [+]+str(RECS,5)
           do while del=[+].and.ident=str(RECS,5)
              do BLOKADAR
              del()
              unlock
              skip
           enddo
           select kartstmo
           seek [+]+str(RECS,5)
           do while del=[+].and.ident=str(RECS,5)
              do BLOKADAR
              del()
              unlock
              skip
           enddo
           sele KARTST
           do BLOKADAR
           del()
           unlock
           seek '+'+ident_fir
        endif
        *====================================
        sele kartst
        @ 23,0
*################################# SZUKANIE #################################
   case kl=13
        begin sequence
              save screen to scrst
                   do srodki
              restore screen from scrst
        end
*################################# SZUKANIE #################################
                   case kl=-9.or.kl=247
@ 1,47 say [          ]
ColStb()
center(23,[þ                 þ])
ColSta()
  center(23,[S Z U K A N I E])
ColStd()
f10=date()
@ _row,1 get f10
read_()
_disp=.not.empty(f10).and.lastkey()#27
if _disp
   seek [+]+ident_fir+dtos(f10)
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
*set cent on
close_()
*################################## FUNKCJE #################################
procedure say31st
return dtoc(DATA_ZAK)+[³]+NREWID+[³]+NAZWA+[³]+KRST+[³]+str(STAWKA,6,2)
*############################################################################
procedure say31sst
clear type
set color to +w
@ 13,19 say substr(OPIS,1,40)
@ 13,69 say NR_OT
@ 14,19 say DOWOD_ZAK
@ 14,40 say WARTOSC picture "@E 9 999 999.99"
@ 14,64 say WART_ULG picture "@E 9 999 999.99"
@ 15,19 say ZRODLO
@ 16,12 say WLASNOSC+iif(WLASNOSC='W','&_l.asny','bcy  ')
@ 16,34 say PRZEZNACZ+iif(PRZEZNACZ='P','rodukcyj.','ieproduk.')
@ 16,53 say SPOSOB+iif(SPOSOB='L','iniowo    ','egresywnie')
@ 16,75 say WSPDEG picture "9.99"
@ 18,26 say VATZAKUP picture "@E 9 999 999.99"
@ 18,49 say VATODLI picture "@E 9 999 999.99"
@ 18,72 say VATkorokr pict '99'

if len(alltrim(dtos(DATA_LIK)))=0 .and. len(alltrim(dtos(DATA_SPRZ)))=0
   zSPOSOBLIK=' '
else
   if len(alltrim(dtos(DATA_LIK)))=8 .and. len(alltrim(dtos(DATA_SPRZ)))=0
      zSPOSOBLIK='L'
   endif
   if len(alltrim(dtos(DATA_LIK)))=8 .and. len(alltrim(dtos(DATA_SPRZ)))=8
      zSPOSOBLIK='Z'
   endif
endif

@ 20,10 say zSPOSOBLIK+iif(zSPOSOBLIK=' ','          ',iif(zSPOSOBLIK='Z','bycie     ','ikwidacja '))
@ 20,42 say space(10)
@ 20,69 say '   '
@ 21,42 say space(10)
if zSPOSOBLIK='Z'
   @ 20,42 say DATA_SPRZ
   @ 20,69 say VATSPRZ+iif(VATSPRZ='Z','wo',iif(VATSPRZ='O','po','  '))
endif
if zSPOSOBLIK='L'
   @ 21,42 say DATA_LIK
endif
@ 21,69 say NR_LT

set color to
return
***************************************************
function v3_111st
if empty(zNAZWA)
   return .f.
endif
return .t.
***************************************************
function w3_131st
ColInf()
@ 24,0 say padc('Wpisz: W - &_s.rodek w&_l.asny   lub   O - &_s.rodek obcy',80,' ')
ColStd()
@ 16,13 say iif(zWLASNOSC='W','&_l.asny','bcy  ')
return .t.
***************************************************
function v3_131st
R=.f.
if zWLASNOSC$'WO'
   ColStd()
   @ 16,13 say iif(zWLASNOSC='W','&_l.asny','bcy  ')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function w3_141st
ColInf()
@ 24,0 say padc('Wpisz: P - &_s.rodek produkcyjny   lub   N - &_s.rodek nieprodukcyjny',80,' ')
ColStd()
@ 16,35 say iif(zPRZEZNACZ='P','rodukcyj.','ieproduk.')
return .t.
***************************************************
function v3_141st
R=.f.
if zPRZEZNACZ$'PN'
   ColStd()
   @ 16,35 say iif(zPRZEZNACZ='P','rodukcyj.','ieproduk.')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function w3_151st
ColInf()
@ 24,0 say padc('Wpisz: L - liniowo   lub   D - degresywnie',80,' ')
ColStd()
@ 16,54 say iif(zSPOSOB='L','iniowo    ','egresywnie')
return .t.
***************************************************
function v3_151st
R=.f.
if zSPOSOB$'LD'
   ColStd()
   @ 16,54 say iif(zSPOSOB='L','iniowo    ','egresywnie')
   @ 24,0
   R=.t.
endif
return R
***************************************************
function w3_161st
ColInf()
@ 24,0 say padc('Pozostaw puste lub wpisz: Z - zbycie   lub   L - likwidacja',80,' ')
ColStd()
@ 20,11 say iif(zSPOSOBLIK=' ','          ',iif(zSPOSOBLIK='Z','bycie     ','ikwidacja '))
return .t.
***************************************************
function v3_161st
R=.f.
if zSPOSOBLIK$'ZL '
   ColStd()
   @ 20,11 say iif(zSPOSOBLIK=' ','          ',iif(zSPOSOBLIK='Z','bycie     ','ikwidacja '))
   @ 24,0
   R=.t.
endif
return R
***************************************************
function wVATkorokr
ColInf()
@ 24,0 say padc('Wpisz: 1 - srodki o wart<15000PLN, 10 - dla nieruchomosci, 5 - dla innych ST',80,' ')
ColStd()
return .t.
***************************************************
function vVATkorokr
R=.f.
if zVATkorokr=1 .or. zVATkorokr=5 .or. zVATkorokr=10
   @ 24,0
   R=.t.
else
   ColInf()
   @ 24,0 say padc('Wpisz: 1 - srodki o wart<15000PLN, 10 - dla nieruchomosci, 5 - dla innych ST',80,' ')
*   @ 24,0 say padc('Wpisz: 10 - dla nieruchomosci   lub   5 - dla innych ST',80,' ')
   ColStd()
   R=.f.
endif
return R
***************************************************
function wVATSPRZ
*if len(alltrim(dtos(zDATA_SPRZ)))=0
*   ColInf()
*   @ 24,0 say padc('Pozostaw puste jezeli nie sprzedawano srodka trwalego',80,' ')
*   ColStd()
*   @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
*else
   ColInf()
   @ 24,0 say padc('Wpisz: O - opodatkowany lub Z - zwolniony',80,' ')
   ColStd()
   @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
*endif
return .t.
***************************************************
function vVATSPRZ
R=.f.
*if len(alltrim(dtos(zDATA_SPRZ)))=0
*   if zVATSPRZ==' '
*      ColStd()
*      @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
*      @ 24,0
*      R=.t.
*   endif
*else
   if zVATSPRZ$'OZ'
      ColStd()
      @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
      @ 24,0
      R=.t.
   endif
*endif
return R
*############################################################################
