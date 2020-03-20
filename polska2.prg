/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

if POLSKA_2=.t.
   POLSKA_2=.f.
   save to POLSKA all like POLSKA_*
else
   if .not.file('POLZNAK.DEF')
      x=fcreate('POLZNAK.DEF',0)
      znaki='§è®ù„‡óçΩ•Ü©à‰¢ò´æ'
      if ferror()=0
         fwrite(x,znaki,18)
      endif
      fclose(x)
   endif
   POLSKA_2=.t.
   save to POLSKA all like POLSKA_*
endif

x=fcreate('POLSKA.BAT',0)
if ferror()=0
   if POLSKA_1=.t.
      znaki1='@call POLSKA1'+chr(13)+chr(10)
   else
      znaki1='rem @call POLSKA1'+chr(13)+chr(10)
   endif
   if POLSKA_2=.t.
      znaki2='@call POLSKA2'+chr(13)+chr(10)
   else
      znaki2='rem @call POLSKA2'+chr(13)+chr(10)
   endif
   do case
   case POLSKA_3='0'
        znaki3='rem @call POLSKA3'+chr(13)+chr(10)
   case POLSKA_3='1'
        znaki3='@call POLSKA3 Z'+chr(13)+chr(10)
   case POLSKA_3='2'
        znaki3='@call POLSKA3 X'+chr(13)+chr(10)
   endcase
   fwrite(x,znaki1+znaki2+znaki3+chr(26))
endif
fclose(x)
do KOMUN with 'Nowe ustawienia zadzia&_l.aj&_a. po ponownym uruchomieniu programu'
