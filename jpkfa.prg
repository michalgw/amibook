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

FUNCTION JPK_FA_Dane()

   LOCAL aDane := hb_Hash()
   LOCAL nWorkArea := Select()

   LOCAL _top := 'faktury->firma#ident_fir.or.faktury->mc#miesiac'
   LOCAL _bot := "faktury->del#'+'.or.faktury->firma#ident_fir.or.faktury->mc#miesiac"
   LOCAL _stop := '+' + ident_fir + miesiac
   LOCAL _sbot := '+' + ident_fir + miesiac + 'þ'
   LOCAL _top_bot := _top + '.or.' + _bot

   LOCAL cIdPoz, cVAT, nIndeks, nWartosc
   LOCAL aPoz, aWiersz, aDokKor

   LOCAL cFirmaNazwa
   LOCAL cFirmaAdres
   LOCAL cFirmaNIP

   aDane[ 'DataWytworzeniaJPK' ] := datetime2strxml( hb_DateTime() )
   aDane[ 'DataOd' ] := hb_Date( Val( param_rok ), Val( miesiac ), 1 )
   aDane[ 'DataDo' ] := EoM( aDane[ 'DataOd' ] )

   dbUseArea( .T., , 'URZEDY', 'URZEDY', .T. )
   dbUseArea( .T., , 'FIRMA', 'FIRMA', .T. )
   firma->( dbGoto( Val( ident_fir ) ) )
   aDane[ 'NIP' ] := firma->nip
   IF firma->skarb > 0
      urzedy->( dbGoto( firma->skarb ) )
      aDane[ 'KodUrzedu' ] := urzedy->kodurzedu
   ENDIF
   aDane[ 'PelnaNazwa' ] := AllTrim( firma->nazwa )
   aDane[ 'Wojewodztwo' ] := AllTrim( firma->param_woj )
   aDane[ 'Powiat' ] := AllTrim( firma->param_pow )
   aDane[ 'Gmina' ] := AllTrim( firma->gmina )
   aDane[ 'Ulica' ] := AllTrim( firma->ulica )
   aDane[ 'NrDomu' ] := AllTrim( firma->nr_domu )
   aDane[ 'NrLokalu' ] := AllTrim( firma->nr_mieszk )
   aDane[ 'Miejscowosc' ] := AllTrim( firma->miejsc )
   aDane[ 'KodPocztowy' ] := AllTrim( firma->kod_p )
   aDane[ 'Poczta' ] := AllTrim( firma->poczta )
   aDane[ 'NazwaSkr' ] := AllTrim( firma->nazwa_skr )
   urzedy->( dbCloseArea() )
   firma->( dbCloseArea() )

   cFirmaNazwa := aDane[ 'PelnaNazwa' ]
   cFirmaNIP := aDane[ 'NIP' ]
   cFirmaAdres := aDane[ 'Ulica' ] + ' ' + aDane[ 'NrDomu' ] + ;
      iif( AllTrim( aDane[ 'NrLokalu' ] ) <> '', '/' + AllTrim( aDane[ 'NrLokalu' ] ), '' ) + ' ' + ;
      aDane[ 'KodPocztowy' ] + ' ' + aDane[ 'Miejscowosc' ]

   aDane[ 'rok' ] := Val( param_rok )
   aDane[ 'miesiac' ] := Val( miesiac )


   IF ! DostepPro( "FAKTURY", , .T., "FAKTURY", "FAKTURY" )
      Select( nWorkArea )
      RETURN NIL
   ENDIF
   faktury->( ordSetFocus( 2 ) )

   faktury->( dbSeek( _stop ) )
   IF &_top_bot
      faktury->( dbCloseArea() )
      Select( nWorkArea )
      RETURN NIL
   ENDIF

   IF ! DostepPro( "POZYCJE", , .T., "POZYCJE", "POZYCJE" )
      faktury->( dbCloseArea() )
      Select( nWorkArea )
      RETURN NIL
   ENDIF

   aDane[ 'Faktury' ] := {}
   aDane[ 'Pozycje' ] := {}

   aDane[ 'FakturaCtrl' ] := hb_Hash()
   aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] := 0
   aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] := 0

   aDane[ 'FakturaWierszCtrl' ] := hb_Hash()
   aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] := 0
   aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] := 0

   DO WHILE ! &_bot
      aPoz := hb_Hash()
      aPoz[ 'P_1' ] := hb_Date( Val( param_rok ), Val( faktury->mc ), Val( faktury->dzien ) )
      aPoz[ 'P_2A' ] := faktury->rach + '-' + StrTran( Str( faktury->numer, 5 ), ' ', '0' ) + '/' + param_rok
      aPoz[ 'P_3A' ] := AllTrim( faktury->nazwa )
      aPoz[ 'P_3B' ] := AllTrim( faktury->adres )
      aPoz[ 'P_3C' ] := cFirmaNazwa
      aPoz[ 'P_3D' ] := cFirmaAdres
      aPoz[ 'P_4A' ] := 'PL'
      aPoz[ 'P_4B' ] := cFirmaNIP
      aPoz[ 'P_5A' ] := AllTrim( faktury->kraj )
      aPoz[ 'P_5B' ] := AllTrim( faktury->nr_ident )
      IF ! Empty( faktury->datas )
         aPoz[ 'P_6' ] := faktury->datas
      ELSEIF ! Empty( faktury->dataz )
         aPoz[ 'P_6' ] := faktury->dataz
      ELSE
         aPoz[ 'P_6' ] := aPoz[ 'P_1' ]
      ENDIF
      aPoz[ 'P_13_1' ] := 0
      aPoz[ 'P_14_1' ] := 0
      aPoz[ 'P_13_2' ] := 0
      aPoz[ 'P_14_2' ] := 0
      aPoz[ 'P_13_3' ] := 0
      aPoz[ 'P_14_3' ] := 0
      aPoz[ 'P_13_4' ] := 0
      aPoz[ 'P_14_4' ] := 0
      aPoz[ 'P_13_5' ] := 0
      aPoz[ 'P_14_5' ] := 0
      aPoz[ 'P_13_6' ] := 0
      aPoz[ 'P_13_7' ] := 0
      aPoz[ 'P_15' ] := 0
      aPoz[ 'P_16' ] := .F.
      aPoz[ 'P_17' ] := .F.
      aPoz[ 'P_18' ] := .F.
      aPoz[ 'P_18A' ] := .F.
      aPoz[ 'P_19' ] := .F.
      aPoz[ 'P_20' ] := .F.
      aPoz[ 'P_21' ] := .F.
      aPoz[ 'P_22' ] := .F.
      aPoz[ 'P_23' ] := .F.
      aPoz[ 'P_106E_2' ] := .F.
      aPoz[ 'P_106E_3' ] := .F.
      aPoz[ 'RodzajFaktury' ] := iif( faktury->korekta == 'T', 'KOREKTA', 'VAT' )

      IF faktury->korekta == 'T'
         aDokKor := FakturyN_DokRefPobierz( faktury->dokkorid )
         aPoz[ 'NrFaKorygowanej' ] := aDokKor[ 'RACH' ] + '-' + StrTran( Str( aDokKor[ 'NUMER' ], 5 ), ' ', '0' ) + '/' + param_rok
         IF Len( AllTrim( faktury->przyczkor ) ) > 0
            aPoz[ 'PrzyczynaKorekty' ] := AllTrim( faktury->przyczkor )
         ENDIF
      ELSE
         aDokKor := NIL
      ENDIF

      aPoz[ 'Pozycje' ] := {}
      nIndeks := 1
      cIdPoz := Str( faktury->rec_no, 8 )
      pozycje->( dbSeek( "+" + cIdPoz ) )
      DO WHILE pozycje->del == "+" .AND. pozycje->ident == cIdPoz

         IF ( pozycje->ilosc == 0 .OR. pozycje->ilosc == 0 ) .AND. HB_ISHASH( aWiersz ) .AND. hb_HHasKey( aWiersz, 'P_2B' ) .AND. aWiersz[ 'P_2B' ] == aPoz[ 'P_2A' ]
            aWiersz[ 'P_7' ] := aWiersz[ 'P_7' ] + ' ' + AllTrim( pozycje->towar )
         ELSE
            aWiersz := hb_Hash()

            aWiersz[ 'P_2B' ] := aPoz[ 'P_2A' ]
            aWiersz[ 'P_7' ] := AllTrim( pozycje->towar )
            aWiersz[ 'P_8A' ] := AllTrim( pozycje->jm )
            aWiersz[ 'P_8B' ] := pozycje->ilosc
            aWiersz[ 'P_9A' ] := pozycje->cena
            nWartosc := pozycje->cena * pozycje->ilosc - iif( faktury->korekta == 'T', aDokKor[ 'pozycje' ][ nIndeks ][ 'CENA' ] * aDokKor[ 'pozycje' ][ nIndeks ][ 'ILOSC' ], 0 )
            aWiersz[ 'P_11' ] := nWartosc

            cVAT := AllTrim( pozycje->vat )

            DO CASE
            CASE cVAT == '23'
               aWiersz[ 'P_12' ] := '23'
               aPoz[ 'P_13_1' ] := aPoz[ 'P_13_1' ] + nWartosc
               aPoz[ 'P_14_1' ] := aPoz[ 'P_14_1' ] + nWartosc * 0.23
            CASE cVAT == '22'
               aWiersz[ 'P_12' ] := '22'
               aPoz[ 'P_13_1' ] := aPoz[ 'P_13_1' ] + nWartosc
               aPoz[ 'P_14_1' ] := aPoz[ 'P_14_1' ] + nWartosc * 0.22
            CASE cVAT == '8'
               aWiersz[ 'P_12' ] := '8'
               aPoz[ 'P_13_2' ] := aPoz[ 'P_13_2' ] + nWartosc
               aPoz[ 'P_14_2' ] := aPoz[ 'P_14_2' ] + nWartosc * 0.08
            CASE cVAT == '7'
               aWiersz[ 'P_12' ] := '7'
               aPoz[ 'P_13_2' ] := aPoz[ 'P_13_2' ] + nWartosc
               aPoz[ 'P_14_2' ] := aPoz[ 'P_14_2' ] + nWartosc * 0.07
            CASE cVAT == '5'
               aWiersz[ 'P_12' ] := '5'
               aPoz[ 'P_13_3' ] := aPoz[ 'P_13_3' ] + nWartosc
               aPoz[ 'P_14_3' ] := aPoz[ 'P_14_3' ] + nWartosc * 0.05
            CASE cVAT == '0'
               aWiersz[ 'P_12' ] := '0'
               aPoz[ 'P_13_4' ] := aPoz[ 'P_13_4' ] + nWartosc
               //aPoz[ 'P_14_4' ] := aPoz[ 'P_14_4' ] + pozycje->cena * pozycje->ilosc * 0.05
            CASE cVAT == 'NP'
               aWiersz[ 'P_12' ] := '0'
               aPoz[ 'P_13_4' ] := aPoz[ 'P_13_4' ] + nWartosc
               aPoz[ 'P_19' ] := .T.
            CASE cVAT == 'PN' .OR. cVAT == 'PU'
               aWiersz[ 'P_12' ] := '0'
               aPoz[ 'P_13_4' ] := aPoz[ 'P_13_4' ] + nWartosc
               aPoz[ 'P_18' ] := .T.
            CASE cVAT == 'ZW'
               aWiersz[ 'P_12' ] := 'zw'
               aPoz[ 'P_13_5' ] := aPoz[ 'P_13_5' ] + nWartosc
            ENDCASE

            aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] := aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] + 1
            aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] := aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] + aWiersz[ 'P_11' ]

            AAdd( aPoz[ 'Pozycje' ], aWiersz )
            AAdd( aDane[ 'Pozycje' ], aWiersz )
         ENDIF
         pozycje->( dbSkip() )
         nIndeks++
      ENDDO

      aPoz[ 'P_15' ] := aPoz[ 'P_13_1' ] + aPoz[ 'P_14_1' ] + aPoz[ 'P_13_2' ] + aPoz[ 'P_14_2' ] + ;
         aPoz[ 'P_13_3' ] + aPoz[ 'P_14_3' ] + aPoz[ 'P_13_4' ] + aPoz[ 'P_14_4' ] + ;
         aPoz[ 'P_13_5' ] + aPoz[ 'P_14_5' ] + aPoz[ 'P_13_6' ] + aPoz[ 'P_13_7' ]

      aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] := aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] + 1
      aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] := aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] + aPoz[ 'P_15' ]

      AAdd( aDane[ 'Faktury' ], aPoz )

      faktury->( dbSkip() )
   ENDDO


   pozycje->( dbCloseArea() )
   faktury->( dbCloseArea() )
   Select( nWorkArea )

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE JPK_FA_Rob()

   LOCAL aDane
   LOCAL nKorekta
   LOCAL cJPK := ""

   aDane := JPK_FA_Dane()

   IF Empty( aDane )
      Kom( 3, "*w", "b r a k   d a n y c h" )
      RETURN
   ENDIF

   IF ( nKorekta := edekCzyKorekta( 17, 2 ) ) == 0
      RETURN
   ENDIF

   aDane[ 'CelZlozenia' ] := iif( nKorekta == 2, '2', '1' )

   cJPK := jpk_fa4( aDane )

   edekZapiszXML( cJPK, normalizujNazwe( 'JPK_FA_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKFA-4', nKorekta == 2, Val(miesiac) )

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION JPK_FA_DekodujVat( cVAT )

   LOCAL cRes := ''

   cVAT := AllTrim( cVAT )

   DO CASE
   CASE cVAT == '23'
      cRes := '23'
   CASE cVAT == '22'
      cRes := '22'
   CASE cVAT == '8'
      cRes := '8'
   CASE cVAT == '7'
      cRes := '7'
   CASE cVAT == '5'
      cRes := '5'
   CASE cVAT == '3'
      cRes := '3'
   CASE cVAT == '0'
      cRes := '0'
   CASE cVAT == 'ZW' .OR. cVAT == 'NP' .OR. cVAT == 'PN' .OR. cVAT == 'PU'
      cRes := 'zw'
   ENDCASE

   RETURN cRes

/*----------------------------------------------------------------------*/

