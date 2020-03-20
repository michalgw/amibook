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

#include "Inkey.ch"

FUNCTION Dodat5L()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   private _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   @ 1, 47 say '          '
*################################# GRAFIKA ##################################

   ColInf()
   @  3, 0 SAY ' D.  ODLICZENIA OD DOCHODU                                           Kwota z&_l..  '
   ColStd()
   @  4, 0 SAY ' Straty z lat ubieg&_l.ych z pozarolniczej dzia&_l.alno&_s.ci gospodarczej......            '
   @  5, 0 SAY ' Inne odliczenia....................................................            '
   @  6, 0 SAY ' Sk&_l.adki na ubezpieczenie spo&_l.eczne podatnika..........            .            '
   ColInf()
   @  7, 0 SAY ' F.  KWOTY ZWIEKSZAJACE PODSTAWE OPODATKOWANIA/ZMNIEJSZAJACE STRATE  Kwota z&_l..  '
   ColStd()
   @  8, 0 SAY ' Na podstawie przepisow wykonawczych do ustawy z dnia 20.10.1994....            '
   ColInf()
   @  9, 0 SAY ' G.2.ODLICZENIE OD PODATKU                                          Kwota z&_l..   '
   ColStd()
   @ 10, 0 SAY ' Sk&_l.adka na ubezpieczenie zdrowotne (zap&_l.acona)........            .            '
   ColInf()
   @ 11, 0 SAY ' G.4.OGRANICZENIE WYSOKOSCI ZALICZEK ALBO ZANIECHANIE POBORU PODATKU            '
   ColStd()
   @ 12, 0 SAY '     Numer decyzji...                         Data decyzji..........            '
   @ 13, 0 SAY '                                              Kwota.................            '
   ColInf()
   @ 14, 0 SAY ' DANE Z ZALACZNIKA PIT-5/A                                                      '
   ColStd()
   @ 15, 0 SAY '                               Przych&_o.d      Koszty       Doch&_o.d       Strata   '
   @ 16, 0 SAY ' Dzia&_l..gosp.(za&_l..PIT-5/A)....                                                   '
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
   _proc := 'say17l'
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
               zSTRATY := STRATY
               zPOWODZ := POWODZ
               zSKLADKIW := SKLADKIW

               zg21 := g21

               zZDROWIEW := ZDROWIEW
               zZDROWIE := ZDROWIE

               zH384 := spolka->H384
               zH385 := H385
               zH386 := spolka->H386

               zPIT5AGOSK := PIT5AGOSK
               zPIT5AGOSP := PIT5AGOSP

               zPIT5105 := PIT5105

               zODSEODMAJ := ODSEODMAJ

               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               @  4, 68 GET zSTRATY    PICTURE FPICold
               @  5, 68 GET zPOWODZ    PICTURE FPICold
               @  6, 55 GET zSKLADKIW  PICTURE FPICold

               @  8, 68 GET zg21 PICTURE FPICold

               @ 10, 55 GET zZDROWIEW PICTURE FPICold

               @ 12, 21 GET zH384 PICTURE repl( '!', 20 )
               @ 12, 68 GET zH386 PICTURE '@D'
               @ 13, 68 GET zH385 PICTURE FPICold

               @ 16, 29 GET zPIT5AGOSP PICTURE FPICold VALID DOCHSTL()
               @ 16, 42 GET zPIT5AGOSK PICTURE FPICold VALID DOCHSTL()

               @ 19, 68 GET zPIT5105 PICTURE FPICold

               @ 22, 68 GET zODSEODMAJ PICTURe FPICold

               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'STRATY', zSTRATY )
               repl_( 'POWODZ', zPOWODZ )
               repl_( 'SKLADKIW', zSKLADKIW )

               repl_( 'g21', zg21 )

               repl_( 'ZDROWIEW', zZDROWIEW )

               repl_( 'h385', zh385 )

               repl_( 'PIT5AGOSK', zPIT5AGOSK )
               repl_( 'PIT5AGOSP', zPIT5AGOSP )

               repl_( 'PIT5105', zPIT5105 )

               repl_( 'ODSEODMAJ', zODSEODMAJ )

               commit_()
               UNLOCK
               SELECT spolka
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
*################################# MODYFIKACJA SUMY ZUS #####################
         CASE kl == K_CTRL_F10
            @ 1, 47 SAY '          '
            ColStb()
            center( 23, 'þ                                                 þ' )
            ColSta()
            center( 23, 'M O D Y F I K A C J A   S U M Y   S K &__L. A D E K' )
            ColStd()
            BEGIN SEQUENCE
               *-------zamek-------
               IF suma_mc->zamek
                  kom( 3, '*u', ' Miesi&_a.c jest zamkni&_e.ty ' )
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
               zSKLADKI := SKLADKI
               zZDROWIE := ZDROWIE
               @  6, 68 GET zSKLADKI   PICTURE FPICold
               @ 10, 68 GET zZDROWIE   PICTURE FPICold
               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'SKLADKI', zSKLADKI )
               repl_( 'ZDROWIE', zZDROWIE )
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
            p[ 3 ] := '   [Control]+[F10].........modyfikacja sumy sk&_l.adek ZUS '
            p[ 4 ] := '   [Esc]...................wyj&_s.cie                      '
            p[ 5 ] := '                                                        '
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
PROCEDURE say17l()

   CLEAR TYPE
   SET COLOR TO +w
   @  4, 68 SAY STRATY    PICTURE RPIC
   @  5, 68 SAY POWODZ    PICTURE RPIC
   @  6, 55 SAY SKLADKIW  PICTURE RPIC
   @  6, 68 SAY SKLADKI   PICTURE RPIC

   @  8, 68 SAY g21 PICTURE RPIC

   @ 10, 55 SAY ZDROWIEW PICTURE RPIC
   @ 10, 68 SAY ZDROWIE PICTURE RPIC

   @ 12, 21 SAY spolka->H384 PICTURE repl( '!', 20 )
   @ 12, 68 SAY spolka->H386 PICTURE '@D'
   @ 13, 68 SAY H385 PICTURE FPICold

   @ 16, 29 SAY PIT5AGOSP PICTURE RPIC
   @ 16, 42 SAY PIT5AGOSK PICTURE RPIC
   @ 16, 55 SAY Max( 0, PIT5AGOSP - PIT5AGOSK ) PICTURE RPIC
   @ 16, 68 SAY Max( 0, PIT5AGOSK - PIT5AGOSP ) PICTURE RPIC

   @ 19, 68 SAY PIT5105 PICTURE RPIC

   @ 22, 68 SAY ODSEODMAJ PICTURE RPIC

   SET COLOR TO

   RETURN

*********************************************************************
FUNCTION DOCHSTL()

   CoCu := SetColor()
   SET COLO TO w+
   @ 16, 55 SAY Max( 0, PIT5AGOSP - PIT5AGOSK ) PICTURE FPICold
   @ 16, 68 SAY Max( 0, PIT5AGOSK - PIT5AGOSP ) PICTURE FPICold
   SetColor( CoCu )
   RETURN .T.

*############################################################################
