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

para _G,_M,_STR,_OU
RAPORT=RAPTEMP
***********************************************
* zPODATKI ustawiane w wywoˆuj¥cych programach
* .t. - gdy przelew podatkowy
* .f. - gdy zwykly przelew
***********************************************
*_czy_close=.f.
*################################# Nowy PRZELEW   #############################
begin sequence
   sele 100
   do while.not.dostepex(RAPORT)
   enddo
   do case
   case _OU='D'
      do case
      case _STR=1
//         zNAZWA_WIE
//         zNAZWA_PLA
//         zULICA_WIE
//         zULICA_PLA
//         zMIEJSC_WIE
//         zMIEJSC_PLA
//         zBANK_WIE
//         zBANK_PLA
//         zKONTO_WIE
//         zKONTO_PLA
//         zKWOTA
//         zTRESC
//         zDATA
*           zPODATKI=.f.
*           if substr(zTRESC,28,3)='PIT'.or.substr(zTRESC,28,3)='VAT'
*              zPODATKI=.t.
*           endif
           zKONTO_WIE=alltrim(strtran(strtran(zKONTO_WIE,' ',''),'-',''))
           zKONTO_WIE=substr(zKONTO_WIE,1,2)+' '+substr(zKONTO_WIE,3,4)+' '+substr(zKONTO_WIE,7,4)+' '+substr(zKONTO_WIE,11,4)+' '+substr(zKONTO_WIE,15,4)+' '+substr(zKONTO_WIE,19,4)+' '+substr(zKONTO_WIE,23,4)
           zKONTO_PLA=alltrim(strtran(strtran(zKONTO_PLA,' ',''),'-',''))
           zKONTO_PLA=substr(zKONTO_PLA,1,2)+' '+substr(zKONTO_PLA,3,4)+' '+substr(zKONTO_PLA,7,4)+' '+substr(zKONTO_PLA,11,4)+' '+substr(zKONTO_PLA,15,4)+' '+substr(zKONTO_PLA,19,4)+' '+substr(zKONTO_PLA,23,4)
           zOPI_PLA=padr(alltrim(zNAZWA_PLA)+' '+alltrim(zULICA_PLA)+' '+alltrim(zMIEJSC_PLA),104)
*           zOPI_PLA=iif(zPODATKI,rozrzut(zOPI_PLA),zOPI_PLA)
           zOPI_WIE=padr(alltrim(zNAZWA_WIE)+' '+alltrim(zULICA_WIE)+' '+alltrim(zMIEJSC_WIE),104)
*           zOPI_WIE=iif(zPODATKI,rozrzut(zOPI_WIE),zOPI_WIE)
           zTRESC=upper(zTRESC)
           if zPODATKI=.t.
              zzTRESC=substr(rozrzut(substr(zTRESC,1,14)),2)+space(3)+substr(zTRESC,16,1)+space(6)+substr(rozrzut(substr(zTRESC,20,7)),2)+space(2)+substr(rozrzut(substr(zTRESC,27,7)),2)+space(1)+substr(zTRESC,34,20)
           else
              zzTRESC=substr(zTRESC,1,104)
           endif
*           zzTRESC=upper(iif(zPODATKI,rozrzut(zTRESC),substr(zTRESC,1,104)))
           for x=1 to _G
               rl()
           next
           rl(space(_M)+space(1)+padr(substr(zKONTO_WIE,1,19),19)+space(5)+substr(zOPI_WIE,1,52))
           rl()
           rl(space(_M)+space(1)+padr(substr(zKONTO_WIE,20),19)+space(5)+substr(zOPI_WIE,53,52))
           rl()
*           if len(alltrim(zKONTO_WIE))<=36
              rl(space(_M)+space(1)+substr(zOPI_WIE,1,19)+space(5)+substr(zKONTO_WIE,1,2)+'  '+padc(substr(zKONTO_WIE,4,4),6)+'  '+padc(substr(zKONTO_WIE,9,4),6)+'  '+padc(substr(zKONTO_WIE,14,4),6)+'  '+padc(substr(zKONTO_WIE,19,4),6)+'  '+padc(substr(zKONTO_WIE,24,4),6)+'  '+padc(substr(zKONTO_WIE,29,4),6))
              rl(space(_M)+space(1)+substr(zOPI_WIE,20,19))
              rl(space(_M)+space(1)+substr(zOPI_WIE,39,19)+space(35)+'**'+alltrim(str(zKWOTA,12,2)))
*           else
*              rl(space(_M)+space(1)+substr(zOPI_WIE,1,19)+space(5)+rozrzut(substr(zKONTO_WIE,1,2))+rozrzut(substr(zKONTO_WIE,4,8))+' '+padc(alltrim(substr(zKONTO_WIE,13)),36))
*              rl(space(_M)+space(1)+substr(zOPI_WIE,20,19))
*              rl(space(_M)+space(1)+substr(zOPI_WIE,39,19)+space(35)+rozrzut(alltrim(str(zKWOTA,12,2))))
*           endif
           rl()
*           if len(alltrim(zKONTO_PLA))<=29
              rl(space(_M)+space(1)+padr('**'+alltrim(str(zKWOTA,12,2)),19)+space(5)+substr(zKONTO_PLA,1,2)+'  '+padc(substr(zKONTO_PLA,4,4),6)+'  '+padc(substr(zKONTO_PLA,9,4),6)+'  '+padc(substr(zKONTO_PLA,14,4),6)+'  '+padc(substr(zKONTO_PLA,19,4),6)+'  '+padc(substr(zKONTO_PLA,24,4),6)+'  '+padc(substr(zKONTO_PLA,29,4),6))
*           else
*              rl(space(_M)+space(1)+padr('**'+alltrim(str(zKWOTA,12,2)),19)+space(5)+rozrzut(substr(zKONTO_PLA,1,2))+rozrzut(substr(zKONTO_PLA,4,8))+' '+padc(alltrim(substr(zKONTO_PLA,13)),36))
*           endif
           if len(alltrim(zzTRESC))>19
              rl(space(_M)+space(1)+substr(zzTRESC,1,19))
              rl(space(_M)+space(1)+padr(substr(zzTRESC,20),19)+space(5)+substr(zOPI_PLA,1,52))
           else
              rl()
              rl(space(_M)+space(1)+padr(alltrim(zzTRESC),19)+space(5)+substr(zOPI_PLA,1,52))
           endif
           rl()
           rl(space(_M)+space(1)+substr(zOPI_PLA,1,19)+space(5)+substr(zOPI_PLA,53,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,20,19))
           rl(space(_M)+space(1)+substr(zOPI_PLA,39,19)+space(5)+substr(zzTRESC,1,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,58,19))
           rl(space(_M)+space(1)+substr(zOPI_PLA,77,19)+space(5)+substr(zzTRESC,53,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,96,19))
           for x=1 to 7
               rl()
           next
           rl(space(_M)+space(1)+padr(substr(zKONTO_WIE,1,19),19)+space(5)+substr(zOPI_WIE,1,52))
           rl()
           rl(space(_M)+space(1)+padr(substr(zKONTO_WIE,20),19)+space(5)+substr(zOPI_WIE,53,52))
           rl()
*           if len(alltrim(zKONTO_WIE))<=36
              rl(space(_M)+space(1)+substr(zOPI_WIE,1,19)+space(5)+substr(zKONTO_WIE,1,2)+'  '+padc(substr(zKONTO_WIE,4,4),6)+'  '+padc(substr(zKONTO_WIE,9,4),6)+'  '+padc(substr(zKONTO_WIE,14,4),6)+'  '+padc(substr(zKONTO_WIE,19,4),6)+'  '+padc(substr(zKONTO_WIE,24,4),6)+'  '+padc(substr(zKONTO_WIE,29,4),6))
              rl(space(_M)+space(1)+substr(zOPI_WIE,20,19))
              rl(space(_M)+space(1)+substr(zOPI_WIE,39,19)+space(35)+'**'+alltrim(str(zKWOTA,12,2)))
*           else
*              rl(space(_M)+space(1)+substr(zOPI_WIE,1,19)+space(5)+rozrzut(substr(zKONTO_WIE,1,2))+rozrzut(substr(zKONTO_WIE,4,8))+' '+padc(alltrim(substr(zKONTO_WIE,13)),36))
*              rl(space(_M)+space(1)+substr(zOPI_WIE,20,19))
*              rl(space(_M)+space(1)+substr(zOPI_WIE,39,19)+space(35)+rozrzut(alltrim(str(zKWOTA,12,2))))
*           endif
           rl()
*           if len(alltrim(zKONTO_PLA))<=29
              rl(space(_M)+space(1)+padr('**'+alltrim(str(zKWOTA,12,2)),19)+space(5)+substr(zKONTO_PLA,1,2)+'  '+padc(substr(zKONTO_PLA,4,4),6)+'  '+padc(substr(zKONTO_PLA,9,4),6)+'  '+padc(substr(zKONTO_PLA,14,4),6)+'  '+padc(substr(zKONTO_PLA,19,4),6)+'  '+padc(substr(zKONTO_PLA,24,4),6)+'  '+padc(substr(zKONTO_PLA,29,4),6))
*           else
*              rl(space(_M)+space(1)+padr('**'+alltrim(str(zKWOTA,12,2)),19)+space(5)+rozrzut(substr(zKONTO_PLA,1,2))+rozrzut(substr(zKONTO_PLA,4,8))+' '+padc(alltrim(substr(zKONTO_PLA,13)),36))
*           endif
           if len(alltrim(zzTRESC))>19
              rl(space(_M)+space(1)+substr(zzTRESC,1,19))
              rl(space(_M)+space(1)+padr(substr(zzTRESC,20),19)+space(5)+substr(zOPI_PLA,1,52))
           else
              rl()
              rl(space(_M)+space(1)+padr(alltrim(zzTRESC),19)+space(5)+substr(zOPI_PLA,1,52))
           endif
           rl()
           rl(space(_M)+space(1)+substr(zOPI_PLA,1,19)+space(5)+substr(zOPI_PLA,53,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,20,19))
           rl(space(_M)+space(1)+substr(zOPI_PLA,39,19)+space(5)+substr(zzTRESC,1,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,58,19))
           rl(space(_M)+space(1)+substr(zOPI_PLA,77,19)+space(5)+substr(zzTRESC,53,52))
           rl(space(_M)+space(1)+substr(zOPI_PLA,96,19))
      endcase
   case _OU='P'
      rl()
      rl(padc('PRZELEW ISTNIEJE TYLKO W FORMIE "DO ZADRUKOWANIA". PODGLAD NIE ISTNIEJE',80))
      rl(padc('=======================================================================',80))
   endcase
end
*close_()
