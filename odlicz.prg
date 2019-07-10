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

FUNCTION Odlicz()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   @ 1, 47 SAY '          '
*################################# GRAFIKA ##################################
   ColInf()
   @  3, 0 SAY ' J.2.ODLICZENIA OD PODATKU                                          Kwota z&_l..   '
   ColStd()
   @  4, 0 SAY ' Sk&_l.adka na ubezpieczenie zdrowotne (zap&_l.acona)........            .            '
   @  5, 0 SAY ' Ulgi inwestycyjne przyznane przed 1.01.1992r.......................            '
   @  6, 0 SAY ' Ulgi za wyszkolenie ucznia.........................................            '
   @  7, 0 SAY ' Inne odliczenia-...................................................            '
   @  8, 0 SAY ' Zap&_l.acona zaliczka za miesi&_a.c poprzedni............................            '
   ColInf()
   @  9, 0 SAY ' J.4.OGRANICZENIE WYSOKOSCI ZALICZEK ALBO ZANIECHANIE POBORU PODATKU            '
   ColStd()
   @ 10, 0 SAY '     Numer decyzji...                         Data decyzji..........            '
   @ 11, 0 SAY '                                              Kwota.................            '
   @ 12, 0 SAY '                                                                                '
   ColInf()
   @ 13, 0 SAY ' DANE Z ZALACZNIKA PIT-5/A                                                      '
   ColStd()
   @ 14, 0 SAY '                               Przych&_o.d      Koszty       Doch&_o.d       Strata   '
   @ 15, 0 SAY ' Dzia&_l..gosp.(za&_l..PIT-5/A)....                                                   '
   @ 16, 0 SAY ' Najem      (za&_l..PIT-5/A)....                                                   '
   @ 17, 0 SAY '                                                                                '
   ColInf()
   @ 18, 0 SAY ' DANE Z REMANENTU LIKWIDACYJNEGO                                                '
   ColStd()
   @ 19, 0 SAY ' Nalezny zryczaltowany podatek dochodowy od dochodu z reman.likwid..            '
   @ 20, 0 SAY '                                                                                '
   ColInf()
   @ 21, 0 SAY ' KWOTA ODSETEK NALICZONYCH OD DNIA ZALICZENIA DO KOSZTOW UZYSKANIA PRZYCHODOW   '
   ColStd()
   @ 22, 0 SAY ' wydatkow na nabycie lub wytworzenie we wlasnym zakresie sklad.maj..            '
*################################# OPERACJE #################################
   *----- parametry ------
   _proc := 'say7'
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
               *-------------------
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               zZDROWIEW := ZDROWIEW
               zZDROWIE := ZDROWIE
               zAAA := AAA
               zBBB := BBB
               zZALICZKA := ZALICZKA
               zINNEODPOD := INNEODPOD

               zH384 := spolka->H384
               zH385 := H385
               zH386 := spolka->H386

               zPIT5AGOSK := PIT5AGOSK
               zPIT5ANAJK := PIT5ANAJK
               zPIT5AGOSP := PIT5AGOSP
               zPIT5ANAJP := PIT5ANAJP

               *zPIT5104=PIT5104
               zPIT5105 := PIT5105

               zODSEODMAJ := ODSEODMAJ
               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               @  4, 55 GET zZDROWIEW PICTURE FPICold
               @  5, 68 GET zAAA PICTURE FPICold
               @  6, 68 GET zBBB PICTURE FPICold
               @  7, 68 GET zINNEODPOD PICTURE FPICold
               @  8, 68 GET zZALICZKA PICTURE FPICold

               @ 10, 21 GET zH384 PICTURE repl('!',20)
               @ 10, 68 GET zH386 PICTURE '@D'
               @ 11, 68 GET zH385 PICTURE FPICold

               @ 15, 29 GET zPIT5AGOSP PICTURE FPICold VALID DOCHST()
               @ 15, 42 GET zPIT5AGOSK PICTURE FPICold VALID DOCHST()
               @ 16, 29 GET zPIT5ANAJP PICTURE FPICold VALID DOCHST()
               @ 16, 42 GET zPIT5ANAJK PICTURE FPICold VALID DOCHST()

               @ 19, 68 GET zPIT5105 PICTURE FPICold
               *@ 20,68 GET zPIT5105 PICTURE FPICold

               @ 22,68 GET zODSEODMAJ PICTURE FPICold

               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'ZDROWIEW', zZDROWIEW )
               repl_( 'AAA', zAAA )
               repl_( 'BBB', zBBB )
               repl_( 'INNEODPOD', zINNEODPOD )
               repl_( 'ZALICZKA', zZALICZKA )

               repl_( 'h385', zh385 )

               repl_( 'PIT5AGOSK', zPIT5AGOSK )
               repl_( 'PIT5ANAJK', zPIT5ANAJK )
               repl_( 'PIT5AGOSP', zPIT5AGOSP )
               repl_( 'PIT5ANAJP', zPIT5ANAJP )

               *repl_([PIT5104],zPIT5104)
               repl_( 'PIT5105', zPIT5105 )

               repl_( 'ODSEODMAJ', zODSEODMAJ )

               commit_()
               UNLOCK
               SELE SPOLKA
               BLOKADAR()
               repl_( 'h384', zh384 )
               repl_( 'h386', zh386 )
               commit_()
               UNLOCK
               SELECT dane_mc
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            END
            DO &_proc
            @ 23, 0
*################################# MODYFIKACJA SUMY ZDROWOTNEGO #############
         case kl == K_CTRL_F10
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                                                                           þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A   S U M Y   S K &__L. A D E K   N A   Z D R O W O T N E' )
            ColStd()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               zZDROWIE := ZDROWIE
               @  6, 68 GET zZDROWIE   PICTURE FPICold
               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'ZDROWIE', zZDROWIE )
               commit_()
               UNLOCK
               *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð-ð
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
                  center( j, p[i] )
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

PROCEDURE say7()

   clear type
   set color to +w
   @  4, 55 SAY ZDROWIEW PICTURE RPIC
   @  4, 68 SAY ZDROWIE PICTURE RPIC
   @  5, 68 SAY AAA PICTURE RPIC
   @  6, 68 SAY BBB PICTURE RPIC
   @  7, 36 SAY AllTrim( spolka->s_rodzaj )
   @  7, 68 SAY INNEODPOD PICTURE RPIC
   @  8, 68 SAY ZALICZKA PICTURE RPIC

   @ 10, 21 SAY spolka->H384 PICTURE repl( '!', 20 )
   @ 10, 68 SAY spolka->H386 PICTURE '@D'
   @ 11, 68 SAY H385 PICTURE FPICold

   @ 15, 29 SAY PIT5AGOSP PICTURE RPIC
   @ 15, 42 SAY PIT5AGOSK PICTURE RPIC
   @ 15, 55 SAY Max( 0, PIT5AGOSP - PIT5AGOSK ) PICTURE RPIC
   @ 15, 68 SAY Max( 0, PIT5AGOSK - PIT5AGOSP ) PICTURE RPIC
   @ 16, 29 SAY PIT5ANAJP PICTURE RPIC
   @ 16, 42 SAY PIT5ANAJK PICTURE RPIC
   @ 16, 55 SAY Max( 0, PIT5ANAJP - PIT5ANAJK ) PICTURE RPIC
   @ 16, 68 SAY Max( 0, PIT5ANAJK - PIT5ANAJP ) PICTURE RPIC

   @ 19, 68 SAY PIT5105 PICTURE RPIC
   *@ 20 ,68 SAy PIT5105 picture RPIC

   @ 22, 68 SAY ODSEODMAJ PICTURE RPIC
   SET COLOR TO

   RETURN

*********************************************************************
FUNCTION DOCHST()
*********************************************************************

   CoCu := SetColor()
   SET COLOR TO w+
   @ 15, 55 SAY Max( 0, PIT5AGOSP - PIT5AGOSK ) PICTURE FPICold
   @ 15, 68 SAY Max( 0, PIT5AGOSK - PIT5AGOSP ) PICTURE FPICold
   @ 16, 55 SAY Max( 0, PIT5ANAJP - PIT5ANAJK ) PICTURE FPICold
   @ 16, 68 SAY Max( 0, PIT5ANAJK - PIT5ANAJP ) PICTURE FPICold
   SetColor( CoCu )

   RETURN .T.

*############################################################################
