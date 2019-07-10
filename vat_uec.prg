/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha� Gawrycki (gmsystems.pl)

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
UEusl=array(59,4)
for licznik=1 to 59
    UEusl[licznik,1]='  '
    UEusl[licznik,2]=space(30)
    UEusl[licznik,3]=0
    UEusl[licznik,4]='  '
next
licznik=1
sele 2
seek 'S'
do while .not. eof() .and. licznik<(13+((numzal-1)*59))
   if REJ='S' .and. usluga='T'
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
*seek 'Z'
licznik=1
do while .not. eof() .and. licznik<60
   if REJ='S' .and. usluga='T'
      UEusl[licznik,1]=kraj
      UEusl[licznik,2]=VATid
      UEusl[licznik,3]=_round(wartosc,0)
      UEusl[licznik,4]=iif(trojca='T','XX','  ')
      licznik=licznik+1
   endif
   skip
enddo
* zaokraglanie wartosci
for licznik=1 to 59
    UEusl[licznik,3]=_round(UEusl[licznik,3],0)
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
             rl(space(_M)+space(5)+rozrzut(ueusl[1,1])+space(4)+ueusl[1,2]+space(5)+kwota(ueusl[1,3],15,0)+space(4)+ueusl[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[2,1])+space(4)+ueusl[2,2]+space(5)+kwota(ueusl[2,3],15,0)+space(4)+ueusl[2,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[3,1])+space(4)+ueusl[3,2]+space(5)+kwota(ueusl[3,3],15,0)+space(4)+ueusl[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[4,1])+space(4)+ueusl[4,2]+space(5)+kwota(ueusl[4,3],15,0)+space(4)+ueusl[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[5,1])+space(4)+ueusl[5,2]+space(5)+kwota(ueusl[5,3],15,0)+space(4)+ueusl[5,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[6,1])+space(4)+ueusl[6,2]+space(5)+kwota(ueusl[6,3],15,0)+space(4)+ueusl[6,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[7,1])+space(4)+ueusl[7,2]+space(5)+kwota(ueusl[7,3],15,0)+space(4)+ueusl[7,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[8,1])+space(4)+ueusl[8,2]+space(5)+kwota(ueusl[8,3],15,0)+space(4)+ueusl[8,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[9,1])+space(4)+ueusl[9,2]+space(5)+kwota(ueusl[9,3],15,0)+space(4)+ueusl[9,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[10,1])+space(4)+ueusl[10,2]+space(5)+kwota(ueusl[10,3],15,0)+space(4)+ueusl[10,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[11,1])+space(4)+ueusl[11,2]+space(5)+kwota(ueusl[11,3],15,0)+space(4)+ueusl[11,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[12,1])+space(4)+ueusl[12,2]+space(5)+kwota(ueusl[12,3],15,0)+space(4)+ueusl[12,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[13,1])+space(4)+ueusl[13,2]+space(5)+kwota(ueusl[13,3],15,0)+space(4)+ueusl[13,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[14,1])+space(4)+ueusl[14,2]+space(5)+kwota(ueusl[14,3],15,0)+space(4)+ueusl[14,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[15,1])+space(4)+ueusl[15,2]+space(5)+kwota(ueusl[15,3],15,0)+space(4)+ueusl[15,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[16,1])+space(4)+ueusl[16,2]+space(5)+kwota(ueusl[16,3],15,0)+space(4)+ueusl[16,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[17,1])+space(4)+ueusl[17,2]+space(5)+kwota(ueusl[17,3],15,0)+space(4)+ueusl[17,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[18,1])+space(4)+ueusl[18,2]+space(5)+kwota(ueusl[18,3],15,0)+space(4)+ueusl[18,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[19,1])+space(4)+ueusl[19,2]+space(5)+kwota(ueusl[19,3],15,0)+space(4)+ueusl[19,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[20,1])+space(4)+ueusl[20,2]+space(5)+kwota(ueusl[20,3],15,0)+space(4)+ueusl[20,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[21,1])+space(4)+ueusl[21,2]+space(5)+kwota(ueusl[21,3],15,0)+space(4)+ueusl[21,4])
        case _STR=2
             for x=1 to _G
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(ueusl[22,1])+space(4)+ueusl[22,2]+space(5)+kwota(ueusl[22,3],15,0)+space(4)+ueusl[22,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[23,1])+space(4)+ueusl[23,2]+space(5)+kwota(ueusl[23,3],15,0)+space(4)+ueusl[23,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[24,1])+space(4)+ueusl[24,2]+space(5)+kwota(ueusl[24,3],15,0)+space(4)+ueusl[24,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[25,1])+space(4)+ueusl[25,2]+space(5)+kwota(ueusl[25,3],15,0)+space(4)+ueusl[25,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[26,1])+space(4)+ueusl[26,2]+space(5)+kwota(ueusl[26,3],15,0)+space(4)+ueusl[26,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[27,1])+space(4)+ueusl[27,2]+space(5)+kwota(ueusl[27,3],15,0)+space(4)+ueusl[27,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[28,1])+space(4)+ueusl[28,2]+space(5)+kwota(ueusl[28,3],15,0)+space(4)+ueusl[28,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[29,1])+space(4)+ueusl[29,2]+space(5)+kwota(ueusl[29,3],15,0)+space(4)+ueusl[29,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[30,1])+space(4)+ueusl[30,2]+space(5)+kwota(ueusl[30,3],15,0)+space(4)+ueusl[30,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[31,1])+space(4)+ueusl[31,2]+space(5)+kwota(ueusl[31,3],15,0)+space(4)+ueusl[31,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[32,1])+space(4)+ueusl[32,2]+space(5)+kwota(ueusl[32,3],15,0)+space(4)+ueusl[32,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[33,1])+space(4)+ueusl[33,2]+space(5)+kwota(ueusl[33,3],15,0)+space(4)+ueusl[33,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[34,1])+space(4)+ueusl[34,2]+space(5)+kwota(ueusl[34,3],15,0)+space(4)+ueusl[34,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[35,1])+space(4)+ueusl[35,2]+space(5)+kwota(ueusl[35,3],15,0)+space(4)+ueusl[35,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[36,1])+space(4)+ueusl[36,2]+space(5)+kwota(ueusl[36,3],15,0)+space(4)+ueusl[36,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[37,1])+space(4)+ueusl[37,2]+space(5)+kwota(ueusl[37,3],15,0)+space(4)+ueusl[37,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[38,1])+space(4)+ueusl[38,2]+space(5)+kwota(ueusl[38,3],15,0)+space(4)+ueusl[38,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[39,1])+space(4)+ueusl[39,2]+space(5)+kwota(ueusl[39,3],15,0)+space(4)+ueusl[39,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[40,1])+space(4)+ueusl[40,2]+space(5)+kwota(ueusl[40,3],15,0)+space(4)+ueusl[40,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[41,1])+space(4)+ueusl[41,2]+space(5)+kwota(ueusl[41,3],15,0)+space(4)+ueusl[41,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[42,1])+space(4)+ueusl[42,2]+space(5)+kwota(ueusl[42,3],15,0)+space(4)+ueusl[42,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[43,1])+space(4)+ueusl[43,2]+space(5)+kwota(ueusl[43,3],15,0)+space(4)+ueusl[43,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[44,1])+space(4)+ueusl[44,2]+space(5)+kwota(ueusl[44,3],15,0)+space(4)+ueusl[44,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[45,1])+space(4)+ueusl[45,2]+space(5)+kwota(ueusl[45,3],15,0)+space(4)+ueusl[45,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[46,1])+space(4)+ueusl[46,2]+space(5)+kwota(ueusl[46,3],15,0)+space(4)+ueusl[46,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[47,1])+space(4)+ueusl[47,2]+space(5)+kwota(ueusl[47,3],15,0)+space(4)+ueusl[47,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[48,1])+space(4)+ueusl[48,2]+space(5)+kwota(ueusl[48,3],15,0)+space(4)+ueusl[48,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[49,1])+space(4)+ueusl[49,2]+space(5)+kwota(ueusl[49,3],15,0)+space(4)+ueusl[49,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[50,1])+space(4)+ueusl[50,2]+space(5)+kwota(ueusl[50,3],15,0)+space(4)+ueusl[50,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[51,1])+space(4)+ueusl[51,2]+space(5)+kwota(ueusl[51,3],15,0)+space(4)+ueusl[51,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[52,1])+space(4)+ueusl[52,2]+space(5)+kwota(ueusl[52,3],15,0)+space(4)+ueusl[52,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(ueusl[53,1])+space(4)+ueusl[53,2]+space(5)+kwota(ueusl[53,3],15,0)+space(4)+ueusl[53,4])
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
        rl(' 1�'+rozrzut(ueusl[1,1])+' �'+ueusl[1,2]+'�'+kwota(ueusl[1,3],15,2)+'�      '+ueusl[1,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 2�'+rozrzut(ueusl[2,1])+' �'+ueusl[2,2]+'�'+kwota(ueusl[2,3],15,2)+'�      '+ueusl[2,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 3�'+rozrzut(ueusl[3,1])+' �'+ueusl[3,2]+'�'+kwota(ueusl[3,3],15,2)+'�      '+ueusl[3,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 4�'+rozrzut(ueusl[4,1])+' �'+ueusl[4,2]+'�'+kwota(ueusl[4,3],15,2)+'�      '+ueusl[4,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 5�'+rozrzut(ueusl[5,1])+' �'+ueusl[5,2]+'�'+kwota(ueusl[5,3],15,2)+'�      '+ueusl[5,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 6�'+rozrzut(ueusl[6,1])+' �'+ueusl[6,2]+'�'+kwota(ueusl[6,3],15,2)+'�      '+ueusl[6,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 7�'+rozrzut(ueusl[7,1])+' �'+ueusl[7,2]+'�'+kwota(ueusl[7,3],15,2)+'�      '+ueusl[7,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 8�'+rozrzut(ueusl[8,1])+' �'+ueusl[8,2]+'�'+kwota(ueusl[8,3],15,2)+'�      '+ueusl[8,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl(' 9�'+rozrzut(ueusl[9,1])+' �'+ueusl[9,2]+'�'+kwota(ueusl[9,3],15,2)+'�      '+ueusl[9,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('10�'+rozrzut(ueusl[10,1])+' �'+ueusl[10,2]+'�'+kwota(ueusl[10,3],15,2)+'�      '+ueusl[10,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('11�'+rozrzut(ueusl[11,1])+' �'+ueusl[11,2]+'�'+kwota(ueusl[11,3],15,2)+'�      '+ueusl[11,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('12�'+rozrzut(ueusl[12,1])+' �'+ueusl[12,2]+'�'+kwota(ueusl[12,3],15,2)+'�      '+ueusl[12,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('13�'+rozrzut(ueusl[13,1])+' �'+ueusl[13,2]+'�'+kwota(ueusl[13,3],15,2)+'�      '+ueusl[13,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('14�'+rozrzut(ueusl[14,1])+' �'+ueusl[14,2]+'�'+kwota(ueusl[14,3],15,2)+'�      '+ueusl[14,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('15�'+rozrzut(ueusl[15,1])+' �'+ueusl[15,2]+'�'+kwota(ueusl[15,3],15,2)+'�      '+ueusl[15,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('16�'+rozrzut(ueusl[16,1])+' �'+ueusl[16,2]+'�'+kwota(ueusl[16,3],15,2)+'�      '+ueusl[16,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('17�'+rozrzut(ueusl[17,1])+' �'+ueusl[17,2]+'�'+kwota(ueusl[17,3],15,2)+'�      '+ueusl[17,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('18�'+rozrzut(ueusl[18,1])+' �'+ueusl[18,2]+'�'+kwota(ueusl[18,3],15,2)+'�      '+ueusl[18,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('19�'+rozrzut(ueusl[19,1])+' �'+ueusl[19,2]+'�'+kwota(ueusl[19,3],15,2)+'�      '+ueusl[19,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('20�'+rozrzut(ueusl[20,1])+' �'+ueusl[20,2]+'�'+kwota(ueusl[20,3],15,2)+'�      '+ueusl[20,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('21�'+rozrzut(ueusl[21,1])+' �'+ueusl[21,2]+'�'+kwota(ueusl[21,3],15,2)+'�      '+ueusl[21,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('22�'+rozrzut(ueusl[22,1])+' �'+ueusl[22,2]+'�'+kwota(ueusl[22,3],15,2)+'�      '+ueusl[22,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('23�'+rozrzut(ueusl[23,1])+' �'+ueusl[23,2]+'�'+kwota(ueusl[23,3],15,2)+'�      '+ueusl[23,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('24�'+rozrzut(ueusl[24,1])+' �'+ueusl[24,2]+'�'+kwota(ueusl[24,3],15,2)+'�      '+ueusl[24,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('25�'+rozrzut(ueusl[25,1])+' �'+ueusl[25,2]+'�'+kwota(ueusl[25,3],15,2)+'�      '+ueusl[25,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('26�'+rozrzut(ueusl[26,1])+' �'+ueusl[26,2]+'�'+kwota(ueusl[26,3],15,2)+'�      '+ueusl[26,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('27�'+rozrzut(ueusl[27,1])+' �'+ueusl[27,2]+'�'+kwota(ueusl[27,3],15,2)+'�      '+ueusl[27,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('28�'+rozrzut(ueusl[28,1])+' �'+ueusl[28,2]+'�'+kwota(ueusl[28,3],15,2)+'�      '+ueusl[28,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('29�'+rozrzut(ueusl[29,1])+' �'+ueusl[29,2]+'�'+kwota(ueusl[29,3],15,2)+'�      '+ueusl[29,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('30�'+rozrzut(ueusl[30,1])+' �'+ueusl[30,2]+'�'+kwota(ueusl[30,3],15,2)+'�      '+ueusl[30,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('31�'+rozrzut(ueusl[31,1])+' �'+ueusl[31,2]+'�'+kwota(ueusl[31,3],15,2)+'�      '+ueusl[31,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('32�'+rozrzut(ueusl[32,1])+' �'+ueusl[32,2]+'�'+kwota(ueusl[32,3],15,2)+'�      '+ueusl[32,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('33�'+rozrzut(ueusl[33,1])+' �'+ueusl[33,2]+'�'+kwota(ueusl[33,3],15,2)+'�      '+ueusl[33,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('34�'+rozrzut(ueusl[34,1])+' �'+ueusl[34,2]+'�'+kwota(ueusl[34,3],15,2)+'�      '+ueusl[34,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('35�'+rozrzut(ueusl[35,1])+' �'+ueusl[35,2]+'�'+kwota(ueusl[35,3],15,2)+'�      '+ueusl[35,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('36�'+rozrzut(ueusl[36,1])+' �'+ueusl[36,2]+'�'+kwota(ueusl[36,3],15,2)+'�      '+ueusl[36,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('37�'+rozrzut(ueusl[37,1])+' �'+ueusl[37,2]+'�'+kwota(ueusl[37,3],15,2)+'�      '+ueusl[37,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('38�'+rozrzut(ueusl[38,1])+' �'+ueusl[38,2]+'�'+kwota(ueusl[38,3],15,2)+'�      '+ueusl[38,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('39�'+rozrzut(ueusl[39,1])+' �'+ueusl[39,2]+'�'+kwota(ueusl[39,3],15,2)+'�      '+ueusl[39,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('40�'+rozrzut(ueusl[40,1])+' �'+ueusl[40,2]+'�'+kwota(ueusl[40,3],15,2)+'�      '+ueusl[40,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('41�'+rozrzut(ueusl[41,1])+' �'+ueusl[41,2]+'�'+kwota(ueusl[41,3],15,2)+'�      '+ueusl[41,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('42�'+rozrzut(ueusl[42,1])+' �'+ueusl[42,2]+'�'+kwota(ueusl[42,3],15,2)+'�      '+ueusl[42,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('43�'+rozrzut(ueusl[43,1])+' �'+ueusl[43,2]+'�'+kwota(ueusl[43,3],15,2)+'�      '+ueusl[43,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('44�'+rozrzut(ueusl[44,1])+' �'+ueusl[44,2]+'�'+kwota(ueusl[44,3],15,2)+'�      '+ueusl[44,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('45�'+rozrzut(ueusl[45,1])+' �'+ueusl[45,2]+'�'+kwota(ueusl[45,3],15,2)+'�      '+ueusl[45,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('46�'+rozrzut(ueusl[46,1])+' �'+ueusl[46,2]+'�'+kwota(ueusl[46,3],15,2)+'�      '+ueusl[46,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('47�'+rozrzut(ueusl[47,1])+' �'+ueusl[47,2]+'�'+kwota(ueusl[47,3],15,2)+'�      '+ueusl[47,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('48�'+rozrzut(ueusl[48,1])+' �'+ueusl[48,2]+'�'+kwota(ueusl[48,3],15,2)+'�      '+ueusl[48,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('49�'+rozrzut(ueusl[49,1])+' �'+ueusl[49,2]+'�'+kwota(ueusl[49,3],15,2)+'�      '+ueusl[49,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('50�'+rozrzut(ueusl[50,1])+' �'+ueusl[50,2]+'�'+kwota(ueusl[50,3],15,2)+'�      '+ueusl[50,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('51�'+rozrzut(ueusl[51,1])+' �'+ueusl[51,2]+'�'+kwota(ueusl[51,3],15,2)+'�      '+ueusl[51,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('52�'+rozrzut(ueusl[52,1])+' �'+ueusl[52,2]+'�'+kwota(ueusl[52,3],15,2)+'�      '+ueusl[52,4]+'      �')
        rl('  �������������������������������������������������������������������Ĵ')
        rl('53�'+rozrzut(ueusl[53,1])+' �'+ueusl[53,2]+'�'+kwota(ueusl[53,3],15,2)+'�      '+ueusl[53,4]+'      �')
        rl('  ���������������������������������������������������������������������')
   case _OU='K'
        do kvat_uec
   endcase
end
*if _czy_close
*   close_()
*endif
