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

#include "box.ch"

FUNCTION IFT1_Dane( dDataOd, dDataDo )
   LOCAL aRes := hb_Hash( 'OK', .F. )
   LOCAL nOstatniWorkArea := Select()

   IF Select( 'FIRMA' ) == 0
      IF ! DostepPro( 'FIRMA' )
         RETURN NIL
      ENDIF
   ENDIF

   firma->( dbGoto( Val( ident_fir ) ) )

   aRes[ 'FirmaSpolka' ] := firma->spolka
   aRes[ 'FirmaNIP' ] := AllTrim( firma->nip )
   IF firma->spolka
      aRes[ 'FirmaNazwa' ] := AllTrim( firma->nazwa )
      aRes[ 'FirmaREGON' ] := SubStr( firma->nr_regon, 3, 9 )

      aRes[ 'FirmaWojewodztwo' ] := AllTrim( firma->param_woj )
      aRes[ 'FirmaPowiat' ] := AllTrim( firma->param_pow )
      aRes[ 'FirmaGmina' ] := AllTrim( firma->gmina )
      aRes[ 'FirmaUlica' ] := AllTrim( firma->ulica )
      aRes[ 'FirmaNrDomu' ] := AllTrim( firma->nr_domu )
      aRes[ 'FirmaNrLokalu' ] := AllTrim( firma->nr_mieszk )
      aRes[ 'FirmaMiejscowosc' ] := AllTrim( firma->miejsc )
      aRes[ 'FirmaKodPocztowy' ] := AllTrim( firma->kod_p )
      aRes[ 'FirmaPoczta' ] := AllTrim( firma->poczta )

   ELSE
      IF Select( 'SPOLKA' ) == 0
         IF ! DostepPro( 'SPOLKA', , , , 'SPOLKA' )
            firma->( dbCloseArea() )
            RETURN NIL
         ENDIF
      ENDIF
      spolka->( dbSeek( '+' + ident_fir ) )
      IF spolka->( Found() )
         aRes[ 'FirmaNazwisko' ] := naz_imie_naz( spolka->naz_imie )
         aRes[ 'FirmaImie' ] := naz_imie_imie( spolka->naz_imie )
         aRes[ 'FirmaData' ] := spolka->data_ur

         aRes[ 'FirmaWojewodztwo' ] := AllTrim( spolka->param_woj )
         aRes[ 'FirmaPowiat' ] := AllTrim( spolka->param_pow )
         aRes[ 'FirmaGmina' ] := AllTrim( spolka->gmina )
         aRes[ 'FirmaUlica' ] := AllTrim( spolka->ulica )
         aRes[ 'FirmaNrDomu' ] := AllTrim( spolka->nr_domu )
         aRes[ 'FirmaNrLokalu' ] := AllTrim( spolka->nr_mieszk )
         aRes[ 'FirmaMiejscowosc' ] := AllTrim( spolka->miejsc_zam )
         aRes[ 'FirmaKodPocztowy' ] := AllTrim( spolka->kod_poczt )
         aRes[ 'FirmaPoczta' ] := AllTrim( spolka->poczta )

      ELSE
         komun('Prosz© wprowadzi† dane wˆa˜ciciela firmy')
         spolka->( dbCloseArea() )
         firma->( dbCloseArea() )
         RETURN NIL
      ENDIF
      spolka->( dbCloseArea() )
   ENDIF

   aRes[ 'P_72' ] := 0.0
   aRes[ 'P_73' ] := 0
   aRes[ 'P_74' ] := 0.0
   umowy->( dbCreateIndex( raptemp, 'del+firma+ident+dtos(data_wyp)', { || del+firma+ident+dtos(data_wyp) } ) )
   umowy->( dbSeek( '+' + ident_fir + Str( prac->rec_no, 5 ) + SubStr( DToS( dDataOd ), 1, 6 ) ) )
   DO WHILE .NOT. umowy->( Eof() ) .AND. umowy->del == '+' .AND. umowy->firma == ident_fir .AND. ;
      umowy->ident == Str( prac->rec_no, 5 ) .AND. ;
      ( SubStr( DToS( umowy->data_wyp ),1 ,6 ) >= SubStr( DToS( dDataOd ), 1, 6 ) .AND. ;
      SubStr( DToS( umowy->data_wyp ), 1, 6 ) <= SubStr( DToS( dDataDo), 1, 6 ) )

      //IF umowy->tytul <> '8 '
         aRes[ 'P_72' ] := aRes[ 'P_72' ] + umowy->brut_razem
         aRes[ 'P_73' ] := umowy->staw_podat
         aRes[ 'P_74' ] := aRes[ 'P_74' ] + umowy->podatek
      //ENDIF

      umowy->( dbSkip() )
   ENDDO
   firma->( dbCloseArea() )

   aRes[ 'OsobaImiePierwsze' ]     := AllTrim( prac->imie1 )
   aRes[ 'OsobaNazwisko' ]         := AllTrim( prac->nazwisko )
   aRes[ 'OsobaDataUrodzenia' ]    := prac->data_ur
   aRes[ 'OsobaMiejsceUrodzenia' ] := AllTrim( prac->miejsc_ur )
   aRes[ 'OsobaImieOjca' ]         := AllTrim( prac->imie_o )
   aRes[ 'OsobaImieMatki' ]        := AllTrim( prac->imie_m )
   aRes[ 'OsobaNrId' ]             := AllTrim( prac->zagrnrid )
   aRes[ 'OsobaRodzajNrId' ]       := AllTrim( prac->dokidroz )
   aRes[ 'OsobaKraj' ]             := AllTrim( prac->dokidkraj )
   aRes[ 'OsobaKodPocztowy' ]      := AllTrim( prac->kod_poczt )
   aRes[ 'OsobaMiejscowosc' ]      := AllTrim( prac->miejsc_zam )
   aRes[ 'OsobaUlica' ]            := AllTrim( prac->ulica )
   aRes[ 'OsobaNrDomu' ]           := AllTrim( prac->nr_domu )
   aRes[ 'OsobaNrLokalu' ]         := AllTrim( prac->nr_mieszk )

   IF prac->skarb > 0
      urzedy->( dbGoto( prac->skarb ) )
      aRes[ 'KodUrzedu' ] := AllTrim( urzedy->kodurzedu )
   ENDIF

   IF File( raptemp + '.cdx' )
      FErase( raptemp + '.cdx' )
   ENDIF

   aRes[ 'OK' ] := .T.
   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION IFT1_Pobierz()
   LOCAL aRes := hb_Hash( 'OK', .F. )
   LOCAL cEkranTmp
   LOCAL cKolorTmp
   LOCAL cRoczny := 'T'
   LOCAL cKorDek := 'D'

   aRes[ 'DataOd' ] := CToD( param_rok + '.01.01' )
   aRes[ 'DataDo' ] := CToD( param_rok + '.12.31' )
   aRes[ 'Roczny' ] := .T.
   aRes[ 'DataZlozenia' ] := Date()
   aRes[ 'DataPrzekazania' ] := Date()

   SAVE SCREEN TO cEkranTmp
   cKolorTmp := ColStd()
   @ 5, 4 CLEAR TO 12, 60
   @ 5, 4, 12, 60 BOX B_SINGLE
   @ 6, 6 SAY 'Zˆo¾enie informacji czy korekta (D/K)'
   @ 7, 6 SAY 'Roczny (IFT-1R)'
   @ 8, 6 SAY 'Data od'
   @ 9, 6 SAY 'Data do'
   @ 10, 6 SAY 'Data przekazania'
   @ 11, 6 SAY 'Data zˆo¾enia'

   @ 6, 45 GET cKorDek PICTURE '!' VALID cKorDek$'DK'
   @ 7, 22 GET cRoczny PICTURE '!' VALID cRoczny$'TN'
   @ 8, 14 GET aRes[ 'DataOd' ] PICTURE '@D'
   @ 9, 14 GET aRes[ 'DataDo' ] PICTURE '@D'
   @ 10, 23 GET aRes[ 'DataPrzekazania' ] PICTURE '@D'
   @ 11, 20 GET aRes[ 'DataZlozenia' ] PICTURE '@D' WHEN cRoczny <> 'T'

   read_()

   IF LastKey() <> 13
      RETURN aRes
   ENDIF

   SetColor( cKolorTmp )
   RESTORE SCREEN from cEkranTmp

   aRes[ 'Roczny' ] := ( cRoczny == 'T' )
   aRes[ 'OK' ] := .T.
   aRes[ 'Korekta' ] := ( cKorDek == 'K' )

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION IFT1_Rob( lEDeklaracja )
   LOCAL aDane := hb_Hash()
   LOCAL nOstatniWorkArea := Select()
   LOCAL cXML := ''
   LOCAL cNazwaPlikuXML := ''

   hb_default( @lEDeklaracja, .F. )
   aDane[ 'Parametry' ] := IFT1_Pobierz()
   IF HB_ISHASH( aDane[ 'Parametry' ] ) .AND. aDane[ 'Parametry' ][ 'OK' ]
      aDane[ 'Dane' ] := IFT1_Dane( aDane[ 'Parametry' ][ 'DataOd' ], aDane[ 'Parametry' ][ 'DataDo' ] )
      Select( nOstatniWorkArea )
      IF HB_ISHASH( aDane[ 'Dane' ] ) .AND. aDane[ 'Dane' ][ 'OK' ]
         IF lEDeklaracja
            aDane[ 'ORDZU' ] := .F.
            IF aDane[ 'Parametry' ][ 'Korekta' ]
               aDane[ 'ORDZU' ] := edekOrdZuTrescPobierz( iif( aDane[ 'Parametry' ][ 'Roczny' ], 'IFT-1R', 'IFT-1' ), Val( ident_fir ), prac->( RecNo() ) )
            ENDIF
            cXML := edek_ift1_13( aDane )
            cNazwaPlikuXML := iif( aDane[ 'Parametry' ][ 'Roczny' ], 'IFT_1R_13_', 'IFT_1_13_' ) ;
               + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' ;
               + AllTrim( Str( Year( aDane[ 'Parametry' ][ 'DataOd' ] ) ) ) + '_' ;
               + AllTrim( aDane[ 'Dane' ][ 'OsobaNazwisko' ] )
            edekZapiszXml(cXML, cNazwaPlikuXML, wys_edeklaracja, ;
               iif( aDane[ 'Parametry' ][ 'Roczny' ], 'IFT1R-13', 'IFT1-13' ), ;
               aDane[ 'Parametry' ][ 'Korekta' ], 0, prac->( RecNo() ) )
         ELSE
            DeklarDrukuj( 'IFT1-13', aDane )
         ENDIF
      ENDIF
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/
