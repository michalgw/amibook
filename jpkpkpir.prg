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

   LOCAL aDane := {=>}, aRow, cJPK

   IF JpkPkpirParam( @aDane )
      dbUseArea( .T., , 'URZEDY' )
      dbUseArea( .T., , 'FIRMA' )
      firma->( dbGoto( Val( ident_fir ) ) )
      aDane['NIP'] := firma->nip
      IF firma->skarb > 0
         urzedy->( dbGoto( firma->skarb ) )
         aDane['KodUrzedu'] := urzedy->kodurzedu
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
      urzedy->( dbCloseArea() )
      firma->( dbCloseArea() )

      IF Dostep( 'OPER' )
         SetInd( 'OPER' )
      ELSE
         SELE 1
         RETURN
      ENDIF
      oper->( dbSeek( '+' + ident_fir + Str( Month( aDane['DataOd'] ), 2 ) ) )
      aDane['pozycje'] := {}
      DO WHILE oper->del == '+' .AND. oper->firma == ident_fir ;
         .AND. hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) ) >= aDane[ 'DataOd' ] ;
         .AND. hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) ) <= aDane[ 'DataDo' ]

         aRow := hb_Hash()
         aRow['k1'] := oper->lp
         aRow['k2'] := hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) )
         aRow['k3'] := iif( Left( oper->numer, 1 ) == Chr( 1 ) .OR. Left( oper->numer, 1 ) == Chr( 254 ), SubStr( oper->numer, 2 ) + [ ], oper->numer )
         aRow['k4'] := oper->nazwa
         aRow['k5'] := oper->adres
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
         AAdd(aDane['pozycje'], aRow)

         oper->( dbSkip() )
      ENDDO
      oper->( dbCloseArea() )

      aDane['LiczbaWierszy'] := Len(aDane['pozycje'])
      aDane['SumaPrzychodow'] := 0
      AEval(aDane['pozycje'], { | aRec | aDane['SumaPrzychodow'] := aDane['SumaPrzychodow'] + aRec['k9']  } )

      cJPK := jpk_pkpir(aDane)

      edekZapiszXML( cJPK, normalizujNazwe( 'JPK_PKPIR_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) ;
         + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKKPR-2', ;
         aDane['CelZlozenia'] == '2', Month( aDane['DataOd'] ) )

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JpkPkpirParam( aDane )

   LOCAL nP_1 := 0, nP_2 := 0, nP_3 := 0, nP_4 := 0, dP_5A := CToD(''), nP_5B := 0, cP_5 := 'N'
   LOCAL cKorekta := 'D', dDataOd := hb_Date( Val( param_rok ), Val( miesiac ), 1 ), dDataDo := EoM( dDataOd )

   SAVE SCREEN TO cScr
   cKolor := ColStd()
   @  5, 0 CLEAR TO 19, 79
   @  6, 0, 18, 79 BOX B_SINGLE
   @  7, 1 SAY '                                               Dane za okres od'
   @  8, 1 SAY '                                                             do'
   @  9, 1 SAY '                                   Deklaracja czy Korekta (D/K)'
   @ 10, 1 SAY '            Warto˜† spisu z natury na pocz¥tek roku podatkowego'
   @ 11, 1 SAY '              Warto˜† spisu z natury na koniec roku podatkowego'
   @ 12, 1 SAY 'Koszty uzysk. przych.,wg obj.do podatk. ksi©gi przych. i rozch.'
   @ 13, 1 SAY '     Doch¢d osi¥gni©ty w roku podatkowym, wg obja˜nieä do PKPiR'
   @ 14, 1 SAY '          Spis z natury dokonany w ci¥gu roku podatkowego (T/N)'
   @ 15, 1 SAY '     Data spisu z natury sporz¥dzonego w ci¥gu roku podatkowego'
   @ 16, 1 SAY '  Warto˜† spisu z natury sporz¥dzonego w ci¥gu roku podatkowego'

   @  7, 65 GET dDataOd VALID Year( dDataOd ) == Val( param_rok )
   @  8, 65 GET dDataDo VALID Year( dDataDo ) == Val( param_rok )
   @  9, 65 GET cKorekta PICTURE '!' VALID cKorekta#'DK'
   @ 10, 65 GET nP_1 PICTURE '999 999 999.99'
   @ 11, 65 GET nP_2 PICTURE '999 999 999.99'
   @ 12, 65 GET nP_3 PICTURE '999 999 999.99'
   @ 13, 65 GET nP_4 PICTURE '999 999 999.99'
   @ 14, 65 GET cP_5 PICTURE '!' VALID cP_5#'TN'
   @ 15, 65 GET dP_5A WHEN cP_5 == 'T'
   @ 16, 65 GET nP_5B PICTURE '999 999 999.99' WHEN cP_5 == 'T'

   CLEAR TYPE
   read_()
   RESTORE SCREEN FROM cScr
   SetColor(cKolor)
   IF LastKey() == 27
      RETURN .F.
   ENDIF

   aDane['P_1'] := nP_1
   aDane['P_2'] := nP_2
   aDane['P_3'] := nP_3
   aDane['P_4'] := nP_4
   aDane['P_5'] := iif(cP_5 == 'T', .T., .F.)
   aDane['P_5A'] := dP_5A
   aDane['P_5B'] := nP_5B

   aDane['DataWytworzeniaJPK'] := datetime2strxml(hb_DateTime())
   aDane['DataOd'] := dDataOd
   aDane['DataDo'] := dDataDo
   aDane['CelZlozenia'] := iif(cKorekta == 'K', '2', '1')

   RETURN .T.

/*----------------------------------------------------------------------*/

