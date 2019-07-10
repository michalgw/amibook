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

**********************************************************************
*** PRZEK.prg - drukowanie PRZEkazu                              ***
**********************************************************************

FUNCTION Przek( WIERZ1,;
     PLATNIK1,;
     WIERZ2,;
     PLATNIK2,;
     WIERZ3,;
     PLATNIK3,;
     BANK_WIERZ,;
     KONT_WIERZ,;
     WARD,;
     TYTUL )

WIERZ1    =alltrim(WIERZ1    )
PLATNIK1  =alltrim(PLATNIK1  )
WIERZ2    =alltrim(WIERZ2    )
PLATNIK2  =alltrim(PLATNIK2  )
WIERZ3    =alltrim(WIERZ3    )
PLATNIK3  =alltrim(PLATNIK3  )
BANK_WIERZ=alltrim(BANK_WIERZ)
KONT_WIERZ=alltrim(KONT_WIERZ)
TYTUL     =alltrim(TYTUL     )

wiersz=array(22)

//do while .not. isprinter()
//   kom(3,[*u],[ Przygotuj drukark&_e. do drukowania ])
//   IF LASTKEY()=27
//      EXIT
//   ENDIF
//enddo

if lastkey() = 27
   return
endif
save scre to SCRKP
CURR=ColInb()
@ 24,0
center(24,'Prosz&_e. czeka&_c.. Drukuj&_e. przekaz')
setcolor(CURR)
//set cons off
//set device to print
//set print on
wiersz[1]='|'+padc(' Odcinek dla poczty ',42,'=')+'|'+padc(' Odcinek dla posiadacza r-ku ',42,'=')+'|'+padc(' Potwierdzenie dla wplacaj&_a.cego ',42,'=')+'|'
wiersz[2]='| '+padr('Z&__L.OTYCH: '+tran(WARD,' 999 999 999 999.99'),40)+' | '+padr('Z&__L.OTYCH: '+tran(WARD,' 999 999 999 999.99'),40)+' | '+padr('Z&__L.OTYCH: '+tran(WARD,' 999 999 999 999.99'),40)+' |'
slowcyf=slownie(ward)
if len(SLOWcyf)<144
   SLOWcyf=SLOWcyf+space(84-len(SLOWcyf))
endif
for X=0 to 1
    wiersz[3+X]='| '+padc(substr(SLOWcyf,(40*X)+1,40),40,'=')+' | '+padc(substr(SLOWcyf,(40*X)+1,40),40,'=')+' | '+padc(substr(SLOWcyf,(40*X)+1,40),40,'=')+' |'
next
CIEZ1=substr(PLATNIK1,1,28)
CIEZ2=substr(PLATNIK1,29)
wiersz[5]='| WP&__L.ACAJ&__A.CY: '+padr(CIEZ1,28)+' | WP&__L.ACAJ&__A.CY: '+padr(CIEZ1,28)+' | WP&__L.ACAJ&__A.CY: '+padr(CIEZ1,28)+' |'
wiersz[6]='| '+padr(CIEZ2,40)+' | '+padr(CIEZ2,40)+' | '+padr(CIEZ2,40)+' |'
wiersz[7]='| '+padc(PLATNIK2,40)+' | '+padc(PLATNIK2,40)+' | '+padc(PLATNIK2,40)+' |'
wiersz[8]='| '+padc(PLATNIK3,40)+' | '+padc(PLATNIK3,40)+' | '+padc(PLATNIK3,40)+' |'
DOBR1=substr(WIERZ1,1,28)
DOBR2=substr(WIERZ1,29)
wiersz[9]='| NA RACHUNEK:'+padr(DOBR1,28)+' | NA RACHUNEK:'+padr(DOBR1,28)+' | NA RACHUNEK:'+padr(DOBR1,28)+' |'
wiersz[10]='| '+padr(DOBR2,40)+' | '+padr(DOBR2,40)+' | '+padr(DOBR2,40)+' |'
wiersz[11]='| '+padc(WIERZ2,40)+' | '+padc(WIERZ2,40)+' | '+padc(WIERZ2,40)+' |'
wiersz[12]='| '+padc(WIERZ3,40)+' | '+padc(WIERZ3,40)+' | '+padc(WIERZ3,40)+' |'
wiersz[13]='|'+repl('-',42)+'|'+repl('-',42)+'|'+repl('-',42)+'|'
wiersz[14]='| Bank :'+padr(BANK_WIERZ,34)+' | Bank :'+padr(BANK_WIERZ,34)+' | Bank :'+padr(BANK_WIERZ,34)+' |'
wiersz[15]='| Konto:'+padr(KONT_WIERZ,35)+'| Konto:'+padr(KONT_WIERZ,35)+'| Konto:'+padr(KONT_WIERZ,35)+'|'
wiersz[16]='| '+padc(TYTUL,40)+' | '+padc(TYTUL,40)+' | '+padc(TYTUL,40)+' |'
wiersz[17]='|'+repl('-',42)+'|'+repl('-',42)+'|'+repl('-',42)+'|'
wiersz[18]='|'+space(24)+'|'+space(17)+'|'+space(24)+'|'+space(17)+'|'+space(24)+'|'+space(17)+'|'
wiersz[19]='|'+space(24)+'|'+space(17)+'|'+space(24)+'|'+space(17)+'|'+space(24)+'|'+space(17)+'|'
wiersz[20]='|'+padc('stempel,data i podpis',24,'_')+'|'+padc('pobrana op&_l.ata',17,'_')+'|'+padc('stempel,data i podpis',24,'_')+'|'+padc('pobrana op&_l.ata',17,'_')+'|'+padc('stempel,data i podpis',24,'_')+'|'+padc('pobrana oplata',17,'_')+'|'
//??&kod_17cp+&kod_6wc
buforDruku = &kod_17cp+&kod_6wc
for x=1 to 20
    //? wiersz[x]
    buforDruku = buforDruku + wiersz[x] + &kod_lf
next
//?
//set print to
//set print off
//set device to screen
//set cons on
DrukujNowyProfil(buforDruku)
buforDruku = ''

@ 24,0
set color to
rest scre from SCRKP
