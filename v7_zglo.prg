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
   @ 15,43 say    [ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ]
   ColStd()
   @ 17,43 say    [      Gdzie zapisywa&_c. pliki dla      ]
   @ 18,43 say    [             E-deklaracje            ]
   @ 19,43 say    [ dysk:\katalog\                      ]
   set colo to w+
   @ 20,47 say    substr(parv7_cel,1,33)
   set colo to w
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
        zparspr=alltrim(parv7_cel)+'*.*'
        katal=directory(zparspr,'HSDV')
        aeval(katal,{|zbi|RAZEM++})
        if razem=0
           do komun with 'Brak podanego katalogu z danymi do E-deklar. Podaj inny'
           RR=0
        else
           RR=1
        endif
        exit
   case opc=2
        zparv7_cel=parv7_cel
        do while .t.
           *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
           @ 20,47 get zparv7_cel picture repl([!],60)
           set curs on
           read
           set curs off
           if lastkey()#27
              if substr(alltrim(zparv7_cel),len(alltrim(zparv7_cel)),1)#'\'
                 zparv7_cel=alltrim(zparv7_cel)+'\'+space(60-len(alltrim(zparv7_cel)))
              endif
              razem=0
              zparspr=alltrim(zparv7_cel)+'*.*'
              katal=directory(zparspr,'HSDV')
              aeval(katal,{|zbi|RAZEM++})
              if razem=0
                 do komun with 'Brak podanego katalogu. Podaj inny'
                 zparv7_cel=parv7_cel
              else
                 parv7_cel=zparv7_cel
                 save to param_v7 all like parv7_*
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
func vcel_v7
***********************************************************
para zparv7_cel
