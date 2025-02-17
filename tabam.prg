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
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
FUNCTION TabAm( mieskart )

   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, ;
      _top, _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, ;
      nr_rec, wiersz, f10, rec, fou, mieslok

   PRIVATE aPolaFiltru := KartSt_Filtr_Czysty()

   PRIVATE bFiltr := { | |
      RETURN iif( ! Empty( aPolaFiltru[ 'DataPrzyOd' ] ), kartst->data_zak >= aPolaFiltru[ 'DataPrzyOd' ], .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'DataPrzyDo' ] ), kartst->data_zak <= aPolaFiltru[ 'DataPrzyDo' ], .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'NrEwid' ] ), At( AllTrim( aPolaFiltru[ 'NrEwid' ] ), kartst->nrewid ) > 0, .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'Nazwa' ] ), At( AllTrim( aPolaFiltru[ 'Nazwa' ] ), kartst->nazwa ) > 0, .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'KST' ] ), SubStr( kartst->krst, 1, Len( AllTrim( aPolaFiltru[ 'KST' ] ) ) ) == AllTrim( aPolaFiltru[ 'KST' ] ), .T. ) .AND. ;
      iif( aPolaFiltru[ 'Rodzaj' ] <> 'W', iif( aPolaFiltru[ 'Rodzaj' ] == 'A', Empty( kartst->data_lik ) .AND. Empty( kartst->data_sprz ), ! Empty( kartst->data_lik ) .OR. ! Empty( kartst->data_sprz ) ), .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'DataLikOd' ] ), ( ! Empty( kartst->data_lik ) .AND. kartst->data_lik >= aPolaFiltru[ 'DataLikOd' ] ) .OR. ( ! Empty( kartst->data_sprz ) .AND. kartst->data_sprz >= aPolaFiltru[ 'DataLikOd' ] ), .T. ) .AND. ;
      iif( ! Empty( aPolaFiltru[ 'DataLikDo' ] ), ( ! Empty( kartst->data_lik ) .AND. kartst->data_lik <= aPolaFiltru[ 'DataLikDo' ] ) .OR. ( ! Empty( kartst->data_sprz ) .AND. kartst->data_sprz <= aPolaFiltru[ 'DataLikDo' ] ), .T. )
   }

   mieslok := mieskart

   @ 1, 47 SAY '          '
   *set cent off
   *################################# GRAFIKA ##################################
   @  3, 0 SAY '      T A B E L E   A M O R T Y Z A C J I   &__S. R O D K &__O. W   T R W A &__L. Y C H     '
   @  4, 0 SAY 'ÚData OT/LTÂÄÄNrEwidÄÄÂÄÄÄKSTÄÄÄÄ¿M-c/Rok                                       '
   @  5, 0 SAY '³          ³          ³          ³Wartosc                                       '
   @  6, 0 SAY '³          ³          ³          ³Przelicz.                                     '
   @  7, 0 SAY '³          ³          ³          ³WartAkt                                       '
   @  8, 0 SAY '³          ³          ³          ³Umorz                                         '
   @  9, 0 SAY '³          ³          ³          ³ 1                                            '
   @ 10, 0 SAY '³          ³          ³          ³ 2                                            '
   @ 11, 0 SAY '³          ³          ³          ³ 3                                            '
   @ 12, 0 SAY '³          ³          ³          ³ 4                                            '
   @ 13, 0 SAY '³          ³          ³          ³ 5                                            '
   @ 14, 0 SAY '³          ³          ³          ³ 6                                            '
   @ 15, 0 SAY '³          ³          ³          ³ 7                                            '
   @ 16, 0 SAY '³          ³          ³          ³ 8                                            '
   @ 17, 0 SAY 'ÚData ZmianÂKwota(+/-)ÄOpis zmian¿ 9                                            '
   @ 18, 0 SAY '³          ³          ³          ³10                                            '
   @ 19, 0 SAY '³          ³          ³          ³11                                            '
   @ 20, 0 SAY '³          ³          ³          ³12                                            '
   @ 21, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙRAZEM  999999.99 999999.99 999999.99 999999.99'
   @ 22, 0 SAY 'NAZWA:                                          OPIS:                           '
   ColInf()
   @  4, 6 SAY 'O'
   @  4, 9 SAY 'L'
   @ 17, 6 SAY 'Z'
   SET COLOR TO

   *############################### OTWARCIE BAZ ###############################
   SELECT 3
   DO WHILE .NOT. Dostep( 'KARTSTMO' )
   ENDDO
   SetInd( 'KARTSTMO' )

   SELECT 2
   DO WHILE .NOT. Dostep( 'AMORT' )
   ENDDO
   SetInd( 'AMORT' )
   SELECT 1
   DO WHILE .NOT. Dostep( 'KARTST' )
   ENDDO
   SetInd( 'KARTST' )
   SEEK '+' + ident_fir
   IF Eof() .OR. del # '+' .OR. firma # ident_fir
      kom( 3, '*u', ' Brak srodk&_o.w trwa&_l.ych ' )
      RETURN
   ENDIF

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 5
   _col_l := 1
   _row_d := 16
   _col_p := 32
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,13,247,77,109,90,122,79,111,76,108,7,28,70,102,67,99'
   _top := 'firma#ident_fir'
   _bot := "eof().or.del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'say41est()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'say41esst'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot

   *----------------------
   kl := 0
   OL := 'O'
   DO WHILE kl # 27
      ColSta()
      @ 1, 47 say '[F1]-pomoc'
      SET COLOR TO
      ROK1 := Space( 6 )
      ROK2 := Space( 6 )
      ROK3 := Space( 6 )
      ROK4 := Space( 6 )
      _row := Wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      CASE (kl == 77 .OR. kl == 109 ) .AND. Len( AllTrim( DToS( data_lik ) ) ) == 0
         SAVE SCREEN TO robs
         wybrok := 1
         CoCu := ColPro()
         FOR x := 0 TO 3
            nrrok := Str( x + 1, 1 )
            IF ROK&NRROK # Space( 6 )
               @ 4, 44 + ( x * 10 ) PROMPT ROK&NRROK
            ENDIF
         NEXT
         wybrok := menu( wybrok )
         swybr := Str( wybrok, 1 )
         zidp := Str( rec_no, 5 )
         ZPRZE := Space( 7 )
         ZMC := Space( 10 )
         zSPOSOB := SPOSOB
         IF wybrok # 0
            IF Val( param_rok ) > Val( AllTrim( ROK&swybr ) ) .AND. ! TNEsc( , "Pr¢bujesz edytowa† poprzedni rok. Czy jeste˜ pewien? (Tak/Nie)" )
               //kom( 3, '*u', ' Nie mo&_z.esz aktualizowa&_c. poprzednich lat ' )
               wybrok := 0
            ENDIF
            IF wybrok # 0
               SELECT KARTSTMO
               SEEK '+' + zidp + AllTrim( ROK&swybr )
               *if found()
               IF .NOT. Eof() .AND. del == '+' .AND. ident == zidp .AND. SubStr( DToS( DATA_MOD ), 1, 4 ) >= AllTrim( ROK&swybr )
                  kom( 3, '*u', ' Zmiany musz&_a. by&_c. dokonywane chronologicznie. S&_a. ju&_z. p&_o.&_z.niejsze modyfikacje ' )
                  wybrok := 0
               ENDIF
               SELECT KARTST
            ENDIF
            IF wybrok # 0
               SELECT AMORT
               SEEK '+' + zidp + AllTrim( ROK&swybr )
               IF Found()
                  wybpol := 1
                  ZPRZE := Transform( PRZEL, '999.999' )
                  IF Val( ROK&swybr ) == Year( kartst->data_zak )
                     nMCRozp := Month( kartst->data_zak )
                  ELSE
                     nMCRozp := 1
                  ENDIF
                  @ 6, 43 + ( ( wybrok - 1 ) * 10 ) PROMPT Zprze
                  FOR nI := nMCRozp TO 12
                     cMCRozp := StrTran( Str( nI, 2, 0 ), ' ', '0' )
                     NMC := MC&cMCRozp
                     ZMC := Transform( NMC, '@Z 999999.99' )
                     @ 8 + nI, 41 + ( ( wybrok - 1 ) * 10 ) PROMPT ZMC
                  NEXT
                  cMCRozp := StrTran( Str( nMCRozp, 2, 0 ), ' ', '0' )
                  wybpol := menu( wybpol )
                  swybp := StrTran( Str( wybpol - 1, 2 ), ' ', '0' )
                  ColStd()
                  modya := 0
                  DO CASE
                  CASE wybpol = 1
                     zprze := Val( zprze )
                     SET CURSOR ON
                     @ 6, 43 + ( ( wybrok - 1 ) * 10 ) GET Zprze PICTURE '999.999' VALID zprze # 0
                     READ
                     SET CURSOR OFF
                     IF LastKey() # 27
                        MODYA := 1
                        BlokadaR()
                        REPLACE PRZEL WITH zPRZE
                        COMMIT
                        UNLOCK
                     ENDIF
                     ZPRZE := Transform( zPRZE, '999.999' )
                  CASE wybpol > 1
                     cMCRozp := StrTran( Str( wybpol + nMCRozp - 2, 2, 0 ), ' ', '0' )
                     NMC := MC&cMCRozp
                     SET CURSOR ON
                     @ 8 + wybpol - 1 + nMCRozp - 1, 41 + ( ( wybrok - 1 ) * 10 ) GET NMC PICTURE '999999.99' /* VALID NMC # 0 */
                     READ
                     SET CURSOR OFF
                     IF LastKey() # 27
                        MODYA := 2
                        BlokadaR()
                        REPLACE MC&cMCRozp WITH NMC
                        COMMIT
                        UNLOCK
                     ENDIF
                  ENDCASE
                  kon := .F.
                  IF MODYA # 0
                     ZMC := MC&cMCRozp
                     zprzel := przel
                     zwart_pocz := WART_POCZ
                     zwart_akt := zwart_pocz * zprzel
                     zodpis_rok := 0
                     reccu := RecNo()
                     SKIP -1
                     IF .NOT. Bof() .AND. del + ident = '+' + zidp
                        zodpis_sum := odpis_sum
                     ELSE
                        zodpis_sum := 0
                     ENDIF
                     GO reccu
                     zumorz_akt := zodpis_sum * zprzel
                     zodpis_sum := zumorz_akt
                     zliniowo := _round( zwart_akt * ( stawka / 100 ), 2 )
                     zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( stawka * wspdeg ) / 100 ), 2 )
                     zodpis_mie := iif( modya=1, iif( zSPOSOB = 'L', _round( zliniowo / 12, 2 ), iif( zSPOSOB = 'J', zwart_pocz, _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) ) ), zmc )
                     BlokadaR()
                     REPLACE przel WITH zprzel, ;
                        wart_akt WITH zwart_akt, ;
                        umorz_akt WITH zumorz_akt, ;
                        liniowo WITH zliniowo, ;
                        degres WITH zdegres
                     FOR i := nMCRozp TO 12
                        zmcn := StrTran( Str( i, 2 ), ' ', '0' )
                        IF kon
                           REPLACE mc&zmcn WITH 0
                        ELSEIF i < Val( cMCRozp )
                           zodpis_rok := zodpis_rok + mc&zmcn
                           zodpis_sum := zodpis_sum + mc&zmcn
                        ELSE
                           IF zodpis_mie > zwart_akt - zodpis_sum
                              REPLACE mc&zmcn WITH zwart_akt - zodpis_sum
                              zodpis_rok := zodpis_rok + ( zwart_akt - zodpis_sum )
                              zodpis_sum := zodpis_sum + ( zwart_akt - zodpis_sum )
                              kon := .T.
                            ELSE
                              REPLACE mc&zmcn WITH zodpis_mie
                              zodpis_rok := zodpis_rok + zodpis_mie
                              zodpis_sum := zodpis_sum + zodpis_mie
                           ENDIF
                        ENDIF
                     NEXT
                     REPLACE odpis_rok WITH zodpis_rok, ;
                        odpis_sum WITH zodpis_sum
                     COMMIT
                     UNLOCK
                     odr := Val( ROK ) + 1
                     zprzel := 1
                     zstawka := stawka
                     zwspdeg := wspdeg
                     zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
                     zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
                     zodpis_mie := iif( zSPOSOB='L', _round( zliniowo / 12, 2 ), iif( zSPOSOB = 'J', zwart_pocz, _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) ) )
                     zodpis_rok := 0
                     SKIP
                     IF .NOT. Eof() .AND. del + ident = '+' + zidp
                        Blokada()
                        DELETE rest WHILE del + ident = '+' + zidp
                     ENDIF
                     IF .NOT. kon
                        DO WHILE .T.
                           CURR := ColInf()
                           @ 24, 0
                           center( 24, 'Aktualizuje ' )
                           SetColor( CURR )
                           app()
                           REPLACE firma WITH ident_fir,;
                              ident WITH zidp,;
                              rok WITH str(odr,4),;
                              wart_pocz WITH zwart_akt,;
                              przel WITH zprzel,;
                              wart_akt WITH zwart_akt,;
                              umorz_akt WITH zodpis_sum,;
                              stawka WITH zstawka,;
                              wspdeg WITH zwspdeg,;
                              liniowo WITH zliniowo,;
                              degres WITH zdegres
                           FOR i := 1 TO 12
                               zmcn := StrTran( Str( i, 2 ), ' ', '0' )
                               IF zodpis_mie > zwart_akt - zodpis_sum
                                  REPLACE mc&zmcn WITH zwart_akt - zodpis_sum
                                  zodpis_rok := zodpis_rok + ( zwart_akt - zodpis_sum )
                                  zodpis_sum := zodpis_sum + ( zwart_akt - zodpis_sum )
                                  kon := .T.
                                  EXIT
                               ELSE
                                  REPLACE mc&zmcn WITH zodpis_mie
                                  zodpis_rok := zodpis_rok + zodpis_mie
                                  zodpis_sum := zodpis_sum + zodpis_mie
                               ENDIF
                           NEXT
                           REPLACE odpis_rok WITH zodpis_rok,;
                              odpis_sum WITH zodpis_sum
                           COMMIT
                           UNLOCK
                           IF kon
                              EXIT
                           ELSE
                              odr++
                              zwart_pocz := zwart_akt
                              zprzel := 1
                              zwart_akt := zwart_pocz * zprzel
                              zodpis_rok := 0
                              zumorz_akt := zodpis_sum * zprzel
                              zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
                              zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
                              zodpis_mie := iif( zSPOSOB = 'L', _round( zliniowo / 12, 2 ), iif( zSPOSOB = 'J', zwart_pocz, _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) ) )
                           ENDIF
                        ENDDO
                        COMMIT
                        UNLOCK
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
         SELECT kartst
         SET ORDER TO 2
         SEEK Val( zidp )
         SET ORDER TO 1
         SetColor( CoCu )
         RESTORE SCREEN FROM robs
      CASE ( kl == 90 .OR. kl == 122 ) .AND. Len( AllTrim( DToS( data_lik ) ) ) == 0
         SAVE SCREEN TO robs
         zidp := Str( rec_no, 5 )
         SELECT kartstmo
         *seek '+'+zidp
         KartSTMo()
         SELECT kartst
         RESTORE SCREEN FROM robs
      CASE kl == 79 .OR. kl == 111
         OL := 'O'
      CASE kl == 76 .OR. kl == 108
         OL := 'L'
      CASE kl == 13
         SAVE SCREEN TO robs
         IF mieslok='C'
            TabAmW()
         ELSE
            Umorz( mieslok )
         ENDIF
         SELECT 1
         RESTORE SCREEN FROM robs
      *################################### POMOC ##################################
      CASE kl == 28
           SAVE SCREEN TO scr_
           @ 1, 47 SAY '          '
           DECLARE p[ 20 ]
           *---------------------------------------
           p[  1 ] := '                                                       '
           p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']..............poprzednia/nast&_e.pna pozycja      '
           p[  3 ] := '   [Home/End].........pierwsza/ostatnia pozycja        '
           if mieslok = 'C'
              p[  4 ] := '   [Enter]............wydruk tabeli amortyzacji        '
           else
              p[  4 ] := '   [Enter]............wydruk listy umorze&_n. w miesi&_a.cu  '
           endif
           p[  5 ] := '   [M]................przeszacowanie &_s.rodka trwa&_l.ego   '
           p[  6 ] := '   [O]................informacja o dacie przyj&_e.cia     '
           p[  7 ] := '   [L]................informacja o dacie likwidacji    '
           p[  8 ] := '   [Z]................zmiana warto&_s.ci pocz&_a.tkowej      '
           p[  9 ] := '   [F]................filtrowanie danych               '
           p[ 10 ] := '   [C]................czyszczenie filtra               '
           p[ 11 ] := '   [Esc]..............wyj&_s.cie                          '
           p[ 12 ] := '                                                       '
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
           Pause( 0 )
           IF LastKey() # 27 .AND. LastKey() # 28
              KEYBOARD Chr( LastKey() )
           ENDIF
           RESTORE SCREEN FROM scr_
           _disp := .F.
      CASE kl == Asc( 'F' ) .OR. kl == Asc( 'f' )
         IF KartSt_Filtr()
            kartst->( dbSetFilter( bFiltr ) )
            kartst->( dbSeek( _stop ) )
            IF kartst->( &_top_bot )
               kartst->( dbClearFilter() )
               kartst->( dbSeek( _stop ) )
               komun( "Brak danych w zadanym zakresie" )
               cKolor := ColStd()
               @ 3, 75 SAY "     "
               SetColor( cKolor )
            ELSE
               cKolor := ColInf()
               @ 3, 75 SAY "FILTR"
               SetColor( cKolor )
            ENDIF
            _disp := .T.
         ELSE
            _disp := .F.
         ENDIF
      CASE kl == Asc( 'C' ) .OR. kl == Asc( 'c' )
         kartst->( dbClearFilter() )
         aPolaFiltru := KartSt_Filtr_Czysty()
         cKolor := ColStd()
         @ 3, 75 SAY "     "
         SetColor( cKolor )
         _disp := .T.
      ENDCASE
   ENDDO
   *set cent on
   Close_()

   RETURN NIL

*################################## FUNKCJE #################################
PROCEDURE say41est()

   wierszyk := Space( 32 )
   IF OL = 'O'
      wierszyk := DToC( DATA_ZAK ) + '³' + NREWID + '³ ' + KRST + ' '
   ELSE
      wierszyk := DToC( DATA_LIK ) + '³' + NREWID + '³ ' + KRST + ' '
   ENDIF

   RETURN wierszyk

*##############################################################################
PROCEDURE say41esst()

   CLEAR TYPEAHEAD
   SET COLOR TO +w
   @ 4, 44 CLEAR TO  4, 79
   @ 5, 41 CLEAR TO  5, 79
   @ 6, 43 CLEAR TO  6, 79
   @ 7, 41 CLEAR TO 21, 79
   zidp := Str( rec_no, 5 )
   SELECT amort
   seek '+' + zidp
   IF Found()
      ofrok := 0
      DO WHILE .NOT. Eof() .AND. del + ident == '+' + zidp
         IF Val( PARAM_ROK ) > Val( ROK ) + 1
            SKIP
         ELSE
            @ 4, 44 + ( ofrok * 10 ) SAY ROK
            @ 5, 41 + ( ofrok * 10 ) SAY wart_pocz PICTURE '@E 999999.99'
            @ 6, 43 + ( ofrok * 10 ) SAY przel     PICTURE '@E 999.999'
            @ 7, 41 + ( ofrok * 10 ) SAY wart_akt  PICTURE '@E 999999.99'
            @ 8, 41 + ( ofrok * 10 ) SAY umorz_akt PICTURE '@E 999999.99'
            FOR x := 1 TO 12
                MCS := StrTran( Str( x, 2 ), ' ', '0' )
                @ 8 + x, 41 + ( ofrok * 10 ) SAY MC&MCS PICTURE '@EZ 999999.99'
            NEXT
            @ 21, 41 + ( ofrok * 10 ) SAY odpis_rok PICTURE '@E 999999.99'
            ofrok++
            NRROK := Str( ofrok, 1 )
            ROK&NRROK := ' ' + ROK + ' '
            IF ofrok == 4
               EXIT
            ENDIF
            SKIP
         ENDIF
      ENDDO
   endif
   SELECT kartstmo
   SEEK '+' + zidp
   ilmod := 0
   @ 18, 1 SAY Space( 10 ) + '³' + Space( 10 ) + '³' + Space( 10 )
   @ 19, 1 SAY Space( 10 ) + '³' + Space( 10 ) + '³' + Space( 10 )
   @ 20, 1 SAY Space( 10 ) + '³' + Space( 10 ) + '³' + Space( 10 )
   *if found().and.ilmod<3.and.[+]+zidp==A->del+str(A->rec_no,5).and..not.eof()
   DO WHILE ilmod < 3 .AND. del + ident == '+' + zidp .AND. .NOT. Eof()
      @ 18 + ilmod, 1 SAY Transform( DATA_MOD, '@D' ) + '³' + Str( WART_MOD, 10, 2 ) + '³' + SubStr( OPIS_MOD, 1, 10 )
      ilmod++
      SKIP
   ENDDO
   *endif
   SELECT kartst
   @ 22,  7 SAY NAZWA
   @ 22, 53 SAY OPIS
   SET COLOR TO

   RETURN
*############################################################################
