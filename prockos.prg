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

   LOCAL oDaneKos, oKosFirma, nKosFirmaID, dKosOd, dKosDo, oFirmaPoz
   LOCAL i, oDokFa, nArea
   LOCAL aDane := NIL, oErr
   LOCAL aPozycje := {}, aPoz, aSum := {=>}
   LOCAL oKol, oKolumny, oTresc, oTresci, oRej, oRejestry

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
         oKolumny := oKosApp:Fabryka():Utworz_Kolekcja()
         oTresci := oKosApp:Fabryka():Utworz_Kolekcja()
         oRejestry := oKosApp:Fabryka():Utworz_Kolekcja()
         DO CASE
         CASE nRodzaj == 0 .AND. zRYCZALT == 'T'
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 5
            oKol:Nazwa := "5 - " + NumToStr( staw_ry20 * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 6
            oKol:Nazwa := "6 - " + NumToStr( staw_ry17 * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 7
            oKol:Nazwa := "7 - " + NumToStr( staw_rk09 * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 8
            oKol:Nazwa := "8 - " + NumToStr( staw_uslu * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 9
            oKol:Nazwa := "9 - " + NumToStr( staw_rk10 * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 10
            oKol:Nazwa := "10 - " + NumToStr( staw_prod * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 11
            oKol:Nazwa := "11 - " + NumToStr( staw_hand * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 12
            oKol:Nazwa := "12 - " + NumToStr( staw_rk07 * 100 ) + "%"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 13
            oKol:Nazwa := "13 - " + NumToStr( staw_ry10 * 100 ) + "%"
            oKolumny:Add( oKol )
         CASE nRodzaj == 0 .AND. zRYCZALT <> 'T'
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 7
            oKol:Nazwa := "7 - Sprzeda¾ towar¢w i usˆug"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 8
            oKol:Nazwa := "8 - Pozostaˆe przychody"
            oKolumny:Add( oKol )
         CASE nRodzaj == 1 .AND. zRYCZALT == 'T'

         CASE nRodzaj == 1 .AND. zRYCZALT <> 'T'
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 10
            oKol:Nazwa := "10 - zakup towarow i materialow"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 11
            oKol:Nazwa := "11 - koszty uboczne zakupu"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 12
            oKol:Nazwa := "12 - wynagrodzenia w gotowce i naturze"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 13
            oKol:Nazwa := "13 - pozostale koszty"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 15
            oKol:Nazwa := "15 - (kolumna wolna)"
            oKolumny:Add( oKol )
            oKol := oKosApp:Fabryka():Utworz_AmiTresc()
            oKol:AmiID := 16
            oKol:Nazwa := "16 - koszty dziaˆalno˜ci badawczej"
            oKolumny:Add( oKol )
         ENDCASE

         nArea := Select()
         IF tresc->( dbSeek( "+" + ident_fir ) )
            DO WHILE tresc->del == "+" .AND. tresc->firma == ident_fir
               IF ( nRodzaj == 0 .AND. tresc->rodzaj $ ' OS' ) .OR. ( nRodzaj == 1 .AND. tresc->rodzaj $ ' OZ' )
                  oTresc := oKosApp:Fabryka():Utworz_AmiTresc()
                  oTresc:AmiID := tresc->id
                  oTresc:Nazwa := AllTrim( SubStr( tresc->tresc, 1, 30 ) )
                  oTresci:Add( oTresc )
               ENDIF
               tresc->( dbSkip() )
            ENDDO
         ENDIF

         IF nRodzaj == 0
            DO WHILE ! DostepPro( 'KAT_SPR', 'KAT_SPR', )
            ENDDO
            IF kat_spr->( dbSeek( "+" + ident_fir ) )
               DO WHILE kat_spr->del == "+" .AND. kat_spr->firma == ident_fir
                  oRej := oKosApp:Fabryka():Utworz_AmiRejVat()
                  oRej:AmiID := kat_spr->id
                  oRej:Symbol := AllTrim( kat_spr->symb_rej )
                  oRej:Nazwa := kat_spr->symb_rej + ' - ' + AllTrim( kat_spr->opis )
                  oRejestry:Add( oRej )
                  kat_spr->( dbSkip() )
               ENDDO
            ENDIF
            kat_spr->( dbCloseArea() )
         ELSE
            DO WHILE ! DostepPro( 'KAT_ZAK', 'KAT_ZAK', )
            ENDDO
            IF kat_zak->( dbSeek( "+" + ident_fir ) )
               DO WHILE kat_zak->del == "+" .AND. kat_zak->firma == ident_fir
                  oRej := oKosApp:Fabryka():Utworz_AmiRejVat()
                  oRej:AmiID := kat_zak->id
                  oRej:Symbol := AllTrim( kat_zak->symb_rej )
                  oRej:Nazwa := kat_zak->symb_rej + ' - ' + AllTrim( kat_zak->opis )
                  oRejestry:Add( oRej )
                  kat_zak->( dbSkip() )
               ENDDO
            ENDIF
            kat_zak->( dbCloseArea() )
         ENDIF
         Select( nArea )

         oDaneKos := oKosApp:Firma():WybierzDok( nKosFirmaID, dKosOd, dKosDo, nRodzaj, .T., oKolumny, oTresci, oRejestry )
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
               aPoz[ 'AmiP1KsgKol' ] := oDokFa:AmiP1KsgKol
               aPoz[ 'AmiP1KsgData' ] := oDokFa:AmiP1KsgData
               aPoz[ 'AmiP1Tresc' ] := oDokFa:AmiP1Tresc
               aPoz[ 'AmiP1RejData' ] := oDokFa:AmiP1RejData
               aPoz[ 'AmiP1RejSymbol' ] := oDokFa:AmiP1RejSymbol
               aPoz[ 'AmiP2KsgData' ] := oDokFa:AmiP2KsgData
               aPoz[ 'AmiP2KsgKol' ] := oDokFa:AmiP2KsgKol
               aPoz[ 'AmiP2Tresc' ] := oDokFa:AmiP2Tresc
               aPoz[ 'AmiP2RejData' ] := oDokFa:AmiP2RejData
               aPoz[ 'AmiP2RejSymbol' ] := oDokFa:AmiP2RejSymbol
               aPoz[ 'AmiP2RejOpcje' ] := oDokFa:AmiP2RejOpcje
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
      LOCAL aPozDek, dDataS
      LOCAL cNip, cKraj := "PL"
      LOCAL cAdr
      aPoz[ 'Importuj' ] := .T.

      dDataS := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )

      aPozDek := hb_Hash()
      aPozDek[ 'zsek_cv7' ] := '  '
      aPozDek[ 'zdzien' ] := Str( Day( dDataS ), 2 )
      aPozDek[ 'zmc' ] := Str( Month( dDataS ), 2 )
      //aPozDek[ 'zdatatran' ] := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )
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

      aPozDek[ 'zkolumna' ] := iif( aPoz[ 'AmiP1KsgKol' ] > 0, Str( aPoz[ 'AmiP1KsgKol' ], 2 ), '  ' )
      aPozDek[ 'zdataks' ] := dDataS
      aPozDek[ 'ztresc' ] := aPoz[ 'AmiP1Tresc' ]
      aPozDek[ 'zsymb_rej' ] := aPoz[ 'AmiP1RejSymbol' ]

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
      aPozDek[ 'zkolumna' ] := iif( aPoz[ 'AmiP2KsgKol' ] > 0, Str( aPoz[ 'AmiP2KsgKol' ], 2 ), '10' )
      aPozDek[ 'zdzien' ] := Str( Day( aPoz[ 'P_1' ] ), 2 )
      //aPozDek[ 'zdatatran' ] := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )
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
      //aPozDek[ 'zdatas' ] := iif( KosEmptyDate( aPoz[ 'P_6' ] ), aPoz[ 'P_1' ], aPoz[ 'P_6' ] )
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

      aPozDek[ 'ztresc' ] := aPoz[ 'AmiP2Tresc' ]
      aPozDek[ 'zsymb_rej' ] := aPoz[ 'AmiP2RejSymbol' ]
      aPozDek[ 'zopcje' ] := ' '
      DO CASE
      CASE aPoz[ 'AmiP2RejOpcje' ] == 1
         aPozDek[ 'zopcje' ] := 'P'
      CASE aPoz[ 'AmiP2RejOpcje' ] == 2
         aPozDek[ 'zopcje' ] := '7'
      CASE aPoz[ 'AmiP2RejOpcje' ] == 3
         aPozDek[ 'zopcje' ] := '5'
      CASE aPoz[ 'AmiP2RejOpcje' ] == 4
         aPozDek[ 'zopcje' ] := '2'
      ENDCASE

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

FUNCTION KosUstawStatus( aDane, nRodzaj, nStatus )

   LOCAL oKolekcja, nKosFirmaID, oKosFirma

   IF ! KosAppZaloguj()
      Komun( "Nie udaˆo si© uruchomi† GM Kos" )
      RETURN NIL
   ENDIF
   TRY
      oKosFirma := oKosApp:Firma()
      nKosFirmaID := oKosFirma:Znajdz( Firma_NIP )
      IF nKosFirmaID > 0
         oKolekcja := oKosApp:UtworzKolekcje()
         AEval( aDane, { | cNr | oKolekcja:Add( cNr ) } )
         oKosFirma:UstawStatus( nKosFirmaID, oKolekcja, nRodzaj, nStatus )
      ELSE
         Komun( "Brak firmy w programie GM Kos" )
      END

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas pr¢by otwarcia programu GM Kos:;" + oErr:description )

   END

   CLEAR TYPEAHEAD
   @ 24, 0

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE KosPokazWizualizacje( cNrKSeF )

   LOCAL nKosFirmaID, oKosFirma

   IF ! KosAppZaloguj()
      Komun( "Nie udaˆo si© uruchomi† GM Kos" )
      RETURN NIL
   ENDIF
   TRY
      oKosFirma := oKosApp:Firma()
      nKosFirmaID := oKosFirma:Znajdz( Firma_NIP )
      IF nKosFirmaID > 0
         IF oKosFirma:PokazWizualizacje( nKosFirmaID, cNrKSeF ) <> 0
            Komun( "Brak dokumentu w KSeF" )
         ENDIF
      ELSE
         Komun( "Brak firmy w programie GM Kos" )
      END

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas pr¢by otwarcia programu GM Kos:;" + oErr:description )

   END

   CLEAR TYPEAHEAD
   @ 24, 0

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION KosWyslijFA( cPlikFA )

   LOCAL nKosFirmaID, oKosFirma, oStatus

   IF ! KosAppZaloguj()
      Komun( "Nie udaˆo si© uruchomi† GM Kos" )
      RETURN NIL
   ENDIF
   TRY
      oKosFirma := oKosApp:Firma()
      nKosFirmaID := oKosFirma:Znajdz( Firma_NIP )
      IF nKosFirmaID > 0
         oStatus := oKosFirma:WyslijFA( nKosFirmaID, cPlikFA )
         IF Empty( oStatus )
            Komun( "Nie udaˆo si© wysˆa† faktury do KSeF" )
         ENDIF
      ELSE
         Komun( "Brak firmy w programie GM Kos" )
      END

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas pr¢by otwarcia programu GM Kos:;" + oErr:description )

   END

   CLEAR TYPEAHEAD
   @ 24, 0

   RETURN oStatus

/*----------------------------------------------------------------------*/

FUNCTION KosSprawdzStatusFA( cNrRefSesji, cNrRefFA )

   LOCAL nKosFirmaID, oKosFirma, oStatus

   IF ! KosAppZaloguj()
      Komun( "Nie udaˆo si© uruchomi† GM Kos" )
      RETURN NIL
   ENDIF
   TRY
      oKosFirma := oKosApp:Firma()
      nKosFirmaID := oKosFirma:Znajdz( Firma_NIP )
      IF nKosFirmaID > 0
         oStatus := oKosFirma:SprawdzStatusFA( nKosFirmaID, cNrRefSesji, cNrRefFA )
         IF Empty( oStatus )
            Komun( "Nie udaˆo si© pobra† statusu faktury z KSeF" )
         ENDIF
      ELSE
         Komun( "Brak firmy w programie GM Kos" )
      END

   CATCH oErr

      CLEAR TYPEAHEAD
      Alert( "Wyst¥piˆ bˆ¥d podczas pr¢by otwarcia programu GM Kos:;" + oErr:description )

   END

   CLEAR TYPEAHEAD
   @ 24, 0

   RETURN oStatus

/*----------------------------------------------------------------------*/


