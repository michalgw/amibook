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

****
* Ten plik zawiera definicje komend, operatorow, pseudofunkcji
* i nazw uzywanych podczas lawinowego ksiegowania dokumentow
* Do programu wstaw:   #include "ami_book.ch"
*
* Plik ami_book.ch wstaw do katalogu INCLUDE
****

#command AKTPOL- <pole> WITH <wartosc> => repl <pole> with <pole> - <wartosc>
#command AKTPOL+ <pole> WITH <wartosc> => repl <pole> with <pole> + <wartosc>

#command AKTPOZ- =>    repl pozycje with pozycje-1
#command AKTPOZ+ =>    repl pozycje with pozycje+1

#command OBROT+  =>    repl pozycje with pozycje+1,&zm with &zm +zwyr_tow
#command OBROT-  =>    repl pozycje with pozycje-1,&zm with &zm -obrot_

#command STANUJ  =>    repl stan with stan-stan_

#command SUMY-   =>  aktpol- wyr_tow  with oper->wyr_tow   ;;
                      aktpol- uslugi   with oper->uslugi  ;;
                      aktpol- zakup    with oper->zakup   ;;
                      aktpol- uboczne  with oper->uboczne ;;
                      aktpol- wynagr_g with oper->wynagr_g;;
                      aktpol- wydatki  with oper->wydatki ;;
                      aktpol- pusta    with oper->pusta

#command SUMY+   =>  aktpol+ wyr_tow  with zwyr_tow   ;;
                      aktpol+ uslugi   with zuslugi  ;;
                      aktpol+ zakup    with zzakup   ;;
                      aktpol+ uboczne  with zuboczne ;;
                      aktpol+ wynagr_g with zwynagr_g;;
                      aktpol+ wydatki  with zwydatki ;;
                      aktpol+ pusta    with zpusta

#command FREEMIN =>  aktpol- p_free with (oper->WYR_TOW+oper->USLUGI) ;;
                     aktpol- k_free with (oper->ZAKUP+oper->UBOCZNE+oper->WYNAGR_G+oper->WYDATKI)

#command ADDDOC  =>  repl firma with ident_fir,mc with miesiac

#command ADDPOZ  =>  repl dzien with zdzien,numer with znumer,nazwa with znazwa,;
                          adres with zadres,nr_ident with znr_ident,tresc with ztresc

#command ADDREJS  =>  repl roks with str(year(zdatas),4),mcs with str(month(zdatas),2),;
                          dziens with str(day(zdatas),2),uwagi with zuwagi,rach with zrach,;
                          wartzw with zwartzw,wart08 with zwart08,wart00 with zwart00,wart07 with zwart07,wart02 with zwart02,;
                          wart22 with zwart22,wart12 with zwart12,vat02 with zvat02,vat07 with zvat07,vat22 with zvat22,vat12 with zvat12,;
                          korekta with zkorekta,sek_cv7 with zsek_cv7,;
                          export with zexport,ue with zue,kraj with zkraj,detal with zdetal,;
                          symb_rej with zsymb_rej,ROZRZAPS with zROZRZAPS,ZAP_TER with zZAP_TER,ZAP_DAT  with zZAP_DAT,ZAP_WART with zZAP_WART,;
                          datatran WITH zDATATRAN, OPCJE WITH zOPCJE, PROCEDUR WITH zPROCEDUR

#command ADDREJZ  =>  repl roks with str(year(zdatas),4),mcs with str(month(zdatas),2),;
                          dziens with str(day(zdatas),2),uwagi with zuwagi,rach with zrach,;
                          wartzw with zwartzw,wart00 with zwart00,wart02 with zwart02,wart07 with zwart07,;
                          wart22 with zwart22,wart12 with zwart12,vat02 with zvat02,vat07 with zvat07,vat22 with zvat22,vat12 with zvat12,;
                          korekta with zkorekta,;
                          export with zexport,ue with zue,kraj with zkraj,detal with zdetal,;
                          symb_rej with zsymb_rej,uslugaue with zuslugaue,wewdos with zwewdos,sek_cv7 with zsek_cv7,;
                          paliwa with zpaliwa,pojazdy with zpojazdy,dataks with zdataks,;
                          ROZRZAPZ with zROZRZAPZ,ZAP_TER with zZAP_TER,ZAP_DAT  with zZAP_DAT,ZAP_WART with zZAP_WART,;
                          OPCJE with zOPCJE, datatran WITH zDATATRAN
