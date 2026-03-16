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

#include "hbcompat.ch"

FUNCTION KosAppZaloguj()

   LOCAL oErr, lRes := .F., nUId, cPrzyczyna

   TRY

      KosCzekaj()
      IF Empty( oKosApp )

         oKosApp := win_oleCreateObject( 'GMKos.Aplikacja' )

      ENDIF

      IF ! Empty( oKosApp )

         IF Empty( oKosUser )

            nUId := oKosApp:Zaloguj( "", "" )
            IF nUId > 0

               oKosUser := oKosApp:Uzytkownik

            ENDIF

         ENDIF

         lRes := ! Empty( oKosUser )

      ELSE

         lRes := .F.

      ENDIF

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas pr¢by otwarcia programu GM Kos:;" + oErr:description )

   END

   CLEAR TYPEAHEAD
   @ 24, 0

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION KosImp_Wczytaj( nRodzaj )

   LOCAL oDaneKos, nKosFirmaID, dKosOd, dKosDo, oFirmaPoz
   LOCAL i, oDokFa
   LOCAL aDane := NIL, oErr
   LOCAL aPozycje := {}, aPoz, aSum := {=>}

   IF ! KosAppZaloguj()
      Komun( "Nie udaˆo si© uruchomi† GM Kos" )
      RETURN NIL
   ENDIF
   TRY
      oKosFirma := oKosApp:Firma()
      nKosFirmaID := oKosFirma:Znajdz( Firma_NIP )
      IF nKosFirmaID == 0
         nKosFirmaID := oKosFirma:DodajNowy( Firma_NIP, AllTrim( symbol_fir ), Firma_Nazwa )
         CLEAR TYPEAHEAD
      ENDIF
      IF nKosFirmaID > 0
         dKosOd := hb_Date( Val( param_rok ), Val( miesiac ), 1 )
         dKosDo := EoM( dKosOd )
         KosCzekaj()
         oDaneKos := oKosApp:Firma():WybierzDok( nKosFirmaID, dKosOd, dKosDo, nRodzaj )
         CLEAR TYPEAHEAD
         IF ! Empty( oDaneKos )
            aSum[ 'P_13_1' ] := 0
            aSum[ 'P_14_1' ] := 0
            aSum[ 'P_14_1W' ] := 0
            aSum[ 'P_13_2' ] := 0
            aSum[ 'P_14_2' ] := 0
            aSum[ 'P_14_2W' ] := 0
            aSum[ 'P_13_3' ] := 0
            aSum[ 'P_14_3' ] := 0
            aSum[ 'P_14_3W' ] := 0
            aSum[ 'P_13_4' ] := 0
            aSum[ 'P_14_4' ] := 0
            aSum[ 'P_14_4W' ] := 0
            aSum[ 'P_13_5' ] := 0
            aSum[ 'P_14_5' ] := 0
            aSum[ 'P_13_6_1' ] := 0
            aSum[ 'P_13_6_2' ] := 0
            aSum[ 'P_13_6_3' ] := 0
            aSum[ 'P_13_7' ] := 0
            aSum[ 'P_13_8' ] := 0
            aSum[ 'P_13_9' ] := 0
            aSum[ 'P_13_10' ] := 0
            aSum[ 'P_13_11' ] := 0
            aSum[ 'P_15' ] := 0

            FOR i := 0 TO oDaneKos:Count() - 1
               oDokFa := oDaneKos:Item( i )
               aPoz := {=>}
               aPoz[ 'KosID' ] := oDokFa:KosID
               aPoz[ 'NrKSeF' ] := oDokFa:NrKSeF
               aPoz[ 'P1IdentyfikatorTyp' ] := oDokFa:P1IdentyfikatorTyp
               aPoz[ 'P1Identyfikator' ] := oDokFa:P1Identyfikator
               aPoz[ 'P1Nazwa' ] := oDokFa:P1Nazwa
               aPoz[ 'P1PrefiksPodatnika' ] := oDokFa:P1PrefiksPodatnika
               aPoz[ 'P1KodKraju' ] := oDokFa:P1KodKraju
               aPoz[ 'P1AdresL1' ] := oDokFa:P1AdresL1
               aPoz[ 'P1AdresL2' ] := oDokFa:P1AdresL2
               aPoz[ 'P2IdentyfikatorTyp' ] := oDokFa:P2IdentyfikatorTyp
               aPoz[ 'P2Identyfikator' ] := oDokFa:P2Identyfikator
               aPoz[ 'P2IdentyfikatorKraj' ] := oDokFa:P2IdentyfikatorKraj
               aPoz[ 'P2Nazwa' ] := oDokFa:P2Nazwa
               aPoz[ 'P2KodKraju' ] := oDokFa:P2KodKraju
               aPoz[ 'P2AdresL1' ] := oDokFa:P2AdresL1
               aPoz[ 'P2AdresL2' ] := oDokFa:P2AdresL2
               aPoz[ 'RodzajFaktury' ] := oDokFa:RodzajFaktury
               aPoz[ 'KodWaluty' ] := oDokFa:KodWaluty
               aPoz[ 'P_1' ] := oDokFa:P_1
               aPoz[ 'P_2' ] := oDokFa:P_2
               aPoz[ 'P_6' ] := oDokFa:P_6
               aPoz[ 'P_6_Od' ] := oDokFa:P_6_Od
               aPoz[ 'P_6_Do' ] := oDokFa:P_6_Do
               aPoz[ 'P_13_1' ] := oDokFa:P_13_1
               aSum[ 'P_13_1' ] += oDokFa:P_13_1
               aPoz[ 'P_14_1' ] := oDokFa:P_14_1
               aSum[ 'P_14_1' ] += oDokFa:P_14_1
               aPoz[ 'P_14_1W' ] := oDokFa:P_14_1W
               aSum[ 'P_14_1W' ] += oDokFa:P_14_1W
               aPoz[ 'P_13_2' ] := oDokFa:P_13_2
               aSum[ 'P_13_2' ] += oDokFa:P_13_2
               aPoz[ 'P_14_2' ] := oDokFa:P_14_2
               aSum[ 'P_14_2' ] += oDokFa:P_14_2
               aPoz[ 'P_14_2W' ] := oDokFa:P_14_2W
               aSum[ 'P_14_2W' ] += oDokFa:P_14_2W
               aPoz[ 'P_13_3' ] := oDokFa:P_13_3
               aSum[ 'P_13_3' ] += oDokFa:P_13_3
               aPoz[ 'P_14_3' ] := oDokFa:P_14_3
               aSum[ 'P_14_3' ] += oDokFa:P_14_3
               aPoz[ 'P_14_3W' ] := oDokFa:P_14_3W
               aSum[ 'P_14_3W' ] += oDokFa:P_14_3W
               aPoz[ 'P_13_4' ] := oDokFa:P_13_4
               aSum[ 'P_13_4' ] += oDokFa:P_13_4
               aPoz[ 'P_14_4' ] := oDokFa:P_14_4
               aSum[ 'P_14_4' ] += oDokFa:P_14_4
               aPoz[ 'P_14_4W' ] := oDokFa:P_14_4W
               aSum[ 'P_14_4W' ] += oDokFa:P_14_4W
               aPoz[ 'P_13_5' ] := oDokFa:P_13_5
               aSum[ 'P_13_5' ] += oDokFa:P_13_5
               aPoz[ 'P_14_5' ] := oDokFa:P_14_5
               aSum[ 'P_14_5' ] += oDokFa:P_14_5
               aPoz[ 'P_13_6_1' ] := oDokFa:P_13_6_1
               aSum[ 'P_13_6_1' ] += oDokFa:P_13_6_1
               aPoz[ 'P_13_6_2' ] := oDokFa:P_13_6_2
               aSum[ 'P_13_6_2' ] += oDokFa:P_13_6_2
               aPoz[ 'P_13_6_3' ] := oDokFa:P_13_6_3
               aSum[ 'P_13_6_3' ] += oDokFa:P_13_6_3
               aPoz[ 'P_13_7' ] := oDokFa:P_13_7
               aSum[ 'P_13_7' ] += oDokFa:P_13_7
               aPoz[ 'P_13_8' ] := oDokFa:P_13_8
               aSum[ 'P_13_8' ] += oDokFa:P_13_8
               aPoz[ 'P_13_9' ] := oDokFa:P_13_9
               aSum[ 'P_13_9' ] += oDokFa:P_13_9
               aPoz[ 'P_13_10' ] := oDokFa:P_13_10
               aSum[ 'P_13_10' ] += oDokFa:P_13_10
               aPoz[ 'P_13_11' ] := oDokFa:P_13_11
               aSum[ 'P_13_11' ] += oDokFa:P_13_11
               aPoz[ 'P_15' ] := oDokFa:P_15
               aSum[ 'P_15' ] += oDokFa:P_15
               aPoz[ 'P_16' ] := oDokFa:P_16
               aPoz[ 'P_17' ] := oDokFa:P_17
               aPoz[ 'P_18' ] := oDokFa:P_18
               aPoz[ 'P_18A' ] := oDokFa:P_18A
               aPoz[ 'P_19' ] := oDokFa:P_19
               aPoz[ 'P_19N' ] := oDokFa:P_19N
               aPoz[ 'P_22' ] := oDokFa:P_22
               aPoz[ 'P_22N' ] := oDokFa:P_22N
               aPoz[ 'P_23' ] := oDokFa:P_23
               aPoz[ 'FP' ] := oDokFa:FP
               aPoz[ 'TP' ] := oDokFa:TP
               aPoz[ 'KosGTU' ] := oDokFa:KosGTU
               aPoz[ 'KosProcedura' ] := oDokFa:KosProcedura
               AAdd( aPozycje, aPoz )
            NEXT

            aDane := { => }
            aDane[ 'Pozycje' ] := aPozycje
            aDane[ 'Sumy' ] := aSum
            aDane[ 'Naglowek' ] := { => }
            aDane[ 'Naglowek' ][ 'KodFormularza' ] := "FA"
            aDane[ 'Naglowek' ][ 'WariantFormularza' ] := "3"
            aDane[ 'Naglowek' ][ 'DataWytworzeniaJPK' ] := DToC( Date() )
            aDane[ 'Naglowek' ][ 'DataOd' ] := dKosOd
            aDane[ 'Naglowek' ][ 'DataDo' ] := dKosDo
            aDane[ 'Podmiot' ] := { => }
            aDane[ 'Podmiot' ][ 'PelnaNazwa' ] := ""
            aDane[ 'Podmiot' ][ 'NIP' ] := Firma_NIP
         ENDIF
      ELSE
         Komun( "Nie znaleziono firmy w programie GM Kos" )
      ENDIF

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas komunikacji z programem GM Kos.;" + oErr:description )

   END

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE KosCzekaj()

   Czekaj( "Dost©p do programu GM Kos. Prosz© czeka†..." )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION KosImp_VatS_Dekretuj( aDane )

   LOCAL aRes := {}, cStr

   AEval( aDane[ 'JPK' ][ 'Pozycje' ], { | aPoz |
      LOCAL aPozDek
      LOCAL cNip, cKraj := "PL"
      LOCAL cAdr
      aPoz[ 'Importuj' ] := .T.

      aPozDek := hb_Hash()
      aPozDek[ 'zsek_cv7' ] := '  '
      aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
      aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
      aPozDek[ 'znumer' ] := aPoz[ 'P_2' ]

      //cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'P2Identyfikator' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
      cKraj := iif( Len( aPoz[ 'P2KodKraju' ] ) == 0, "PL", aPoz[ 'P2KodKraju' ] )
      aPozDek[ 'zkraj' ] := cKraj
      aPozDek[ 'zue' ] := iif( KrajUE( cKraj ), 'T', 'N' )
      aPozDek[ 'znr_ident' ] := aPoz[ 'P2Identyfikator' ]
      aPozDek[ 'znazwa' ] := aPoz[ 'P2Nazwa' ]
      cAdr := aPoz[ 'P2AdresL1' ]
      IF Len( cAdr ) > 0 .AND. Len( aPoz[ 'P2AdresL2' ] ) > 0
         cAdr := cAdr + ', ' + aPoz[ 'P2AdresL2' ]
      ENDIF
      aPozDek[ 'zadres' ] := cAdr
      aPozDek[ 'zdatas' ] := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )

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
      aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6_1', 0 ) + HGetDefault( aPoz, 'P_13_6_2', 0 ) + HGetDefault( aPoz, 'P_13_6_3', 0 )

      IF aPoz[ 'P_18' ]
         //aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
         aPozDek[ 'zsek_cv7' ] := 'PN'
      ELSE
         //aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
      ENDIF

      IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
         aPozDek[ 'zsek_cv7' ] := 'SP'
      ENDIF

      aPozDek[ 'zkorekta' ] := iif( AScan( { "KOR", "KOR_ZAL", "KOR_ROZ" }, aPoz[ 'RodzajFaktury' ] ) > 0, 'T', 'N' )

      aPozDek[ 'KodWaluty' ] := HGetDefault( aPoz, 'KodWaluty', 'PLN' )

      aPozDek[ 'VATMarza' ] := 0
      aPozDek[ 'RodzDow' ] := ''
      aPozDek[ 'Procedura' ] := aPoz[ 'KosProcedura' ]
      aPozDek[ 'Oznaczenie' ] := aPoz[ 'KosGTU' ]

      aPozDek[ 'NrKSeF' ] := aPoz[ 'NrKSeF' ]
      aPozDek[ 'KSeFStat' ] := ' '

      aPozDek[ 'FakturaPoz' ] := aPoz

      AAdd( aRes, aPozDek )

   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION KosImp_VatZ_Dekretuj( aDane )

   LOCAL aRes := {}, cAdr
   //LOCAL cNipFir := TrimNip( aDane[ 'JPK' ][ 'Firma' ][ 'firma' ][ 'nip' ] )

   AEval( aDane[ 'JPK' ][ 'Pozycje' ], { | aPoz |
      LOCAL aPozDek
     // LOCAL cNip := HGetDefault( aPoz, 'P_5B', '' )
      LOCAL cKraj := "PL"
      aPoz[ 'Aktywny' ] := .T.
      aPoz[ 'Importuj' ] := .T.
      aPoz[ 'DataDok' ] := aPoz[ 'P_1' ]
      aPozDek := hb_Hash()
      aPozDek[ 'zsek_cv7' ] := '  '
      aPozDek[ 'zkolumna' ] := '10'
      aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
      aPozDek[ 'zdatatran' ] := aPoz[ 'P_1' ]
      aPozDek[ 'znumer' ] := HGetDefault( aPoz, 'P_2', '' )

      //cNip := PodzielNIP( iif( Upper( AllTrim( aPoz[ 'NrKontrahenta' ] ) ) == "BRAK", "", aPoz[ 'NrKontrahenta' ] ), @cKraj )
      aPozDek[ 'zkraj' ] := HGetDefault( aPoz, 'P1KodKraju', 'PL' )
      aPozDek[ 'zue' ] := iif( KrajUE( aPozDek[ 'zkraj' ] ), 'T', 'N' )
      aPozDek[ 'znr_ident' ] := HGetDefault( aPoz, 'P1Identyfikator', '' )
      aPozDek[ 'znazwa' ] := HGetDefault( aPoz, 'P1Nazwa', '' )
      cAdr := aPoz[ 'P1AdresL1' ]
      IF Len( cAdr ) > 0 .AND. Len( aPoz[ 'P1AdresL2' ] ) > 0
         cAdr := cAdr + ', ' + aPoz[ 'P1AdresL2' ]
      ENDIF
      aPozDek[ 'zadres' ] := cAdr
      aPozDek[ 'zdatas' ] := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )

      aPozDek[ 'zexport' ] := 'N'
      IF aPozDek[ 'zue' ] == 'N' .AND. aPozDek[ 'zkraj' ] <> 'PL'
         aPozDek[ 'zexport' ] := 'T'
      ENDIF

      aPozDek[ 'zkorekta' ] := aPozDek[ 'zkorekta' ] := iif( AScan( { "KOR", "KOR_ZAL", "KOR_ROZ" }, aPoz[ 'RodzajFaktury' ] ) > 0, 'T', 'N' )

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
      aPozDek[ 'zwart08' ] := 0
      aPozDek[ 'zvat108' ] := 0
      aPozDek[ 'zbrut02' ] := 0
      aPozDek[ 'zbrut07' ] := 0
      aPozDek[ 'zbrut22' ] := 0
      aPozDek[ 'zbrut12' ] := 0
      aPozDek[ 'znetto' ] := 0

      IF aPoz[ 'P_18' ]
         //aPozDek[ 'zwart08' ] := HGetDefault( aPoz, 'P_13_6', 0 ) + HGetDefault( aPoz, 'P_13_4', 0 )
         aPozDek[ 'zsek_cv7' ] := 'PN'
      ELSE
      ENDIF
      aPozDek[ 'zwart00' ] := HGetDefault( aPoz, 'P_13_6_1', 0 ) + HGetDefault( aPoz, 'P_13_6_2', 0 ) + HGetDefault( aPoz, 'P_13_6_3', 0 )

      IF hb_HHasKey( aPoz, 'P_18A' ) .AND. aPoz[ 'P_18A' ]
         aPozDek[ 'zsek_cv7' ] := 'SP'
      ENDIF

      aPozDek[ 'SierTrwaly' ] := .F.
      aPozDek[ 'UwagaVat' ] := .F.

      aPozDek[ 'KodWaluty' ] := HGetDefault( aPoz, 'KodWaluty', 'PLN' )

      aPozDek[ 'VATMarza' ] := 0
      aPozDek[ 'RodzDow' ] := ''

      aPozDek[ 'NrKSeF' ] := aPoz[ 'NrKSeF' ]
      aPozDek[ 'KSeFStat' ] := ' '

      aPozDek[ 'FakturaPoz' ] := aPoz

      AAdd( aRes, aPozDek )

   } )

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION KosEmptyDate( dDate )

   RETURN ! HB_ISDATE( dDate ) .OR. dDate < 0d19900101

/*----------------------------------------------------------------------*/



