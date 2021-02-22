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
UEzak=array(59,4)
for licznik=1 to 59
    UEzak[licznik,1]='  '
    UEzak[licznik,2]=space(30)
    UEzak[licznik,3]=0
    UEzak[licznik,4]='  '
next
licznik=1
sele 2
seek 'Z'
do while .not. eof() .and. REJ='Z' .and. licznik<(13+((numzal-1)*59))
   licznik=licznik+1
   skip
enddo
*for licznik=1 to 9+((numzal-1)*53)
*    if REJ='Z' .and. korekta='N'
*       licznik=licznik+1
*    endif
*    skip
*next
*seek 'Z'
licznik=1
do while .not. eof() .and. REJ='Z' .and. licznik<60
   UEzak[licznik,1]=kraj
   UEzak[licznik,2]=VATid
   UEzak[licznik,3]=_round(wartosc,0)
   UEzak[licznik,4]=iif(trojca='T','XX','  ')
   licznik=licznik+1
   skip
enddo
* zaokraglanie wartosci
for licznik=1 to 59
    UEzak[licznik,3]=_round(UEzak[licznik,3],0)
next
begin sequence
   *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
   sele 100
   USE &RAPORT VIA "ARRAYRDD"
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
             rl(space(_M)+space(5)+rozrzut(UEzak[1,1])+space(4)+UEzak[1,2]+space(5)+kwota(UEzak[1,3],15,0)+space(4)+UEzak[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[2,1])+space(4)+UEzak[2,2]+space(5)+kwota(UEzak[2,3],15,0)+space(4)+UEzak[2,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[3,1])+space(4)+UEzak[3,2]+space(5)+kwota(UEzak[3,3],15,0)+space(4)+UEzak[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[4,1])+space(4)+UEzak[4,2]+space(5)+kwota(UEzak[4,3],15,0)+space(4)+UEzak[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[5,1])+space(4)+UEzak[5,2]+space(5)+kwota(UEzak[5,3],15,0)+space(4)+UEzak[5,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[6,1])+space(4)+UEzak[6,2]+space(5)+kwota(UEzak[6,3],15,0)+space(4)+UEzak[6,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[7,1])+space(4)+UEzak[7,2]+space(5)+kwota(UEzak[7,3],15,0)+space(4)+UEzak[7,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[8,1])+space(4)+UEzak[8,2]+space(5)+kwota(UEzak[8,3],15,0)+space(4)+UEzak[8,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[9,1])+space(4)+UEzak[9,2]+space(5)+kwota(UEzak[9,3],15,0)+space(4)+UEzak[9,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[10,1])+space(4)+UEzak[10,2]+space(5)+kwota(UEzak[10,3],15,0)+space(4)+UEzak[10,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[11,1])+space(4)+UEzak[11,2]+space(5)+kwota(UEzak[11,3],15,0)+space(4)+UEzak[11,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[12,1])+space(4)+UEzak[12,2]+space(5)+kwota(UEzak[12,3],15,0)+space(4)+UEzak[12,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[13,1])+space(4)+UEzak[13,2]+space(5)+kwota(UEzak[13,3],15,0)+space(4)+UEzak[13,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[14,1])+space(4)+UEzak[14,2]+space(5)+kwota(UEzak[14,3],15,0)+space(4)+UEzak[14,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[15,1])+space(4)+UEzak[15,2]+space(5)+kwota(UEzak[15,3],15,0)+space(4)+UEzak[15,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[16,1])+space(4)+UEzak[16,2]+space(5)+kwota(UEzak[16,3],15,0)+space(4)+UEzak[16,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[17,1])+space(4)+UEzak[17,2]+space(5)+kwota(UEzak[17,3],15,0)+space(4)+UEzak[17,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[18,1])+space(4)+UEzak[18,2]+space(5)+kwota(UEzak[18,3],15,0)+space(4)+UEzak[18,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[19,1])+space(4)+UEzak[19,2]+space(5)+kwota(UEzak[19,3],15,0)+space(4)+UEzak[19,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[20,1])+space(4)+UEzak[20,2]+space(5)+kwota(UEzak[20,3],15,0)+space(4)+UEzak[20,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[21,1])+space(4)+UEzak[21,2]+space(5)+kwota(UEzak[21,3],15,0)+space(4)+UEzak[21,4])
        case _STR=2
             for x=1 to _G
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEzak[22,1])+space(4)+UEzak[22,2]+space(5)+kwota(UEzak[22,3],15,0)+space(4)+UEzak[22,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[23,1])+space(4)+UEzak[23,2]+space(5)+kwota(UEzak[23,3],15,0)+space(4)+UEzak[23,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[24,1])+space(4)+UEzak[24,2]+space(5)+kwota(UEzak[24,3],15,0)+space(4)+UEzak[24,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[25,1])+space(4)+UEzak[25,2]+space(5)+kwota(UEzak[25,3],15,0)+space(4)+UEzak[25,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[26,1])+space(4)+UEzak[26,2]+space(5)+kwota(UEzak[26,3],15,0)+space(4)+UEzak[26,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[27,1])+space(4)+UEzak[27,2]+space(5)+kwota(UEzak[27,3],15,0)+space(4)+UEzak[27,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[28,1])+space(4)+UEzak[28,2]+space(5)+kwota(UEzak[28,3],15,0)+space(4)+UEzak[28,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[29,1])+space(4)+UEzak[29,2]+space(5)+kwota(UEzak[29,3],15,0)+space(4)+UEzak[29,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[30,1])+space(4)+UEzak[30,2]+space(5)+kwota(UEzak[30,3],15,0)+space(4)+UEzak[30,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[31,1])+space(4)+UEzak[31,2]+space(5)+kwota(UEzak[31,3],15,0)+space(4)+UEzak[31,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[32,1])+space(4)+UEzak[32,2]+space(5)+kwota(UEzak[32,3],15,0)+space(4)+UEzak[32,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[33,1])+space(4)+UEzak[33,2]+space(5)+kwota(UEzak[33,3],15,0)+space(4)+UEzak[33,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[34,1])+space(4)+UEzak[34,2]+space(5)+kwota(UEzak[34,3],15,0)+space(4)+UEzak[34,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[35,1])+space(4)+UEzak[35,2]+space(5)+kwota(UEzak[35,3],15,0)+space(4)+UEzak[35,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[36,1])+space(4)+UEzak[36,2]+space(5)+kwota(UEzak[36,3],15,0)+space(4)+UEzak[36,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[37,1])+space(4)+UEzak[37,2]+space(5)+kwota(UEzak[37,3],15,0)+space(4)+UEzak[37,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[38,1])+space(4)+UEzak[38,2]+space(5)+kwota(UEzak[38,3],15,0)+space(4)+UEzak[38,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[39,1])+space(4)+UEzak[39,2]+space(5)+kwota(UEzak[39,3],15,0)+space(4)+UEzak[39,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[40,1])+space(4)+UEzak[40,2]+space(5)+kwota(UEzak[40,3],15,0)+space(4)+UEzak[40,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[41,1])+space(4)+UEzak[41,2]+space(5)+kwota(UEzak[41,3],15,0)+space(4)+UEzak[41,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[42,1])+space(4)+UEzak[42,2]+space(5)+kwota(UEzak[42,3],15,0)+space(4)+UEzak[42,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[43,1])+space(4)+UEzak[43,2]+space(5)+kwota(UEzak[43,3],15,0)+space(4)+UEzak[43,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[44,1])+space(4)+UEzak[44,2]+space(5)+kwota(UEzak[44,3],15,0)+space(4)+UEzak[44,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[45,1])+space(4)+UEzak[45,2]+space(5)+kwota(UEzak[45,3],15,0)+space(4)+UEzak[45,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[46,1])+space(4)+UEzak[46,2]+space(5)+kwota(UEzak[46,3],15,0)+space(4)+UEzak[46,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[47,1])+space(4)+UEzak[47,2]+space(5)+kwota(UEzak[47,3],15,0)+space(4)+UEzak[47,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[48,1])+space(4)+UEzak[48,2]+space(5)+kwota(UEzak[48,3],15,0)+space(4)+UEzak[48,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[49,1])+space(4)+UEzak[49,2]+space(5)+kwota(UEzak[49,3],15,0)+space(4)+UEzak[49,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[50,1])+space(4)+UEzak[50,2]+space(5)+kwota(UEzak[50,3],15,0)+space(4)+UEzak[50,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[51,1])+space(4)+UEzak[51,2]+space(5)+kwota(UEzak[51,3],15,0)+space(4)+UEzak[51,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[52,1])+space(4)+UEzak[52,2]+space(5)+kwota(UEzak[52,3],15,0)+space(4)+UEzak[52,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[53,1])+space(4)+UEzak[53,2]+space(5)+kwota(UEzak[53,3],15,0)+space(4)+UEzak[53,4])
        endcase
   case _OU='P'
        rl(padc('VAT-UE/B  INFORMACJA PODSUMOWUJ&__A.CA O DOKONANYCH UE NABYCIACH TOWAR&__O.W',80))
        rl('(01) Numer identyfikacyjny podatnika: '+P4)
        rl('(04) Za kwartal: '+P5a+'   (05) rok: '+P5b)
        rl('(06) Numer za&_l.&_a.cznika: '+str(numzal,2,0))
        rl()
        rl(padc('A. DANE IDENTYFIKACYJNE PODATNIKA',80))
        rl(padc('=================================',80))
        if spolka_
           rl('(08) Nazwa pe&_l.na: '+P8)
        else
           rl('(08) Nazwisko,imie,data urodz.: '+P8+'   '+P11)
        endif
        rl()
        rl(padc('B. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYCH NABYCIACH TOWAR&__O.W',80))
        rl(padc('=======================================================',80))
        rl('  �������������������������������������������������������������������Ŀ')
        rl('  � Kod �      Nr identyfikacyjny      �Kwota transakc.�  Transakcje  �')
        rl('  �kraju�        VAT kontrahenta       �      w z&_l..    � tr&_o.jstronne  �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 1�'+rozrzut(UEzak[1,1])+' �'+UEzak[1,2]+'�'+kwota(UEzak[1,3],15,2)+'�      '+UEzak[1,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 2�'+rozrzut(UEzak[2,1])+' �'+UEzak[2,2]+'�'+kwota(UEzak[2,3],15,2)+'�      '+UEzak[2,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 3�'+rozrzut(UEzak[3,1])+' �'+UEzak[3,2]+'�'+kwota(UEzak[3,3],15,2)+'�      '+UEzak[3,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 4�'+rozrzut(UEzak[4,1])+' �'+UEzak[4,2]+'�'+kwota(UEzak[4,3],15,2)+'�      '+UEzak[4,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 5�'+rozrzut(UEzak[5,1])+' �'+UEzak[5,2]+'�'+kwota(UEzak[5,3],15,2)+'�      '+UEzak[5,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 6�'+rozrzut(UEzak[6,1])+' �'+UEzak[6,2]+'�'+kwota(UEzak[6,3],15,2)+'�      '+UEzak[6,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 7�'+rozrzut(UEzak[7,1])+' �'+UEzak[7,2]+'�'+kwota(UEzak[7,3],15,2)+'�      '+UEzak[7,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 8�'+rozrzut(UEzak[8,1])+' �'+UEzak[8,2]+'�'+kwota(UEzak[8,3],15,2)+'�      '+UEzak[8,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 9�'+rozrzut(UEzak[9,1])+' �'+UEzak[9,2]+'�'+kwota(UEzak[9,3],15,2)+'�      '+UEzak[9,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('10�'+rozrzut(UEzak[10,1])+' �'+UEzak[10,2]+'�'+kwota(UEzak[10,3],15,2)+'�      '+UEzak[10,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('11�'+rozrzut(UEzak[11,1])+' �'+UEzak[11,2]+'�'+kwota(UEzak[11,3],15,2)+'�      '+UEzak[11,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('12�'+rozrzut(UEzak[12,1])+' �'+UEzak[12,2]+'�'+kwota(UEzak[12,3],15,2)+'�      '+UEzak[12,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('13�'+rozrzut(UEzak[13,1])+' �'+UEzak[13,2]+'�'+kwota(UEzak[13,3],15,2)+'�      '+UEzak[13,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('14�'+rozrzut(UEzak[14,1])+' �'+UEzak[14,2]+'�'+kwota(UEzak[14,3],15,2)+'�      '+UEzak[14,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('15�'+rozrzut(UEzak[15,1])+' �'+UEzak[15,2]+'�'+kwota(UEzak[15,3],15,2)+'�      '+UEzak[15,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('16�'+rozrzut(UEzak[16,1])+' �'+UEzak[16,2]+'�'+kwota(UEzak[16,3],15,2)+'�      '+UEzak[16,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('17�'+rozrzut(UEzak[17,1])+' �'+UEzak[17,2]+'�'+kwota(UEzak[17,3],15,2)+'�      '+UEzak[17,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('18�'+rozrzut(UEzak[18,1])+' �'+UEzak[18,2]+'�'+kwota(UEzak[18,3],15,2)+'�      '+UEzak[18,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('19�'+rozrzut(UEzak[19,1])+' �'+UEzak[19,2]+'�'+kwota(UEzak[19,3],15,2)+'�      '+UEzak[19,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('20�'+rozrzut(UEzak[20,1])+' �'+UEzak[20,2]+'�'+kwota(UEzak[20,3],15,2)+'�      '+UEzak[20,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('21�'+rozrzut(UEzak[21,1])+' �'+UEzak[21,2]+'�'+kwota(UEzak[21,3],15,2)+'�      '+UEzak[21,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('22�'+rozrzut(UEzak[22,1])+' �'+UEzak[22,2]+'�'+kwota(UEzak[22,3],15,2)+'�      '+UEzak[22,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('23�'+rozrzut(UEzak[23,1])+' �'+UEzak[23,2]+'�'+kwota(UEzak[23,3],15,2)+'�      '+UEzak[23,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('24�'+rozrzut(UEzak[24,1])+' �'+UEzak[24,2]+'�'+kwota(UEzak[24,3],15,2)+'�      '+UEzak[24,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('25�'+rozrzut(UEzak[25,1])+' �'+UEzak[25,2]+'�'+kwota(UEzak[25,3],15,2)+'�      '+UEzak[25,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('26�'+rozrzut(UEzak[26,1])+' �'+UEzak[26,2]+'�'+kwota(UEzak[26,3],15,2)+'�      '+UEzak[26,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('27�'+rozrzut(UEzak[27,1])+' �'+UEzak[27,2]+'�'+kwota(UEzak[27,3],15,2)+'�      '+UEzak[27,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('28�'+rozrzut(UEzak[28,1])+' �'+UEzak[28,2]+'�'+kwota(UEzak[28,3],15,2)+'�      '+UEzak[28,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('29�'+rozrzut(UEzak[29,1])+' �'+UEzak[29,2]+'�'+kwota(UEzak[29,3],15,2)+'�      '+UEzak[29,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('30�'+rozrzut(UEzak[30,1])+' �'+UEzak[30,2]+'�'+kwota(UEzak[30,3],15,2)+'�      '+UEzak[30,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('31�'+rozrzut(UEzak[31,1])+' �'+UEzak[31,2]+'�'+kwota(UEzak[31,3],15,2)+'�      '+UEzak[31,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('32�'+rozrzut(UEzak[32,1])+' �'+UEzak[32,2]+'�'+kwota(UEzak[32,3],15,2)+'�      '+UEzak[32,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('33�'+rozrzut(UEzak[33,1])+' �'+UEzak[33,2]+'�'+kwota(UEzak[33,3],15,2)+'�      '+UEzak[33,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('34�'+rozrzut(UEzak[34,1])+' �'+UEzak[34,2]+'�'+kwota(UEzak[34,3],15,2)+'�      '+UEzak[34,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('35�'+rozrzut(UEzak[35,1])+' �'+UEzak[35,2]+'�'+kwota(UEzak[35,3],15,2)+'�      '+UEzak[35,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('36�'+rozrzut(UEzak[36,1])+' �'+UEzak[36,2]+'�'+kwota(UEzak[36,3],15,2)+'�      '+UEzak[36,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('37�'+rozrzut(UEzak[37,1])+' �'+UEzak[37,2]+'�'+kwota(UEzak[37,3],15,2)+'�      '+UEzak[37,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('38�'+rozrzut(UEzak[38,1])+' �'+UEzak[38,2]+'�'+kwota(UEzak[38,3],15,2)+'�      '+UEzak[38,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('39�'+rozrzut(UEzak[39,1])+' �'+UEzak[39,2]+'�'+kwota(UEzak[39,3],15,2)+'�      '+UEzak[39,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('40�'+rozrzut(UEzak[40,1])+' �'+UEzak[40,2]+'�'+kwota(UEzak[40,3],15,2)+'�      '+UEzak[40,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('41�'+rozrzut(UEzak[41,1])+' �'+UEzak[41,2]+'�'+kwota(UEzak[41,3],15,2)+'�      '+UEzak[41,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('42�'+rozrzut(UEzak[42,1])+' �'+UEzak[42,2]+'�'+kwota(UEzak[42,3],15,2)+'�      '+UEzak[42,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('43�'+rozrzut(UEzak[43,1])+' �'+UEzak[43,2]+'�'+kwota(UEzak[43,3],15,2)+'�      '+UEzak[43,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('44�'+rozrzut(UEzak[44,1])+' �'+UEzak[44,2]+'�'+kwota(UEzak[44,3],15,2)+'�      '+UEzak[44,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('45�'+rozrzut(UEzak[45,1])+' �'+UEzak[45,2]+'�'+kwota(UEzak[45,3],15,2)+'�      '+UEzak[45,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('46�'+rozrzut(UEzak[46,1])+' �'+UEzak[46,2]+'�'+kwota(UEzak[46,3],15,2)+'�      '+UEzak[46,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('47�'+rozrzut(UEzak[47,1])+' �'+UEzak[47,2]+'�'+kwota(UEzak[47,3],15,2)+'�      '+UEzak[47,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('48�'+rozrzut(UEzak[48,1])+' �'+UEzak[48,2]+'�'+kwota(UEzak[48,3],15,2)+'�      '+UEzak[48,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('49�'+rozrzut(UEzak[49,1])+' �'+UEzak[49,2]+'�'+kwota(UEzak[49,3],15,2)+'�      '+UEzak[49,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('50�'+rozrzut(UEzak[50,1])+' �'+UEzak[50,2]+'�'+kwota(UEzak[50,3],15,2)+'�      '+UEzak[50,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('51�'+rozrzut(UEzak[51,1])+' �'+UEzak[51,2]+'�'+kwota(UEzak[51,3],15,2)+'�      '+UEzak[51,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('52�'+rozrzut(UEzak[52,1])+' �'+UEzak[52,2]+'�'+kwota(UEzak[52,3],15,2)+'�      '+UEzak[52,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('53�'+rozrzut(UEzak[53,1])+' �'+UEzak[53,2]+'�'+kwota(UEzak[53,3],15,2)+'�      '+UEzak[53,4]+'      �')
        rl('  ���������������������������������������������������������������������')
   case _OU='K'
        do kvat_ueb
   endcase
end
*if _czy_close
*   close_()
*endif
