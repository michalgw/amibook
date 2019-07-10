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

FUNCTION indeks()
   IF Type("TabliceDbf") == "U"
      dbfInicjujDane()
   ENDIF
   dbfUtworzIndeksy({|aTab, nAkt, nIlosc|indeks_postep(aTab, nAkt, nIlosc)})
   close_()
   RETURN

FUNCTION indeks_postep(aTab, nAktualny, nIlosc)
   ColInb()
   @ 24,0 SAY PadR(" Indeksowanie zbioru: " + AllTrim(Str(nAktualny)) + " z " + AllTrim(Str(nIlosc)) + " - " + aTab[1], 80)
   RETURN

/*----------------------------------------------------------------------*/

