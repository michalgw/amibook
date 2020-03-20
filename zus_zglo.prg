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

opc=0
RR=0
ColStd()
@ 11,42 CLEAR TO 22,79
do while .t.
   set colo to w+
*   @ 12,43 say    [ÄÄÄÄÄ Czyje dane eksportowa&_c. ? ÄÄÄÄÄÄ]
*   @ 12,43 say    [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
   @ 15,43 say    [ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ]
   ColStd()
   @ 17,43 say    [      Gdzie zapisywa&_c. pliki dla      ]
   @ 18,43 say    [          Programu P&_l.atnika          ]
   @ 19,43 say    [ dysk:\katalog\                      ]
   set colo to w+
   @ 20,47 say    substr(paraz_cel,1,33)
   set colo to w
*  ColPro()
*  @ 13,43 prompt [        TYLKO WYBRANEJ OSOBY         ]
*  @ 14,43 prompt [      WSZYSTKICH OS&__O.B Z LISTY        ]
   @ 14,43 prompt [          TWORZENIE PLIKU            ]
   @ 16,43 prompt [     ZMIANA PARAMETR&__O.W EKSPORTU      ]
   RR=0
   opc=menu(opc)
   ColStd()
   if lastkey()=27
      exit
   endif
*   save screen to _scr22
   do case
   case opc=1
        razem=0
        zparspr=alltrim(paraz_cel)+'*.*'
        katal=directory(zparspr,'HSDV')
        aeval(katal,{|zbi|RAZEM++})
        if razem=0
           do komun with 'Brak podanego katalogu z danymi do Platnika. Podaj inny'
*          zparaz_cel=paraz_cel
           RR=0
        else
           RR=1
        endif
        exit
*  case opc=2
*       RR=2
*       exit
   case opc=2
        zparaz_cel=paraz_cel
        do while .t.
           *ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ GET ğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğğ
           @ 20,47 get zparaz_cel picture repl([!],60)
           set curs on
           read
           set curs off
           if lastkey()#27
              if substr(alltrim(zparaz_cel),len(alltrim(zparaz_cel)),1)#'\'
                 zparaz_cel=alltrim(zparaz_cel)+'\'+space(60-len(alltrim(zparaz_cel)))
              endif
              razem=0
              zparspr=alltrim(zparaz_cel)+'*.*'
              katal=directory(zparspr,'HSDV')
              aeval(katal,{|zbi|RAZEM++})
              if razem=0
                 do komun with 'Brak podanego katalogu. Podaj inny'
                 zparaz_cel=paraz_cel
              else
                 paraz_cel=zparaz_cel
                 save to param_zu all like paraz_*
                 exit
              endif
           endif
        enddo
   endcase
*   restore screen from _scr22
enddo
@ 11,42 clear to 22,79
return RR
***********************************************************
func vcel_zus
***********************************************************
para zparaz_cel
