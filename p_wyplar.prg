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

*############################### OTWARCIE BAZ ###############################
ColInf()
@  3,0 say '[B,W]-wplata gotowkowa   [L,N]-przelew   [P]-wplata pocztowa   [D]-wydruk ekranu'
ColStd()
@  4,0 say [                                                                                ]
@  5,0 say [                 INFORMACJA O ZRYCZALTOWANYM PODATKU DOCHODOWYM                 ]
@  6,0 say padc('Za okres '+param_rok+'.'+miesiac,80)
@  7,0 say [C.1 - C12 - sumarycznie...............................................          ]
@  8,0 say [C.13      - inne nale&_z.no&_s.ci...........................................          ]
@  9,0 say [                                                                                ]
@ 10,0 say [C.14      - Suma pobranego zrycza&_l.towanego podatku....................          ]
@ 11,0 say [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
@ 12,0 say [C.15      - Kwota potr&_a.conego wynagrodzenia z tytu&_l.u terminowej wp&_l.aty          ]
@ 13,0 say [C.16      - Kwota podatku do wp&_l.aty...................................          ]
@ 14,0 say [                                                                                ]
@ 15,0 say [                                                                                ]
@ 16,0 say [                                                                                ]
@ 17,0 say [                                                                                ]
@ 18,0 say [                                                                                ]
@ 19,0 say [                                                                                ]
@ 20,0 say [                                                                                ]
@ 21,0 say [                                                                                ]
@ 22,0 say [                                                                                ]
ColInf()
center(4,dos_c([ P&_l.atnik - ]+alltrim(P8)+[ ]))
ColStd()
set color to +w
xxxmm=strtran(miesiac,' ','0')
@  7,70 say z1&xxxmm pict '9999999'
@  8,70 say z2&xxxmm pict '9999999'
@ 10,70 say z3&xxxmm pict '9999999'
@ 12,70 say z4&xxxmm pict '9999999'
@ 13,70 say z5&xxxmm pict '9999999'

wartprzek=z5&xxxmm
set color to
*sele spolka
*################################## PRZEKAZ #################################
zNAZWA_PLA=alltrim(p8)
zULICA_PLA=alltrim(p19)+' '+alltrim(p20)+iif(len(alltrim(p21))>0,'/'+alltrim(p21),'')
zMIEJSC_PLA=alltrim(p23)+' '+alltrim(p22)
zBANK_PLA=firma->bank
zKONTO_PLA=firma->nr_konta
ztr1=padr(strtran(alltrim(p1),'-',''),14)
ztr2=' N  '
ztr3=' '+substr(param_rok,3,2)+'M'+strtran(padl(miesiac,2),' ','0')+'  '
ztr4='PI8AR  '
zTRESC=ztr1+ztr2+ztr3+ztr4
*zTRESC='PIT27 '+miesiac+'.'+param_rok+' NIP:'+padc(alltrim(nip),13)

*sele 7
*do while.not.dostep('URZEDY')
*enddo
*set inde to urzedy
*go spolka->skarb
zNAZWA_WIE='URZ&__A.D SKARBOWY '+alltrim(URZEDY->URZAD)
zULICA_WIE=alltrim(URZEDY->ULICA)+' '+alltrim(URZEDY->NR_DOMU)
zMIEJSC_WIE=alltrim(URZEDY->KOD_POCZT)+' '+alltrim(URZEDY->MIEJSC_US)
zBANK_WIE=URZEDY->BANK
zKONTO_WIE=URZEDY->KONTODOCH

if nr_uzytk=108
   do csvpit8r
endif

sele 100
clear type
kkk=inkey(0)
zPodatki=.t.
do case
case kkk=68.or.kkk=100

     //x=fcreate('c:\ekrwypl.txt',0)
     zm=savescreen(0,0,24,79)
     zm__=''
     zm__=zm__+&kod_res+&kod_12cp+&kod_6wc
     zm__=zm__+repl('=',80)+chr(13)+chr(10)
     zm__=zm__+''+chr(13)+chr(10)
     for j=4 to 22
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
     //!copy c:\ekrwypl.txt lpt1:
     DrukujNowyProfil(zm__)

case kkk=87.or.kkk=119.or.kkk=66.or.kkk=98

zNAZWA_PLA=zNAZWA_PLA+space(30)
@ 23,0  clear to 23,79
@ 23,0 say [Nazwa wp&_l.acaj&_a.cego] get zNAZWA_PLA pict repl('X',60)
read_()

     save screen to scr_
     zKWOTA=wartprzek
     afill(nazform,'')
     afill(strform,0)
     nazform[1]='WPLATN'
     strform[1]=1
     form(nazform,strform,1)
     restore screen from scr_
case kkk=78.or.kkk=110.or.kkk=76.or.kkk=108

zNAZWA_PLA=zNAZWA_PLA+space(30)
@ 23,0  clear to 23,79
@ 23,0 say [Nazwa wp&_l.acaj&_a.cego] get zNAZWA_PLA pict repl('X',60)
read_()

     save screen to scr_
     zKWOTA=wartprzek
     afill(nazform,'')
     afill(strform,0)
     nazform[1]='PRZELN'
     strform[1]=1
     form(nazform,strform,1)
     restore screen from scr_
case kkk=80 .or. kkk=112

zNAZWA_PLA=zNAZWA_PLA+space(30)
@ 23,0  clear to 23,79
@ 23,0 say [Nazwa wp&_l.acaj&_a.cego] get zNAZWA_PLA pict repl('X',60)
read_()

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
*    do przekaz with wartprzek,'D'
     restore screen from scr3
endcase
zPodatki=.f.
****************************
proc CSVPIT8r
****************************
//tworzenie bazy roboczej

save scre to _csvscre_

ColInb()
@ 24,0 clear
center(24,[Preparuj&_e. dane do internetu. Prosz&_e. czeka&_c....])
set color to


_konc_=substr(param_rok,3,2)+strtran(padl(miesiac,2),' ','0')
_plik_='PIT8'+_konc_



      if file(_plik_+'.dbf')=.f.
*        wait 'brak pliku dbf'
         dbcreate(_plik_,{;
                 {"NIPFIRMY", "C", 10, 0},;
                 {"NIPPODAT", "C", 10, 0},;
                 {"PODATNICY","N",  2, 0},;
                 {"WYPLATY",  "N", 15, 2},;
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
               repl PODATNICY with p29,WYPLATY with p30,;
                    PODATEK with p33,DATAAKT with date()
               commit_()
            else
               appe blan
               repl NIPFIRMY with alltrim(strtran(firma->nip,'-','')),NIPPODAT with alltrim(ztr1)
               repl PODATNICY with p29,WYPLATY with p30,;
                    PODATEK with p33,DATAAKT with date()
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
****************************
