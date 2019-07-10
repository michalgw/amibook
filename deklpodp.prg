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

FUNCTION DeklPodp( _DEKLKOR_ )

* czy pytac o deklaracja/korekta
if _DEKLKOR_=NIL
   _DEKLKOR_='N'
endif
zDRUKDEKL='T'
save scre to _DEKPOD_
if _DEKLKOR_='T'
   @ 16,42 clear to 22,79
   @ 16,42 to 22,79
   @ 17,43 say 'Deklaracja czy korekta (D/K) ?' get zDEKLKOR pict '!' valid zDEKLKOR$'DK'
else
   @ 17,42 clear to 22,79
   @ 17,42 to 22,79
endif
@ 18,43 say 'Nazwisko:' get zDEKLNAZWI pict repl('!',20)
@ 19,43 say 'Imie....:' get zDEKLIMIE pict repl('!',15)
@ 20,43 say 'Telefony:' get zDEKLTEL pict repl('!',25)
@ 21,43 say 'Drukowac na deklar.? (Tak/Nie):' get zDRUKDEKL pict '!' valid zDRUKDEKL$'TN'
read
if zDRUKDEKL='N'
   zDEKLNAZWI=space(20)
   zDEKLIMIE=space(15)
   zDEKLTEL=space(25)
endif
rest scre from _DEKPOD_

