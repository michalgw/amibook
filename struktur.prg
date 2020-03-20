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

*################################# GRAFIKA ##################################

   sprawdzVAT(10,ctod(param_rok+'.'+strtran(miesiac,' ','0')+'.01'))


@  3,0 clear to 22,79
ColInf()
@  3,0 say '[ESC]-wyjscie                                                  [D]-wydruk ekranu'
ColStd()
@  4,0 say '                                                                                '
@  5,0 say '           W Y L I C Z E N I E   S T R U K T U R Y   S P R Z E D A &__Z. Y          '
@  6,0 say '                                                                                '
@  7,0 say '                     Og&_o.lna warto&_s.&_c. sprzeda&_z.y do podzia&_l.u -                     '
@  8,0 say '                                                                                '
@  9,0 say '              Struktura                         SPRZEDA&__Z.                        '
@ 10,0 say '   Stawka %    zakupu %         NETTO             VAT            BRUTTO         '
@ 11,0 say '           ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ   '
@ 12,0 say '         '+str(vat_A,2)+'    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 13,0 say '         '+str(vat_B,2)+'    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 14,0 say '         '+str(vat_C,2)+'    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 15,0 say '          0    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 16,0 say '         ZW    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 17,0 say '           ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ   '
@ 18,0 say '      RAZEM    תתת.תת     תת תתת תתת תתת   תת תתת תתת תתת   תת תתת תתת תתת      '
@ 19,0 say '                                                                                '
@ 20,0 say '                                                                                '
@ 21,0 say '                                                                                '
@ 22,0 say '                                                                                '
*################################ OBLICZENIA ################################
SPRZEDAZ=0
for I=1 to 6
    II=str(I,1)
    A&II=0
    B&II=0
    C&II=0
    D&II=0
next
set curs on
do while lastkey()<>27
   @ 7,60 get SPRZEDAZ pict '   99999999.99'
   for I=1 to 5
       II=str(I,1)
       @ 11+I,15 get A&II pict '999.99'
   next
   read
   SET COLOR TO W+
   @ 7,60 say SPRZEDAZ pict '999 999 999.99'
   A=0
   SP100=sprzedaz/100
   for I=1 to 5
       II=str(I,1)
       @ 11+I,15 say A&II pict '999.99'
       A=A+A&II
   next
   @ 18,15 say A pict '999.99'

   D=0
   for I=1 to 5
       II=str(I,1)
       D&II=_round(SP100*A&II,2)
   next
   if D1+D2+D3+D4+D5<>SPRZEDAZ
      RESZTA=SPRZEDAZ-(D1+D2+D3+D4+D5)
      do case
      case D1<>0
           D1=D1+RESZTA
      case D2<>0
           D2=D2+RESZTA
      case D3<>0
           D3=D3+RESZTA
      case D4<>0
           D4=D4+RESZTA
      case D5<>0
           D5=D5+RESZTA
      endcase
   endif
   for I=1 to 5
       II=str(I,1)
       @ 11+I,60 say D&II pict '999 999 999.99'
       D=D+D&II
   next
   @ 18,60 say D pict '999 999 999.99'

   C=0
   C1=D1-_round(D1/(1+(vat_A/100)),2)
   C2=D2-_round(D2/(1+(vat_B/100)),2)
   C3=D3-_round(D3/(1+(vat_C/100)),2)
   C4=0
   C5=0
   for I=1 to 5
       II=str(I,1)
       @ 11+I,43 say C&II pict '999 999 999.99'
       C=C+C&II
   next
   @ 18,43 say C pict '999 999 999.99'
   B=0
   B1=D1-C1
   B2=D2-C2
   B3=D3-C3
   B4=D4
   B5=D5
   for I=1 to 5
       II=str(I,1)
       @ 11+I,26 say B&II pict '999 999 999.99'
       B=B+B&II
   next
   @ 18,26 say B pict '999 999 999.99'
   SET COLOR TO
   @ 21,0 say '[D lub PrintScreen]-drukowanie ekranu    [Inny klawisz]-wpisanie nowych wartosci'
   kkk=inkey(0)
   if kkk=68.or.kkk=100
      //x=fcreate('c:\ekrstru.txt',0)
      zm=savescreen(0,0,24,79)
      zm__=''
      zm__=zm__+&kod_res+&kod_12cp+&kod_6wc
      zm__=zm__+repl('=',80)+chr(13)+chr(10)
      zm__=zm__+''+chr(13)+chr(10)
      for j=5 to 19
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
      //!copy c:\ekrstru.txt lpt1:
      DrukujNowyProfil(zm__)
   endif
   @ 21,0 say '                                                                                '
enddo
set curs off
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
