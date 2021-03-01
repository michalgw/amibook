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

#include "Directry.ch"
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ODTW     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura obslugujaca odtwarzanie danych z dyskietek.                     ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Odtw()

   archfile := 'ksiega'
   IF .NOT. File( 'odtw.mem' )
      *---------------------------------------
      @  3,42 say '                                      '
      @  4,42 say '                                      '
      @  5,42 say '                                      '
      @  6,42 say '                                      '
      @  7,42 say '                                      '
      @  8,42 say '                                      '
      @  9,42 say '                                      '
      @ 10,42 say '    Opcja odtwarzania danych zamienia '
      @ 11,42 say '    dane w komputerze na dane zawarte '
      @ 12,42 say '    w kopii na wskazanym dysku.       '
      @ 13,42 say '    W przypadku odtwarzania danych    '
      @ 14,42 say '    z dyskietek, kolejno&_s.&_c. wsuwanych  '
      @ 15,42 say '    dyskietek nie jest istotna.       '
      @ 16,42 say '                                      '
      @ 17,42 say '                                      '
      @ 18,42 say '                                      '
      @ 19,42 say '                                      '
      @ 20,42 say '                                      '
      @ 21,42 say '                                      '
      @ 22,42 say '                                      '
      *---------------------------------------
      IF .NOT. TNEsc( '*i', ' UWAGA ! Informacje w bazach danych zostan&_a. zamienione - jeste&_s. pewny? (T/N) ' )
         RETURN
      ENDIF
      @ 1,47 say space(10)

      sciez_ar := 'c:\'
      IF .NOT. File( 'archpath.mem' )
         SAVE TO archpath ALL LIKE sciez_ar
      ELSE
         RESTORE FROM archpath ADDITIVE
      ENDIF
      razempl := 0
      DO WHILE razempl == 0
         sciez_ar := AllTrim( sciez_ar ) + repl( ' ', 100 - Len( AllTrim( sciez_ar ) ) )
         @ 24, 0 CLEAR TO 24, 79
         @ 24, 5 SAY 'Podaj dysk i folder z kopi&_a. ' GET sciez_ar PICTURE '@S30 ' + repl( '!', 100 )
         READ
         IF LastKey() == 27
            RETURN
         ENDIF

         pel_path := ''
         if SubStr( AllTrim( sciez_ar ), Len( AllTrim( sciez_ar ) ), 1 ) == '\'
            pel_path := AllTrim( sciez_ar )
         ELSE
            pel_path := AllTrim( sciez_ar ) + '\'
         ENDIF

         razempl := 0
         zparspr := AllTrim( pel_path ) + '*.z01'
         katal := Directory( zparspr, 'HSD' )
         AEval( katal,{ | zbi | RAZEMPL++ } )
         ASort( katal, , , { | x, y | x[ F_DATE ] > y[ F_DATE ] } )
         listaplik := {}
         FOR nItem := 1 TO razempl
            AADD( listaplik, PadR( katal[ nItem, F_NAME ], 15 ) + ;
                          IF( SubStr( katal[ nItem, F_ATTR ], ;
                          1, 1 ) == "D", "   <dir>", ;
                          Str( katal[ nItem, F_SIZE ], 8 ) ) + "  " + ;
                          DToC( katal[ nItem, F_DATE ] ) + "  " + ;
                          SubStr( katal[ nItem, F_TIME ], 1, 5 ) + "  " + ;
                          SubStr( katal[ nItem, F_ATTR ], 1, 4 ) + "  " )
         NEXT

         IF razempl == 0
            komun( 'Brak podanego folderu lub plikow z kopiami. Podaj inny folder' )
         ELSE
            @ 9, 29 CLEAR TO 23, 79
            @ 9, 29 TO 23, 79
            @ 9, 39 SAY 'Wybierz kopi&_e. kt&_o.ra odtworzy&_c.'
            wybrplik := AChoice( 10, 30, 23, 78, listaplik, .T. )
            IF LastKey() == 13
               pel_path := pel_path + SubStr( listaplik[ wybrplik ], 1, 12 )
               IF TNEsc( 0, 'Jestes pewny ze chcesz zastapic dane w bazach danymi z tej kopii ? (T/N) ' ) == .T.
                  COPY FILE &pel_path TO kopia.arc
                  il_dysk := 1
                  SAVE TO odtw ALL LIKE il_dysk
                  SAVE TO scr ALL LIKE scr
                  IF File( RAPTEMP + '.dbf' )
                     DELETE FILE &RAPTEMP..dbf
                  ENDIF
                  IF File( RAPTEMP + '.cdx' )
                     DELETE FILE &RAPTEMP..cdx
                  ENDIF
                  RELEASE ALL
                  hbfr_FreeLibrary()
                  amiDllZakoncz()
                  CANCEL
               ELSE
                  RETURN
               ENDIF
            ELSE
               RETURN
            ENDIF
         ENDIF

      ENDDO
   ENDIF
   RESTORE FROM odtw ADDITIVE
   RESTORE FROM scr ADDITIVE
   ColInb()
   @ 24, 0 CLEAR
   center( 24, 'Prosz&_e. czeka&_c....' )
   SET COLOR TO
   odtw_()
   Indeks()
   *!indeks
   numeruj()
   center( 24, '- Odtwarzanie zako&_n.czone -' )
   IF param_dzw == 'T'
      Tone( 500, 4 )
   ENDIF
   Pause( 0 )

   RETURN NIL
   *********************

PROCEDURE odtw_()

   FOR i := 1 TO il_dysk
       ERASE ( archfile + '.' + iif( i == il_dysk, 'z', 'x' ) + StrTran( Str( i, 2 ), ' ', '0' ) )
   NEXT
   ERASE arch.mem
   ERASE odtw.mem
   ERASE scr.mem
   ERASE kopia.arc

   RETURN NIL
