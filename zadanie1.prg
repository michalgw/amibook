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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ZADANIE1 ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura uruchamiajaca plik wsadowy ZADANIE1.BAT                         ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Zadanie1()

zadanie1='WSADOWE1'
if .not.file([zadanie1.mem])
*+++++++++++++++++++++++++++++++++
   save to zadanie1 all like zadanie1
   save to scr all like scr
   if file(RAPTEMP+'.dbf')
      dele file &RAPTEMP..dbf
   endif
   if file(RAPTEMP+'.cdx')
      dele file &RAPTEMP..cdx
   endif
   hbfr_FreeLibrary()
   amiDllZakoncz()
   cancel
endif
restore from scr additive
erase zadanie1.mem
erase scr.mem
rest scre from scr
*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
