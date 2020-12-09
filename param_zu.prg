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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_ZU.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Param_ZU()

   *############################# PARAMETRY POCZATKOWE #########################
   IF .NOT. File( 'param_zu.mem' )
      SAVE TO param_zu ALL LIKE paraz_*
      RETURN
   ENDIF

   razem := 0
   zparspr := AllTrim( paraz_cel ) + '*.*'
   katal := Directory( zparspr, 'HSDV' )
   AEval( katal, { | zbi | RAZEM++ } )
   IF razem == 0
      Komun( 'Brak podanego katalogu z danymi do Platnika. Podaj inny' )
      *zparaz_cel=paraz_cel
   ENDIF

   RETURN
