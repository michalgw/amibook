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

#include "Inkey.ch"

FUNCTION Wydatki2()
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   ColInf()
   @  3, 0 SAY ' F.  ODLICZENIA Z TYTULU WYDATKOW INWESTYCYJNYCH                     Kwota z&_l..  '
   ColStd()
   @  4, 0 SAY '    Dodatkowa obnizka..............................................            '
   @  5, 0 SAY '                                                                                '
   @  6, 0 SAY '                                                                                '
   ColInf()
   @  7, 0 SAY ' G.  DOCHOD ZWOLNIONY OD PODATKU                                     Kwota z&_l..  '
   ColStd()
   @  8, 0 SAY '    Dochod zwolniony od podatku na podstawie przepisow o SSE........            '
   @  9, 0 SAY '                                                                                '
   ColInf()
   @ 10, 0 SAY ' I.  KWOTY ZWIEKSZAJACE PODSTAWE OPODATKOWANIA/ZMNIEJSZAJACE STRATE  Kwota z&_l..  '
   ColStd()
   @ 11, 0 SAY '    Na podstawie przepisow wykonawczych do ustawy z dnia 20.10.1994.            '
   @ 12, 0 SAY '                                                                                '
   @ 13, 0 SAY '                                                                                '
   @ 14, 0 SAY '                                                                                '
   @ 15, 0 SAY '                                                                                '
   @ 16, 0 SAY '                                                                                '
   @ 17, 0 SAY '                                                                                '
   @ 18, 0 SAY '                                                                                '
   @ 19, 0 SAY '                                                                                '
   @ 20, 0 SAY '                                                                                '
   @ 21, 0 SAY '                                                                                '
   @ 22, 0 SAY '                                                                                '
   *################################# OPERACJE #################################
   *----- parametry ------
   _proc := 'say172'
   *----------------------
   DO &_proc
   kl := 0
   DO WHILE kl # K_ESC
      @ 1, 47 SAY '[F1]-pomoc'
      kl := Inkey( 0 )
      DO CASE
*########################### INSERT/MODYFIKACJA #############################
         CASE kl == Asc( 'M' ) .OR. kl == Asc( 'm' )
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                       þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A' )
            ColStd()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð

               zUBIEGINW := UBIEGINW

               zDOCHZWOL := DOCHZWOL

               zg21 := g21
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð

               @  4, 68 GET zUBIEGINW PICTURE FPICold

               @  8, 68 GET zDOCHZWOL PICTURE FPICold

               @ 11, 68 GET zg21 PICTURE FPICold

               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()

               repl_( 'UBIEGINW', zUBIEGINW )

               repl_( 'DOCHZWOL', zDOCHZWOL )

               repl_( 'g21', zg21 )
               commit_()
               UNLOCK
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            END
            DO &_proc
            @ 23, 0
*################################### POMOC ##################################
         CASE kl == K_F1
            SAVE SCREEN TO scr_
            @ 1, 47 SAY '          '
            DECLARE p[ 20 ]
            *---------------------------------------
            p[ 1 ] := '                                                        '
            p[ 2 ] := '   [M].....................modyfikacja                  '
            p[ 3 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 4 ] := '                                                        '
            *---------------------------------------
            SET COLOR TO i
            i := 20
            j := 24
            DO WHILE i > 0
               IF Type( 'p[i]' ) # 'U'
                  center( j, p[ i ] )
                  j := j - 1
               ENDIF
               i := i - 1
            ENDDO
            SET COLOR TO
            pause( 0 )
            IF LastKey() # K_ESC .AND. LastKey() # K_F1
               KEYBOARD Chr( LastKey() )
            ENDIF
            RESTORE SCREEN FROM scr_

******************** ENDCASE
      ENDCASE
   ENDDO

   RETURN NIL

*################################## FUNKCJE #################################

PROCEDURE say172()

   CLEAR TYPE
   SET COLOR TO +w

   @  4, 68 SAY UBIEGINW PICTURE RPIC

   @  8, 68 SAY DOCHZWOL PICTURE RPIC

   @ 11, 68 SAY g21 PICTURE RPIC
   SET COLOR TO

   RETURN NIL

*############################################################################
