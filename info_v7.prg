/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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
ColInf()
@  3,0 say '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
ColStd()
@  4,0 say '                I N F O R M A C J E   O   P O D A T K U   V A T                 '
@  5,0 say 'PODATEK NALEZNY     NETTO        VAT     PODATEK NALICZONY   NETTO        VAT   '
@  6,0 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
@  7,0 say ' kraj         ZW  ú úúú úúú              Nadwyzka z poprzedniej dekl. ú úúú úúú '
@  8,0 say ' poza kraj    NP  ú úúú úúú              Podatek od spisu z natury    ú úúú úúú '
@  9,0 say ' kraj          0% ú úúú úúú                   ZAKUPY Z UWZGLEDNIENIEM KOREKT    '
@ 10,0 say '    w tym art.129 ú úúú úúú              Srodki trwale    ú úúú úúú   ú úúú úúú '
@ 11,0 say '               3% ú úúú úúú   ú úúú úúú  Pozostale        ú úúú úúú   ú úúú úúú '
@ 12,0 say '               7% ú úúú úúú   ú úúú úúú          KOREKTA VAT NALICZONEGO        '
@ 13,0 say '              22% ú úúú úúú   ú úúú úúú  Od sr.trwalych               ú úúú úúú '
@ 14,0 say ' WDT (UE)      0% ú úúú úúú              Od pozostalych               ú úúú úúú '
@ 15,0 say ' eksport       0% ú úúú úúú              ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
@ 16,0 say ' WNT (UE)         ú úúú úúú   ú úúú úúú  RAZEM NALICZONY              ú úúú úúú '
@ 17,0 say ' Import uslug     ú úúú úúú   ú úúú úúú  Do odlicz.za kasy            ú úúú úúú '
@ 18,0 say ' Dostawa wewne.   ú úúú úúú   ú úúú úúú  Zaniechanie poboru           ú úúú úúú '
@ 19,0 say ' od spisu z natury            ú úúú úúú  DO WPLATY DO US              ú úúú úúú '
@ 20,0 say ' zapl.za sr.transp            ú úúú úúú  Zwrot za kasy                ú úúú úúú '
@ 21,0 say 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Nadwyzka(Na rach)ú úúú úúú ( ú úúú úúú)'
@ 22,0 say ' RAZEM NALEZNY    ú úúú úúú   ú úúú úúú  (60dni/180dni)  (ú úúú úúú / ú úúú úúú)'
@ 23,0 say '                                         Do przeniesienia             ú úúú úúú '
@ 24,0 say '                                         Nieodliczone  pal         poj          '
*################################ OBLICZENIA ################################
*wartprzek=p98b
****************************
set color to +w
@ 19,41 say 'DO WPLATY DO US'

@  7,18 say tran(p64,RVPIC)
@  8,18 say tran(p64exp,RVPIC)
@  9,18 say tran(p67,RVPIC)
@ 10,18 say tran(p67art129,RVPIC)
@ 11,18 say tran(p61,RVPIC)
@ 11,30 say tran(p62,RVPIC)
@ 12,18 say tran(p69,RVPIC)
@ 12,30 say tran(p70,RVPIC)
@ 13,18 say tran(p71,RVPIC)
@ 13,30 say tran(p72,RVPIC)
@ 14,18 say tran(p65ue,RVPIC)
@ 15,18 say tran(p65,RVPIC)

@ 16,18 say tran(p65dekue,RVPIC)
@ 16,30 say tran(p65vdekue,RVPIC)
@ 17,18 say tran(p65dekus,RVPIC)
@ 17,30 say tran(p65vdekus,RVPIC)
@ 18,18 say tran(p65dekwe,RVPIC)
@ 18,30 say tran(p65vdekwe,RVPIC)

@ 19,30 say tran(pp12,RVPIC)
@ 20,30 say tran(znowytran,RVPIC)
@ 22,18 say tran(p75,RVPIC)
@ 22,30 say tran(p76,RVPIC)

@  7,70 say tran(pp8,RVPIC)
@  8,70 say tran(pp11,RVPIC)

@ 10,58 say tran(p45dek,RVPIC)
@ 10,70 say tran(p46dek,RVPIC)
@ 11,58 say tran(p49dek,RVPIC)
@ 11,70 say tran(p50dek,RVPIC)

@ 13,70 say tran(zkorekst,RVPIC)
@ 14,70 say tran(zkorekpoz,RVPIC)

@ 16,70 say tran(p79,RVPIC)

@ 17,70 say tran(p98a,DRVPIC)
@ 18,70 say tran(pp13,DRVPIC)
@ 19,70 say tran(p98b,DRVPIC)

@ 20,70 say tran(p99a,DRVPIC)
@ 21,58 say tran(p99,DRVPIC)
@ 21,70 say tran(p99c,RVPIC)
@ 22,58 say tran(p99ab,RVPIC)
@ 22,70 say tran(p99b,RVPIC)
@ 23,70 say tran(p99d,RVPIC)
@ 24,58 say ' '+alltrim(tran(zpaliwa,RVPIC))
@ 24,70 say ' '+alltrim(tran(zpojazdy,RVPIC))

sele firma
*################################## PRZEKAZ #################################
zNAZWA_PLA=nazwa
zULICA_PLA=alltrim(ulica)+' '+alltrim(nr_domu)+iif(len(alltrim(nr_mieszk))>0,'/'+alltrim(nr_mieszk),'')
zMIEJSC_PLA=alltrim(kod_p)+' '+alltrim(miejsc)
zBANK_PLA=bank
zKONTO_PLA=nr_konta
ztr1=padr(strtran(alltrim(nip),'-',''),14)
ztr2=' N  '
if zVATOKRES='M'
   ztr3=' '+substr(param_rok,3,2)+'M'+strtran(padl(miesiac,2),' ','0')+'  '
else
   ztr3=' '+substr(param_rok,3,2)+'K'+strtran(padl(str(kwarta,2),2),' ','0')+'  '
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
   do csvvat7
endif

sele urzedy
clear type
kkk=inkey(0)
zPodatki=.t.
do case
case kkk=68.or.kkk=100

     //x=fcreate('c:\ekrvat.txt',0)
     zm=savescreen(0,0,24,79)
     zm__=''
     zm__=zm__+&kod_res+&kod_12cp+&kod_6wc
     zm__=zm__+repl('=',80)+chr(13)+chr(10)
     zm__=zm__+''+chr(13)+chr(10)
     zm__=zm__+padc(alltrim(firma->nazwa),80)+chr(13)+chr(10)
     if zVATOKRES='M'
        zm__=zm__+padc('Miesi&_a.c '+param_rok+'.'+strtran(padl(miesiac,2),' ','0'),80)+chr(13)+chr(10)
     else
        zm__=zm__+padc('Kwarta&_l. '+param_rok+'.'+strtran(padl(str(kwarta,2),2),' ','0'),80)+chr(13)+chr(10)
     endif
     zm__=zm__+''+chr(13)+chr(10)
     for j=4 to 24
         for i=1 to 159 step 2
             zm__=zm__+substr(zm,j*160+i,1)
         next
         zm__=zm__+chr(13)+chr(10)
     next
     zm__=zm__+''+chr(13)+chr(10)
     zm__=zm__+repl('=',80)+chr(13)+chr(10)
     zm__=zm__+&kod_ff
     //fwrite(x,zm__,len(zm__))
     //fclose(x)
     //!copy c:\ekrvat.txt lpt1:
     DrukujNowyProfil(zm__)

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
     przek( zNAZWA_WIE,;
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
endcase
zPodatki=.f.
sele firma
****************************
proc CSVVAT7
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
