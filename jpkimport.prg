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

#include "hbxml.ch"
#include "inkey.ch"

FUNCTION JPKImp_NrDokumentu( cNrDok )

   LOCAL lDodaj := .F.

   DO CASE
   CASE AllTrim( cNrDok ) == 'REM-P'
      lDodaj := .T.
   CASE AllTrim( cNrDok ) == 'REM-K'
      lDodaj := .T.
   CASE AllTrim( cNrDok ) == 'RS-7'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 3 ) == 'RZ-' .OR. Left( LTrim( cNrDok ), 3 ) == 'RS-'
      lDodaj := .T.
   CASE AllTrim( cNrDok ) == 'RS-8'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 2 ) == 'S-'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 2 ) == 'F-'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 2 ) == 'R-'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 3 ) == 'KF-'
      lDodaj := .T.
   CASE Left( LTrim( cNrDok ), 3 ) == 'KR-'
      lDodaj := .T.
   CASE SubStr( cNrDok, 1, 1 ) == '#'
      lDodaj := .T.
   ENDCASE

   RETURN iif( lDodaj, "#" + cNrDok, cNrDok )

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_WczytajNagl( oDoc )

   LOCAL aRes := hb_Hash()
   LOCAL oNode, oVal, oIter

   oNode := oDoc:FindFirstRegex( '(([\w]*:)Naglowek|(^Naglowek))' )
   IF ! Empty( oNode )
      oIter := TXMLIteratorRegex():New( oNode )
      oVal := oIter:Find( '(([\w]*:)KodFormularza|(^KodFormularza))' )
      IF ! Empty( oVal )
         aRes[ 'KodFormularza' ] := oVal:cData
         aRes[ 'KodSystemowy' ] := oVal:GetAttribute( 'kodSystemowy' )
         IF aRes[ 'KodSystemowy' ] == NIL
            aRes[ 'KodSystemowy' ] := aRes[ 'KodFormularza' ]
         ENDIF
         IF aRes[ 'KodFormularza' ] == 'JPK_VAT' .AND. SubStr( aRes[ 'KodSystemowy' ], 1, 6 ) == 'JPK_V7'
            aRes[ 'KodFormularza' ] := SubStr( aRes[ 'KodSystemowy' ], 1, 7 )
         ENDIF
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)WariantFormularza|(^WariantFormularza))' )
      IF ! Empty( oVal )
         aRes[ 'WariantFormularza' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)DataWytworzeniaJPK|(^DataWytworzeniaJPK))' )
      IF ! Empty( oVal )
         aRes[ 'DataWytworzeniaJPK' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)CelZlozenia|(^CelZlozenia))' )
      IF ! Empty( oVal )
         aRes[ 'CelZlozenia' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)DataOd|(^DataOd))' )
      IF ! Empty( oVal )
         aRes[ 'DataOd' ] := sxml2date( oVal:cData )
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)DataDo|(^DataDo))' )
      IF ! Empty( oVal )
         aRes[ 'DataDo' ] := sxml2date( oVal:cData )
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)DomyslnyKodWaluty|(^DomyslnyKodWaluty))' )
      IF ! Empty( oVal )
         aRes[ 'DomyslnyKodWaluty' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)KodUrzedu|(^KodUrzedu))' )
      IF ! Empty( oVal )
         aRes[ 'KodUrzedu' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)Rok|(^Rok))' )
      IF ! Empty( oVal )
         aRes[ 'Rok' ] := oVal:cData
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)Miesiac|(^Miesiac))' )
      IF ! Empty( oVal )
         aRes[ 'Miesiac' ] := oVal:cData
      ENDIF
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_WczytajPodm( oDoc )

   LOCAL aRes := hb_Hash()
   LOCAL oNode, oVal, oIter

   oNode := oDoc:FindFirstRegex( '(([\w]*:)Podmiot1|(^Podmiot1))' )
   IF ! Empty( oNode )
      oIter := TXMLIteratorRegex():New( oNode )
      oVal := oIter:Find( '(([\w]*:)NIP|(^NIP))' )
      IF ! Empty( oVal )
         aRes[ 'NIP' ] := sxml2str( oVal:cData )
      ENDIF
      oIter:Rewind()
      oVal := oIter:Find( '(([\w]*:)PelnaNazwa|(^PelnaNazwa))' )
      IF ! Empty( oVal )
         aRes[ 'PelnaNazwa' ] := sxml2str( oVal:cData )
      ELSE
         oIter:Rewind()
         oVal := oIter:Find( '(([\w]*:)ImiePierwsze|(^ImiePierwsze))' )
         IF ! Empty( oVal )
            aRes[ 'PelnaNazwa' ] := sxml2str( oVal:cData )
         ELSE
            aRes[ 'PelnaNazwa' ] := ''
         ENDIF
         oIter:Rewind()
         oVal := oIter:Find( '(([\w]*:)Nazwisko|(^Nazwisko))' )
         IF ! Empty( oVal )
            aRes[ 'PelnaNazwa' ] := aRes[ 'PelnaNazwa' ] + ' ' + sxml2str( oVal:cData )
         ENDIF
      ENDIF
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_Weryf( aDane, cNip, nRok, nMiesiac, nCelImportu )

   LOCAL aRes := hb_Hash( 'OK', .F. )
   LOCAL aTmp := {}, sTmp := ""

   hb_default( @nCelImportu, 1 )

   IF ! hb_HHasKey( aDane[ 'Naglowek' ], 'KodFormularza' )
      aRes[ 'Komunikat' ] := 'Brak kodu formularza (KodFormularza)'
      RETURN aRes
   ENDIF

   DO CASE
   CASE nCelImportu == 1
      aTmp := { "JPK_VAT", "JPK_FA", "JPK_V7M", "JPK_V7K" }
      sTmp := "JPK_VAT, JPK_FA, JPK_V7M, JPK_V7K"
   CASE nCelImportu == 2
      aTmp := { "JPK_VAT", "JPK_FA", "JPK_V7M", "JPK_V7K" }
      sTmp := "JPK_VAT, JPK_FA, JPK_V7M, JPK_V7K"
   CASE nCelImportu == 4
      aTmp := { "JPK_PKPIR" }
      sTmp := "JPK_PKPIR"
   OTHERWISE
      aRes[ 'Komunikat' ] := "Nieobsˆugiwany cel importu: " + Str( nCelImportu )
      RETURN aRes
   ENDCASE
   IF AScan( aTmp, aDane[ 'Naglowek' ][ 'KodFormularza' ] ) == 0
      aRes[ 'Komunikat' ] := 'Bˆ©dny kod formularza (odczytany: ' + aDane[ 'Naglowek' ][ 'KodFormularza' ] + ;
         ' wymagane: ' + sTmp
      RETURN aRes
   ENDIF

/*
   IF ! hb_HHasKey( aDane[ 'Naglowek' ], 'WariantFormularza' )
      aRes[ 'Komunikat' ] := 'Brak wariantu formularza (WariantFormularza)'
      RETURN aRes
   ENDIF
   IF ! Empty( cKodFormularza ) .AND. aDane[ 'Naglowek' ][ 'WariantFormularza' ] != cWersja
      aRes[ 'Komunikat' ] := 'Bˆ©dny wariant formularza (odczytany: ' + aDane[ 'Naglowek' ][ 'WariantFormularza' ] + ;
         ' wymagany: ' + cWersja
      RETURN aRes
   ENDIF
*/

   IF AScan( { "JPK_VAT", "JPK_FA", "JPK_PKPIR" }, aDane[ 'Naglowek' ][ 'KodFormularza' ] ) > 0
      IF ! hb_HHasKey( aDane[ 'Naglowek' ], 'DataOd' )
         aRes[ 'Komunikat' ] := 'Brak daty pocz¥tkowej okresu (DataOd)'
         RETURN aRes
      ENDIF
      IF ! Empty( nRok ) .AND. ! Empty( nMiesiac ) .AND. ( Month( aDane[ 'Naglowek' ][ 'DataOd' ] ) != nMiesiac .OR. Year( aDane[ 'Naglowek' ][ 'DataOd' ] ) != nRok )
         aRes[ 'Komunikat' ] := 'Bˆ©dny pocz¥tek okresu (odczytany rok-miesiac: ' + AllTrim( Str( Year( aDane[ 'Naglowek' ][ 'DataOd' ] ) ) ) + '-' + AllTrim( Str( Month( aDane[ 'Naglowek' ][ 'DataOd' ] ) ) ) + ;
            ' wymagany: ' + AllTrim( Str( nRok ) ) + '-' + AllTrim( Str( nMiesiac ) )
         RETURN aRes
      ENDIF

      IF ! hb_HHasKey( aDane[ 'Naglowek' ], 'DataDo' )
         aRes[ 'Komunikat' ] := 'Brak daty koäcowej okresu (DataDo)'
         RETURN aRes
      ENDIF
      IF ! Empty( nRok ) .AND. ! Empty( nMiesiac ) .AND. ( Month( aDane[ 'Naglowek' ][ 'DataDo' ] ) != nMiesiac .OR. Year( aDane[ 'Naglowek' ][ 'DataDo' ] ) != nRok )
         aRes[ 'Komunikat' ] := 'Bˆ©dny koniec okresu (odczytany rok-miesiac: ' + AllTrim( Str( Year( aDane[ 'Naglowek' ][ 'DataDo' ] ) ) ) + '-' + AllTrim( Str( Month( aDane[ 'Naglowek' ][ 'DataDo' ] ) ) ) + ;
            ' wymagany: ' + AllTrim( Str( nRok ) ) + '-' + AllTrim( Str( nMiesiac ) )
         RETURN aRes
      ENDIF
   ELSE
      IF ! hb_HHasKey( aDane[ 'Naglowek' ], 'Rok' ) .OR. ! hb_HHasKey( aDane[ 'Naglowek' ], 'Miesiac' )
         aRes[ 'Komunikat' ] := 'Brak roku lub miesi¥ca w nagˆ¢wku deklaracji'
         RETURN aRes
      ENDIF
      IF ! Empty( nRok ) .AND. ! Empty( nMiesiac ) .AND. ( Val( aDane[ 'Naglowek' ][ 'Rok' ] ) != nRok .OR. Val( aDane[ 'Naglowek' ][ 'Miesiac' ] ) != nMiesiac )
         aRes[ 'Komunikat' ] := 'Bˆ©dny okres danych w pliku (odcytany rok-miesi¥c: ' + aDane[ 'Naglowek' ][ 'Rok' ] + '-' + aDane[ 'Naglowek' ][ 'Miesiac' ]
         RETURN aRes
      ENDIF
      aDane[ 'Naglowek' ][ 'DataOd' ] := hb_Date( nRok, nMiesiac, 1 )
      aDane[ 'Naglowek' ][ 'DataDo' ] := EoM( hb_Date( nRok, nMiesiac, 1 ) )
   ENDIF

   IF ! hb_HHasKey( aDane[ 'Podmiot' ], 'NIP' )
      aRes[ 'Komunikat' ] := 'Brak nr NIP podmiotu na formlularzu JPK'
      RETURN aRes
   ENDIF
   IF ! Empty( cNip ) .AND. aDane[ 'Podmiot' ][ 'NIP' ] != cNip
      aRes[ 'Komunikat' ] := 'Nieprawidˆowy NIP dokumentu (odczytany: ' + aDane[ 'Podmiot' ][ 'NIP' ] + ;
         ' wymagany: ' + cNip
      RETURN aRes
   ENDIF

   aRes[ 'OK' ] := .T.

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatS_Wczytaj( cPlikJpk, lZakupy )

   LOCAL oDoc, cAktKlucz
   LOCAL xRes := .F.
   LOCAL aDaneJPK := hb_Hash()
   LOCAL aWeryf, aWiersz
   LOCAL oWiersz, oWierszIter, oWartosc, oWartoscIter
   LOCAL aFirma, lDaneDostepne := .F.

/*   LOCAL bWiersz := { | |
      IF ! Empty( oWiersz )
         oWartoscIter := TXMLIterator():New( oDoc )
         aWiersz := hb_Hash()
         DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
            aWiersz[ xmlUsunNamespace( oWartosc:cName ) ] := sxml2str( oWartosc:cData )
         ENDDO
         AAdd( aDaneJPK[ 'Sprzedaz' ], aWiersz )
      ENDIF
   }*/

   hb_default( @lZakupy, .F. )

   IF File( cPlikJpk )

      oDoc := TXMLDocument():New( cPlikJpk )

      IF oDoc:nError == HBXML_ERROR_NONE

         aDaneJPK[ 'Naglowek' ] := JPKImp_WczytajNagl( oDoc )
         aDaneJPK[ 'Podmiot' ] := JPKImp_WczytajPodm( oDoc )

         aFirma := PobierzFirme( Val( ident_fir ) )
         aDaneJPK[ 'Firma' ] := aFirma
         aWeryf := JPKImp_Weryf( @aDaneJPK, TrimNip( aFirma[ 'firma' ][ 'nip' ] ), Val( param_rok ), Val( miesiac ) )

         IF aWeryf[ 'OK' ]

            DO CASE
            CASE aDaneJPK[ 'Naglowek' ][ 'KodFormularza' ] == "JPK_VAT"

               aDaneJPK[ 'Sprzedaz' ] := {}

               oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

               oWiersz := oWierszIter:Find( '(([\w]*:)SprzedazWiersz|(^SprzedazWiersz))' )
               DO WHILE ( oWiersz != NIL )
                  oWartoscIter := TXMLIterator():New( oWiersz )
                  aWiersz := hb_Hash()
                  DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                     cAktKlucz := oWartosc:cName
                     IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                        oWartosc := oWartoscIter:Next()
                     ENDIF
                     aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
                  ENDDO
                  AAdd( aDaneJPK[ 'Sprzedaz' ], aWiersz )

                  oWiersz := oWierszIter:Next()
               ENDDO

               aDaneJPK[ 'SprzedazSum' ] := hb_Hash( 'Ilosc', 0, 'K_10', 0, 'K_11', 0, 'K_12', 0, ;
                  'K_13', 0, 'K_14', 0, 'K_15', 0, 'K_16', 0, 'K_17', 0, 'K_18', 0, 'K_19', 0, ;
                  'K_20', 0, 'K_21', 0, 'K_22', 0, 'K_23', 0, 'K_24', 0, 'K_25', 0, 'K_26', 0, ;
                  'K_27', 0, 'K_28', 0, 'K_29', 0, 'K_30', 0, 'K_31', 0, 'K_32', 0, 'K_33', 0, ;
                  'K_34', 0, 'K_35', 0, 'K_36', 0, 'K_37', 0, 'K_38', 0, 'K_39', 0 )

               IF Len( aDaneJPK[ 'Sprzedaz' ] ) > 0

                  AEval( aDaneJPK[ 'Sprzedaz' ], { | aW |
                     aW[ 'Aktywny' ] := .F.
                     aW[ 'Importuj' ] := .F.
                     aW[ 'DataWystawienia' ] := sxml2date( aW[ 'DataWystawienia' ] )
                     aW[ 'NazwaKontrahenta' ] := sxmlTrim( aW[ 'NazwaKontrahenta' ] )
                     aW[ 'AdresKontrahenta' ] := sxmlTrim( aW[ 'AdresKontrahenta' ] )
                     IF ! hb_HHasKey( aW, 'DataSprzedazy' ) .OR. AllTrim( aW[ 'DataSprzedazy' ] ) == ""
                        aW[ 'DataSprzedazy' ] := aW[ 'DataWystawienia' ]
                     ELSE
                        aW[ 'DataSprzedazy' ] := sxml2date( aW[ 'DataSprzedazy' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'K_10' ) .AND. HB_ISCHAR( aW[ 'K_10' ] )
                        aW[ 'K_10' ] := sxml2num( aW[ 'K_10' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_10' ] += aW[ 'K_10' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_11' ) .AND. HB_ISCHAR( aW[ 'K_11' ] )
                        aW[ 'K_11' ] := sxml2num( aW[ 'K_11' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_11' ] += aW[ 'K_11' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_12' ) .AND. HB_ISCHAR( aW[ 'K_12' ] )
                        aW[ 'K_12' ] := sxml2num( aW[ 'K_12' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_12' ] += aW[ 'K_12' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_13' ) .AND. HB_ISCHAR( aW[ 'K_13' ] )
                        aW[ 'K_13' ] := sxml2num( aW[ 'K_13' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_13' ] += aW[ 'K_13' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_14' ) .AND. HB_ISCHAR( aW[ 'K_14' ] )
                        aW[ 'K_14' ] := sxml2num( aW[ 'K_14' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_14' ] += aW[ 'K_14' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_15' ) .AND. HB_ISCHAR( aW[ 'K_15' ] )
                        aW[ 'K_15' ] := sxml2num( aW[ 'K_15' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_15' ] += aW[ 'K_15' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_16' ) .AND. HB_ISCHAR( aW[ 'K_16' ] )
                        aW[ 'K_16' ] := sxml2num( aW[ 'K_16' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_16' ] += aW[ 'K_16' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_17' ) .AND. HB_ISCHAR( aW[ 'K_17' ] )
                        aW[ 'K_17' ] := sxml2num( aW[ 'K_17' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_17' ] += aW[ 'K_17' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_18' ) .AND. HB_ISCHAR( aW[ 'K_18' ] )
                        aW[ 'K_18' ] := sxml2num( aW[ 'K_18' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_18' ] += aW[ 'K_18' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_19' ) .AND. HB_ISCHAR( aW[ 'K_19' ] )
                        aW[ 'K_19' ] := sxml2num( aW[ 'K_19' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_19' ] += aW[ 'K_19' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_20' ) .AND. HB_ISCHAR( aW[ 'K_20' ] )
                        aW[ 'K_20' ] := sxml2num( aW[ 'K_20' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_20' ] += aW[ 'K_20' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_21' ) .AND. HB_ISCHAR( aW[ 'K_21' ] )
                        aW[ 'K_21' ] := sxml2num( aW[ 'K_21' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_21' ] += aW[ 'K_21' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_22' ) .AND. HB_ISCHAR( aW[ 'K_22' ] )
                        aW[ 'K_22' ] := sxml2num( aW[ 'K_22' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_22' ] += aW[ 'K_22' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_23' ) .AND. HB_ISCHAR( aW[ 'K_23' ] )
                        aW[ 'K_23' ] := sxml2num( aW[ 'K_23' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_23' ] += aW[ 'K_23' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_24' ) .AND. HB_ISCHAR( aW[ 'K_24' ] )
                        aW[ 'K_24' ] := sxml2num( aW[ 'K_24' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_24' ] += aW[ 'K_24' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_25' ) .AND. HB_ISCHAR( aW[ 'K_25' ] )
                        aW[ 'K_25' ] := sxml2num( aW[ 'K_25' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_25' ] += aW[ 'K_25' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_26' ) .AND. HB_ISCHAR( aW[ 'K_26' ] )
                        aW[ 'K_26' ] := sxml2num( aW[ 'K_26' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_26' ] += aW[ 'K_26' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_27' ) .AND. HB_ISCHAR( aW[ 'K_27' ] )
                        aW[ 'K_27' ] := sxml2num( aW[ 'K_27' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_27' ] += aW[ 'K_27' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_28' ) .AND. HB_ISCHAR( aW[ 'K_28' ] )
                        aW[ 'K_28' ] := sxml2num( aW[ 'K_28' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_28' ] += aW[ 'K_28' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_29' ) .AND. HB_ISCHAR( aW[ 'K_29' ] )
                        aW[ 'K_29' ] := sxml2num( aW[ 'K_29' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_29' ] += aW[ 'K_29' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_30' ) .AND. HB_ISCHAR( aW[ 'K_30' ] )
                        aW[ 'K_30' ] := sxml2num( aW[ 'K_30' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_30' ] += aW[ 'K_30' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_31' ) .AND. HB_ISCHAR( aW[ 'K_31' ] )
                        aW[ 'K_31' ] := sxml2num( aW[ 'K_31' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_31' ] += aW[ 'K_31' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_32' ) .AND. HB_ISCHAR( aW[ 'K_32' ] )
                        aW[ 'K_32' ] := sxml2num( aW[ 'K_32' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_32' ] += aW[ 'K_32' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_33' ) .AND. HB_ISCHAR( aW[ 'K_33' ] )
                        aW[ 'K_33' ] := sxml2num( aW[ 'K_33' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_33' ] += aW[ 'K_33' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_34' ) .AND. HB_ISCHAR( aW[ 'K_34' ] )
                        aW[ 'K_34' ] := sxml2num( aW[ 'K_34' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_34' ] += aW[ 'K_34' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_35' ) .AND. HB_ISCHAR( aW[ 'K_35' ] )
                        aW[ 'K_35' ] := sxml2num( aW[ 'K_35' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_35' ] += aW[ 'K_35' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_36' ) .AND. HB_ISCHAR( aW[ 'K_36' ] )
                        aW[ 'K_36' ] := sxml2num( aW[ 'K_36' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_36' ] += aW[ 'K_36' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_37' ) .AND. HB_ISCHAR( aW[ 'K_37' ] )
                        aW[ 'K_37' ] := sxml2num( aW[ 'K_37' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_37' ] += aW[ 'K_37' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_38' ) .AND. HB_ISCHAR( aW[ 'K_38' ] )
                        aW[ 'K_38' ] := sxml2num( aW[ 'K_38' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_38' ] += aW[ 'K_38' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_39' ) .AND. HB_ISCHAR( aW[ 'K_39' ] )
                        aW[ 'K_39' ] := sxml2num( aW[ 'K_39' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_39' ] += aW[ 'K_39' ]
                     ENDIF
                  } )

                  lDaneDostepne := .T.

               ELSE
                  IF ! lZakupy
                     Komun( 'Deklaracja nie zawiera pozycji sprzeda¾y' )
                  ENDIF
               ENDIF

               IF lZakupy
                  aDaneJPK[ 'Zakup' ] := {}

                  oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

                  oWiersz := oWierszIter:Find( '(([\w]*:)ZakupWiersz|(^ZakupWiersz))' )
                  DO WHILE ( oWiersz != NIL )
                     oWartoscIter := TXMLIterator():New( oWiersz )
                     aWiersz := hb_Hash()
                     DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                        cAktKlucz := oWartosc:cName
                        IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                           oWartosc := oWartoscIter:Next()
                        ENDIF
                        aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
                     ENDDO
                     AAdd( aDaneJPK[ 'Zakup' ], aWiersz )

                     oWiersz := oWierszIter:Next()
                  ENDDO

                  aDaneJPK[ 'ZakupSum' ] := hb_Hash( 'Ilosc', 0, 'K_43', 0, 'K_44', 0, 'K_45', 0, ;
                     'K_46', 0, 'K_47', 0, 'K_48', 0, 'K_49', 0, 'K_50', 0 )

                  IF Len( aDaneJPK[ 'Zakup' ] ) > 0

                     AEval( aDaneJPK[ 'Zakup' ], { | aW |
                        aW[ 'Aktywny' ] := .F.
                        aW[ 'Importuj' ] := .F.
                        aW[ 'DataZakupu' ] := sxml2date( aW[ 'DataZakupu' ] )
                        aW[ 'NazwaDostawcy' ] := sxmlTrim( aW[ 'NazwaDostawcy' ] )
                        aW[ 'AdresDostawcy' ] := sxmlTrim( aW[ 'AdresDostawcy' ] )
                        IF ! hb_HHasKey( aW, 'DataWplywu' ) .OR. AllTrim( aW[ 'DataWplywu' ] ) == ""
                           aW[ 'DataWplywu' ] := aW[ 'DataZakupu' ]
                        ELSE
                           aW[ 'DataWplywu' ] := sxml2date( aW[ 'DataWplywu' ] )
                        ENDIF
                        IF hb_HHasKey( aW, 'K_43' ) .AND. HB_ISCHAR( aW[ 'K_43' ] )
                           aW[ 'K_43' ] := sxml2num( aW[ 'K_43' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_43' ] += aW[ 'K_43' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_44' ) .AND. HB_ISCHAR( aW[ 'K_44' ] )
                           aW[ 'K_44' ] := sxml2num( aW[ 'K_44' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_44' ] += aW[ 'K_44' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_45' ) .AND. HB_ISCHAR( aW[ 'K_45' ] )
                           aW[ 'K_45' ] := sxml2num( aW[ 'K_45' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_45' ] += aW[ 'K_45' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_46' ) .AND. HB_ISCHAR( aW[ 'K_46' ] )
                           aW[ 'K_46' ] := sxml2num( aW[ 'K_46' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_46' ] += aW[ 'K_46' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_47' ) .AND. HB_ISCHAR( aW[ 'K_47' ] )
                           aW[ 'K_47' ] := sxml2num( aW[ 'K_47' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_47' ] += aW[ 'K_47' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_48' ) .AND. HB_ISCHAR( aW[ 'K_48' ] )
                           aW[ 'K_48' ] := sxml2num( aW[ 'K_48' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_48' ] += aW[ 'K_48' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_49' ) .AND. HB_ISCHAR( aW[ 'K_49' ] )
                           aW[ 'K_49' ] := sxml2num( aW[ 'K_49' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_49' ] += aW[ 'K_49' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_50' ) .AND. HB_ISCHAR( aW[ 'K_50' ] )
                           aW[ 'K_50' ] := sxml2num( aW[ 'K_50' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_50' ] += aW[ 'K_50' ]
                        ENDIF
                     } )

                     lDaneDostepne := .T.

                  ENDIF
               ENDIF

               IF lDaneDostepne
                  xRes := aDaneJPK
               ENDIF

            CASE aDaneJPK[ 'Naglowek' ][ 'KodFormularza' ] == "JPK_FA"

               aDaneJPK[ 'Faktura' ] := {}

               oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

               oWiersz := oWierszIter:Find( '(([\w]*:)Faktura|(^Faktura))' )
               DO WHILE ( oWiersz != NIL )
                  oWartoscIter := TXMLIterator():New( oWiersz )
                  aWiersz := hb_Hash()
                  DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                     cAktKlucz := oWartosc:cName
                     IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                        oWartosc := oWartoscIter:Next()
                     ENDIF
                     aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
                  ENDDO
                  AAdd( aDaneJPK[ 'Faktura' ], aWiersz )

                  oWiersz := oWierszIter:Next()
               ENDDO

               aDaneJPK[ 'FakturaSum' ] := hb_Hash( 'Ilosc', 0, 'P_13_1', 0, 'P_14_1', 0, 'P_14_1W', 0, ;
                  'P_13_2', 0, 'P_14_2', 0, 'P_14_2W', 0, 'P_13_3', 0, 'P_14_3', 0, 'P_14_3W', 0, 'P_13_4', 0, 'P_14_4', 0, 'P_14_4W', 0, ;
                  'P_13_5', 0, 'P_14_5', 0, 'P_13_6', 0, 'P_13_7', 0, 'P_15', 0 )

               IF Len( aDaneJPK[ 'Faktura' ] ) > 0

                  AEval( aDaneJPK[ 'Faktura' ], { | aW |
                     aW[ 'Aktywny' ] := .F.
                     aW[ 'Importuj' ] := .F.
                     aW[ 'P_1' ] := sxml2date( aW[ 'P_1' ] )
                     IF hb_HHasKey( aW, 'P_3A' ) .AND. HB_ISCHAR( aW[ 'P_3A' ] )
                        aW[ 'P_3A' ] := sxmlTrim( aW[ 'P_3A' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_3B' ) .AND. HB_ISCHAR( aW[ 'P_3B' ] )
                        aW[ 'P_3B' ] := sxmlTrim( aW[ 'P_3B' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_3C' ) .AND. HB_ISCHAR( aW[ 'P_3C' ] )
                        aW[ 'P_3C' ] := sxmlTrim( aW[ 'P_3C' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_3D' ) .AND. HB_ISCHAR( aW[ 'P_3D' ] )
                        aW[ 'P_3D' ] := sxmlTrim( aW[ 'P_3D' ] )
                     ENDIF
                     IF ! hb_HHasKey( aW, 'P_5A' ) .OR. AllTrim( aW[ 'P_5A' ] ) == ""
                        aW[ 'P_5A' ] := "PL"
                     ENDIF
                     IF ! hb_HHasKey( aW, 'P_5B' ) .OR. AllTrim( aW[ 'P_5B' ] ) == ""
                        aW[ 'P_5B' ] := ""
                     ENDIF
                     IF ! hb_HHasKey( aW, 'P_6' ) .OR. AllTrim( aW[ 'P_6' ] ) == ""
                        aW[ 'P_6' ] := aW[ 'P_1' ]
                     ELSE
                        aW[ 'P_6' ] := sxml2date( aW[ 'P_6' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_1' ) .AND. HB_ISCHAR( aW[ 'P_13_1' ] )
                        aW[ 'P_13_1' ] := sxml2num( aW[ 'P_13_1' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_1' ] += aW[ 'P_13_1' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_1' ) .AND. HB_ISCHAR( aW[ 'P_14_1' ] )
                        aW[ 'P_14_1' ] := sxml2num( aW[ 'P_14_1' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_1' ] += aW[ 'P_14_1' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_1W' ) .AND. HB_ISCHAR( aW[ 'P_14_1W' ] )
                        aW[ 'P_14_1W' ] := sxml2num( aW[ 'P_14_1W' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_1W' ] += aW[ 'P_14_1W' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_2' ) .AND. HB_ISCHAR( aW[ 'P_13_2' ] )
                        aW[ 'P_13_2' ] := sxml2num( aW[ 'P_13_2' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_2' ] += aW[ 'P_13_2' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_2' ) .AND. HB_ISCHAR( aW[ 'P_14_2' ] )
                        aW[ 'P_14_2' ] := sxml2num( aW[ 'P_14_2' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_2' ] += aW[ 'P_14_2' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_2W' ) .AND. HB_ISCHAR( aW[ 'P_14_2W' ] )
                        aW[ 'P_14_2W' ] := sxml2num( aW[ 'P_14_2W' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_2W' ] += aW[ 'P_14_2W' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_3' ) .AND. HB_ISCHAR( aW[ 'P_13_3' ] )
                        aW[ 'P_13_3' ] := sxml2num( aW[ 'P_13_3' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_3' ] += aW[ 'P_13_3' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_3' ) .AND. HB_ISCHAR( aW[ 'P_14_3' ] )
                        aW[ 'P_14_3' ] := sxml2num( aW[ 'P_14_3' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_3' ] += aW[ 'P_14_3' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_3W' ) .AND. HB_ISCHAR( aW[ 'P_14_3W' ] )
                        aW[ 'P_14_3W' ] := sxml2num( aW[ 'P_14_3W' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_3W' ] += aW[ 'P_14_3W' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_4' ) .AND. HB_ISCHAR( aW[ 'P_13_4' ] )
                        aW[ 'P_13_4' ] := sxml2num( aW[ 'P_13_4' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_4' ] += aW[ 'P_13_4' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_4' ) .AND. HB_ISCHAR( aW[ 'P_14_4' ] )
                        aW[ 'P_14_4' ] := sxml2num( aW[ 'P_14_4' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_4' ] += aW[ 'P_14_4' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_4W' ) .AND. HB_ISCHAR( aW[ 'P_14_4W' ] )
                        aW[ 'P_14_4W' ] := sxml2num( aW[ 'P_14_4W' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_4W' ] += aW[ 'P_14_4W' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_5' ) .AND. HB_ISCHAR( aW[ 'P_13_5' ] )
                        aW[ 'P_13_5' ] := sxml2num( aW[ 'P_13_5' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_5' ] += aW[ 'P_13_5' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_14_5' ) .AND. HB_ISCHAR( aW[ 'P_14_5' ] )
                        aW[ 'P_14_5' ] := sxml2num( aW[ 'P_14_5' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_14_5' ] += aW[ 'P_14_5' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_6' ) .AND. HB_ISCHAR( aW[ 'P_13_6' ] )
                        aW[ 'P_13_6' ] := sxml2num( aW[ 'P_13_6' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_6' ] += aW[ 'P_13_6' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_13_7' ) .AND. HB_ISCHAR( aW[ 'P_13_7' ] )
                        aW[ 'P_13_7' ] := sxml2num( aW[ 'P_13_7' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_13_7' ] += aW[ 'P_13_7' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'P_15' ) .AND. HB_ISCHAR( aW[ 'P_15' ] )
                        aW[ 'P_15' ] := sxml2num( aW[ 'P_15' ], 0 )
                        aDaneJPK[ 'FakturaSum' ][ 'P_15' ] += aW[ 'P_15' ]
                     ENDIF

                     IF hb_HHasKey( aW, 'P_16' ) .AND. HB_ISCHAR( aW[ 'P_16' ] )
                        aW[ 'P_16' ] := sxml2bool( aW[ 'P_16' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_17' ) .AND. HB_ISCHAR( aW[ 'P_17' ] )
                        aW[ 'P_17' ] := sxml2bool( aW[ 'P_17' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_18' ) .AND. HB_ISCHAR( aW[ 'P_18' ] )
                        aW[ 'P_18' ] := sxml2bool( aW[ 'P_18' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_18A' ) .AND. HB_ISCHAR( aW[ 'P_18A' ] )
                        aW[ 'P_18A' ] := sxml2bool( aW[ 'P_18A' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_19' ) .AND. HB_ISCHAR( aW[ 'P_19' ] )
                        aW[ 'P_19' ] := sxml2bool( aW[ 'P_19' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_20' ) .AND. HB_ISCHAR( aW[ 'P_20' ] )
                        aW[ 'P_20' ] := sxml2bool( aW[ 'P_20' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_21' ) .AND. HB_ISCHAR( aW[ 'P_21' ] )
                        aW[ 'P_21' ] := sxml2bool( aW[ 'P_21' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_23' ) .AND. HB_ISCHAR( aW[ 'P_23' ] )
                        aW[ 'P_23' ] := sxml2bool( aW[ 'P_23' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_106E_2' ) .AND. HB_ISCHAR( aW[ 'P_106E_2' ] )
                        aW[ 'P_106E_2' ] := sxml2bool( aW[ 'P_106E_2' ], 0 )
                     ENDIF
                     IF hb_HHasKey( aW, 'P_106E_3' ) .AND. HB_ISCHAR( aW[ 'P_106E_3' ] )
                        aW[ 'P_106E_3' ] := sxml2bool( aW[ 'P_106E_3' ], 0 )
                     ENDIF

                  } )

                  xRes := aDaneJPK

               ELSE
                  Komun( 'Deklaracja nie zawiera pozycji lub posiada niewˆa˜ciw¥ struktur©' )
               ENDIF

            CASE AScan( { "JPK_V7M", "JPK_V7K" } ,aDaneJPK[ 'Naglowek' ][ 'KodFormularza' ] ) > 0

               aDaneJPK[ 'Sprzedaz' ] := {}

               oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

               oWiersz := oWierszIter:Find( '(([\w]*:)SprzedazWiersz|(^SprzedazWiersz))' )
               DO WHILE ( oWiersz != NIL )
                  oWartoscIter := TXMLIterator():New( oWiersz )
                  aWiersz := hb_Hash()
                  DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                     cAktKlucz := oWartosc:cName
                     IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                        oWartosc := oWartoscIter:Next()
                     ENDIF
                     aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
                  ENDDO
                  AAdd( aDaneJPK[ 'Sprzedaz' ], aWiersz )

                  oWiersz := oWierszIter:Next()
               ENDDO

               aDaneJPK[ 'SprzedazSum' ] := hb_Hash( 'Ilosc', 0, ;
                  'K_10', 0, 'K_11', 0, 'K_12', 0, 'K_13', 0, 'K_14', 0, 'K_15', 0, 'K_16', 0, ;
                  'K_17', 0, 'K_18', 0, 'K_19', 0, 'K_20', 0, 'K_21', 0, 'K_22', 0, 'K_23', 0, ;
                  'K_24', 0, 'K_25', 0, 'K_26', 0, 'K_27', 0, 'K_28', 0, 'K_29', 0, 'K_30', 0, ;
                  'K_31', 0, 'K_32', 0, 'K_33', 0, 'K_34', 0, 'K_35', 0, 'K_36', 0, 'SprzedazVAT_Marza', 0 )

               IF Len( aDaneJPK[ 'Sprzedaz' ] ) > 0

                  AEval( aDaneJPK[ 'Sprzedaz' ], { | aW |
                     aW[ 'Aktywny' ] := .F.
                     aW[ 'Importuj' ] := .F.
                     aW[ 'DataWystawienia' ] := sxml2date( aW[ 'DataWystawienia' ] )
                     IF ! hb_HHasKey( aW, 'NazwaKontrahenta' )
                        aW[ 'NazwaKontrahenta' ] := "BRAK"
                     ELSE
                        aW[ 'NazwaKontrahenta' ] := sxmlTrim( aW[ 'NazwaKontrahenta' ] )
                     ENDIF
                     IF ! hb_HHasKey( aW, 'KodKrajuNadaniaTIN' )
                        aW[ 'KodKrajuNadaniaTIN' ] := "PL"
                     ENDIF
                     IF ! hb_HHasKey( aW, 'NrKontrahenta' )
                        aW[ 'NrKontrahenta' ] := "BRAK"
                     ENDIF
                     //aW[ 'AdresKontrahenta' ] := sxmlTrim( aW[ 'AdresKontrahenta' ] )
                     IF ! hb_HHasKey( aW, 'DataSprzedazy' ) .OR. AllTrim( aW[ 'DataSprzedazy' ] ) == ""
                        aW[ 'DataSprzedazy' ] := aW[ 'DataWystawienia' ]
                     ELSE
                        aW[ 'DataSprzedazy' ] := sxml2date( aW[ 'DataSprzedazy' ] )
                     ENDIF
                     IF hb_HHasKey( aW, 'TypDokumentu' ) .AND. HB_ISCHAR( aW[ 'TypDokumentu' ] )
                        aW[ 'TypDokumentu' ] := sxmlTrim( aW[ 'TypDokumentu' ] )
                     ELSE
                        aW[ 'TypDokumentu' ] := ''
                     ENDIF
                     aW[ 'Oznaczenie' ] := ''
                     IF hb_HHasKey( aW, 'GTU_01' ) .AND. HB_ISCHAR( aW[ 'GTU_01' ] ) .AND. sxmlTrim( aW[ 'GTU_01' ] ) == '1'
                        aW[ 'Oznaczenie' ] := '1'
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_02' ) .AND. HB_ISCHAR( aW[ 'GTU_02' ] ) .AND. sxmlTrim( aW[ 'GTU_02' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '2', ',2' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_03' ) .AND. HB_ISCHAR( aW[ 'GTU_03' ] ) .AND. sxmlTrim( aW[ 'GTU_03' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '3', ',3' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_04' ) .AND. HB_ISCHAR( aW[ 'GTU_04' ] ) .AND. sxmlTrim( aW[ 'GTU_04' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '4', ',4' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_05' ) .AND. HB_ISCHAR( aW[ 'GTU_05' ] ) .AND. sxmlTrim( aW[ 'GTU_05' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '5', ',5' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_06' ) .AND. HB_ISCHAR( aW[ 'GTU_06' ] ) .AND. sxmlTrim( aW[ 'GTU_06' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '6', ',6' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_07' ) .AND. HB_ISCHAR( aW[ 'GTU_07' ] ) .AND. sxmlTrim( aW[ 'GTU_07' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '7', ',7' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_08' ) .AND. HB_ISCHAR( aW[ 'GTU_08' ] ) .AND. sxmlTrim( aW[ 'GTU_08' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '8', ',8' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_09' ) .AND. HB_ISCHAR( aW[ 'GTU_09' ] ) .AND. sxmlTrim( aW[ 'GTU_09' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '9', ',9' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_10' ) .AND. HB_ISCHAR( aW[ 'GTU_10' ] ) .AND. sxmlTrim( aW[ 'GTU_10' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '10', ',10' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_11' ) .AND. HB_ISCHAR( aW[ 'GTU_11' ] ) .AND. sxmlTrim( aW[ 'GTU_11' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '11', ',11' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_12' ) .AND. HB_ISCHAR( aW[ 'GTU_12' ] ) .AND. sxmlTrim( aW[ 'GTU_12' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '12', ',12' )
                     ENDIF
                     IF hb_HHasKey( aW, 'GTU_13' ) .AND. HB_ISCHAR( aW[ 'GTU_13' ] ) .AND. sxmlTrim( aW[ 'GTU_13' ] ) == '1'
                        aW[ 'Oznaczenie' ] := aW[ 'Oznaczenie' ] + iif( aW[ 'Oznaczenie' ] == '', '13', ',13' )
                     ENDIF
                     aW[ 'Procedura' ] := ''
                     IF hb_HHasKey( aW, 'WSTO_EE' ) .AND. HB_ISCHAR( aW[ 'WSTO_EE' ] ) .AND. sxmlTrim( aW[ 'WSTO_EE' ] ) == '1'
                        aW[ 'Procedura' ] := 'WSTO_EE'
                     ENDIF
                     IF hb_HHasKey( aW, 'IED' ) .AND. HB_ISCHAR( aW[ 'IED' ] ) .AND. sxmlTrim( aW[ 'IED' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'IED'
                     ENDIF
                     IF hb_HHasKey( aW, 'TP' ) .AND. HB_ISCHAR( aW[ 'TP' ] ) .AND. sxmlTrim( aW[ 'TP' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'TP'
                     ENDIF
                     IF hb_HHasKey( aW, 'TT_WNT' ) .AND. HB_ISCHAR( aW[ 'TT_WNT' ] ) .AND. sxmlTrim( aW[ 'TT_WNT' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'TT_WNT'
                     ENDIF
                     IF hb_HHasKey( aW, 'TT_D' ) .AND. HB_ISCHAR( aW[ 'TT_D' ] ) .AND. sxmlTrim( aW[ 'TT_D' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'TT_D'
                     ENDIF
                     IF hb_HHasKey( aW, 'MR_T' ) .AND. HB_ISCHAR( aW[ 'MR_T' ] ) .AND. sxmlTrim( aW[ 'MR_T' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'MR_T'
                     ENDIF
                     IF hb_HHasKey( aW, 'MR_UZ' ) .AND. HB_ISCHAR( aW[ 'MR_UZ' ] ) .AND. sxmlTrim( aW[ 'MR_UZ' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'MR_UZ'
                     ENDIF
                     IF hb_HHasKey( aW, 'I_42' ) .AND. HB_ISCHAR( aW[ 'I_42' ] ) .AND. sxmlTrim( aW[ 'I_42' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'I_42'
                     ENDIF
                     IF hb_HHasKey( aW, 'I_63' ) .AND. HB_ISCHAR( aW[ 'I_63' ] ) .AND. sxmlTrim( aW[ 'I_63' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'I_63'
                     ENDIF
                     IF hb_HHasKey( aW, 'B_SPV' ) .AND. HB_ISCHAR( aW[ 'B_SPV' ] ) .AND. sxmlTrim( aW[ 'B_SPV' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'B_SPV'
                     ENDIF
                     IF hb_HHasKey( aW, 'B_SPV_DOSTAWA' ) .AND. HB_ISCHAR( aW[ 'B_SPV_DOSTAWA' ] ) .AND. sxmlTrim( aW[ 'B_SPV_DOSTAWA' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'B_SPV_DOSTAWA'
                     ENDIF
                     IF hb_HHasKey( aW, 'B_MPV_PROWIZJA' ) .AND. HB_ISCHAR( aW[ 'B_MPV_PROWIZJA' ] ) .AND. sxmlTrim( aW[ 'B_MPV_PROWIZJA' ] ) == '1'
                        IF aW[ 'Procedura' ] <> ''
                           aW[ 'Procedura' ] := aW[ 'Procedura' ] + ','
                        ENDIF
                        aW[ 'Procedura' ] := aW[ 'Procedura' ] + 'B_MPV_PROWIZJA'
                     ENDIF
                     IF hb_HHasKey( aW, 'MPP' ) .AND. HB_ISCHAR( aW[ 'MPP' ] ) .AND. sxmlTrim( aW[ 'MPP' ] ) == '1'
                        aW[ 'MPP' ] := .T.
                     ELSE
                        aW[ 'MPP' ] := .F.
                     ENDIF
                     IF hb_HHasKey( aW, 'KorektaPodstawyOpodt' ) .AND. HB_ISCHAR( aW[ 'KorektaPodstawyOpodt' ] ) .AND. sxmlTrim( aW[ 'KorektaPodstawyOpodt' ] ) == '1'
                        aW[ 'KorektaPodstawyOpodt' ] := .T.
                     ELSE
                        aW[ 'KorektaPodstawyOpodt' ] := .F.
                     ENDIF
                     IF hb_HHasKey( aW, 'K_10' ) .AND. HB_ISCHAR( aW[ 'K_10' ] )
                        aW[ 'K_10' ] := sxml2num( aW[ 'K_10' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_10' ] += aW[ 'K_10' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_11' ) .AND. HB_ISCHAR( aW[ 'K_11' ] )
                        aW[ 'K_11' ] := sxml2num( aW[ 'K_11' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_11' ] += aW[ 'K_11' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_12' ) .AND. HB_ISCHAR( aW[ 'K_12' ] )
                        aW[ 'K_12' ] := sxml2num( aW[ 'K_12' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_12' ] += aW[ 'K_12' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_13' ) .AND. HB_ISCHAR( aW[ 'K_13' ] )
                        aW[ 'K_13' ] := sxml2num( aW[ 'K_13' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_13' ] += aW[ 'K_13' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_14' ) .AND. HB_ISCHAR( aW[ 'K_14' ] )
                        aW[ 'K_14' ] := sxml2num( aW[ 'K_14' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_14' ] += aW[ 'K_14' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_15' ) .AND. HB_ISCHAR( aW[ 'K_15' ] )
                        aW[ 'K_15' ] := sxml2num( aW[ 'K_15' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_15' ] += aW[ 'K_15' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_16' ) .AND. HB_ISCHAR( aW[ 'K_16' ] )
                        aW[ 'K_16' ] := sxml2num( aW[ 'K_16' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_16' ] += aW[ 'K_16' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_17' ) .AND. HB_ISCHAR( aW[ 'K_17' ] )
                        aW[ 'K_17' ] := sxml2num( aW[ 'K_17' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_17' ] += aW[ 'K_17' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_18' ) .AND. HB_ISCHAR( aW[ 'K_18' ] )
                        aW[ 'K_18' ] := sxml2num( aW[ 'K_18' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_18' ] += aW[ 'K_18' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_19' ) .AND. HB_ISCHAR( aW[ 'K_19' ] )
                        aW[ 'K_19' ] := sxml2num( aW[ 'K_19' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_19' ] += aW[ 'K_19' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_20' ) .AND. HB_ISCHAR( aW[ 'K_20' ] )
                        aW[ 'K_20' ] := sxml2num( aW[ 'K_20' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_20' ] += aW[ 'K_20' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_21' ) .AND. HB_ISCHAR( aW[ 'K_21' ] )
                        aW[ 'K_21' ] := sxml2num( aW[ 'K_21' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_21' ] += aW[ 'K_21' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_22' ) .AND. HB_ISCHAR( aW[ 'K_22' ] )
                        aW[ 'K_22' ] := sxml2num( aW[ 'K_22' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_22' ] += aW[ 'K_22' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_23' ) .AND. HB_ISCHAR( aW[ 'K_23' ] )
                        aW[ 'K_23' ] := sxml2num( aW[ 'K_23' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_23' ] += aW[ 'K_23' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_24' ) .AND. HB_ISCHAR( aW[ 'K_24' ] )
                        aW[ 'K_24' ] := sxml2num( aW[ 'K_24' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_24' ] += aW[ 'K_24' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_25' ) .AND. HB_ISCHAR( aW[ 'K_25' ] )
                        aW[ 'K_25' ] := sxml2num( aW[ 'K_25' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_25' ] += aW[ 'K_25' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_26' ) .AND. HB_ISCHAR( aW[ 'K_26' ] )
                        aW[ 'K_26' ] := sxml2num( aW[ 'K_26' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_26' ] += aW[ 'K_26' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_27' ) .AND. HB_ISCHAR( aW[ 'K_27' ] )
                        aW[ 'K_27' ] := sxml2num( aW[ 'K_27' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_27' ] += aW[ 'K_27' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_28' ) .AND. HB_ISCHAR( aW[ 'K_28' ] )
                        aW[ 'K_28' ] := sxml2num( aW[ 'K_28' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_28' ] += aW[ 'K_28' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_29' ) .AND. HB_ISCHAR( aW[ 'K_29' ] )
                        aW[ 'K_29' ] := sxml2num( aW[ 'K_29' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_29' ] += aW[ 'K_29' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_30' ) .AND. HB_ISCHAR( aW[ 'K_30' ] )
                        aW[ 'K_30' ] := sxml2num( aW[ 'K_30' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_30' ] += aW[ 'K_30' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_31' ) .AND. HB_ISCHAR( aW[ 'K_31' ] )
                        aW[ 'K_31' ] := sxml2num( aW[ 'K_31' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_31' ] += aW[ 'K_31' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_32' ) .AND. HB_ISCHAR( aW[ 'K_32' ] )
                        aW[ 'K_32' ] := sxml2num( aW[ 'K_32' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_32' ] += aW[ 'K_32' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_33' ) .AND. HB_ISCHAR( aW[ 'K_33' ] )
                        aW[ 'K_33' ] := sxml2num( aW[ 'K_33' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_33' ] += aW[ 'K_33' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_34' ) .AND. HB_ISCHAR( aW[ 'K_34' ] )
                        aW[ 'K_34' ] := sxml2num( aW[ 'K_34' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_34' ] += aW[ 'K_34' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_35' ) .AND. HB_ISCHAR( aW[ 'K_35' ] )
                        aW[ 'K_35' ] := sxml2num( aW[ 'K_35' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_35' ] += aW[ 'K_35' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'K_36' ) .AND. HB_ISCHAR( aW[ 'K_36' ] )
                        aW[ 'K_36' ] := sxml2num( aW[ 'K_36' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'K_36' ] += aW[ 'K_36' ]
                     ENDIF
                     IF hb_HHasKey( aW, 'SprzedazVAT_Marza' ) .AND. HB_ISCHAR( aW[ 'SprzedazVAT_Marza' ] )
                        aW[ 'SprzedazVAT_Marza' ] := sxml2num( aW[ 'SprzedazVAT_Marza' ], 0 )
                        aDaneJPK[ 'SprzedazSum' ][ 'SprzedazVAT_Marza' ] += aW[ 'SprzedazVAT_Marza' ]
                     ENDIF
                  } )

                  lDaneDostepne := .T.

               ELSE
                  IF ! lZakupy
                     Komun( 'Deklaracja nie zawiera pozycji sprzeda¾y' )
                  ENDIF
               ENDIF

               IF lZakupy
                  aDaneJPK[ 'Zakup' ] := {}

                  oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

                  oWiersz := oWierszIter:Find( '(([\w]*:)ZakupWiersz|(^ZakupWiersz))' )
                  DO WHILE ( oWiersz != NIL )
                     oWartoscIter := TXMLIterator():New( oWiersz )
                     aWiersz := hb_Hash()
                     DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                        cAktKlucz := oWartosc:cName
                        IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                           oWartosc := oWartoscIter:Next()
                        ENDIF
                        aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
                     ENDDO
                     AAdd( aDaneJPK[ 'Zakup' ], aWiersz )

                     oWiersz := oWierszIter:Next()
                  ENDDO

                  aDaneJPK[ 'ZakupSum' ] := hb_Hash( 'Ilosc', 0, 'K_40', 0, 'K_41', 0, 'K_42', 0, ;
                     'K_43', 0, 'K_44', 0, 'K_45', 0, 'K_46', 0, 'K_47', 0, 'ZakupVAT_Marza', 0 )

                  IF Len( aDaneJPK[ 'Zakup' ] ) > 0

                     AEval( aDaneJPK[ 'Zakup' ], { | aW |
                        aW[ 'Aktywny' ] := .F.
                        aW[ 'Importuj' ] := .F.
                        aW[ 'DataZakupu' ] := sxml2date( aW[ 'DataZakupu' ] )
                        IF ! hb_HHasKey( aW, 'NazwaDostawcy' )
                           aW[ 'NazwaDostawcy' ] := "BRAK"
                        ELSE
                           aW[ 'NazwaDostawcy' ] := sxmlTrim( aW[ 'NazwaDostawcy' ] )
                        ENDIF
                        //aW[ 'AdresDostawcy' ] := sxmlTrim( aW[ 'AdresDostawcy' ] )
                        IF ! hb_HHasKey( aW, 'KodKrajuNadaniaTIN' )
                           aW[ 'KodKrajuNadaniaTIN' ] := "PL"
                        ENDIF
                        IF ! hb_HHasKey( aW, 'NrDostawcy' )
                           aW[ 'NrDostawcy' ] := "BRAK"
                        ENDIF
                        IF ! hb_HHasKey( aW, 'DataWplywu' ) .OR. AllTrim( aW[ 'DataWplywu' ] ) == ""
                           aW[ 'DataWplywu' ] := aW[ 'DataZakupu' ]
                        ELSE
                           aW[ 'DataWplywu' ] := sxml2date( aW[ 'DataWplywu' ] )
                        ENDIF
                        IF hb_HHasKey( aW, 'DokumentZakupu' ) .AND. HB_ISCHAR( aW[ 'DokumentZakupu' ] )
                           aW[ 'DokumentZakupu' ] := sxmlTrim( aW[ 'DokumentZakupu' ] )
                        ELSE
                           aW[ 'DokumentZakupu' ] := ''
                        ENDIF
                        IF hb_HHasKey( aW, 'MPP' ) .AND. HB_ISCHAR( aW[ 'MPP' ] ) .AND. sxmlTrim( aW[ 'MPP' ] ) == '1'
                           aW[ 'MPP' ] := .T.
                        ELSE
                           aW[ 'MPP' ] := .F.
                        ENDIF
                        IF hb_HHasKey( aW, 'IMP' ) .AND. HB_ISCHAR( aW[ 'IMP' ] ) .AND. sxmlTrim( aW[ 'IMP' ] ) == '1'
                           aW[ 'IMP' ] := .T.
                        ELSE
                           aW[ 'IMP' ] := .F.
                        ENDIF
                        IF hb_HHasKey( aW, 'K_40' ) .AND. HB_ISCHAR( aW[ 'K_40' ] )
                           aW[ 'K_40' ] := sxml2num( aW[ 'K_40' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_40' ] += aW[ 'K_40' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_41' ) .AND. HB_ISCHAR( aW[ 'K_41' ] )
                           aW[ 'K_41' ] := sxml2num( aW[ 'K_41' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_41' ] += aW[ 'K_41' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_42' ) .AND. HB_ISCHAR( aW[ 'K_42' ] )
                           aW[ 'K_42' ] := sxml2num( aW[ 'K_42' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_42' ] += aW[ 'K_42' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_43' ) .AND. HB_ISCHAR( aW[ 'K_43' ] )
                           aW[ 'K_43' ] := sxml2num( aW[ 'K_43' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_43' ] += aW[ 'K_43' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_44' ) .AND. HB_ISCHAR( aW[ 'K_44' ] )
                           aW[ 'K_44' ] := sxml2num( aW[ 'K_44' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_44' ] += aW[ 'K_44' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_45' ) .AND. HB_ISCHAR( aW[ 'K_45' ] )
                           aW[ 'K_45' ] := sxml2num( aW[ 'K_45' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_45' ] += aW[ 'K_45' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_46' ) .AND. HB_ISCHAR( aW[ 'K_46' ] )
                           aW[ 'K_46' ] := sxml2num( aW[ 'K_46' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_46' ] += aW[ 'K_46' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'K_47' ) .AND. HB_ISCHAR( aW[ 'K_47' ] )
                           aW[ 'K_47' ] := sxml2num( aW[ 'K_47' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'K_47' ] += aW[ 'K_47' ]
                        ENDIF
                        IF hb_HHasKey( aW, 'ZakupVAT_Marza' ) .AND. HB_ISCHAR( aW[ 'ZakupVAT_Marza' ] )
                           aW[ 'ZakupVAT_Marza' ] := sxml2num( aW[ 'ZakupVAT_Marza' ], 0 )
                           aDaneJPK[ 'ZakupSum' ][ 'ZakupVAT_Marza' ] += aW[ 'ZakupVAT_Marza' ]
                        ENDIF
                     } )

                     lDaneDostepne := .T.

                  ENDIF
               ENDIF

               IF lDaneDostepne
                  xRes := aDaneJPK
               ENDIF

            ENDCASE

         ELSE
            Komun( aWeryf[ 'Komunikat' ] )
         ENDIF
      ELSE
         Komun( 'Wyst¥piˆ bˆ¥d podczas otwierania pliku JPK. Nr bˆ©du: ' + AllTrim( Str( oDoc:nError ) ) )
      ENDIF
   ELSE
      Komun( 'Brak pliku wej˜ciowego' )
   ENDIF

   RETURN xRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Podglad_VAT( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "Lp", "NIP", "Nazwa", "Adres", "Nr dow. sprzeda¾y", "Data wyst.", "Data sprz.", ;
      "K_10", "K_11", "K_12", "K_13", "K_14", "K_15", "K_16", "K_17", "K_18", "K_19", ;
      "K_20", "K_21", "K_22", "K_23", "K_24", "K_25", "K_26", "K_27", "K_28", "K_29", ;
      "K_30", "K_31", "K_32", "K_33", "K_34", "K_35", "K_36", "K_37", "K_38", "K_39" }
   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( aDane[ nElem ][ "LpSprzedazy" ], 6 ) }, ;
      { || PadR( aDane[ nElem ][ "NrKontrahenta" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "NazwaKontrahenta" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "AdresKontrahenta" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "DowodSprzedazy" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "DataWystawienia" ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ "DataSprzedazy" ], 10 ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_10" ), Transform( aDane[ nElem ][ "K_10" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_11" ), Transform( aDane[ nElem ][ "K_11" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_12" ), Transform( aDane[ nElem ][ "K_12" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_13" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_14" ), Transform( aDane[ nElem ][ "K_14" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_15" ), Transform( aDane[ nElem ][ "K_15" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_16" ), Transform( aDane[ nElem ][ "K_16" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_17" ), Transform( aDane[ nElem ][ "K_17" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_18" ), Transform( aDane[ nElem ][ "K_18" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_19" ), Transform( aDane[ nElem ][ "K_19" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_20" ), Transform( aDane[ nElem ][ "K_20" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_21" ), Transform( aDane[ nElem ][ "K_21" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_22" ), Transform( aDane[ nElem ][ "K_22" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_23" ), Transform( aDane[ nElem ][ "K_23" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_24" ), Transform( aDane[ nElem ][ "K_24" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_25" ), Transform( aDane[ nElem ][ "K_25" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_26" ), Transform( aDane[ nElem ][ "K_26" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_27" ), Transform( aDane[ nElem ][ "K_27" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_28" ), Transform( aDane[ nElem ][ "K_28" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_29" ), Transform( aDane[ nElem ][ "K_29" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_30" ), Transform( aDane[ nElem ][ "K_30" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_31" ), Transform( aDane[ nElem ][ "K_31" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_32" ), Transform( aDane[ nElem ][ "K_32" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_33" ), Transform( aDane[ nElem ][ "K_33" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_34" ), Transform( aDane[ nElem ][ "K_34" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_35" ), Transform( aDane[ nElem ][ "K_35" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_36" ), Transform( aDane[ nElem ][ "K_36" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_37" ), Transform( aDane[ nElem ][ "K_37" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_38" ), Transform( aDane[ nElem ][ "K_38" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_39" ), Transform( aDane[ nElem ][ "K_39" ], RPICE ),  Transform( 0, RPICE ) ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", "", Transform( aSumy[ "K_10" ], RPICE ), ;
      Transform( aSumy[ "K_11" ], RPICE ), Transform( aSumy[ "K_12" ], RPICE ), ;
      Transform( aSumy[ "K_13" ], RPICE ), Transform( aSumy[ "K_14" ], RPICE ), ;
      Transform( aSumy[ "K_15" ], RPICE ), Transform( aSumy[ "K_16" ], RPICE ), ;
      Transform( aSumy[ "K_17" ], RPICE ), Transform( aSumy[ "K_18" ], RPICE ), ;
      Transform( aSumy[ "K_19" ], RPICE ), Transform( aSumy[ "K_20" ], RPICE ), ;
      Transform( aSumy[ "K_21" ], RPICE ), Transform( aSumy[ "K_22" ], RPICE ), ;
      Transform( aSumy[ "K_23" ], RPICE ), Transform( aSumy[ "K_24" ], RPICE ), ;
      Transform( aSumy[ "K_25" ], RPICE ), Transform( aSumy[ "K_26" ], RPICE ), ;
      Transform( aSumy[ "K_27" ], RPICE ), Transform( aSumy[ "K_28" ], RPICE ), ;
      Transform( aSumy[ "K_29" ], RPICE ), Transform( aSumy[ "K_30" ], RPICE ), ;
      Transform( aSumy[ "K_31" ], RPICE ), Transform( aSumy[ "K_32" ], RPICE ), ;
      Transform( aSumy[ "K_33" ], RPICE ), Transform( aSumy[ "K_34" ], RPICE ), ;
      Transform( aSumy[ "K_35" ], RPICE ), Transform( aSumy[ "K_36" ], RPICE ), ;
      Transform( aSumy[ "K_37" ], RPICE ), Transform( aSumy[ "K_38" ], RPICE ), ;
      Transform( aSumy[ "K_39" ], RPICE ) }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Podglad_V7( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "Lp", "NIP", "Nazwa", "Nr dow. sprzeda¾y", "Data wyst.", "Data sprz.", ;
      "K_10", "K_11", "K_12", "K_13", "K_14", "K_15", "K_16", "K_17", "K_18", "K_19", ;
      "K_20", "K_21", "K_22", "K_23", "K_24", "K_25", "K_26", "K_27", "K_28", "K_29", ;
      "K_30", "K_31", "K_32", "K_33", "K_34", "K_35", "K_36", "Mar¾a", "Typ dok.", "Oznaczenie", "Procedura", "MPP" }
   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( aDane[ nElem ][ "LpSprzedazy" ], 6 ) }, ;
      { || PadR( aDane[ nElem ][ "NrKontrahenta" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "NazwaKontrahenta" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "DowodSprzedazy" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "DataWystawienia" ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ "DataSprzedazy" ], 10 ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_10" ), Transform( aDane[ nElem ][ "K_10" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_11" ), Transform( aDane[ nElem ][ "K_11" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_12" ), Transform( aDane[ nElem ][ "K_12" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_13" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_14" ), Transform( aDane[ nElem ][ "K_14" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_15" ), Transform( aDane[ nElem ][ "K_15" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_16" ), Transform( aDane[ nElem ][ "K_16" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_17" ), Transform( aDane[ nElem ][ "K_17" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_18" ), Transform( aDane[ nElem ][ "K_18" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_19" ), Transform( aDane[ nElem ][ "K_19" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_20" ), Transform( aDane[ nElem ][ "K_20" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_21" ), Transform( aDane[ nElem ][ "K_21" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_22" ), Transform( aDane[ nElem ][ "K_22" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_23" ), Transform( aDane[ nElem ][ "K_23" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_24" ), Transform( aDane[ nElem ][ "K_24" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_25" ), Transform( aDane[ nElem ][ "K_25" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_26" ), Transform( aDane[ nElem ][ "K_26" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_27" ), Transform( aDane[ nElem ][ "K_27" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_28" ), Transform( aDane[ nElem ][ "K_28" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_29" ), Transform( aDane[ nElem ][ "K_29" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_30" ), Transform( aDane[ nElem ][ "K_30" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_31" ), Transform( aDane[ nElem ][ "K_31" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_32" ), Transform( aDane[ nElem ][ "K_32" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_33" ), Transform( aDane[ nElem ][ "K_33" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_34" ), Transform( aDane[ nElem ][ "K_34" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_35" ), Transform( aDane[ nElem ][ "K_35" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_36" ), Transform( aDane[ nElem ][ "K_36" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "SprzedazVAT_Marza" ), Transform( aDane[ nElem ][ "SprzedazVAT_Marza" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || PadR( aDane[ nElem ][ "TypDokumentu" ], 3 ) }, ;
      { || PadR( aDane[ nElem ][ "Oznaczenie" ], 2 ) }, ;
      { || PadR( aDane[ nElem ][ "Procedura" ], 3 ) }, ;
      { || iif( aDane[ nElem ][ 'MPP' ], "Tak", "Nie" ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", Transform( aSumy[ "K_10" ], RPICE ), ;
      Transform( aSumy[ "K_11" ], RPICE ), Transform( aSumy[ "K_12" ], RPICE ), ;
      Transform( aSumy[ "K_13" ], RPICE ), Transform( aSumy[ "K_14" ], RPICE ), ;
      Transform( aSumy[ "K_15" ], RPICE ), Transform( aSumy[ "K_16" ], RPICE ), ;
      Transform( aSumy[ "K_17" ], RPICE ), Transform( aSumy[ "K_18" ], RPICE ), ;
      Transform( aSumy[ "K_19" ], RPICE ), Transform( aSumy[ "K_20" ], RPICE ), ;
      Transform( aSumy[ "K_21" ], RPICE ), Transform( aSumy[ "K_22" ], RPICE ), ;
      Transform( aSumy[ "K_23" ], RPICE ), Transform( aSumy[ "K_24" ], RPICE ), ;
      Transform( aSumy[ "K_25" ], RPICE ), Transform( aSumy[ "K_26" ], RPICE ), ;
      Transform( aSumy[ "K_27" ], RPICE ), Transform( aSumy[ "K_28" ], RPICE ), ;
      Transform( aSumy[ "K_29" ], RPICE ), Transform( aSumy[ "K_30" ], RPICE ), ;
      Transform( aSumy[ "K_31" ], RPICE ), Transform( aSumy[ "K_32" ], RPICE ), ;
      Transform( aSumy[ "K_33" ], RPICE ), Transform( aSumy[ "K_34" ], RPICE ), ;
      Transform( aSumy[ "K_35" ], RPICE ), Transform( aSumy[ "K_36" ], RPICE ), ;
      Transform( aSumy[ "SprzedazVAT_Marza" ], RPICE ), "", "", "", "" }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Podglad_VAT( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "Lp", "NIP", "Nazwa", "Adres", "Nr dow. sprzeda¾y", "Data wyst.", "Data sprz.", ;
      "K_43", "K_44", "K_45", "K_46", "K_47", "K_48", "K_49", "K_50" }

   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( aDane[ nElem ][ "LpZakupu" ], 6 ) }, ;
      { || PadR( aDane[ nElem ][ "NrDostawcy" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "NazwaDostawcy" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "AdresDostawcy" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "DowodZakupu" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "DataZakupu" ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ "DataWplywu" ], 10 ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_43" ), Transform( aDane[ nElem ][ "K_43" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_44" ), Transform( aDane[ nElem ][ "K_44" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_45" ), Transform( aDane[ nElem ][ "K_45" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_46" ), Transform( aDane[ nElem ][ "K_46" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_47" ), Transform( aDane[ nElem ][ "K_47" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_48" ), Transform( aDane[ nElem ][ "K_48" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_49" ), Transform( aDane[ nElem ][ "K_49" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_50" ), Transform( aDane[ nElem ][ "K_50" ], RPICE ),  Transform( 0, RPICE ) ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", "", Transform( aSumy[ "K_43" ], RPICE ), ;
      Transform( aSumy[ "K_44" ], RPICE ), Transform( aSumy[ "K_45" ], RPICE ), ;
      Transform( aSumy[ "K_46" ], RPICE ), Transform( aSumy[ "K_47" ], RPICE ), ;
      Transform( aSumy[ "K_48" ], RPICE ), Transform( aSumy[ "K_49" ], RPICE ), ;
      Transform( aSumy[ "K_50" ], RPICE ) }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Podglad_V7( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "Lp", "NIP", "Nazwa", "Nr dow. sprzeda¾y", "Data wyst.", "Data sprz.", ;
      "Rodz.dok", "K_40", "K_41", "K_42", "K_43", "K_44", "K_45", "K_46", "K_47", "Mar¾a", "MPP", "IMP" }

   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( aDane[ nElem ][ "LpZakupu" ], 6 ) }, ;
      { || PadR( aDane[ nElem ][ "NrDostawcy" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "NazwaDostawcy" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "DowodZakupu" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "DataZakupu" ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ "DataWplywu" ], 10 ) }, ;
      { || PadR( aDane[ nElem ][ "DokumentZakupu" ], 6 ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_40" ), Transform( aDane[ nElem ][ "K_40" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_41" ), Transform( aDane[ nElem ][ "K_41" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_42" ), Transform( aDane[ nElem ][ "K_42" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_43" ), Transform( aDane[ nElem ][ "K_43" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_44" ), Transform( aDane[ nElem ][ "K_44" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_45" ), Transform( aDane[ nElem ][ "K_45" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_46" ), Transform( aDane[ nElem ][ "K_46" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_47" ), Transform( aDane[ nElem ][ "K_47" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "ZakupVAT_Marza" ), Transform( aDane[ nElem ][ "ZakupVAT_Marza" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( aDane[ nElem ][ 'MPP' ], "Tak", "Nie" ) }, ;
      { || iif( aDane[ nElem ][ 'IMP' ], "Tak", "Nie" ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", "", ;
      Transform( aSumy[ "K_40" ], RPICE ), Transform( aSumy[ "K_41" ], RPICE ), ;
      Transform( aSumy[ "K_42" ], RPICE ), Transform( aSumy[ "K_43" ], RPICE ), ;
      Transform( aSumy[ "K_44" ], RPICE ), Transform( aSumy[ "K_45" ], RPICE ), ;
      Transform( aSumy[ "K_46" ], RPICE ), Transform( aSumy[ "K_47" ], RPICE ), ;
      Transform( aSumy[ "ZakupVAT_Marza" ], RPICE ), "", "" }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Podglad_FA( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "KodWaluty", "P_1", "P_2A", "P_3A", "P_3B", "P_3C", "P_3D", "P_4A", ;
      "P_4B", "P_5A", "P_5B", "P_6", "P_13_1", "P_14_1", "P_14_1W", "P_13_2", "P_14_2", "P_14_2W", "P_13_3", "P_14_3", "P_14_3W", ;
      "P_13_4", "P_14_4", "P_14_4W", "P_13_5", "P_14_5", "P_13_6", "P_13_7", "P_15", "P_16", "P_17", "P_18", "P_18A", ;
      "P_19", "P_19A", "P_19B", "P_19C", "P_20", "P_20A", "P_20B", "P_21", "P_21A", "P_21B", "P_21C", ;
      "P_22", "P_22A", "P_22B", "P_22C", "P_23", "P_106E_2", "P_106E_3", "P_106E_3A", "RodzajFaktury", ;
      "PrzyczynaKorekty", "NrFaKorygowanej", "OkresFaKorygowanej", "NrFaZaliczkowej", "ZALZaplata", "ZALPodatek" }
   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "KodWaluty", "" ), 3 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "P_1", "" ), 10 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_2A", "" ), 16 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_3A", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_3B", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_3C", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_3D", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_4A", "" ), 2 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_4B", "" ), 16 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_5A", "" ), 2 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_5B", "" ), 16 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_6", "" ), 10 ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_1", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_1", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_1W", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_2", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_2", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_2W", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_3", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_3", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_3W", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_4", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_4", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_4W", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_5", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_14_5", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_6", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_13_7", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "P_15", 0 ), RPICE ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_16", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_17", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_18", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_18A", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_19", .F. ) ), 5 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_19A", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_19B", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_19C", "" ), 25 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_20", .F. ) ), 5 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_20A", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_20B", "" ), 25 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_21", .F. ) ), 5 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_21A", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_21B", "" ), 25 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_21C", "" ), 15 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_22", .F. ) ), 5 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_22A", "" ), 10 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_22B", "" ), 10 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_22C", "" ), 10 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_23", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_106E_2", .F. ) ), 5 ) }, ;
      { || PadR( bool2sxml( HGetDefault( aDane[ nElem ], "P_106E_3", .F. ) ), 5 ) }, ;
      { || PadR( HGetDefault( aDane[ nElem ], "P_106E_3A", "" ), 15 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "RodzajFaktury", "" ), 7 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "PrzyczynaKorekty", "" ), 25 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "NrFaKorygowanej", "" ), 16 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "OkresFaKorygowanej", "" ), 10 ) }, ;
      { || PadC( HGetDefault( aDane[ nElem ], "NrFaZaliczkowej", "" ), 16 ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "ZALZaplata", 0 ), RPICE ) }, ;
      { || Transform( HGetDefault( aDane[ nElem ], "ZALPodatek", 0 ), RPICE ) } }

   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", "", "", "", "", "", "", ;
      Transform( aSumy[ "P_13_1" ], RPICE ), Transform( aSumy[ "P_14_1" ], RPICE ), Transform( aSumy[ "P_14_1W" ], RPICE ), ;
      Transform( aSumy[ "P_13_2" ], RPICE ), Transform( aSumy[ "P_14_2" ], RPICE ), Transform( aSumy[ "P_14_2W" ], RPICE ), ;
      Transform( aSumy[ "P_13_3" ], RPICE ), Transform( aSumy[ "P_14_3" ], RPICE ), Transform( aSumy[ "P_14_3W" ], RPICE ), ;
      Transform( aSumy[ "P_13_4" ], RPICE ), Transform( aSumy[ "P_14_4" ], RPICE ), Transform( aSumy[ "P_14_4W" ], RPICE ), ;
      Transform( aSumy[ "P_13_5" ], RPICE ), Transform( aSumy[ "P_14_5" ], RPICE ), ;
      Transform( aSumy[ "P_13_6" ], RPICE ), Transform( aSumy[ "P_13_7" ], RPICE ), ;
      Transform( aSumy[ "P_15" ], RPICE ), "", "", "", "", "", "", "", "", "", "", ;
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Dekretuj_FA( aDane )

   LOCAL aRes := {}
   LOCAL cNipFir := TrimNip( aDane[ 'JPK' ][ 'Firma' ][ 'firma' ][ 'nip' ] )

   AEval( aDane[ 'JPK' ][ 'Faktura' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip := HGetDefault( aPoz, 'P_4B', '' )
      LOCAL cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'P_13_1' ) .AND. aPoz[ 'P_13_1' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_2' ) .AND. aPoz[ 'P_13_2' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_3' ) .AND. aPoz[ 'P_13_3' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_4' ) .AND. aPoz[ 'P_13_4' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_5' ) .AND. aPoz[ 'P_13_5' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_6' ) .AND. aPoz[ 'P_13_6' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_7' ) .AND. aPoz[ 'P_13_7' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_1' ) .AND. aPoz[ 'P_14_1' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_2' ) .AND. aPoz[ 'P_14_2' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_3' ) .AND. aPoz[ 'P_14_3' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_4' ) .AND. aPoz[ 'P_14_4' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_5' ) .AND. aPoz[ 'P_14_5' ] <> 0 ) ) .AND. ;
         aPoz[ 'P_16' ] == .F. .AND. aPoz[ 'P_17' ] == .F. .AND. /*aPoz[ 'P_19' ] == .F. .AND.*/ ;
         aPoz[ 'P_20' ] == .F. .AND. aPoz[ 'P_21' ] == .F. .AND. aPoz[ 'P_106E_2' ] == .F. .AND. ;
         ( ( ( Month( aPoz[ 'P_1' ] ) == Val( miesiac ) ) .AND. ( Year( aPoz[ 'P_1' ] ) == Val( param_rok ) ) ) ;
         .OR. ( hb_HHasKey( aPoz, 'P_6' ) .AND. ( Month( aPoz[ 'P_6' ] ) == Val( miesiac ) ) ;
         .AND. ( Year( aPoz[ 'P_1' ] ) == Val( param_rok ) ) ) ) .AND. ( iif( cNip == '', .T., cNip == cNipFir ) )
/*         ( iif( cNip == '', .T., cNip == cNipFir ) ) .AND. ;
         ( ( hb_HHasKey( aPoz, 'P_6' ) .AND. ( Month( aPoz[ 'P_6' ] ) == Val( miesiac ) ) .AND. ( Year( aPoz[ 'P_6' ] ) == Val( miesiac ) ) ) .OR. ;
         ( ! hb_HHasKey( aPoz, 'P_6' ) .AND. ( Month( aPoz[ 'P_1' ] ) == Val( miesiac ) ) .AND. ( Year( aPoz[ 'P_1' ] ) == Val( miesiac ) ) ) )
*/
/*         IF hb_HHasKey( aPoz, 'KodWaluty' ) .AND. aPoz[ 'KodWaluty' ] <> 'PLN'
            IF ( hb_HHasKey( aPoz, 'P_14_1W' ) .AND. aPoz[ 'P_14_1W' ] <> 0 ) .OR. ;
            ( hb_HHasKey( aPoz, 'P_14_2W' ) .AND. aPoz[ 'P_14_2W' ] <> 0 ) .OR. ;
            ( hb_HHasKey( aPoz, 'P_14_3W' ) .AND. aPoz[ 'P_14_3W' ] <> 0 )

               aPoz[ 'Aktywny' ] := .T.
               aPoz[ 'Importuj' ] := .T.

               aPozDek := hb_Hash()
               aPozDek[ 'zsek_cv7' ] := '  '
               aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
               aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
               aPozDek[ 'znumer' ] := HGetDefault( aPoz, 'P_2A', '' )

               aPozDek[ 'zkraj' ] := HGetDefault( aPoz, 'P_5A', 'PL' )
               aPozDek[ 'zue' ] := iif( AScan( aKrajeUE, aPozDek[ 'zkraj' ] ) > 0, 'T', 'N' )
               aPozDek[ 'znr_ident' ] := HGetDefault( aPoz, 'P_5B', '' )
               aPozDek[ 'znazwa' ] := HGetDefault( aPoz, 'P_3A', '' )
               aPozDek[ 'zadres' ] := HGetDefault( aPoz, 'P_3B', '' )
               aPozDek[ 'zdatas' ] := HGetDefault( aPoz, 'P_6', aPoz[ 'P_1' ] )

               aPozDek[ 'zwartzw' ] := HGetDefault( aPoz, 'P_13_7', 0 )

               aPozDek[ 'zexport' ] := 'N'
               IF aPozDek[ 'zue' ] == 'N' .AND. aPozDek[ 'zkraj' ] <> 'PL'
                  aPozDek[ 'zexport' ] := 'T'
               ENDIF


               aPozDek[ 'zwart02' ] := 0
               aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'P_14_3W', 0 )

               aPozDek[ 'zwart07' ] := 0
               aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'P_14_2W', 0 )

               aPozDek[ 'zwart22' ] := 0
               aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'P_14_1W', 0 )

               aPozDek[ 'zwart08' ] := 0
               aPozDek[ 'zwart00' ] := 0

               IF aPoz[ 'P_18' ]
                  aPozDek[ 'zsek_cv7' ] := 'PN'
               ENDIF

               IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
                  aPozDek[ 'zsek_cv7' ] := 'SP'
               ENDIF

               aPozDek[ 'zkorekta' ] := iif( aPoz[ 'RodzajFaktury' ] == "KOREKTA" , 'T', 'N' )

               aPozDek[ 'FakturaPoz' ] := aPoz

               AAdd( aRes, aPozDek )
            ENDIF
         ELSE */
            aPoz[ 'Aktywny' ] := .T.
            aPoz[ 'Importuj' ] := .T.

            aPozDek := hb_Hash()
            aPozDek[ 'zsek_cv7' ] := '  '
            aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
            aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
            aPozDek[ 'znumer' ] := HGetDefault( aPoz, 'P_2A', '' )

            aPozDek[ 'zkraj' ] := HGetDefault( aPoz, 'P_5A', 'PL' )
            aPozDek[ 'zue' ] := iif( KrajUE( aPozDek[ 'zkraj' ] ), 'T', 'N' )
            aPozDek[ 'znr_ident' ] := HGetDefault( aPoz, 'P_5B', '' )
            aPozDek[ 'znazwa' ] := HGetDefault( aPoz, 'P_3A', '' )
            aPozDek[ 'zadres' ] := HGetDefault( aPoz, 'P_3B', '' )
            aPozDek[ 'zdatas' ] := HGetDefault( aPoz, 'P_6', aPoz[ 'P_1' ] )

            aPozDek[ 'zwartzw' ] := HGetDefault( aPoz, 'P_13_7', 0 )

            aPozDek[ 'zexport' ] := 'N'
            IF aPozDek[ 'zue' ] == 'N' .AND. aPozDek[ 'zkraj' ] <> 'PL'
               aPozDek[ 'zexport' ] := 'T'
            ENDIF



            aPozDek[ 'zwart02' ] := HGetDefault( aPoz, 'P_13_3', 0 )
            aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'P_14_3', 0 )

            aPozDek[ 'zwart07' ] := HGetDefault( aPoz, 'P_13_2', 0 )
            aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'P_14_2', 0 )

            aPozDek[ 'zwart22' ] := HGetDefault( aPoz, 'P_13_1', 0 )
            aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'P_14_1', 0 )

            aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_5', 0 )
            aPozDek[ 'zwart00' ] := 0

            IF aPoz[ 'P_18' ]
               aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
               aPozDek[ 'zsek_cv7' ] := 'PN'
            ELSE
               aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
            ENDIF

            IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
               aPozDek[ 'zsek_cv7' ] := 'SP'
            ENDIF

            aPozDek[ 'zkorekta' ] := iif( aPoz[ 'RodzajFaktury' ] == "KOREKTA" , 'T', 'N' )

            aPozDek[ 'KodWaluty' ] := HGetDefault( aPoz, 'KodWaluty', 'PLN' )

            aPozDek[ 'VATMarza' ] := 0
            aPozDek[ 'RodzDow' ] := ''
            aPozDek[ 'Procedura' ] := ''
            aPozDek[ 'Oznaczenie' ] := ''

            aPozDek[ 'FakturaPoz' ] := aPoz

            AAdd( aRes, aPozDek )
         //ENDIF

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Dekretuj_FA( aDane )

   LOCAL aRes := {}
   LOCAL cNipFir := TrimNip( aDane[ 'JPK' ][ 'Firma' ][ 'firma' ][ 'nip' ] )

   AEval( aDane[ 'JPK' ][ 'Faktura' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip := HGetDefault( aPoz, 'P_5B', '' )
      LOCAL cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'P_13_1' ) .AND. aPoz[ 'P_13_1' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_2' ) .AND. aPoz[ 'P_13_2' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_3' ) .AND. aPoz[ 'P_13_3' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_4' ) .AND. aPoz[ 'P_13_4' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_5' ) .AND. aPoz[ 'P_13_5' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_6' ) .AND. aPoz[ 'P_13_6' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_7' ) .AND. aPoz[ 'P_13_7' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_1' ) .AND. aPoz[ 'P_14_1' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_2' ) .AND. aPoz[ 'P_14_2' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_13_3' ) .AND. aPoz[ 'P_14_3' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_4' ) .AND. aPoz[ 'P_14_4' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'P_14_5' ) .AND. aPoz[ 'P_14_5' ] <> 0 ) ) .AND. ;
         aPoz[ 'P_16' ] == .F. .AND. aPoz[ 'P_17' ] == .F. .AND. /*aPoz[ 'P_19' ] == .F. .AND.*/ ;
         aPoz[ 'P_20' ] == .F. .AND. aPoz[ 'P_21' ] == .F. .AND. aPoz[ 'P_106E_2' ] == .F. .AND. ;
         ( ( ( Month( aPoz[ 'P_1' ] ) == Val( miesiac ) ) .AND. ( Year( aPoz[ 'P_1' ] ) == Val( param_rok ) ) ) ;
         .OR. ( hb_HHasKey( aPoz, 'P_6' ) .AND. ( Month( aPoz[ 'P_6' ] ) == Val( miesiac ) ) ;
         .AND. ( Year( aPoz[ 'P_1' ] ) == Val( param_rok ) ) ) ) .AND. ( iif( cNip == '', .T., cNip == cNipFir ) )

/*         IF hb_HHasKey( aPoz, 'KodWaluty' ) .AND. aPoz[ 'KodWaluty' ] <> 'PLN'
            IF ( hb_HHasKey( aPoz, 'P_14_1W' ) .AND. aPoz[ 'P_14_1W' ] <> 0 ) .OR. ;
            ( hb_HHasKey( aPoz, 'P_14_2W' ) .AND. aPoz[ 'P_14_2W' ] <> 0 ) .OR. ;
            ( hb_HHasKey( aPoz, 'P_14_3W' ) .AND. aPoz[ 'P_14_3W' ] <> 0 )

               aPoz[ 'DataDok' ] := aPoz[ 'DataWystawienia' ]

               aPoz[ 'Aktywny' ] := .T.
               aPoz[ 'Importuj' ] := .T.

               aPozDek := hb_Hash()
               aPozDek[ 'zsek_cv7' ] := '  '
               aPozDek[ 'zkolumna' ] := '10'
               aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
               aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
               aPozDek[ 'znumer' ] := HGetDefault( aPoz, 'P_2A', '' )

               //cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
               aPozDek[ 'zkraj' ] := HGetDefault( aPoz, 'P_4A', 'PL' )
               aPozDek[ 'zue' ] := iif( AScan( aKrajeUE, aPozDek[ 'zkraj' ] ) > 0, 'T', 'N' )
               aPozDek[ 'znr_ident' ] := HGetDefault( aPoz, 'P_4B', '' )
               aPozDek[ 'znazwa' ] := HGetDefault( aPoz, 'P_3C', '' )
               aPozDek[ 'zadres' ] := HGetDefault( aPoz, 'P_3D', '' )
               aPozDek[ 'zdatas' ] := HGetDefault( aPoz, 'P_6', aPoz[ 'P_1' ] )

               aPozDek[ 'zexport' ] := 'N'
               IF aPozDek[ 'zue' ] == 'N' .AND. aPozDek[ 'zkraj' ] <> 'PL'
                  aPozDek[ 'zexport' ] := 'T'
               ENDIF

               aPozDek[ 'zkorekta' ] := aPozDek[ 'zkorekta' ] := iif( aPoz[ 'RodzajFaktury' ] == "KOREKTA" , 'T', 'N' )

               aPozDek[ 'zwartzw' ] := 0
               aPozDek[ 'zwart00' ] := 0
               aPozDek[ 'zwart02' ] := 0
               aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'P_14_3W', 0 )
               aPozDek[ 'zwart07' ] := 0
               aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'P_14_2W', 0 )
               aPozDek[ 'zwart22' ] := 0
               aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'P_14_1W', 0 )
               aPozDek[ 'zwart12' ] := 0
               aPozDek[ 'zvat12' ] := 0
               aPozDek[ 'zbrut02' ] := 0
               aPozDek[ 'zbrut07' ] := 0
               aPozDek[ 'zbrut22' ] := 0
               aPozDek[ 'zbrut12' ] := 0
               aPozDek[ 'znetto' ] := 0

               IF aPoz[ 'P_18' ]
                  aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
                  aPozDek[ 'zsek_cv7' ] := 'PN'
               ELSE
                  aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
               ENDIF

               IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
                  aPozDek[ 'zsek_cv7' ] := 'SP'
               ENDIF

               aPozDek[ 'SierTrwaly' ] := .F.
               aPozDek[ 'UwagaVat' ] := .F.

               aPozDek[ 'SprzedazPoz' ] := aPoz

               AAdd( aRes, aPozDek )

            ENDIF
         ELSE */
            aPoz[ 'DataDok' ] := aPoz[ 'DataWystawienia' ]

            aPoz[ 'Aktywny' ] := .T.
            aPoz[ 'Importuj' ] := .T.

            aPozDek := hb_Hash()
            aPozDek[ 'zsek_cv7' ] := '  '
            aPozDek[ 'zkolumna' ] := '10'
            aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
            aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
            aPozDek[ 'znumer' ] := HGetDefault( aPoz, 'P_2A', '' )

            //cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
            aPozDek[ 'zkraj' ] := HGetDefault( aPoz, 'P_4A', 'PL' )
            aPozDek[ 'zue' ] := iif( KrajUE( aPozDek[ 'zkraj' ] ), 'T', 'N' )
            aPozDek[ 'znr_ident' ] := HGetDefault( aPoz, 'P_4B', '' )
            aPozDek[ 'znazwa' ] := HGetDefault( aPoz, 'P_3C', '' )
            aPozDek[ 'zadres' ] := HGetDefault( aPoz, 'P_3D', '' )
            aPozDek[ 'zdatas' ] := HGetDefault( aPoz, 'P_6', aPoz[ 'P_1' ] )

            aPozDek[ 'zexport' ] := 'N'
            IF aPozDek[ 'zue' ] == 'N' .AND. aPozDek[ 'zkraj' ] <> 'PL'
               aPozDek[ 'zexport' ] := 'T'
            ENDIF

            aPozDek[ 'zkorekta' ] := aPozDek[ 'zkorekta' ] := iif( aPoz[ 'RodzajFaktury' ] == "KOREKTA" , 'T', 'N' )

            aPozDek[ 'zwartzw' ] := HGetDefault( aPoz, 'P_13_7', 0 )
            aPozDek[ 'zwart00' ] := 0
            aPozDek[ 'zwart02' ] := HGetDefault( aPoz, 'P_13_3', 0 )
            aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'P_14_3', 0 )
            aPozDek[ 'zwart07' ] := HGetDefault( aPoz, 'P_13_2', 0 )
            aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'P_14_2', 0 )
            aPozDek[ 'zwart22' ] := HGetDefault( aPoz, 'P_13_1', 0 )
            aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'P_14_1', 0 )
            aPozDek[ 'zwart12' ] := 0
            aPozDek[ 'zvat12' ] := 0
            aPozDek[ 'zbrut02' ] := 0
            aPozDek[ 'zbrut07' ] := 0
            aPozDek[ 'zbrut22' ] := 0
            aPozDek[ 'zbrut12' ] := 0
            aPozDek[ 'znetto' ] := 0

            IF aPoz[ 'P_18' ]
               aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
               aPozDek[ 'zsek_cv7' ] := 'PN'
            ELSE
               aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
            ENDIF

            IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
               aPozDek[ 'zsek_cv7' ] := 'SP'
            ENDIF

            aPozDek[ 'SierTrwaly' ] := .F.
            aPozDek[ 'UwagaVat' ] := .F.

            aPozDek[ 'KodWaluty' ] := HGetDefault( aPoz, 'KodWaluty', 'PLN' )

            aPozDek[ 'VATMarza' ] := 0
            aPozDek[ 'RodzDow' ] := ''

            aPozDek[ 'SprzedazPoz' ] := aPoz

            AAdd( aRes, aPozDek )

         //ENDIF

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Dekretuj_VAT( aDane )

   LOCAL aRes := {}

   AEval( aDane[ 'JPK' ][ 'Sprzedaz' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'K_10' ) .AND. aPoz[ 'K_10' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_11' ) .AND. aPoz[ 'K_11' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_12' ) .AND. aPoz[ 'K_12' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_13' ) .AND. aPoz[ 'K_13' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_15' ) .AND. aPoz[ 'K_15' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_16' ) .AND. aPoz[ 'K_16' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_17' ) .AND. aPoz[ 'K_17' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_18' ) .AND. aPoz[ 'K_18' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_19' ) .AND. aPoz[ 'K_19' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_20' ) .AND. aPoz[ 'K_20' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_21' ) .AND. aPoz[ 'K_21' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_22' ) .AND. aPoz[ 'K_22' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_31' ) .AND. aPoz[ 'K_31' ] <> 0 ) ) .AND. ;
         ( ( Month( aPoz[ 'DataWystawienia' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataWystawienia' ] ) == Val( param_rok ) ) .OR. ;
         ( Month( aPoz[ 'DataSprzedazy' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataSprzedazy' ] ) == Val( param_rok ) ) )

/*         ( ( Month( aPoz[ 'DataSprzedazy' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataSprzedazy' ] ) == Val( param_rok ) ) )
*/
         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataWystawienia' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataWystawienia' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodSprzedazy' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaKontrahenta' ]
         aPozDek[ 'zadres' ] := aPoz[ 'AdresKontrahenta' ]
         aPozDek[ 'zdatas' ] := aPoz[ 'DataSprzedazy' ]

         aPozDek[ 'zwartzw' ] := HGetDefault( aPoz, 'K_10', 0 )

         aPozDek[ 'zwart08' ] := 0

         aPozDek[ 'zexport' ] := 'N'
         IF ( aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'K_11', 0 ) ) <> 0
            aPozDek[ 'zexport' ] := 'T'
         ENDIF

         IF HGetDefault( aPoz, 'K_12', 0 ) <> 0
            aPozDek[ 'zue' ] := 'T'
         ENDIF

         aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'K_13', 0 )

         aPozDek[ 'zwart02' ] := HGetDefault( aPoz, 'K_15', 0 )
         aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'K_16', 0 )

         aPozDek[ 'zwart07' ] := HGetDefault( aPoz, 'K_17', 0 )
         aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'K_18', 0 )

         aPozDek[ 'zwart22' ] := HGetDefault( aPoz, 'K_19', 0 )
         aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'K_20', 0 )

         IF HGetDefault( aPoz, 'K_21', 0 ) <> 0
            aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'K_21', 0 )
         ENDIF


         IF HGetDefault( aPoz, 'K_22', 0 ) <> 0
            aPozDek[ 'zwart00' ] := aPoz[ 'K_22' ]
            aPozDek[ 'zue' ] := 'T'
         ENDIF

         IF HGetDefault( aPoz, 'K_31', 0 ) <> 0
            aPozDek[ 'zsek_cv7' ] := 'PN'
            aPozDek[ 'zwart08' ] := aPoz[ 'K_31' ]
         ENDIF

         aPozDek[ 'VATMarza' ] := 0
         aPozDek[ 'RodzDow' ] := ''
         aPozDek[ 'Procedura' ] := ''
         aPozDek[ 'Oznaczenie' ] := ''

         aPozDek[ 'SprzedazPoz' ] := aPoz

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Dekretuj_VAT( aDane )

   LOCAL aRes := {}
   LOCAL nWNetto, nWVat, lSierTrwaly
   LOCAL nRodzajVat

   AEval( aDane[ 'JPK' ][ 'Sprzedaz' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'K_23' ) .AND. aPoz[ 'K_23' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_25' ) .AND. aPoz[ 'K_25' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_29' ) .AND. aPoz[ 'K_29' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_27' ) .AND. aPoz[ 'K_27' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_34' ) .AND. aPoz[ 'K_34' ] <> 0 ) ) .AND. ;
         Month( aPoz[ 'DataWystawienia' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataWystawienia' ] ) == Val( param_rok )

         aPoz[ 'DataDok' ] := aPoz[ 'DataWystawienia' ]

         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zkolumna' ] := '10'
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataWystawienia' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataWystawienia' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodSprzedazy' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( aKrajeUE ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaKontrahenta' ]
         aPozDek[ 'zadres' ] := aPoz[ 'AdresKontrahenta' ]
         aPozDek[ 'zdatas' ] := aPoz[ 'DataSprzedazy' ]

         aPozDek[ 'zexport' ] := 'N'
         aPozDek[ 'zkorekta' ] := 'N'

         aPozDek[ 'zwartzw' ] := 0
         aPozDek[ 'zwart00' ] := 0
         aPozDek[ 'zwart07' ] := 0
         aPozDek[ 'zwart02' ] := 0
         aPozDek[ 'zvat02' ] := 0
         aPozDek[ 'zvat07' ] := 0
         aPozDek[ 'zwart22' ] := 0
         aPozDek[ 'zvat22' ] := 0
         aPozDek[ 'zwart12' ] := 0
         aPozDek[ 'zvat12' ] := 0
         aPozDek[ 'zbrut02' ] := 0
         aPozDek[ 'zbrut07' ] := 0
         aPozDek[ 'zbrut22' ] := 0
         aPozDek[ 'zbrut12' ] := 0
         aPozDek[ 'znetto' ] := 0

         nWNetto := 0
         nWVat := 0

         DO CASE
         CASE ( hb_HHasKey( aPoz, 'K_23' ) .AND. aPoz[ 'K_23' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_23' ]
            aPozDek[ 'zsek_cv7' ] := 'WT'
            nWVat := HGetDefault( aPoz, 'K_24', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_25' ) .AND. aPoz[ 'K_25' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_25' ]
            aPozDek[ 'zsek_cv7' ] := 'IT'
            nWVat := HGetDefault( aPoz, 'K_26', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_29' ) .AND. aPoz[ 'K_29' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_29' ]
            aPozDek[ 'zsek_cv7' ] := 'IU'
            nWVat := HGetDefault( aPoz, 'K_30', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_27' ) .AND. aPoz[ 'K_27' ] <> 0 )
            aPozDek[ 'zue' ] := 'N'
            nWNetto := aPoz[ 'K_27' ]
            aPozDek[ 'zsek_cv7' ] := 'IU'
            nWVat := HGetDefault( aPoz, 'K_28', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_34' ) .AND. aPoz[ 'K_34' ] <> 0 )
            aPozDek[ 'zue' ] := 'N'
            nWNetto := aPoz[ 'K_34' ]
            aPozDek[ 'zsek_cv7' ] := 'PN'
            nWVat := HGetDefault( aPoz, 'K_35', 0 )
         ENDCASE

         nRodzajVat := VATObliczStawkaRodzaj( nWNetto, nWVat )
         DO CASE
         CASE nRodzajVat == 1 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 1 )
            aPozDek[ 'zwart22' ] := nWNetto
            aPozDek[ 'zvat22' ] := nWVat
            aPozDek[ 'zbrut22' ] := nWNetto + nWVat
         CASE nRodzajVat == 2 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 2 )
            aPozDek[ 'zwart07' ] := nWNetto
            aPozDek[ 'zvat07' ] := nWVat
            aPozDek[ 'zbrut07' ] := nWNetto + nWVat
         CASE nRodzajVat == 3 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 3 )
            aPozDek[ 'zwart02' ] := nWNetto
            aPozDek[ 'zvat02' ] := nWVat
            aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         CASE nRodzajVat == 4 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 4 )
            aPozDek[ 'zwart00' ] := nWNetto
            //aPozDek[ 'zvat02' ] := nWVat
            //aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         ENDCASE
         aPozDek[ 'znetto' ] := nWNetto
         aPozDek[ 'SierTrwaly' ] := .F.
         aPozDek[ 'UwagaVat' ] := nRodzajVat == 0

         aPozDek[ 'SprzedazPoz' ] := aPoz

         aPozDek[ 'VATMarza' ] := 0
         aPozDek[ 'RodzDow' ] := ''

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   AEval( aDane[ 'JPK' ][ 'Zakup' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( hb_HHasKey( aPoz, 'K_43' ) .AND. aPoz[ 'K_43' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_45' ) .AND. aPoz[ 'K_45' ] <> 0 ) .OR. ;
         Month( aPoz[ 'DataZakupu' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataZakupu' ] ) == Val( param_rok )

         aPoz[ 'DataDok' ] := aPoz[ 'DataZakupu' ]

         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zkolumna' ] := '10'
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataZakupu' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataZakupu' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodZakupu' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrDostawcy' ] ) ) == "BRAK", "", aPoz[ 'NrDostawcy' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaDostawcy' ]
         aPozDek[ 'zadres' ] := aPoz[ 'AdresDostawcy' ]
         aPozDek[ 'zdatas' ] := aPoz[ 'DataWplywu' ]

         aPozDek[ 'zexport' ] := 'N'
         aPozDek[ 'zkorekta' ] := 'N'

         aPozDek[ 'zwartzw' ] := 0
         aPozDek[ 'zwart00' ] := 0
         aPozDek[ 'zwart07' ] := 0
         aPozDek[ 'zwart02' ] := 0
         aPozDek[ 'zvat02' ] := 0
         aPozDek[ 'zvat07' ] := 0
         aPozDek[ 'zwart22' ] := 0
         aPozDek[ 'zvat22' ] := 0
         aPozDek[ 'zwart12' ] := 0
         aPozDek[ 'zvat12' ] := 0
         aPozDek[ 'zbrut02' ] := 0
         aPozDek[ 'zbrut07' ] := 0
         aPozDek[ 'zbrut22' ] := 0
         aPozDek[ 'zbrut12' ] := 0
         aPozDek[ 'znetto' ] := 0

         lSierTrwaly := .F.
         nWNetto := 0
         nWVat := 0

         DO CASE
         CASE ( hb_HHasKey( aPoz, 'K_43' ) .AND. aPoz[ 'K_43' ] <> 0 )
            lSierTrwaly := .T.
            nWNetto := aPoz[ 'K_43' ]
            nWVat := HGetDefault( aPoz, 'K_44', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_45' ) .AND. aPoz[ 'K_45' ] <> 0 )
            nWNetto := aPoz[ 'K_45' ]
            nWVat := HGetDefault( aPoz, 'K_46', 0 )
         ENDCASE

         nRodzajVat := VATObliczStawkaRodzaj( nWNetto, nWVat )
         DO CASE
         CASE nRodzajVat == 1 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 1 )
            aPozDek[ 'zwart22' ] := nWNetto
            aPozDek[ 'zvat22' ] := nWVat
            aPozDek[ 'zbrut22' ] := nWNetto + nWVat
         CASE nRodzajVat == 2 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 2 )
            aPozDek[ 'zwart07' ] := nWNetto
            aPozDek[ 'zvat07' ] := nWVat
            aPozDek[ 'zbrut07' ] := nWNetto + nWVat
         CASE nRodzajVat == 3 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 3 )
            aPozDek[ 'zwart02' ] := nWNetto
            aPozDek[ 'zvat02' ] := nWVat
            aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         CASE nRodzajVat == 4 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 4 )
            aPozDek[ 'zwart00' ] := nWNetto
            //aPozDek[ 'zvat02' ] := nWVat
            //aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         ENDCASE

         IF hb_HHasKey( aPoz, 'K_48' )
            aPozDek[ 'zkorekta' ] := 'T'
            DO CASE
            CASE aDane[ 'DomVat' ] == 1
               aPozDek[ 'zvat22' ] := aPozDek[ 'zvat22' ] + aPoz[ 'K_48' ]
            CASE aDane[ 'DomVat' ] == 2
               aPozDek[ 'zvat07' ] := aPozDek[ 'zvat07' ] + aPoz[ 'K_48' ]
            CASE aDane[ 'DomVat' ] == 3
               aPozDek[ 'zvat02' ] := aPozDek[ 'zvat02' ] + aPoz[ 'K_48' ]
            CASE aDane[ 'DomVat' ] == 4
               aPozDek[ 'zvat00' ] := aPozDek[ 'zvat00' ] + aPoz[ 'K_48' ]
            ENDCASE
            nWNetto := nWNetto + aPoz[ 'K_48' ]
         ENDIF

         aPozDek[ 'znetto' ] := nWNetto

         aPozDek[ 'SierTrwaly' ] := lSierTrwaly
         aPozDek[ 'UwagaVat' ] := nRodzajVat == 0

         aPozDek[ 'VATMarza' ] := 0
         aPozDek[ 'RodzDow' ] := ''

         aPozDek[ 'SprzedazPoz' ] := aPoz

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Dekretuj_V7( aDane )

   LOCAL aRes := {}

   AEval( aDane[ 'JPK' ][ 'Sprzedaz' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'K_10' ) .AND. aPoz[ 'K_10' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_11' ) .AND. aPoz[ 'K_11' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_12' ) .AND. aPoz[ 'K_12' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_13' ) .AND. aPoz[ 'K_13' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_15' ) .AND. aPoz[ 'K_15' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_16' ) .AND. aPoz[ 'K_16' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_17' ) .AND. aPoz[ 'K_17' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_18' ) .AND. aPoz[ 'K_18' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_19' ) .AND. aPoz[ 'K_19' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_20' ) .AND. aPoz[ 'K_20' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_21' ) .AND. aPoz[ 'K_21' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_22' ) .AND. aPoz[ 'K_22' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_31' ) .AND. aPoz[ 'K_31' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'SprzedazVAT_Marza' ) .AND. aPoz[ 'SprzedazVAT_Marza' ] <> 0 ) ) .AND. ;
         ( ( Month( aPoz[ 'DataWystawienia' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataWystawienia' ] ) == Val( param_rok ) ) .OR. ;
         ( Month( aPoz[ 'DataSprzedazy' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataSprzedazy' ] ) == Val( param_rok ) ) )

/*         ( ( Month( aPoz[ 'DataSprzedazy' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataSprzedazy' ] ) == Val( param_rok ) ) )
*/
         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataWystawienia' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataWystawienia' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodSprzedazy' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaKontrahenta' ]
         aPozDek[ 'zadres' ] := ''
         aPozDek[ 'zdatas' ] := aPoz[ 'DataSprzedazy' ]

         aPozDek[ 'zwartzw' ] := HGetDefault( aPoz, 'K_10', 0 )

         aPozDek[ 'zwart08' ] := 0

         aPozDek[ 'zexport' ] := 'N'
         IF ( aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'K_11', 0 ) ) <> 0
            aPozDek[ 'zexport' ] := 'T'
         ENDIF

         IF HGetDefault( aPoz, 'K_12', 0 ) <> 0
            aPozDek[ 'zue' ] := 'T'
         ENDIF

         aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'K_13', 0 )

         aPozDek[ 'zwart02' ] := HGetDefault( aPoz, 'K_15', 0 )
         aPozDek[ 'zvat02' ] := HGetDefault( aPoz, 'K_16', 0 )

         aPozDek[ 'zwart07' ] := HGetDefault( aPoz, 'K_17', 0 )
         aPozDek[ 'zvat07' ] := HGetDefault( aPoz, 'K_18', 0 )

         aPozDek[ 'zwart22' ] := HGetDefault( aPoz, 'K_19', 0 )
         aPozDek[ 'zvat22' ] := HGetDefault( aPoz, 'K_20', 0 )

         IF HGetDefault( aPoz, 'K_21', 0 ) <> 0
            aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'K_21', 0 )
         ENDIF


         IF HGetDefault( aPoz, 'K_22', 0 ) <> 0
            aPozDek[ 'zwart00' ] := aPoz[ 'K_22' ]
            aPozDek[ 'zue' ] := 'T'
         ENDIF

         IF HGetDefault( aPoz, 'K_31', 0 ) <> 0
            aPozDek[ 'zsek_cv7' ] := 'PN'
            //aPozDek[ 'zwart08' ] := aPoz[ 'K_31' ]
         ENDIF

         IF aPoz[ 'MPP' ]
            aPozDek[ 'zsek_cv7' ] := 'SP'
         ENDIF

         aPozDek[ 'SprzedazPoz' ] := aPoz

         aPozDek[ 'VATMarza' ] := HGetDefault( aPoz, 'SprzedazVAT_Marza', 0 )
         aPozDek[ 'RodzDow' ] := HGetDefault( aPoz, 'TypDokumentu', '' )
         aPozDek[ 'Procedura' ] := HGetDefault( aPoz, 'Procedura', '' )
         aPozDek[ 'Oznaczenie' ] := HGetDefault( aPoz, 'Oznaczenie', '' )

         IF HGetDefault( aPoz, 'KorektaPodstawyOpodt', .F. )
            aPozDek[ 'zkorekta' ] := 'Z'
         ENDIF

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Dekretuj_V7( aDane )

   LOCAL aRes := {}
   LOCAL nWNetto, nWVat, lSierTrwaly
   LOCAL nRodzajVat

   AEval( aDane[ 'JPK' ][ 'Sprzedaz' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( ( hb_HHasKey( aPoz, 'K_23' ) .AND. aPoz[ 'K_23' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_25' ) .AND. aPoz[ 'K_25' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_29' ) .AND. aPoz[ 'K_29' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_27' ) .AND. aPoz[ 'K_27' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_34' ) .AND. aPoz[ 'K_34' ] <> 0 ) ) .AND. ;
         Month( aPoz[ 'DataWystawienia' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataWystawienia' ] ) == Val( param_rok )

         aPoz[ 'DataDok' ] := aPoz[ 'DataWystawienia' ]

         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zkolumna' ] := '10'
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataWystawienia' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataWystawienia' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodSprzedazy' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaKontrahenta' ]
         aPozDek[ 'zadres' ] := ''
         aPozDek[ 'zdatas' ] := aPoz[ 'DataSprzedazy' ]

         aPozDek[ 'zexport' ] := 'N'
         aPozDek[ 'zkorekta' ] := 'N'

         aPozDek[ 'zwartzw' ] := 0
         aPozDek[ 'zwart00' ] := 0
         aPozDek[ 'zwart07' ] := 0
         aPozDek[ 'zwart02' ] := 0
         aPozDek[ 'zvat02' ] := 0
         aPozDek[ 'zvat07' ] := 0
         aPozDek[ 'zwart22' ] := 0
         aPozDek[ 'zvat22' ] := 0
         aPozDek[ 'zwart12' ] := 0
         aPozDek[ 'zvat12' ] := 0
         aPozDek[ 'zbrut02' ] := 0
         aPozDek[ 'zbrut07' ] := 0
         aPozDek[ 'zbrut22' ] := 0
         aPozDek[ 'zbrut12' ] := 0
         aPozDek[ 'znetto' ] := 0

         nWNetto := 0
         nWVat := 0

         DO CASE
         CASE ( hb_HHasKey( aPoz, 'K_23' ) .AND. aPoz[ 'K_23' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_23' ]
            aPozDek[ 'zsek_cv7' ] := 'WT'
            nWVat := HGetDefault( aPoz, 'K_24', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_25' ) .AND. aPoz[ 'K_25' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_25' ]
            aPozDek[ 'zsek_cv7' ] := 'IT'
            nWVat := HGetDefault( aPoz, 'K_26', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_29' ) .AND. aPoz[ 'K_29' ] <> 0 )
            aPozDek[ 'zue' ] := 'T'
            nWNetto := aPoz[ 'K_29' ]
            aPozDek[ 'zsek_cv7' ] := 'IU'
            nWVat := HGetDefault( aPoz, 'K_30', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_27' ) .AND. aPoz[ 'K_27' ] <> 0 )
            aPozDek[ 'zue' ] := 'N'
            nWNetto := aPoz[ 'K_27' ]
            aPozDek[ 'zsek_cv7' ] := 'IU'
            nWVat := HGetDefault( aPoz, 'K_28', 0 )
         ENDCASE

         IF aPoz[ 'MPP' ]
            aPozDek[ 'zsek_cv7' ] := 'SP'
         ENDIF

         nRodzajVat := VATObliczStawkaRodzaj( nWNetto, nWVat )
         DO CASE
         CASE nRodzajVat == 1 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 1 )
            aPozDek[ 'zwart22' ] := nWNetto
            aPozDek[ 'zvat22' ] := nWVat
            aPozDek[ 'zbrut22' ] := nWNetto + nWVat
         CASE nRodzajVat == 2 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 2 )
            aPozDek[ 'zwart07' ] := nWNetto
            aPozDek[ 'zvat07' ] := nWVat
            aPozDek[ 'zbrut07' ] := nWNetto + nWVat
         CASE nRodzajVat == 3 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 3 )
            aPozDek[ 'zwart02' ] := nWNetto
            aPozDek[ 'zvat02' ] := nWVat
            aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         CASE nRodzajVat == 4 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 4 )
            aPozDek[ 'zwart00' ] := nWNetto
            //aPozDek[ 'zvat02' ] := nWVat
            //aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         ENDCASE
         aPozDek[ 'znetto' ] := nWNetto
         aPozDek[ 'SierTrwaly' ] := .F.
         aPozDek[ 'UwagaVat' ] := nRodzajVat == 0

         aPozDek[ 'VATMarza' ] := 0
         aPozDek[ 'RodzDow' ] := ''

         aPozDek[ 'SprzedazPoz' ] := aPoz

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   AEval( aDane[ 'JPK' ][ 'Zakup' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      IF ( hb_HHasKey( aPoz, 'K_40' ) .AND. aPoz[ 'K_40' ] <> 0 ) .OR. ;
         ( hb_HHasKey( aPoz, 'K_42' ) .AND. aPoz[ 'K_42' ] <> 0 ) .OR. ;
         Month( aPoz[ 'DataZakupu' ] ) == Val( miesiac ) .AND. ;
         Year( aPoz[ 'DataZakupu' ] ) == Val( param_rok )

         aPoz[ 'DataDok' ] := aPoz[ 'DataZakupu' ]

         aPoz[ 'Aktywny' ] := .T.
         aPoz[ 'Importuj' ] := .T.

         aPozDek := hb_Hash()
         aPozDek[ 'zsek_cv7' ] := '  '
         aPozDek[ 'zkolumna' ] := '10'
         aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'DataZakupu' ] ), 2 )
         aPozDek[ 'zdatatran' ] := aPoz[ 'DataZakupu' ]
         aPozDek[ 'znumer' ] := aPoz[ 'DowodZakupu' ]

         cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrDostawcy' ] ) ) == "BRAK", "", aPoz[ 'NrDostawcy' ] ), @cKraj )
         aPozDek[ 'zkraj' ] := iif( AllTrim( cKraj ) == "", "PL", cKraj )
         aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
         aPozDek[ 'znr_ident' ] := cNip
         aPozDek[ 'znazwa' ] := aPoz[ 'NazwaDostawcy' ]
         aPozDek[ 'zadres' ] := ''
         aPozDek[ 'zdatas' ] := aPoz[ 'DataWplywu' ]

         aPozDek[ 'zexport' ] := 'N'
         aPozDek[ 'zkorekta' ] := 'N'

         aPozDek[ 'zwartzw' ] := 0
         aPozDek[ 'zwart00' ] := 0
         aPozDek[ 'zwart07' ] := 0
         aPozDek[ 'zwart02' ] := 0
         aPozDek[ 'zvat02' ] := 0
         aPozDek[ 'zvat07' ] := 0
         aPozDek[ 'zwart22' ] := 0
         aPozDek[ 'zvat22' ] := 0
         aPozDek[ 'zwart12' ] := 0
         aPozDek[ 'zvat12' ] := 0
         aPozDek[ 'zbrut02' ] := 0
         aPozDek[ 'zbrut07' ] := 0
         aPozDek[ 'zbrut22' ] := 0
         aPozDek[ 'zbrut12' ] := 0
         aPozDek[ 'znetto' ] := 0

         lSierTrwaly := .F.
         nWNetto := 0
         nWVat := 0

         DO CASE
         CASE ( hb_HHasKey( aPoz, 'K_40' ) .AND. aPoz[ 'K_40' ] <> 0 )
            lSierTrwaly := .T.
            nWNetto := aPoz[ 'K_40' ]
            nWVat := HGetDefault( aPoz, 'K_41', 0 )
         CASE ( hb_HHasKey( aPoz, 'K_42' ) .AND. aPoz[ 'K_42' ] <> 0 )
            nWNetto := aPoz[ 'K_42' ]
            nWVat := HGetDefault( aPoz, 'K_43', 0 )
         ENDCASE

         nRodzajVat := VATObliczStawkaRodzaj( nWNetto, nWVat )
         DO CASE
         CASE nRodzajVat == 1 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 1 )
            aPozDek[ 'zwart22' ] := nWNetto
            aPozDek[ 'zvat22' ] := nWVat
            aPozDek[ 'zbrut22' ] := nWNetto + nWVat
         CASE nRodzajVat == 2 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 2 )
            aPozDek[ 'zwart07' ] := nWNetto
            aPozDek[ 'zvat07' ] := nWVat
            aPozDek[ 'zbrut07' ] := nWNetto + nWVat
         CASE nRodzajVat == 3 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 3 )
            aPozDek[ 'zwart02' ] := nWNetto
            aPozDek[ 'zvat02' ] := nWVat
            aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         CASE nRodzajVat == 4 .OR. ( nRodzajVat == 0 .AND. aDane[ 'DomVat' ] == 4 )
            aPozDek[ 'zwart00' ] := nWNetto
            //aPozDek[ 'zvat02' ] := nWVat
            //aPozDek[ 'zbrut02' ] := nWNetto + nWVat
         ENDCASE

         IF hb_HHasKey( aPoz, 'K_45' )
            aPozDek[ 'zkorekta' ] := 'T'
            DO CASE
            CASE aDane[ 'DomVat' ] == 1
               aPozDek[ 'zvat22' ] := aPozDek[ 'zvat22' ] + aPoz[ 'K_45' ]
            CASE aDane[ 'DomVat' ] == 2
               aPozDek[ 'zvat07' ] := aPozDek[ 'zvat07' ] + aPoz[ 'K_45' ]
            CASE aDane[ 'DomVat' ] == 3
               aPozDek[ 'zvat02' ] := aPozDek[ 'zvat02' ] + aPoz[ 'K_45' ]
            CASE aDane[ 'DomVat' ] == 4
               aPozDek[ 'zvat00' ] := aPozDek[ 'zvat00' ] + aPoz[ 'K_45' ]
            ENDCASE
            nWNetto := nWNetto + aPoz[ 'K_45' ]
         ENDIF

         aPozDek[ 'znetto' ] := nWNetto

         aPozDek[ 'SierTrwaly' ] := lSierTrwaly
         aPozDek[ 'UwagaVat' ] := nRodzajVat == 0

         aPozDek[ 'VATMarza' ] := HGetDefault( aPoz, 'ZakupVAT_Marza', 0 )
         aPozDek[ 'RodzDow' ] := aPoz[ 'DokumentZakupu' ]

         aPozDek[ 'SprzedazPoz' ] := aPoz

         AAdd( aRes, aPozDek )

      ENDIF
   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatS_CzyImport( aDane, aPoz )

   LOCAL lImport := .F.

   DO CASE
   CASE AScan( { "JPK_VAT", "JPK_V7M", "JPK_V7K" }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0
      lImport := aPoz[ 'SprzedazPoz' ][ 'Importuj' ]
   CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == 'JPK_FA'
      lImport := aPoz[ 'FakturaPoz' ][ 'Importuj' ]
   ENDCASE

   RETURN lImport

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatZ_CzyImport( aDane, aPoz )

   LOCAL lImport := .F.

   lImport := aPoz[ 'SprzedazPoz' ][ 'Importuj' ]

   RETURN lImport

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatS_Importuj( aDane )

   LOCAL nI := 1, nIlosc := JPKImp_VatS_Ilosc( aDane )
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import sprzeda¾y", 48 )

   AEval( aDane[ 'Dekret' ], { | aPoz |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := JPKImp_VatS_CzyImport( aDane, aPoz )

      IF lImportuj

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         IF aDane[ 'DataRej' ] == 'W'
            zDZIEN := aPoz[ 'zdzien' ]
         ELSE
            zDZIEN := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         ENDIF
         znazwa := iif( Upper( AllTrim( aPoz[ 'znazwa' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'znazwa' ], 100 ) )
         zNR_IDENT := iif( Upper( AllTrim( aPoz[ 'znr_ident' ] ) ) == "BRAK", Space( 30 ), PadR( aPoz[ 'znr_ident' ], 30 ) )
         zNUMER := iif( Upper( AllTrim( aPoz[ 'znumer' ] ) ) == "BRAK", Space( 100 ), PadR( JPKImp_NrDokumentu( aPoz[ 'znumer' ] ), 100 ) )
         zADRES := iif( Upper( AllTrim( aPoz[ 'zadres' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'zadres' ], 100 ) )
         zTRESC := Space( 30 )
         zROKS := Str( Year( aPoz[ 'zdatas' ] ), 4 )
         zMCS := Str( Month( aPoz[ 'zdatas' ] ), 2 )
         zDZIENS := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         zDATAS := aPoz[ 'zdatas' ]
         zDATATRAN := aPoz[ 'zdatatran' ]
         zKOLUMNA := aDane[ 'KolRej' ]
         zuwagi := Space( 20 )
         zWARTZW := aPoz[ 'zwartzw' ]
         zWART08 := aPoz[ 'zwart08' ]
         zWART00 := aPoz[ 'zwart00' ]
         zWART02 := aPoz[ 'zwart02' ]
         zVAT02 := aPoz[ 'zvat02' ]
         zWART07 := aPoz[ 'zwart07' ]
         zVAT07 := aPoz[ 'zvat07' ]
         zWART22 := aPoz[ 'zwart22' ]
         zVAT22 := aPoz[ 'zvat22' ]
         zWART12 := 0
         zVAT12 := 0
         zBRUTZW := zWartZw
         zBRUT08 := zWart08
         zBRUT00 := zWart00
         zBRUT02 := zWart02 + zVat02
         zBRUT07 := zWart07 + zVat07
         zBRUT22 := zWart22 + zVat22
         zBRUT12 := zWart12 + zVat12
         zRODZDOW := iif( AllTrim( aPoz[ 'RodzDow' ] ) <> "", aPoz[ 'RodzDow' ], aDane[ 'RodzDow' ] )
         zVATMARZA := HGetDefault( aPoz, 'VATMarza', 0 )
         IF AllTrim( zRODZDOW ) <> "FP"
            IF zVATMARZA > 0
               zNETTO := _round( zVATMARZA - ( zVat02 + zVat07 + zVat22 + zVat12 ), 2 )
            ELSE
               zNETTO := _round( zWARTZW + zWART08 + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
            ENDIF
         ELSE
            zNETTO := 0
         ENDIF
         zExPORT := aPoz[ 'zexport' ]
         IF aPoz[ 'zue' ] == 'T' .AND. aDane[ 'Export' ] == 'T'
            zExPORT := 'T'
         ENDIF
         zUE := aPoz[ 'zue' ]
         zKRAJ := aPoz[ 'zkraj' ]
         zSEK_CV7 := aPoz[ 'zsek_cv7' ]
         zRACH := 'F'
         zDETAL := DETALISTA
         zKOREKTA :=  HGetDefault( aPoz, 'zkorekta', iif( zNETTO < 0, 'T', 'N' ) )
         zROZRZAPS := iif( AllTrim( pzROZRZAPS ) == "", "N", pzROZRZAPS )
         zZAP_TER := 0
         zZAP_DAT := date()
         zZAP_WART := 0
         zTROJSTR := 'N'
         zSYMB_REJ := aDane[ 'Rejestr' ]
         zTRESC := aDane[ 'OpisZd' ]
         zOPCJE := iif( AllTrim( aPoz[ 'Oznaczenie' ] ) <> "", aPoz[ 'Oznaczenie' ], aDane[ 'Oznaczenie' ] )
         zPROCEDUR := iif( AllTrim( aPoz[ 'Procedura' ] ) <> "", aPoz[ 'Procedura' ], aDane[ 'Procedura' ] )
         zKOL36 := 0
         zKOL37 := 0
         zKOL38 := 0
         zKOL39 := 0
         zNETTO2 := 0
         zKOLUMNA2 := '  '
         zDATA_ZAP := CToD('')

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'REJS', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            KRejS_Ksieguj()
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_OperS_Importuj( aDane )

   LOCAL nI := 1, nIlosc := JPKImp_VatS_Ilosc( aDane )
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import sprzeda¾y", 48 )

   AEval( aDane[ 'Dekret' ], { | aPoz |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := JPKImp_VatS_CzyImport( aDane, aPoz )

      IF lImportuj

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         IF aDane[ 'DataRej' ] == 'W'
            zDZIEN := aPoz[ 'zdzien' ]
         ELSE
            zDZIEN := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         ENDIF
         znazwa := iif( Upper( AllTrim( aPoz[ 'znazwa' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'znazwa' ], 100 ) )
         zNR_IDENT := iif( Upper( AllTrim( aPoz[ 'znr_ident' ] ) ) == "BRAK", Space( 30 ), PadR( aPoz[ 'znr_ident' ], 30 ) )
         zNUMER := iif( Upper( AllTrim( aPoz[ 'znumer' ] ) ) == "BRAK", Space( 100 ), PadR( JPKImp_NrDokumentu( aPoz[ 'znumer' ] ), 100 ) )
         zADRES := iif( Upper( AllTrim( aPoz[ 'zadres' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'zadres' ], 100 ) )
         zTRESC := aDane[ 'OpisZd' ]

         zWYR_TOW := 0
         zUSLUGI := 0
         STORE 0 TO zZAKUP, zUBOCZNE, zWYNAGR_G, zWYDATKI, zPUSTA
         zident := 0
         zuwagi := Space( 14 )
         zROZRZAPK := 'N'
         zZAP_TER := 0
         zZAP_DAT := Date()
         zZAP_WART := 0
         zK16WART := 0
         zK16OPIS := Space( 30 )

         zNETTO := _round( aPoz[ 'zwartzw' ] + aPoz[ 'zwart08' ] + aPoz[ 'zwart00' ] + aPoz[ 'zwart02' ] + aPoz[ 'zwart07' ] + aPoz[ 'zwart22' ], 2 )

         DO CASE
         CASE Empty( aDane[ 'KolRej' ] ) .OR. Val( aDane[ 'KolRej' ] ) == 7
            zWYR_TOW := zNETTO
         CASE Val( aDane[ 'KolRej' ] ) == 8
            zUSLUGI := zNETTO
         ENDCASE

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'OPER', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            Oper_Ksieguj()
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatZ_Importuj( aDane )

   LOCAL nI := 1, nIlosc := JPKImp_VatS_Ilosc( aDane )
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Uwagi', 0, 'ListaUwag', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import sprzeda¾y", 48 )

   AEval( aDane[ 'Dekret' ], { | aPoz |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := JPKImp_VatZ_CzyImport( aDane, aPoz )

      IF lImportuj

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         IF aDane[ 'DataRej' ] == 'W'
            zDZIEN := aPoz[ 'zdzien' ]
         ELSE
            zDZIEN := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         ENDIF
         znazwa := iif( Upper( AllTrim( aPoz[ 'znazwa' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'znazwa' ], 100 ) )
         zNR_IDENT := iif( Upper( AllTrim( aPoz[ 'znr_ident' ] ) ) == "BRAK", Space( 30 ), PadR( aPoz[ 'znr_ident' ], 30 ) )
         zNUMER := iif( Upper( AllTrim( aPoz[ 'znumer' ] ) ) == "BRAK", Space( 100 ), PadR( JPKImp_NrDokumentu( aPoz[ 'znumer' ] ), 100 ) )
         zADRES := iif( Upper( AllTrim( aPoz[ 'zadres' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'zadres' ], 100 ) )
         zTRESC := Space( 30 )
         zROKS := Str( Year( aPoz[ 'zdatas' ] ), 4 )
         zMCS := Str( Month( aPoz[ 'zdatas' ] ), 2 )
         zDZIENS := Str( Day( aPoz[ 'zdatas' ] ), 2 )
         zDATAS := aPoz[ 'zdatas' ]
         zDATAKS := zDATAS
         zDATATRAN := aPoz[ 'zdatatran' ]
         zKOLUMNA := '10'
         zuwagi := Space( 20 )
         zWARTZW := aPoz[ 'zwartzw' ]
         zWART00 := aPoz[ 'zwart00' ]
         zWART02 := aPoz[ 'zwart02' ]
         zVAT02 := aPoz[ 'zvat02' ]
         zWART07 := aPoz[ 'zwart07' ]
         zVAT07 := aPoz[ 'zvat07' ]
         zWART22 := aPoz[ 'zwart22' ]
         zVAT22 := aPoz[ 'zvat22' ]
         zWART12 := 0
         zVAT12 := 0
         zBRUTZW := zWartZw
         zBRUT00 := zWart00
         zBRUT02 := zWart02 + zVat02
         zBRUT07 := zWart07 + zVat07
         zBRUT22 := zWart22 + zVat22
         zBRUT12 := zWart12 + zVat12
         zNETTO := _round( zWARTZW + zWART00 + zWART02 + zWART07 + zWART22 + zWART12, 2 )
         zExPORT := aPoz[ 'zexport' ]
         zUE := aPoz[ 'zue' ]
         zKRAJ := aPoz[ 'zkraj' ]
         zSEK_CV7 := aPoz[ 'zsek_cv7' ]
         zRACH := 'F'
         zDETAL := DETALISTA
         zKOREKTA :=  HGetDefault( aPoz, 'zkorekta', iif( zNETTO < 0, 'T', 'N' ) )
         zROZRZAPZ := iif( AllTrim( pzROZRZAPZ ) == "", "N", pzROZRZAPZ )
         zZAP_TER := 0
         zZAP_DAT := date()
         zZAP_WART := 0
         zTROJSTR := 'N'
         zSYMB_REJ := aDane[ 'Rejestr' ]
         zTRESC := aDane[ 'OpisZd' ]
         zUSLUGAUE := 'N'
         zWEWDOS := 'N'
         zPALIWA := 0
         zPOJAZDY := 0
         IF aPoz[ 'SierTrwaly' ]
            zSP22 := 'S'
            zSP12 := 'S'
            zSP07 := 'S'
            zSP02 := 'S'
            zSP00 := 'S'
            zSPZW := 'S'
         ELSE
            zSP22 := 'P'
            zSP12 := 'P'
            zSP07 := 'P'
            zSP02 := 'P'
            zSP00 := 'P'
            zSPZW := 'P'
         ENDIF
         zZOM22 := 'O'
         zZOM00 := 'O'
         zZOM12 := 'O'
         zZOM07 := 'O'
         zZOM02 := 'O'
         zOPCJE := " "

         zKOL47 := 0
         zKOL48 := 0
         zKOL49 := 0
         zKOL50 := 0

         zNETTO2 := 0
         zKOLUMNA2 := '  '

         zRODZDOW := HGetDefault( aPoz, 'RodzDow', '' )
         zVATMARZA := HGetDefault( aPoz, 'VATMarza', 0 )

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'REJZ', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            KRejZ_Ksieguj()
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
            IF aPoz[ 'UwagaVat' ]
               aRaport[ 'Uwagi' ] := aRaport[ 'Uwagi' ] + 1
               AAdd( aRaport[ 'ListaUwag' ], hb_Hash( 'Numer', aPoz[ 'znumer' ], 'Data', aPoz[ 'SprzedazPoz' ][ 'DataDok' ] ) )
            ENDIF
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatS_Ilosc( aDane )

   LOCAL nI := 0

   DO CASE
   CASE AScan( { 'JPK_VAT', 'JPK_V7M', 'JPK_V7K' }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0
      AEval( aDane[ 'Dekret' ], { | aPoz |
         IF aPoz[ 'SprzedazPoz' ][ 'Importuj' ]
            nI++
         ENDIF
      } )

   CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == 'JPK_FA'
      AEval( aDane[ 'Dekret' ], { | aPoz |
         IF aPoz[ 'FakturaPoz' ][ 'Importuj' ]
            nI++
         ENDIF
      } )

   ENDCASE

   RETURN nI

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatZ_Ilosc( aDane )

   LOCAL nI := 0

   AEval( aDane[ 'Dekret' ], { | aPoz |
      IF aPoz[ 'SprzedazPoz' ][ 'Importuj' ]
         nI++
      ENDIF
   } )

   RETURN nI

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatS_Kontrah( aDane )

   LOCAL nI, nJ
   LOCAL cNip
   LOCAL aDaneRegon
   LOCAL cKlucz
   LOCAL aNipy := {}
   LOCAL cEkran
   LOCAL cKolor := ColInf()
   LOCAL aRekord

   SAVE SCREEN TO cEkran
   @ 18, 10 CLEAR TO 20, 69
   @ 18, 10 TO 20, 69
   @ 19, 12 SAY '          ...Pobieranie danych z bazy REGON...'

   DO CASE
   CASE AScan( { 'JPK_VAT', 'JPK_V7M', 'JPK_V7K' }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0
      cKlucz := 'SprzedazPoz'
   CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == 'JPK_FA'
      cKlucz := 'FakturaPoz'
   ENDCASE

   AEval( aDane[ 'Dekret' ], { | aPoz |
      IF aPoz[ cKlucz ][ 'Importuj' ] .AND. Upper( aPoz[ 'zkraj' ] ) == "PL" .AND. ;
         SprawdzNIPSuma( NormalizujNipPL( aPoz[ 'znr_ident' ] ) )
         cNip := NormalizujNipPL( aPoz[ 'znr_ident' ] )
         IF AScan( aNipy, cNip ) == 0
            AAdd( aNipy, cNip )
         ENDIF
      ENDIF
   } )

   IF Len( aNipy ) > 0 .AND. KontrahZnajdzA( aNipy, @aDaneRegon ) > 0

      nI := 1
      DO WHILE nI < Len( aDaneRegon )
         nJ := nI + 1
         DO WHILE nJ <= Len( aDaneRegon )
            IF iif( HB_ISHASH( aDaneRegon[ nI ] ), aDaneRegon[ nI ][ 'nip' ], aDaneRegon[ nI ][ 1 ][ 'nip' ] ) == aDaneRegon[ nJ ][ 'nip' ]
               IF HB_ISHASH( aDaneRegon[ nI ] )
                  aDaneRegon[ nI ] := { aDaneRegon[ nI ] }
               ENDIF
               AAdd( aDaneRegon[ nI ], aDaneRegon[ nJ ] )
               hb_ADel( aDaneRegon, nJ, .T. )
            ELSE
               nJ++
            ENDIF
         ENDDO
         nI++
      ENDDO

      FOR nI := 1 TO Len( aDaneRegon )
         FOR nJ := 1 TO Len( aDane[ 'Dekret' ] )
            IF NormalizujNipPL( aDane[ 'Dekret' ][ nJ ][ 'znr_ident' ] ) == iif( HB_ISHASH( aDaneRegon[ nI ] ), aDaneRegon[ nI ][ 'nip' ], aDaneRegon[ nI ][ 1 ][ 'nip' ] )
               IF HB_ISARRAY( aDaneRegon[ nI ] )
                  aRekord := KontrahentWybierzRegonNip( aDaneRegon[ nI ], hb_Hash( 'nr', aDane[ 'Dekret' ][ nJ ][ 'znumer' ], 'data', DToS( aDane[ 'Dekret' ][ nJ ][ 'zdatas' ] ) ) )
               ELSE
                  aRekord := aDaneRegon[ nI ]
               ENDIF
               //aDane[ 'Dekret' ][ nJ ][ 'znr_ident' ] := aRekord[ 'nip' ]
               aDane[ 'Dekret' ][ nJ ][ 'znazwa' ] := aRekord[ 'nazwa' ]
               aDane[ 'Dekret' ][ nJ ][ 'zadres' ] := aRekord[ 'adres' ]
               aDane[ 'Dekret' ][ nJ ][ 'zkraj' ] := aRekord[ 'kraj' ]
               aDane[ 'Dekret' ][ nJ ][ 'zexport' ] := aRekord[ 'export' ]
            ENDIF
         NEXT
      NEXT
   ENDIF

   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ_Kontrah( aDane )
   LOCAL nI, nJ
   LOCAL aNipy := {}
   LOCAL cNip
   LOCAL aDaneRegon
   LOCAL cEkran
   LOCAL cKolor := ColInf()
   LOCAL aRekord

   SAVE SCREEN TO cEkran
   @ 18, 10 CLEAR TO 20, 69
   @ 18, 10 TO 20, 69
   @ 19, 12 SAY '          ...Pobieranie danych z bazy REGON...'

   AEval( aDane[ 'Dekret' ], { | aPoz |
      IF aPoz[ 'SprzedazPoz' ][ 'Importuj' ] .AND. Upper( aPoz[ 'zkraj' ] ) == "PL" .AND. ;
         SprawdzNIPSuma( NormalizujNipPL( aPoz[ 'znr_ident' ] ) )
         cNip := NormalizujNipPL( aPoz[ 'znr_ident' ] )
         IF AScan( aNipy, cNip ) == 0
            AAdd( aNipy, cNip )
         ENDIF
      ENDIF
   } )

   IF Len( aNipy ) > 0 .AND. KontrahZnajdzA( aNipy, @aDaneRegon ) > 0

      nI := 1
      DO WHILE nI < Len( aDaneRegon )
         nJ := nI + 1
         DO WHILE nJ <= Len( aDaneRegon )
            IF iif( HB_ISHASH( aDaneRegon[ nI ] ), aDaneRegon[ nI ][ 'nip' ], aDaneRegon[ nI ][ 1 ][ 'nip' ] ) == aDaneRegon[ nJ ][ 'nip' ]
               IF HB_ISHASH( aDaneRegon[ nI ] )
                  aDaneRegon[ nI ] := { aDaneRegon[ nI ] }
               ENDIF
               AAdd( aDaneRegon[ nI ], aDaneRegon[ nJ ] )
               hb_ADel( aDaneRegon, nJ, .T. )
            ELSE
               nJ++
            ENDIF
         ENDDO
         nI++
      ENDDO

      FOR nI := 1 TO Len( aDaneRegon )
         FOR nJ := 1 TO Len( aDane[ 'Dekret' ] )
            IF NormalizujNipPL( aDane[ 'Dekret' ][ nJ ][ 'znr_ident' ] ) == iif( HB_ISHASH( aDaneRegon[ nI ] ), aDaneRegon[ nI ][ 'nip' ], aDaneRegon[ nI ][ 1 ][ 'nip' ] )
               IF HB_ISARRAY( aDaneRegon[ nI ] )
                  aRekord := KontrahentWybierzRegonNip( aDaneRegon[ nI ], hb_Hash( 'nr', aDane[ 'Dekret' ][ nJ ][ 'znumer' ], 'data', DToS( aDane[ 'Dekret' ][ nJ ][ 'zdatas' ] ) ) )
               ELSE
                  aRekord := aDaneRegon[ nI ]
               ENDIF
               //aDane[ 'Dekret' ][ nJ ][ 'znr_ident' ] := aRekord[ 'nip' ]
               aDane[ 'Dekret' ][ nJ ][ 'znazwa' ] := aRekord[ 'nazwa' ]
               aDane[ 'Dekret' ][ nJ ][ 'zadres' ] := aRekord[ 'adres' ]
               aDane[ 'Dekret' ][ nJ ][ 'zkraj' ] := aRekord[ 'kraj' ]
               aDane[ 'Dekret' ][ nJ ][ 'zexport' ] := aRekord[ 'export' ]
            ENDIF
         NEXT
      NEXT
   ENDIF

   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN NIL

/*----------------------------------------------------------------------*/

// nCelImportu - 1 - rej VAT, 2 - ksi©ga, 3 - ewidencja

PROCEDURE JPKImp_VatS( nCelImportu )

   LOCAL aDane := hb_Hash( 'ZezwolNaDuplikaty', 'N', 'Rejestr', '  ', ;
      'OpisZd', Space( 30 ), 'KolRej', iif( zRYCZALT == 'T', ' 5', '7' ), ;
      'DataRej', 'W', 'Oznaczenie', Space( 16 ), 'Procedura', Space( 32 ), ;
      'SprawdzRegon', iif( olparam_ra, 'T', 'N' ), 'RodzDow', Space( 6 ), ;
      'Export', 'N' )
   LOCAL cPlik
   LOCAL cKolor
   LOCAL cEkran := SaveScreen()
   LOCAL nMenu, cEkran2
   LOCAL aRaport, cRaport, cTN, cRej, lOk, cKolKs, cDataRej, cRegon, cExport
   LOCAL nSumaImp, nLiczbaLp := 0

   PRIVATE cOpisZd, zOpcje, zProcedur, zRodzDow

   hb_default( @nCelImportu, 1 )

   cKolor := ColInf()
   @ 24, 0 SAY PadC( "Wybierz plik do importu", 80 )
   SetColor( cKolor )

   IF ( cPlik := win_GetOpenFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} } ) ) <> ''

      IF TNEsc( , "Czy weryfikowa† plik przed importem? (T/N)" )
         ColInf()
         @ 24, 0 SAY PadC( "...weryfikacja dokumentu...", 80 )
         nMenu := edekWeryfikuj( cPlik, , .T., "Ignoruj i importuj (niezalecane)", .F. )
         IF nMenu <> 0 .AND. nMenu <> 4
            RestScreen( , , , , cEkran )
            SetColor( cKolor )
            RETURN
         ENDIF
      ENDIF

      ColInf()
      @ 24, 0 SAY PadC( "Wczytywanie danych... Prosz© czeka†...", 80 )
      SetColor( cKolor )

      aDane[ 'JPK' ] := JPKImp_VatS_Wczytaj( cPlik )

      IF HB_ISHASH( aDane[ 'JPK' ] )

         DO CASE
         CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_VAT"

            aDane[ 'Dekret' ] := JPKImp_VatS_Dekretuj_VAT( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_16' ] + ;
               aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_18' ] + ;
               aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_20' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Sprzedaz' ] )

         CASE AScan( { "JPK_V7M", "JPK_V7K" }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0

            aDane[ 'Dekret' ] := JPKImp_VatS_Dekretuj_V7( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_16' ] + ;
               aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_18' ] + ;
               aDane[ 'JPK' ][ 'SprzedazSum' ][ 'K_20' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Sprzedaz' ] )

         CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_FA"
            aDane[ 'Dekret' ] := JPKImp_VatS_Dekretuj_FA( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_1' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_2' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_3' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_4' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_5' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Faktura' ] )

         ENDCASE

         ColStd()
         @ 24,  0
         @  2,  0 CLEAR TO 22, 79
         @  2,  2 TO 19, 77 DOUBLE
         @  4,  3 TO  4, 76
         @ 10,  3 TO 10, 76
         @ 13,  3 TO 13, 76
         @ 17,  3 TO 17, 76

         @  3,  3 SAY PadC( "IMPORT SPRZEDA½Y Z PLIKU JPK", 72 )
         PrintTextEx(  5, 4, "Rodzaj pliku JPK: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] + " (" + aDane[ 'JPK' ][ 'Naglowek' ][ 'WariantFormularza' ] + ")" )
         PrintTextEx(  6, 4, "Data wytworzenia: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DataWytworzeniaJPK' ] )
         PrintTextEx(  7, 4, "         Data od: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataOd' ] ) )
         PrintTextEx(  8, 4, "         Data do: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataDo' ] ) )
         IF hb_HHasKey( aDane[ 'JPK' ][ 'Naglowek' ], 'DomyslnyKodWaluty' )
            PrintTextEx(  9, 4, "      Kod waluty: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DomyslnyKodWaluty' ] )
         ENDIF
         PrintTextEx( 11, 4, "Nazwa firmy: {w+}" + SubStr( sxmlTrim( aDane[ 'JPK' ][ 'Podmiot' ][ 'PelnaNazwa' ] ), 1, 59 ) )
         PrintTextEx( 12, 4, "  NIP firmy: {w+}" + aDane[ 'JPK' ][ 'Podmiot' ][ 'NIP' ] )
         PrintTextEx( 14, 4, "Liczba pozycji sprzeda¾y w pliku JPK: {w+}" + AllTrim( Str( nLiczbaLp ) ) )
         PrintTextEx( 15, 4, "  Suma podatku nale¾nego w pliku JPK: {w+}" + Transform( nSumaImp , RPICE ) )
         PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )

         nMenu := 1
         DO WHILE nMenu != 0
            @ 18,  4 PROMPT "[ Wykonaj import ]"
            @ 18, 26 PROMPT "[ Podgl¥d zawarto˜ci ]"
            @ 18, 52 PROMPT "[ Opcje ]"
            @ 18, 65 PROMPT "[ Anuluj ]"
            MENU TO nMenu

            DO CASE
            CASE nMenu == 1
               IF TNEsc( , "Czy wykona† import danych sprzeda¾y? ( T / N )" )

                  IF aDane[ 'SprawdzRegon' ] == 'T'
                     JPKImp_VatS_Kontrah( @aDane )
                  ENDIF

                  DO CASE
                  CASE nCelImportu == 1
                     aRaport := JPKImp_VatS_Importuj( aDane )
                  CASE nCelImportu == 2
                     aRaport := JPKImp_OperS_Importuj( aDane )
                  CASE nCelImportu == 3
                     //
                  ENDCASE

                  cRaport := "IMPORT ZAKOãCZONY" + hb_eol()
                  cRaport += "-----------------" + hb_eol()
                  cRaport += hb_eol()
                  cRaport += "Liczba zaimportowanych pozycji: " + AllTrim( Str( aRaport[ 'Zaimportowano' ] ) ) + hb_eol()
                  cRaport += "Liczba pomini©tych dokument¢w: " + AllTrim( Str( aRaport[ 'Pominieto' ] ) ) + hb_eol()
                  cRaport += "Liczba dokument¢w w obej walucie: " + AllTrim( Str( aRaport[ 'Waluta' ] ) ) + hb_eol()
                  IF aRaport[ 'Pominieto' ] > 0
                     cRaport += hb_eol()
                     cRaport += "POMINI¨TE DOKUMENTY" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaPom' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Waluta' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY W OBCEJ WALUCIE" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaWal' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF

                  WyswietlTekst( cRaport )

                  nMenu := 0
               ENDIF
            CASE nMenu == 2
               DO CASE
               CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_VAT"
                  IF Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) > 0
                     JPKImp_VatS_Podglad_VAT( aDane[ 'JPK' ][ 'Sprzedaz' ], aDane[ 'JPK' ][ 'SprzedazSum' ] )
                  ELSE
                     Komun( "Brak danych", 15 )
                  ENDIF
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )

               CASE AScan( { "JPK_V7M", "JPK_V7K" }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0
                  IF Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) > 0
                     JPKImp_VatS_Podglad_V7( aDane[ 'JPK' ][ 'Sprzedaz' ], aDane[ 'JPK' ][ 'SprzedazSum' ] )
                  ELSE
                     Komun( "Brak danych", 15 )
                  ENDIF
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )

               CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_FA"
                  IF Len( aDane[ 'JPK' ][ 'Faktura' ] ) > 0
                     JPKImp_VatS_Podglad_FA( aDane[ 'JPK' ][ 'Faktura' ], aDane[ 'JPK' ][ 'FakturaSum' ] )
                  ELSE
                     Komun( "Brak danych", 15 )
                  ENDIF
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )

               ENDCASE
            CASE nMenu == 3
               cEkran2 := SaveScreen()
               cTN := aDane[ 'ZezwolNaDuplikaty' ]
               cRej := aDane[ 'Rejestr' ]
               cOpisZd := aDane[ 'OpisZd' ]
               cKolRej := aDane[ 'KolRej' ]
               cDataRej := aDane[ 'DataRej' ]
               zOpcje := aDane[ 'Oznaczenie' ]
               zProcedur := aDane[ 'Procedura' ]
               cRegon := aDane[ 'SprawdzRegon' ]
               zRodzDow := aDane[ 'RodzDow' ]
               cExport := aDane[ 'Export' ]
               @  6, 13 CLEAR TO 21, 67
               @  7, 15 TO 20, 65
               @  8, 17 SAY "Zezw¢l na import dokument¢w z istniej¥cym nr" GET cTN PICTURE "!" VALID ValidTakNie( cTN, 8, 63 )
               @  9, 17 SAY "Domy˜lny symbol rejestru" GET cRej PICTURE "!!" VALID { || Kat_Rej_Wybierz( @cRej, 9, 42 ), .T. }
               @ 10, 17 SAY "Opis zdarzenia" GET cOpisZd VALID JPKImp_VatS_Tresc_V( iif( nCelImportu == 1, "S", "R" ) )
               IF zRYCZALT == 'T'
                  @ 11, 17 SAY "Domy˜lna kol. ewid. (5,6,7,8,9,10,11,12,13)" GET cKolRej PICTURE '@K 99' VALID AllTrim( cKolRej ) $ '56789' .OR. cKolRej == '10' .OR. cKolRej == '11' .OR. cKolRej == '12' .OR. cKolRej == '13'
               ELSE
                  @ 11, 17 SAY "Domy˜lna kolumna ksi©gi (7,8)" GET cKolRej PICTURE "9" VALID cKolRej $ '78'
               ENDIF
               @ 12, 17 SAY "Do rejestru na dzieä (S-sprzed., W-wystaw.)" GET cDataRej PICTURE "!" VALID cDataRej $ 'SW'
               @ 13, 17 SAY "Oznaczenie dot. dostawy i ˜wiadczenia usˆug" GET zOpcje PICTURE '!!' WHEN nCelImportu == 1 .AND. KRejSWhOpcje() VALID KRejSVaOpcje()
               @ 14, 17 SAY "Oznaczenia dot. procedur" GET zProcedur PICTURE '!!!!!!!!!!!!!!!' WHEN nCelImportu == 1 .AND. KRejSWhProcedur() VALID KRejSVaProcedur()
               @ 15, 17 SAY "Rodzaj dowodu sprzeda¾y" GET zRodzDow PICTURE '!!!' WHEN nCelImportu == 1 .AND. KRejSWRodzDow() VALID KRejSVRodzDow()
               @ 16, 17 SAY "Pobieraj dane kontrahenta z bazy REGON" GET cRegon PICTURE '!' WHEN olparam_ra VALID ValidTakNie( cRegon, 16, 57 )
               @ 17, 17 SAY "Oznacz kraje UE jako eksport" GET cExport PICTURE '!' VALID ValidTakNie( cExport, 17, 47 )
               @ 19, 52 GET lOk PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
               ValidTakNie( cTN, 8, 63 )
               ValidTakNie( cRegon, 16, 57 )
               ValidTakNie( cExport, 17, 47 )
               READ
               IF LastKey() <> K_ESC
                  aDane[ 'ZezwolNaDuplikaty' ] := cTN
                  aDane[ 'Rejestr' ] := cRej
                  aDane[ 'OpisZd' ] := cOpisZd
                  aDane[ 'KolRej' ] := cKolRej
                  aDane[ 'DataRej' ] := cDataRej
                  aDane[ 'Oznaczenie' ] := zOpcje
                  aDane[ 'Procedura' ] := zProcedur
                  aDane[ 'SprawdzRegon' ] := cRegon
                  aDane[ 'RodzDow' ] := zRodzDow
                  aDane[ 'Export' ] := cExport
               ENDIF
               RestScreen( , , , , cEkran2 )
            CASE nMenu == 4
               nMenu := 0
            ENDCASE

         ENDDO

      ENDIF

   ENDIF

   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_VatS_Tresc_V( cKatalog )

   LOCAL cKolorTemp
   LOCAL cTablica

   hb_default( @cKatalog, 'S' )

   IF cKatalog == 'Z'
      cTablica := 'rejz'
   ELSEIF cKatalog == 'S'
      cTablica := 'rejs'
   ELSEIF cKatalog == 'R'
      cTablica := 'oper'
   ENDIF

   IF LastKey() == K_UP
      RETURN .T.
   ENDIF
   IF Empty( cOpisZd )
      SELECT tresc
      SEEK '+' + ident_fir
      IF ! Found()
         SELECT (cTablica)
      ELSE
         SAVE SCREEN TO scr2
         Tresc_( cKatalog )
         RESTORE SCREEN FROM scr2
         SELECT (cTablica)
         IF LastKey() == K_ESC
            RETURN .T.
         ENDIF
         cOpisZd := Left( tresc->tresc, 30 )
         cKolorTemp := SetColor()
         SET COLOR TO i
         @ 10, 33 SAY cOpisZd
         SetColor( cKolorTemp )
      ENDIF
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_VatZ()

   LOCAL aDane := hb_Hash( 'ZezwolNaDuplikaty', 'N', 'Rejestr', '  ', ;
      'OpisZd', Space( 30 ), 'DomVat', 1, 'DataRej', 'W', ;
      'SprawdzRegon', iif( olparam_ra, 'T', 'N' ) )
   LOCAL cPlik
   LOCAL cKolor
   LOCAL cEkran := SaveScreen()
   LOCAL nMenu, cEkran2, nMenu2
   LOCAL aRaport, cRaport, cTN, cRej, lOk, nDomVat, cDataRej, cRegon
   LOCAL nSumaImp, nLiczbaLp := 0

   PRIVATE cOpisZd

   cKolor := ColInf()
   @ 24, 0 SAY PadC( "Wybierz plik do importu", 80 )
   SetColor( cKolor )

   IF ( cPlik := win_GetOpenFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} } ) ) <> ''

      IF TNEsc( , "Czy weryfikowa† plik przed importem? (T/N)" )
         ColInf()
         @ 24, 0 SAY PadC( "...weryfikacja dokumentu...", 80 )
         nMenu := edekWeryfikuj( cPlik, , .T., "Ignoruj i importuj (niezalecane)", .F. )
         IF nMenu <> 0 .AND. nMenu <> 4
            RestScreen( , , , , cEkran )
            SetColor( cKolor )
            RETURN
         END
      ENDIF

      ColInf()
      @ 24, 0 SAY PadC( "Wczytywanie danych... Prosz© czeka†...", 80 )
      SetColor( cKolor )

      aDane[ 'JPK' ] := JPKImp_VatS_Wczytaj( cPlik, .T. )

      IF HB_ISHASH( aDane[ 'JPK' ] )

         DO CASE
         CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_VAT"

            aDane[ 'Dekret' ] := JPKImp_VatZ_Dekretuj_VAT( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'ZakupSum' ][ 'K_44' ] + ;
               aDane[ 'JPK' ][ 'ZakupSum' ][ 'K_46' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) + Len( aDane[ 'JPK' ][ 'Zakup' ] )

         CASE AScan( { "JPK_V7M", "JPK_V7K" }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0

            aDane[ 'Dekret' ] := JPKImp_VatZ_Dekretuj_V7( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'ZakupSum' ][ 'K_41' ] + ;
               aDane[ 'JPK' ][ 'ZakupSum' ][ 'K_43' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) + Len( aDane[ 'JPK' ][ 'Zakup' ] )

         CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_FA"

            aDane[ 'Dekret' ] := JPKImp_VatZ_Dekretuj_FA( aDane )
            nSumaImp := aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_1' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_2' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_3' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_4' ] + ;
               aDane[ 'JPK' ][ 'FakturaSum' ][ 'P_14_5' ]
            nLiczbaLp := Len( aDane[ 'JPK' ][ 'Faktura' ] )
         ENDCASE

         ColStd()
         @ 24,  0
         @  2,  0 CLEAR TO 22, 79
         @  2,  2 TO 19, 77 DOUBLE
         @  4,  3 TO  4, 76
         @ 10,  3 TO 10, 76
         @ 13,  3 TO 13, 76
         @ 17,  3 TO 17, 76

         @  3,  3 SAY PadC( "IMPORT ZAKUPàW Z PLIKU JPK", 72 )
         PrintTextEx(  5, 4, "Rodzaj pliku JPK: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] + " (" + aDane[ 'JPK' ][ 'Naglowek' ][ 'WariantFormularza' ] + ")" )
         PrintTextEx(  6, 4, "Data wytworzenia: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DataWytworzeniaJPK' ] )
         PrintTextEx(  7, 4, "         Data od: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataOd' ] ) )
         PrintTextEx(  8, 4, "         Data do: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataDo' ] ) )
         IF hb_HHasKey( aDane[ 'JPK' ][ 'Naglowek' ], 'DomyslnyKodWaluty' )
            PrintTextEx(  9, 4, "      Kod waluty: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DomyslnyKodWaluty' ] )
         ENDIF
         PrintTextEx( 11, 4, "Nazwa firmy: {w+}" + SubStr( sxmlTrim( aDane[ 'JPK' ][ 'Podmiot' ][ 'PelnaNazwa' ] ), 1, 59 ) )
         PrintTextEx( 12, 4, "  NIP firmy: {w+}" + aDane[ 'JPK' ][ 'Podmiot' ][ 'NIP' ] )
         PrintTextEx( 14, 4, "  Liczba pozycji zakup¢w w pliku JPK: {w+}" + AllTrim( Str( nLiczbaLp ) ) )
         PrintTextEx( 15, 4, "Suma podatku naliczonego w pliku JPK: {w+}" + Transform( nSumaImp , RPICE ) )
         PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatZ_Ilosc( aDane ) ) ), 72 ) )

         nMenu := 1
         DO WHILE nMenu != 0
            @ 18,  4 PROMPT "[ Wykonaj import ]"
            @ 18, 26 PROMPT "[ Podgl¥d zawarto˜ci ]"
            @ 18, 52 PROMPT "[ Opcje ]"
            @ 18, 65 PROMPT "[ Anuluj ]"
            MENU TO nMenu

            DO CASE
            CASE nMenu == 1
               IF TNEsc( , "Czy wykona† import danych zakup¢w? ( T / N )" )

                  IF aDane[ 'SprawdzRegon' ] == 'T'
                     JPKImp_VatZ_Kontrah( @aDane )
                  ENDIF

                  aRaport := JPKImp_VatZ_Importuj( aDane )

                  cRaport := "IMPORT ZAKOãCZONY" + hb_eol()
                  cRaport += "-----------------" + hb_eol()
                  cRaport += hb_eol()
                  cRaport += "Liczba zaimportowanych pozycji: " + AllTrim( Str( aRaport[ 'Zaimportowano' ] ) ) + hb_eol()
                  cRaport += "Liczba pomini©tych dokument¢w: " + AllTrim( Str( aRaport[ 'Pominieto' ] ) ) + hb_eol()
                  cRaport += "Liczba dokument¢w w obej walucie: " + AllTrim( Str( aRaport[ 'Waluta' ] ) ) + hb_eol()
                  cRaport += "Liczba uwag: " + AllTrim( Str( aRaport[ 'Uwagi' ] ) ) + hb_eol()
                  IF aRaport[ 'Uwagi' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY Z NIEROZPOZNAN¤ STAWK¤ VAT" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaUwag' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Numer' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Data' ] ) + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Pominieto' ] > 0
                     cRaport += hb_eol()
                     cRaport += "POMINI¨TE DOKUMENTY" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaPom' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Waluta' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY W OBCEJ WALUCIE" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaWal' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'znumer' ] ) + hb_eol()
                        cRaport += "Nr ident.: " + AllTrim( aPoz[ 'Importowany' ][ 'znr_ident' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'znazwa' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'zdatas' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF

                  WyswietlTekst( cRaport )

                  nMenu := 0
               ENDIF
            CASE nMenu == 2
               DO CASE
               CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_VAT"
                  nMenu2 := MenuEx( 18, 26, { "SprzedazPoz (podatek nale¾ny)", "ZakupPoz (podatek naliczony)" } )
                  SWITCH nMenu2
                  CASE 1
                     IF Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) > 0
                        JPKImp_VatS_Podglad_VAT( aDane[ 'JPK' ][ 'Sprzedaz' ], aDane[ 'JPK' ][ 'SprzedazSum' ] )
                     ELSE
                        Komun( "Brak danych", 15 )
                     ENDIF
                     EXIT
                  CASE 2
                     IF Len( aDane[ 'JPK' ][ 'Zakup' ] ) > 0
                        JPKImp_VatZ_Podglad_VAT( aDane[ 'JPK' ][ 'Zakup' ], aDane[ 'JPK' ][ 'ZakupSum' ] )
                     ELSE
                        Komun( "Brak danych", 15 )
                     ENDIF
                     EXIT
                  ENDSWITCH
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )
               CASE AScan( { "JPK_V7M", "JPK_V7K" }, aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] ) > 0
                  nMenu2 := MenuEx( 18, 26, { "SprzedazPoz (podatek nale¾ny)", "ZakupPoz (podatek naliczony)" } )
                  SWITCH nMenu2
                  CASE 1
                     IF Len( aDane[ 'JPK' ][ 'Sprzedaz' ] ) > 0
                        JPKImp_VatS_Podglad_V7( aDane[ 'JPK' ][ 'Sprzedaz' ], aDane[ 'JPK' ][ 'SprzedazSum' ] )
                     ELSE
                        Komun( "Brak danych", 15 )
                     ENDIF
                     EXIT
                  CASE 2
                     IF Len( aDane[ 'JPK' ][ 'Zakup' ] ) > 0
                        JPKImp_VatZ_Podglad_V7( aDane[ 'JPK' ][ 'Zakup' ], aDane[ 'JPK' ][ 'ZakupSum' ] )
                     ELSE
                        Komun( "Brak danych", 15 )
                     ENDIF
                     EXIT
                  ENDSWITCH
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )
               CASE aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] == "JPK_FA"
                  IF Len( aDane[ 'JPK' ][ 'Faktura' ] ) > 0
                     JPKImp_VatS_Podglad_FA( aDane[ 'JPK' ][ 'Faktura' ], aDane[ 'JPK' ][ 'FakturaSum' ] )
                  ELSE
                     Komun( "Brak danych", 15 )
                  ENDIF
                  PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )
               ENDCASE
            CASE nMenu == 3
               cEkran2 := SaveScreen()
               cTN := aDane[ 'ZezwolNaDuplikaty' ]
               cRej := aDane[ 'Rejestr' ]
               cOpisZd := aDane[ 'OpisZd' ]
               nDomVat := aDane[ 'DomVat' ]
               cDataRej := aDane[ 'DataRej' ]
               cRegon := aDane[ 'SprawdzRegon' ]
               @  9, 13 CLEAR TO 20, 66
               @ 10, 15 TO 19, 64
               @ 11, 17 SAY "Zezw¢l na import dokument¢w z istniej¥cym nr" GET cTN PICTURE "!" VALID cTN$"TN"
               @ 12, 17 SAY "Domy˜lny symbol rejestru" GET cRej PICTURE "!!" VALID { || Kat_Rej_Wybierz( @cRej, 12, 42, 'Z' ), .T. }
               @ 13, 17 SAY "Opis zdarzenia" GET cOpisZd VALID JPKImp_VatS_Tresc_V( "Z" )
               @ 14, 17 SAY "Domy˜lna stawka VAT"
               @ 14, 37, 20, 41 GET nDomVat LISTBOX { { "23%", 1 }, { "8% ", 2 }, { "5% ", 3 }, { "0% ", 4 } } DROPDOWN
               @ 15, 17 SAY "Do rejestru na dzieä (Z-zakupu, W-wystaw.)" GET cDataRej VALID cDataRej $ "WZ"
               @ 16, 17 SAY "Pobieraj dane kontrahenta z bazy REGON" GET cRegon PICTURE '!' WHEN olparam_ra VALID cRegon $ 'TN'
               @ 18, 52 GET lOk PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
               READ
               IF LastKey() <> K_ESC
                  aDane[ 'ZezwolNaDuplikaty' ] := cTN
                  aDane[ 'Rejestr' ] := cRej
                  aDane[ 'OpisZd' ] := cOpisZd
                  aDane[ 'DomVat' ] := nDomVat
                  aDane[ 'DataRej' ] := cDataRej
                  aDane[ 'SprawdzRegon' ] := cRegon
               ENDIF
               RestScreen( , , , , cEkran2 )
            CASE nMenu == 4
               nMenu := 0
            ENDCASE

         ENDDO

      ENDIF

   ENDIF

   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION VATObliczStawkaProcent( nNetto, nVAT )

   RETURN Int( ( nVAT / nNetto ) * 100 )

/*----------------------------------------------------------------------*/
/*
Zwraca
1 - 22 %
2 -  8 %
3 -  5 %
4 -  0 %
*/
FUNCTION VATObliczStawkaRodzaj( nNetto, nVAT )

   LOCAL nProc := VATObliczStawkaProcent( nNetto, nVAT )
   LOCAL nRodzaj := 0

   DO CASE
   CASE nProc == 0
      nRodzaj := 4
   CASE nProc >= 4 .AND. nProc <= 6
      nRodzaj := 3
   CASE nProc >= 7 .AND. nProc <= 9
      nRodzaj := 2
   CASE nProc >= 21 .AND. nProc <= 23
      nRodzaj := 1
   ENDCASE

   RETURN nRodzaj

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_PKPIR()

   LOCAL aDane := hb_Hash( 'ZezwolNaDuplikaty', 'N', 'OpisZd', Space( 30 ) )
   LOCAL cPlik
   LOCAL cKolor
   LOCAL cEkran := SaveScreen()
   LOCAL nMenu, cEkran2
   LOCAL aRaport, cRaport, cTN, lOk
   LOCAL nSumaImp, nLiczbaLp := 0

   PRIVATE cOpisZd

   cKolor := ColInf()
   @ 24, 0 SAY PadC( "Wybierz plik do importu", 80 )
   SetColor( cKolor )

   IF ( cPlik := win_GetOpenFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} } ) ) <> ''

      IF TNEsc( , "Czy weryfikowa† plik przed importem? (T/N)" )
         ColInf()
         @ 24, 0 SAY PadC( "...weryfikacja dokumentu...", 80 )
         nMenu := edekWeryfikuj( cPlik, , .T., "Ignoruj i importuj (niezalecane)", .F. )
         IF nMenu <> 0 .AND. nMenu <> 4
            RestScreen( , , , , cEkran )
            SetColor( cKolor )
            RETURN
         ENDIF
      ENDIF

      ColInf()
      @ 24, 0 SAY PadC( "Wczytywanie danych... Prosz© czeka†...", 80 )
      SetColor( cKolor )

      aDane[ 'JPK' ] := JPKImp_PKPIR_Wczytaj( cPlik )

      IF HB_ISHASH( aDane[ 'JPK' ] )

         nLiczbaLp := Len( aDane[ 'JPK' ][ 'Wiersze' ] )

         ColStd()
         @ 24,  0
         @  2,  0 CLEAR TO 22, 79
         @  2,  2 TO 19, 77 DOUBLE
         @  4,  3 TO  4, 76
         @ 10,  3 TO 10, 76
         @ 13,  3 TO 13, 76
         @ 17,  3 TO 17, 76

         @  3,  3 SAY PadC( "IMPORT SPRZEDA½Y Z PLIKU JPK", 72 )
         PrintTextEx(  5, 4, "Rodzaj pliku JPK: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'KodFormularza' ] + " (" + aDane[ 'JPK' ][ 'Naglowek' ][ 'WariantFormularza' ] + ")" )
         PrintTextEx(  6, 4, "Data wytworzenia: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DataWytworzeniaJPK' ] )
         PrintTextEx(  7, 4, "         Data od: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataOd' ] ) )
         PrintTextEx(  8, 4, "         Data do: {w+}" + DToC( aDane[ 'JPK' ][ 'Naglowek' ][ 'DataDo' ] ) )
         IF hb_HHasKey( aDane[ 'JPK' ][ 'Naglowek' ], 'DomyslnyKodWaluty' )
            PrintTextEx(  9, 4, "      Kod waluty: {w+}" + aDane[ 'JPK' ][ 'Naglowek' ][ 'DomyslnyKodWaluty' ] )
         ENDIF
         PrintTextEx( 11, 4, "Nazwa firmy: {w+}" + SubStr( sxmlTrim( aDane[ 'JPK' ][ 'Podmiot' ][ 'PelnaNazwa' ] ), 1, 59 ) )
         PrintTextEx( 12, 4, "  NIP firmy: {w+}" + aDane[ 'JPK' ][ 'Podmiot' ][ 'NIP' ] )
         PrintTextEx( 14, 4, "Liczba pozycji w pliku JPK: {w+}" + AllTrim( Str( nLiczbaLp ) ) )
         PrintTextEx( 15, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( JPKImp_VatS_Ilosc( aDane ) ) ), 72 ) )

         nMenu := 1
         DO WHILE nMenu != 0
            @ 18,  4 PROMPT "[ Wykonaj import ]"
            @ 18, 26 PROMPT "[ Podgl¥d zawarto˜ci ]"
            @ 18, 52 PROMPT "[ Opcje ]"
            @ 18, 65 PROMPT "[ Anuluj ]"
            MENU TO nMenu

            DO CASE
            CASE nMenu == 1
               IF TNEsc( , "Czy wykona† import danych sprzeda¾y? ( T / N )" )

                  aRaport := JPKImp_PKPIR_Importuj( aDane )

                  cRaport := "IMPORT ZAKOãCZONY" + hb_eol()
                  cRaport += "-----------------" + hb_eol()
                  cRaport += hb_eol()
                  cRaport += "Liczba zaimportowanych pozycji: " + AllTrim( Str( aRaport[ 'Zaimportowano' ] ) ) + hb_eol()
                  cRaport += "Liczba pomini©tych dokument¢w: " + AllTrim( Str( aRaport[ 'Pominieto' ] ) ) + hb_eol()
                  cRaport += "Liczba dokument¢w w obej walucie: " + AllTrim( Str( aRaport[ 'Waluta' ] ) ) + hb_eol()
                  IF aRaport[ 'Pominieto' ] > 0
                     cRaport += hb_eol()
                     cRaport += "POMINI¨TE DOKUMENTY" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaPom' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'K_3' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'K_4' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'K_2' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF
                  IF aRaport[ 'Waluta' ] > 0
                     cRaport += hb_eol()
                     cRaport += "DOKUMENTY W OBCEJ WALUCIE" + hb_eol()
                     cRaport += "-------------------" + hb_eol()
                     AEval( aRaport[ 'ListaWal' ], { | aPoz |
                        cRaport += "Nr dokumentu: " + AllTrim( aPoz[ 'Importowany' ][ 'K_3' ] ) + hb_eol()
                        cRaport += "Kontrahent: " + AllTrim( aPoz[ 'Importowany' ][ 'K_4' ] ) + hb_eol()
                        cRaport += "Data wystawienia: " + DToC( aPoz[ 'Importowany' ][ 'K_2' ] ) + hb_eol()
                        cRaport += "Przyczyna: " + aPoz[ 'Przyczyna' ] + hb_eol()
                        cRaport += "--------------------------" + hb_eol()
                     } )
                  ENDIF

                  WyswietlTekst( cRaport )

                  nMenu := 0
               ENDIF
            CASE nMenu == 2
               JPKImp_PKPIR_Podglad( aDane[ 'JPK' ][ 'Wiersze' ], aDane[ 'JPK' ][ 'WierszeSum' ] )
               PrintTextEx( 16, 4, PadR( "Liczba importowanych pozycji: {w+}" + AllTrim( Str( Len( aDane[ 'JPK' ][ 'Wiersze' ] ) ) ), 72 ) )
            CASE nMenu == 3
               cEkran2 := SaveScreen()
               cTN := aDane[ 'ZezwolNaDuplikaty' ]
               cOpisZd := aDane[ 'OpisZd' ]
               @  6, 13 CLEAR TO 13, 66
               @  7, 15 TO 12, 64
               @  8, 17 SAY "Zezw¢l na import dokument¢w z istniej¥cym nr" GET cTN PICTURE "!" VALID cTN$"TN"
               @  9, 17 SAY "Opis zdarzenia" GET cOpisZd VALID JPKImp_VatS_Tresc_V( "R" )
               @ 11, 52 GET lOk PUSHBUTTON CAPTION ' Zamknij ' STATE { || ReadKill( .T. ) }
               READ
               IF LastKey() <> K_ESC
                  aDane[ 'ZezwolNaDuplikaty' ] := cTN
                  aDane[ 'OpisZd' ] := cOpisZd
               ENDIF
               RestScreen( , , , , cEkran2 )
            CASE nMenu == 4
               nMenu := 0
            ENDCASE

         ENDDO

      ENDIF

   ENDIF

   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_PKPIR_Wczytaj( cPlikJpk )

   LOCAL oDoc, cAktKlucz
   LOCAL xRes := .F.
   LOCAL aDaneJPK := hb_Hash()
   LOCAL aWeryf, aWiersz
   LOCAL oWiersz, oWierszIter, oWartosc, oWartoscIter
   LOCAL aFirma, lDaneDostepne := .F.

   IF File( cPlikJpk )

      oDoc := TXMLDocument():New( cPlikJpk )

      IF oDoc:nError == HBXML_ERROR_NONE

         aDaneJPK[ 'Naglowek' ] := JPKImp_WczytajNagl( oDoc )
         aDaneJPK[ 'Podmiot' ] := JPKImp_WczytajPodm( oDoc )

         aFirma := PobierzFirme( Val( ident_fir ) )
         aDaneJPK[ 'Firma' ] := aFirma
         aWeryf := JPKImp_Weryf( @aDaneJPK, TrimNip( aFirma[ 'firma' ][ 'nip' ] ), Val( param_rok ), Val( miesiac ), 4 )

         IF aWeryf[ 'OK' ]

            aDaneJPK[ 'Wiersze' ] := {}

            oWierszIter := TXMLIteratorRegex():New( oDoc:oRoot )

            oWiersz := oWierszIter:Find( '(([\w]*:)PKPIRWiersz|(^PKPIRWiersz))' )
            DO WHILE ( oWiersz != NIL )
               oWartoscIter := TXMLIterator():New( oWiersz )
               aWiersz := hb_Hash()
               DO WHILE ( oWartosc := oWartoscIter:Next() ) != NIL
                  cAktKlucz := oWartosc:cName
                  IF ! Empty( oWartosc:oChild ) .AND. HB_ISNIL( oWartosc:oChild:cName )
                     oWartosc := oWartoscIter:Next()
                  ENDIF
                  aWiersz[ xmlUsunNamespace( cAktKlucz ) ] := sxml2str( oWartosc:cData )
               ENDDO
               AAdd( aDaneJPK[ 'Wiersze' ], aWiersz )

               oWiersz := oWierszIter:Next()
            ENDDO

            aDaneJPK[ 'WierszeSum' ] := hb_Hash( 'Ilosc', 0, 'K_7', 0, 'K_8', 0, 'K_9', 0, ;
               'K_10', 0, 'K_11', 0, 'K_12', 0, 'K_13', 0, 'K_14', 0, 'K_15', 0, 'K_16B', 0 )

            IF Len( aDaneJPK[ 'Wiersze' ] ) > 0

               AEval( aDaneJPK[ 'Wiersze' ], { | aW |
                  aW[ 'Aktywny' ] := .T.
                  aW[ 'Importuj' ] := .T.
                  aW[ 'K_1' ] := sxmlTrim( aW[ 'K_1' ] )
                  aW[ 'K_2' ] := sxml2date( aW[ 'K_2' ] )
                  aW[ 'K_3' ] := sxmlTrim( aW[ 'K_3' ] )
                  aW[ 'K_4' ] := sxmlTrim( aW[ 'K_4' ] )
                  aW[ 'K_5' ] := sxmlTrim( aW[ 'K_5' ] )
                  aW[ 'K_6' ] := sxmlTrim( aW[ 'K_6' ] )
                  IF hb_HHasKey( aW, 'K_7' ) .AND. HB_ISCHAR( aW[ 'K_7' ] )
                     aW[ 'K_7' ] := sxml2num( aW[ 'K_7' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_7' ] += aW[ 'K_7' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_8' ) .AND. HB_ISCHAR( aW[ 'K_8' ] )
                     aW[ 'K_8' ] := sxml2num( aW[ 'K_8' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_8' ] += aW[ 'K_8' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_9' ) .AND. HB_ISCHAR( aW[ 'K_9' ] )
                     aW[ 'K_9' ] := sxml2num( aW[ 'K_9' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_9' ] += aW[ 'K_9' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_10' ) .AND. HB_ISCHAR( aW[ 'K_10' ] )
                     aW[ 'K_10' ] := sxml2num( aW[ 'K_10' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_10' ] += aW[ 'K_10' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_11' ) .AND. HB_ISCHAR( aW[ 'K_11' ] )
                     aW[ 'K_11' ] := sxml2num( aW[ 'K_11' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_11' ] += aW[ 'K_11' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_12' ) .AND. HB_ISCHAR( aW[ 'K_12' ] )
                     aW[ 'K_12' ] := sxml2num( aW[ 'K_12' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_12' ] += aW[ 'K_12' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_13' ) .AND. HB_ISCHAR( aW[ 'K_13' ] )
                     aW[ 'K_13' ] := sxml2num( aW[ 'K_13' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_13' ] += aW[ 'K_13' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_14' ) .AND. HB_ISCHAR( aW[ 'K_14' ] )
                     aW[ 'K_14' ] := sxml2num( aW[ 'K_14' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_14' ] += aW[ 'K_14' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_15' ) .AND. HB_ISCHAR( aW[ 'K_15' ] )
                     aW[ 'K_15' ] := sxml2num( aW[ 'K_15' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_15' ] += aW[ 'K_15' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_16B' ) .AND. HB_ISCHAR( aW[ 'K_16B' ] )
                     aW[ 'K_16B' ] := sxml2num( aW[ 'K_16B' ], 0 )
                     aDaneJPK[ 'WierszeSum' ][ 'K_16B' ] += aW[ 'K_16B' ]
                  ENDIF
                  IF hb_HHasKey( aW, 'K_16A' ) .AND. HB_ISCHAR( aW[ 'K_16A' ] )
                     aW[ 'K_16A' ] := sxmlTrim( aW[ 'K_16A' ] )
                  ENDIF
                  IF hb_HHasKey( aW, 'K_17' ) .AND. HB_ISCHAR( aW[ 'K_17' ] )
                     aW[ 'K_17' ] := sxmlTrim( aW[ 'K_17' ] )
                  ENDIF
               } )

               xRes := aDaneJPK

            ELSE
               Komun( 'Deklaracja nie zawiera pozycji' )
            ENDIF
         ELSE
            Komun( aWeryf[ 'Komunikat' ] )
         ENDIF
      ELSE
         Komun( 'Wyst¥piˆ bˆ¥d podczas otwierania pliku JPK. Nr bˆ©du: ' + AllTrim( Str( oDoc:nError ) ) )
      ENDIF
   ELSE
      Komun( 'Brak pliku wej˜ciowego' )
   ENDIF

   RETURN xRes

/*----------------------------------------------------------------------*/

FUNCTION JPKImp_PKPIR_Importuj( aDane )

   LOCAL nI := 1, nIlosc := 0
   LOCAL aRaport := hb_Hash( 'Zaimportowano', 0, 'Pominieto', 0, 'ListaPom', {}, 'Waluta', 0, 'ListaWal', {} )

   @ 11, 15 CLEAR TO 15, 64
   @ 11, 15 TO 15, 64 DOUBLE
   @ 12, 16 SAY PadC( "Import sprzeda¾y", 48 )

   AEval( aDane[ 'JPK' ][ 'Wiersze' ], { | aPoz |
      IF aPoz[ 'Importuj' ]
         nIlosc++
      ENDIF
   } )

   AEval( aDane[ 'JPK' ][ 'Wiersze' ], { | aPoz |

      LOCAL aIstniejacyRec
      LOCAL lImportuj := aPoz[ 'Importuj' ]

      IF lImportuj

         @ 13, 16 SAY PadC( AllTrim( Str( nI ) ) + " / " + AllTrim( Str( nIlosc ) ), 48 )
         @ 14, 17 SAY ProgressBar( nI, nIlosc, 46 )
         ins := .T.

         zDZIEN := Str( Day( aPoz[ 'K_2' ] ) )
         znazwa := iif( Upper( AllTrim( aPoz[ 'K_4' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'K_4' ], 100 ) )
         zNR_IDENT := Space( 30 )
         zNUMER := iif( Upper( AllTrim( aPoz[ 'K_3' ] ) ) == "BRAK", Space( 100 ), PadR( JPKImp_NrDokumentu( aPoz[ 'K_3' ] ), 100 ) )
         zADRES := iif( Upper( AllTrim( aPoz[ 'K_5' ] ) ) == "BRAK", Space( 100 ), PadR( aPoz[ 'K_5' ], 100 ) )
         zTRESC := aDane[ 'OpisZd' ]

         zWYR_TOW := aPoz[ 'K_7' ]
         zUSLUGI := aPoz[ 'K_8' ]
         zZAKUP := aPoz[ 'K_10' ]
         zUBOCZNE := aPoz[ 'K_11' ]
         zWYNAGR_G := aPoz[ 'K_12' ]
         zWYDATKI := aPoz[ 'K_13' ]
         zPUSTA := aPoz[ 'K_15' ]
         zident := 0
         zuwagi := HGetDefault( aPoz, 'K_17', Space( 14 ) )
         zROZRZAPK := 'N'
         zZAP_TER := 0
         zZAP_DAT := Date()
         zZAP_WART := 0
         zK16WART := HGetDefault( aPoz, 'K_16B', 0 )
         zK16OPIS := HGetDefault( aPoz, 'K_16A', Space( 30 ) )

         IF aDane[ 'ZezwolNaDuplikaty' ] == 'N' .AND. EwidSprawdzNrDokRec( 'OPER', ident_fir, miesiac, znumer, @aIstniejacyRec )
            aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
            AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Istnieje ju¾ dokument o tym numerze' ) )
         ELSE
            Oper_Ksieguj()
            IF HGetDefault( aPoz, 'KodWaluty', 'PLN' ) <> 'PLN'
               aRaport[ 'Waluta' ] := aRaport[ 'Waluta' ] + 1
               AAdd( aRaport[ 'ListaWal' ], hb_Hash( 'Importowany', aPoz, 'Przyczyna', 'Dokument w obcej walucie (' + aPoz[ 'KodWaluty' ] + ')' ) )
            ENDIF
            aRaport[ 'Zaimportowano' ] := aRaport[ 'Zaimportowano' ] + 1
         ENDIF

         nI++
      ELSE
         aRaport[ 'Pominieto' ] := aRaport[ 'Pominieto' ] + 1
         AAdd( aRaport[ 'ListaPom' ], hb_Hash( 'Istniejacy', aIstniejacyRec, 'Importowany', aPoz, 'Przyczyna', 'Dokument nie zostaˆ zaznaczony do importu' ) )
      ENDIF

   } )

   RETURN aRaport

/*----------------------------------------------------------------------*/

PROCEDURE JPKImp_PKPIR_Podglad( aDane, aSumy )

   LOCAL nElem := 1
   LOCAL aNaglowki := { "Import", "K_1", "K_2", "K_3", "K_4", "K_5", "K_6", "K_7", ;
      "K_8", "K_9", "K_10", "K_11", "K_12", "K_13", "K_14", "K_15", "K_16A", "K_16B", "K_17" }

   LOCAL aBlokiKolumn := { ;
      { || iif( aDane[ nElem ][ "Importuj" ], "Tak", "Nie" ) }, ;
      { || PadC( aDane[ nElem ][ "K_1" ], 6 ) }, ;
      { || DToS( aDane[ nElem ][ "K_2" ] ) }, ;
      { || PadR( aDane[ nElem ][ "K_3" ], 16 ) }, ;
      { || PadR( aDane[ nElem ][ "K_4" ], 25 ) }, ;
      { || PadR( aDane[ nElem ][ "K_5" ], 20 ) }, ;
      { || PadR( aDane[ nElem ][ "K_6" ], 20 ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_7" ), Transform( aDane[ nElem ][ "K_7" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_8" ), Transform( aDane[ nElem ][ "K_8" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_9" ), Transform( aDane[ nElem ][ "K_9" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_10" ), Transform( aDane[ nElem ][ "K_10" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_11" ), Transform( aDane[ nElem ][ "K_11" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_12" ), Transform( aDane[ nElem ][ "K_12" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_13" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_14" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_15" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_16A" ), PadR( aDane[ nElem ][ "K_16A" ], 20 ), Space( 20 ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_16B" ), Transform( aDane[ nElem ][ "K_13" ], RPICE ),  Transform( 0, RPICE ) ) }, ;
      { || iif( hb_HHasKey( aDane[ nElem ], "K_17" ), PadR( aDane[ nElem ][ "K_17" ], 20 ), Space( 20 ) ) } }
   LOCAL bColorBlock := { | xVal |
      IF aDane[ nElem ][ "Importuj" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aStopki := { "", "", "", "", "", "", "", Transform( aSumy[ "K_7" ], RPICE ), ;
      Transform( aSumy[ "K_8" ], RPICE ), Transform( aSumy[ "K_9" ], RPICE ), ;
      Transform( aSumy[ "K_10" ], RPICE ), Transform( aSumy[ "K_11" ], RPICE ), ;
      Transform( aSumy[ "K_12" ], RPICE ), Transform( aSumy[ "K_13" ], RPICE ), ;
      Transform( aSumy[ "K_14" ], RPICE ), Transform( aSumy[ "K_15" ], RPICE ), ;
      "", Transform( aSumy[ "K_16B" ], RPICE ), "" }
   LOCAL aKlawisze := { { K_ENTER, { | nElem, ar, b |
      IF ar[ nElem ][ 'Aktywny' ]
         ar[ nElem ][ 'Importuj' ] := ! ar[ nElem ][ 'Importuj' ]
      ELSE
         komun( "Nie mo¾na importowa† tej pozycji" )
      ENDIF
   } } }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   GM_ArEdit( 2, 0, 22, 79, aDane, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru, aStopki )

   RETURN NIL

/*----------------------------------------------------------------------*/

