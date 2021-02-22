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
        rl('  ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
        rl('  ³ Kod ³      Nr identyfikacyjny      ³Kwota transakc.³  Transakcje  ³')
        rl('  ³kraju³        VAT kontrahenta       ³      w z&_l..    ³ tr&_o.jstronne  ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 1³'+rozrzut(UEzak[1,1])+' ³'+UEzak[1,2]+'³'+kwota(UEzak[1,3],15,2)+'³      '+UEzak[1,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 2³'+rozrzut(UEzak[2,1])+' ³'+UEzak[2,2]+'³'+kwota(UEzak[2,3],15,2)+'³      '+UEzak[2,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 3³'+rozrzut(UEzak[3,1])+' ³'+UEzak[3,2]+'³'+kwota(UEzak[3,3],15,2)+'³      '+UEzak[3,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 4³'+rozrzut(UEzak[4,1])+' ³'+UEzak[4,2]+'³'+kwota(UEzak[4,3],15,2)+'³      '+UEzak[4,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 5³'+rozrzut(UEzak[5,1])+' ³'+UEzak[5,2]+'³'+kwota(UEzak[5,3],15,2)+'³      '+UEzak[5,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 6³'+rozrzut(UEzak[6,1])+' ³'+UEzak[6,2]+'³'+kwota(UEzak[6,3],15,2)+'³      '+UEzak[6,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 7³'+rozrzut(UEzak[7,1])+' ³'+UEzak[7,2]+'³'+kwota(UEzak[7,3],15,2)+'³      '+UEzak[7,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 8³'+rozrzut(UEzak[8,1])+' ³'+UEzak[8,2]+'³'+kwota(UEzak[8,3],15,2)+'³      '+UEzak[8,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 9³'+rozrzut(UEzak[9,1])+' ³'+UEzak[9,2]+'³'+kwota(UEzak[9,3],15,2)+'³      '+UEzak[9,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('10³'+rozrzut(UEzak[10,1])+' ³'+UEzak[10,2]+'³'+kwota(UEzak[10,3],15,2)+'³      '+UEzak[10,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('11³'+rozrzut(UEzak[11,1])+' ³'+UEzak[11,2]+'³'+kwota(UEzak[11,3],15,2)+'³      '+UEzak[11,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('12³'+rozrzut(UEzak[12,1])+' ³'+UEzak[12,2]+'³'+kwota(UEzak[12,3],15,2)+'³      '+UEzak[12,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('13³'+rozrzut(UEzak[13,1])+' ³'+UEzak[13,2]+'³'+kwota(UEzak[13,3],15,2)+'³      '+UEzak[13,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('14³'+rozrzut(UEzak[14,1])+' ³'+UEzak[14,2]+'³'+kwota(UEzak[14,3],15,2)+'³      '+UEzak[14,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('15³'+rozrzut(UEzak[15,1])+' ³'+UEzak[15,2]+'³'+kwota(UEzak[15,3],15,2)+'³      '+UEzak[15,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('16³'+rozrzut(UEzak[16,1])+' ³'+UEzak[16,2]+'³'+kwota(UEzak[16,3],15,2)+'³      '+UEzak[16,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('17³'+rozrzut(UEzak[17,1])+' ³'+UEzak[17,2]+'³'+kwota(UEzak[17,3],15,2)+'³      '+UEzak[17,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('18³'+rozrzut(UEzak[18,1])+' ³'+UEzak[18,2]+'³'+kwota(UEzak[18,3],15,2)+'³      '+UEzak[18,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('19³'+rozrzut(UEzak[19,1])+' ³'+UEzak[19,2]+'³'+kwota(UEzak[19,3],15,2)+'³      '+UEzak[19,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('20³'+rozrzut(UEzak[20,1])+' ³'+UEzak[20,2]+'³'+kwota(UEzak[20,3],15,2)+'³      '+UEzak[20,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('21³'+rozrzut(UEzak[21,1])+' ³'+UEzak[21,2]+'³'+kwota(UEzak[21,3],15,2)+'³      '+UEzak[21,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('22³'+rozrzut(UEzak[22,1])+' ³'+UEzak[22,2]+'³'+kwota(UEzak[22,3],15,2)+'³      '+UEzak[22,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('23³'+rozrzut(UEzak[23,1])+' ³'+UEzak[23,2]+'³'+kwota(UEzak[23,3],15,2)+'³      '+UEzak[23,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('24³'+rozrzut(UEzak[24,1])+' ³'+UEzak[24,2]+'³'+kwota(UEzak[24,3],15,2)+'³      '+UEzak[24,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('25³'+rozrzut(UEzak[25,1])+' ³'+UEzak[25,2]+'³'+kwota(UEzak[25,3],15,2)+'³      '+UEzak[25,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('26³'+rozrzut(UEzak[26,1])+' ³'+UEzak[26,2]+'³'+kwota(UEzak[26,3],15,2)+'³      '+UEzak[26,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('27³'+rozrzut(UEzak[27,1])+' ³'+UEzak[27,2]+'³'+kwota(UEzak[27,3],15,2)+'³      '+UEzak[27,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('28³'+rozrzut(UEzak[28,1])+' ³'+UEzak[28,2]+'³'+kwota(UEzak[28,3],15,2)+'³      '+UEzak[28,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('29³'+rozrzut(UEzak[29,1])+' ³'+UEzak[29,2]+'³'+kwota(UEzak[29,3],15,2)+'³      '+UEzak[29,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('30³'+rozrzut(UEzak[30,1])+' ³'+UEzak[30,2]+'³'+kwota(UEzak[30,3],15,2)+'³      '+UEzak[30,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('31³'+rozrzut(UEzak[31,1])+' ³'+UEzak[31,2]+'³'+kwota(UEzak[31,3],15,2)+'³      '+UEzak[31,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('32³'+rozrzut(UEzak[32,1])+' ³'+UEzak[32,2]+'³'+kwota(UEzak[32,3],15,2)+'³      '+UEzak[32,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('33³'+rozrzut(UEzak[33,1])+' ³'+UEzak[33,2]+'³'+kwota(UEzak[33,3],15,2)+'³      '+UEzak[33,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('34³'+rozrzut(UEzak[34,1])+' ³'+UEzak[34,2]+'³'+kwota(UEzak[34,3],15,2)+'³      '+UEzak[34,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('35³'+rozrzut(UEzak[35,1])+' ³'+UEzak[35,2]+'³'+kwota(UEzak[35,3],15,2)+'³      '+UEzak[35,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('36³'+rozrzut(UEzak[36,1])+' ³'+UEzak[36,2]+'³'+kwota(UEzak[36,3],15,2)+'³      '+UEzak[36,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('37³'+rozrzut(UEzak[37,1])+' ³'+UEzak[37,2]+'³'+kwota(UEzak[37,3],15,2)+'³      '+UEzak[37,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('38³'+rozrzut(UEzak[38,1])+' ³'+UEzak[38,2]+'³'+kwota(UEzak[38,3],15,2)+'³      '+UEzak[38,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('39³'+rozrzut(UEzak[39,1])+' ³'+UEzak[39,2]+'³'+kwota(UEzak[39,3],15,2)+'³      '+UEzak[39,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('40³'+rozrzut(UEzak[40,1])+' ³'+UEzak[40,2]+'³'+kwota(UEzak[40,3],15,2)+'³      '+UEzak[40,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('41³'+rozrzut(UEzak[41,1])+' ³'+UEzak[41,2]+'³'+kwota(UEzak[41,3],15,2)+'³      '+UEzak[41,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('42³'+rozrzut(UEzak[42,1])+' ³'+UEzak[42,2]+'³'+kwota(UEzak[42,3],15,2)+'³      '+UEzak[42,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('43³'+rozrzut(UEzak[43,1])+' ³'+UEzak[43,2]+'³'+kwota(UEzak[43,3],15,2)+'³      '+UEzak[43,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('44³'+rozrzut(UEzak[44,1])+' ³'+UEzak[44,2]+'³'+kwota(UEzak[44,3],15,2)+'³      '+UEzak[44,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('45³'+rozrzut(UEzak[45,1])+' ³'+UEzak[45,2]+'³'+kwota(UEzak[45,3],15,2)+'³      '+UEzak[45,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('46³'+rozrzut(UEzak[46,1])+' ³'+UEzak[46,2]+'³'+kwota(UEzak[46,3],15,2)+'³      '+UEzak[46,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('47³'+rozrzut(UEzak[47,1])+' ³'+UEzak[47,2]+'³'+kwota(UEzak[47,3],15,2)+'³      '+UEzak[47,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('48³'+rozrzut(UEzak[48,1])+' ³'+UEzak[48,2]+'³'+kwota(UEzak[48,3],15,2)+'³      '+UEzak[48,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('49³'+rozrzut(UEzak[49,1])+' ³'+UEzak[49,2]+'³'+kwota(UEzak[49,3],15,2)+'³      '+UEzak[49,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('50³'+rozrzut(UEzak[50,1])+' ³'+UEzak[50,2]+'³'+kwota(UEzak[50,3],15,2)+'³      '+UEzak[50,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('51³'+rozrzut(UEzak[51,1])+' ³'+UEzak[51,2]+'³'+kwota(UEzak[51,3],15,2)+'³      '+UEzak[51,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('52³'+rozrzut(UEzak[52,1])+' ³'+UEzak[52,2]+'³'+kwota(UEzak[52,3],15,2)+'³      '+UEzak[52,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl('53³'+rozrzut(UEzak[53,1])+' ³'+UEzak[53,2]+'³'+kwota(UEzak[53,3],15,2)+'³      '+UEzak[53,4]+'      ³')
        rl('  ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
   case _OU='K'
        do kvat_ueb
   endcase
end
*if _czy_close
*   close_()
*endif
