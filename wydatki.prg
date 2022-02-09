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

FUNCTION Wydatki()
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
   PRIVATE _top, _bot, _top_bot, _stop, _sbot, _proc, kl, ins, nr_rec, f10, rec, fou
   @ 1, 47 SAY '          '
   *################################# GRAFIKA ##################################
   ColInf()
   @  3, 0 SAY ' D.  ODLICZENIA DOCHODU ZWOLNIONEGO i STRAT                          Kwota z&_l..  '
   ColStd()
   *@  4, 0 SAY ' Doch&_o.d zwolniony od podatku (za&_l..PIT-5/B)..........................            '
   @  4, 0 SAY ' Doch&_o.d zwolniony od podatku-na podstawie art.21 ust.1 pkt.63a ustawy..            '
   @  5, 0 SAY ' Straty z lat ubieg&_l.ych z pozarolniczej dzia&_l.alno&_s.ci gospodarczej......            '
   @  6, 0 SAY ' Straty z lat ubieg&_l.ych z najmu,podnajmu,dzier&_z.awy i innych umow....            '
   @  7, 0 SAY ' Straty poniesione w wyniku powodzi z lipca 1997roku................            '
   @  8, 0 SAY Space( 80 )
   ColInf()
   @  9, 0 SAY ' E.1.ODLICZENIA OD DOCHODU - na podstawie art.26 ust.1               Kwota z&_l..  '
   ColStd()
   @ 10, 0 SAY ' 1  Sk&_l.adki na ubezpieczenie spo&_l.eczne podatnika.......            .            '
   @ 11, 0 SAY ' 2a Sk&_l.adki na rzecz organizacji z obowi&_a.zkow&_a. przynale&_z.no&_s.ci&_a.......            '
   @ 12, 0 SAY ' 2b Zwrot nienale&_z.nie pobranych emerytur i rent oraz zasi&_l.k&_o.w z US..            '
   @ 13, 0 SAY ' 2c Zwrot nienale&_z.nie pobranych &_s.wiadcze&_n.,kt&_o.re uprzednio zw.doch...            '
   @ 14, 0 SAY ' 2d Wydatki na cele rehabilitacyjne, ponoszone przez podatnika......            '
   @ 15, 0 SAY ' 2e Kwota wydatk&_o.w,o kt&_o.r&_a. zosta&_l.a obni&_z.ona op&_l.ata za wydob.kopalin.            '
   @ 16, 0 SAY ' 2f Darowizny.......................................................            '
   @ 17, 0 SAY ' 2g Fundusz wynagrodzen przyslugujacy osobom pozbawionym wolnosci...            '
   ColInf()
   @ 18, 0 SAY ' E.2.ODLICZENIA OD DOCHODU WYDATKOW MIESZKANIOWYCH                   Kwota z&_l..  '
   ColStd()
   @ 19, 0 SAY '    Wydatki mieszkaniowe............................................            '
   ColInf()
   @ 20, 0 SAY ' E.3.INNE ODLICZENIA NIE WYMIENIONE W CZESCIACH OD E.1 do E.2        Kwota z&_l..  '
   ColStd()
   @ 21, 0 SAY '    Inne odliczenia-................................................            '
   @ 22, 0 SAY Space( 80 )
   *################################# OPERACJE #################################
   *----- parametry ------
   _proc := 'say17'
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
               *  zPIT569=PIT569
               zRENTALIM := RENTALIM
               zSTRATY := STRATY
               zSTRATY_N := STRATY_N
               zPOWODZ := POWODZ

               zSKLADKIW := SKLADKIW
               zORGANY := ORGANY
               zZWROT_REN := ZWROT_REN
               zZWROT_SWI := ZWROT_SWI
               zREHAB := REHAB
               zKOPALINY := KOPALINY
               zDAROWIZ := DAROWIZ
               zWYNAGRO := WYNAGRO

               zBUDOWA := BUDOWA

               zINNE := INNE

               *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
               *@  4,68 get zPIT569    picture FPICold
               @  4, 68 GET zRENTALIM  PICTURE FPICold
               @  5, 68 GET zSTRATY    PICTURE FPICold
               @  6, 68 GET zSTRATY_N  PICTURE FPICold
               @  7, 68 GET zPOWODZ    PICTURE FPICold

               @ 10, 55 GET zSKLADKIW  PICTURE FPICold
               @ 11, 68 GET zORGANY    PICTURE FPICold
               @ 12, 68 GET zZWROT_REN PICTURE FPICold
               @ 13, 68 GET zZWROT_SWI PICTURE FPICold
               @ 14, 68 GET zREHAB     PICTURE FPICold
               @ 15, 68 GET zKOPALINY  PICTURE FPICold
               @ 16, 68 GET zDAROWIZ   PICTURE FPICold
               @ 17, 68 GET zWYNAGRO   PICTURE FPICold

               @ 19, 68 GET zBUDOWA   PICTURE FPICold WHEN ! Empty( spolka->odlicz2 )

               @ 21, 68 GET zINNE     PICTURE FPICold WHEN ! Empty( spolka->odlicz1 )

               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               *repl_([PIT569],zPIT569)
               repl_('RENTALIM', zRENTALIM )
               repl_('STRATY', zSTRATY )
               repl_('STRATY_N', zSTRATY_N )
               repl_('POWODZ', zPOWODZ )

               repl_('SKLADKIW', zSKLADKIW )
               repl_('ORGANY', zORGANY )
               repl_('ZWROT_REN', zZWROT_REN )
               repl_('ZWROT_SWI', zZWROT_SWI )
               repl_('REHAB', zREHAB )
               repl_('KOPALINY', zKOPALINY )
               repl_('DAROWIZ', zDAROWIZ )
               repl_('WYNAGRO', zWYNAGRO )

               repl_('BUDOWA', zBUDOWA )

               repl_('INNE', zINNE )

               commit_()
               UNLOCK
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
               IF TNEsc( , 'Czy przeliczy† sum©?' )
                  zSKLADKI := 0
                  cAktMc := dane_mc->mc
                  nAktRec := dane_mc->( RecNo() )
                  cAktIdent := dane_mc->ident
                  IF dane_mc->( dbSeek( '+' + cAktIdent + ' 1' ) )
                     DO WHILE ! dane_mc->( Eof() ) .AND. dane_mc->ident == cAktIdent .AND. dane_mc->del == '+'
                        IF dane_mc->mc_wue == Val( cAktMc )
                           zSKLADKI := zSKLADKI + dane_mc->war5_wue
                        ENDIF
                        IF dane_mc->mc_wur == Val( cAktMc )
                           zSKLADKI := zSKLADKI + dane_mc->war5_wur
                        ENDIF
                        IF dane_mc->mc_wuc == Val( cAktMc )
                           zSKLADKI := zSKLADKI + dane_mc->war5_wuc
                        ENDIF
                        IF dane_mc->mc_wuw == Val( cAktMc )
                           zSKLADKI := zSKLADKI + dane_mc->war5_wuw
                        ENDIF
                        dane_mc->( dbSkip() )
                     ENDDO
                  ENDIF
                  dane_mc->( dbGoto( nAktRec ) )
               ELSE
                  zSKLADKI := SKLADKI
               ENDIF
               @ 10, 68 GET zSKLADKI PICTURE FPICold
               CLEAR TYPE
               read_()
               IF LastKey() == K_ESC
                  BREAK
               ENDIF
               *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
               BLOKADAR()
               repl_( 'SKLADKI', zSKLADKI )
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

PROCEDURE say17()

   CLEAR TYPE
   SET COLOR TO +w
   *@  4,68 SAY PIT569    PICTURE RPIC
   @  4, 68 SAY RENTALIM  PICTURE RPIC
   @  5, 68 SAY STRATY    PICTURE RPIC
   @  6, 68 SAY STRATY_N  PICTURE RPIC
   @  7, 68 SAY POWODZ    PICTURE RPIC

   @ 10, 55 SAY SKLADKIW  PICTURE RPIC
   @ 10, 68 SAY SKLADKI   PICTURE RPIC
   @ 11, 68 SAY ORGANY    PICTURE RPIC
   @ 12, 68 SAY ZWROT_REN PICTURE RPIC
   @ 13, 68 SAY ZWROT_SWI PICTURE RPIC
   @ 14, 68 SAY REHAB     PICTURE RPIC
   @ 15, 68 SAY KOPALINY  PICTURE RPIC
   @ 16, 68 SAY DAROWIZ   PICTURE RPIC
   @ 17, 68 SAY WYNAGRO   PICTURE RPIC

   @ 19, 36 SAY AllTrim( spolka->odlicz2 )
   @ 19, 68 SAY BUDOWA   PICTURE RPIC

   @ 21, 36 SAY AllTrim( spolka->odlicz1 )
   @ 21, 68 SAY INNE     PICTURE RPIC

   SET COLOR TO

   RETURN

*############################################################################
