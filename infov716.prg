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

*################################# GRAFIKA ##################################

   sprawdzVAT(10,ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.01'))


ColInf()
//@  3,0 say '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
@  3,0 say '[B,W]-wpl.got.   [L,N]-przelew   [P]-wpl.poczt.   [D]-wydr.ekranu   [I]-wydr.inf'
ColStd()
@  4,0 say '                I N F O R M A C J E   O   P O D A T K U   V A T                 '
@  5,0 say 'PODATEK NALEZNY     NETTO        VAT     PODATEK NALICZONY   NETTO        VAT   '
@  6,0 say ' kraj         ZW  ת תתת תתת              Nadwyzka z poprzedniej dekl. ת תתת תתת '
@  7,0 say ' poza kraj    NP  ת תתת תתת              Podatek od spisu z natury    ת תתת תתת '
@  8,0 say '    w tym art.100 ת תתת תתת              ZAKUPY  Sr.Trwale ת תתת תתת  ת תתת תתת '
@  9,0 say ' kraj          0% ת תתת תתת                      Pozostale ת תתת תתת  ת תתת תתת '
@ 10,0 say '    w tym art.129 ת תתת תתת              KOREK-  Sr.trwale ת תתת תתת  ת תתת תתת '
@ 11,0 say '              '+str(vat_C,2)+'% ת תתת תתת   ת תתת תתת  TY      Pozostale ת תתת תתת  ת תתת תתת '
@ 12,0 say '              '+str(vat_B,2)+'% ת תתת תתת   ת תתת תתת  RAZEM NALICZONY              ת תתת תתת '
@ 13,0 say '              '+str(vat_A,2)+'% ת תתת תתת   ת תתת תתת  Do odlicz.za kasy            ת תתת תתת '
@ 14,0 say ' WDT (UE)      0% ת תתת תתת              Zaniechanie poboru           ת תתת תתת '
@ 15,0 say ' eksport       0% ת תתת תתת              NALEZNE ZOBOWIAZANIE         ת תתת תתת '
@ 16,0 say ' WNT (UE)         ת תתת תתת   ת תתת תתת          Wplacone zaliczki    ת תתת תתת '
@ 17,0 say ' Import towarow   ת תתת תתת   ת תתת תתת          Nadplata z pop.kwart.ת תתת תתת '
@ 18,0 say ' Import uslug     ת תתת תתת   ת תתת תתת          DO ZAPLATY/NADPLATA  ת תתת תתת '
@ 19,0 say ' Import u.art.28b ת תתת תתת   ת תתת תתת          Przeniesc nadpl.TAK  ת תתת תתת '
@ 20,0 say ' Podatnikiem naby.ת תתת תתת   ת תתת תתת  Zwrot za kasy                ת תתת תתת '
@ 21,0 say ' Podat.nab.dostawaת תתת תתת              Nadwyzka(Na rach)  ת תתת תתת(ת תתת תתת)'
@ 22,0 say ' od spisu z natury            ת תתת תתת  25/60/180ת תתת תתת/ת תתת תתת/ת תתת תתת '
@ 23,0 say ' zapl.za sr.transp            ת תתת תתת  Do przeniesienia             ת תתת תתת '
@ 24,0 say ' RAZEM NALEZNY    ת תתת תתת   ת תתת תתת                                         '
*################################ OBLICZENIA ################################
*wartprzek=p98b
****************************
if zVATFORDR='7D'
   @ 15,41 say 'NALEZNE ZOBOWIAZANIE'
   set color to +w
   @ 18,49 say iif(p98dozap>0.0,'DO ZAPLATY         ','NADPLATA           ')
else
   @ 16,41 clear to 19,79
   set color to +w
   @ 15,41 say 'DO WPLATY DO US     '
endif
@  6,18 say tran(p64,RVPIC)
@  7,18 say tran(p64exp,RVPIC)
@  8,18 say tran(p64expue,RVPIC)
@  9,18 say tran(p67,RVPIC)
@ 10,18 say tran(p67art129,RVPIC)
@ 11,18 say tran(p61+P61a,RVPIC)
@ 11,30 say tran(p62+P62a,RVPIC)
@ 12,18 say tran(p69,RVPIC)
@ 12,30 say tran(p70,RVPIC)
@ 13,18 say tran(p71,RVPIC)
@ 13,30 say tran(p72,RVPIC)
@ 14,18 say tran(p65ue,RVPIC)
@ 15,18 say tran(p65,RVPIC)

@ 16,18 say tran(p65dekue,RVPIC)
@ 16,30 say tran(p65vdekue,RVPIC)
@ 17,18 say tran(p65dekit,RVPIC)
@ 17,30 say tran(p65vdekit,RVPIC)
@ 18,18 say tran(p65dekus,RVPIC)
@ 18,30 say tran(p65vdekus,RVPIC)
@ 19,18 say tran(p65dekusu,RVPIC)
@ 19,30 say tran(p65vdekusu,RVPIC)
@ 20,18 say tran(p65dekwe,RVPIC)
@ 20,30 say tran(p65vdekwe,RVPIC)

@ 22,30 say tran(pp12,RVPIC)
@ 23,30 say tran(znowytran,RVPIC)
@ 24,18 say tran(p75,RVPIC)
@ 24,30 say tran(p76,RVPIC)

@  6,70 say tran(pp8,RVPIC)
@  7,70 say tran(pp11,RVPIC)

@  8,59 say tran(p45dek,RVPIC)
@  8,70 say tran(p46dek,RVPIC)
@  9,59 say tran(p49dek,RVPIC)
@  9,70 say tran(p50dek,RVPIC)

@ 10,70 say tran(zkorekst,RVPIC)
@ 11,70 say tran(zkorekpoz,RVPIC)

@ 12,70 say tran(p79,RVPIC)
@ 13,70 say tran(p98a,DRVPIC)
@ 14,70 say tran(pp13,DRVPIC)
@ 15,70 say tran(p98b,DRVPIC)

if zVATFORDR='7D'
   @ 16,70 say tran(zVATZALMIE,DRVPIC)
   @ 17,70 say tran(zVATNADKWA,DRVPIC)
   if p98dozap>0.0
      @ 18,70 say tran(p98dozap,DRVPIC)
   else
      @ 18,70 say tran(p98rozn,DRVPIC)
   endif
   @ 19,70 say tran(p98doprze,DRVPIC)
endif

@ 20,70 say tran(p99a,DRVPIC)
@ 21,60 say tran(p99,DRVPIC)
@ 21,70 say tran(p99c,RVPIC)
@ 22,50 say tran(p99abc,RVPIC)
@ 22,60 say tran(p99ab,RVPIC)
@ 22,70 say tran(p99b,RVPIC)
@ 23,70 say tran(p99d,RVPIC)
*@ 24,58 say ' '+alltrim(tran(zpaliwa,RVPIC))
*@ 24,70 say ' '+alltrim(tran(zpojazdy,RVPIC))

@ 21, 18 SAY tran( Int( SEK_CV7net ), RVPIC )

sele firma
*################################## PRZEKAZ #################################
zNAZWA_PLA=nazwa
zULICA_PLA=alltrim(ulica)+' '+alltrim(nr_domu)+iif(len(alltrim(nr_mieszk))>0,'/'+alltrim(nr_mieszk),'')
zMIEJSC_PLA=alltrim(kod_p)+' '+alltrim(miejsc)
zBANK_PLA=bank
zKONTO_PLA=nr_konta
ztr1=padr(strtran(alltrim(nip),'-',''),14)
ztr2=' N  '
if zVATFORDR='7 '
*if zVATOKRES='M'
   ztr3=' '+substr(param_rok,3,2)+'M'+strtran(padl(miesiac,2),' ','0')+'  '
else
   ztr3=' '+substr(param_rok,3,2)+'K'+strtran(padl(P5a,2),' ','0')+'  '
endif
ztr4='VAT7   '
zTRESC=ztr1+ztr2+ztr3+ztr4
*zTRESC='VAT-7 '+miesiac+'.'+param_rok+' NIP:'+padc(alltrim(nip),13)

*sele 7
*do while.not.dostep('URZEDY')
*enddo
*set inde to urzedy
sele URZEDY
go firma->skarb
zNAZWA_WIE='URZ&__A.D SKARBOWY '+alltrim(URZAD)
zULICA_WIE=alltrim(ULICA)+' '+alltrim(NR_DOMU)
zMIEJSC_WIE=alltrim(KOD_POCZT)+' '+alltrim(MIEJSC_US)
zBANK_WIE=BANK
zKONTO_WIE=KONTOVAT

if nr_uzytk=108
   do csvvat716
endif

sele urzedy
clear type
kkk=inkey(0)
zPodatki=.t.
do case
case kkk=68.or.kkk=100
     **** Drukowanie ekranu
   DrukujEkran( { PadC( AllTrim( firma->nazwa ), 80 ), iif( zVATFORDR='7 ', ;
      PadC( 'Miesi&_a.c ' + param_rok + '.' + StrTran( PadL( miesiac, 2 ), ' ', '0' ), 80 ), ;
      PadC( 'Kwarta&_l. ' + param_rok + '.' + StrTran( PadL( p5a, 2 ), ' ', '0' ), 80 ) ) } )

case kkk=87 .or. kkk=119.or.kkk=66 .or. kkk=98
     save screen to scr_
     zKWOTA=wartprzek
     afill(nazform,'')
     afill(strform,0)
     nazform[1]='WPLATN'
     strform[1]=1
     form(nazform,strform,1)
     restore screen from scr_
case kkk=78 .or. kkk=110.or.kkk=76 .or. kkk=108
     save screen to scr_
     zKWOTA=wartprzek
     afill(nazform,'')
     afill(strform,0)
     nazform[1]='PRZELN'
     strform[1]=1
     form(nazform,strform,1)
     restore screen from scr_
case kkk=80 .or. kkk=112
     save screen to scr3
     Przek( zNAZWA_WIE,;
                   zNAZWA_PLA,;
                   zULICA_WIE,;
                   zULICA_PLA,;
                   zMIEJSC_WIE,;
                   zMIEJSC_PLA,;
                   zBANK_WIE,;
                   zKONTO_WIE,;
                   wartprzek,;
                   zTRESC )
*    do przekaz with wartprzek,'V'
     restore screen from scr3
   CASE kkk == Asc( 'i' ) .OR. kkk == Asc( 'I' )
      DeklarDrukuj( 'VATINFO' )
endcase
zPodatki=.f.
sele firma
****************************
proc CSVVAT716
****************************
//tworzenie bazy roboczej

save scre to _csvscre_

ColInb()
@ 24,0 clear
center(24,[Preparuj&_e. dane do internetu. Prosz&_e. czeka&_c....])
set color to


_konc_=substr(param_rok,3,2)+strtran(padl(miesiac,2),' ','0')
_plik_='VAT7'+_konc_



      if file(_plik_+'.dbf')=.f.
*        wait 'brak pliku dbf'
         dbcreate(_plik_,{;
                 {"NIPFIRMY", "C", 10, 0},;
                 {"NIPPODAT", "C", 10, 0},;
                 {"NALEZNY",  "N", 15, 2},;
                 {"NALICZONY","N", 15, 2},;
                 {"PODATEK",  "N", 15, 2},;
                 {"DATAAKT",  "D",  8, 0}})
      endif
      select 11
      if dostepex(_plik_)
         index on nipfirmy+nippodat to &_plik_
         go top
         if len(alltrim(strtran(firma->nip,'-',''))+alltrim(ztr1))=20
            seek alltrim(strtran(firma->nip,'-',''))+alltrim(ztr1)
            if found()
               repl NALEZNY with p76,NALICZONY with p79,;
                    PODATEK with p98b,DATAAKT with date()
               commit_()
            else
               appe blan
               repl NIPFIRMY with alltrim(strtran(firma->nip,'-','')),NIPPODAT with alltrim(ztr1)
               repl NALEZNY with p76,NALICZONY with p79,;
                    PODATEK with p98b,DATAAKT with date()
               commit_()
            endif
            go top
            copy to &_plik_ all delimited
         else
            do komun with 'Niew&_l.a&_s.ciwe d&_l.ugo&_s.ci NIP firmy i/lub podatnika. Sprawd&_x. i popraw.'
         endif
      else
         do komun with 'Nie mog&_e. zaktualizowa&_c. pliku exportu CSV.'
      endif
      use

rest scre from _csvscre_
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
