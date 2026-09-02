/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

#include "Box.ch"

PROCEDURE JpkPkpirRob()

   LOCAL aDane := {=>}, aRow, cJPK, cScr, cKolor

   SAVE SCREEN TO cScr
   cKolor := ColStd()

   IF JpkPkpirParam( @aDane )
      IF ! DostepPro( 'URZEDY' )
         RETURN
      ENDIF
      IF ! DostepPro( 'FIRMA' )
         urzedy->( dbCloseArea() )
         RETURN
      ENDIF
      IF ! DostepPro( 'SPOLKA', , , , 'SPOLKA' )
         firma->( dbCloseArea() )
         urzedy->( dbCloseArea() )
         RETURN
      ENDIF
      firma->( dbGoto( Val( ident_fir ) ) )
      aDane['NIP'] := firma->nip
      IF firma->skarb > 0
         urzedy->( dbGoto( firma->skarb ) )
         aDane['KodUrzedu'] := urzedy->kodurzedu
      ENDIF
      aDane[ 'Spolka' ] := firma->spolka
      IF ! firma->spolka
         IF spolka->( dbSeek( '+' + ident_fir + firma->nazwisko ) )
            aDane[ 'Nazwisko' ] := naz_imie_naz( AllTrim( spolka->naz_imie ) )
            aDane[ 'ImiePierwsze' ] := naz_imie_imie( AllTrim( spolka->naz_imie ) )
            aDane[ 'DataUrodzenia' ] := spolka->data_ur
         ELSE
            aDane[ 'Nazwisko' ] := ''
            aDane[ 'ImiePierwsze' ] := ''
            aDane[ 'DataUrodzenia' ] := ''
         ENDIF
      ENDIF
      aDane['PelnaNazwa'] := firma->nazwa
      aDane['Wojewodztwo'] := firma->param_woj
      aDane['Powiat'] := firma->param_pow
      aDane['Gmina'] := firma->gmina
      aDane['Ulica'] := firma->ulica
      aDane['NrDomu'] := firma->nr_domu
      aDane['NrLokalu'] := firma->nr_mieszk
      aDane['Miejscowosc'] := firma->miejsc
      aDane['KodPocztowy'] := firma->kod_p
      aDane['Poczta'] := firma->poczta
      aDane['NazwaSkr'] := firma->nazwa_skr

      aDane[ 'SumK7' ] := 0
      aDane[ 'SumK8' ] := 0
      aDane[ 'SumK9' ] := 0
      aDane[ 'SumK10' ] := 0
      aDane[ 'SumK11' ] := 0
      aDane[ 'SumK12' ] := 0
      aDane[ 'SumK13' ] := 0
      aDane[ 'SumK14' ] := 0
      aDane[ 'SumK15' ] := 0
      aDane[ 'SumK16' ] := 0

      urzedy->( dbCloseArea() )
      firma->( dbCloseArea() )
      spolka->( dbCloseArea() )

      IF Dostep( 'OPER' )
         SetInd( 'OPER' )
      ELSE
         SELE 1
         RETURN
      ENDIF
      oper->( dbSeek( '+' + ident_fir + Str( Month( aDane['DataOd'] ), 2 ) ) )
      aDane['pozycje'] := {}
      aDane['rem'] := {}
      DO WHILE oper->del == '+' .AND. oper->firma == ident_fir ;
         .AND. hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) ) >= aDane[ 'DataOd' ] ;
         .AND. hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) ) <= aDane[ 'DataDo' ]

         aRow := hb_Hash()
         aRow['k1'] := oper->lp
         aRow['k2'] := hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) )
         aRow['k3a'] := iif( Left( oper->numer, 1 ) == Chr( 1 ) .OR. Left( oper->numer, 1 ) == Chr( 254 ), SubStr( oper->numer, 2 ) + [ ], oper->numer )
         aRow['k3b'] := oper->nrksef
         aRow['k4a'] := oper->kraj
         aRow['k4b'] := oper->nr_ident
         aRow['k5a'] := oper->nazwa
         aRow['k5b'] := oper->adres
         aRow['k6'] := oper->tresc
         aRow['k7'] := oper->wyr_tow
         aRow['k8'] := oper->uslugi
         aRow['k9'] := oper->wyr_tow + oper->uslugi
         aRow['k10'] := oper->zakup
         aRow['k11'] := oper->uboczne
         aRow['k13'] := oper->wynagr_g
         aRow['k14'] := oper->wydatki
         aRow['k15'] := oper->wynagr_g + oper->wydatki
         aRow['k16'] := oper->pusta
         aRow['k17'] := oper->uwagi
         aRow['k16w'] := oper->k16wart
         aRow['k16o'] := AllTrim( oper->k16opis )
         IF Left( oper->numer, 1 ) == Chr( 1 ) .OR. Left( oper->numer, 1 ) == Chr( 254 )
            AAdd(aDane['rem'], aRow)
         ELSE
            AAdd(aDane['pozycje'], aRow)

            aDane[ 'SumK7' ] := aDane[ 'SumK7' ] + aRow[ 'k7' ]
            aDane[ 'SumK8' ] := aDane[ 'SumK8' ] + aRow[ 'k8' ]
            aDane[ 'SumK9' ] := aDane[ 'SumK9' ] + aRow[ 'k9' ]
            aDane[ 'SumK10' ] := aDane[ 'SumK10' ] + aRow[ 'k10' ]
            aDane[ 'SumK11' ] := aDane[ 'SumK11' ] + aRow[ 'k11' ]
            aDane[ 'SumK13' ] := aDane[ 'SumK13' ] + aRow[ 'k13' ]
            aDane[ 'SumK14' ] := aDane[ 'SumK14' ] + aRow[ 'k14' ]
            aDane[ 'SumK15' ] := aDane[ 'SumK15' ] + aRow[ 'k15' ]
            aDane[ 'SumK16' ] := aDane[ 'SumK16' ] + aRow[ 'k16w' ]
         ENDIF

         oper->( dbSkip() )
      ENDDO
      oper->( dbCloseArea() )

      aDane['LiczbaWierszy'] := Len(aDane['pozycje'])
      aDane['SumaPrzychodow'] := 0
      AEval(aDane['pozycje'], { | aRec | aDane['SumaPrzychodow'] := aDane['SumaPrzychodow'] + aRec['k9']  } )

      aDane[ 'P_1' ] := 0
      aDane[ 'P_2' ] := 0
      aDane[ 'P_3' ] := 0
      aDane[ 'P_4' ] := 0

      IF Len( aDane[ 'rem' ] ) > 0
         IF AllTrim( aDane[ 'rem' ][ 1 ][ 'k3a' ] ) == 'REM-P'
            aDane[ 'P_1' ] := aDane[ 'rem' ][ 1 ][ 'k10' ]
         ENDIF
         IF AllTrim( aDane[ 'rem' ][ Len( aDane[ 'rem' ] ) ][ 'k3a' ] ) == 'REM-K'
            aDane[ 'P_2' ] := aDane[ 'rem' ][ Len( aDane[ 'rem' ] ) ][ 'k10' ]
         ENDIF
      ENDIF

      aDane[ 'P_3' ] := aDane[ 'P_1' ] - aDane[ 'P_2' ] + aDane[ 'SumK10' ] + aDane[ 'SumK11' ] + aDane[ 'SumK13' ] + aDane[ 'SumK14' ]
      aDane[ 'P_4' ] := aDane[ 'SumK7' ] + aDane[ 'SumK8' ] - aDane[ 'P_3' ]

      IF JpkPkpirParam2( @aDane )

         IF aDane['WersjaJPK'] == 2
            cJPK := jpk_pkpir(aDane)
         ELSE
            cJPK := jpk_pkpir_w3( aDane )
         ENDIF

         edekZapiszXML( cJPK, normalizujNazwe( 'JPK_PKPIR_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) ;
            + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKKPR-' + AllTrim( Str( aDane[ 'WersjaJPK' ] ) ), ;
            aDane['CelZlozenia'] == '2', Month( aDane['DataOd'] ) )

      ENDIF

   ENDIF

   RESTORE SCREEN FROM cScr
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JpkPkpirParam( aDane )

   LOCAL dDataOd := hb_Date( Val( param_rok ), 1, 1 )
   LOCAL dDataDo := hb_Date( Val( param_rok ), 12, 31 )

   @  5, 0 CLEAR TO 19, 79
   @  6, 0, 18, 79 BOX B_SINGLE
   @  7, 1 SAY '                                               Dane za okres od'
   @  8, 1 SAY '                                                             do'

   @  7, 65 GET dDataOd VALID Year( dDataOd ) == Val( param_rok )
   @  8, 65 GET dDataDo VALID Year( dDataDo ) == Val( param_rok )

   CLEAR TYPE
   read_()

   IF LastKey() == 27
      RETURN .F.
   ENDIF

   aDane['DataOd'] := dDataOd
   aDane['DataDo'] := dDataDo

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION JpkPkpirParam2( aDane )

   LOCAL nP_1 := aDane[ 'P_1' ], nP_2 := aDane[ 'P_2' ], nP_3 := aDane[ 'P_3' ]
   LOCAL nP_4 := aDane[ 'P_4' ], cP_5 := 'N', nWer := 3, cKorekta := 'D'

   @  9, 1 SAY '                      Deklaracja / Korekta / Na ¾¥danie (D/K/Z)'
   @ 10, 1 SAY '            Warto˜† spisu z natury na pocz¥tek roku podatkowego'
   @ 11, 1 SAY '              Warto˜† spisu z natury na koniec roku podatkowego'
   @ 12, 1 SAY 'Koszty uzysk. przych.,wg obj.do podatk. ksi©gi przych. i rozch.'
   @ 13, 1 SAY '     Doch¢d osi¥gni©ty w roku podatkowym, wg obja˜nieä do PKPiR'
   @ 14, 1 SAY '   Doˆ¥cz spis z natury dokonany w ci¥gu roku podatkowego (T/N)'
   @ 15, 1 SAY '                                         Wersja pliku JPK (2/3)'

   @  9, 65 GET cKorekta PICTURE '!' VALID cKorekta#'DKZ'
   @ 10, 65 GET nP_1 PICTURE '999 999 999.99'
   @ 11, 65 GET nP_2 PICTURE '999 999 999.99'
   @ 12, 65 GET nP_3 PICTURE '999 999 999.99'
   @ 13, 65 GET nP_4 PICTURE '999 999 999.99'
   @ 14, 65 GET cP_5 PICTURE '!' VALID cP_5#'TN'
   @ 15, 65 GET nWer PICTURE '9' RANGE 2, 3

   CLEAR TYPE
   read_()

   IF LastKey() == 27
      RETURN .F.
   ENDIF

   aDane['P_1'] := nP_1
   aDane['P_2'] := nP_2
   aDane['P_3'] := nP_3
   aDane['P_4'] := nP_4
   aDane['P_5'] := iif(cP_5 == 'T', .T., .F.)
   aDane['WersjaJPK'] := nWer

   aDane['DataWytworzeniaJPK'] := datetime2strxml(hb_DateTime())
   aDane['CelZlozenia'] := iif( cKorekta == 'K', '2', iif( cKorekta == 'Z', '0', '1' ) )

   RETURN .T.

/*----------------------------------------------------------------------*/

