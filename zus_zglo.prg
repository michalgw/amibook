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

FUNCTION ZUS_Zglo()

   LOCAL aWersje := { '1.3', '5.4' }

   opc := 0
   RR := 0
   ColStd()
   @ 11, 42 CLEAR TO 22,79
   DO WHILE .T.
      SET COLOR TO w+
      *@ 12,43 say    [ִִִִִ Czyje dane eksportowa&_c. ? ִִִִִִ]
      *@ 12,43 say    [ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ]
      @ 15, 43 SAY    'ִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִִ'
      ColStd()
      @ 17, 43 SAY    '      Gdzie zapisywa&_c. pliki dla      '
      @ 18, 43 SAY    '          Programu P&_l.atnika          '
      @ 19, 43 SAY    ' dysk:\katalog\                      '
      @ 22, 43 SAY    ' Format pliku:                       '
      SET COLOR TO w+
      @ 20, 47 SAY    SubStr( paraz_cel, 1, 33 )
      @ 22, 58 SAY    aWersje[ paraz_wer ]
      SET COLOR TO w
      *ColPro()
      *@ 13,43 prompt [        TYLKO WYBRANEJ OSOBY         ]
      *@ 14,43 prompt [      WSZYSTKICH OS&__O.B Z LISTY        ]
      @ 14, 43 PROMPT '          TWORZENIE PLIKU            '
      @ 16, 43 PROMPT '     ZMIANA PARAMETR&__O.W EKSPORTU      '

      RR:= 0
      opc := menu( opc )
      ColStd()
      IF LastKey() == 27
         EXIT
      ENDIF
      *save screen to _scr22
      DO CASE
      CASE opc == 1
         razem := 0
         zparspr := AllTrim( paraz_cel ) + '*.*'
         katal := Directory( zparspr, 'HSDV' )
         AEval( katal, { | zbi | RAZEM++ } )
         IF razem == 0
            Komun( 'Brak podanego katalogu z danymi do Platnika. Podaj inny' )
            *zparaz_cel=paraz_cel
            RR := 0
         ELSE
            RR := 1
         ENDIF
         EXIT
         *case opc=2
         *  RR=2
         *  exit
      CASE opc == 2
         zparaz_cel := paraz_cel
         zparaz_wer := paraz_wer
         DO WHILE .T.
            *ננננננננננננננננננננננננננננננננ GET ננננננננננננננננננננננננננננננננננ
            @ 20, 47 GET zparaz_cel PICTURE repl( '!', 60 )
            @ 22, 58, 24, 64 GET zparaz_wer LISTBOX aWersje DROPDOWN
            SET CURSOR ON
            READ
            SET CURSOR OFF
            IF LastKey() # 27
               IF SubStr( AllTrim( zparaz_cel ), Len( AllTrim( zparaz_cel ) ), 1 ) # '\'
                  zparaz_cel := AllTrim( zparaz_cel ) + '\' + Space( 60 - Len( AllTrim( zparaz_cel ) ) )
               ENDIF
               razem := 0
               zparspr := AllTrim( zparaz_cel ) + '*.*'
               katal := Directory( zparspr, 'HSDV' )
               AEval( katal, { | zbi | RAZEM++ } )
               IF razem == 0
                  Komun( 'Brak podanego katalogu. Podaj inny' )
                  zparaz_cel := paraz_cel
               ELSE
                  paraz_cel := zparaz_cel
                  paraz_wer := zparaz_wer
                  SAVE TO param_zu ALL LIKE paraz_*
                  EXIT
               ENDIF
            ENDIF
         ENDDO
      ENDCASE
      *restore screen from _scr22
   ENDDO
   @ 11, 42 CLEAR TO 22, 79
   RETURN RR

***********************************************************
*func vcel_zus
***********************************************************
*para zparaz_cel
