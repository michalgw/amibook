/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

*±±±±±± NAGLOWEK KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    KEDU_POCZ
??"<!DOCTYPE KEDU PUBLIC '-//ZUS//DTD KEDU 1.3//PL'["
?"<!ENTITY wersja '001.300'>"
?"<!ENTITY strona.kodowa 'ISO 8859-2'>]>"
?"<KEDU>"
?"<naglowek.KEDU>"
?space(139)
?"</naglowek.KEDU>"
*±±±±±± STOPKA KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    KEDU_KON
?"<stopka.KEDU>"
?"</stopka.KEDU>"
?"</KEDU>"
*±±±±±± RAPORT z KEDU ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    KEDU_RAPO
para    plik_k
CurCol=ColStd()
set colo to w
@ 12,43 say padc('Utworzono plik '+plik_k,35)
@ 13,43 say padc('Zaimportuj go Programem P&_l.atnika',35)
@ 14,43 say padc('Poszczeg&_o.lne znaki w nazwie',35)
@ 15,43 say padc('pliku '+plik_k+' oznaczaj&_a.:',35)
set colo to w+
@ 16,43 say substr(plik_k,1,1) pict '!!'
@ 17,43 say substr(plik_k,2,1) pict '!!'
@ 18,43 say substr(plik_k,3,2) pict '!!'
@ 19,43 say substr(plik_k,5,1) pict '!!'
@ 20,43 say substr(plik_k,6,1) pict '!!'
@ 21,43 say substr(plik_k,7,2) pict '!!'
ColStd()
@ 16,45 say '-ko&_n.c&_o.wka roku '+param_rok
@ 17,45 say '-nr miesi&_a.ca (dla zg&_l.osze&_n. 0)(HEX)'
@ 18,45 say '-nr firmy (S35)'
do case
case substr(plik_k,5,1)='1'
     symfor='ZUA'
case substr(plik_k,5,1)='2'
     symfor='ZCZA'
case substr(plik_k,5,1)='3'
     symfor='ZCNA'
case substr(plik_k,5,1)='4'
     symfor='ZPA'
case substr(plik_k,5,1)='5'
     symfor='ZFA'
case substr(plik_k,5,1)='7'
     symfor='RNA'
case substr(plik_k,5,1)='8'
     symfor='RCA'
case substr(plik_k,5,1)='9'
     symfor='DRA'
case substr(plik_k,5,1)='A'
     symfor='RZA'
other
     symfor=''
endcase
@ 19,45 say '-symbol formularza ('+symfor+')'
do case
case substr(plik_k,6,1)='W'
     sympod='w&_l.a&_s.ciciel'
case substr(plik_k,6,1)='P'
     sympod='pracownik'
case substr(plik_k,6,1)='F'
     sympod='firma'
case substr(plik_k,6,1)='R'
     sympod='rodzina'
other
     sympod=''
endcase
@ 20,45 say '-podmiot formularza ('+sympod+')'
@ 21,45 say '-nr podmiotu (S35)'
set color to &CurCol
inkey(0)
*±±±±±± NAGLOWEK DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DP_POCZ
para FORMA
?'<ZUS'+FORMA+'.DP>'
?'<naglowek.DP>'
?space(245)
?'</naglowek.DP>'
*±±±±±± STOPKA DP ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DP_KON
para FORMA
?'<stopka.DP>'
?'</stopka.DP>'
?'</ZUS'+FORMA+'.DP>'
*±±±±±± ZUSWYMIAR    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    ZUSWYMIAR
para WYML,WYMM
WYMIZUS=strtran(str(WYML,3)+str(WYMM,3),' ','0')
if WYMIZUS='000000'
   WYMIZUS=space(6)
endif
return WYMIZUS
*±±±±±± ADKB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADKB
?     '<ADKB>'
?space(5)
?space(26)
?space(30)
?space(7)
?space(7)
?space(5)
?space(12)
?space(12)
?space(30)
?    '</ADKB>'
*±±±±±± ADKP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADKP
?     '<ADKP>'
?space(5)
?space(26)
?space(30)
?space(7)
?space(7)
?space(12)
?space(5)
?space(12)
?space(12)
?space(30)
?    '</ADKP>'
*±±±±±± ADZA     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ADZA
?     '<ADZA>'
?space(5)
?space(26)
?space(26)
?space(30)
?space(7)
?space(7)
?space(12)
?space(12)
?    '</ADZA>'
*±±±±±± ASPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ASPL
para PKOD_POCZT,;
     PMIEJSCE,;
     PGMINA,;
     PULICA,;
     PNR_DOMU,;
     PNR_LOKAL,;
     PTEL,;
     PFAX
?     '<ASPL>'
?lat_iso(padr(strtran(PKOD_POCZT,'-',''),5))
?lat_iso(padr(PMIEJSCE,26))
?lat_iso(padr(PGMINA,26))
?lat_iso(padr(PULICA,30))
?lat_iso(padr(PNR_DOMU,7))
?lat_iso(padr(PNR_LOKAL,7))
?lat_iso(padr(PTEL,12))
?lat_iso(padr(PFAX,12))
?space(30)
?    '</ASPL>'
*±±±±±± ASZP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ASZP
para PKOD_POCZT,;
     PMIEJSCE,;
     PGMINA,;
     PULICA,;
     PNR_DOMU,;
     PNR_LOKAL,;
     PTEL,;
     PFAX
?     '<ASZP>'
?lat_iso(padr(strtran(PKOD_POCZT,'-',''),5))
?lat_iso(padr(PMIEJSCE,26))
?lat_iso(padr(PGMINA,26))
?lat_iso(padr(PULICA,30))
?lat_iso(padr(PNR_DOMU,7))
?lat_iso(padr(PNR_LOKAL,7))
?lat_iso(padr(PTEL,12))
?lat_iso(padr(PFAX,12))
?space(30)
?    '</ASZP>'
*±±±±±± AZMO     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    AZMO
para PKOD_POCZT,;
     PMIEJSCE,;
     PGMINA,;
     PULICA,;
     PNR_DOMU,;
     PNR_LOKAL,;
     PTEL,;
     PFAX
?     '<AZMO>'
?lat_iso(padr(strtran(PKOD_POCZT,'-',''),5))
?lat_iso(padr(PMIEJSCE,26))
?lat_iso(padr(PGMINA,26))
?lat_iso(padr(PULICA,30))
?lat_iso(padr(PNR_DOMU,7))
?lat_iso(padr(PNR_LOKAL,7))
?lat_iso(padr(PTEL,12))
?lat_iso(padr(PFAX,12))
?    '</AZMO>'
*±±±±±± DADRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DADRA
para PTERMIN,;
     PMM,;
     PRRRR
?     '<DADRA>'
?PTERMIN
?'01'+strtran(pmm,' ','0')+prrrr
?space(8)
?space(6)
?space(12)
?    '</DADRA>'
*±±±±±± DAIP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DAIP
para PNIP,;
     PREGON,;
     PSKROT
?     '<DAIP>'
?padr(strtran(PNIP,'-',''),10)
?padr(substr(strtran(PREGON,'-',''),1,9),14)
?lat_iso(padr(qq(PSKROT),31))
?space(16)
?space(16)
?'  '
?    '</DAIP>'
*±±±±±± DAPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DAPL
para PNAZWA,;
     PDATA_REJ,;
     PNUMER_REJ,;
     PORGAN,;
     PDATA_ZAL
?     '<DAPL>'
?lat_iso(padr(qq(PNAZWA),62))
?' '
?'X'
?space(31)
?'X'
?substr(dtos(PDATA_REJ),7,2)+substr(dtos(PDATA_REJ),5,2)+substr(dtos(PDATA_REJ),1,4)
?padr(PNUMER_REJ,15)
?lat_iso(padr(PORGAN,72))
?'        '
pdata_zal=iif(dtos(Pdata_zal)<'19990101',ctod('1998/12/31'),pdata_zal)
?substr(dtos(PDATA_ZAL),7,2)+substr(dtos(PDATA_ZAL),5,2)+substr(dtos(PDATA_ZAL),1,4)
?    '</DAPL>'
*±±±±±± DAU      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DAU
para PPESEL,;
     PNIP,;
     PRODZ_DOK,;
     PDOWOD_OSOB,;
     PNAZWISKO,;
     PIMIE,;
     PDATA_UR
?     '<DAU>'
?padr(PPESEL,11)
?padr(strtran(PNIP,'-',''),10)
?iif(empty(PDOWOD_OSOB),' ',iif(PRODZ_DOK='D','1',iif(PRODZ_DOK='P','2',' ')))
?lat_iso(padr(PDOWOD_OSOB,9))
?lat_iso(padr(PNAZWISKO,31))
?lat_iso(padr(PIMIE,22))
?substr(dtos(PDATA_UR),7,2)+substr(dtos(PDATA_UR),5,2)+substr(dtos(PDATA_UR),1,4)
?space(16)
?space(16)
?'  '
?    '</DAU>'
*±±±±±± DDDU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DDDU
para PTYT,PPODS,PPODSZDR
?     '<DDDU>'
?padr(PTYT,6)
if .not.empty(ptyt)
   ?strtran(str(ppods*100,10),' ','0')
   ?strtran(str(ppods*100,10),' ','0')
   ?strtran(str(ppodszdr*100,10),' ','0')
else
   ?space(10)
   ?space(10)
   ?space(10)
endif
?' '
?    '</DDDU>'
*±±±±±± DDORCA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DDORCA
para PNAZWISKO,;
     PIMIE,;
     PTYPID,;
     PNRID,;
     PTYTUB,;
     PWYMIAR,;
     PPODSEME,;
     PPODSCHO,;
     PPODSZDR,;
     PWAR_PUE,;
     PWAR_PUR,;
     PWAR_PUC,;
     PWAR_PUZ,;
     PWAR_FUE,;
     PWAR_FUR,;
     PWAR_FUW,;
     PWAR_PF3,;
     PWAR_SUM,;
     PILOSORODZ,;
     PWARRODZ,;
     PILOSOPIEL,;
     PWARPIEL,;
     PSUM_ZAS
?     '<DDORCA>'
?lat_iso(padr(PNAZWISKO,31))
?lat_iso(padr(PIMIE,22))
?PTYPID
?padr(PNRID,11)
?PTYTUB
?' '
?PWYMIAR
?strtran(str(ppodseme*100,8),' ','0')
?strtran(str(ppodscho*100,8),' ','0')
?strtran(str(ppodszdr*100,8),' ','0')
?strtran(str(pwar_pue*100,7),' ','0')
?strtran(str(pwar_pur*100,7),' ','0')
?strtran(str(pwar_puc*100,7),' ','0')
?strtran(str(pwar_puz*100,7),' ','0')
?strtran(str(pwar_fue*100,7),' ','0')
?strtran(str(pwar_fur*100,7),' ','0')
?strtran(str(pwar_fuw*100,7),' ','0')
?strtran(str(pwar_pf3*100,7),' ','0')
?strtran(str(pwar_sum*100,8),' ','0')
?strtran(str(pilosorodz,2),' ','0')
?strtran(str(pwarrodz*100,7),' ','0')
?'0000000'
?strtran(str(pilosopiel,2),' ','0')
?strtran(str(pwarpiel*100,7),' ','0')
?strtran(str(psum_zas*100,8),' ','0')
?repl('0',16)
?repl('0',16)
?'  '
?    '</DDORCA>'
*±±±±±± DDORNA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DDORNA
para PNAZWISKO,;
     PIMIE,;
     PTYPID,;
     PNRID,;
     PTYTUB,;
     PWYMIAR,;
     PPODSEME,;
     PPODSCHO,;
     PPODSZDR,;
     PWAR_PUE,;
     PWAR_PUR,;
     PWAR_PUC,;
     PWAR_PUZ,;
     PWAR_FUE,;
     PWAR_FUR,;
     PWAR_FUW,;
     PWAR_PF3,;
     PWAR_SUM,;
     PILOSORODZ,;
     PWARRODZ,;
     PILOSOPIEL,;
     PWARPIEL,;
     PSUM_ZAS,;
     PDATA,;
     PZASAD,;
     PPREMIA,;
     PINNE,;
     PSUMSKLA,;
     PKODSKLA
?     '<DDORNA>'
?lat_iso(padr(PNAZWISKO,31))
?lat_iso(padr(PIMIE,22))
if PTYPID='D'
   PTYPID='1'
endif
?PTYPID
?padr(PNRID,11)
?PTYTUB
?' '
?PWYMIAR
?strtran(str(ppodseme*100,8),' ','0')
?strtran(str(ppodscho*100,8),' ','0')
?strtran(str(ppodszdr*100,8),' ','0')
?strtran(str(pwar_pue*100,7),' ','0')
?strtran(str(pwar_pur*100,7),' ','0')
?strtran(str(pwar_puc*100,7),' ','0')
?strtran(str(pwar_puz*100,7),' ','0')
?strtran(str(pwar_fue*100,7),' ','0')
?strtran(str(pwar_fur*100,7),' ','0')
?strtran(str(pwar_fuw*100,7),' ','0')
?strtran(str(pwar_pf3*100,7),' ','0')
?strtran(str(pwar_sum*100,8),' ','0')
?strtran(str(pilosorodz,2),' ','0')
?strtran(str(pwarrodz*100,7),' ','0')
?'0000000'
?strtran(str(pilosopiel,2),' ','0')
?strtran(str(pwarpiel*100,7),' ','0')
?strtran(str(psum_zas*100,8),' ','0')
?'  '
?'  '
?PKODSKLA
if dtoc(PDATA)=='    .  .  '
   ?'        '
   ?'        '
else
   ?'01'+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
   ?substr(dtos(PDATA),7,2)+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
endif
?strtran(str(pzasad*100,8),' ','0')
if ppremia#0
   ?'21'
   ?'01'+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
   ?substr(dtos(PDATA),7,2)+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
   ?strtran(str(ppremia*100,8),' ','0')
else
   ?'  '
   ?'        '
   ?'        '
   ?'        '
endif
if pinne#0
   ?'50'
   ?'01'+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
   ?substr(dtos(PDATA),7,2)+substr(dtos(PDATA),5,2)+substr(dtos(PDATA),1,4)
   ?strtran(str(pinne*100,8),' ','0')
else
   ?'  '
   ?'        '
   ?'        '
   ?'        '
endif
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?'  '
?'        '
?'        '
?'        '
?strtran(str(psumskla*100,9),' ','0')
?repl('0',16)
?repl('0',16)
?'  '
?    '</DDORNA>'
*±±±±±± DDORZA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DDORZA
para PNAZWISKO,;
     PIMIE,;
     PTYPID,;
     PNRID,;
     PTYTUB,;
     PPODSTAWA,;
     PSUMSKLA
?     '<DDORZA>'
?lat_iso(padr(PNAZWISKO,31))
?lat_iso(padr(PIMIE,22))
?PTYPID
?padr(PNRID,11)
?PTYTUB
?strtran(str(ppodstawa*100,8),' ','0')
?strtran(str(psumskla*100,7),' ','0')
?repl('0',16)
?repl('0',16)
?'  '
?    '</DDORZA>'
*±±±±±± DEOZ     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DEOZ
para PIMIE2,;
     PNAZW_RODU,;
     POBYWATEL,;
     PPLEC
?     '<DEOZ>'
?lat_iso(padr(PIMIE2,22))
?lat_iso(padr(PNAZW_RODU,31))
?lat_iso(padr(POBYWATEL,22))
?PPLEC
?' '
?' '
?    '</DEOZ>'
*±±±±±± DEPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DEPL
para PIMIE2,;
     PMIEJSC_UR,;
     POBYWATEL
?     '<DEPL>'
?lat_iso(padr(PIMIE2,22))
?lat_iso(padr(PMIEJSC_UR,26))
?lat_iso(padr(POBYWATEL,22))
?    '</DEPL>'
*±±±±±± DIPL     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DIPL
para PNIP,;
     PREGON,;
     PPESEL,;
     PRODZ_DOK,;
     PDOWOD_OSOB,;
     PSKROT,;
     PNAZWISKO,;
     PIMIE,;
     PDATA_UR
?     '<DIPL>'
?padr(strtran(PNIP,'-',''),10)
?padr(substr(strtran(PREGON,'-',''),1,9),14)
?padr(PPESEL,11)
?iif(empty(PDOWOD_OSOB),' ',iif(PRODZ_DOK='D','1',iif(PRODZ_DOK='P','2',' ')))
?padr(PDOWOD_OSOB,9)
?lat_iso(padr(qq(PSKROT),31))
?lat_iso(padr(PNAZWISKO,31))
?lat_iso(padr(PIMIE,22))
?substr(dtos(PDATA_UR),7,2)+substr(dtos(PDATA_UR),5,2)+substr(dtos(PDATA_UR),1,4)
?space(16)
?space(16)
?'  '
?    '</DIPL>'
*±±±±±± DOBR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOBR
para PNIP,;
     PREGON,;
     PSKROT
?     '<DOBR>'
?padr(strtran(PNIP,'-',''),10)
?padr(substr(strtran(PREGON,'-',''),1,9),14)
?lat_iso(padr(qq(PSKROT),31))
?space(16)
?space(16)
?'  '
?    '</DOBR>'
*±±±±±± DOBU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOBU
?     '<DOBU>'
?' '
?space(8)
?' '
?space(8)
?' '
?space(8)
?    '</DOBU>'
*±±±±±± DOCRA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOCRA
?     '<DOCRA>'
?' '
?space(8)
?space(11)
?space(10)
?space(1)
?space(9)
?space(31)
?space(22)
?space(8)
?'  '
?' '
?' '
?' '
?space(5)
?space(26)
?space(26)
?space(30)
?space(7)
?space(7)
?space(12)
?space(12)
?repl('0',16)
?repl('0',16)
?'00'
?    '</DOCRA>'
*±±±±±± DOCRBA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOCRBA
?     '<DOCRBA>'
?' '
?space(8)
?space(11)
?space(10)
?space(1)
?space(9)
?space(31)
?space(22)
?space(8)
?'  '
?' '
?' '
?' '
?repl('0',16)
?repl('0',16)
?'00'
?    '</DOCRBA>'
*±±±±±± DODU   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DODU
?     '<DODU>'
?space(8)
?space(9)
?    '</DODU>'
*±±±±±± DOKC     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOKC
para PKOD_KASY
?     '<DOKC>'
?PKOD_KASY
do case
case PKOD_KASY='01R'
     ?lat_iso(padr('DOLNOóL§SKA RKCH',23))
case PKOD_KASY='02R'
     ?lat_iso(padr('KUJAWSKO-POMORSKA RKCH',23))
case PKOD_KASY='03R'
     ?lat_iso(padr('LUBELSKA RKCH',23))
case PKOD_KASY='04R'
     ?lat_iso(padr('LUBUSKA RKCH',23))
case PKOD_KASY='05R'
     ?lat_iso(padr('ù‡DZKA RKCH',23))
case PKOD_KASY='06R'
     ?lat_iso(padr('MAùOPOLSKA RKCH',23))
case PKOD_KASY='07R'
     ?lat_iso(padr('MAZOWIECKA RKCH',23))
case PKOD_KASY='08R'
     ?lat_iso(padr('OPOLSKA RKCH',23))
case PKOD_KASY='09R'
     ?lat_iso(padr('PODKARPACKA RKCH',23))
case PKOD_KASY='10R'
     ?lat_iso(padr('PODLASKA RKCH',23))
case PKOD_KASY='11R'
     ?lat_iso(padr('POMORSKA RKCH',23))
case PKOD_KASY='12R'
     ?lat_iso(padr('óL§SKA RKCH',23))
case PKOD_KASY='13R'
     ?lat_iso(padr('óWI®TOKRZYSKA RKCH',23))
case PKOD_KASY='14R'
     ?lat_iso(padr('WARMI„SKO-MAZURSKA RKCH',23))
case PKOD_KASY='15R'
     ?lat_iso(padr('WIELKOPOLSKA RKCH',23))
case PKOD_KASY='16R'
     ?lat_iso(padr('ZACHODNIOPOMORSKA RKCH',23))
case PKOD_KASY='17R'
     ?lat_iso(padr('BKCH SùUΩB MUNDUROWYCH',23))
other
     ?space(23)
endcase
?'        '
?    '</DOKC>'
*±±±±±± DOOU     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOOU
?     '<DOOU>'
?'        '
?    '</DOOU>'
*±±±±±± DORB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DORB
para PKONTO
?     '<DORB>'
*PKONTO=iif(substr(PKONTO,9,1)='-',substr(PKONTO,1,8)+substr(PKONTO,10),PKONTO)
?lat_iso(padr(PKONTO,36))
?' '
?    '</DORB>'
*±±±±±± DORCA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DORCA
para PMM,PRRRR,PSUMA
?     '<DORCA>'
?'01'+strtran(pmm,' ','0')+prrrr
?'00001'
?repl('0',9)
?strtran(str(psuma*100,9),' ','0')
?    '</DORCA>'
*±±±±±± DORNA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DORNA
para PMM,PRRRR,PSUMA
?     '<DORNA>'
?'01'+strtran(pmm,' ','0')+prrrr
?'00001'
?repl('0',10)
?strtran(str(psuma*100,10),' ','0')
?    '</DORNA>'
*±±±±±± DORZA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DORZA
para PMM,PRRRR,PSUMA
?     '<DORZA>'
?'01'+strtran(pmm,' ','0')+prrrr
?'0001'
?repl('0',8)
?strtran(str(psuma*100,8),' ','0')
?    '</DORZA>'
*±±±±±± DOWP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOWP
para PWYMIAR,;
     PUE,;
     PUR,;
     PUC,;
     PUW
?     '<DOWP>'
?PWYMIAR
?'        '
?padr(PUE,1)
?padr(PUR,1)
?padr(PUC,1)
?padr(PUW,1)
?    '</DOWP>'
*±±±±±± DOZCBA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOZCBA
?     '<DOZCBA>'
?space(8)
?space(6)
?    '</DOZCBA>'
*±±±±±± DOZPF    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOZPF
?     '<DOZPF>'
?'X'
?' '
?space(8)
?space(6)
?    '</DOZPF>'
*±±±±±± DOZUA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    DOZUA
?     '<DOZUA>'
?'X'
?' '
?' '
?space(8)
?space(6)
?    '</DOZUA>'
*±±±±±± IDO1     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    IDO1
?     '<IDO1>'
?' '
?space(8)
?space(8)
?' '
?    '</IDO1>'
*±±±±±± IDOP     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    IDOP
?     '<IDOP>'
?' '
?space(8)
?space(8)
?space(8)
?' '
?    '</IDOP>'
*±±±±±± INN7     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    INN7
para PILUB,PILET,PSTAW_WYP
?     '<INN7>'
?strtran(str(pilub,6),' ','0')
?strtran(str(pilet*100,8),' ','0')
?'0'
?strtran(str(pstaw_wyp*100,4),' ','0')
?    '</INN7>'
*±±±±±± IODZ     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    IODZ
?     '<IODZ>'
?'  '
?' '
?'01'
?space(16)
?space(7)
?space(6)
?space(16)
?'  '
?space(9)
?space(16)
?    '</IODZ>'
*±±±±±± KNDK     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    KNDK
?     '<KNDK>'
?'0000000000'
?'0000000000'
?'0000000000'
?'00000000000'
?    '</KNDK>'
*±±±±±± LSKD     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    LSKD
para PWAR_PUZ
?     '<LSKD>'
?'000000000000'
?    '</LSKD>'
*±±±±±± OPL1     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OPL1
?     '<OPL1>'
?'        '
?    '</OPL1>'
*±±±±±± OPL2     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OPL2
?     '<OPL2>'
?'   '
?'   '
?'        '
?    '</OPL2>'
*±±±±±± OPLR     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OPLR
para PDATA
?     '<OPLR>'
?'        '
?    '</OPLR>'
*±±±±±± OPLS     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    OPLS
?     '<OPLS>'
?'     '
?'     '
?'     '
?'     '
?'     '
?'     '
?'        '
?'        '
?    '</OPLS>'
*±±±±±± PPDB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    PPDB
para PKOD,;
     PNUMER_REJ,;
     PORGAN,;
     PDATA_REJ,;
     PDATA_ZAL
?     '<PPDB>'
?PKOD
?padr(PNUMER_REJ,15)
?lat_iso(padr(PORGAN,72))
?substr(dtos(PDATA_REJ),7,2)+substr(dtos(PDATA_REJ),5,2)+substr(dtos(PDATA_REJ),1,4)
pdata_zal=iif(dtos(Pdata_zal)<'19990101',ctod('1998/12/31'),pdata_zal)
?substr(dtos(PDATA_ZAL),7,2)+substr(dtos(PDATA_ZAL),5,2)+substr(dtos(PDATA_ZAL),1,4)
?    '</PPDB>'
*±±±±±± RIVDRA   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    RIVDRA
?     '<RIVDRA>'
?'00000000000'
?'00000000000'
?    '</RIVDRA>'
*±±±±±± TYUB     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    TYUB
para PTYTUB
?     '<TYUB>'
?PTYTUB
?space(16)
?    '</TYUB>'
*±±±±±± ZDRAV    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ZDRAV
para PWAR_Pfp,pwar_pfg,psum
?     '<ZDRAV>'
?strtran(str(pwar_pfp*100,10),' ','0')
?strtran(str(pwar_pfg*100,10),' ','0')
?strtran(str(psum*100,11),' ','0')
?    '</ZDRAV>'
*±±±±±± ZSDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ZSDRA
para PWAR_PUZ
?     '<ZSDRA>'
?strtran(str(pwar_puz*100,10),' ','0')
?'0000000000'
?'0000000000'
?strtran(str(pwar_puz*100,11),' ','0')
?    '</ZSDRA>'
*±±±±±± ZSDRAI   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ZSDRAI
para PSUM_EME,;
     PSUM_REN,;
     PSUMEMEREN,;
     PWAR_PUE,;
     PWAR_PUR,;
     PWARSUMP,;
     PWAR_FUE,;
     PWAR_FUR,;
     PWARSUMF,;
     PSUM_CHO,;
     PSUM_WYP,;
     PSUMCHOWYP,;
     PWAR_PUC,;
     PWAR_PUW,;
     PWARSUMPC,;
     PWAR_FUC,;
     PWARSUMFC,;
     PRAZEM
?     '<ZSDRAI>'
?strtran(str(psum_eme*100,10),' ','0')
?strtran(str(psum_ren*100,10),' ','0')
?strtran(str(psumemeren*100,10),' ','0')
?strtran(str(pwar_pue*100,10),' ','0')
?strtran(str(pwar_pur*100,10),' ','0')
?strtran(str(pwarsump*100,10),' ','0')
?strtran(str(pwar_fue*100,10),' ','0')
?strtran(str(pwar_fur*100,10),' ','0')
?strtran(str(pwarsumf*100,10),' ','0')
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?strtran(str(psum_cho*100,10),' ','0')
?strtran(str(psum_wyp*100,10),' ','0')
?strtran(str(psumchowyp*100,10),' ','0')
?strtran(str(pwar_puc*100,10),' ','0')
?strtran(str(pwar_puw*100,10),' ','0')
?strtran(str(pwarsumpc*100,10),' ','0')
?strtran(str(pwar_fuc*100,10),' ','0')
?strtran(str(pwarsumfc*100,10),' ','0')
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?strtran(str(prazem*100,11),' ','0')
?    '</ZSDRAI>'
*±±±±±± ZWDRA    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
proc    ZWDRA
?     '<ZWDRA>'
?'0000000000'
?'0000000000'
?'0000000000'
?'0000000000'
?'00000000000'
?    '</ZWDRA>'
*±±±±±± LAT_ISO  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    LAT_ISO
param lancuch
lancuch=strtran(lancuch,'§',chr(161))
lancuch=strtran(lancuch,'è',chr(198))
lancuch=strtran(lancuch,'®',chr(202))
lancuch=strtran(lancuch,'ù',chr(163))
lancuch=strtran(lancuch,'„',chr(209))
lancuch=strtran(lancuch,'‡',chr(211))
lancuch=strtran(lancuch,'ó',chr(166))
lancuch=strtran(lancuch,'Ω',chr(175))
lancuch=strtran(lancuch,'ç',chr(172))
return lancuch
*±±±±±± QQ       ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    QQ
param lanc
lanc=strtran(lanc,["],[ ])
lanc=strtran(lanc,[,],[ ])
lanc=strtran(lanc,[/],[ ])
lanc=strtran(lanc,['],[ ])
return lanc
*±±±±±± HI36     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    HI36
param _liczba
return _int(_liczba/35)
*±±±±±± LO36     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func    LO36
param _liczba
return _liczba-(_int(_liczba/35)*35)
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
