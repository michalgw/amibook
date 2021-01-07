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
*±±±±±± PARAM    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Modul parametrow programu przechowywanych w pliku PARAM_P.MEM             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

PROCEDURE Param_PPK()

   LOCAL zPPKPS1, zPPKPS2, zPPKEIDKADR, zPPKEIDEPPK, zPPKEIDPZIF
   LOCAL bTN := { | nRow, lTN |
      @ nRow, 77 SAY iif( lTN, 'ak', 'ie' )
      RETURN .T.
   }

   *############################# PARAMETRY POCZATKOWE #########################
   SELECT 1
   IF Dostep( 'FIRMA' )
      SET INDEX TO firma
      GO Val( ident_fir )
   ELSE
      Close_()
      RETURN
   ENDIF

   @ 3, 42 CLEAR TO 22, 79
   *################################# GRAFIKA ##################################
   //@ 3, 42 SAY 'ÍÍ Parametry PPK ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   //@ 4, 42 SAY ' Wpˆata podstawowa pracodawcy:      % '
   //@ 5, 42 SAY ' Wpˆata dodatkowa pracodawcy:       % '
   @ 6, 42 SAY 'ÍÍ Parametry struktury pliku PPK ÍÍÍÍÍ'
   @ 7, 42 SAY ' Doˆ¥cz wewn©trzny identyfikator      '
   @ 8, 42 SAY ' Doˆ¥cz identyfikator ewid. PPK       '
   @ 9, 42 SAY ' Doˆ¥cz identyfikator inst.finan.     '

   *################################# OPERACJE #################################
   Param_PPK_Pokaz()
   kl := 0
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 SAY '[F1]-pomoc'
      ColStd()
      kl := Inkey( 0 )
      DO CASE
      *############################### MODYFIKACJA ################################
      CASE kl == 109 .OR. kl == 77
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                       þ' )
         ColSta()
         center( 23, 'M O D Y F I K A C J A' )
         ColStd()
         BEGIN SEQUENCE
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            //zPPKPS1 := firma->ppkps1
            //zPPKPS2 := firma->ppkps2
            zPPKEIDKADR := iif( firma->ppkeidkadr $ 'TN', firma->ppkeidkadr, 'N' )
            zPPKEIDEPPK := iif( firma->ppkeideppk $ 'TN', firma->ppkeideppk, 'N' )
            zPPKEIDPZIF := iif( firma->ppkeidpzif $ 'TN', firma->ppkeidpzif, 'N' )

            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            //@ 4, 73 GET zPPKPS1 PICTURE "99.99"
            //@ 5, 73 GET zPPKPS2 PICTURE "99.99"
            @ 7, 76 GET zPPKEIDKADR PICTURE "!" VALID zPPKEIDKADR $ 'TN' .AND. Eval( bTN, 7, zPPKEIDKADR == 'T' )
            @ 8, 76 GET zPPKEIDEPPK PICTURE "!" VALID zPPKEIDEPPK $ 'TN' .AND. Eval( bTN, 7, zPPKEIDEPPK == 'T' )
            @ 9, 76 GET zPPKEIDPZIF PICTURE "!" VALID zPPKEIDPZIF $ 'TN' .AND. Eval( bTN, 7, zPPKEIDPZIF == 'T' )
            ****************************
            CLEAR TYPEAHEAD
            Read_()

            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            BlokadaR()
            //firma->ppkps1 := zPPKPS1
            //firma->ppkps2 := zPPKPS2
            firma->ppkeidkadr := zPPKEIDKADR
            firma->ppkeideppk := zPPKEIDEPPK
            firma->ppkeidpzif := zPPKEIDPZIF
            Commit_()
            UNLOCK
         END
         Param_PPK_Pokaz()
         @ 23, 0
         *################################### POMOC ##################################
      CASE kl == 28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[ 1 ] := '                                             '
         p[ 2 ] := '     [M].....................modyfikacja     '
         p[ 3 ] := '     [Esc]...................wyj&_s.cie         '
         p[ 4 ] := '                                             '
         *---------------------------------------
         SET COLOR TO i
         i := 20
         j := 24
         DO WHILE i > 0
            IF Type( 'p[i]' ) # 'U'
               Center( j, p[ i ] )
               j := j - 1
            ENDIF
            i := i - 1
         ENDDO
         ColStd()
         pause( 0 )
         IF LastKey() # 27 .AND. LastKey() # 28
            KEYBOARD Chr( LastKey() )
         ENDIF
         RESTORE SCREEN FROM scr_
         _disp := .F.
         ******************** ENDCASE
      ENDCASE
   ENDDO
   Close_()

   RETURN NIL

*################################## FUNKCJE #################################
PROCEDURE Param_PPK_Pokaz()

   CLEAR TYPEAHEAD
   SET COLOR TO w+
   //@ 4, 73 SAY firma->ppkps1 PICTURE "99.99"
   //@ 5, 73 SAY firma->ppkps2 PICTURE "99.99"
   @ 7, 76 SAY iif( firma->ppkeidkadr == 'T', 'Tak', 'Nie' )
   @ 8, 76 SAY iif( firma->ppkeideppk == 'T', 'Tak', 'Nie' )
   @ 9, 76 SAY iif( firma->ppkeidpzif == 'T', 'Tak', 'Nie' )
   ColStd()

   RETURN NIL

*############################################################################

