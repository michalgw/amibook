/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2019  GM Systems Micha� Gawrycki (gmsystems.pl)

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

*����������������������������������������������������������������������������
*������ PARAM    ������������������������������������������������������������
*�Modul parametrow programu przechowywanych w pliku PARAM_V7.MEM            �
*����������������������������������������������������������������������������

FUNCTION Param_V7()

*############################# PARAMETRY POCZATKOWE #########################
if .not.file([param_v7.mem])
   save to param_v7 all like parv7_*
   return
endif
              razem=0
              zparspr=alltrim(parv7_cel)+'*.*'
              katal=directory(zparspr,'HSDV')
              aeval(katal,{|zbi|RAZEM++})
              if razem=0
                 do komun with 'Brak podanego katalogu z danymi do e-dekl. Podaj inny'
              endif
return
