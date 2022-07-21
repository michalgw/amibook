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

#include "achoice.ch"
#include "inkey.ch"

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
store 0 to zBRUT_ZASAD,;
           zBRUT_PREMI,;
           zDOPL_OPOD ,;
           zDOPL_BZUS ,;
           zKOSZT     ,;
           zSTAW_PUE  ,;
           zSTAW_PUR  ,;
           zSTAW_PUC  ,;
           zSTAW_PF3  ,;
           zSTAW_PSUM ,;
           zWAR_PUE   ,;
           zWAR_PUR   ,;
           zWAR_PUC   ,;
           zzWAR_PUE   ,;
           zzWAR_PUR   ,;
           zzWAR_PUC   ,;
           zWAR_PF3   ,;
           zWAR_PSUM  ,;
           zzWAR_PSUM  ,;
           zODLICZ    ,;
           zSTAW_PODAT,;
           zSTAW_PUZ  ,;
           zWAR_PUZ   ,;
           zSTAW_PZK  ,;
           zWAR_PUZB  ,;
           zWAR_PZKB  ,;
           zWAR_PUZO  ,;
           zDOPL_NIEOP,;
           zODL_NIEOP ,;
           zSTAW_FUE  ,;
           zSTAW_FUR  ,;
           zSTAW_FUW  ,;
           zSTAW_FFP  ,;
           zSTAW_FFG  ,;
           zSTAW_FSUM ,;
           zzWAR_FUE   ,;
           zzWAR_FUR   ,;
           zzWAR_FUW   ,;
           zzWAR_FFP   ,;
           zzWAR_FFG   ,;
           zWAR_FUE   ,;
           zWAR_FUR   ,;
           zWAR_FUW   ,;
           zWAR_FFP   ,;
           zWAR_FFG   ,;
           zzWAR_FSUM  ,;
           zWAR_FSUM  ,;
           zZASIL_RODZ,;
           zZASIL_PIEL,;
           zILOSO_RODZ,;
           zILOSO_PIEL,;
           zWYMIARL   ,;
           zWYMIARM   ,;
           zDNI_CHOROB,;
           zSTA_CHOROB,;
           zODL_CHOROB,;
           zIL_DNI_ROB,;
           zDNI_BEZPL ,;
           zSTA_BEZPL ,;
           zODL_BEZPL ,;
           zBRUTTO6   ,;
           zPRO_ZASCHO,;
           zDNI_ZASCHO,;
           zSTA_ZASCHO,;
           zDOP_ZASCHO,;
           zPRO_ZASC20,;
           zDNI_ZASC20,;
           zSTA_ZASC20,;
           zDOP_ZASC20,;
           zIL_MIE6   ,;
           zDNI_ZAS100,;
           zSTA_ZAS100,;
           zDOP_ZAS100,;
           zZUS_ZASCHO,;
           zZUS_PODAT ,;
           zZUS_RKCH  ,;
           zBRUT_RAZEM,;
           zDOCHOD    ,;
           zDOCHODPOD ,;
           zPENSJA    ,;
           zPODATEK   ,;
           zNETTO     ,;
           zDO_WYPLATY,;
           zUWAGI     ,;
           B5         ,;
           B61        ,;
           B62        ,;
           EDI        ,;
           zKW_PRZELEW,;
           zPRZEL_NAKO,;
           zPPKZS1    ,;
           zPPKZK1    ,;
           zPPKZS2    ,;
           zPPKZK2    ,;
           zPPKPS1    ,;
           zPPKPK1    ,;
           zPPKPS2    ,;
           zPPKPK2    ,;
           zPPKPPM    ,;
           zZASI_BZUS ,;
           zULGAKLSRK ,;
           zPODNIEP   ,;
           zWAR_PUZW
*           zNADPL_KWO
*           zZAOPOD    ,;
zJAKI_PRZEL=' '
*zJAKZAO='Z'
zKOD_KASY='   '
zKOD_TYTU='      '
*zNADPL_SPO='N'
zSTANOWISKO=space(40)
zOSWIAD26R := ' '
zPPK := iif( etaty->ppk $ 'TN', etaty->ppk, 'N' )
zULGAKLSRA := ' '
zODLICZENIE := ' '
zWNIOSTERM := ' '

//002 ostatnia zmienna jest nowa

mmm=array(12)
mmm[1] :='1 - Stycze&_n.     '
mmm[2] :='2 - Luty        '
mmm[3] :='3 - Marzec      '
mmm[4] :='4 - Kwiecie&_n.    '
mmm[5] :='5 - Maj         '
mmm[6] :='6 - Czerwiec    '
mmm[7] :='7 - Lipiec      '
mmm[8] :='8 - Sierpie&_n.    '
mmm[9] :='9 - Wrzesie&_n.    '
mmm[10]:='P - Pa&_x.dziernik '
mmm[11]:='L - Listopad    '
mmm[12]:='G - Grudzie&_n.    '
*################################# GRAFIKA ##################################
@  3,0 clea to 22,79
CURR=ColStd()
@  3, 0 say '        K A R T O T E K I   W Y N A G R O D Z E &__N.   P R A C O W N I K &__O. W       '
@  5, 0 say 'Stanowisko:                                         Kod RKCh:     Wymiar:   /   '
@  6, 0 say 'Wykszta&_l.cenie:'
@  6,56 say 'Kod tytu&_l.u ubezp:'
@  7,0 to 7,79
*@  7,19 say 'Sposob zaokraglania podatku ? '
@  8,19 say 'Przychody opodatkowane =           III filar (PPE) =         '
@  9,19 say 'Nieobecno&_s.ci w pracy                                         '
@ 10,19 say 'Za dni przepracowane   =                                     '
@ 11,19 say 'Za chorobowe(do 33dni) =           Przych&_o.d brutto =         '
@ 12,19 say 'Koszt uzyskania        =           Podstawa sk&_l.adek=         '
@ 13,19 say 'Sk&_l.adki na ubezpieczen.=           Podstawa podatku=         '
@ 14,19 say 'Pracownicze plany kapit=           Doch&_o.d netto    =         '
//002 podniesiona wyplata i dwie nowe pozycje
@ 15,19 say 'Podatek+Ubezp.Zdrowotne=           DO WYP&__L.ATY      =         '
@ 16,19 say 'Zasi&_l.ki z ZUS          =           w tym przelew   =         '
@ 17,19 say 'Dopl.i potrac.po opodat=           got&_o.wka         =         '
@ 18,19 say '-------------------------------------------------------------'
@ 19,19 say 'Sk&_l.adki na ZUS         =           (     %)                  '
@ 20,19 say 'Wyp&_l.aty z ZUS          =           RKCH=       podat.=       '
@ 22,0 say  ' UWAGI:                                                     '
set colo to w+
@  4, 0 say padc(alltrim(nazwisko)+' '+alltrim(imie1)+' '+alltrim(imie2),80)
@  6,15 say WYKSZTALC
CURR=ColStd()
miesiacpla='  '
skladn=1
do while .t.
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
   sele etaty
   miesiacpla=iif(miesiacpla=[  ],aktualny,miesiacpla)
   mmc=val(miesiacpla)
*   @  7,0 to 7,79
   @ 21,18 to 21,79
   ColPro()
   @  8,0 to 21,17
   keyb chr(32)
   miesiacpla=str(achoice(9,1,20,16,mmm,.t.,"infoplac",mmc),2)
   ColStd()
   do case
   case lastkey()=27
        exit
   case lastkey()=77.or.lastkey()=109
        do podstaw
        save scre to scr_sklad
        set curs on
        @  5,11 get zSTANOWISKO pict repl('X',40)
        @  5,61 get zKOD_KASY pict '99!' valid iif(len(alltrim(zKOD_KASY))>0.and.len(alltrim(zKOD_KASY))<3,.f.,.t.)
        @  5,73 get zWYMIARL  pict '999'
        @  5,77 get zWYMIARM  pict '999'
        @  6,73 get zKOD_TYTU pict '999999' valid iif(len(alltrim(zKOD_TYTU))>0.and.len(alltrim(zKOD_TYTU))<6,.f.,.t.)
        @ 22,8  get zUWAGI
        read
        set curs off
        rest scre from scr_sklad
         if lastkey()#27
            oblpl()
            do BLOKADAR
            do zapiszpla
            COMMIT
            unlock
            _infoskl_()
         endif
   case lastkey()=13

*        @ 17,39 get zNADPL_SPO pict '!' when wNADPL() valid zNADPL_SPO$'NZD'.and.vNADPL()
*        set curs on
*        @ 7,49 get zJAKZAO pict '!' when wJAKZAO(7,50) valid vJAKZAO(7,50)
*         when wJAKZAO() valid zJAKZAO$'ZD'.and.vJAKZAO()
*        read
*        set curs off
*        rest scre from scr_sklad
*        if lastkey()#27
*           if zJAKZAO='Z'
*              zZAOPOD=0
*           else
*              zZAOPOD=1
*           endif
*           oblpl()
*           do BLOKADAR
*           do zapiszpla
*           unlock
*           _infoskl_()
*        endif
      save scre to scr_sklad
      zSTAWKAPODAT21 := 17
      SET KEY K_CTRL_F10 TO Etaty1_UstawWewPar
      do while .t.
         IF ! Empty( prac->data_zwol ) .AND. prac->data_zwol < hb_Date( Val( param_rok ), Val( miesiacpla ), 1 )
            IF ! TNEsc( , 'Pracownik jest ju¾ zwolniony. Czy kontynuowa†? (T/N)' )
               EXIT
            ENDIF
         ENDIF
         do podstaw
         edi=0
         set color to /w
         @ 8+val(miesiacpla),1 say mmm[val(miesiacpla)]
         ColStd()
         @  8,18 prompt ' Przychody opodatkowane '
         @  9,18 prompt ' Nieobecno&_s.ci w pracy   '
         @ 10,18 prompt ' Za dni przepracowane   '
         @ 11,18 prompt ' Za chorobowe(do 33dni) '
         @ 12,18 prompt ' Koszt uzyskania        '
         @ 13,18 prompt ' Sk&_l.adki na ubezpieczen.'
         @ 14,18 prompt ' Pracownicze plany kapit'
         @ 15,18 prompt ' Podatek+Ubezp.Zdrowotne'
         @ 16,18 prompt ' Zasi&_l.ki z ZUS          '
         @ 17,18 prompt ' Dop&_l..i potr&_a.c.po opodat'
//002 nowa linia
*         @ 17,18 prompt ' Rozlicz.roku ubieg&_l..'
         @ 19,18 prompt ' Sk&_l.adki na ZUS         '
         @ 20,18 prompt ' Wyp&_l.aty z ZUS          '
         @  8,53 prompt ' III filar (PPE) '
         @ 16,53 prompt ' w tym przelew '
         skladn=menu(skladn)
         ColStd()
         if lastkey()=27
            exit
         endif
         do podstaw
         do case
         case skladn=1
              save scre to scr_sklad
              set curs on
              @  7,42 clear to 13,68
              @  7,42 to 13,68
              @  8,43 say 'Zasadnicza.....:' get zBRUT_ZASAD pict '99999.99' valid oblpl()
              @  9,43 say 'Premia.........:' get zBRUT_PREMI pict '99999.99' valid oblpl()
              @ 10,43 say 'Inne dodatki...:' get zDOPL_OPOD  pict '99999.99' valid oblpl()
              @ 11,43 say 'Inne bez ZUS...:' get zDOPL_BZUS  pict '99999.99' valid oblpl()
              @ 12,43 say 'Zasiˆki bez ZUS:' get zZASI_BZUS  pict '99999.99' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
         case skladn=2
              save scre to scr_sklad
              do nieobec
              sele etaty
              rest scre from scr_sklad
         case skladn=3
              save scre to scr_sklad
              set curs on
              @  9,38 clear to 18,79
              @  9,38 to 18,79
              @ 10,39 say 'ZWOLNIENIA P&__L.ATNE,OPIEKA,itp'
              @ 11,39 say 'Liczba dni zwolnienia w mies..:' get zDNI_CHOROB pict '99' when oblpl().and..f.
              @ 12,39 say 'Potr&_a.cenie za okres zwolnienia:' get zODL_CHOROB pict '99999.99' valid oblpl()
              @ 13,39 say 'NIEOBECNO&_S.CI NIEP&__L.ATNE'
              @ 14,39 say 'Ilo&_s.&_c. dni roboczych w miesi&_a.cu:' get zIL_DNI_ROB pict '99' valid oblpl()
              @ 15,39 say 'Ilo&_s.&_c. dni rob.nieobecn. w m-cu:' get zDNI_BEZPL  pict '99' valid oblpl()
              @ 16,39 say 'Stawka za 1 dzie&_n. urlopu......:' get zSTA_BEZPL  pict '99999.99' when oblpl().and..f.
              @ 17,39 say 'Potr&_a.cenie za okres urlopu....:' get zODL_BEZPL  pict '99999.99' when oblpl().and..f.
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
         case skladn=4
              save scre to scr_sklad
              set curs on
              @  7,37 clear to 19,79
              @  7,37 to 19,79
              if zPRO_ZASCHO=0
                 zPRO_ZASCHO=parap_cho
              endif
              @  8,38 say 'Zarobki z okresu do wyliczen...:' get zBRUTTO6    pict '99999.99' valid oblpl()
              @  9,38 say 'Ilo&_s.&_c. miesi&_e.cy w/w okresu......:' get zIL_MIE6 pict '99' valid oblpl()
              @ 10,38 say 'Dni do zasi&_l.ku z zak&_l.adu (  %).:'
              @ 13,38 say 'Dni do zasi&_l.ku z zak&_l.adu (  %).:'
              @ 10,64 get zPRO_ZASCHO pict '99'
              @ 10,71 get zDNI_ZASCHO pict '99' valid oblpl()
              @ 13,64 get zPRO_ZASC20 pict '99'
              @ 13,71 get zDNI_ZASC20 pict '99' valid oblpl()
              @ 11,38 say 'Stawka za 1 dzie&_n. choroby......:' get zSTA_ZASCHO pict '99999.99' when oblpl().and..f.
              @ 12,38 say 'Zasi&_l.ek chorobowy z zak&_l.adu....:' get zDOP_ZASCHO pict '99999.99' when oblpl().and..f.
              @ 14,38 say 'Stawka za 1 dzie&_n. choroby......:' get zSTA_ZASC20 pict '99999.99' when oblpl().and..f.
              @ 15,38 say 'Zasi&_l.ek chorobowy z zak&_l.adu....:' get zDOP_ZASC20 pict '99999.99' when oblpl().and..f.
              @ 16,38 say 'Dni do zasi&_l.ku z zak&_l.adu (100%):' get zDNI_ZAS100 pict '99' when oblpl().and..f.
              @ 17,38 say 'Stawka za 1 dzie&_n. choroby......:' get zSTA_ZAS100 pict '99999.99' when oblpl().and..f.
              @ 18,38 say 'Zasi&_l.ek chorobowy z zak&_l.adu....:' get zDOP_ZAS100 pict '99999.99' when oblpl().and..f.
*             @ 10,38 get 'Dni do zasi&_l.ku z zak&_l.adu (  %).:' get zDNI_ZASCHO pict '99' when oblpl().and..f.
*             @ 13,38 say 'Dni do zasi&_l.ku z zak&_l.adu (  %).:' get zDNI_ZASCHO pict '99' when oblpl().and..f.
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
         case skladn=5
              save scre to scr_sklad
              set curs on
              @ 12,43 get zKOSZT pict ' 99999.99' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
         case skladn=6
              EDI=1
              save scre to scr_sklad
              set curs on
              @ 12,42 clear to 18,77
              @ 12,42 to 18,77
              @ 13,43 say 'SK&__L.ADKI    %stawki oblicz. ksi&_e.gow'
              @ 14,43 say 'Emerytalna ' get zSTAW_PUE pict '99.99' valid OBLPL()
              @ 14,70 get zWAR_PUE pict '9999.99' valid OBLPL()
              @ 15,43 say 'Rentowa    ' get zSTAW_PUR pict '99.99' valid OBLPL()
              @ 15,70 get zWAR_PUR pict '9999.99' valid OBLPL()
              @ 16,43 say 'Chorobowa  ' get zSTAW_PUC pict '99.99' valid OBLPL()
              @ 16,70 get zWAR_PUC pict '9999.99' valid OBLPL()
              @ 17,43 say 'RAZEM      ' get B61 pict '99.99' when oblpl().and..f.
              @ 17,70 get zWAR_PSUM pict '9999.99' when .f.
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
              EDI=0
         case skladn=7
              save scre to scr_sklad
              set curs on
              @ 11,42 clear TO 21,79
              @ 11,42 TO 21,79
              @ 12,44 say 'Udziaˆ pracownika w PPK' get zPPK pict '!' valid Eval( { || zPPK $ 'TN' } ) .AND. OBLPL()
              @ 13,44 say 'WPATY PRACOWNIKA'
              @ 14,44 say 'Podst. stawka' get zPPKZS1 pict '99.99' when zPPK == 'T' valid OBLPL()
              @ 14,63 say '% kwota' get zPPKZK1 pict '9999.99' when zPPK == 'T' .AND. OBLPL() .AND. .F.
              @ 15,44 say 'Dodat. stawka' get zPPKZS2 pict '99.99' when zPPK == 'T' valid OBLPL()
              @ 15,63 say '% kwota' get zPPKZK2 pict '9999.99' when zPPK == 'T' .AND. OBLPL() .AND. .F.
              @ 16,44 say 'WPATY PRACODAWCY'
              @ 17,44 say 'Podst. stawka' get zPPKPS1 pict '99.99' when zPPK == 'T' valid OBLPL()
              @ 17,63 say '% kwota' get zPPKPK1 pict '9999.99' when zPPK == 'T' .AND. OBLPL() .AND. .F.
              @ 18,44 say 'Dodat. stawka' get zPPKPS2 pict '99.99' when zPPK == 'T' valid OBLPL()
              @ 18,63 say '% kwota' get zPPKPK2 pict '9999.99' when zPPK == 'T' .AND. OBLPL() .AND. .F.
              @ 20,44 say 'Dolicz do podstawy opodat.' get zPPKPPM pict '9999.99' when Eval( { || zPPKPPM := zPPKPK1 + zPPKPK2, .T. } ) valid OBLPL()
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
         case skladn=8
              save scre to scr_sklad
              set curs on
              @ 10,42 clear to 21,79
              @ 10,42 to 21,79
              ValidTakNie( zOSWIAD26R, 11, 72 )
              ValidTakNie( zULGAKLSRA, 12, 64 )
              ValidTakNie( zODLICZENIE, 14, 67 )
              @ 11,43 say 'O˜w. o zwol. od pod.<26 r.:' GET zOSWIAD26R PICTURE '!' /*WHEN CzyPracowPonizej26R( Val( miesiacpla ), Val( param_rok ) )*/ VALID ValidTakNie( zOSWIAD26R, 11, 72 ) .AND. oblpl()
              @ 12,43 say 'Ulga klasy ˜redniej' GET zULGAKLSRA PICTURE '!' WHEN Param_PPla_param( 'aktuks', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) VALID ValidTakNie( zULGAKLSRA, 12, 64 ) .AND. oblpl()
              @ 12,71 GET zULGAKLSRK picture '99999.99' when oblpl() .AND. .F.
              @ 13,43 say 'Podatek stawka..........%.='
              @ 13,62 get zSTAW_PODAT pict '99.99' valid oblpl()
              @ 13,71 get B5          pict '99999.99' when oblpl().and..f.
              @ 14,43 say 'Odliczenie od dochodu.' GET zODLICZENIE picture '!' valid ValidTakNie( zODLICZENIE, 14, 67 ) .AND. oblpl()
              @ 14,71 get zODLICZ     pict '99999.99' valid oblpl()
              @ 15,43 say 'Na ubezp.zdrowotne do ZUS  '
              @ 16,43 say 'obliczono:     % ='
              @ 16,53 get zSTAW_PUZ pict '99.99' valid oblpl()
              @ 16,61 get zWAR_PUZB pict '99999.99' when oblpl().and..f.
              @ 17,43 SAY 'Przedˆu¾enie terminu poboru' GET zWNIOSTERM WHEN Param_PPla_param( 'aktpterm', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) PICTURE '!' VALID ValidTakNie( zWNIOSTERM, 17, 72 ) .AND. oblpl()
              @ 18,43 say 'do pobrania na ZUS........='
              @ 18,71 get zWAR_PUZ  pict '99999.99' when oblpl().and..f.
              *@ 16,43 say 'Do odliczenia od podatku   '
              *@ 17,43 say 'obliczono:     % ='
              *@ 17,53 get zSTAW_PZK pict '99.99' valid oblpl()
              *@ 17,61 get zWAR_PZKB pict '99999.99' when oblpl().and..f.
              *@ 18,43 say 'Z tego odliczono od podat.:' get zWAR_PUZO   pict '99999.99' when oblpl().and..f.
              @ 19,71 say '========'
              @ 20,43 say 'Podatek do zap&_l.aty........:' get zPODATEK    pict '99999.99' when oblpl().and..f.
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
         case skladn=9
              save scre to scr_sklad
              set curs on
              @ 15,37 clear to 18,79
              @ 15,37 to 18,79
              @ 16,38 say 'Zasi&_l.ek rodzinny.....          dla   os&_o.b'
              @ 16,60 get zZASIL_RODZ pict '99999.99' valid oblpl()
              @ 16,73 get zILOSO_RODZ pict '9' valid oblpl()
              @ 17,38 say 'Zasi&_l.ek piel&_e.gnacyjny          dla   os&_o.b'
              @ 17,60 get zZASIL_PIEL pict '99999.99' valid oblpl()
              @ 17,73 get zILOSO_PIEL pict '9' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
         case skladn=10
              save scre to scr_sklad
              set curs on
              @ 16,42 clear to 19,76
              @ 16,42 to 19,76
              @ 17,43 say 'Dop&_l.aty nieopodatkowane:' get zDOPL_NIEOP pict '99999.99' valid oblpl()
              @ 18,43 say 'Potr&_a.cenia po opodatkow:' get zODL_NIEOP pict '99999.99' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
*         case skladn=10
*              save scre to scr_sklad
*              set curs on
*              @ 17,39 get zNADPL_SPO pict '!' when wNADPL() valid zNADPL_SPO$'NZD'.and.vNADPL()
*              @ 17,43 get zNADPL_KWO pict ' 99999.99' when wNADPLKW()
*              read
*              set curs off
*              rest scre from scr_sklad
//002 nowy case, nast©pne numery +1
         case skladn=11
              EDI=1
              save scre to scr_sklad
              set curs on
              @ 12,42 clear to 21,77
              @ 12,42 to 21,77
              @ 13,43 say 'SK&__L.ADKI    %stawki oblicz. ksi&_e.gow'
              @ 14,43 say 'Emerytalna ' get zSTAW_FUE pict '99.99' valid OBLPL()
              @ 14,70 get zWAR_FUE pict '9999.99' valid OBLPL()
              @ 15,43 say 'Rentowa    ' get zSTAW_FUR pict '99.99' valid OBLPL()
              @ 15,70 get zWAR_FUR pict '9999.99' valid OBLPL()
              @ 16,43 say 'Wypadkowa  ' get zSTAW_FUW pict '99.99' valid OBLPL()
              @ 16,70 get zWAR_FUW pict '9999.99' valid OBLPL()
              @ 17,43 say 'FUNDUSZE   %stawki  warto&_s.&_c.'
              @ 18,43 say 'Pracy      ' get zSTAW_FFP pict '99.99' valid OBLPL()
              @ 18,70 get zWAR_FFP pict '9999.99' valid OBLPL()
              @ 19,43 say 'G&__S.P        ' get zSTAW_FFG pict '99.99' valid OBLPL()
              @ 19,70 get zWAR_FFG pict '9999.99' valid OBLPL()
              @ 20,43 say 'RAZEM      ' get zSTAW_FSUM pict '99.99' when oblpl().and..f.
              @ 20,70 get zWAR_FSUM pict '9999.99' when .f.
              read
              inkey(0)
              set curs off
              rest scre from scr_sklad
              EDI=0
         case skladn=12
              save scre to scr_sklad
              set curs on
              @ 20,43 get zZUS_ZASCHO pict ' 99999.99' valid oblpl()
              @ 20,59 get zZUS_RKCH   pict '999.99' valid oblpl()
              @ 20,73 get zZUS_PODAT  pict '999.99' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
         case skladn=13
              save scre to scr_sklad
              set curs on
*             @ 8,64 get zSTAW_PF3 pict '9' valid OBLPL()
              @ 8,74 get zWAR_PF3 pict '999.99' valid oblpl()
              read
              set curs off
              rest scre from scr_sklad
         case skladn=14
              save scre to scr_sklad
              set curs on
              @ 16,71 get zPRZEL_NAKO pict ' 99999.99' valid spr_przel().and.oblpl()
              @ 17,71 say zDO_WYPLATY-zPRZEL_NAKO pict '99 999.99'
              read
              set curs off
              rest scre from scr_sklad
         endcase
         if lastkey()#27.or.skladn=2
            oblpl()
            do BLOKADAR
            do ZAPISZPLA
            COMMIT
            unlock
         endif
         _infoskl_()
      enddo
*      @  7,49 say iif(ZAOPOD=1,'Dziesiec groszy','Zlotowka       ')
      @  8,18 say ' Przychody opodatkowane '
      @  8,53 say ' III filar (PPE) '
      @  9,18 say ' Nieobecno&_s.ci w pracy   '
      @ 10,18 say ' Za dni przepracowane   '
      @ 11,18 say ' Za chorobowe(do 33dni) '
      @ 12,18 say ' Koszt uzyskania        '
      @ 13,18 say ' Sk&_l.adki na ubezpieczen.'
      @ 14,18 say ' Pracownicze plany kapit'
      @ 15,18 say ' Podatek+Ubezp.Zdrowotne'
      @ 16,18 say ' Zasi&_l.ki z ZUS          '
      @ 17,18 say ' Dop&_l..i potr&_a.c.po opodat'
//002 nowa linia
      @ 16,53 say ' w tym przelew     '
*      @ 17,18 say ' Rozlicz.roku ubieg&_l..'
*      ColInf()
*      @ 17,39 say iif(NADPL_SPO='N','Nad',iif(NADPL_SPO='Z','Zwr','Dod'))
*      ColStd()
      @ 19,18 say ' Sk&_l.adki na ZUS         '
      @ 20,18 say ' Wyp&_l.aty z ZUS          '

      SET KEY K_CTRL_F10 TO

   endcase
enddo
sele prac
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± INFOplac  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o placach  miesiecznie                               ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
function infoplac(nMode,nCurEl,nRowPos)
   local nRetVal:=AC_CONT
   local nKey:=lastkey()

   do case
   case nMode==AC_IDLE
        infoskl(str(nCurEl,2))
        nRetVal:=AC_CONT
   case nMode==AC_EXCEPT
        do case
        case nKey=13.or.nKey=77.or.nKey=109
             nRetVal:=AC_SELECT
        case nKey=27
             nRetVal:=AC_ABORT
        other
             nRetVal:=AC_GOTO
        endcase
   endcase
return nRetVal
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± infoskl  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o skladnikach placowych                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func infoskl(nCurEl)
     sele prac
     zident=rec_no
     sele etaty
     seek [+]+ident_fir+str(zident,5)+nCurEl
     _infoskl_()
return
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± _infoskl_  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Wyswietla informacje o skladnikach placowych                              ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
func _infoskl_
     store 0 to wolI,wolU,wolC,wolO,wolW,wolB,wolM,choC,wolZ,choZ,wolN
     _zident_=str(prac->rec_no,5)
     _bot_=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#etaty->mc]
     _bot_1=[del#'+'.or.firma#ident_fir.or.ident#_zident_]
     sele nieobec
     seek [+]+ident_fir+_zident_+etaty->mc
     if found()
        do while .not.&_bot_
           do case
           case substr(PRZYCZYNA,1,1)='I'
                wolI=wolI+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='U'
                wolU=wolU+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='C'
                wolC=wolC+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='Z'
                wolZ=wolZ+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='O'
                wolO=wolO+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='W'
                wolW=wolW+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='B'
                wolB=wolB+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='M'
                wolM=wolM+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='N'
                wolN=wolN+((dddo-ddod)+1)
           endcase
           skip
        enddo
     endif
     sele etaty
     CURR=ColStd()
     set color to w+
      zzWAR_PUE=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_PUE/100),2)
      zzWAR_PUR=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_PUR/100),2)
      zzWAR_PUC=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_PUC/100),2)
      zzWAR_PSUM=zzWAR_PUE+zzWAR_PUR+zzWAR_PUC
      zzWAR_FUE=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_FUE/100),2)
      zzWAR_FUR=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_FUR/100),2)
      zzWAR_FUW=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_FUW/100),2)
      zzWAR_FFP=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_FFP/100),2)
      zzWAR_FFG=_round((PENSJA-DOPL_BZUS - ZASI_BZUS)*(STAW_FFG/100),2)
      zzWAR_FSUM=zzWAR_FUE+zzWAR_FUR+zzWAR_FUW+zzWAR_FFP+zzWAR_FFG
     @  5,11 say STANOWISKO
     @  5,61 say KOD_KASY
     @  5,73 say WYMIARL
     @  5,77 say WYMIARM
     @  6,73 say KOD_TYTU
*     @  7,49 say iif(ZAOPOD=1,'Dziesiec groszy','Zlotowka       ')
     @  8,43 say BRUT_ZASAD+BRUT_PREMI+DOPL_OPOD+DOPL_BZUS+ZASI_BZUS pict '99 999.99'
     @  8,74 say WAR_PF3 pict '999.99'
     @  9,42 say padr(iif(wolU#0,'U='+alltrim(str(wolU,2))+' ','')+;
                      iif(wolC#0,'C='+alltrim(str(wolC,2))+' ','')+;
                      iif(wolZ#0,'Z='+alltrim(str(wolZ,2))+' ','')+;
                      iif(wolO#0,'O='+alltrim(str(wolO,2))+' ','')+;
                      iif(wolB#0,'B='+alltrim(str(wolB,2))+' ','')+;
                      iif(wolM#0,'M='+alltrim(str(wolM,2))+' ','')+;
                      iif(wolW#0,'W='+alltrim(str(wolW,2))+' ','')+;
                      iif(wolN#0,'N='+alltrim(str(wolN,2))+' ','')+;
                      iif(wolI#0,'I='+alltrim(str(wolI,2))+' ',''),37)
     @ 10,43 say PENSJA+WAR_PF3 pict '99 999.99'
     @ 11,43 say DOP_ZASCHO+DOP_ZASC20+DOP_ZAS100 pict '99 999.99'
     @ 11,71 say BRUT_RAZEM pict '99 999.99'
     @ 12,43 say KOSZT pict '99 999.99'
     @ 12,71 say PENSJA-DOPL_BZUS - ZASI_BZUS pict '99 999.99'
     if str(zzWAR_PSUM,7,2)#str(WAR_PSUM,7,2)
        ColErr()
     endif
     @ 13,43 say WAR_PSUM pict '99 999.99'
     set color to w+
     @ 13,71 say DOCHODPOD pict '99 999.99'
     @ 14,43 say PPKPK1 + PPKPK2 + PPKZK1 + PPKZK2 pict '99 999.99'
     @ 14,71 say NETTO pict '99 999.99'
     @ 15,43 say PODATEK+WAR_PUZ pict '99 999.99'
     @ 16,43 say ZASIL_RODZ+ZASIL_PIEL pict '99 999.99'
     @ 17,43 say DOPL_NIEOP-ODL_NIEOP pict '99 999.99'
*     @ 17,39 say iif(NADPL_SPO='N','Nad',iif(NADPL_SPO='Z','Zwr','Dod'))
*     @ 17,43 say NADPL_KWO pict '99 999.99'
//002 dwa pi©tra wy¾ej:
     @ 15,71 say DO_WYPLATY pict '99 999.99'
     if str(zzWAR_FSUM,7,2)#str(WAR_FSUM,7,2)
        ColErr()
     endif
//002 nowe 2 linie
     @ 16,71 say PRZEL_NAKO pict '99 999.99'
     @ 17,71 say DO_WYPLATY-PRZEL_NAKO pict '99 999.99'

     @ 19,43 say WAR_FSUM pict '99 999.99'
     set color to w+
     @ 19,55 say STAW_FSUM pict '99.99'
     @ 20,43 say ZUS_ZASCHO pict '99 999.99'
     @ 20,59 say ZUS_RKCH   pict '999.99'
     @ 20,73 say ZUS_PODAT  pict '999.99'
     @ 22,8  say UWAGI
     setcolor(CURR)
return
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± oblpl      ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*± Obliczanie skladnikow placowych                                          ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
function oblpl()
     store 0 to wolI,wolU,wolC,wolO,wolW,wolB,wolM,choC,wolZ,choZ,wolN
     _zident_=str(prac->rec_no,5)
     _bot_=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc#etaty->mc]
     _bot_1=[del#'+'.or.firma#ident_fir.or.ident#_zident_.or.mc=etaty->mc]
     sele nieobec
     seek [+]+ident_fir+_zident_+etaty->mc
     if found()
        do while .not.&_bot_
           do case
           case substr(PRZYCZYNA,1,1)='I'
                wolI=wolI+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='U'
                wolU=wolU+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='C'
                wolC=wolC+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='Z'
                wolZ=wolZ+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='O'
                wolO=wolO+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='W'
                wolW=wolW+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='B'
                wolB=wolB+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='M'
                wolM=wolM+((dddo-ddod)+1)
           case substr(PRZYCZYNA,1,1)='N'
                wolN=wolN+((dddo-ddod)+1)
           endcase
           skip
        enddo
     endif
     seek [+]+ident_fir+_zident_
     if found()
        do while .not.&_bot_1
           if substr(PRZYCZYNA,1,1)='C'
              choC=choC+((dddo-ddod)+1)
           endif
           if substr(PRZYCZYNA,1,1)='Z'
              choZ=choZ+((dddo-ddod)+1)
           endif
           skip
        enddo
     endif
*    zDNI_ZASCHO=min(wolC,max(0,33-(choC+choZ)))
     zDNI_ZAS100=min(wolZ,max(0,parap_ldw-(choC+choZ)))
     sele etaty
      zDNI_CHOROB=wolC+wolZ+wolO+wolW+wolM
      if zDNI_BEZPL#0
         zSTA_BEZPL=_round((zBRUT_ZASAD+zBRUT_PREMI+zDOPL_OPOD)/zIL_DNI_ROB,2)
         zODL_BEZPL=iif(zIL_DNI_ROB=zDNI_BEZPL,zBRUT_ZASAD+zBRUT_PREMI+zDOPL_OPOD,_round(zDNI_BEZPL*zSTA_BEZPL,2))
      else
         zSTA_BEZPL=0
         zODL_BEZPL=0
      endif
      zPENSJA=(zBRUT_ZASAD+zBRUT_PREMI+zDOPL_OPOD+zDOPL_BZUS + zZASI_BZUS)-(zWAR_PF3+zODL_CHOROB+zODL_BEZPL)
      IF zODLICZENIE = 'N'
         zODLICZ=0
      ELSE
         IF zODLICZ == 0
            zODLICZ := Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_odl*/
         ENDIF
      endif
      zSTA_ZASCHO=_round(((zBRUTTO6/zIL_MIE6)/30)*(zPRO_ZASCHO/100),2)
      zDOP_ZASCHO=_round(zDNI_ZASCHO*zSTA_ZASCHO,2)
      zSTA_ZASC20=_round(((zBRUTTO6/zIL_MIE6)/30)*(zPRO_ZASC20/100),2)
      zDOP_ZASC20=_round(zDNI_ZASC20*zSTA_ZASC20,2)
      zSTA_ZAS100=_round((zBRUTTO6/zIL_MIE6)/30,2)
      zDOP_ZAS100=_round(zDNI_ZAS100*zSTA_ZAS100,2)
      zBRUT_RAZEM=zPENSJA+zDOP_ZASCHO+zDOP_ZASC20+zDOP_ZAS100+zWAR_PF3
      zzWAR_PUE=_round((zPENSJA-zDOPL_BZUS-zZASI_BZUS)*(zSTAW_PUE/100),2)
      zzWAR_PUR=_round((zPENSJA-zDOPL_BZUS-zZASI_BZUS)*(zSTAW_PUR/100),2)
      zzWAR_PUC=_round((zPENSJA-zDOPL_BZUS-zZASI_BZUS)*(zSTAW_PUC/100),2)
      zzWAR_PSUM=zzWAR_PUE+zzWAR_PUR+zzWAR_PUC
      if str(zPENSJA,8,2)#str(PENSJA,8,2).or.str(zDOPL_BZUS,8,2)#str(DOPL_BZUS,8,2).or.str(zSTAW_PUE,5,2)#str(STAW_PUE,5,2).or.str(zSTAW_PUR,5,2)#str(STAW_PUR,5,2).or.str(zSTAW_PUC,5,2)#str(STAW_PUC,5,2).or.str(zZASI_BZUS,8,2)#Str(ZASI_BZUS,8,2)
         zWAR_PUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUE/100),2)
         zWAR_PUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUR/100),2)
         zWAR_PUC=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUC/100),2)
      endif
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC
      zDOCHOD=max(0,zBRUT_RAZEM-(zKOSZT+zWAR_PSUM))
      IF zULGAKLSRA == 'T'
         zULGAKLSRK := TabDochUKSKwota( zBRUT_RAZEM, Val( param_rok ), Val( miesiacpla ) )
      ELSE
         zULGAKLSRK := 0
      ENDIF
      zDOCHODPOD=_round(zDOCHOD + zPPKPPM - zULGAKLSRK,0)
      IF zPPK == 'T'
         IF zPPKZS1 == 0
            zPPKZS1 := prac->ppkzs1
         ENDIF
         IF zPPKPS1 == 0
            zPPKPS1 := parpk_sp
         ENDIF
         zPPKZK1 := zPENSJA * ( zPPKZS1 / 100 )
         zPPKZK2 := zPENSJA * ( zPPKZS2 / 100 )
         zPPKPK1 := zPENSJA * ( zPPKPS1 / 100 )
         zPPKPK2 := zPENSJA * ( zPPKPS2 / 100 )
      ELSE
         zPPKZK1 := 0
         zPPKZK2 := 0
         zPPKPK1 := 0
         zPPKPK2 := 0
      ENDIF
      IF zOSWIAD26R == 'T'
         zODLICZ21 := 43.76
         B521 := zDOCHODPOD*(zSTAWKAPODAT21/100)
         B5=_round(max(0,zBRUT_RAZEM-(parap_kos+zWAR_PSUM)),0)*(Param_PPla_param( 'podatek', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_pod*/ / 100)
         zWAR_PUZ21=iif(B521<=zODLICZ21,0,min(B521-zODLICZ21,_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)))
         zWAR_PUZ= _round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)
         zWAR_PUZB=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)
         zWAR_PZKB21=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(7.75/100),2)
         zWAR_PUZO21=iif(B521<=zODLICZ21,0,min(B521-zODLICZ21,_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(7.75/100),2)))
         zWAR_PUZO=0
         zPODATEK=max(0,_round(B5-(zWAR_PUZO+Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_odl*/ ),0))
         zPODATEK21=max(0,_round(B521-(zWAR_PUZO21+zODLICZ21),0))
         zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ+zWAR_PF3)
         zNETTO21=zBRUT_RAZEM-(zPODATEK21+zWAR_PSUM+zWAR_PUZO21+zWAR_PF3)

         zWAR_PUZ := Min( _round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2), zWAR_PUZ )
         zWAR_PUZB := zWAR_PUZ
         zWAR_PZKB := 0.0
         zWAR_PUZO := 0.0
         zPODATEK := 0.0
         zNETTO := zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ+zWAR_PF3)
         B5 := 0.0
         zODLICZ := 0.0
         zWAR_PUZW := zWAR_PUZ
         IF Param_PPla_param( 'obnizzus', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) .AND. zBRUT_RAZEM < 12800 .AND. zWNIOSTERM == 'T' .AND. zNETTO21 > zNETTO
            *IF zODLICZ <> 0
               zWAR_PUZ := zWAR_PUZO21
               *zPODATEK=max(0,_round(B5-(zWAR_PUZ+zODLICZ),0))
            *ELSE
               *zPODATEK=max(0,_round(B5-(zWAR_PUZO21+zODLICZ),0))
            *ENDIF
            zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ+zWAR_PF3)
         ENDIF
      ELSE
         B5=zDOCHODPOD*(zSTAW_PODAT/100)
         B521=(zDOCHODPOD+zULGAKLSRK)*(zSTAWKAPODAT21/100)
   *--> Gdy potracanie skladki do wysokosci podatku
         zODLICZ21 := iif(zODLICZENIE<>'N'.AND.zODLICZ<>0,43.76,0)
         zWAR_PUZ21=iif(B521<=zODLICZ21,0,min(B521-zODLICZ21,_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)))
         zWAR_PUZ= _round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)
         zWAR_PUZB=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(zSTAW_PUZ/100),2)
         zWAR_PZKB21=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(7.75/100),2)
         zWAR_PUZO21=iif(B521<=zODLICZ21,0,min(B521-zODLICZ21,_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM + zZASI_BZUS))*(7.75/100),2)))
         zWAR_PUZO=0
   *     zWAR_PUZO=zWAR_PUZ
   *--> Koniec
   *--> Gdy potracanie pelnej skladki a odliczanie do wysokosci podatku
   *     zWAR_PUZ=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM))*(zSTAW_PUZ/100),2)
   *     zWAR_PUZB=_round((zBRUT_RAZEM-(zDOPL_BZUS+zWAR_PF3+zWAR_PSUM))*(zSTAW_PUZ/100),2)
   *     zWAR_PUZO=iif(B5<=zODLICZ,0,min(B5-zODLICZ,zWAR_PUZ))
   *--> Koniec
         zPODATEK=max(0,_round(B5-(zWAR_PUZO+zODLICZ),0))
         zPODATEK21=max(0,_round(B521-(zWAR_PUZO21+zODLICZ21),0))
         zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ+zWAR_PF3)
         zNETTO21=zBRUT_RAZEM-(zPODATEK21+zWAR_PSUM+zWAR_PUZ21+zWAR_PF3)
         zPODNIEP := 0
         zWAR_PUZW := zWAR_PUZ
         IF Param_PPla_param( 'obnizzus', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) .AND. zBRUT_RAZEM < 12800 .AND. zNETTO21 > zNETTO
            zWAR_PUZ := zWAR_PUZ21
            IF zWNIOSTERM == 'T'
               zPODNIEP := zPODATEK - zPODATEK21
               zPODATEK := zPODATEK21
            ENDIF
            zNETTO=zBRUT_RAZEM-(zPODATEK+zWAR_PSUM+zWAR_PUZ+zWAR_PF3)
         ENDIF
      ENDIF
      zDO_WYPLATY=zNETTO+zZASIL_RODZ+zZASIL_PIEL+zDOPL_NIEOP-zODL_NIEOP-zPPKZK1-zPPKZK2
      *zDO_WYPLATY21=zNETTO21+zZASIL_RODZ+zZASIL_PIEL+zDOPL_NIEOP-zODL_NIEOP-zPPKZK1-zPPKZK2
      zzWAR_FUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUE/100),2)
      zzWAR_FUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUR/100),2)
      zzWAR_FUW=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUW/100),2)
      zzWAR_FFP=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFP/100),2)
      zzWAR_FFG=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFG/100),2)
      zzWAR_FSUM=zzWAR_FUE+zzWAR_FUR+zzWAR_FUW+zzWAR_FFP+zzWAR_FFG
      if str(zPENSJA,8,2)#str(PENSJA,8,2).or.str(zDOPL_BZUS,8,2)#str(DOPL_BZUS,8,2).or.str(zSTAW_FUE,5,2)#str(STAW_FUE,5,2).or.str(zSTAW_FUR,5,2)#str(STAW_FUR,5,2).or.str(zSTAW_FUW,5,2)#str(STAW_FUW,5,2).or.str(zSTAW_FFP,5,2)#str(STAW_FFP,5,2);
         .or.str(zSTAW_FFG,5,2)#str(STAW_FFG,5,2) .or.str(zZASI_BZUS,8,2)#Str(ZASI_BZUS,8,2)
         zWAR_FUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUE/100),2)
         zWAR_FUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUR/100),2)
         zWAR_FUW=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUW/100),2)
         zWAR_FFP=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFP/100),2)
         zWAR_FFG=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFG/100),2)
      endif
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG
      zSTAW_FSUM=zSTAW_FUE+zSTAW_FUR+zSTAW_FUW+zSTAW_FFP+zSTAW_FFG
      B61=zSTAW_PUE+zSTAW_PUR+zSTAW_PUC
      B62=zSTAW_FUE+zSTAW_FUR+zSTAW_FUW+zSTAW_FFP+zSTAW_FFG
      if EDI=1
         do case
         case skladn=7
              set colo to w+
              if str(zzWAR_PUE,7,2)==str(zWAR_PUE,7,2)
                 @ 14,61 say zzWAR_PUE pict '9 999.99'
              endif
              if str(zzWAR_PUR,7,2)==str(zWAR_PUR,7,2)
                 @ 15,61 say zzWAR_PUR pict '9 999.99'
              endif
              if str(zzWAR_PUC,7,2)==str(zWAR_PUC,7,2)
                 @ 16,61 say zzWAR_PUC pict '9 999.99'
              endif
              if str(zzWAR_PSUM,7,2)==str(zWAR_PSUM,7,2)
                 @ 17,61 say zzWAR_PSUM pict '9 999.99'
              endif
              ColErr()
              if str(zzWAR_PUE,7,2)#str(zWAR_PUE,7,2)
                 @ 14,61 say zzWAR_PUE pict '9 999.99'
              endif
              if str(zzWAR_PUR,7,2)#str(zWAR_PUR,7,2)
                 @ 15,61 say zzWAR_PUR pict '9 999.99'
              endif
              if str(zzWAR_PUC,7,2)#str(zWAR_PUC,7,2)
                 @ 16,61 say zzWAR_PUC pict '9 999.99'
              endif
              if str(zzWAR_PSUM,7,2)#str(zWAR_PSUM,7,2)
                 @ 17,61 say zzWAR_PSUM pict '9 999.99'
              endif
              ColStd()
         case skladn=13 //<----- 002 UWAGA! ZMIANA NUMERU!
              set colo to w+
              if str(zzWAR_FUE,7,2)==str(zWAR_FUE,7,2)
                 @ 14,61 say zzWAR_FUE pict '9 999.99'
              endif
              if str(zzWAR_FUR,7,2)==str(zWAR_FUR,7,2)
                 @ 15,61 say zzWAR_FUR pict '9 999.99'
              endif
              if str(zzWAR_FUW,7,2)==str(zWAR_FUW,7,2)
                 @ 16,61 say zzWAR_FUW pict '9 999.99'
              endif
              if str(zzWAR_FFP,7,2)==str(zWAR_FFP,7,2)
                 @ 18,61 say zzWAR_FFP pict '9 999.99'
              endif
              if str(zzWAR_FFG,7,2)==str(zWAR_FFG,7,2)
                 @ 19,61 say zzWAR_FFG pict '9 999.99'
              endif
              if str(zzWAR_FSUM,7,2)==str(zWAR_FSUM,7,2)
                 @ 20,61 say zzWAR_FSUM pict '9 999.99'
              endif
              ColErr()
              if str(zzWAR_FUE,7,2)#str(zWAR_FUE,7,2)
                 @ 14,61 say zzWAR_FUE pict '9 999.99'
              endif
              if str(zzWAR_FUR,7,2)#str(zWAR_FUR,7,2)
                 @ 15,61 say zzWAR_FUR pict '9 999.99'
              endif
              if str(zzWAR_FUW,7,2)#str(zWAR_FUW,7,2)
                 @ 16,61 say zzWAR_FUW pict '9 999.99'
              endif
              if str(zzWAR_FFP,7,2)#str(zWAR_FFP,7,2)
                 @ 18,61 say zzWAR_FFP pict '9 999.99'
              endif
              if str(zzWAR_FFG,7,2)#str(zWAR_FFG,7,2)
                 @ 19,61 say zzWAR_FFG pict '9 999.99'
              endif
              if str(zzWAR_FSUM,7,2)#str(zWAR_FSUM,7,2)
                 @ 20,61 say zzWAR_FSUM pict '9 999.99'
              endif
              ColStd()
         endcase
      endif
//002 nowe linie juz do konca procedury

   do case
   case zJAKI_PRZEL='N'
        zKW_PRZELEW=0
        zPRZEL_NAKO=0
   case zJAKI_PRZEL='P'
        zPRZEL_NAKO=_round(zDO_WYPLATY*(zKW_PRZELEW/100),2)
   case zJAKI_PRZEL='K'
        zPRZEL_NAKO=zKW_PRZELEW
        if zKW_PRZELEW > zDO_WYPLATY
           zPRZEL_NAKO = zDO_WYPLATY
        endif
   endcase

return .t.
**************************************************************************
procedure PODSTAW()
***************************************************************************
zBRUT_ZASAD=BRUT_ZASAD
zBRUT_PREMI=BRUT_PREMI
zDOPL_OPOD=DOPL_OPOD
zDOPL_BZUS=DOPL_BZUS

zKOSZT=KOSZT
zKOD_KASY=KOD_KASY
zKOD_TYTU=KOD_TYTU

zSTAW_PUE=STAW_PUE
zSTAW_PUR=STAW_PUR
zSTAW_PUC=STAW_PUC
zSTAW_PF3=STAW_PF3
zSTAW_PSUM=STAW_PSUM
zWAR_PUE=WAR_PUE
zWAR_PUR=WAR_PUR
zWAR_PUC=WAR_PUC
zWAR_PF3=WAR_PF3
zWAR_PSUM=WAR_PSUM

zODLICZ=ODLICZ
zSTAW_PODAT=STAW_PODA2
zSTAW_PUZ=STAW_PUZ
zWAR_PUZ=WAR_PUZ
zWAR_PUZO=WAR_PUZO
//zSTAW_PZK=STAW_PZK

zDOPL_NIEOP=DOPL_NIEOP
zODL_NIEOP=ODL_NIEOP

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

zZASIL_RODZ=ZASIL_RODZ
zZASIL_PIEL=ZASIL_PIEL
zILOSO_RODZ=ILOSO_RODZ
zILOSO_PIEL=ILOSO_PIEL

zSTANOWISKO=STANOWISKO
zKOD_KASY=KOD_KASY
zKOD_TYTU=KOD_TYTU
zWYMIARL=WYMIARL
zWYMIARM=WYMIARM
zKW_PRZELEW=KW_PRZELEW
zJAKI_PRZEL=JAKI_PRZEL
zPRZEL_NAKO=PRZEL_NAKO

zPPKZS1 := PPKZS1
zPPKZK1 := PPKZK1
zPPKZS2 := PPKZS2
zPPKZK2 := PPKZK2
zPPKPS1 := PPKPS1
zPPKPK1 := PPKPK1
zPPKPS2 := PPKPS2
zPPKPK2 := PPKPK2
zPPKPPM := PPKPPM
zPPK := PPK

zZASI_BZUS := ZASI_BZUS

zOSWIAD26R=iif( OSWIAD26R == ' ', iif( CzyPracowPonizej26R( Val( miesiacpla ), Val( param_rok ) ) .AND. prac->oswiad26r == 'T', 'T', 'N' ), OSWIAD26R )
   IF ! Param_PPla_param( 'aktuks', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) )
      zULGAKLSRA := 'N'
      zULGAKLSRK=0
   ELSE
      zULGAKLSRA=iif( etaty->ulgaklsra $ 'TN', etaty->ulgaklsra, iif( prac->ulgaklsra == ' ', 'N', prac->ulgaklsra ) )
      zULGAKLSRK=ULGAKLSRK
   ENDIF
   IF ! Param_PPla_param( 'aktpterm', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) )
      zWNIOSTERM := 'N'
      zPODNIEP := 0
   ELSE
      zWNIOSTERM := WNIOSTERM
      zPODNIEP := PODNIEP
   ENDIF
zODLICZENIE := ODLICZENIE
zWAR_PUZW := WAR_PUZW

if val(miesiacpla)>1.and.zBRUT_ZASAD=0
   nCoRobic := Etaty1CoRobic()
   DO CASE
   CASE nCoRobic == 1
      skip -1
      zBRUT_ZASAD=iif(zBRUT_ZASAD=0,BRUT_ZASAD,zBRUT_ZASAD)
      zBRUT_PREMI=iif(zBRUT_PREMI=0,BRUT_PREMI,zBRUT_PREMI)
      zDOPL_OPOD=iif(zDOPL_OPOD=0,DOPL_OPOD,zDOPL_OPOD)

      zKOSZT=iif(zKOSZT=0,KOSZT,zKOSZT)

      zSTAW_PUE=iif(zSTAW_PUE=0,STAW_PUE,zSTAW_PUE)
      zSTAW_PUR=iif(zSTAW_PUR=0,STAW_PUR,zSTAW_PUR)
      zSTAW_PUC=iif(zSTAW_PUC=0,STAW_PUC,zSTAW_PUC)
      zSTAW_PF3=iif(zSTAW_PF3=0,STAW_PF3,zSTAW_PF3)
      zSTAW_PSUM=zSTAW_PUE+zSTAW_PUR+zSTAW_PUC
      zWAR_PUE=iif(zWAR_PUE=0,WAR_PUE,zWAR_PUE)
      zWAR_PUR=iif(zWAR_PUR=0,WAR_PUR,zWAR_PUR)
      zWAR_PUC=iif(zWAR_PUC=0,WAR_PUC,zWAR_PUC)
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC

      zWAR_PF3=iif(zWAR_PF3=0,WAR_PF3,zWAR_PF3)

      zODLICZ=iif(zODLICZ=0 .OR. zODLICZ <> Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ), Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*ODLICZ*/,zODLICZ)
      zSTAW_PODAT=iif(zSTAW_PODAT=0 .OR. zSTAW_PODAT <> Param_PPla_param( 'podatek', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ), Param_PPla_param( 'podatek', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*STAW_PODA2*/,zSTAW_PODAT)
      zSTAW_PUZ=iif(zSTAW_PUZ=0,STAW_PUZ,zSTAW_PUZ)
      //zSTAW_PZK=iif(zSTAW_PZK=0,STAW_PZK,zSTAW_PZK)

      zDOPL_NIEOP=iif(zDOPL_NIEOP=0,DOPL_NIEOP,zDOPL_NIEOP)
      zODL_NIEOP=iif(zODL_NIEOP=0,ODL_NIEOP,zODL_NIEOP)

      zSTAW_FUE=iif(zSTAW_FUE=0,STAW_FUE,zSTAW_FUE)
      zSTAW_FUR=iif(zSTAW_FUR=0,STAW_FUR,zSTAW_FUR)
      zSTAW_FUW=iif(zSTAW_FUW=0,STAW_FUW,zSTAW_FUW)
      zSTAW_FFP=iif(zSTAW_FFP=0,STAW_FFP,zSTAW_FFP)
      zSTAW_FFG=iif(zSTAW_FFG=0,STAW_FFG,zSTAW_FFG)
      zSTAW_FSUM=zSTAW_FUE+zSTAW_FUR+zSTAW_FUW+zSTAW_FFP+zSTAW_FFG
      zWAR_FUE=iif(zWAR_FUE=0,WAR_FUE,zWAR_FUE)
      zWAR_FUR=iif(zWAR_FUR=0,WAR_FUR,zWAR_FUR)
      zWAR_FUW=iif(zWAR_FUW=0,WAR_FUW,zWAR_FUW)
      zWAR_FFP=iif(zWAR_FFP=0,WAR_FFP,zWAR_FFP)
      zWAR_FFG=iif(zWAR_FFG=0,WAR_FFG,zWAR_FFG)
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG

      zZASIL_RODZ=iif(zZASIL_RODZ=0,ZASIL_RODZ,zZASIL_RODZ)
      zZASIL_PIEL=iif(zZASIL_PIEL=0,ZASIL_PIEL,zZASIL_PIEL)
      zILOSO_RODZ=iif(zILOSO_RODZ=0,ILOSO_RODZ,zILOSO_RODZ)
      zILOSO_PIEL=iif(zILOSO_PIEL=0,ILOSO_PIEL,zILOSO_PIEL)

      zSTANOWISKO=iif(empty(zSTANOWISKO),STANOWISKO,zSTANOWISKO)
      zKOD_KASY=iif(empty(zKOD_KASY),KOD_KASY,zKOD_KASY)
      zKOD_TYTU=iif(empty(zKOD_TYTU),KOD_TYTU,zKOD_TYTU)
      zWYMIARL=iif(zWYMIARL=0,WYMIARL,zWYMIARL)
      zWYMIARM=iif(zWYMIARM=0,WYMIARM,zWYMIARM)

      //zOSWIAD26R := OSWIAD26R

      //002 nowe linie
      zJAKI_PRZEL=prac->JAKI_PRZEL
      do case
      case zJAKI_PRZEL='N'
           zKW_PRZELEW=0
           zPRZEL_NAKO=0
      case zJAKI_PRZEL='P'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=_round(DO_WYPLATY*(prac->KW_PRZELEW/100),2)
      case zJAKI_PRZEL='K'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=prac->KW_PRZELEW
      endcase
      skip 1
   CASE nCoRobic == 2
      zKOSZT=parap_kos
      zKOD_KASY=parap_rkc
      zKOD_TYTU='011000'
      zSTAW_PODAT=Param_PPla_param( 'podatek', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_pod*/
      zODLICZENIE := prac->odliczenie
      IF zODLICZENIE='T'
         zODLICZ=Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_odl*/
      else
         zODLICZ=0
      endif
      zSTAW_PUE=parap_pue
      zSTAW_PUR=parap_pur
      zSTAW_PUC=parap_puc
      zSTAW_PF3=parap_pf3
      zSTAW_PUZ=parap_puz
      //zSTAW_PZK=parap_pzk
      zSTAW_FUE=parap_fue
      zSTAW_FUR=parap_fur
      zSTAW_FUW=parap_fuw
      zSTAW_FFP=parap_ffp
      zSTAW_FFG=parap_ffg
      zWAR_PUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUE/100),2)
      zWAR_PUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUR/100),2)
      zWAR_PUC=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUC/100),2)
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC
      zWAR_FUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUE/100),2)
      zWAR_FUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUR/100),2)
      zWAR_FUW=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUW/100),2)
      zWAR_FFP=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFP/100),2)
      zWAR_FFG=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFG/100),2)
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG
      zJAKI_PRZEL=prac->JAKI_PRZEL
      do case
      case zJAKI_PRZEL='N'
           zKW_PRZELEW=0
           zPRZEL_NAKO=0
      case zJAKI_PRZEL='P'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=_round(DO_WYPLATY*(prac->KW_PRZELEW/100),2)
      case zJAKI_PRZEL='K'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=prac->KW_PRZELEW
      endcase
      zPPK := iif( prac->ppk $ 'TN', prac->ppk, 'N' )
      IF zPPK == 'T'
         zPPKZS1 := prac->ppkzs1
         zPPKZK1 := zPENSJA * ( zPPKZS1 / 100 )
         zPPKPS1 := parpk_sp
         zPPKPK1 := zPENSJA * ( zPPKPS1 / 100 )
         zPPKZS2 := prac->ppkzs2
         zPPKZK2 := zPENSJA * ( zPPKZS2 / 100 )
         zPPKPS2 := prac->ppkps2
         zPPKPK2 := zPENSJA * ( zPPKPS2 / 100 )
      ELSE
         zPPKZS1 := 0
         zPPKZK1 := 0
         zPPKPS1 := 0
         zPPKPK1 := 0
         zPPKZS2 := 0
         zPPKZK2 := 0
         zPPKPS2 := 0
         zPPKPK2 := 0
      ENDIF
      zWNIOSTERM := prac->wniosterm
   ENDCASE
endif
zDNI_CHOROB=DNI_CHOROB
zSTA_CHOROB=STA_CHOROB
zODL_CHOROB=ODL_CHOROB
zIL_DNI_ROB=IL_DNI_ROB
zDNI_BEZPL=DNI_BEZPL
zSTA_BEZPL=STA_BEZPL
zODL_BEZPL=ODL_BEZPL
zBRUTTO6=BRUTTO6
*zNADPL_SPO=NADPL_SPO
*zNADPL_KWO=NADPL_KWO

zPRO_ZASCHO=PRO_ZASCHO
zDNI_ZASCHO=DNI_ZASCHO
zSTA_ZASCHO=STA_ZASCHO
zDOP_ZASCHO=DOP_ZASCHO
zPRO_ZASC20=PRO_ZASC20
zDNI_ZASC20=DNI_ZASC20
zSTA_ZASC20=STA_ZASC20
zDOP_ZASC20=DOP_ZASC20
zIL_MIE6=IL_MIE6
zDNI_ZAS100=DNI_ZAS100
zSTA_ZAS100=STA_ZAS100
zDOP_ZAS100=DOP_ZAS100

zZUS_ZASCHO=ZUS_ZASCHO
zZUS_PODAT=ZUS_PODAT
zZUS_RKCH=ZUS_RKCH

zBRUT_RAZEM=BRUT_RAZEM
zDOCHOD=DOCHOD
zDOCHODPOD=DOCHODPOD
*zZAOPOD=ZAOPOD
*zJAKZAO=iif(zZAOPOD=1,'D','Z')
zPENSJA=PENSJA
zPODATEK=PODATEK
zNETTO=NETTO
zDO_WYPLATY=DO_WYPLATY
zUWAGI=UWAGI
   IF zOSWIAD26R == 'T'
      B5 := 0
   ELSE
      B5=zDOCHODPOD*(zSTAW_PODAT/100)
   ENDIF
B6=zWAR_FSUM

   if zJAKI_PRZEL='K'.and.zKW_PRZELEW > zDO_WYPLATY
      zPRZEL_NAKO = zDO_WYPLATY
   endif
*//002 nowe linie
*do case
*case zJAKI_PRZEL='N'
*     zPRZEL_NAKO=0
*case zJAKI_PRZEL='P'
*     zPRZEL_NAKO=_round(zDO_WYPLATY*(zKW_PRZELEW/100),2)
*case zJAKI_PRZEL='K'
*     zPRZEL_NAKO=zKW_PRZELEW
*     if zKW_PRZELEW > zDO_WYPLATY
*        zPRZEL_NAKO = zDO_WYPLATY
*     endif
*endcase

if val(miesiacpla)=1.or.substr(dtos(prac->data_przy),1,6)==param_rok+strtran(miesiacpla,' ','0')
   if tnesc('*','Podstawic standardowe parametry placowe [T/N] ?')
      zKOSZT=parap_kos
      zKOD_KASY=parap_rkc
      zKOD_TYTU='011000'
      zSTAW_PODAT=Param_PPla_param( 'podatek', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_pod*/
      zODLICZENIE := prac->odliczenie
      IF zODLICZENIE='T'
         zODLICZ=Param_PPla_param( 'odlicz', hb_Date( Val( param_rok ), Val( miesiacpla ), 1 ) ) /*parap_odl*/
      else
         zODLICZ=0
      endif
      zSTAW_PUE=parap_pue
      zSTAW_PUR=parap_pur
      zSTAW_PUC=parap_puc
      zSTAW_PF3=parap_pf3
      zSTAW_PUZ=parap_puz
      //zSTAW_PZK=parap_pzk
      zSTAW_FUE=parap_fue
      zSTAW_FUR=parap_fur
      zSTAW_FUW=parap_fuw
      zSTAW_FFP=parap_ffp
      zSTAW_FFG=parap_ffg
      zWAR_PUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUE/100),2)
      zWAR_PUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUR/100),2)
      zWAR_PUC=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUC/100),2)
      zWAR_PSUM=zWAR_PUE+zWAR_PUR+zWAR_PUC
      zWAR_FUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUE/100),2)
      zWAR_FUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUR/100),2)
      zWAR_FUW=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUW/100),2)
      zWAR_FFP=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFP/100),2)
      zWAR_FFG=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFG/100),2)
      zWAR_FSUM=zWAR_FUE+zWAR_FUR+zWAR_FUW+zWAR_FFP+zWAR_FFG
      zJAKI_PRZEL=prac->JAKI_PRZEL
      do case
      case zJAKI_PRZEL='N'
           zKW_PRZELEW=0
           zPRZEL_NAKO=0
      case zJAKI_PRZEL='P'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=_round(DO_WYPLATY*(prac->KW_PRZELEW/100),2)
      case zJAKI_PRZEL='K'
           zKW_PRZELEW=prac->KW_PRZELEW
           zPRZEL_NAKO=prac->KW_PRZELEW
      endcase
      zPPK := iif( prac->ppk $ 'TN', prac->ppk, 'N' )
      IF zPPK == 'T'
         zPPKZS1 := prac->ppkzs1
         zPPKZK1 := zPENSJA * ( zPPKZS1 / 100 )
         zPPKPS1 := parpk_sp
         zPPKPK1 := zPENSJA * ( zPPKPS1 / 100 )
         zPPKZS2 := prac->ppkzs2
         zPPKZK2 := zPENSJA * ( zPPKZS2 / 100 )
         zPPKPS2 := prac->ppkps2
         zPPKPK2 := zPENSJA * ( zPPKPS2 / 100 )
      ELSE
         zPPKZS1 := 0
         zPPKZK1 := 0
         zPPKPS1 := 0
         zPPKPK1 := 0
         zPPKZS2 := 0
         zPPKZK2 := 0
         zPPKPS2 := 0
         zPPKPK2 := 0
      ENDIF
      zWNIOSTERM := prac->wniosterm
   endif
endif

   IF zODLICZENIE == ' '
      zODLICZENIE := prac->odliczenie
   ENDIF

   IF zWNIOSTERM == ' '
      zWNIOSTERM := prac->wniosterm
   ENDIF
      zzWAR_PUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUE/100),2)
      zzWAR_PUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUR/100),2)
      zzWAR_PUC=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_PUC/100),2)
      zzWAR_PSUM=zzWAR_PUE+zzWAR_PUR+zzWAR_PUC
      zzWAR_FUE=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUE/100),2)
      zzWAR_FUR=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUR/100),2)
      zzWAR_FUW=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FUW/100),2)
      zzWAR_FFP=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFP/100),2)
      zzWAR_FFG=_round((zPENSJA-zDOPL_BZUS - zZASI_BZUS)*(zSTAW_FFG/100),2)
      zzWAR_FSUM=zzWAR_FUE+zzWAR_FUR+zzWAR_FUW+zzWAR_FFP+zzWAR_FFG
***************************************************************************
proc ZAPISZPLA
***************************************************************************
repl_('BRUT_ZASAD',zBRUT_ZASAD)
repl_('BRUT_PREMI',zBRUT_PREMI)
repl_('DOPL_OPOD', zDOPL_OPOD )
repl_('DOPL_BZUS', zDOPL_BZUS )
repl_('KOSZT',     zKOSZT     )
repl_('STAW_PUE',  zSTAW_PUE  )
repl_('STAW_PUr',  zSTAW_PUr  )
repl_('STAW_PUc',  zSTAW_PUc  )
repl_('STAW_Pf3',  zSTAW_Pf3  )
repl_('STAW_PSUM', zSTAW_PSUM )
repl_('WAR_pUE',   zWAR_pUE  )
repl_('WAR_pUr',   zWAR_pUr  )
repl_('WAR_pUc',   zWAR_pUc  )
repl_('WAR_pf3',   zWAR_pf3  )
repl_('WAR_psum',  zWAR_psum )
repl_('ODLICZ',    zODLICZ    )
repl_('STAW_PODA2',zSTAW_PODAT)
repl_('STAW_PUz',  zSTAW_PUz  )
repl_('WAR_pUz',   zWAR_pUz  )
repl_('STAW_Pzk',  zSTAW_Pzk  )
repl_('WAR_pUzO',  zWAR_pUzO )
repl_('DOPL_NIEOP',zDOPL_NIEOP)
repl_('ODL_NIEOP', zODL_NIEOP )
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
repl_('ZASIL_RODZ',zZASIL_RODZ)
repl_('ZASIL_PIEL',zZASIL_PIEL)
repl_('ILOSO_RODZ',zILOSO_RODZ)
repl_('ILOSO_PIEL',zILOSO_PIEL)
repl_('STANOWISKO',zSTANOWISKO)
repl_('KOD_KASY',  zKOD_KASY)
repl_('KOD_TYTU',  zKOD_TYTU)
repl_('WYMIARL',   zWYMIARL)
repl_('WYMIARM',   zWYMIARM)
repl_('DNI_CHOROB',zDNI_CHOROB)
repl_('STA_CHOROB',zSTA_CHOROB)
repl_('ODL_CHOROB',zODL_CHOROB)
repl_('IL_DNI_ROB',zIL_DNI_ROB)
repl_('DNI_BEZPL' ,zDNI_BEZPL )
repl_('STA_BEZPL' ,zSTA_BEZPL )
repl_('ODL_BEZPL' ,zODL_BEZPL )
repl_('BRUTTO6'   ,zBRUTTO6   )
repl_('PRO_ZASCHO',zPRO_ZASCHO)
repl_('DNI_ZASCHO',zDNI_ZASCHO)
repl_('STA_ZASCHO',zSTA_ZASCHO)
repl_('DOP_ZASCHO',zDOP_ZASCHO)
repl_('PRO_ZASC20',zPRO_ZASC20)
repl_('DNI_ZASC20',zDNI_ZASC20)
repl_('STA_ZASC20',zSTA_ZASC20)
repl_('DOP_ZASC20',zDOP_ZASC20)
repl_('IL_MIE6'   ,zIL_MIE6   )
repl_('DNI_ZAS100',zDNI_ZAS100)
repl_('STA_ZAS100',zSTA_ZAS100)
repl_('DOP_ZAS100',zDOP_ZAS100)
repl_('ZUS_ZASCHO',zZUS_ZASCHO)
repl_('ZUS_PODAT' ,zZUS_PODAT )
repl_('ZUS_RKCH'  ,zZUS_RKCH  )
repl_('BRUT_RAZEM',zBRUT_RAZEM)
repl_('DOCHOD',    zDOCHOD    )
repl_('DOCHODPOD', zDOCHODPOD )
*repl_('ZAOPOD',    zZAOPOD    )
repl_('PENSJA',    zPENSJA    )
repl_('PODATEK',   zPODATEK   )
repl_('NETTO',     zNETTO     )
repl_('DO_WYPLATY',zDO_WYPLATY)
repl_('UWAGI',     zUWAGI )
//002 nowa linia
repl_('KW_PRZELEW',zKW_PRZELEW)
repl_('JAKI_PRZEL',zJAKI_PRZEL)
repl_('PRZEL_NAKO',zPRZEL_NAKO)
*repl_('NADPL_SPO',zNADPL_SPO)
*repl_('NADPL_KWO',zNADPL_KWO)
repl_( 'OSWIAD26R', zOSWIAD26R )

repl_( 'PPKZS1', zPPKZS1 )
repl_( 'PPKZK1', zPPKZK1 )
repl_( 'PPKZS2', zPPKZS2 )
repl_( 'PPKZK2', zPPKZK2 )
repl_( 'PPKPS1', zPPKPS1 )
repl_( 'PPKPK1', zPPKPK1 )
repl_( 'PPKPS2', zPPKPS2 )
repl_( 'PPKPK2', zPPKPK2 )
repl_( 'PPKPPM', zPPKPPM )
repl_( 'PPK', zPPK )
repl_( 'ZASI_BZUS', zZASI_BZUS )
repl_( 'ULGAKLSRA', zULGAKLSRA )
repl_( 'ULGAKLSRK', zULGAKLSRK )
repl_( 'ODLICZENIE', zODLICZENIE )
repl_( 'WNIOSTERM', zWNIOSTERM )
repl_( 'PODNIEP', zPODNIEP )
repl_( 'WAR_PUZW', zWAR_PUZW )
***************************************************************************
func spr_przel
***************************************************************************
//002 nowa funkcja
zJAKI_PRZEL='K'
if (empty(prac->BANK) .or. empty(prac->KONTO) .or. prac->Konto='  -        -')
   tone(500,4)
   tone(500,4)
   ColErr()
   @24,0 say padc('Niekompletne dane o banku pracownika. Wpisuj&_e. 0',80,' ')
   zPRZEL_NAKO=0
endif
if zPRZEL_NAKO > zDO_WYPLATY
   tone(500,4)
   tone(500,4)
   ColErr()
   @24,0 say padc('Kwota przelewu nie mo&_z.e by&_c wi&_e.ksza od kwoty do wyp&_l.aty',80,' ')
   zPRZEL_NAKO=zDO_WYPLATY
endif
zKW_PRZELEW=zPRZEL_NAKO
@ 17,71 say zDO_WYPLATY-zPRZEL_NAKO pict'99 999.99'
return .t.
***************************************************************************
*func vNADPL
***************************************************************************
*   ColStd()
*   @ 24,0 clear
*return .t.
***************************************************************************
*func wNADPL
***************************************************************************
*   ColInf()
*   @ 24,0 say padc('Wpisz: N-zalicz.nadp&_l..za rok ubieg&_l.y, Z-zwrot w got&_o.wce, D-dodatkowe pobranie',80,' ')
*return .t.
***************************************************************************
*func wNADPLKW
***************************************************************************
*   ColInf()
*   @ 17,39 say iif(zNADPL_SPO='N','Nad',iif(zNADPL_SPO='Z','Zwr','Dod'))
*   ColStd()
*return .t.
***************************************************
*function wJAKZAO
*para x,y
*ColInf()
*@ 24,0 say padc('Jak zaokraglic podatek: Z-do zlotowki   lub   D-do dziesieciu groszy',80,' ')
*ColStd()
*@ x,y say iif(zJAKZAO='D','ziesiec groszy','lotowka       ')
*return .t.
***************************************************
*function vJAKZAO
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

FUNCTION Etaty1CoRobic()

   LOCAL cKolor := ColSta(), nRes

   @ 24, 0 SAY PadC( "Wybierz co zrobi†...", 80 )
   ColStd()
   nRes := MenuEx( 20, 20, { "P - Podstaw z poprzedniego miesi¥ca", ;
                             "D - Podstaw z parametr¢w", ;
                             "Z - Pozostaw bez zmian" } )
   ColStd()
   @ 24, 0
   SetColor( cKolor )
   RETURN nRes

/*----------------------------------------------------------------------*/

PROCEDURE Etaty1_UstawWewPar()

   LOCAL cEkran := SaveScreen()
   LOCAL cKolor := ColStd()
   LOCAL nStawka := zSTAWKAPODAT21

   @ 12, 30 CLEAR TO 14, 52
   @ 12, 30 TO 14, 52
   @ 13, 32 SAY "Stawka pod. 2021" GET nStawka PICTURE '99'
   READ

   IF LastKey() <> K_ESC
      zSTAWKAPODAT21 := nStawka
   ENDIF

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

