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

save scre to _DEKPOD_
@ 17,42 clear to 22,79
@ 17,42 to 22,79
@ 18,43 say 'Kwota nadplaty za kwartal:'
@ 19,43 get p98rozn picture '99999999.99'
@ 20,43 say 'Na poczet przyszlych zobowiaz:'
@ 21,43 say 'Tak/Nie:' get p98taknie picture '!' valid p98taknie$'TN'
read
rest scre from _DEKPOD_

