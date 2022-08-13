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

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± ......   ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Obsluga podstawowych operacji na bazie ......                             ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

FUNCTION KartST()

   LOCAL cKolor
   PRIVATE _row_g, _col_l, _row_d, _col_p, _invers, _curs_l, _curs_p, _esc, _top, ;
      _bot, _stop, _sbot, _proc, _row, _proc_spe, _disp, _cls, kl, ins, nr_rec, ;
      wiersz, f10, rec, fou, _top_bot

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

   @ 1, 47 SAY '          '

   *################################# GRAFIKA ##################################
   @  3, 0 SAY '               K A R T O T E K A   &__S. R O D K &__O. W   T R W A &__L. Y C H              '
   @  4, 0 SAY '  DataPrzy   Nr Ewid            Nazwa &_s.rodka trwa&_l.ego            KST    StawAmor'
   @  5, 0 SAY 'ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄ¿'
   @  6, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @  7, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @  8, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @  9, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @ 10, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @ 11, 0 SAY '³          ³          ³                                        ³        ³      ³'
   @ 12, 0 SAY 'ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ´'
   @ 13, 0 SAY '³ Opis.............                                            Nr OT.          ³'
   @ 14, 0 SAY '³ Nr dowodu zakupu.            Wart.zak.               Wart.ulg.               ³'
   @ 15, 0 SAY '³ &__X.r&_o.d&_l.o zakupu....                                                            ³'
   @ 16, 0 SAY '³ W&_l.asno&_s.&_c...       Przeznaczenie..           Spos&_o.b..            Wsp.degr..    ³'
   @ 17, 0 SAY 'ÃÄInformacje do korekt VATÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
   @ 18, 0 SAY '³ VAT z rej.zak.naliczony.             odliczony.             Okres kor.   lat ³'
   @ 19, 0 SAY 'ÃÄInformacje o zbyciu/likwidacjiÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
   @ 20, 0 SAY '³ Spos&_o.b..                Data zbycia.....            VAT sprzeda&_z.y..          ³'
   @ 21, 0 SAY '³                         Data likwidacji.                     Nr LT.          ³'
   @ 22, 0 SAY 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'

   *############################### OTWARCIE BAZ ###############################
   ColInf()
   @ 17, 2 SAY 'Informacje do korekt VAT'
   @ 19, 2 SAY 'Informacje o zbyciu/likwidacji'
   ColStd()

   SELECT 3
   IF Dostep( 'KARTSTMO' )
      SetInd( 'KARTSTMO' )
   ELSE
      close_()
      RETURN
   ENDIF

   SELECT 2
   IF Dostep( 'AMORT' )
      SetInd( 'AMORT' )
   ELSE
      close_()
      RETURN
   ENDIF

   SELECT 1
   IF Dostep( 'KARTST' )
      SetInd( 'KARTST' )
   ELSE
      close_()
      RETURN
   ENDIF
   SEEK '+' + ident_fir

   *################################# OPERACJE #################################
   *----- parametry ------
   _row_g := 6
   _col_l := 1
   _row_d := 11
   _col_p := 78
   _invers := 'i'
   _curs_l := 0
   _curs_p := 0
   _esc := '27,-9,247,22,48,77,109,7,46,28,13,70,102,67,99'
   _top := 'firma#ident_fir'
   _bot := "eof().or.del#'+'.or.firma#ident_fir"
   _stop := '+' + ident_fir
   _sbot := '+' + ident_fir + 'þ'
   _proc := 'say31st()'
   _row := Int( ( _row_g + _row_d ) / 2 )
   _proc_spe := 'say31sst'
   _disp := .T.
   _cls := ''
   _top_bot := _top + '.or.' + _bot

   *----------------------
   kl := 0
   *set cent off
   do while kl#27
      ColSta()
      @ 1, 47 say '[F1]-pomoc'
      SET COLOR TO
      zSPOSOBLIK := ' '
      _row := wybor( _row )
      ColStd()
      kl := LastKey()
      DO CASE
      *########################### INSERT/MODYFIKACJA #############################
      CASE kl == 22 .OR. kl == 48 .OR. _row == -1 .OR. kl == 77 .OR. kl == 109
         @ 1, 47 SAY '          '
         ins := ( kl # 109 .AND. kl # 77 ) .OR. &_top_bot
         KTOROPER()
         IF ins
            RestScreen( _row_g, _col_l, _row_d + 1, _col_p, _cls )
            wiersz := _row_d
         ELSE
            wiersz := _row
         ENDIF
         BEGIN SEQUENCE
            IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 0 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 0
               zSPOSOBLIK := ' '
            ELSE
               IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 8 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 0
                  zSPOSOBLIK := 'L'
               ENDIF
               IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 8 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 8
                  zSPOSOBLIK := 'Z'
               ENDIF
            ENDIF
            IF .NOT. ins .AND. .NOT. Empty( DToS( DATA_LIK ) )
               komun( '&__S.rodek zlikwidowany/zbyty. Modyfikacja zabroniona' )
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððð ZMIENNE ðððððððððððððððððððððððððððððððð
            IF ins
               zNREWID := Space( 10 )
               zNAZWA := Space( 40 )
               zOPIS := Space( 60 )
               zKRST := Space( 8 )
               zDATA_ZAK := Date()
               zDOWOD_ZAK := Space( 10 )
               zZRODLO := Space( 60 )
               zWARTOSC := 0
               zWART_ULG := 0
               zNR_OT := Space( 10 )
               zNR_LT := Space( 10 )
               zDATA_LIK := CToD( '    .  .  ' )
               zWLASNOSC := 'W'
               zPRZEZNACZ := 'P'
               zSPOSOB := 'L'
               zSTAWKA := 0
               zWSPDEG := 1
               zVATZAKUP := 0
               zVATODLI := 0
               zVATkorokr := 1
               zDATA_SPRZ := CToD( '    .  .  ' )
               zVATSPRZ := ' '
            ELSE
               zNREWID := NREWID
               zNAZWA := NAZWA
               zOPIS := OPIS
               zKRST := KRST
               zDATA_ZAK := DATA_ZAK
               zDOWOD_ZAK := DOWOD_ZAK
               zZRODLO := ZRODLO
               zWARTOSC := WARTOSC
               zWART_ULG := WART_ULG
               zNR_OT := NR_OT
               zNR_LT := NR_LT
               zDATA_LIK := DATA_LIK
               zWLASNOSC := WLASNOSC
               zPRZEZNACZ := PRZEZNACZ
               zSPOSOB := SPOSOB
               zSTAWKA := STAWKA
               zWSPDEG := WSPDEG
               zVATZAKUP := VATZAKUP
               zVATODLI := VATODLI
               zVATkorokr := VATkorokr
               zDATA_SPRZ := DATA_SPRZ
               zVATSPRZ := VATSPRZ
            ENDIF
            *ðððððððððððððððððððððððððððððððð GET ðððððððððððððððððððððððððððððððððð
            @ wiersz,  1 GET zDATA_ZAK WHEN ins
            @ wiersz, 12 GET zNREWID PICTURE "!!!!!!!!!!"
            @ wiersz, 23 GET zNAZWA PICTURE repl( "!", 40 ) VALID v3_111st()
            @ wiersz, 64 GET zKRST PICTURE "!!!!!!!!"
            @ wiersz, 73 GET zSTAWKA PICTURE '999.99' WHEN ins VALID zSTAWKA >= 0.0
            @ 13, 19 GET zOPIS PICTURE '@S40 ' + repl( "!", 60 )
            @ 13, 69 GET zNR_OT PICTURE "!!!!!!!!!!"
            @ 14, 19 GET zDOWOD_ZAK PICTURE "!!!!!!!!!!"
            @ 14, 40 GET zWARTOSC PICTURE "  9999999.99" WHEN ins VALID zWARTOSC > 0
            @ 14, 64 GET zWART_ULG PICTURE "  9999999.99" WHEN ins VALID zWARTOSC >= zWART_ULG
            @ 15, 19 GET zZRODLO PICTURE repl( '!', 60 )
            @ 16, 12 GET zWLASNOSC PICTURE "!" WHEN w3_131st() VALID v3_131st()
            @ 16, 34 GET zPRZEZNACZ PICTURE "!" WHEN w3_141st() VALID v3_141st()
            @ 16, 53 GET zSPOSOB PICTURE "!" WHEN ins .AND. w3_151st() VALID v3_151st()
            @ 16, 75 GET zWSPDEG PICTURE "9.99" WHEN ins .AND. zSPOSOB = 'D' VALID zWSPDEG>0

            @ 18, 26 GET zVATZAKUP PICTURE "  9999999.99"
            @ 18, 49 GET zVATODLI PICTURE "  9999999.99" VALID zVATZAKUP >= zVATODLI
            @ 18, 72 GET zVATkorokr PICTURE "99" WHEN wVATkorokr() VALID vVATkorokr()

            @ 20, 10 GET zSPOSOBLIK PICTURE "!" WHEN .NOT. ins .AND. w3_161st() VALID v3_161st()
            @ 20, 42 GET zDATA_SPRZ WHEN .NOT. ins .AND. zSPOSOBLIK = 'Z' VALID Len( AllTrim( DToS( zDATA_SPRZ ) ) ) = 8
            @ 20, 69 GET zVATSPRZ PICTURE "!" WHEN .NOT. ins .AND. zSPOSOBLIK = 'Z' .AND. wVATSPRZ() VALID vVATSPRZ()

            @ 21, 42 GET zDATA_LIK WHEN .NOT. ins .AND. zSPOSOBLIK = 'L' VALID Len( AllTrim( DToS( zDATA_LIK ) ) ) = 8
            @ 21, 69 GET zNR_LT PICTURE "!!!!!!!!!!" WHEN .NOT. ins .AND. zSPOSOBLIK $ 'ZL'

            read_()
            IF LastKey() == 27
               BREAK
            ENDIF
            *ðððððððððððððððððððððððððððððððð REPL ððððððððððððððððððððððððððððððððð
            IF ins
               SET ORDER TO 2
               BLOKADA()
               GO bott
               IDPR := rec_no + 1
               SET ORDER TO 1
               app()
               repl_( 'FIRMA', IDENT_FIR )
               repl_( 'REC_NO', IDPR )
               kon := .F.

               if zstawka > 0.0
                  SELECT amort
                  zwart_pocz := zwartosc
                  zprzel := 1
                  zwart_akt := zwart_pocz * zprzel
                  zodpis_rok := 0
                  zodpis_sum := 0
                  zumorz_akt := zodpis_sum * zprzel
                  zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
                  zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
                  zodpis_mie := iif( zSPOSOB='L', _round( zliniowo / 12, 2 ), iif( zSPOSOB='J', zwartosc, _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) ) )
                  odm := Month( zdata_zak )
                  odr := Year( zdata_zak )
                  DO WHILE .T.
                     CURR := ColInf()
                     @ 24, 0
                     center( 24, 'Dopisuj&_e. rok ' + Str( odr, 4 ) )
                     SetColor( CURR )
                     app()
                     REPLACE firma WITH ident_fir, ;
                        ident WITH Str( idpr, 5 ), ;
                        rok WITH Str( odr, 4 ), ;
                        wart_pocz WITH zwart_pocz, ;
                        przel WITH zprzel, ;
                        wart_akt WITH zwart_akt, ;
                        umorz_akt WITH zumorz_akt, ;
                        stawka WITH zstawka, ;
                        wspdeg WITH zwspdeg, ;
                        liniowo WITH zliniowo, ;
                        degres WITH zdegres
                     FOR i := odm TO 12
                        zmcn := StrTran( Str( i, 2 ), ' ', '0' )
                        IF Month( zdata_zak ) = i .AND. Year( zdata_zak ) = odr .AND. zSPOSOB # 'J'
                           IF zwart_ulg = zwart_akt
                              REPLACE mc&zmcn WITH zwart_ulg
                              zodpis_rok := zodpis_rok + zwart_ulg
                              zodpis_sum := zodpis_sum + zwart_ulg
                              kon := .T.
                              EXIT
                           ELSE
                              REPLACE mc&zmcn WITH zwart_ulg
                              zodpis_rok := zodpis_rok + zwart_ulg
                              zodpis_sum := zodpis_sum + zwart_ulg
                           ENDIF
                        ELSE
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
                        ENDIF
                     NEXT
                     REPLACE odpis_rok WITH zodpis_rok, ;
                        odpis_sum WITH zodpis_sum
                     COMMIT
                     UNLOCK
                     IF kon
                        EXIT
                     ELSE
                        odm := 1
                        odr++
                        zwart_pocz := zwart_akt
                        zprzel := 1
                        zwart_akt := zwart_pocz * zprzel
                        zodpis_rok := 0
                        zumorz_akt := zodpis_sum * zprzel
                        zliniowo := _round( zwart_akt * ( zstawka / 100 ), 2 )
                        zdegres := _round( ( zwart_akt - zumorz_akt ) * ( ( zstawka * zwspdeg ) / 100 ), 2 )
                        zodpis_mie := iif( zSPOSOB = 'L', _round( zliniowo / 12, 2 ), iif( zSPOSOB='J', zwartosc, _round( iif( zliniowo >= zdegres, zliniowo / 12, zdegres / 12 ), 2 ) ) )
                     ENDIF
                  ENDDO
                  COMMIT
                  UNLOCK
               ENDIF
            ELSE
               IF zSPOSOBLIK='Z'
                  zDATA_LIK := zDATA_SPRZ
               ENDIF
               IF zstawka > 0.0
                  IDPR := rec_no
                  IF .NOT. Empty( DToS( zDATA_LIK ) )
                     SELECT AMORT
                     SEEK '+' + Str( idpr, 5 ) + Str( Year( zDATA_LIK ), 4 )
                     IF Found()
                        ODLIK := 0
                        ODROK := 0
                        BlokadaR()
                        IF Month( zDATA_LIK ) < 12
                           odm := Month( zDATA_LIK )
                           FOR i := odm + 1 TO 12
                               zmcn := StrTran( Str( i, 2 ), ' ', '0' )
                               *ODLIK=ODLIK+mc&zmcn
                               REPLACE MC&ZMCN WITH 0
                           NEXT
                            *codm=strtran(str(odm,2),' ','0')
                            *repl MC&codm with wart_akt-(odpis_sum-odlik)
                        ENDIF
                        FOR i := 1 TO 12
                            zmcn := StrTran( Str( i, 2 ), ' ', '0' )
                            ODrok := ODrok + mc&zmcn
                        NEXT
                        REPLACE odpis_rok WITH odrok, odpis_sum WITH umorz_akt + odrok
                        COMMIT
                        UNLOCK
                        SKIP
                        IF .NOT. Eof() .AND. del + ident = '+' + Str( idpr, 5 )
                           BLOKADA()
                           DELETE REST WHILE del + ident = '+' + Str( idpr, 5 )
                        ENDIF
                        COMMIT
                        UNLOCK
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
            @ 24, 0
            SELECT kartst
            BlokadaR()
            REPLACE NREWID WITH zNREWID, ;
               NAZWA WITH zNAZWA, ;
               OPIS WITH zOPIS, ;
               KRST WITH zKRST, ;
               DATA_ZAK WITH zDATA_ZAK, ;
               DATA_LIK WITH zDATA_LIK, ;
               DOWOD_ZAK WITH zDOWOD_ZAK, ;
               ZRODLO WITH zZRODLO, ;
               WARTOSC WITH zWARTOSC, ;
               WART_ULG WITH zWART_ULG, ;
               NR_OT WITH zNR_OT, ;
               NR_LT WITH zNR_LT, ;
               WLASNOSC WITH zWLASNOSC, ;
               PRZEZNACZ WITH zPRZEZNACZ, ;
               SPOSOB WITH zSPOSOB, ;
               STAWKA WITH zSTAWKA, ;
               WSPDEG WITH zWSPDEG, ;
               VATZAKUP WITH zVATZAKUP, ;
               VATODLI WITH zVATODLI, ;
               VATkorokr WITH zVATkorokr, ;
               DATA_SPRZ WITH zDATA_SPRZ, ;
               VATSPRZ WITH zVATSPRZ
            COMMIT
            UNLOCK
            commit_()
            *ððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
            _row := Int( ( _row_g + _row_d ) / 2 )
            IF .NOT. ins
               BREAK
            ENDIF
            *@ _row_d,_col_l say &_proc
            Scroll( _row_g, _col_l, _row_d, _col_p, 1 )
            @ _row_d, _col_l SAY '        ³          ³                                          ³        ³      '
         end
         _disp := ins .OR. LastKey() # 27
         kl := iif( LastKey() == 27 .AND. _row == -1, 27, kl )
         @ 23, 0
      *################################ KASOWANIE #################################
      CASE kl == 7 .OR. kl == 46
         RECS := rec_no
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                   þ' )
         ColSta()
         center( 23, 'K A S O W A N I E' )
         ColStd()
         _disp := tnesc( '*i', '   Czy skasowa&_c.? (T/N)   ' )
         IF _disp
            SELECT amort
            SEEK '+' + Str( RECS, 5 )
            DO WHILE del = '+' .AND. ident = Str( RECS, 5 )
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
            ENDDO
            SELECT kartstmo
            SEEK '+' + Str( RECS, 5 )
            DO WHILE del = '+' .AND. ident = Str( RECS, 5 )
               BlokadaR()
               del()
               COMMIT
               UNLOCK
               SKIP
            ENDDO
            SELECT KARTST
            BlokadaR()
            del()
            COMMIT
            UNLOCK
            SEEK '+' + ident_fir
         ENDIF
         *====================================
         SELECT kartst
         @ 23, 0
      *################################# SZUKANIE #################################
      CASE kl == 13
         BEGIN SEQUENCE
            SAVE SCREEN TO scrst
            Srodki()
            SELECT 1
            RESTORE SCREEN FROM scrst
         END
      *################################# SZUKANIE #################################
      CASE kl == -9 .OR. kl == 247
         @ 1, 47 SAY '          '
         ColStb()
         center( 23, 'þ                 þ' )
         ColSta()
         center( 23, 'S Z U K A N I E' )
         ColStd()
         f10 := Date()
         @ _row, 1 GET f10
         read_()
         _disp := .NOT. Empty( f10 ) .AND. LastKey() # 27
         IF _disp
            SEEK '+' + ident_fir + DToS( f10 )
            IF &_bot
               skip -1
            ENDIF
         _row := Int( ( _row_g + _row_d ) / 2 )
         ENDIF
         @ 23, 0
      *################################### POMOC ##################################
      case kl=28
         SAVE SCREEN TO scr_
         @ 1, 47 SAY '          '
         DECLARE p[ 20 ]
         *---------------------------------------
         p[  1 ] := '                                                        '
         p[  2 ] := '   [' + Chr( 24 ) + '/' + Chr( 25 ) + ']...................poprzednia/nast&_e.pna pozycja  '
         p[  3 ] := '   [PgUp/PgDn].............poprzednia/nast&_e.pna strona   '
         p[  4 ] := '   [Home/End]..............pierwsza/ostatnia pozycja    '
         p[  5 ] := '   [Ins]...................wpisywanie                   '
         p[  6 ] := '   [M].....................modyfikacja pozycji          '
         p[  7 ] := '   [F].....................filtrowanie danych           '
         p[  8 ] := '   [C].....................czyszczenie filtra           '
         p[  9 ] := '   [Del]...................kasowanie pozycji            '
         p[ 10 ] := '   [F10]...................szukanie                     '
         p[ 11 ] := '   [Esc]...................wyj&_s.cie                      '
         p[ 12 ] := '                                                        '
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
            SEEK _stop
            IF &_top_bot
               kartst->( dbClearFilter() )
               SEEK _stop
               komun( "Brak danych w zadanym zakresie" )
               cKolor := ColStd()
               @ 3, 72 SAY "       "
               SetColor( cKolor )
            ELSE
               cKolor := ColInf()
               @ 3, 72 SAY " FILTR "
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
         @ 3, 72 SAY "       "
         SetColor( cKolor )
         _disp := .T.
      ******************** ENDCASE
      ENDCASE
   ENDDO
   *set cent on
   close_()

   RETURN NIL

*################################## FUNKCJE #################################
PROCEDURE say31st()

   RETURN DToC( DATA_ZAK ) + '³' + NREWID + '³' + NAZWA + '³' + KRST + '³' + Str( STAWKA, 6, 2 )

*############################################################################
PROCEDURE say31sst()

   CLEAR TYPEAHEAD
   SET COLOR TO +w
   @ 13, 19 SAY SubStr( OPIS, 1, 40 )
   @ 13, 69 SAY NR_OT
   @ 14, 19 SAY DOWOD_ZAK
   @ 14, 40 SAY WARTOSC PICTURE "@E 9 999 999.99"
   @ 14, 64 SAY WART_ULG PICTURE "@E 9 999 999.99"
   @ 15, 19 SAY ZRODLO
   @ 16, 12 SAY WLASNOSC + iif( WLASNOSC = 'W', '&_l.asny', 'bcy  ' )
   @ 16, 34 SAY PRZEZNACZ + iif( PRZEZNACZ='P', 'rodukcyj.', 'ieproduk.' )
   @ 16, 53 SAY SPOSOB + iif( SPOSOB = 'L', 'iniowo    ', iif( SPOSOB = 'J', 'ednorazowo', 'egresywnie' ) )
   @ 16, 75 SAY WSPDEG PICTURE "9.99"
   @ 18, 26 SAY VATZAKUP PICTURE "@E 9 999 999.99"
   @ 18, 49 SAY VATODLI PICTURE "@E 9 999 999.99"
   @ 18, 72 SAY VATkorokr PICTURE '99'

   IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 0 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 0
      zSPOSOBLIK := ' '
   ELSE
      IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 8 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 0
         zSPOSOBLIK := 'L'
      ENDIF
      IF Len( AllTrim( DToS( DATA_LIK ) ) ) = 8 .AND. Len( AllTrim( DToS( DATA_SPRZ ) ) ) = 8
         zSPOSOBLIK := 'Z'
      ENDIF
   ENDIF

   @ 20, 10 SAY zSPOSOBLIK + iif( zSPOSOBLIK = ' ', '          ', iif( zSPOSOBLIK = 'Z', 'bycie     ', 'ikwidacja ' ) )
   @ 20, 42 SAY Space( 10 )
   @ 20, 69 SAY '   '
   @ 21, 42 SAY Space( 10 )
   IF zSPOSOBLIK = 'Z'
      @ 20, 42 SAY DATA_SPRZ
      @ 20, 69 SAY VATSPRZ + iif( VATSPRZ = 'Z', 'wo', iif( VATSPRZ = 'O', 'po', '  ' ) )
   ENDIF
   IF zSPOSOBLIK = 'L'
      @ 21, 42 SAY DATA_LIK
   ENDIF
   @ 21, 69 SAY NR_LT

   SET COLOR TO

   RETURN

***************************************************
FUNCTION v3_111st()

   IF Empty( zNAZWA )
      RETURN .F.
   ENDIF

   RETURN .T.

***************************************************
FUNCTION w3_131st()

   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: W - &_s.rodek w&_l.asny   lub   O - &_s.rodek obcy', 80, ' ' )
   ColStd()
   @ 16, 13 SAY iif( zWLASNOSC = 'W', '&_l.asny', 'bcy  ' )

   RETURN .T.

***************************************************
FUNCTION v3_131st()

   R := .F.
   IF zWLASNOSC $ 'WO'
      ColStd()
      @ 16, 13 SAY iif( zWLASNOSC = 'W', '&_l.asny', 'bcy  ' )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION w3_141st()

   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: P - &_s.rodek produkcyjny   lub   N - &_s.rodek nieprodukcyjny', 80, ' ' )
   ColStd()
   @ 16, 35 SAY iif( zPRZEZNACZ = 'P', 'rodukcyj.', 'ieproduk.' )

   RETURN .T.

***************************************************
FUNCTION v3_141st()

   R := .F.
   IF zPRZEZNACZ $ 'PN'
      ColStd()
      @ 16, 35 SAY iif( zPRZEZNACZ = 'P', 'rodukcyj.', 'ieproduk.' )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION w3_151st()

   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: L - liniowo lub D - degresywnie lub J - jednorazowo', 80, ' ' )
   ColStd()
   @ 16, 54 SAY iif( zSPOSOB = 'L', 'iniowo    ', iif( zSPOSOB = 'J', 'ednorazowo', 'egresywnie' ) )

   RETURN .T.

***************************************************
FUNCTION v3_151st()

   R := .F.
   IF zSPOSOB $ 'LDJ'
      ColStd()
      @ 16, 54 SAY iif( zSPOSOB = 'L', 'iniowo    ', iif( zSPOSOB = 'J', 'ednorazowo', 'egresywnie' ) )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION w3_161st()

   ColInf()
   @ 24,  0 SAY PadC( 'Pozostaw puste lub wpisz: Z - zbycie   lub   L - likwidacja', 80, ' ' )
   ColStd()
   @ 20, 11 SAY iif( zSPOSOBLIK = ' ', '          ', iif( zSPOSOBLIK = 'Z', 'bycie     ', 'ikwidacja ' ) )

   RETURN .T.

***************************************************
FUNCTION v3_161st()

   R := .F.
   IF zSPOSOBLIK $ 'ZL '
      ColStd()
      @ 20, 11 SAY iif( zSPOSOBLIK = ' ', '          ', iif( zSPOSOBLIK = 'Z', 'bycie     ', 'ikwidacja ' ) )
      @ 24,  0
      R := .T.
   ENDIF

   RETURN R

***************************************************
FUNCTION wVATkorokr()

   ColInf()
   @ 24, 0 SAY PadC( 'Wpisz: 1 - srodki o wart<15000PLN, 10 - dla nieruchomosci, 5 - dla innych ST', 80, ' ' )
   ColStd()
   RETURN .T.

***************************************************
FUNCTION vVATkorokr()

   R := .F.
   IF zVATkorokr = 1 .OR. zVATkorokr = 5 .OR. zVATkorokr = 10
      @ 24, 0
      R := .T.
   ELSE
      ColInf()
      @ 24, 0 SAY PadC( 'Wpisz: 1 - srodki o wart<15000PLN, 10 - dla nieruchomosci, 5 - dla innych ST', 80, ' ' )
      *@ 24,0 say padc('Wpisz: 10 - dla nieruchomosci   lub   5 - dla innych ST',80,' ')
      ColStd()
      R := .F.
   ENDIF

   RETURN R

***************************************************
FUNCTION wVATSPRZ()

   *if len(alltrim(dtos(zDATA_SPRZ)))=0
   *   ColInf()
   *   @ 24,0 say padc('Pozostaw puste jezeli nie sprzedawano srodka trwalego',80,' ')
   *   ColStd()
   *   @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
   *else
   ColInf()
   @ 24,  0 SAY PadC( 'Wpisz: O - opodatkowany lub Z - zwolniony', 80, ' ' )
   ColStd()
   @ 20, 70 SAY iif( zVATSPRZ = 'Z', 'wo', iif( zVATSPRZ = 'O', 'po', '  ' ) )
   *endif

   RETURN .T.

***************************************************
FUNCTION vVATSPRZ()

   R := .F.
   *if len(alltrim(dtos(zDATA_SPRZ)))=0
   *   if zVATSPRZ==' '
   *      ColStd()
   *      @ 20,70 say iif(zVATSPRZ='Z','wo',iif(zVATSPRZ='O','po','  '))
   *      @ 24,0
   *      R=.t.
   *   endif
   *else
   IF zVATSPRZ $ 'OZ'
      ColStd()
      @ 20, 70 SAY iif( zVATSPRZ = 'Z', 'wo', iif( zVATSPRZ = 'O', 'po', '  ' ) )
      @ 24,  0
      R := .T.
   ENDIF
   *endif

   RETURN R

*############################################################################

FUNCTION KartSt_Filtr()

   LOCAL dDataPrzyOd, dDataPrzyDo, cNrEwid, cNazwa, cKST, cRodzaj, dDataLikOd
   LOCAL dDataLikDo, cEkran, cKolor
   LOCAL bRodzajW := { | |
      LOCAL cKolor := ColInf()
      @ 24, 0 SAY PadC( "W - wszystkie pozycje,  A - tylko aktywne,  Z - tylko zlikwidowane/zbyte", 80 )
      SetColor( cKolor )
      RETURN .T.
   }
   LOCAL bRodzajV := { | |
      LOCAL lRes := cRodzaj $ 'AWZ'
      LOCAL cKolor
      IF lRes
         cKolor := SetColor( "W+" )
         DO CASE
         CASE cRodzaj == "W"
            @ 16, 20 SAY "szystkie   "
         CASE cRodzaj == "A"
            @ 16, 20 SAY "ktywne     "
         CASE cRodzaj == "Z"
            @ 16, 20 SAY "likwidowane"
         ENDCASE
         @ 24, 0
      ENDIF
      RETURN lRes
   }

   dDataPrzyOd := aPolaFiltru[ 'DataPrzyOd' ]
   dDataPrzyDo := aPolaFiltru[ 'DataPrzyDo' ]
   cNrEwid := aPolaFiltru[ 'NrEwid' ]
   cNazwa := aPolaFiltru[ 'Nazwa' ]
   cKST := aPolaFiltru[ 'KST' ]
   cRodzaj := aPolaFiltru[ 'Rodzaj' ]
   dDataLikOd := aPolaFiltru[ 'DataLikOd' ]
   dDataLikDo := aPolaFiltru[ 'DataLikDo' ]

   cEkran := SaveScreen()
   cKolor := ColStd()
   @ 10, 10 CLEAR TO 19, 69
   @ 10, 10 TO 19, 69
   @ 11, 12 SAY "Przyj©to data od" GET dDataPrzyOd PICTURE "@D"
   @ 12, 12 SAY "Przyj©to data do" GET dDataPrzyDo PICTURE "@D"
   @ 13, 12 SAY "Nr ewidencyjny" GET cNrEwid PICTURE Replicate( '!', 10 )
   @ 14, 12 SAY "Nazwa" GET cNazwa PICTURE Replicate( '!', 40 )
   @ 15, 12 SAY "KST" GET cKST PICTURE Replicate( '!', 10 )
   @ 16, 12 SAY "Rodzaj" GET cRodzaj PICTURE '!' WHEN Eval( bRodzajW ) VALID Eval( bRodzajV )
   @ 17, 12 SAY "Data likwidacji / zbycia od" GET dDataLikOd PICTURE "@D"
   @ 18, 12 SAY "Data likwidacji / zbycia do" GET dDataLikDo PICTURE "@D"
   Eval( bRodzajV )
   READ
   IF LastKey() == K_ESC
      RestScreen( , , , , cEkran )
      SetColor( cKolor )
      RETURN .F.
   ENDIF

   aPolaFiltru[ 'DataPrzyOd' ] := dDataPrzyOd
   aPolaFiltru[ 'DataPrzyDo' ] := dDataPrzyDo
   aPolaFiltru[ 'NrEwid' ] := cNrEwid
   aPolaFiltru[ 'Nazwa' ] := cNazwa
   aPolaFiltru[ 'KST' ] := cKST
   aPolaFiltru[ 'Rodzaj' ] := cRodzaj
   aPolaFiltru[ 'DataLikOd' ] := dDataLikOd
   aPolaFiltru[ 'DataLikDo' ] := dDataLikDo

   RestScreen( , , , , cEkran )
   SetColor( cKolor )

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION KartSt_Filtr_Czysty()

   LOCAL aCzystePolaFiltru := { ;
      'DataPrzyOd' => SToD( '' ), ;
      'DataPrzyDo' => SToD( '' ), ;
      'NrEwid' => Space( 10 ), ;
      'Nazwa' => Space( 40 ), ;
      'KST' => Space( 8 ), ;
      'Rodzaj' => 'W', ;
      'DataLikOd' => SToD( '' ), ;
      'DataLikDo' => SToD( '' ) }

   RETURN aCzystePolaFiltru

/*----------------------------------------------------------------------*/

