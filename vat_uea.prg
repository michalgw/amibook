/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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
*RAPORT=RAPTEMP
*private P4,P5,P6,P7,P8
*private P11,P16,P17,P17a,P18,P19
*private P20,P21,P22,P23,P24,P26,P29
*private P35,P36,P37,P38,P39
*private P40,P41,P42,P43,P44,P45,P46,P47,P48,P49
*private P50,P51,P52,P53,P54,P55,P56,P57,P58,P59
*private P60,P61,P62,P61a,P62a,P64,P66,P68
*store 0 to P22,P23,P26,P35,P36,P37,P38
*store 0 to P39,P40,P41,P42,P43,P44,P45,P46,P47,P48,P49,P50,P51,P52,P53,P54,P55
*store 0 to P56,P57,P58,P59,P60,P61,P62,P61a,P62a,P64,P66,P68
*store '' to P4,P5,P6,P7,P8,P11,P16,P17,P17a,P18,P19,P20,P21,P29
*#################################     VAT_UE     #############################
UEspr=array(59,4)
for licznik=1 to 59
    UEspr[licznik,1]='  '
    UEspr[licznik,2]=space(30)
    UEspr[licznik,3]=0
    UEspr[licznik,4]='  '
next
licznik=1
sele 2
seek 'S'
do while .not. eof() .and. licznik<(13+((numzal-1)*59))
   if REJ='S' .and. usluga='N'
      licznik=licznik+1
   endif
   skip
enddo
*for licznik=1 to 9+((numzal-1)*53)
*    if REJ='Z' .and. korekta='N'
*       licznik=licznik+1
*    endif
*    skip
*next
*seek 'S'
licznik=1
do while .not. eof() .and. licznik<60
   if REJ='S' .and. usluga='N'
      UEspr[licznik,1]=kraj
      UEspr[licznik,2]=VATid
      UEspr[licznik,3]=wartosc
      UEspr[licznik,4]=iif(trojca='T','XX','  ')
      licznik=licznik+1
   endif
   skip
enddo
* zaokraglanie wartosci
for licznik=1 to 59
    UEspr[licznik,3]=_round(UEspr[licznik,3],0)
next
begin sequence
   *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
   sele 100
   do while.not.dostepex(RAPORT)
   enddo
   do case
   case _OU='D'
        do case
        case _STR=1
             for x=1 to _G
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(P4))
             for x=1 to 5
                 rl()
             next
             rl(space(_M)+space(29)+rozrzut(p5a)+'     '+rozrzut(p5b)+space(18)+rozrzut(str(numzal,2,0)))
             for x=1 to 5
                 rl()
             next
             if spolka_
                rl(space(_M)+space(19)+'XXX')
             else
                rl(space(_M)+space(55)+'XXX')
             endif
             rl()
             rl()
             rl(space(_M)+space(7)+padc(alltrim(P8)+'   '+P11,60))
             for x=1 to 6
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEspr[1,1])+space(4)+UEspr[1,2]+space(5)+kwota(UEspr[1,3],15,0)+space(4)+UEspr[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[2,1])+space(4)+UEspr[2,2]+space(5)+kwota(UEspr[2,3],15,0)+space(4)+UEspr[2,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[3,1])+space(4)+UEspr[3,2]+space(5)+kwota(UEspr[3,3],15,0)+space(4)+UEspr[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[4,1])+space(4)+UEspr[4,2]+space(5)+kwota(UEspr[4,3],15,0)+space(4)+UEspr[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[5,1])+space(4)+UEspr[5,2]+space(5)+kwota(UEspr[5,3],15,0)+space(4)+UEspr[5,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[6,1])+space(4)+UEspr[6,2]+space(5)+kwota(UEspr[6,3],15,0)+space(4)+UEspr[6,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[7,1])+space(4)+UEspr[7,2]+space(5)+kwota(UEspr[7,3],15,0)+space(4)+UEspr[7,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[8,1])+space(4)+UEspr[8,2]+space(5)+kwota(UEspr[8,3],15,0)+space(4)+UEspr[8,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[9,1])+space(4)+UEspr[9,2]+space(5)+kwota(UEspr[9,3],15,0)+space(4)+UEspr[9,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[10,1])+space(4)+UEspr[10,2]+space(5)+kwota(UEspr[10,3],15,0)+space(4)+UEspr[10,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[11,1])+space(4)+UEspr[11,2]+space(5)+kwota(UEspr[11,3],15,0)+space(4)+UEspr[11,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[12,1])+space(4)+UEspr[12,2]+space(5)+kwota(UEspr[12,3],15,0)+space(4)+UEspr[12,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[13,1])+space(4)+UEspr[13,2]+space(5)+kwota(UEspr[13,3],15,0)+space(4)+UEspr[13,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[14,1])+space(4)+UEspr[14,2]+space(5)+kwota(UEspr[14,3],15,0)+space(4)+UEspr[14,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[15,1])+space(4)+UEspr[15,2]+space(5)+kwota(UEspr[15,3],15,0)+space(4)+UEspr[15,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[16,1])+space(4)+UEspr[16,2]+space(5)+kwota(UEspr[16,3],15,0)+space(4)+UEspr[16,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[17,1])+space(4)+UEspr[17,2]+space(5)+kwota(UEspr[17,3],15,0)+space(4)+UEspr[17,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[18,1])+space(4)+UEspr[18,2]+space(5)+kwota(UEspr[18,3],15,0)+space(4)+UEspr[18,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[19,1])+space(4)+UEspr[19,2]+space(5)+kwota(UEspr[19,3],15,0)+space(4)+UEspr[19,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[20,1])+space(4)+UEspr[20,2]+space(5)+kwota(UEspr[20,3],15,0)+space(4)+UEspr[20,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[21,1])+space(4)+UEspr[21,2]+space(5)+kwota(UEspr[21,3],15,0)+space(4)+UEspr[21,4])
        case _STR=2
             for x=1 to _G
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEspr[22,1])+space(4)+UEspr[22,2]+space(5)+kwota(UEspr[22,3],15,0)+space(4)+UEspr[22,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[23,1])+space(4)+UEspr[23,2]+space(5)+kwota(UEspr[23,3],15,0)+space(4)+UEspr[23,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[24,1])+space(4)+UEspr[24,2]+space(5)+kwota(UEspr[24,3],15,0)+space(4)+UEspr[24,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[25,1])+space(4)+UEspr[25,2]+space(5)+kwota(UEspr[25,3],15,0)+space(4)+UEspr[25,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[26,1])+space(4)+UEspr[26,2]+space(5)+kwota(UEspr[26,3],15,0)+space(4)+UEspr[26,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[27,1])+space(4)+UEspr[27,2]+space(5)+kwota(UEspr[27,3],15,0)+space(4)+UEspr[27,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[28,1])+space(4)+UEspr[28,2]+space(5)+kwota(UEspr[28,3],15,0)+space(4)+UEspr[28,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[29,1])+space(4)+UEspr[29,2]+space(5)+kwota(UEspr[29,3],15,0)+space(4)+UEspr[29,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[30,1])+space(4)+UEspr[30,2]+space(5)+kwota(UEspr[30,3],15,0)+space(4)+UEspr[30,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[31,1])+space(4)+UEspr[31,2]+space(5)+kwota(UEspr[31,3],15,0)+space(4)+UEspr[31,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[32,1])+space(4)+UEspr[32,2]+space(5)+kwota(UEspr[32,3],15,0)+space(4)+UEspr[32,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[33,1])+space(4)+UEspr[33,2]+space(5)+kwota(UEspr[33,3],15,0)+space(4)+UEspr[33,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[34,1])+space(4)+UEspr[34,2]+space(5)+kwota(UEspr[34,3],15,0)+space(4)+UEspr[34,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[35,1])+space(4)+UEspr[35,2]+space(5)+kwota(UEspr[35,3],15,0)+space(4)+UEspr[35,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[36,1])+space(4)+UEspr[36,2]+space(5)+kwota(UEspr[36,3],15,0)+space(4)+UEspr[36,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[37,1])+space(4)+UEspr[37,2]+space(5)+kwota(UEspr[37,3],15,0)+space(4)+UEspr[37,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[38,1])+space(4)+UEspr[38,2]+space(5)+kwota(UEspr[38,3],15,0)+space(4)+UEspr[38,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[39,1])+space(4)+UEspr[39,2]+space(5)+kwota(UEspr[39,3],15,0)+space(4)+UEspr[39,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[40,1])+space(4)+UEspr[40,2]+space(5)+kwota(UEspr[40,3],15,0)+space(4)+UEspr[40,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[41,1])+space(4)+UEspr[41,2]+space(5)+kwota(UEspr[41,3],15,0)+space(4)+UEspr[41,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[42,1])+space(4)+UEspr[42,2]+space(5)+kwota(UEspr[42,3],15,0)+space(4)+UEspr[42,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[43,1])+space(4)+UEspr[43,2]+space(5)+kwota(UEspr[43,3],15,0)+space(4)+UEspr[43,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[44,1])+space(4)+UEspr[44,2]+space(5)+kwota(UEspr[44,3],15,0)+space(4)+UEspr[44,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[45,1])+space(4)+UEspr[45,2]+space(5)+kwota(UEspr[45,3],15,0)+space(4)+UEspr[45,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[46,1])+space(4)+UEspr[46,2]+space(5)+kwota(UEspr[46,3],15,0)+space(4)+UEspr[46,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[47,1])+space(4)+UEspr[47,2]+space(5)+kwota(UEspr[47,3],15,0)+space(4)+UEspr[47,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[48,1])+space(4)+UEspr[48,2]+space(5)+kwota(UEspr[48,3],15,0)+space(4)+UEspr[48,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[49,1])+space(4)+UEspr[49,2]+space(5)+kwota(UEspr[49,3],15,0)+space(4)+UEspr[49,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[50,1])+space(4)+UEspr[50,2]+space(5)+kwota(UEspr[50,3],15,0)+space(4)+UEspr[50,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[51,1])+space(4)+UEspr[51,2]+space(5)+kwota(UEspr[51,3],15,0)+space(4)+UEspr[51,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[52,1])+space(4)+UEspr[52,2]+space(5)+kwota(UEspr[52,3],15,0)+space(4)+UEspr[52,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[53,1])+space(4)+UEspr[53,2]+space(5)+kwota(UEspr[53,3],15,0)+space(4)+UEspr[53,4])
        endcase
   case _OU='P'
        rl(padc('VAT-UE/A  INFORMACJA PODSUMOWUJ&__A.CA O DOKONANYCH UE DOSTAWACH TOWAR&__O.W',80))
        rl('(01) Numer identyfikacyjny podatnika: '+P4)
        rl('(04) Miesiac:'+iif(zUEOKRES='K','  ',miesiac)+'      lub (06) Kwartal: '+iif(zUEOKRES='K',P5a,'  ')+'   (06) rok: '+P5b)
*        rl('(04) Za kwartal: '+P5a+'   (05) rok: '+P5b)
        rl('(07) Numer za&_l.&_a.cznika: '+str(numzal,2,0))
        rl()
        rl(padc('A. DANE IDENTYFIKACYJNE PODATNIKA',80))
        rl(padc('=================================',80))
        if spolka_
           rl('(08) Nazwa pe&_l.na: '+P8)
        else
           rl('(08) Nazwisko,imie,data urodz.: '+P8+'   '+P11)
        endif
        rl()
        rl(padc('B. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYCH DOSTAWACH TOWAR&__O.W',80))
        rl(padc('=======================================================',80))
        rl('  �������������������������������������������������������������������Ŀ')
        rl('  � Kod �      Nr identyfikacyjny      �Kwota transakc.�  Transakcje  �')
        rl('  �kraju�        VAT kontrahenta       �      w z&_l..    � tr&_o.jstronne  �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 1�'+rozrzut(UEspr[1,1])+' �'+UEspr[1,2]+'�'+kwota(UEspr[1,3],15,2)+'�      '+UEspr[1,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 2�'+rozrzut(UEspr[2,1])+' �'+UEspr[2,2]+'�'+kwota(UEspr[2,3],15,2)+'�      '+UEspr[2,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 3�'+rozrzut(UEspr[3,1])+' �'+UEspr[3,2]+'�'+kwota(UEspr[3,3],15,2)+'�      '+UEspr[3,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 4�'+rozrzut(UEspr[4,1])+' �'+UEspr[4,2]+'�'+kwota(UEspr[4,3],15,2)+'�      '+UEspr[4,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 5�'+rozrzut(UEspr[5,1])+' �'+UEspr[5,2]+'�'+kwota(UEspr[5,3],15,2)+'�      '+UEspr[5,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 6�'+rozrzut(UEspr[6,1])+' �'+UEspr[6,2]+'�'+kwota(UEspr[6,3],15,2)+'�      '+UEspr[6,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 7�'+rozrzut(UEspr[7,1])+' �'+UEspr[7,2]+'�'+kwota(UEspr[7,3],15,2)+'�      '+UEspr[7,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 8�'+rozrzut(UEspr[8,1])+' �'+UEspr[8,2]+'�'+kwota(UEspr[8,3],15,2)+'�      '+UEspr[8,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 9�'+rozrzut(UEspr[9,1])+' �'+UEspr[9,2]+'�'+kwota(UEspr[9,3],15,2)+'�      '+UEspr[9,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('10�'+rozrzut(UEspr[10,1])+' �'+UEspr[10,2]+'�'+kwota(UEspr[10,3],15,2)+'�      '+UEspr[10,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('11�'+rozrzut(UEspr[11,1])+' �'+UEspr[11,2]+'�'+kwota(UEspr[11,3],15,2)+'�      '+UEspr[11,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('12�'+rozrzut(UEspr[12,1])+' �'+UEspr[12,2]+'�'+kwota(UEspr[12,3],15,2)+'�      '+UEspr[12,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('13�'+rozrzut(UEspr[13,1])+' �'+UEspr[13,2]+'�'+kwota(UEspr[13,3],15,2)+'�      '+UEspr[13,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('14�'+rozrzut(UEspr[14,1])+' �'+UEspr[14,2]+'�'+kwota(UEspr[14,3],15,2)+'�      '+UEspr[14,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('15�'+rozrzut(UEspr[15,1])+' �'+UEspr[15,2]+'�'+kwota(UEspr[15,3],15,2)+'�      '+UEspr[15,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('16�'+rozrzut(UEspr[16,1])+' �'+UEspr[16,2]+'�'+kwota(UEspr[16,3],15,2)+'�      '+UEspr[16,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('17�'+rozrzut(UEspr[17,1])+' �'+UEspr[17,2]+'�'+kwota(UEspr[17,3],15,2)+'�      '+UEspr[17,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('18�'+rozrzut(UEspr[18,1])+' �'+UEspr[18,2]+'�'+kwota(UEspr[18,3],15,2)+'�      '+UEspr[18,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('19�'+rozrzut(UEspr[19,1])+' �'+UEspr[19,2]+'�'+kwota(UEspr[19,3],15,2)+'�      '+UEspr[19,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('20�'+rozrzut(UEspr[20,1])+' �'+UEspr[20,2]+'�'+kwota(UEspr[20,3],15,2)+'�      '+UEspr[20,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('21�'+rozrzut(UEspr[21,1])+' �'+UEspr[21,2]+'�'+kwota(UEspr[21,3],15,2)+'�      '+UEspr[21,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('22�'+rozrzut(UEspr[22,1])+' �'+UEspr[22,2]+'�'+kwota(UEspr[22,3],15,2)+'�      '+UEspr[22,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('23�'+rozrzut(UEspr[23,1])+' �'+UEspr[23,2]+'�'+kwota(UEspr[23,3],15,2)+'�      '+UEspr[23,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('24�'+rozrzut(UEspr[24,1])+' �'+UEspr[24,2]+'�'+kwota(UEspr[24,3],15,2)+'�      '+UEspr[24,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('25�'+rozrzut(UEspr[25,1])+' �'+UEspr[25,2]+'�'+kwota(UEspr[25,3],15,2)+'�      '+UEspr[25,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('26�'+rozrzut(UEspr[26,1])+' �'+UEspr[26,2]+'�'+kwota(UEspr[26,3],15,2)+'�      '+UEspr[26,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('27�'+rozrzut(UEspr[27,1])+' �'+UEspr[27,2]+'�'+kwota(UEspr[27,3],15,2)+'�      '+UEspr[27,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('28�'+rozrzut(UEspr[28,1])+' �'+UEspr[28,2]+'�'+kwota(UEspr[28,3],15,2)+'�      '+UEspr[28,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('29�'+rozrzut(UEspr[29,1])+' �'+UEspr[29,2]+'�'+kwota(UEspr[29,3],15,2)+'�      '+UEspr[29,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('30�'+rozrzut(UEspr[30,1])+' �'+UEspr[30,2]+'�'+kwota(UEspr[30,3],15,2)+'�      '+UEspr[30,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('31�'+rozrzut(UEspr[31,1])+' �'+UEspr[31,2]+'�'+kwota(UEspr[31,3],15,2)+'�      '+UEspr[31,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('32�'+rozrzut(UEspr[32,1])+' �'+UEspr[32,2]+'�'+kwota(UEspr[32,3],15,2)+'�      '+UEspr[32,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('33�'+rozrzut(UEspr[33,1])+' �'+UEspr[33,2]+'�'+kwota(UEspr[33,3],15,2)+'�      '+UEspr[33,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('34�'+rozrzut(UEspr[34,1])+' �'+UEspr[34,2]+'�'+kwota(UEspr[34,3],15,2)+'�      '+UEspr[34,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('35�'+rozrzut(UEspr[35,1])+' �'+UEspr[35,2]+'�'+kwota(UEspr[35,3],15,2)+'�      '+UEspr[35,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('36�'+rozrzut(UEspr[36,1])+' �'+UEspr[36,2]+'�'+kwota(UEspr[36,3],15,2)+'�      '+UEspr[36,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('37�'+rozrzut(UEspr[37,1])+' �'+UEspr[37,2]+'�'+kwota(UEspr[37,3],15,2)+'�      '+UEspr[37,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('38�'+rozrzut(UEspr[38,1])+' �'+UEspr[38,2]+'�'+kwota(UEspr[38,3],15,2)+'�      '+UEspr[38,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('39�'+rozrzut(UEspr[39,1])+' �'+UEspr[39,2]+'�'+kwota(UEspr[39,3],15,2)+'�      '+UEspr[39,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('40�'+rozrzut(UEspr[40,1])+' �'+UEspr[40,2]+'�'+kwota(UEspr[40,3],15,2)+'�      '+UEspr[40,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('41�'+rozrzut(UEspr[41,1])+' �'+UEspr[41,2]+'�'+kwota(UEspr[41,3],15,2)+'�      '+UEspr[41,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('42�'+rozrzut(UEspr[42,1])+' �'+UEspr[42,2]+'�'+kwota(UEspr[42,3],15,2)+'�      '+UEspr[42,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('43�'+rozrzut(UEspr[43,1])+' �'+UEspr[43,2]+'�'+kwota(UEspr[43,3],15,2)+'�      '+UEspr[43,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('44�'+rozrzut(UEspr[44,1])+' �'+UEspr[44,2]+'�'+kwota(UEspr[44,3],15,2)+'�      '+UEspr[44,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('45�'+rozrzut(UEspr[45,1])+' �'+UEspr[45,2]+'�'+kwota(UEspr[45,3],15,2)+'�      '+UEspr[45,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('46�'+rozrzut(UEspr[46,1])+' �'+UEspr[46,2]+'�'+kwota(UEspr[46,3],15,2)+'�      '+UEspr[46,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('47�'+rozrzut(UEspr[47,1])+' �'+UEspr[47,2]+'�'+kwota(UEspr[47,3],15,2)+'�      '+UEspr[47,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('48�'+rozrzut(UEspr[48,1])+' �'+UEspr[48,2]+'�'+kwota(UEspr[48,3],15,2)+'�      '+UEspr[48,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('49�'+rozrzut(UEspr[49,1])+' �'+UEspr[49,2]+'�'+kwota(UEspr[49,3],15,2)+'�      '+UEspr[49,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('50�'+rozrzut(UEspr[50,1])+' �'+UEspr[50,2]+'�'+kwota(UEspr[50,3],15,2)+'�      '+UEspr[50,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('51�'+rozrzut(UEspr[51,1])+' �'+UEspr[51,2]+'�'+kwota(UEspr[51,3],15,2)+'�      '+UEspr[51,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('52�'+rozrzut(UEspr[52,1])+' �'+UEspr[52,2]+'�'+kwota(UEspr[52,3],15,2)+'�      '+UEspr[52,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('53�'+rozrzut(UEspr[53,1])+' �'+UEspr[53,2]+'�'+kwota(UEspr[53,3],15,2)+'�      '+UEspr[53,4]+'      �')
        rl('  ���������������������������������������������������������������������')
   case _OU='K'
        do kvat_uea
   endcase
end
*if _czy_close
*   close_()
*endif
