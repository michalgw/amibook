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

FUNCTION Param_F()

private _top,_bot,_top_bot,_stop,_sbot,_proc,kl,ins,nr_rec,f10,rec,fou
@ 1,47 say [          ]
*################################# GRAFIKA ##################################
ColStd()
@  3, 0 say 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@  4, 0 say '³ Nazwa skr&_o.cona..                                                             ³'
@  5, 0 say '³ NIP.123-456-78-90 nipUE.PL-1234567890  REGON.12345678901 NKP..12345678901234 ³'
@  6, 0 say '³ Bank..                                 Konto..                               ³'
@  7, 0 say '³ Urz&_a.d Skarbowy..                                                             ³'
@  8, 0 say '³ Wojew&_o.dztwo.....                       Powiat.                               ³'
@  9, 0 say '³ Nazwisko pe&_l.nomocnika lub w&_l.a&_s.ciciela.........                               ³'
@ 10, 0 say '³ Dekl.podpisuje: Nazwisko..               Imie..               Tel..          ³'
@ 11, 0 say '³ Organ rej...                                 Data rejestracji....            ³'
@ 12, 0 say '³ Nazwa rej...                                 Numer w rejestrze...            ³'
@ 13, 0 say '³ R.Dzia&_l..1.                                         KGN.         PKD.         ³'
@ 14, 0 say '³ Platnik VAT.Tak        Formularz:VAT-      Info UE Mies/Kwart ?..            ³'
@ 15, 0 say '³ Ryczalt...        Num.ks.(Roczn/Mies).     Pod.doch.oblicz Mies/Kwart ?..    ³'
@ 16, 0 say '³ W rej.zak.VAT domy&_s.lna data ksi&_e.gowania do ksi&_e.gi (data Wp&_l.ywu/Dokumentu) ?. ³'
@ 17, 0 say '³ Haslo firmy...            Rodz.druku FA.   Rachunki wprowadzac bruttem ?.    ³'
@ 18, 0 say '³ Adres e-mail...                            Rodzaj dokumentu sprzed..         ³'
@ 19, 0 say 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ 20, 0 say '³ Lp pocz.ewid.podstawowej...       Domy&_s.lna druga data:.                      ³'
@ 21, 0 say '³ Lp pocz.ewid.wyposa&_z.enia...       Nr biez.fakt.VAT:.....Wew:..... Rach:..... ³'
@ 22, 0 say 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
*############################### OTWARCIE BAZ ###############################
select 5
if dostep('ORGANY')
   do setind with 'ORGANY'
   seek [+]
   if eof().or.del#'+'
      kom(3,[*u],[ Najpierw wprowad&_x. informacje o Organach Rejestrowych ])
      return
   endif
else
   close_()
   return
endif
select 4
if dostep('REJESTRY')
   do setind with 'REJESTRY'
   seek [+]
   if eof().or.del#'+'
      kom(3,[*u],[ Najpierw wprowad&_x. informacje o rejestrach gospodarczych ])
      return
   endif
else
   close_()
   return
endif
select 3
if dostep('SPOLKA')
   do setind with 'SPOLKA'
   seek [+]+ident_fir
   if eof().or.del#'+'.or.firma#ident_fir
      kom(3,[*u],[ Najpierw wprowad&_x. informacje o w&_l.a&_s.cicielach ])
      return
   endif
else
   close_()
   return
endif
select 2
if dostep('URZEDY')
   do setind with 'URZEDY'
   seek [+]
   if eof().or.del#'+'
      kom(3,[*u],[ Najpierw wprowad&_x. informacje o Urz&_e.dach Skarbowych ])
      return
   endif
else
   close_()
   return
endif
select 1
if dostep('FIRMA')
   set inde to firma
   go val(ident_fir)
else
   close_()
   return
endif
*----- parametry ------
_proc=[say23]
*----------------------
do &_proc
kl=0
do while kl#27
   ColSta()
   @ 1,47 say '[F1]-pomoc'
   ColStd()
   kl=inkey(0)
   do case
   *############################### MODYFIKACJA ################################
   case kl=109.or.kl=77
        @ 1,47 say [          ]
        ColStb()
        center(23,[þ                       þ])
        ColSta()
        center(23,[M O D Y F I K A C J A])
        ColStd()
        begin sequence
              *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
              NNN=alltrim(nazwa)
              zNAZWA_SKR=iif(empty(NAZWA_SKR),NNN+space(60-len(NNN)),NAZWA_SKR)
              zHASLO=HASLO
              zNR_REGON=NR_REGON
              zNR_KONTA=NR_KONTA
              zBANK=BANK
              zSKARB=SKARB
              zURZAD=space(45)
              if zSKARB<>0
                 sele urzedy
                 go zSKARB
                 zURZAD=miejsc_us+' - '+urzad
              endif
              sele firma
              zORGAN=ORGAN
              zNAZWA_ORG=space(60)
              if zORGAN<>0
                 sele organy
                 go zORGAN
                 zNAZWA_ORG=NAZWA_ORG
              endif
              sele firma
              zREJESTR=REJESTR
              zNAZWA_REJ=space(60)
              if zREJESTR<>0
                 sele rejestry
                 go zREJESTR
                 zNAZWA_REJ=NAZWA_REJ
              endif
              sele firma
              zDATA_REJ=DATA_REJ
              zNUMER_REJ=NUMER_REJ
              zNAZWISKO=NAZWISKO
              zNIP=NIP
              zNIPUE=NIPUE
              zNKP=NKP
              zODZUS=ODZUS
              zPARAM_WOJ=iif(empty(PARAM_WOJ),m->PARAM_WOJ,PARAM_WOJ)
              zPARAM_POW=iif(empty(PARAM_POW),m->PARAM_POW,PARAM_POW)
              zPRZEDM=PRZEDM
              zKGN1=KGN1
              zEKD1=EKD1
              zNR_FAKT=max(1,NR_FAKT)
              zNR_FAKTW=max(1,NR_FAKTW)
              zLICZBA=LICZBA
              zLICZBA_WYP=LICZBA_WYP
              zVAT=iif(VAT=' ','N',VAT)
              if UEOKRES=='K'
                 zUEOKRES='K'
              else
                 zUEOKRES='M'
              endif
              zVATOKRES=iif(VATOKRES=' ','M',VATOKRES)
              zVATOKRESDR=iif(VATOKRESDR=' ',VATOKRES,VATOKRESDR)
              if VATFORDR=='  '
                 if zVATOKRES='M'
*                   if zVATOKRESDR='M'
                       zVATFORDR='7 '
*                   else
*                      zVATFORDR='7D'
*                   endif
                 else
                    zVATFORDR='7K'
                 endif
              else
                 zVATFORDR=VATFORDR
              endif
              zPITOKRES=iif(PITOKRES=' ','M',PITOKRES)
              zNR_RACH=max(1,NR_RACH)
              zNR_SKUP=max(1,NR_SKUP)
              zKOR_FAKT=max(1,KOR_FAKT)
              zKOR_RACH=max(1,KOR_RACH)
              zDETAL=iif(DETAL=' ','N',DETAL)
              zRYCZALT=iif(RYCZALT=' ','N',RYCZALT)
*              zFAKT_MIEJ=FAKT_MIEJ
              zDEKLNAZWI=DEKLNAZWI
              zDEKLIMIE=DEKLIMIE
              zDEKLTEL=DEKLTEL
              zDATAKS=DATAKS
              zDATA2TYP=DATA2TYP
              zRODZNRKS := firma->rodznrks
              zAdrEMail := firma->email
              zRodzajDrFV := iif( firma->rodzajdrfv $ 'GT', firma->rodzajdrfv, 'T' )
              zRodzajFNV := iif( firma->rodzajfnv $ 'FR', firma->rodzajfnv, 'F' )
*ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
*set century off
ColStd()
@  4,18 get zNAZWA_SKR pict repl('!',60)
@  5,6  get zNIP       pict "!!!!!!!!!!!!!"
@  5,26 get zNIPUE     pict "!!!!!!!!!!!!!" when wnipue()
@  5,47 get zNR_REGON  pict "@S11 P-999999999-99999999-99-9-999-99999"
@  5,64 get zNKP       pict "@S14 !!!!!!!!!!!!!!!"
@  6,8  get zBANK      pict repl('!',30)
@  6,48 get zNR_KONTA  pict "@S30 "+repl('!',32)
@  7,18 get zURZAD     pict repl('!',20)+' - '+repl('!',25) valid v3_14f()
@  8,18 get zPARAM_WOJ pict repl('!',20)
@  8,48 get zPARAM_POW pict repl('!',20)
@  9,48 get zNAZWISKO  pict repl('!',30) valid vf_NAZW()
@ 10,28 get zDEKLNAZWI pict "@S14 "+repl('!',20)
@ 10,49 get zDEKLIMIE  pict "@S14 "+repl('!',15)
@ 10,69 get zDEKLTEL   pict "@S10 "+repl('!',25)
@ 11,14 get zNAZWA_ORG pict '@S30 '+repl('!',60) valid v3_14o()
@ 12,14 get zNAZWA_REJ pict '@S30 '+repl('!',60) valid v3_14r()
@ 11,67 get zDATA_REJ  pict '@D'
@ 12,67 get zNUMER_REJ pict '!!!!!!!!!!!'
@ 13,12 get zPRZEDM    pict repl('!',40)
@ 13,57 get zKGN1      pict '!!!!!!!!'
@ 13,70 get zEKD1      pict '!!!!!!!!'
@ 14,14 get zVAT       pict "!" valid zVAT$'TN' .and. vTN(zVAT,14,14)
*@ 15,41 get zVATOKRES  pict "!" when zVAT<>'N' valid zVATOKRES$'MK' .and. vMK(zVATOKRES,15,41)
*@ 15,60 get zVATOKRESDR pict "!" when zVAT<>'N' valid iif(zVATOKRES=='K',zVATOKRESDR$'K',zVATOKRESDR$'MK') .and. vMK(zVATOKRESDR,15,60)
@ 14,39 get zVATFORDR  pict "!!" when wVATFORDR() valid vVATFORDR()
@ 14,67 get zUEOKRES   pict "!" valid zUEOKRES$'MK' .and. vMK(zUEOKRES,14,67)
@ 15,12 get zRYCZALT   pict "!" valid zRYCZALT$'TN' .and. vTN(zRYCZALT,15,12)
@ 15,40 get zRODZNRKS  pict "!" valid zRODZNRKS $ 'MR'
@ 15,75 get zPITOKRES  pict "!" valid zPITOKRES$'MK' .and. vMK(zPITOKRES,15,75)
@ 16,78 get zDATAKS    pict "!" when wDATAKS() valid zDATAKS$'WD' .and. vDATAKS()
@ 17,16 get zHASLO     pict 'XXXXXXXXXX'
@ 17, 42 GET zRodzajDrFV PICTURE '!' WHEN Param_F_VRodzajDrFVW() VALID Param_F_VRodzajDrFVV()
@ 17,75 get zDETAL     pict "!" valid zDETAL$'TN' .and. vTN(zDETAL,17,75)
@ 18,17 GET zAdrEMail  PICTURE "@S27 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
@ 18,70 GET zRodzajFNV PICTURE "!" WHEN Param_F_WRodzajFNV() VALID Param_F_VRodzajFNV()
@ 20,29 get zLICZBA    pict "99999"
@ 21,29 get zLICZBA_WYP picture "99999"
@ 20,56 get zDATA2TYP  pict "!" when wDATA2TYP() valid vDATA2TYP()
@ 21,53 get zNR_FAKT   pict "99999" valid v23_1()
@ 21,62 get zNR_FAKTW  pict "99999" valid v23_1w()
@ 21,73 get zNR_RACH   pict "99999" valid v23_11()
clear type
read_()
*set century on
if lastkey()=27
break
endif
*ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
**************************** lp
if nr_uzytk>=0
if param_lp=[T].and.zliczba#liczba
   CURR=ColInb()
   @ 24,0
   center(24,[Trwa nadawanie liczby porz&_a.dkowej - prosz&_e. czeka&_c....])
   select 3
   do while.not.dostep('OPER')
   enddo
   do SETIND with 'OPER'
   IF param_kslp == '3'
      SET ORDER TO 4
   ENDIF
   do BLOKADA
   seek [+]+ident_fir
   zlp=zliczba
   do while del=[+].and.firma=ident_fir
      repl_([lp],zlp)
      zlp=zlp+1
      zmc := mc
      skip
      IF zRODZNRKS == 'M' .AND. mc # zmc
         zlp := 1
      ENDIF
   enddo
   COMMIT
   unlock
   use
   select 1
   @ 24,0
   center(24,[Trwa nadawanie liczby porz&_a.dkowej - prosz&_e. czeka&_c....])
   select 3
   do while.not.dostep('EWID')
   enddo
   do SETIND with 'EWID'
   do BLOKADA
   seek [+]+ident_fir
   zlp=zliczba
   do while del=[+].and.firma=ident_fir
      repl_([lp],zlp)
      zlp=zlp+1
      zmc := mc
      skip
      IF zRODZNRKS == 'M' .AND. mc # zmc
         zlp := 1
      ENDIF
   enddo
   COMMIT
   unlock
   use
   select 1
   ColStd()
   @ 24,0
   setcolor(CURR)
endif
endif
****************************
do BLOKADAR
repl_([NAZWA_SKR],zNAZWA_SKR)
repl_([NR_REGON],zNR_REGON)
repl_([NR_KONTA],zNR_KONTA)
repl_([BANK],zBANK)
repl_([HASLO],zHASLO)
repl_([SKARB],zSKARB)
repl_([ORGAN],zORGAN)
repl_([REJESTR],zREJESTR)
repl_([DATA_REJ],zDATA_REJ)
repl_([NUMER_REJ],zNUMER_REJ)
repl_([NAZWISKO],zNAZWISKO)
repl_([NIP],zNIP)
repl_([NIPUE],zNIPUE)
repl_([NKP],zNKP)
repl_([ODZUS],zODZUS)
repl_([PRZEDM],zPRZEDM)
repl_([KGN1],zKGN1)
repl_([EKD1],zEKD1)
repl_([NR_FAKT],zNR_FAKT)
repl_([NR_FAKTW],zNR_FAKTW)
repl_([NR_RACH],zNR_RACH)
repl_([LICZBA],zLICZBA)
repl_([LICZBA_WYP],zLICZBA_WYP)
repl_([VAT],zVAT)
*repl_([VATOKRES],zVATOKRES)
*repl_([VATOKRESDR],zVATOKRESDR)
repl_([VATFORDR],zVATFORDR)
repl_([UEOKRES],zUEOKRES)
repl_([PITOKRES],zPITOKRES)
repl_([DETAL],zDETAL)
repl_([RYCZALT],zRYCZALT)
repl_([PARAM_WOJ],zPARAM_WOJ)
repl_([PARAM_POW],zPARAM_POW)
*repl_([FAKT_MIEJ],zFAKT_MIEJ)
repl_([DEKLNAZWI],zDEKLNAZWI)
repl_([DEKLIMIE],zDEKLIMIE)
repl_([DEKLTEL],zDEKLTEL)
repl_([DATAKS],zDATAKS)
repl_([DATA2TYP],zDATA2TYP)
repl_( "RODZNRKS", zRODZNRKS )
repl_( "EMAIL", zAdrEMail )
repl_( "RODZAJDRFV", zRodzajDrFV )
repl_( "RODZAJFNV", zRodzajFNV )

DETALISTA=DETAL
commit_()
unlock
ColSta()
@ 0,0 clear to 0,40
@ 0,3 say iif(zVAT='T','VAT-'+zVATFORDR,'')+iif(zRYCZALT='T','Rycz ','')+iif(zDETAL='T','Det ','')
ColStd()
Firma_RodzNrKs := zRODZNRKS
firma_rodzajdrfv := zRodzajDrFV
*ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
                             end
do &_proc
@ 23,0
*################################### POMOC ##################################
              case kl=28
save screen to scr_
@ 1,47 say [          ]
declare p[20]
*---------------------------------------
p[ 1]='                                             '
p[ 2]='     [M].....................modyfikacja     '
p[ 3]='     [Esc]...................wyj&_s.cie         '
p[ 4]='                                             '
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

return
*################################## FUNKCJE #################################
procedure say23
clear type
set color to +w
*set century off
@ 4,18 say NAZWA_SKR
@ 5,6  say NIP
@ 5,26 say NIPUE
@ 5,47 say substr(NR_REGON,1,11)
@ 5,64 say substr(NKP,1,14)
@ 6,8  say BANK
@ 6,48 say substr(NR_KONTA,1,30)
sele urzedy
go firma->skarb
zURZAD=miejsc_us+' - '+urzad
@ 7,18 say zURZAD
sele firma
@  8,18 say PARAM_WOJ
@  8,48 say PARAM_POW
@  9,48 say NAZWISKO
@ 10,28 say substr(DEKLNAZWI,1,14)
@ 10,49 say substr(DEKLIMIE,1,14)
@ 10,69 say substr(DEKLTEL,1,10)
sele organy
go firma->organ
zNAZWA_ORG=NAZWA_ORG
@ 11,14 say substr(zNAZWA_ORG,1,30)
sele rejestry
go firma->rejestr
zNAZWA_REJ=NAZWA_REJ
@ 12,14 say substr(zNAZWA_REJ,1,30)
sele firma
@ 11,67 say DATA_REJ
@ 12,67 say NUMER_REJ
@ 13,12 say PRZEDM
@ 13,57 say KGN1
@ 13,70 say EKD1
@ 14,14 say iif(VAT='T','Tak','Nie')
*@ 15,41 say iif(VATOKRES='K','Kwa','Mie')
*@ 15,60 say iif(VATOKRESDR='K','Kwa','Mie')
              if VATFORDR=='  '
                 if VATOKRES='K'
*                    if VATOKRESDR='M'
                       zVATFORDR='7K'
*                    else
*                       zVATFORDR='7D'
*                    endif
                 else
                    zVATFORDR='7 '
                 endif
              else
                 zVATFORDR=VATFORDR
              endif
@ 14,39 say zVATFORDR
@ 14,67 say iif(UEOKRES='K','Kwa','Mie')
@ 15,12 say iif(RYCZALT='T','Tak','Nie')
@ 15,40 say RODZNRKS
@ 15,75 say iif(PITOKRES='K','Kwa','Mie')
@ 16,78 say iif(DATAKS='W','W','D')
@ 17,16 say HASLO
@ 17, 42 say iif( rodzajdrfv $ 'GT', rodzajdrfv, 'T' )
@ 17,75 say iif(DETAL='T','Tak','Nie')
@ 18,17 SAY SubStr( EMAIL, 1, 27 )
@ 18,70 SAY iif( RODZAJFNV == 'R', 'Rachunek', 'Faktura ' )
@ 20,29 say dos_l(str(LICZBA,5))
@ 21,29 say dos_l(str(LICZBA_WYP,5))
@ 20,56 say DATA2TYP
@ 20,58 say iif(DATA2TYP='D','dokonanie dost.towar.',iif(DATA2TYP='T','zakonczenie dost.tow.',iif(DATA2TYP='U','wykonanie uslugi     ',iif(DATA2TYP='Z','zaliczka             ','dokonanie dost.towar.'))))
@ 21,53 say dos_l(str(NR_FAKT,5))
@ 21,62 say dos_l(str(NR_FAKTW,5))
@ 21,73 say dos_l(str(NR_RACH,5))
*@ 21,56 say FAKT_MIEJ
*@ 24,0 say padc('Wpisz:D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka',80,' ')
*set century on
ColStd()
return
***************************************************
function v23_11
if lastkey()=5
return .t.
endif
return zNR_RACH>0
***************************************************
function v23_1
if lastkey()=5
return .t.
endif
return zNR_FAKT>0
***************************************************
function v23_1w
if lastkey()=5
return .t.
endif
return zNR_FAKTW>0
***************************************************
function v23_2
if lastkey()=5
return .t.
endif
return zLICZBA>0
***************************************************
function v23_22
if lastkey()=5
return .t.
endif
return zLICZBA_WYP>0
***************************************************
func vTN
para ZM,WI,KO
@ WI,KO+1 say iif(ZM='T','ak','ie')
return .t.
***************************************************
func vMK
para ZM,WI,KO
@ WI,KO+1 say iif(ZM='K','wa','ie')
return .t.
***************************************************
*func wVATFORDR
*@ 24,0 say padc('Wpisz 7 - VAT-7, 7K - VATW - podpowiada&_c. dat&_e. wp&_l.ywu lub D - dat&_e. wystawienia dokumentu',80,' ')
*if zVATOKRES='M'
*   if zVATOKRESDR='M'
*      zVATFORDR='7 '
*   else
*      zVATFORDR='7D'
*   endif
*else
*   zVATFORDR='7K'
*endif
*return .f.
***************************************************
func wVATFORDR
ColInf()
@ 24,0 say padc('Wpisz "7 " - VAT-7, "7K" - VAT-7K lub "8 " - VAT-8',80,' ')
ColStd()
return .t.
***************************************************
func vVATFORDR
R=.t.
if zVATFORDR<>'7 '.and.zVATFORDR<>'7K'.and.zVATFORDR<>'8 '
   ColInf()
   @ 24,0 say padc('Wpisz "7 " - VAT-7, "7K" - VAT-7K lub "8 " - VAT-8',80,' ')
   ColStd()
   R=.f.
else
   @ 24,0 clear
endif
return R
***************************************************
func wDATA2TYP
ColInf()
@ 24,0 say padc('Wpisz:D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka',80,' ')
ColStd()
return .t.
***************************************************
func vDATA2TYP
R=.t.
if zDATA2TYP<>'D'.and.zDATA2TYP<>'T'.and.zDATA2TYP<>'U'.and.zDATA2TYP<>'Z'
   ColInf()
   @ 24,0 say padc('Wpisz:D-dokonanie dostawy,T-zakonczenie dostawy,U-wykonanie uslugi,Z-zaliczka',80,' ')
   ColStd()
   R=.f.
else
   @ 20,58 say iif(zDATA2TYP='D','dokonanie dost.towar.',iif(zDATA2TYP='T','zakonczenie dost.tow.',iif(zDATA2TYP='U','wykonanie uslugi     ',iif(zDATA2TYP='Z','zaliczka             ','dokonanie dost.towar.'))))
   @ 24,0 clear
endif
return R
***************************************************
function v3_14f
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
   @ 7,18 say zurzad
   set color to
   pause(.5)
endif
select firma
return .not.empty(zurzad)
***************************************************
function v3_14o
if lastkey()=5
   return .t.
endif
save screen to scr2
select organy
seek [+]+znazwa_org
if del#[+].or.nazwa_org#znazwa_org
   skip -1
endif
organy_()
restore screen from scr2
if lastkey()=13 .OR. LastKey() == 1006
   znazwa_org=nazwa_org
   set color to i
   @ 11,14 say substr(znazwa_org,1,30)
   set color to
   pause(.5)
endif
select firma
return .not.empty(znazwa_org)
***************************************************
function v3_14r
if lastkey()=5
   return .t.
endif
save screen to scr2
select rejestry
seek [+]+znazwa_rej
if del#[+].or.nazwa_rej#znazwa_rej
   skip -1
endif
rejestr_()
restore screen from scr2
if lastkey()=13 .OR. LastKey() == 1006
   znazwa_rej=nazwa_rej
   set color to i
   @ 12,14 say substr(znazwa_rej,1,30)
   set color to
   pause(.5)
endif
select firma
return .not.empty(znazwa_rej)
***************************************************
function vf_nazw
if lastkey()=5
   return .t.
endif
save screen to scr2
select spolka
seek [+]+ident_fir+znazwisko
if del#[+].or.firma#ident_fir.or.naz_imie#znazwisko
   seek [+]+ident_fir
   if .not. found()
      restore screen from scr2
      sele firma
      return .f.
   endif
endif
wlas_()
restore screen from scr2
if lastkey()=13 .OR. LastKey() == 1006
   znazwisko=naz_imie
   set color to i
   @  9,48 say zNAZWISKO
   set color to
   pause(.5)
endif
select firma
return .not.empty(znazwisko)
****************************************************************************
function wnipue
if len(alltrim(zNIPUE))=0
   zNIPUE='PL-'+strtran(zNIP,'-','')
endif
return .t.
***************************************************
function wDATAKS
ColInf()
@ 24,0 say padc('Wpisz W - podpowiada&_c. dat&_e. wp&_l.ywu lub D - dat&_e. wystawienia dokumentu',80,' ')
ColStd()
return .t.
***************************************************
function vDATAKS
@ 24,0 clear
return .t.
*############################################################################

FUNCTION Param_F_VRodzajDrFVW()

   LOCAL lRes := .T.
   LOCAL cKolor := ColInf()

   @ 24, 0 SAY PadC( "Rodzaj wydruku faktury: G - graficznu   T - tekstowy", 80 )
   SetColor( cKolor )

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Param_F_VRodzajDrFVV()

   LOCAL lRes := zRodzajDrFV $ 'GT'

   IF lRes
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Param_F_WRodzajFNV()

   LOCAL lRes
   LOCAL cKolor

   IF ( lRes := zVAT <> 'T' )
      cKolor := ColInf()
      @ 24, 0 SAY PadC( "F - faktura             R - rachunek", 80 )
      SetColor( cKolor )
   ELSE
      zRodzajFNV := 'F'
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION Param_F_VRodzajFNV()

   LOCAL lRes

   IF ( lRes := zRodzajFNV $ 'FR' )
      SET COLOR TO +w
      @ 18, 70 SAY iif( zRodzajFNV == 'R', 'Rachunek', 'Faktura ' )
      ColStd()
      @ 24, 0
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

