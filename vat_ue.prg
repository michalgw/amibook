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
UEspr=array(12,4)
for licznik=1 to 12
    UEspr[licznik,1]='  '
    UEspr[licznik,2]=space(30)
    UEspr[licznik,3]=0
    UEspr[licznik,4]='  '
next
UEzak=array(12,4)
for licznik=1 to 12
    UEzak[licznik,1]='  '
    UEzak[licznik,2]=space(30)
    UEzak[licznik,3]=0
    UEzak[licznik,4]='  '
next
UEusl=array(12,4)
for licznik=1 to 12
    UEusl[licznik,1]='  '
    UEusl[licznik,2]=space(30)
    UEusl[licznik,3]=0
    UEusl[licznik,4]='  '
next
licznik=1
sele 2
seek 'S'
do while .not. eof() .and. licznik<13
   if REJ='S' .and. usluga='N'
      UEspr[licznik,1]=kraj
      UEspr[licznik,2]=VATid
      UEspr[licznik,3]=wartosc
      UEspr[licznik,4]=iif(trojca='T','XX','  ')
      licznik=licznik+1
   endif
   skip
enddo
licznik=1
sele 2
seek 'Z'
do while .not. eof() .and. REJ='Z' .and. licznik<13
   UEzak[licznik,1]=kraj
   UEzak[licznik,2]=VATid
   UEzak[licznik,3]=_round(wartosc,0)
   UEzak[licznik,4]=iif(trojca='T','XX','  ')
   licznik=licznik+1
   skip
enddo
licznik=1
sele 2
seek 'S'
do while .not. eof() .and. licznik<13
   if REJ='S' .and. usluga='T'
      UEusl[licznik,1]=kraj
      UEusl[licznik,2]=VATid
      UEusl[licznik,3]=wartosc
      UEusl[licznik,4]=iif(trojca='T','XX','  ')
      licznik=licznik+1
   endif
   skip
enddo
* zaokraglenie wartosci
for licznik=1 to 12
    UEspr[licznik,3]=_round(UEspr[licznik,3],0)
next
for licznik=1 to 12
    UEzak[licznik,3]=_round(UEzak[licznik,3],0)
next
for licznik=1 to 12
    UEusl[licznik,3]=_round(UEusl[licznik,3],0)
next
zDEKLNAZWI=firma->DEKLNAZWI
zDEKLIMIE=firma->DEKLIMIE
zDEKLTEL=firma->DEKLTEL
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
             rl(space(_M)+space(24)+rozrzut(p5a)+'     '+rozrzut(p5b))
             for x=1 to 13
                 rl()
             next
             rl(space(_M)+space(7)+padc(alltrim(P6),60))
             for x=1 to 5
                 rl()
             next
             if spolka_
                rl(space(_M)+space(19)+'XXX')
             else
                rl(space(_M)+space(54)+'XXX')
             endif
             rl()
             rl()
             rl(space(_M)+space(7)+padc(alltrim(P8)+'   '+P11,60))
             for x=1 to 4
                 rl()
             next
             rl(space(_M)+space(4)+padc(alltrim(p16),16)+padc(alltrim(p17),31)+padc(alltrim(p17a),25))
             rl()
             rl(space(_M)+space(4)+padc(alltrim(p18),20)+padc(alltrim(P19),36)+padc(alltrim(P20),8)+padc(alltrim(P21),8))
             rl()
             rl(space(_M)+space(4)+padc(alltrim(P22),30)+padc(alltrim(P23),12)+padc(alltrim(P24),30))
             for x=1 to 5
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEspr[1,1])+space(4)+UEspr[1,2]+space(4)+kwota(UEspr[1,3],16,0)+space(4)+UEspr[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[2,1])+space(4)+UEspr[2,2]+space(4)+kwota(UEspr[2,3],16,0)+space(4)+UEspr[2,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[3,1])+space(4)+UEspr[3,2]+space(4)+kwota(UEspr[3,3],16,0)+space(4)+UEspr[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[4,1])+space(4)+UEspr[4,2]+space(4)+kwota(UEspr[4,3],16,0)+space(4)+UEspr[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[5,1])+space(4)+UEspr[5,2]+space(4)+kwota(UEspr[5,3],16,0)+space(4)+UEspr[5,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEspr[6,1])+space(4)+UEspr[6,2]+space(4)+kwota(UEspr[6,3],16,0)+space(4)+UEspr[6,4])
             for x=1 to 5
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEzak[1,1])+space(4)+UEzak[1,2]+space(5)+kwota(UEzak[1,3],16,0)+space(4)+UEzak[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[2,1])+space(4)+UEzak[2,2]+space(5)+kwota(UEzak[2,3],16,0)+space(4)+UEzak[2,4])
        case _STR=2
             for x=1 to _G
                 rl()
             next
             for x=1 to 3
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEzak[3,1])+space(4)+UEzak[3,2]+space(5)+kwota(UEzak[3,3],16,0)+space(4)+UEzak[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[4,1])+space(4)+UEzak[4,2]+space(5)+kwota(UEzak[4,3],16,0)+space(4)+UEzak[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[5,1])+space(4)+UEzak[5,2]+space(5)+kwota(UEzak[5,3],16,0)+space(4)+UEzak[5,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEzak[6,1])+space(4)+UEzak[6,2]+space(5)+kwota(UEzak[6,3],16,0)+space(4)+UEzak[6,4])
             for x=1 to 5
                 rl()
             next
             rl(space(_M)+space(5)+rozrzut(UEusl[1,1])+space(4)+UEusl[1,2]+space(4)+kwota(UEusl[1,3],16,0)+space(4)+UEusl[1,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEusl[2,1])+space(4)+UEusl[2,2]+space(4)+kwota(UEusl[2,3],16,0)+space(4)+UEusl[2,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEusl[3,1])+space(4)+UEusl[3,2]+space(4)+kwota(UEusl[3,3],16,0)+space(4)+UEusl[3,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEusl[4,1])+space(4)+UEusl[4,2]+space(4)+kwota(UEusl[4,3],16,0)+space(4)+UEusl[4,4])
             rl()
             rl(space(_M)+space(5)+rozrzut(UEusl[5,1])+space(4)+UEusl[5,2]+space(4)+kwota(UEusl[5,3],16,0)+space(4)+UEusl[5,4])
             for x=1 to 3
                 rl()
             next
             rl(space(_M)+space(21)+kwota(ROBSPR,2,0)+space(17)+kwota(ROBZAK,2,0)+space(17)+kwota(ROBUSL,2,0))
        endcase
   case _OU='P'
        rl(padc('VAT-UE  INFORMACJA PODSUMOWUJ&__A.CA O DOKONANYCH TRANSAKCJACH UE',80))
        rl('(01) Numer identyfikacyjny podatnika: '+P4)
        rl('(04) Miesiac:'+iif(zUEOKRES='K','  ',miesiac)+'      lub (06) Kwartal: '+iif(zUEOKRES='K',P5a,'  ')+'   (06) rok: '+P5b)
        rl()
        rl(padc('A. MIEJSCE SK&__L.ADANIA DEKLARACJI',80))
        rl(padc('===============================',80))
        rl('(07) Urz&_a.d Skarbowy: '+P6)
        rl()
        rl(padc('B. DANE PODATNIKA',80))
        rl(padc('=================',80))
        if spolka_
           rl('B.1. DANE IDENTYFIKACYJNE')
           rl('-------------------------')
           rl('(09) Nazwa pe&_l.na,REGON: '+P8)
        else
           rl('B.1. DANE PERSONALNE')
           rl('--------------------')
           rl('(09) Nazwisko,imie,data urodz.,PESEL: '+P8+'   '+P11)
        endif
        rl()
        if spolka_
           rl('B.2. ADRES SIEDZIBY')
           rl('-------------------')
        else
           rl('B.2. ADRES ZAMIESZKANIA')
           rl('-----------------------')
        endif
        rl('(10) Kraj.: '+P16+'   (11) Wojew&_o.dztwo: '+P17)
        rl('(12) Powiat: '+P17a+'   (13) Gmina: '+P18)
        rl('(14) Ulica: '+P19+' (15) Nr domu: '+P20+' (16) Nr lokalu: '+P21)
        rl('(17) Miejsc: '+P22+' (18) Kod: '+P23)
        rl('(19) Poczta: '+P24)
        rl()
        rl(padc('C. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYCH DOSTAWACH TOWAR&__O.W',80))
        rl(padc('=======================================================',80))
        rl('  ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
        rl('  ³ Kod ³      Nr identyfikacyjny      ³  Kwota dostaw ³  Transakcje  ³')
        rl('  ³kraju³        VAT kontrahenta       ³      w z&_l..    ³ tr&_o.jstronne  ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 1³'+rozrzut(UEspr[1,1])+' ³'+UEspr[1,2]+'³'+kwota(UEspr[1,3],15,2)+'³      '+UEspr[1,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 2³'+rozrzut(UEspr[2,1])+' ³'+UEspr[2,2]+'³'+kwota(UEspr[2,3],15,2)+'³      '+UEspr[2,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 3³'+rozrzut(UEspr[3,1])+' ³'+UEspr[3,2]+'³'+kwota(UEspr[3,3],15,2)+'³      '+UEspr[3,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 4³'+rozrzut(UEspr[4,1])+' ³'+UEspr[4,2]+'³'+kwota(UEspr[4,3],15,2)+'³      '+UEspr[4,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 5³'+rozrzut(UEspr[5,1])+' ³'+UEspr[5,2]+'³'+kwota(UEspr[5,3],15,2)+'³      '+UEspr[5,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 6³'+rozrzut(UEspr[6,1])+' ³'+UEspr[6,2]+'³'+kwota(UEspr[6,3],15,2)+'³      '+UEspr[6,4]+'      ³')
        rl('  ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
        rl()
        rl(padc('D. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYCH NABYCIACH TOWAR&__O.W',80))
        rl(padc('=======================================================',80))
        rl('  ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
        rl('  ³ Kod ³      Nr identyfikacyjny      ³  Kwota naby&_c.  ³  Transakcje  ³')
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
        rl('  ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
        rl()
        rl(padc('E. INFORMACJA O WEWN&__A.TRZWSP&__O.LNOTOWYM SWIADCZENIU USLUG',80))
        rl(padc('=======================================================',80))
        rl('  ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
        rl('  ³ Kod ³      Nr identyfikacyjny      ³  Kwota naby&_c.  ³  Transakcje  ³')
        rl('  ³kraju³        VAT kontrahenta       ³      w z&_l..    ³ tr&_o.jstronne  ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 1³'+rozrzut(UEusl[1,1])+' ³'+UEusl[1,2]+'³'+kwota(UEusl[1,3],15,2)+'³      '+UEusl[1,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 2³'+rozrzut(UEusl[2,1])+' ³'+UEusl[2,2]+'³'+kwota(UEusl[2,3],15,2)+'³      '+UEusl[2,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 3³'+rozrzut(UEusl[3,1])+' ³'+UEusl[3,2]+'³'+kwota(UEusl[3,3],15,2)+'³      '+UEusl[3,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 4³'+rozrzut(UEusl[4,1])+' ³'+UEusl[4,2]+'³'+kwota(UEusl[4,3],15,2)+'³      '+UEusl[4,4]+'      ³')
        rl('  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
        rl(' 5³'+rozrzut(UEusl[5,1])+' ³'+UEusl[5,2]+'³'+kwota(UEusl[5,3],15,2)+'³      '+UEusl[5,4]+'      ³')
        rl('  ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
        rl()
        rl(padc('F. INFORMACJA O ZA&__L.&__A.CZNIKACH',80))
        rl(padc('============================',80))
        rl('(20) VAT-UE/A: '+kwota(ROBSPR,2,0))
        rl('(21) VAT-UE/B: '+kwota(ROBZAK,2,0))
        rl('(22) VAT-UE/C: '+kwota(ROBUSL,2,0))
   case _OU='K'
        DeklPodp()
        do kvat_ue
   endcase
end
*if _czy_close
*   close_()
*endif
