/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

PROCEDURE KasyFiskalne()

   LOCAL cEkran, cKolor

   SAVE SCREEN TO cEkran
   cKolor := ColStd()

   BEGIN SEQUENCE
      IF ! DostepPro( 'KASAFISK', , .T., , 'KASAFISK' )
         BREAK
      ENDIF

   END

   close_()

   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

