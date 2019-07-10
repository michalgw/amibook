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

FUNCTION drukarkaMenuKonfig()
   LOCAL pos_x:=10, pos_y:=10
      @ pos_y, pos_x PROMPT ' Drukarka '
      @ pos_y + 1, pos_x PROMPT ' '
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION drukarkaWybierz(cDrukarka)
   LOCAL aWinDrukarki, aDrukarki
      aWinDrukarki = win_PrinterList()
   RETURN

/*----------------------------------------------------------------------*/

