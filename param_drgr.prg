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

FUNCTION paramDrukGraf()

   LOCAL zdrukarka, zmarginl, zmarginp, zmarging, zmargind, ztyprap
   LOCAL aListaDrukarek := win_printerList()
   LOCAL bTypRapValid := { ||
      LOCAL lValid := ztyprap # 'FL'
      LOCAL cKolor
      IF lValid
         cKolor := SetColor()
         SET COLOR TO W+
         @ 10, 69 SAY iif( ztyprap == 'L', 'azReport ', 'astReport' )
         SetColor( cKolor )
      ENDIF
   }

      ColSta()
      @  2,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      ColStd()
      @  3,42 say ' Drukarka dla wydruk¢w graficznych    '
      @  4,42 say '                                      '
      @  5,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @  6,42 say ' Margines (mm)                        '
      @  7,42 say '  Lewy              Prawy             '
      @  8,42 say ' G¢rny              Dolny             '
      @  9,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 10,42 say ' Typ sterownika raport¢w:             '
      @ 11,42 say ' (F - FastReport, L - LazReport)      '
      @ 12,42 say 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
      @ 13,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 14,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 15,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 16,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 17,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 18,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 19,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 20,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 21,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      @ 22,42 say '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
      paramDrukGrafPokaz()
      kl=0
      DO WHILE kl#27
            ColSta()
            @ 1,47 say '[F1]-pomoc'
            ColStd()
            kl=inkey(0)
            DO CASE
            CASE kl=109.or.kl=77
                 @ 1,47 say [          ]
                 ColStb()
                 center(23,[þ                       þ])
                 ColSta()
                 center(23,[M O D Y F I K A C J A])
                 ColStd()
                 begin sequence
                 *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
                       zdrukarka := hProfilUzytkownika[ 'drukarka' ]
                       zmarginl := hProfilUzytkownika[ 'marginl' ]
                       zmarginp := hProfilUzytkownika[ 'marginp' ]
                       zmarging := hProfilUzytkownika[ 'marging' ]
                       zmargind := hProfilUzytkownika[ 'margind' ]
                       ztyprap := iif( hProfilUzytkownika[ 'typrap' ] == ' ', 'F', hProfilUzytkownika[ 'typrap' ] )
                       *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
                       @  4, 43, 14, 78 GET zdrukarka LISTBOX aListaDrukarek DROPDOWN SCROLLBAR
                       @  7, 49 GET zmarginl PICTURE '9999'
                       @  7, 68 GET zmarginp PICTURE '9999'
                       @  8, 49 GET zmarging PICTURE '9999'
                       @  8, 68 GET zmargind PICTURE '9999'
                       @ 10, 68 GET ztyprap PICTURE '!' VALID ztyprap # 'FL'
                       ****************************
                       clear type
                       read_()
                       if lastkey()=27
                          break
                       endif
                       *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
                       hProfilUzytkownika[ 'drukarka' ] := zdrukarka
                       hProfilUzytkownika[ 'marginl' ] := zmarginl
                       hProfilUzytkownika[ 'marginp' ] := zmarginp
                       hProfilUzytkownika[ 'marging' ] := zmarging
                       hProfilUzytkownika[ 'margind' ] := zmargind
                       hProfilUzytkownika[ 'typrap' ] := ztyprap

                       ZapiszProfilUzytkownika()
                 end
                 paramDrukGrafPokaz()
                 @ 23,0
                 *################################### POMOC ##################################
            case kl=28
                 save screen to scr_
                 @ 1,47 say [          ]
                 declare p[20]
                 *---------------------------------------
                 p[ 1]='                                             '
                 p[ 2]='     [M].....................modyfikacja     '
                 p[ 3]='     [Esc]...................wyj&_s.cie         '
                 p[ 4]='                                             '
                 *---------------------------------------
                 set color to i
                 i=20
                 j=24
                 do while i>0
                    if type('p[i]')#[U]
                       center(j,p[i])
                       j=j-1
                    endif
                    i=i-1
                 enddo
                 ColStd()
                 pause(0)
                 if lastkey()#27.and.lastkey()#28
                    keyboard chr(lastkey())
                 endif
                 restore screen from scr_
                 _disp=.f.
                 ******************** ENDCASE
            endcase
         enddo
      close_()
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION paramDrukGrafPokaz()

      clear type
      set colo to w+

      @  4, 43 SAY PadR(hProfilUzytkownika[ 'drukarka' ], 36) PICTURE 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
      @  7, 49 SAY hProfilUzytkownika[ 'marginl' ] PICTURE '9999'
      @  7, 68 SAY hProfilUzytkownika[ 'marginp' ] PICTURE '9999'
      @  8, 49 SAY hProfilUzytkownika[ 'marging' ] PICTURE '9999'
      @  8, 68 SAY hProfilUzytkownika[ 'margind' ] PICTURE '9999'
      @ 10, 68 SAY iif( hProfilUzytkownika[ 'typrap' ] == 'L', 'LazReport ', 'FastReport' )

   RETURN

/*----------------------------------------------------------------------*/
