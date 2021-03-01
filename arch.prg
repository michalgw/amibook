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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ARCH     ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Procedura obslugujaca archiwowanie danych na dyskietki.                   ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION Arch()

   archfile := 'ksiega'

   DECLARE p[ 1 ]

   IF .NOT. File( 'arch.mem' )
      *---------------------------------------
      @  3, 42 SAY '                                      '
      @  4, 42 SAY '                                      '
      @  5, 42 SAY '                                      '
      @  6, 42 SAY '                                      '
      @  7, 42 SAY '                                      '
      @  8, 42 SAY '    Opcja kopiowania danych tworzy    '
      @  9, 42 SAY '    na wskazanym dysku kopie danych   '
      @ 10, 42 SAY '    programu.                         '
      @ 11, 42 SAY '    W przypadku kopiowania danych     '
      @ 12, 42 SAY '    na dyskietki, nalezy uzyc puste   '
      @ 13, 42 SAY '    sformatowane dyskietki. Kolejne   '
      @ 14, 42 SAY '    kopiowanie na te same dyskietki   '
      @ 15, 42 SAY '    likwiduje poprzedni zapis         '
      @ 16, 42 SAY '    samoczynnie. Nie trzeba pamietac  '
      @ 17, 42 SAY '    kolejnosci dyskietek przy         '
      @ 18, 42 SAY '    odtwarzaniu danych.               '
      @ 19, 42 SAY '                                      '
      @ 20, 42 SAY '                                      '
      @ 21, 42 SAY '                                      '
      @ 22, 42 SAY '                                      '
      *---------------------------------------
      @  1, 47 SAY Space( 10 )
      naped := 2
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
         @ 24, 5 SAY 'Podaj folder do zapisu kopii' GET sciez_ar PICTURE '@S30 ' + repl( '!' , 100 )
         READ
         IF LastKey() == 27
            RETURN
         ENDIF

         razempl := 0
         zparspr := AllTrim( sciez_ar ) + '*.*'
         katal := Directory( zparspr, 'HSDV' )
         AEval( katal,{ | zbi | RAZEMPL++ } )
         IF razempl == 0
            Komun( 'Brak podanego folderu. Podaj inny' )
         ELSE
            SAVE TO archpath ALL LIKE sciez_ar
         ENDIF

      ENDDO
      Czekaj()
      *+++++++++++++++++++++++++++++++++
      SAVE TO arch ALL LIKE naped
      SAVE TO scr ALL LIKE scr
      IF File( RAPTEMP + '.dbf' )
         DELETE FILE &RAPTEMP..dbf
      ENDIF
      IF File( RAPTEMP + '.cdx' )
         DELETE FILE &RAPTEMP..cdx
      ENDIF
      hbfr_FreeLibrary()
      amiDllZakoncz()
      WinPrintDone()
      CANCEL
   ENDIF
   RESTORE FROM arch ADDITIVE
   RESTORE FROM scr ADDITIVE
   ERASE arch.mem
   ERASE scr.mem
   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   Czekaj()
   x := FOpen( 'kopia.arc', 0 )
   IF fblad( FError() ) <> 0
      RETURN
   ENDIF

   pel_path := ''
   sciez_ar := 'c:\'
   IF .NOT. File( 'archpath.mem' )
      SAVE TO archpath ALL LIKE sciez_ar
   ELSE
      RESTORE FROM archpath ADDITIVE
   ENDIF
   wernaz := StrTran( wersprog, '.', '' ) + StrTran( SubStr( StrTran( Time(), ':', '' ), 1, 4 ), ' ' , '0' )
   IF SubStr( AllTrim( sciez_ar ), Len( AllTrim( sciez_ar ) ), 1 ) == '\'
      pel_path := AllTrim( sciez_ar ) + wernaz + '.z01'
      COPY FILE kopia.arc TO &pel_path
   ELSE
      pel_path := AllTrim( sciez_ar ) + '\' + wernaz + '.z01'
      COPY FILE kopia.arc TO &pel_path
   ENDIF

   *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   arch_()
   @ 24, 0
   center( 24, '- kopiowanie zako&_n.czone -' )
   IF nr_uzytk <> 81
      Tone( 500, 4 )
   ENDIF
   Pause( 0 )

   RETURN NIL

*********************
PROCEDURE arch_()

   FClose( x )
   RELEASE ALL LIKE inf
   COPY FILE kopia.arc TO kopia.kpr
   ERASE kopia.arc

   RETURN NIL