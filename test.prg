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

para _G,_M,_JAKITEST_
*################################# TEST drukarki  #############################
if pcount()=2
   _JAKITEST_='OGOLNY'
endif
//@  0,0 say prninit
buforDruku = buforDruku + prninit
if _JAKITEST_='PRZEL'
   _ods1_=23
   _ods2_=52
//   @  0+_G,_M    say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   dodajLinie(_G)
   buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   if 10+_G<65
//      @ 10+_G,_M say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   endif
   if 20+_G<65
//      @ 20+_G,_M say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   endif
   if 30+_G<65
//      @ 30+_G,_M say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   endif
   if 40+_G<65
//      @ 40+_G,_M say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   endif
   if 50+_G<65
//      @ 50+_G,_M say '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(_ods1_)+'+'+space(_ods2_)+'+'
   endif
else
   _ods1_=0
   _ods2_=74
   dodajLinie(_G)
   buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
//   @  0+_G,_M say '+'+space(74)+'+'
   if 10+_G<65
//      @ 10+_G,_M say '+'+space(74)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
   endif
   if 20+_G<65
//      @ 20+_G,_M say '+'+space(74)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
   endif
   if 30+_G<65
//      @ 30+_G,_M say '+'+space(74)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
   endif
   if 40+_G<65
//      @ 40+_G,_M say '+'+space(74)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
   endif
   if 50+_G<65
//      @ 50+_G,_M say '+'+space(74)+'+'
      dodajLinie(10)
      buforDruku = buforDruku + Space(_M) + '+'+space(74)+'+'
   endif
endif

FUNCTION dodajLinie(nIlosc)
   LOCAL i
   FOR i = 0 TO nIlosc
      buforDruku = buforDruku + &kod_lf
   NEXT
   RETURN

/*----------------------------------------------------------------------*/

