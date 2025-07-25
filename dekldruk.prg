/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Micha� Gawrycki (gmsystems.pl)

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

PROCEDURE DeklarDrukuj( cSymbolDek, xDane )
   LOCAL oRap, oSubRap, cPlikRap := '', aRaporty := {}
   LOCAL nMenu, cKolor, hDane := hb_Hash()

   SWITCH cSymbolDek

   CASE 'PIT4R-6'
      hDane := DaneDek_PIT4Rw6()
      cPlikRap := 'frf\pit4r_w6.frf'
      EXIT
   CASE 'PIT4R-8'
      hDane := DaneDek_PIT4Rw8()
      cPlikRap := 'frf\pit4r_w8.frf'
      EXIT
   CASE 'PIT4R-9'
      hDane := DaneDek_PIT4Rw9()
      cPlikRap := 'frf\pit4r_w9.frf'
      EXIT
   CASE 'PIT4R-10'
      hDane := DaneDek_PIT4Rw10()
      cPlikRap := 'frf\pit4r_w10.frf'
      EXIT
   CASE 'PIT4R-11'
      hDane := DaneDek_PIT4Rw11()
      cPlikRap := 'frf\pit4r_w11.frf'
      EXIT
   CASE 'PIT4R-12'
      hDane := DaneDek_PIT4Rw12()
      cPlikRap := 'frf\pit4r_w12.frf'
      EXIT
   CASE 'PIT4R-13'
      hDane := DaneDek_PIT4Rw13()
      cPlikRap := 'frf\pit4r_w13.frf'
      EXIT
   CASE 'PIT8AR-6'
      hDane := DaneDek_PIT8ARw6()
      cPlikRap := 'frf\pit8ar_w6.frf'
      EXIT
   CASE 'PIT8AR-7'
      hDane := DaneDek_PIT8ARw7()
      cPlikRap := 'frf\pit8ar_w7.frf'
      EXIT
   CASE 'PIT8AR-8'
      hDane := DaneDek_PIT8ARw8()
      cPlikRap := 'frf\pit8ar_w8.frf'
      EXIT
   CASE 'PIT8AR-9'
      hDane := DaneDek_PIT8ARw9()
      cPlikRap := 'frf\pit8ar_w9.frf'
      EXIT
   CASE 'PIT8AR-10'
      hDane := DaneDek_PIT8ARw10()
      cPlikRap := 'frf\pit8ar_w10.frf'
      EXIT
   CASE 'PIT8AR-11'
      hDane := DaneDek_PIT8ARw11()
      cPlikRap := 'frf\pit8ar_w11.frf'
      EXIT
   CASE 'PIT8AR-12'
      hDane := DaneDek_PIT8ARw12()
      cPlikRap := 'frf\pit8ar_w12.frf'
      EXIT
   CASE 'PIT8AR-13'
      hDane := DaneDek_PIT8ARw13()
      cPlikRap := 'frf\pit8ar_w13.frf'
      EXIT
   CASE 'PIT8AR-14'
      hDane := DaneDek_PIT8ARw13()
      cPlikRap := 'frf\pit8ar_w14.frf'
      EXIT
   CASE 'PIT11-22'
      hDane := DaneDek_PIT11w22()
      cPlikRap := 'frf\pit11_w22.frf'
      EXIT
   CASE 'PIT11-23'
      hDane := DaneDek_PIT11w23()
      cPlikRap := 'frf\pit11_w23.frf'
      EXIT
   CASE 'PIT11-24'
      hDane := DaneDek_PIT11w24()
      cPlikRap := 'frf\pit11_w24.frf'
      EXIT
   CASE 'PIT11-25'
      hDane := DaneDek_PIT11w25()
      cPlikRap := 'frf\pit11_w25.frf'
      EXIT
   CASE 'PIT11-26'
      hDane := DaneDek_PIT11w25()
      cPlikRap := 'frf\pit11_w26.frf'
      EXIT
   CASE 'PIT11-27'
      hDane := DaneDek_PIT11w27()
      cPlikRap := 'frf\pit11_w27.frf'
      EXIT
   CASE 'PIT11-29'
      hDane := DaneDek_PIT11w29()
      cPlikRap := 'frf\pit11_w29.frf'
      EXIT
   CASE 'VAT7-15'
      hDane := DaneDek_VAT7w15()
      cPlikRap := 'frf\vat7_w15.frf'
      EXIT
   CASE 'VAT7-16'
      hDane := DaneDek_VAT7w16()
      cPlikRap := 'frf\vat7_w16.frf'
      EXIT
   CASE 'VAT7-17'
      hDane := DaneDek_VAT7w17()
      cPlikRap := 'frf\vat7_w17.frf'
      EXIT
   CASE 'VAT7-18'
      hDane := DaneDek_VAT7w18()
      cPlikRap := 'frf\vat7_w18.frf'
      EXIT
   CASE 'VAT7-19'
      hDane := DaneDek_VAT7w19()
      cPlikRap := 'frf\vat7_w19.frf'
      EXIT
   CASE 'VAT7-20'
      hDane := DaneDek_VAT7w20()
      cPlikRap := 'frf\vat7_w20.frf'
      EXIT
   CASE 'VAT7K-9'
      hDane := DaneDek_VAT7Kw9()
      cPlikRap := 'frf\vat7k_w9.frf'
      EXIT
   CASE 'VAT7K-10'
      hDane := DaneDek_VAT7Kw10()
      cPlikRap := 'frf\vat7k_w10.frf'
      EXIT
   CASE 'VAT7K-11'
      hDane := DaneDek_VAT7Kw11()
      cPlikRap := 'frf\vat7k_w11.frf'
      EXIT
   CASE 'VAT7K-12'
      hDane := DaneDek_VAT7Kw12()
      cPlikRap := 'frf\vat7k_w12.frf'
      EXIT
   CASE 'VAT7K-13'
      hDane := DaneDek_VAT7Kw13()
      cPlikRap := 'frf\vat7k_w13.frf'
      EXIT
   CASE 'VAT7K-14'
      hDane := DaneDek_VAT7Kw14()
      cPlikRap := 'frf\vat7k_w14.frf'
      EXIT
   CASE 'VAT7D-6'
      hDane := DaneDek_VAT7Dw6()
      cPlikRap := 'frf\vat7d_w6.frf'
      EXIT
   CASE 'VAT7D-7'
      hDane := DaneDek_VAT7Dw7()
      cPlikRap := 'frf\vat7d_w7.frf'
      EXIT
   CASE 'VAT7D-8'
      hDane := DaneDek_VAT7Dw8()
      cPlikRap := 'frf\vat7d_w8.frf'
      EXIT
   CASE 'VAT8-11'
      hDane := DaneDek_VAT8w11( xDane )
      cPlikRap := 'frf\vat8_w11.frf'
      EXIT
   CASE 'VAT8-12'
      hDane := DaneDek_VAT8w11( xDane )
      cPlikRap := 'frf\vat8_w12.frf'
      EXIT
   CASE 'VAT9M-10'
      hDane := DaneDek_VAT9Mw10( xDane )
      cPlikRap := 'frf\vat9m_w10.frf'
      EXIT
   CASE 'VAT9M-11'
      hDane := DaneDek_VAT9Mw10( xDane )
      cPlikRap := 'frf\vat9m_w11.frf'
      EXIT
   CASE 'VATUE-3'
      hDane := DaneDek_VATUEw3()
      cPlikRap := 'frf\vatue_w3.frf'
      EXIT
   CASE 'VATUE-4'
      hDane := DaneDek_VATUEw4()
      cPlikRap := 'frf\vatue_w4.frf'
      EXIT
   CASE 'VATUEK-4'
      hDane := DaneDek_VATUEKw4( xDane )
      cPlikRap := 'frf\vatuek_w4.frf'
      EXIT
   CASE 'VATUE-5'
      hDane := DaneDek_VATUEw5()
      cPlikRap := 'frf\vatue_w5.frf'
      EXIT
   CASE 'VATUEK-5'
      hDane := DaneDek_VATUEKw5( xDane )
      cPlikRap := 'frf\vatuek_w5.frf'
      EXIT
   CASE 'VIUDO-1'
      hDane := DaneDek_VIUDOw1( xDane )
      cPlikRap := 'frf\viudo_w1.frf'
      EXIT
   CASE 'VIUDO-2'
      hDane := DaneDek_VIUDOw1( xDane )
      cPlikRap := 'frf\viudo_w2.frf'
      EXIT
   CASE 'VAT27K-1'
   CASE 'VAT27-1'
      hDane := DaneDek_VAT27w1()
      cPlikRap := 'frf\vat27_w1.frf'
      EXIT
   CASE 'VAT27-2'
      hDane := DaneDek_VAT27w2( xDane )
      cPlikRap := 'frf\vat27_w2.frf'
      EXIT
   CASE 'IFT1-13'
      hDane := DaneDek_IFT1w13( xDane )
      cPlikRap := 'frf\ift1_w13.frf'
      EXIT
   CASE 'IFT1-15'
      hDane := DaneDek_IFT1w15( xDane )
      cPlikRap := 'frf\ift1_w15.frf'
      EXIT
   CASE 'IFT1-16'
      hDane := DaneDek_IFT1w16( xDane )
      cPlikRap := 'frf\ift1_w16.frf'
      EXIT
   CASE 'IFT2-9'
   CASE 'IFT2R-9'
      hDane := DaneDek_IFT2w9( xDane )
      cPlikRap := 'frf\ift2_w9.frf'
      EXIT
   CASE 'IFT2-10'
   CASE 'IFT2R-10'
      hDane := DaneDek_IFT2w9( xDane )
      cPlikRap := 'frf\ift2_w10.frf'
      EXIT
   CASE 'IFT2-11'
   CASE 'IFT2R-11'
      hDane := DaneDek_IFT2w11( xDane )
      cPlikRap := 'frf\ift2_w11.frf'
      EXIT
   CASE 'VATINFO'
      //hDane := DaneDek_VAT7w17()
      hDane := DaneDek_VATINFO( xDane )
      cPlikRap := 'frf\vatinfo.frf'
      EXIT
   CASE 'JPKV7M-1'
   CASE 'JPKV7K-1'
      hDane := DaneDek_JPKV7w1( xDane )
      IF ! hDane[ 'JestDeklaracja' ]
         cPlikRap := 'frf\jpkv7n_w1.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      IF hDane[ 'JestDeklaracja' ]
         cPlikRap := 'frf\jpkv7d_w1.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      IF hDane[ 'JestSprzedaz' ] .OR. hDane[ 'JestZakup' ]
         cPlikRap := 'frf\jpkv7j_w1.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      EXIT
   CASE 'JPKV7M-2'
   CASE 'JPKV7K-2'
      hDane := DaneDek_JPKV7w2( xDane )
      IF ! hDane[ 'JestDeklaracja' ]
         cPlikRap := 'frf\jpkv7n_w2.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      IF hDane[ 'JestDeklaracja' ]
         cPlikRap := 'frf\jpkv7d_w2.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      IF hDane[ 'JestSprzedaz' ] .OR. hDane[ 'JestZakup' ]
         cPlikRap := 'frf\jpkv7j_w2.frf'
         AAdd( aRaporty, { hDane, cPlikRap } )
      ENDIF
      EXIT
   OTHERWISE
      Komunikat( 'Brak szablonu wydruku dla tej deklaracji - ' + cSymbolDek )
      RETURN
   ENDSWITCH

   TRY
      IF Len( aRaporty ) > 0
         //oRap := TFreeReport():New( .T. )
         oRap := FRUtworzRaport( .T. )
         AEval( aRaporty, { | aPoz |
            oSubRap := FRUtworzRaport()
            oSubRap:LoadFromFile( aPoz[ 2 ] )
            IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
               oSubRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
            ENDIF
            RaportUstawDane( oSubRap, aPoz[ 1 ] )
            oRap:AddReport( oSubRap )
            AAdd( aPoz, oSubRap )
         } )
         oRap:DoublePass := .T.
      ELSE
         oRap := FRUtworzRaport()
         oRap:LoadFromFile(cPlikRap)
         RaportUstawDane(oRap, hDane)
      ENDIF
      IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
         oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
      ENDIF
      oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
      oRap:ModalPreview := .F.
      cKolor := ColStd()
      @ 24, 0
      @ 24, 26 PROMPT '[ Monitor ]'
      @ 24, 44 PROMPT '[ Drukarka ]'
      IF trybSerwisowy
         @ 24, 70 PROMPT '[ Edytor ]'
      ENDIF
      CLEAR TYPE
      nMenu := Menu(1)
      IF LastKey() != 27
         SWITCH nMenu
         CASE 1
            oRap:ShowReport()
            EXIT
         CASE 2
            IF oRap:PrepareReport()
               oRap:PrintPreparedReport('', 1)
            ENDIF
            EXIT
         CASE 3
            oRap:DesignReport()
            EXIT
         ENDSWITCH
      ENDIF
   CATCH oErr
      Alert( "Wyst�pi� b��d podczas generowania wydruku;" + oErr:description )
   END

   @ 24, 0
   SetColor(cKolor)

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw6()
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   /* IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_5'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_6_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_6_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_9'] := sxml2num( xmlWartoscH( hPozycje, 'P_9' ) )
   hDane['P_10'] := sxml2num( xmlWartoscH( hPozycje, 'P_10' ) )
   hDane['P_11'] := sxml2num( xmlWartoscH( hPozycje, 'P_11' ) )
   hDane['P_12'] := sxml2num( xmlWartoscH( hPozycje, 'P_12' ) )
   hDane['P_13'] := sxml2num( xmlWartoscH( hPozycje, 'P_13' ) )
   hDane['P_14'] := sxml2num( xmlWartoscH( hPozycje, 'P_14' ) )
   hDane['P_15'] := sxml2num( xmlWartoscH( hPozycje, 'P_15' ) )
   hDane['P_16'] := sxml2num( xmlWartoscH( hPozycje, 'P_16' ) )
   hDane['P_17'] := sxml2num( xmlWartoscH( hPozycje, 'P_17' ) )
   hDane['P_18'] := sxml2num( xmlWartoscH( hPozycje, 'P_18' ) )
   hDane['P_19'] := sxml2num( xmlWartoscH( hPozycje, 'P_19' ) )
   hDane['P_20'] := sxml2num( xmlWartoscH( hPozycje, 'P_20' ) )
   hDane['P_21'] := sxml2num( xmlWartoscH( hPozycje, 'P_21' ) )
   hDane['P_22'] := sxml2num( xmlWartoscH( hPozycje, 'P_22' ) )
   hDane['P_23'] := sxml2num( xmlWartoscH( hPozycje, 'P_23' ) )
   hDane['P_24'] := sxml2num( xmlWartoscH( hPozycje, 'P_24' ) )
   hDane['P_25'] := sxml2num( xmlWartoscH( hPozycje, 'P_25' ) )
   hDane['P_26'] := sxml2num( xmlWartoscH( hPozycje, 'P_26' ) )
   hDane['P_27'] := sxml2num( xmlWartoscH( hPozycje, 'P_27' ) )
   hDane['P_28'] := sxml2num( xmlWartoscH( hPozycje, 'P_28' ) )
   hDane['P_29'] := sxml2num( xmlWartoscH( hPozycje, 'P_29' ) )
   hDane['P_30'] := sxml2num( xmlWartoscH( hPozycje, 'P_30' ) )
   hDane['P_31'] := sxml2num( xmlWartoscH( hPozycje, 'P_31' ) )
   hDane['P_32'] := sxml2num( xmlWartoscH( hPozycje, 'P_32' ) )
   hDane['P_33'] := sxml2num( xmlWartoscH( hPozycje, 'P_33' ) )
   hDane['P_34'] := sxml2num( xmlWartoscH( hPozycje, 'P_34' ) )
   hDane['P_35'] := sxml2num( xmlWartoscH( hPozycje, 'P_35' ) )
   hDane['P_36'] := sxml2num( xmlWartoscH( hPozycje, 'P_36' ) )
   hDane['P_37'] := sxml2num( xmlWartoscH( hPozycje, 'P_37' ) )
   hDane['P_38'] := sxml2num( xmlWartoscH( hPozycje, 'P_38' ) )
   hDane['P_39'] := sxml2num( xmlWartoscH( hPozycje, 'P_39' ) )
   hDane['P_40'] := sxml2num( xmlWartoscH( hPozycje, 'P_40' ) )
   hDane['P_41'] := sxml2num( xmlWartoscH( hPozycje, 'P_41' ) )
   hDane['P_42'] := sxml2num( xmlWartoscH( hPozycje, 'P_42' ) )
   hDane['P_43'] := sxml2num( xmlWartoscH( hPozycje, 'P_43' ) )
   hDane['P_44'] := sxml2num( xmlWartoscH( hPozycje, 'P_44' ) )
   hDane['P_45'] := sxml2num( xmlWartoscH( hPozycje, 'P_45' ) )
   hDane['P_46'] := sxml2num( xmlWartoscH( hPozycje, 'P_46' ) )
   hDane['P_47'] := sxml2num( xmlWartoscH( hPozycje, 'P_47' ) )
   hDane['P_48'] := sxml2num( xmlWartoscH( hPozycje, 'P_48' ) )
   hDane['P_49'] := sxml2num( xmlWartoscH( hPozycje, 'P_49' ) )
   hDane['P_50'] := sxml2num( xmlWartoscH( hPozycje, 'P_50' ) )
   hDane['P_51'] := sxml2num( xmlWartoscH( hPozycje, 'P_51' ) )
   hDane['P_52'] := sxml2num( xmlWartoscH( hPozycje, 'P_52' ) )
   hDane['P_53'] := sxml2num( xmlWartoscH( hPozycje, 'P_53' ) )
   hDane['P_54'] := sxml2num( xmlWartoscH( hPozycje, 'P_54' ) )
   hDane['P_55'] := sxml2num( xmlWartoscH( hPozycje, 'P_55' ) )
   hDane['P_56'] := sxml2num( xmlWartoscH( hPozycje, 'P_56' ) )
   hDane['P_57'] := sxml2num( xmlWartoscH( hPozycje, 'P_57' ) )
   hDane['P_58'] := sxml2num( xmlWartoscH( hPozycje, 'P_58' ) )
   hDane['P_59'] := sxml2num( xmlWartoscH( hPozycje, 'P_59' ) )
   hDane['P_60'] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
   hDane['P_61'] := sxml2num( xmlWartoscH( hPozycje, 'P_61' ) )
   hDane['P_62'] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
   hDane['P_63'] := sxml2num( xmlWartoscH( hPozycje, 'P_63' ) )
   hDane['P_64'] := sxml2num( xmlWartoscH( hPozycje, 'P_64' ) )
   hDane['P_65'] := sxml2num( xmlWartoscH( hPozycje, 'P_65' ) )
   hDane['P_66'] := sxml2num( xmlWartoscH( hPozycje, 'P_66' ) )
   hDane['P_67'] := sxml2num( xmlWartoscH( hPozycje, 'P_67' ) )
   hDane['P_68'] := sxml2num( xmlWartoscH( hPozycje, 'P_68' ) )
   hDane['P_69'] := sxml2num( xmlWartoscH( hPozycje, 'P_69' ) )
   hDane['P_70'] := sxml2num( xmlWartoscH( hPozycje, 'P_70' ) )
   hDane['P_71'] := sxml2num( xmlWartoscH( hPozycje, 'P_71' ) )
   hDane['P_72'] := sxml2num( xmlWartoscH( hPozycje, 'P_72' ) )
   hDane['P_73'] := sxml2num( xmlWartoscH( hPozycje, 'P_73' ) )
   hDane['P_74'] := sxml2num( xmlWartoscH( hPozycje, 'P_74' ) )
   hDane['P_75'] := sxml2num( xmlWartoscH( hPozycje, 'P_75' ) )
   hDane['P_76'] := sxml2num( xmlWartoscH( hPozycje, 'P_76' ) )
   hDane['P_77'] := sxml2num( xmlWartoscH( hPozycje, 'P_77' ) )
   hDane['P_78'] := sxml2num( xmlWartoscH( hPozycje, 'P_78' ) )
   hDane['P_79'] := sxml2num( xmlWartoscH( hPozycje, 'P_79' ) )
   hDane['P_80'] := sxml2num( xmlWartoscH( hPozycje, 'P_80' ) )
   hDane['P_81'] := sxml2num( xmlWartoscH( hPozycje, 'P_81' ) )
   hDane['P_82'] := sxml2num( xmlWartoscH( hPozycje, 'P_82' ) )
   hDane['P_83'] := sxml2num( xmlWartoscH( hPozycje, 'P_83' ) )
   hDane['P_84'] := sxml2num( xmlWartoscH( hPozycje, 'P_84' ) )
   hDane['P_85'] := sxml2num( xmlWartoscH( hPozycje, 'P_85' ) )
   hDane['P_86'] := sxml2num( xmlWartoscH( hPozycje, 'P_86' ) )
   hDane['P_87'] := sxml2num( xmlWartoscH( hPozycje, 'P_87' ) )
   hDane['P_88'] := sxml2num( xmlWartoscH( hPozycje, 'P_88' ) )
   hDane['P_89'] := sxml2num( xmlWartoscH( hPozycje, 'P_89' ) )
   hDane['P_90'] := sxml2num( xmlWartoscH( hPozycje, 'P_90' ) )
   hDane['P_91'] := sxml2num( xmlWartoscH( hPozycje, 'P_91' ) )
   hDane['P_92'] := sxml2num( xmlWartoscH( hPozycje, 'P_92' ) )
   hDane['P_93'] := sxml2num( xmlWartoscH( hPozycje, 'P_93' ) )
   hDane['P_94'] := sxml2num( xmlWartoscH( hPozycje, 'P_94' ) )
   hDane['P_95'] := sxml2num( xmlWartoscH( hPozycje, 'P_95' ) )
   hDane['P_96'] := sxml2num( xmlWartoscH( hPozycje, 'P_96' ) )
   hDane['P_97'] := sxml2num( xmlWartoscH( hPozycje, 'P_97' ) )
   hDane['P_98'] := sxml2num( xmlWartoscH( hPozycje, 'P_98' ) )
   hDane['P_99'] := sxml2num( xmlWartoscH( hPozycje, 'P_99' ) )
   hDane['P_100'] := sxml2num( xmlWartoscH( hPozycje, 'P_100' ) )
   hDane['P_101'] := sxml2num( xmlWartoscH( hPozycje, 'P_101' ) )
   hDane['P_102'] := sxml2num( xmlWartoscH( hPozycje, 'P_102' ) )
   hDane['P_103'] := sxml2num( xmlWartoscH( hPozycje, 'P_103' ) )
   hDane['P_104'] := sxml2num( xmlWartoscH( hPozycje, 'P_104' ) )
   hDane['P_105'] := sxml2num( xmlWartoscH( hPozycje, 'P_105' ) )
   hDane['P_106'] := sxml2num( xmlWartoscH( hPozycje, 'P_106' ) )
   hDane['P_107'] := sxml2num( xmlWartoscH( hPozycje, 'P_107' ) )
   hDane['P_108'] := sxml2num( xmlWartoscH( hPozycje, 'P_108' ) )
   hDane['P_109'] := sxml2num( xmlWartoscH( hPozycje, 'P_109' ) )
   hDane['P_110'] := sxml2num( xmlWartoscH( hPozycje, 'P_110' ) )
   hDane['P_111'] := sxml2num( xmlWartoscH( hPozycje, 'P_111' ) )
   hDane['P_112'] := sxml2num( xmlWartoscH( hPozycje, 'P_112' ) )
   hDane['P_113'] := sxml2num( xmlWartoscH( hPozycje, 'P_113' ) )
   hDane['P_114'] := sxml2num( xmlWartoscH( hPozycje, 'P_114' ) )
   hDane['P_115'] := sxml2num( xmlWartoscH( hPozycje, 'P_115' ) )
   hDane['P_116'] := sxml2num( xmlWartoscH( hPozycje, 'P_116' ) )
   hDane['P_117'] := sxml2num( xmlWartoscH( hPozycje, 'P_117' ) )
   hDane['P_118'] := sxml2num( xmlWartoscH( hPozycje, 'P_118' ) )
   hDane['P_119'] := sxml2num( xmlWartoscH( hPozycje, 'P_119' ) )
   hDane['P_120'] := sxml2num( xmlWartoscH( hPozycje, 'P_120' ) )
   hDane['P_121'] := sxml2num( xmlWartoscH( hPozycje, 'P_121' ) )
   hDane['P_122'] := sxml2num( xmlWartoscH( hPozycje, 'P_122' ) )
   hDane['P_123'] := sxml2num( xmlWartoscH( hPozycje, 'P_123' ) )
   hDane['P_124'] := sxml2num( xmlWartoscH( hPozycje, 'P_124' ) )
   hDane['P_125'] := sxml2num( xmlWartoscH( hPozycje, 'P_125' ) )
   hDane['P_126'] := sxml2num( xmlWartoscH( hPozycje, 'P_126' ) )
   hDane['P_127'] := sxml2num( xmlWartoscH( hPozycje, 'P_127' ) )
   hDane['P_128'] := sxml2num( xmlWartoscH( hPozycje, 'P_128' ) )
   hDane['P_129'] := sxml2num( xmlWartoscH( hPozycje, 'P_129' ) )
   hDane['P_130'] := sxml2num( xmlWartoscH( hPozycje, 'P_130' ) )
   hDane['P_131'] := sxml2num( xmlWartoscH( hPozycje, 'P_131' ) )
   hDane['P_132'] := sxml2num( xmlWartoscH( hPozycje, 'P_132' ) )
   hDane['P_133'] := sxml2num( xmlWartoscH( hPozycje, 'P_133' ) )
   hDane['P_134'] := sxml2num( xmlWartoscH( hPozycje, 'P_134' ) )
   hDane['P_135'] := sxml2num( xmlWartoscH( hPozycje, 'P_135' ) )
   hDane['P_136'] := sxml2num( xmlWartoscH( hPozycje, 'P_136' ) )
   hDane['P_137'] := sxml2num( xmlWartoscH( hPozycje, 'P_137' ) )
   hDane['P_138'] := sxml2num( xmlWartoscH( hPozycje, 'P_138' ) )
   hDane['P_139'] := sxml2num( xmlWartoscH( hPozycje, 'P_139' ) )
   hDane['P_140'] := sxml2num( xmlWartoscH( hPozycje, 'P_140' ) )
   hDane['P_141'] := sxml2num( xmlWartoscH( hPozycje, 'P_141' ) )
   hDane['P_142'] := sxml2num( xmlWartoscH( hPozycje, 'P_142' ) )
   hDane['P_143'] := sxml2num( xmlWartoscH( hPozycje, 'P_143' ) )
   hDane['P_144'] := sxml2num( xmlWartoscH( hPozycje, 'P_144' ) )
   hDane['P_145'] := sxml2num( xmlWartoscH( hPozycje, 'P_145' ) )
   hDane['P_146'] := sxml2num( xmlWartoscH( hPozycje, 'P_146' ) )
   hDane['P_147'] := sxml2num( xmlWartoscH( hPozycje, 'P_147' ) )
   hDane['P_148'] := sxml2num( xmlWartoscH( hPozycje, 'P_148' ) )
   hDane['P_149'] := sxml2num( xmlWartoscH( hPozycje, 'P_149' ) )
   hDane['P_150'] := sxml2num( xmlWartoscH( hPozycje, 'P_150' ) )
   hDane['P_151'] := sxml2num( xmlWartoscH( hPozycje, 'P_151' ) )
   hDane['P_152'] := sxml2num( xmlWartoscH( hPozycje, 'P_152' ) )
   hDane['P_153'] := sxml2num( xmlWartoscH( hPozycje, 'P_153' ) )
   hDane['P_154'] := sxml2num( xmlWartoscH( hPozycje, 'P_154' ) )
   hDane['P_155'] := sxml2num( xmlWartoscH( hPozycje, 'P_155' ) )
   hDane['P_156'] := sxml2num( xmlWartoscH( hPozycje, 'P_156' ) )
   hDane['P_157'] := sxml2num( xmlWartoscH( hPozycje, 'P_157' ) )
   hDane['P_158'] := sxml2num( xmlWartoscH( hPozycje, 'P_158' ) )
   hDane['P_159'] := sxml2num( xmlWartoscH( hPozycje, 'P_159' ) )
   hDane['P_160'] := sxml2num( xmlWartoscH( hPozycje, 'P_160' ) )
   hDane['P_161'] := sxml2num( xmlWartoscH( hPozycje, 'P_161' ) )
   hDane['P_162'] := sxml2num( xmlWartoscH( hPozycje, 'P_162' ) )
   hDane['P_163'] := sxml2num( xmlWartoscH( hPozycje, 'P_163' ) )
   hDane['P_164'] := sxml2num( xmlWartoscH( hPozycje, 'P_164' ) )
   hDane['P_165'] := sxml2num( xmlWartoscH( hPozycje, 'P_165' ) )
   hDane['P_166'] := sxml2num( xmlWartoscH( hPozycje, 'P_166' ) )
   hDane['P_167'] := sxml2num( xmlWartoscH( hPozycje, 'P_167' ) )
   hDane['P_168'] := sxml2num( xmlWartoscH( hPozycje, 'P_168' ) )
   hDane['P_168'] := sxml2num( xmlWartoscH( hPozycje, 'P_168' ) )
   hDane['P_169'] := xmlWartoscH( hPozycje, 'P_169', '' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_8_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_8_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF   */

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw8()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif( spolka_, '1', '0' )
   hDane['P_7_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_8'] := AllTrim(P8)
   hDane['P_9']  := z1a01
   hDane['P_10'] := z1a02
   hDane['P_11'] := z1a03
   hDane['P_12'] := z1a04
   hDane['P_13'] := z1a05
   hDane['P_14'] := z1a06
   hDane['P_15'] := z1b01
   hDane['P_16'] := z1b02
   hDane['P_17'] := z1b03
   hDane['P_18'] := z1b04
   hDane['P_19'] := z1b05
   hDane['P_20'] := z1b06
   hDane['P_21'] := z1a07
   hDane['P_22'] := z1a08
   hDane['P_23'] := z1a09
   hDane['P_24'] := z1a10
   hDane['P_25'] := z1a11
   hDane['P_26'] := z1a12
   hDane['P_27'] := z1b07
   hDane['P_28'] := z1b08
   hDane['P_29'] := z1b09
   hDane['P_30'] := z1b10
   hDane['P_31'] := z1b11
   hDane['P_32'] := z1b12
   hDane['P_33'] := z201
   hDane['P_34'] := z202
   hDane['P_35'] := z203
   hDane['P_36'] := z204
   hDane['P_37'] := z205
   hDane['P_38'] := z206
   hDane['P_39'] := z207
   hDane['P_40'] := z208
   hDane['P_41'] := z209
   hDane['P_42'] := z210
   hDane['P_43'] := z211
   hDane['P_44'] := z212
   hDane['P_45'] := z1001
   hDane['P_46'] := z1002
   hDane['P_47'] := z1003
   hDane['P_48'] := z1004
   hDane['P_49'] := z1005
   hDane['P_50'] := z1006
   hDane['P_51'] := z1007
   hDane['P_52'] := z1008
   hDane['P_53'] := z1009
   hDane['P_54'] := z1010
   hDane['P_55'] := z1011
   hDane['P_56'] := z1012
   hDane['P_57'] := z901
   hDane['P_58'] := z902
   hDane['P_59'] := z903
   hDane['P_60'] := z904
   hDane['P_61'] := z905
   hDane['P_62'] := z906
   hDane['P_63'] := z907
   hDane['P_64'] := z908
   hDane['P_65'] := z909
   hDane['P_66'] := z910
   hDane['P_67'] := z911
   hDane['P_68'] := z912
   hDane['P_69'] := z301
   hDane['P_70'] := z302
   hDane['P_71'] := z303
   hDane['P_72'] := z304
   hDane['P_73'] := z305
   hDane['P_74'] := z306
   hDane['P_75'] := z307
   hDane['P_76'] := z308
   hDane['P_77'] := z309
   hDane['P_78'] := z310
   hDane['P_79'] := z311
   hDane['P_80'] := z312
   hDane['P_82'] := z401
   hDane['P_81'] := z402
   hDane['P_83'] := z403
   hDane['P_84'] := z404
   hDane['P_85'] := z405
   hDane['P_86'] := z406
   hDane['P_87'] := z407
   hDane['P_88'] := z408
   hDane['P_89'] := z409
   hDane['P_90'] := z410
   hDane['P_91'] := z411
   hDane['P_92'] := z412
   hDane['P_93'] := z501
   hDane['P_94'] := z502
   hDane['P_95'] := z503
   hDane['P_96'] := z504
   hDane['P_97'] := z505
   hDane['P_98'] := z506
   hDane['P_99'] := z507
   hDane['P_100'] := z508
   hDane['P_101'] := z509
   hDane['P_102'] := z510
   hDane['P_103'] := z511
   hDane['P_104'] := z512
   hDane['P_105'] := z601
   hDane['P_106'] := z602
   hDane['P_107'] := z603
   hDane['P_108'] := z604
   hDane['P_109'] := z701
   hDane['P_110'] := z702
   hDane['P_111'] := z703
   hDane['P_112'] := z704
   hDane['P_113'] := z705
   hDane['P_114'] := z706
   hDane['P_115'] := z707
   hDane['P_116'] := z708
   hDane['P_117'] := z709
   hDane['P_118'] := z710
   hDane['P_119'] := z711
   hDane['P_120'] := z712
   hDane['P_121'] := z801
   hDane['P_122'] := z802
   hDane['P_123'] := z803
   hDane['P_124'] := z804
   hDane['P_125'] := z805
   hDane['P_126'] := z806
   hDane['P_127'] := z807
   hDane['P_128'] := z808
   hDane['P_129'] := z809
   hDane['P_130'] := z810
   hDane['P_131'] := z811
   hDane['P_132'] := z812
   hDane['P_133'] := z1101
   hDane['P_134'] := z1102
   hDane['P_135'] := z1103
   hDane['P_136'] := z1104
   hDane['P_137'] := z1105
   hDane['P_138'] := z1106
   hDane['P_139'] := z1107
   hDane['P_140'] := z1108
   hDane['P_141'] := z1109
   hDane['P_142'] := z1110
   hDane['P_143'] := z1111
   hDane['P_144'] := z1112
   hDane['P_145'] := z1201
   hDane['P_146'] := z1202
   hDane['P_147'] := z1203
   hDane['P_148'] := z1204
   hDane['P_149'] := z1205
   hDane['P_150'] := z1206
   hDane['P_151'] := z1207
   hDane['P_152'] := z1208
   hDane['P_153'] := z1209
   hDane['P_154'] := z1210
   hDane['P_155'] := z1211
   hDane['P_156'] := z1212
   hDane['P_157'] := z1301
   hDane['P_158'] := z1302
   hDane['P_159'] := z1303
   hDane['P_160'] := z1304
   hDane['P_161'] := z1305
   hDane['P_162'] := z1306
   hDane['P_163'] := z1307
   hDane['P_164'] := z1308
   hDane['P_165'] := z1309
   hDane['P_166'] := z1310
   hDane['P_167'] := z1311
   hDane['P_168'] := z1312
   hDane['P_169'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw9()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_10']  := z1a01
   hDane['P_11'] := z1a02
   hDane['P_12'] := z1a03
   hDane['P_13'] := z1a04
   hDane['P_14'] := z1a05
   hDane['P_15'] := z1a06
   hDane['P_16'] := z1b01
   hDane['P_17'] := z1b02
   hDane['P_18'] := z1b03
   hDane['P_19'] := z1b04
   hDane['P_20'] := z1b05
   hDane['P_21'] := z1b06
   hDane['P_22'] := z1a07
   hDane['P_23'] := z1a08
   hDane['P_24'] := z1a09
   hDane['P_25'] := z1a10
   hDane['P_26'] := z1a11
   hDane['P_27'] := z1a12
   hDane['P_28'] := z1b07
   hDane['P_29'] := z1b08
   hDane['P_30'] := z1b09
   hDane['P_31'] := z1b10
   hDane['P_32'] := z1b11
   hDane['P_33'] := z1b12
   hDane['P_34'] := z201
   hDane['P_35'] := z202
   hDane['P_36'] := z203
   hDane['P_37'] := z204
   hDane['P_38'] := z205
   hDane['P_39'] := z206
   hDane['P_40'] := z207
   hDane['P_41'] := z208
   hDane['P_42'] := z209
   hDane['P_43'] := z210
   hDane['P_44'] := z211
   hDane['P_45'] := z212
   hDane['P_46'] := z1001
   hDane['P_47'] := z1002
   hDane['P_48'] := z1003
   hDane['P_49'] := z1004
   hDane['P_50'] := z1005
   hDane['P_51'] := z1006
   hDane['P_52'] := z1007
   hDane['P_53'] := z1008
   hDane['P_54'] := z1009
   hDane['P_55'] := z1010
   hDane['P_56'] := z1011
   hDane['P_57'] := z1012
   hDane['P_58'] := z901
   hDane['P_59'] := z902
   hDane['P_60'] := z903
   hDane['P_61'] := z904
   hDane['P_62'] := z905
   hDane['P_63'] := z906
   hDane['P_64'] := z907
   hDane['P_65'] := z908
   hDane['P_66'] := z909
   hDane['P_67'] := z910
   hDane['P_68'] := z911
   hDane['P_69'] := z912
   hDane['P_70'] := z301
   hDane['P_71'] := z302
   hDane['P_72'] := z303
   hDane['P_73'] := z304
   hDane['P_74'] := z305
   hDane['P_75'] := z306
   hDane['P_76'] := z307
   hDane['P_77'] := z308
   hDane['P_78'] := z309
   hDane['P_79'] := z310
   hDane['P_80'] := z311
   hDane['P_81'] := z312
   hDane['P_82'] := z401
   hDane['P_83'] := z402
   hDane['P_84'] := z403
   hDane['P_85'] := z404
   hDane['P_86'] := z405
   hDane['P_87'] := z406
   hDane['P_88'] := z407
   hDane['P_89'] := z408
   hDane['P_90'] := z409
   hDane['P_91'] := z410
   hDane['P_92'] := z411
   hDane['P_93'] := z412
   hDane['P_94'] := z501
   hDane['P_95'] := z502
   hDane['P_96'] := z503
   hDane['P_97'] := z504
   hDane['P_98'] := z505
   hDane['P_99'] := z506
   hDane['P_100'] := z507
   hDane['P_101'] := z508
   hDane['P_102'] := z509
   hDane['P_103'] := z510
   hDane['P_104'] := z511
   hDane['P_105'] := z512
   hDane['P_106'] := z601
   hDane['P_107'] := z602
   hDane['P_108'] := z603
   hDane['P_109'] := z604
   hDane['P_110'] := z701
   hDane['P_111'] := z702
   hDane['P_112'] := z703
   hDane['P_113'] := z704
   hDane['P_114'] := z705
   hDane['P_115'] := z706
   hDane['P_116'] := z707
   hDane['P_117'] := z708
   hDane['P_118'] := z709
   hDane['P_119'] := z710
   hDane['P_120'] := z711
   hDane['P_121'] := z712
   hDane['P_122'] := z801
   hDane['P_123'] := z802
   hDane['P_124'] := z803
   hDane['P_125'] := z804
   hDane['P_126'] := z805
   hDane['P_127'] := z806
   hDane['P_128'] := z807
   hDane['P_129'] := z808
   hDane['P_130'] := z809
   hDane['P_131'] := z810
   hDane['P_132'] := z811
   hDane['P_133'] := z812
   hDane['P_134'] := z1101
   hDane['P_135'] := z1102
   hDane['P_136'] := z1103
   hDane['P_137'] := z1104
   hDane['P_138'] := z1105
   hDane['P_139'] := z1106
   hDane['P_140'] := z1107
   hDane['P_141'] := z1108
   hDane['P_142'] := z1109
   hDane['P_143'] := z1110
   hDane['P_144'] := z1111
   hDane['P_145'] := z1112
   hDane['P_146'] := z1201
   hDane['P_147'] := z1202
   hDane['P_148'] := z1203
   hDane['P_149'] := z1204
   hDane['P_150'] := z1205
   hDane['P_151'] := z1206
   hDane['P_152'] := z1207
   hDane['P_153'] := z1208
   hDane['P_154'] := z1209
   hDane['P_155'] := z1210
   hDane['P_156'] := z1211
   hDane['P_157'] := z1212
   hDane['P_158'] := z1301
   hDane['P_159'] := z1302
   hDane['P_160'] := z1303
   hDane['P_161'] := z1304
   hDane['P_162'] := z1305
   hDane['P_163'] := z1306
   hDane['P_164'] := z1307
   hDane['P_165'] := z1308
   hDane['P_166'] := z1309
   hDane['P_167'] := z1310
   hDane['P_168'] := z1311
   hDane['P_169'] := z1312
   hDane['P_170'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw10()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_10']  := z1a01
   hDane['P_11'] := z1a02
   hDane['P_12'] := z1a03
   hDane['P_13'] := z1a04
   hDane['P_14'] := z1a05
   hDane['P_15'] := z1a06
   hDane['P_16'] := z1b01
   hDane['P_17'] := z1b02
   hDane['P_18'] := z1b03
   hDane['P_19'] := z1b04
   hDane['P_20'] := z1b05
   hDane['P_21'] := z1b06
   hDane['P_22'] := z1a07
   hDane['P_23'] := z1a08
   hDane['P_24'] := z1a09
   hDane['P_25'] := z1a10
   hDane['P_26'] := z1a11
   hDane['P_27'] := z1a12
   hDane['P_28'] := z1b07
   hDane['P_29'] := z1b08
   hDane['P_30'] := z1b09
   hDane['P_31'] := z1b10
   hDane['P_32'] := z1b11
   hDane['P_33'] := z1b12
   hDane['P_34'] := z201
   hDane['P_35'] := z202
   hDane['P_36'] := z203
   hDane['P_37'] := z204
   hDane['P_38'] := z205
   hDane['P_39'] := z206
   hDane['P_40'] := z207
   hDane['P_41'] := z208
   hDane['P_42'] := z209
   hDane['P_43'] := z210
   hDane['P_44'] := z211
   hDane['P_45'] := z212
   hDane['P_46'] := z1001
   hDane['P_47'] := z1002
   hDane['P_48'] := z1003
   hDane['P_49'] := z1004
   hDane['P_50'] := z1005
   hDane['P_51'] := z1006
   hDane['P_52'] := z1007
   hDane['P_53'] := z1008
   hDane['P_54'] := z1009
   hDane['P_55'] := z1010
   hDane['P_56'] := z1011
   hDane['P_57'] := z1012
   hDane['P_58'] := z901
   hDane['P_59'] := z902
   hDane['P_60'] := z903
   hDane['P_61'] := z904
   hDane['P_62'] := z905
   hDane['P_63'] := z906
   hDane['P_64'] := z907
   hDane['P_65'] := z908
   hDane['P_66'] := z909
   hDane['P_67'] := z910
   hDane['P_68'] := z911
   hDane['P_69'] := z912
   hDane['P_70'] := z301
   hDane['P_71'] := z302
   hDane['P_72'] := z303
   hDane['P_73'] := z304
   hDane['P_74'] := z305
   hDane['P_75'] := z306
   hDane['P_76'] := z307
   hDane['P_77'] := z308
   hDane['P_78'] := z309
   hDane['P_79'] := z310
   hDane['P_80'] := z311
   hDane['P_81'] := z312
   hDane['P_82'] := z401
   hDane['P_83'] := z402
   hDane['P_84'] := z403
   hDane['P_85'] := z404
   hDane['P_86'] := z405
   hDane['P_87'] := z406
   hDane['P_88'] := z407
   hDane['P_89'] := z408
   hDane['P_90'] := z409
   hDane['P_91'] := z410
   hDane['P_92'] := z411
   hDane['P_93'] := z412
   hDane['P_94'] := z501
   hDane['P_95'] := z502
   hDane['P_96'] := z503
   hDane['P_97'] := z504
   hDane['P_98'] := z505
   hDane['P_99'] := z506
   hDane['P_100'] := z507
   hDane['P_101'] := z508
   hDane['P_102'] := z509
   hDane['P_103'] := z510
   hDane['P_104'] := z511
   hDane['P_105'] := z512
   hDane['P_106'] := z601
   hDane['P_107'] := z602
   hDane['P_108'] := z603
   hDane['P_109'] := z604
   hDane['P_110'] := z801
   hDane['P_111'] := z802
   hDane['P_112'] := z803
   hDane['P_113'] := z804
   hDane['P_114'] := z805
   hDane['P_115'] := z806
   hDane['P_116'] := z807
   hDane['P_117'] := z808
   hDane['P_118'] := z809
   hDane['P_119'] := z810
   hDane['P_120'] := z811
   hDane['P_121'] := z812
   hDane['P_122'] := z1101
   hDane['P_123'] := z1102
   hDane['P_124'] := z1103
   hDane['P_125'] := z1104
   hDane['P_126'] := z1105
   hDane['P_127'] := z1106
   hDane['P_128'] := z1107
   hDane['P_129'] := z1108
   hDane['P_130'] := z1109
   hDane['P_131'] := z1110
   hDane['P_132'] := z1111
   hDane['P_133'] := z1112
   hDane['P_134'] := z1201
   hDane['P_135'] := z1202
   hDane['P_136'] := z1203
   hDane['P_137'] := z1204
   hDane['P_138'] := z1205
   hDane['P_139'] := z1206
   hDane['P_140'] := z1207
   hDane['P_141'] := z1208
   hDane['P_142'] := z1209
   hDane['P_143'] := z1210
   hDane['P_144'] := z1211
   hDane['P_145'] := z1212
   hDane['P_146'] := z1301
   hDane['P_147'] := z1302
   hDane['P_148'] := z1303
   hDane['P_149'] := z1304
   hDane['P_150'] := z1305
   hDane['P_151'] := z1306
   hDane['P_152'] := z1307
   hDane['P_153'] := z1308
   hDane['P_154'] := z1309
   hDane['P_155'] := z1310
   hDane['P_156'] := z1311
   hDane['P_157'] := z1312
   hDane['P_158'] := ''
   hDane['P_159'] := '0'
   hDane['P_160'] := '0'
   hDane['P_161'] := '0'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw11()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_10']  := z1a01
   hDane['P_11'] := z1a02
   hDane['P_12'] := z1a03
   hDane['P_13'] := z1a04
   hDane['P_14'] := z1a05
   hDane['P_15'] := z1a06
   hDane['P_16'] := z1b01
   hDane['P_17'] := z1b02
   hDane['P_18'] := z1b03
   hDane['P_19'] := z1b04
   hDane['P_20'] := z1b05
   hDane['P_21'] := z1b06
   hDane['P_22'] := z1a07
   hDane['P_23'] := z1a08
   hDane['P_24'] := z1a09
   hDane['P_25'] := z1a10
   hDane['P_26'] := z1a11
   hDane['P_27'] := z1a12
   hDane['P_28'] := z1b07
   hDane['P_29'] := z1b08
   hDane['P_30'] := z1b09
   hDane['P_31'] := z1b10
   hDane['P_32'] := z1b11
   hDane['P_33'] := z1b12
   hDane['P_34'] := z201
   hDane['P_35'] := z202
   hDane['P_36'] := z203
   hDane['P_37'] := z204
   hDane['P_38'] := z205
   hDane['P_39'] := z206
   hDane['P_40'] := z207
   hDane['P_41'] := z208
   hDane['P_42'] := z209
   hDane['P_43'] := z210
   hDane['P_44'] := z211
   hDane['P_45'] := z212
   hDane['P_46'] := z1001
   hDane['P_47'] := z1002
   hDane['P_48'] := z1003
   hDane['P_49'] := z1004
   hDane['P_50'] := z1005
   hDane['P_51'] := z1006
   hDane['P_52'] := z1007
   hDane['P_53'] := z1008
   hDane['P_54'] := z1009
   hDane['P_55'] := z1010
   hDane['P_56'] := z1011
   hDane['P_57'] := z1012
   hDane['P_58'] := z901
   hDane['P_59'] := z902
   hDane['P_60'] := z903
   hDane['P_61'] := z904
   hDane['P_62'] := z905
   hDane['P_63'] := z906
   hDane['P_64'] := z907
   hDane['P_65'] := z908
   hDane['P_66'] := z909
   hDane['P_67'] := z910
   hDane['P_68'] := z911
   hDane['P_69'] := z912
   hDane['P_70'] := z301
   hDane['P_71'] := z302
   hDane['P_72'] := z303
   hDane['P_73'] := z304
   hDane['P_74'] := z305
   hDane['P_75'] := z306
   hDane['P_76'] := z307
   hDane['P_77'] := z308
   hDane['P_78'] := z309
   hDane['P_79'] := z310
   hDane['P_80'] := z311
   hDane['P_81'] := z312
   hDane['P_82'] := z401
   hDane['P_83'] := z402
   hDane['P_84'] := z403
   hDane['P_85'] := z404
   hDane['P_86'] := z405
   hDane['P_87'] := z406
   hDane['P_88'] := z407
   hDane['P_89'] := z408
   hDane['P_90'] := z409
   hDane['P_91'] := z410
   hDane['P_92'] := z411
   hDane['P_93'] := z412
   hDane['P_94'] := z501
   hDane['P_95'] := z502
   hDane['P_96'] := z503
   hDane['P_97'] := z504
   hDane['P_98'] := z505
   hDane['P_99'] := z506
   hDane['P_100'] := z507
   hDane['P_101'] := z508
   hDane['P_102'] := z509
   hDane['P_103'] := z510
   hDane['P_104'] := z511
   hDane['P_105'] := z512
   hDane['P_106'] := z601
   hDane['P_107'] := z602
   hDane['P_108'] := z603
   hDane['P_109'] := z604
   hDane['P_110'] := z801
   hDane['P_111'] := z802
   hDane['P_112'] := z803
   hDane['P_113'] := z804
   hDane['P_114'] := z805
   hDane['P_115'] := z806
   hDane['P_116'] := z807
   hDane['P_117'] := z808
   hDane['P_118'] := z809
   hDane['P_119'] := z810
   hDane['P_120'] := z811
   hDane['P_121'] := z812
   hDane['P_122'] := z1101
   hDane['P_123'] := z1102
   hDane['P_124'] := z1103
   hDane['P_125'] := z1104
   hDane['P_126'] := z1105
   hDane['P_127'] := z1106
   hDane['P_128'] := z1107
   hDane['P_129'] := z1108
   hDane['P_130'] := z1109
   hDane['P_131'] := z1110
   hDane['P_132'] := z1111
   hDane['P_133'] := z1112
   hDane['P_134'] := z1201
   hDane['P_135'] := z1202
   hDane['P_136'] := z1203
   hDane['P_137'] := z1204
   hDane['P_138'] := z1205
   hDane['P_139'] := z1206
   hDane['P_140'] := z1207
   hDane['P_141'] := z1208
   hDane['P_142'] := z1209
   hDane['P_143'] := z1210
   hDane['P_144'] := z1211
   hDane['P_145'] := z1212
   hDane['P_146'] := z1301
   hDane['P_147'] := z1302
   hDane['P_148'] := z1303
   hDane['P_149'] := z1304
   hDane['P_150'] := z1305
   hDane['P_151'] := z1306
   hDane['P_152'] := z1307
   hDane['P_153'] := z1308
   hDane['P_154'] := z1309
   hDane['P_155'] := z1310
   hDane['P_156'] := z1311
   hDane['P_157'] := z1312
   hDane['P_158'] := ''
   hDane['P_159'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_160'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_161'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_162'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_163'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_164'] := iif( aPit48Covid[ 6 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw12()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_10']  := z1a01
   hDane['P_11'] := z1a02
   hDane['P_12'] := z1a03
   hDane['P_13'] := z1a04
   hDane['P_14'] := z1a05
   hDane['P_15'] := z1a06
   hDane['P_16'] := z1b01
   hDane['P_17'] := z1b02
   hDane['P_18'] := z1b03
   hDane['P_19'] := z1b04
   hDane['P_20'] := z1b05
   hDane['P_21'] := z1b06
   hDane['P_22'] := z1a07
   hDane['P_23'] := z1a08
   hDane['P_24'] := z1a09
   hDane['P_25'] := z1a10
   hDane['P_26'] := z1a11
   hDane['P_27'] := z1a12
   hDane['P_28'] := z1b07
   hDane['P_29'] := z1b08
   hDane['P_30'] := z1b09
   hDane['P_31'] := z1b10
   hDane['P_32'] := z1b11
   hDane['P_33'] := z1b12
   hDane['P_34'] := z201
   hDane['P_35'] := z202
   hDane['P_36'] := z203
   hDane['P_37'] := z204
   hDane['P_38'] := z205
   hDane['P_39'] := z206
   hDane['P_40'] := z207
   hDane['P_41'] := z208
   hDane['P_42'] := z209
   hDane['P_43'] := z210
   hDane['P_44'] := z211
   hDane['P_45'] := z212
   hDane['P_46'] := z1001
   hDane['P_47'] := z1002
   hDane['P_48'] := z1003
   hDane['P_49'] := z1004
   hDane['P_50'] := z1005
   hDane['P_51'] := z1006
   hDane['P_52'] := z1007
   hDane['P_53'] := z1008
   hDane['P_54'] := z1009
   hDane['P_55'] := z1010
   hDane['P_56'] := z1011
   hDane['P_57'] := z1012
   hDane['P_58'] := z901
   hDane['P_59'] := z902
   hDane['P_60'] := z903
   hDane['P_61'] := z904
   hDane['P_62'] := z905
   hDane['P_63'] := z906
   hDane['P_64'] := z907
   hDane['P_65'] := z908
   hDane['P_66'] := z909
   hDane['P_67'] := z910
   hDane['P_68'] := z911
   hDane['P_69'] := z912
   hDane['P_70'] := z301
   hDane['P_71'] := z302
   hDane['P_72'] := z303
   hDane['P_73'] := z304
   hDane['P_74'] := z305
   hDane['P_75'] := z306
   hDane['P_76'] := z307
   hDane['P_77'] := z308
   hDane['P_78'] := z309
   hDane['P_79'] := z310
   hDane['P_80'] := z311
   hDane['P_81'] := z312
   hDane['P_82'] := z401
   hDane['P_83'] := z402
   hDane['P_84'] := z403
   hDane['P_85'] := z404
   hDane['P_86'] := z405
   hDane['P_87'] := z406
   hDane['P_88'] := z407
   hDane['P_89'] := z408
   hDane['P_90'] := z409
   hDane['P_91'] := z410
   hDane['P_92'] := z411
   hDane['P_93'] := z412
   hDane['P_94'] := z501
   hDane['P_95'] := z502
   hDane['P_96'] := z503
   hDane['P_97'] := z504
   hDane['P_98'] := z505
   hDane['P_99'] := z506
   hDane['P_100'] := z507
   hDane['P_101'] := z508
   hDane['P_102'] := z509
   hDane['P_103'] := z510
   hDane['P_104'] := z511
   hDane['P_105'] := z512
   hDane['P_106'] := z601
   hDane['P_107'] := z602
   hDane['P_108'] := z603
   hDane['P_109'] := z604
   hDane['P_110'] := z801
   hDane['P_111'] := z802
   hDane['P_112'] := z803
   hDane['P_113'] := z804
   hDane['P_114'] := z805
   hDane['P_115'] := z806
   hDane['P_116'] := z807
   hDane['P_117'] := z808
   hDane['P_118'] := z809
   hDane['P_119'] := z810
   hDane['P_120'] := z811
   hDane['P_121'] := z812
   hDane['P_122'] := z1101
   hDane['P_123'] := z1102
   hDane['P_124'] := z1103
   hDane['P_125'] := z1104
   hDane['P_126'] := z1105
   hDane['P_127'] := z1106
   hDane['P_128'] := z1107
   hDane['P_129'] := z1108
   hDane['P_130'] := z1109
   hDane['P_131'] := z1110
   hDane['P_132'] := z1111
   hDane['P_133'] := z1112
   hDane['P_134'] := z1201
   hDane['P_135'] := z1202
   hDane['P_136'] := z1203
   hDane['P_137'] := z1204
   hDane['P_138'] := z1205
   hDane['P_139'] := z1206
   hDane['P_140'] := z1207
   hDane['P_141'] := z1208
   hDane['P_142'] := z1209
   hDane['P_143'] := z1210
   hDane['P_144'] := z1211
   hDane['P_145'] := z1212
   hDane['P_146'] := z1301
   hDane['P_147'] := z1302
   hDane['P_148'] := z1303
   hDane['P_149'] := z1304
   hDane['P_150'] := z1305
   hDane['P_151'] := z1306
   hDane['P_152'] := z1307
   hDane['P_153'] := z1308
   hDane['P_154'] := z1309
   hDane['P_155'] := z1310
   hDane['P_156'] := z1311
   hDane['P_157'] := z1312
   hDane['P_158'] := ''
   hDane['P_159'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_160'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_161'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_162'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_163'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_164'] := iif( aPit48Covid[ 6 ], '1', '0' )
   hDane['P_165'] := iif( aPit48Covid[ 7 ], '1', '0' )
   hDane['P_166'] := iif( aPit48Covid[ 8 ], '1', '0' )
   hDane['P_167'] := iif( aPit48Covid[ 9 ], '1', '0' )
   hDane['P_168'] := iif( aPit48Covid[ 10 ], '1', '0' )
   hDane['P_169'] := iif( aPit48Covid[ 11 ], '1', '0' )
   hDane['P_170'] := iif( aPit48Covid[ 12 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT4Rw13()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_10']  := z1a01
   hDane['P_11'] := z1a02
   hDane['P_12'] := z1a03
   hDane['P_13'] := z1a04
   hDane['P_14'] := z1a05
   hDane['P_15'] := z1a06
   hDane['P_16'] := z1b01
   hDane['P_17'] := z1b02
   hDane['P_18'] := z1b03
   hDane['P_19'] := z1b04
   hDane['P_20'] := z1b05
   hDane['P_21'] := z1b06
   hDane['P_22'] := z1a07
   hDane['P_23'] := z1a08
   hDane['P_24'] := z1a09
   hDane['P_25'] := z1a10
   hDane['P_26'] := z1a11
   hDane['P_27'] := z1a12
   hDane['P_28'] := z1b07
   hDane['P_29'] := z1b08
   hDane['P_30'] := z1b09
   hDane['P_31'] := z1b10
   hDane['P_32'] := z1b11
   hDane['P_33'] := z1b12
   hDane['P_34'] := z201
   hDane['P_35'] := z202
   hDane['P_36'] := z203
   hDane['P_37'] := z204
   hDane['P_38'] := z205
   hDane['P_39'] := z206
   hDane['P_40'] := z207
   hDane['P_41'] := z208
   hDane['P_42'] := z209
   hDane['P_43'] := z210
   hDane['P_44'] := z211
   hDane['P_45'] := z212
   hDane['P_46'] := z1001
   hDane['P_47'] := z1002
   hDane['P_48'] := z1003
   hDane['P_49'] := z1004
   hDane['P_50'] := z1005
   hDane['P_51'] := z1006
   hDane['P_52'] := z1007
   hDane['P_53'] := z1008
   hDane['P_54'] := z1009
   hDane['P_55'] := z1010
   hDane['P_56'] := z1011
   hDane['P_57'] := z1012
   hDane['P_58'] := z901
   hDane['P_59'] := z902
   hDane['P_60'] := z903
   hDane['P_61'] := z904
   hDane['P_62'] := z905
   hDane['P_63'] := z906
   hDane['P_64'] := z907
   hDane['P_65'] := z908
   hDane['P_66'] := z909
   hDane['P_67'] := z910
   hDane['P_68'] := z911
   hDane['P_69'] := z912
   hDane['P_70'] := z301
   hDane['P_71'] := z302
   hDane['P_72'] := z303
   hDane['P_73'] := z304
   hDane['P_74'] := z305
   hDane['P_75'] := z306
   hDane['P_76'] := z307
   hDane['P_77'] := z308
   hDane['P_78'] := z309
   hDane['P_79'] := z310
   hDane['P_80'] := z311
   hDane['P_81'] := z312
   hDane['P_82'] := z401
   hDane['P_83'] := z402
   hDane['P_84'] := z403
   hDane['P_85'] := z404
   hDane['P_86'] := z405
   hDane['P_87'] := z406
   hDane['P_88'] := z407
   hDane['P_89'] := z408
   hDane['P_90'] := z409
   hDane['P_91'] := z410
   hDane['P_92'] := z411
   hDane['P_93'] := z412
   hDane['P_94'] := z501
   hDane['P_95'] := z502
   hDane['P_96'] := z503
   hDane['P_97'] := z504
   hDane['P_98'] := z505
   hDane['P_99'] := z506
   hDane['P_100'] := z507
   hDane['P_101'] := z508
   hDane['P_102'] := z509
   hDane['P_103'] := z510
   hDane['P_104'] := z511
   hDane['P_105'] := z512
   hDane['P_106'] := z601
   hDane['P_107'] := z602
   hDane['P_108'] := z603
   hDane['P_109'] := z604
   hDane['P_110'] := z801
   hDane['P_111'] := z802
   hDane['P_112'] := z803
   hDane['P_113'] := z804
   hDane['P_114'] := z805
   hDane['P_115'] := z806
   hDane['P_116'] := z807
   hDane['P_117'] := z808
   hDane['P_118'] := z809
   hDane['P_119'] := z810
   hDane['P_120'] := z811
   hDane['P_121'] := z812
   hDane['P_122'] := z1101
   hDane['P_123'] := z1102
   hDane['P_124'] := z1103
   hDane['P_125'] := z1104
   hDane['P_126'] := z1105
   hDane['P_127'] := z1106
   hDane['P_128'] := z1107
   hDane['P_129'] := z1108
   hDane['P_130'] := z1109
   hDane['P_131'] := z1110
   hDane['P_132'] := z1111
   hDane['P_133'] := z1112
   hDane['P_134'] := z1201
   hDane['P_135'] := z1202
   hDane['P_136'] := z1203
   hDane['P_137'] := z1204
   hDane['P_138'] := z1205
   hDane['P_139'] := z1206
   hDane['P_140'] := z1207
   hDane['P_141'] := z1208
   hDane['P_142'] := z1209
   hDane['P_143'] := z1210
   hDane['P_144'] := z1211
   hDane['P_145'] := z1212
   hDane['P_146'] := z1301
   hDane['P_147'] := z1302
   hDane['P_148'] := z1303
   hDane['P_149'] := z1304
   hDane['P_150'] := z1305
   hDane['P_151'] := z1306
   hDane['P_152'] := z1307
   hDane['P_153'] := z1308
   hDane['P_154'] := z1309
   hDane['P_155'] := z1310
   hDane['P_156'] := z1311
   hDane['P_157'] := z1312
   hDane['P_158_1'] := '0'
   hDane['P_158_2'] := '1'
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := z1301
   hDane['P_172'] := z1302
   hDane['P_173'] := z1303
   hDane['P_174'] := z1304
   hDane['P_175'] := z1305
   hDane['P_176'] := z1306
   hDane['P_177'] := z1307
   hDane['P_178'] := z1308
   hDane['P_179'] := z1309
   hDane['P_180'] := z1310
   hDane['P_181'] := z1311
   hDane['P_182'] := z1312

   hDane['P_183'] := ''

   hDane['P_184'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_185'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_186'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_187'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_188'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_189'] := iif( aPit48Covid[ 6 ], '1', '0' )
   hDane['P_190'] := iif( aPit48Covid[ 7 ], '1', '0' )
   hDane['P_191'] := iif( aPit48Covid[ 8 ], '1', '0' )
   hDane['P_192'] := iif( aPit48Covid[ 9 ], '1', '0' )
   hDane['P_193'] := iif( aPit48Covid[ 10 ], '1', '0' )
   hDane['P_194'] := iif( aPit48Covid[ 11 ], '1', '0' )
   hDane['P_195'] := iif( aPit48Covid[ 12 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw6()
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   /* IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_5'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_6_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_6_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_9'] := sxml2num( xmlWartoscH( hPozycje, 'P_9' ) )
   hDane['P_10'] := sxml2num( xmlWartoscH( hPozycje, 'P_10' ) )
   hDane['P_11'] := sxml2num( xmlWartoscH( hPozycje, 'P_11' ) )
   hDane['P_12'] := sxml2num( xmlWartoscH( hPozycje, 'P_12' ) )
   hDane['P_13'] := sxml2num( xmlWartoscH( hPozycje, 'P_13' ) )
   hDane['P_14'] := sxml2num( xmlWartoscH( hPozycje, 'P_14' ) )
   hDane['P_15'] := sxml2num( xmlWartoscH( hPozycje, 'P_15' ) )
   hDane['P_16'] := sxml2num( xmlWartoscH( hPozycje, 'P_16' ) )
   hDane['P_17'] := sxml2num( xmlWartoscH( hPozycje, 'P_17' ) )
   hDane['P_18'] := sxml2num( xmlWartoscH( hPozycje, 'P_18' ) )
   hDane['P_19'] := sxml2num( xmlWartoscH( hPozycje, 'P_19' ) )
   hDane['P_20'] := sxml2num( xmlWartoscH( hPozycje, 'P_20' ) )
   hDane['P_21'] := sxml2num( xmlWartoscH( hPozycje, 'P_21' ) )
   hDane['P_22'] := sxml2num( xmlWartoscH( hPozycje, 'P_22' ) )
   hDane['P_23'] := sxml2num( xmlWartoscH( hPozycje, 'P_23' ) )
   hDane['P_24'] := sxml2num( xmlWartoscH( hPozycje, 'P_24' ) )
   hDane['P_25'] := sxml2num( xmlWartoscH( hPozycje, 'P_25' ) )
   hDane['P_26'] := sxml2num( xmlWartoscH( hPozycje, 'P_26' ) )
   hDane['P_27'] := sxml2num( xmlWartoscH( hPozycje, 'P_27' ) )
   hDane['P_28'] := sxml2num( xmlWartoscH( hPozycje, 'P_28' ) )
   hDane['P_29'] := sxml2num( xmlWartoscH( hPozycje, 'P_29' ) )
   hDane['P_30'] := sxml2num( xmlWartoscH( hPozycje, 'P_30' ) )
   hDane['P_31'] := sxml2num( xmlWartoscH( hPozycje, 'P_31' ) )
   hDane['P_32'] := sxml2num( xmlWartoscH( hPozycje, 'P_32' ) )
   hDane['P_33'] := sxml2num( xmlWartoscH( hPozycje, 'P_33' ) )
   hDane['P_34'] := sxml2num( xmlWartoscH( hPozycje, 'P_34' ) )
   hDane['P_35'] := sxml2num( xmlWartoscH( hPozycje, 'P_35' ) )
   hDane['P_36'] := sxml2num( xmlWartoscH( hPozycje, 'P_36' ) )
   hDane['P_37'] := sxml2num( xmlWartoscH( hPozycje, 'P_37' ) )
   hDane['P_38'] := sxml2num( xmlWartoscH( hPozycje, 'P_38' ) )
   hDane['P_39'] := sxml2num( xmlWartoscH( hPozycje, 'P_39' ) )
   hDane['P_40'] := sxml2num( xmlWartoscH( hPozycje, 'P_40' ) )
   hDane['P_41'] := sxml2num( xmlWartoscH( hPozycje, 'P_41' ) )
   hDane['P_42'] := sxml2num( xmlWartoscH( hPozycje, 'P_42' ) )
   hDane['P_43'] := sxml2num( xmlWartoscH( hPozycje, 'P_43' ) )
   hDane['P_44'] := sxml2num( xmlWartoscH( hPozycje, 'P_44' ) )
   hDane['P_45'] := sxml2num( xmlWartoscH( hPozycje, 'P_45' ) )
   hDane['P_46'] := sxml2num( xmlWartoscH( hPozycje, 'P_46' ) )
   hDane['P_47'] := sxml2num( xmlWartoscH( hPozycje, 'P_47' ) )
   hDane['P_48'] := sxml2num( xmlWartoscH( hPozycje, 'P_48' ) )
   hDane['P_49'] := sxml2num( xmlWartoscH( hPozycje, 'P_49' ) )
   hDane['P_50'] := sxml2num( xmlWartoscH( hPozycje, 'P_50' ) )
   hDane['P_51'] := sxml2num( xmlWartoscH( hPozycje, 'P_51' ) )
   hDane['P_52'] := sxml2num( xmlWartoscH( hPozycje, 'P_52' ) )
   hDane['P_53'] := sxml2num( xmlWartoscH( hPozycje, 'P_53' ) )
   hDane['P_54'] := sxml2num( xmlWartoscH( hPozycje, 'P_54' ) )
   hDane['P_55'] := sxml2num( xmlWartoscH( hPozycje, 'P_55' ) )
   hDane['P_56'] := sxml2num( xmlWartoscH( hPozycje, 'P_56' ) )
   hDane['P_57'] := sxml2num( xmlWartoscH( hPozycje, 'P_57' ) )
   hDane['P_58'] := sxml2num( xmlWartoscH( hPozycje, 'P_58' ) )
   hDane['P_59'] := sxml2num( xmlWartoscH( hPozycje, 'P_59' ) )
   hDane['P_60'] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
   hDane['P_61'] := sxml2num( xmlWartoscH( hPozycje, 'P_61' ) )
   hDane['P_62'] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
   hDane['P_63'] := sxml2num( xmlWartoscH( hPozycje, 'P_63' ) )
   hDane['P_64'] := sxml2num( xmlWartoscH( hPozycje, 'P_64' ) )
   hDane['P_65'] := sxml2num( xmlWartoscH( hPozycje, 'P_65' ) )
   hDane['P_66'] := sxml2num( xmlWartoscH( hPozycje, 'P_66' ) )
   hDane['P_67'] := sxml2num( xmlWartoscH( hPozycje, 'P_67' ) )
   hDane['P_68'] := sxml2num( xmlWartoscH( hPozycje, 'P_68' ) )
   hDane['P_69'] := sxml2num( xmlWartoscH( hPozycje, 'P_69' ) )
   hDane['P_70'] := sxml2num( xmlWartoscH( hPozycje, 'P_70' ) )
   hDane['P_71'] := sxml2num( xmlWartoscH( hPozycje, 'P_71' ) )
   hDane['P_72'] := sxml2num( xmlWartoscH( hPozycje, 'P_72' ) )
   hDane['P_73'] := sxml2num( xmlWartoscH( hPozycje, 'P_73' ) )
   hDane['P_74'] := sxml2num( xmlWartoscH( hPozycje, 'P_74' ) )
   hDane['P_75'] := sxml2num( xmlWartoscH( hPozycje, 'P_75' ) )
   hDane['P_76'] := sxml2num( xmlWartoscH( hPozycje, 'P_76' ) )
   hDane['P_77'] := sxml2num( xmlWartoscH( hPozycje, 'P_77' ) )
   hDane['P_78'] := sxml2num( xmlWartoscH( hPozycje, 'P_78' ) )
   hDane['P_79'] := sxml2num( xmlWartoscH( hPozycje, 'P_79' ) )
   hDane['P_80'] := sxml2num( xmlWartoscH( hPozycje, 'P_80' ) )
   hDane['P_81'] := sxml2num( xmlWartoscH( hPozycje, 'P_81' ) )
   hDane['P_82'] := sxml2num( xmlWartoscH( hPozycje, 'P_82' ) )
   hDane['P_83'] := sxml2num( xmlWartoscH( hPozycje, 'P_83' ) )
   hDane['P_84'] := sxml2num( xmlWartoscH( hPozycje, 'P_84' ) )
   hDane['P_85'] := sxml2num( xmlWartoscH( hPozycje, 'P_85' ) )
   hDane['P_86'] := sxml2num( xmlWartoscH( hPozycje, 'P_86' ) )
   hDane['P_87'] := sxml2num( xmlWartoscH( hPozycje, 'P_87' ) )
   hDane['P_88'] := sxml2num( xmlWartoscH( hPozycje, 'P_88' ) )
   hDane['P_89'] := sxml2num( xmlWartoscH( hPozycje, 'P_89' ) )
   hDane['P_90'] := sxml2num( xmlWartoscH( hPozycje, 'P_90' ) )
   hDane['P_91'] := sxml2num( xmlWartoscH( hPozycje, 'P_91' ) )
   hDane['P_92'] := sxml2num( xmlWartoscH( hPozycje, 'P_92' ) )
   hDane['P_93'] := sxml2num( xmlWartoscH( hPozycje, 'P_93' ) )
   hDane['P_94'] := sxml2num( xmlWartoscH( hPozycje, 'P_94' ) )
   hDane['P_95'] := sxml2num( xmlWartoscH( hPozycje, 'P_95' ) )
   hDane['P_96'] := sxml2num( xmlWartoscH( hPozycje, 'P_96' ) )
   hDane['P_97'] := sxml2num( xmlWartoscH( hPozycje, 'P_97' ) )
   hDane['P_98'] := sxml2num( xmlWartoscH( hPozycje, 'P_98' ) )
   hDane['P_99'] := sxml2num( xmlWartoscH( hPozycje, 'P_99' ) )
   hDane['P_100'] := sxml2num( xmlWartoscH( hPozycje, 'P_100' ) )
   hDane['P_101'] := sxml2num( xmlWartoscH( hPozycje, 'P_101' ) )
   hDane['P_102'] := sxml2num( xmlWartoscH( hPozycje, 'P_102' ) )
   hDane['P_103'] := sxml2num( xmlWartoscH( hPozycje, 'P_103' ) )
   hDane['P_104'] := sxml2num( xmlWartoscH( hPozycje, 'P_104' ) )
   hDane['P_105'] := sxml2num( xmlWartoscH( hPozycje, 'P_105' ) )
   hDane['P_106'] := sxml2num( xmlWartoscH( hPozycje, 'P_106' ) )
   hDane['P_107'] := sxml2num( xmlWartoscH( hPozycje, 'P_107' ) )
   hDane['P_108'] := sxml2num( xmlWartoscH( hPozycje, 'P_108' ) )
   hDane['P_109'] := sxml2num( xmlWartoscH( hPozycje, 'P_109' ) )
   hDane['P_110'] := sxml2num( xmlWartoscH( hPozycje, 'P_110' ) )
   hDane['P_111'] := sxml2num( xmlWartoscH( hPozycje, 'P_111' ) )
   hDane['P_112'] := sxml2num( xmlWartoscH( hPozycje, 'P_112' ) )
   hDane['P_113'] := sxml2num( xmlWartoscH( hPozycje, 'P_113' ) )
   hDane['P_114'] := sxml2num( xmlWartoscH( hPozycje, 'P_114' ) )
   hDane['P_115'] := sxml2num( xmlWartoscH( hPozycje, 'P_115' ) )
   hDane['P_116'] := sxml2num( xmlWartoscH( hPozycje, 'P_116' ) )
   hDane['P_117'] := sxml2num( xmlWartoscH( hPozycje, 'P_117' ) )
   hDane['P_118'] := sxml2num( xmlWartoscH( hPozycje, 'P_118' ) )
   hDane['P_119'] := sxml2num( xmlWartoscH( hPozycje, 'P_119' ) )
   hDane['P_120'] := sxml2num( xmlWartoscH( hPozycje, 'P_120' ) )
   hDane['P_121'] := sxml2num( xmlWartoscH( hPozycje, 'P_121' ) )
   hDane['P_122'] := sxml2num( xmlWartoscH( hPozycje, 'P_122' ) )
   hDane['P_123'] := sxml2num( xmlWartoscH( hPozycje, 'P_123' ) )
   hDane['P_124'] := sxml2num( xmlWartoscH( hPozycje, 'P_124' ) )
   hDane['P_125'] := sxml2num( xmlWartoscH( hPozycje, 'P_125' ) )
   hDane['P_126'] := sxml2num( xmlWartoscH( hPozycje, 'P_126' ) )
   hDane['P_127'] := sxml2num( xmlWartoscH( hPozycje, 'P_127' ) )
   hDane['P_128'] := sxml2num( xmlWartoscH( hPozycje, 'P_128' ) )
   hDane['P_129'] := sxml2num( xmlWartoscH( hPozycje, 'P_129' ) )
   hDane['P_130'] := sxml2num( xmlWartoscH( hPozycje, 'P_130' ) )
   hDane['P_131'] := sxml2num( xmlWartoscH( hPozycje, 'P_131' ) )
   hDane['P_132'] := sxml2num( xmlWartoscH( hPozycje, 'P_132' ) )
   hDane['P_133'] := sxml2num( xmlWartoscH( hPozycje, 'P_133' ) )
   hDane['P_134'] := sxml2num( xmlWartoscH( hPozycje, 'P_134' ) )
   hDane['P_135'] := sxml2num( xmlWartoscH( hPozycje, 'P_135' ) )
   hDane['P_136'] := sxml2num( xmlWartoscH( hPozycje, 'P_136' ) )
   hDane['P_137'] := sxml2num( xmlWartoscH( hPozycje, 'P_137' ) )
   hDane['P_138'] := sxml2num( xmlWartoscH( hPozycje, 'P_138' ) )
   hDane['P_139'] := sxml2num( xmlWartoscH( hPozycje, 'P_139' ) )
   hDane['P_140'] := sxml2num( xmlWartoscH( hPozycje, 'P_140' ) )
   hDane['P_141'] := sxml2num( xmlWartoscH( hPozycje, 'P_141' ) )
   hDane['P_142'] := sxml2num( xmlWartoscH( hPozycje, 'P_142' ) )
   hDane['P_143'] := sxml2num( xmlWartoscH( hPozycje, 'P_143' ) )
   hDane['P_144'] := sxml2num( xmlWartoscH( hPozycje, 'P_144' ) )
   hDane['P_145'] := sxml2num( xmlWartoscH( hPozycje, 'P_145' ) )
   hDane['P_146'] := sxml2num( xmlWartoscH( hPozycje, 'P_146' ) )
   hDane['P_147'] := sxml2num( xmlWartoscH( hPozycje, 'P_147' ) )
   hDane['P_148'] := sxml2num( xmlWartoscH( hPozycje, 'P_148' ) )
   hDane['P_149'] := sxml2num( xmlWartoscH( hPozycje, 'P_149' ) )
   hDane['P_150'] := sxml2num( xmlWartoscH( hPozycje, 'P_150' ) )
   hDane['P_151'] := sxml2num( xmlWartoscH( hPozycje, 'P_151' ) )
   hDane['P_152'] := sxml2num( xmlWartoscH( hPozycje, 'P_152' ) )
   hDane['P_153'] := sxml2num( xmlWartoscH( hPozycje, 'P_153' ) )
   hDane['P_154'] := sxml2num( xmlWartoscH( hPozycje, 'P_154' ) )
   hDane['P_155'] := sxml2num( xmlWartoscH( hPozycje, 'P_155' ) )
   hDane['P_156'] := sxml2num( xmlWartoscH( hPozycje, 'P_156' ) )
   hDane['P_157'] := sxml2num( xmlWartoscH( hPozycje, 'P_157' ) )
   hDane['P_158'] := sxml2num( xmlWartoscH( hPozycje, 'P_158' ) )
   hDane['P_159'] := sxml2num( xmlWartoscH( hPozycje, 'P_159' ) )
   hDane['P_160'] := sxml2num( xmlWartoscH( hPozycje, 'P_160' ) )
   hDane['P_161'] := sxml2num( xmlWartoscH( hPozycje, 'P_161' ) )
   hDane['P_162'] := sxml2num( xmlWartoscH( hPozycje, 'P_162' ) )
   hDane['P_163'] := sxml2num( xmlWartoscH( hPozycje, 'P_163' ) )
   hDane['P_164'] := sxml2num( xmlWartoscH( hPozycje, 'P_164' ) )
   hDane['P_165'] := sxml2num( xmlWartoscH( hPozycje, 'P_165' ) )
   hDane['P_166'] := sxml2num( xmlWartoscH( hPozycje, 'P_166' ) )
   hDane['P_167'] := sxml2num( xmlWartoscH( hPozycje, 'P_167' ) )
   hDane['P_168'] := sxml2num( xmlWartoscH( hPozycje, 'P_168' ) )
   hDane['P_168'] := sxml2num( xmlWartoscH( hPozycje, 'P_168' ) )
   hDane['P_169'] := sxml2num( xmlWartoscH( hPozycje, 'P_169' ) )
   hDane['P_170'] := sxml2num( xmlWartoscH( hPozycje, 'P_170' ) )
   hDane['P_171'] := sxml2num( xmlWartoscH( hPozycje, 'P_171' ) )
   hDane['P_172'] := sxml2num( xmlWartoscH( hPozycje, 'P_172' ) )
   hDane['P_173'] := sxml2num( xmlWartoscH( hPozycje, 'P_173' ) )
   hDane['P_174'] := sxml2num( xmlWartoscH( hPozycje, 'P_174' ) )
   hDane['P_175'] := sxml2num( xmlWartoscH( hPozycje, 'P_175' ) )
   hDane['P_176'] := sxml2num( xmlWartoscH( hPozycje, 'P_176' ) )
   hDane['P_177'] := sxml2num( xmlWartoscH( hPozycje, 'P_177' ) )
   hDane['P_178'] := sxml2num( xmlWartoscH( hPozycje, 'P_178' ) )
   hDane['P_179'] := sxml2num( xmlWartoscH( hPozycje, 'P_179' ) )
   hDane['P_180'] := sxml2num( xmlWartoscH( hPozycje, 'P_180' ) )
   hDane['P_181'] := sxml2num( xmlWartoscH( hPozycje, 'P_181' ) )
   hDane['P_182'] := sxml2num( xmlWartoscH( hPozycje, 'P_182' ) )
   hDane['P_183'] := sxml2num( xmlWartoscH( hPozycje, 'P_183' ) )
   hDane['P_184'] := sxml2num( xmlWartoscH( hPozycje, 'P_184' ) )
   hDane['P_185'] := sxml2num( xmlWartoscH( hPozycje, 'P_185' ) )
   hDane['P_186'] := sxml2num( xmlWartoscH( hPozycje, 'P_186' ) )
   hDane['P_187'] := sxml2num( xmlWartoscH( hPozycje, 'P_187' ) )
   hDane['P_188'] := sxml2num( xmlWartoscH( hPozycje, 'P_188' ) )
   hDane['P_189'] := sxml2num( xmlWartoscH( hPozycje, 'P_189' ) )
   hDane['P_190'] := sxml2num( xmlWartoscH( hPozycje, 'P_190' ) )
   hDane['P_191'] := sxml2num( xmlWartoscH( hPozycje, 'P_191' ) )
   hDane['P_192'] := sxml2num( xmlWartoscH( hPozycje, 'P_192' ) )
   hDane['P_193'] := sxml2num( xmlWartoscH( hPozycje, 'P_193' ) )
   hDane['P_194'] := sxml2num( xmlWartoscH( hPozycje, 'P_194' ) )
   hDane['P_195'] := sxml2num( xmlWartoscH( hPozycje, 'P_195' ) )
   hDane['P_196'] := sxml2num( xmlWartoscH( hPozycje, 'P_196' ) )
   hDane['P_197'] := sxml2num( xmlWartoscH( hPozycje, 'P_197' ) )
   hDane['P_198'] := sxml2num( xmlWartoscH( hPozycje, 'P_198' ) )
   hDane['P_199'] := sxml2num( xmlWartoscH( hPozycje, 'P_199' ) )
   hDane['P_200'] := sxml2num( xmlWartoscH( hPozycje, 'P_200' ) )
   hDane['P_201'] := sxml2num( xmlWartoscH( hPozycje, 'P_201' ) )
   hDane['P_202'] := sxml2num( xmlWartoscH( hPozycje, 'P_202' ) )
   hDane['P_203'] := sxml2num( xmlWartoscH( hPozycje, 'P_203' ) )
   hDane['P_204'] := sxml2num( xmlWartoscH( hPozycje, 'P_204' ) )
   hDane['P_205'] := sxml2num( xmlWartoscH( hPozycje, 'P_205' ) )
   hDane['P_206'] := sxml2num( xmlWartoscH( hPozycje, 'P_206' ) )
   hDane['P_207'] := sxml2num( xmlWartoscH( hPozycje, 'P_207' ) )
   hDane['P_208'] := sxml2num( xmlWartoscH( hPozycje, 'P_208' ) )
   hDane['P_209'] := sxml2num( xmlWartoscH( hPozycje, 'P_209' ) )
   hDane['P_210'] := sxml2num( xmlWartoscH( hPozycje, 'P_210' ) )
   hDane['P_211'] := sxml2num( xmlWartoscH( hPozycje, 'P_211' ) )
   hDane['P_212'] := sxml2num( xmlWartoscH( hPozycje, 'P_212' ) )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_8_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_8_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF   */

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw7()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif( spolka_, '1', '0' )
   hDane['P_7_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_8'] := AllTrim(P8)
   hDane['P_9']  := z601
   hDane['P_10'] := z602
   hDane['P_11'] := z603
   hDane['P_12'] := z604
   hDane['P_13'] := z605
   hDane['P_14'] := z606
   hDane['P_15'] := z607
   hDane['P_16'] := z608
   hDane['P_17'] := z609
   hDane['P_18'] := z610
   hDane['P_19'] := z611
   hDane['P_20'] := z612
   hDane['P_21'] := 0
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := z201
   hDane['P_310'] := z202
   hDane['P_311'] := z203
   hDane['P_312'] := z204
   hDane['P_313'] := z205
   hDane['P_314'] := z206
   hDane['P_315'] := z207
   hDane['P_316'] := z208
   hDane['P_317'] := z209
   hDane['P_318'] := z210
   hDane['P_319'] := z211
   hDane['P_320'] := z212
   hDane['P_321'] := z301
   hDane['P_322'] := z302
   hDane['P_323'] := z303
   hDane['P_324'] := z304
   hDane['P_325'] := z305
   hDane['P_326'] := z306
   hDane['P_327'] := z307
   hDane['P_328'] := z308
   hDane['P_329'] := z309
   hDane['P_330'] := z310
   hDane['P_331'] := z311
   hDane['P_332'] := z312
   hDane['P_333'] := z401
   hDane['P_334'] := z402
   hDane['P_335'] := z403
   hDane['P_336'] := z404
   hDane['P_337'] := z405
   hDane['P_338'] := z406
   hDane['P_339'] := z407
   hDane['P_340'] := z408
   hDane['P_341'] := z409
   hDane['P_342'] := z410
   hDane['P_343'] := z411
   hDane['P_344'] := z412
   hDane['P_345'] := z501
   hDane['P_346'] := z502
   hDane['P_347'] := z503
   hDane['P_348'] := z504
   hDane['P_349'] := z505
   hDane['P_350'] := z506
   hDane['P_351'] := z507
   hDane['P_352'] := z508
   hDane['P_353'] := z509
   hDane['P_354'] := z510
   hDane['P_355'] := z511
   hDane['P_356'] := z512

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw8()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := z201
   hDane['P_311'] := z202
   hDane['P_312'] := z203
   hDane['P_313'] := z204
   hDane['P_314'] := z205
   hDane['P_315'] := z206
   hDane['P_316'] := z207
   hDane['P_317'] := z208
   hDane['P_318'] := z209
   hDane['P_319'] := z210
   hDane['P_320'] := z211
   hDane['P_321'] := z212
   hDane['P_322'] := z301
   hDane['P_323'] := z302
   hDane['P_324'] := z303
   hDane['P_325'] := z304
   hDane['P_326'] := z305
   hDane['P_327'] := z306
   hDane['P_328'] := z307
   hDane['P_329'] := z308
   hDane['P_330'] := z309
   hDane['P_331'] := z310
   hDane['P_332'] := z311
   hDane['P_333'] := z312
   hDane['P_334'] := z401
   hDane['P_335'] := z402
   hDane['P_336'] := z403
   hDane['P_337'] := z404
   hDane['P_338'] := z405
   hDane['P_339'] := z406
   hDane['P_340'] := z407
   hDane['P_341'] := z408
   hDane['P_342'] := z409
   hDane['P_343'] := z410
   hDane['P_344'] := z411
   hDane['P_345'] := z412
   hDane['P_346'] := z501
   hDane['P_347'] := z502
   hDane['P_348'] := z503
   hDane['P_349'] := z504
   hDane['P_350'] := z505
   hDane['P_351'] := z506
   hDane['P_352'] := z507
   hDane['P_353'] := z508
   hDane['P_354'] := z509
   hDane['P_355'] := z510
   hDane['P_356'] := z511
   hDane['P_357'] := z512

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw9()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := 0
   hDane['P_311'] := 0
   hDane['P_312'] := 0
   hDane['P_313'] := 0
   hDane['P_314'] := 0
   hDane['P_315'] := 0
   hDane['P_316'] := 0
   hDane['P_317'] := 0
   hDane['P_318'] := 0
   hDane['P_319'] := 0
   hDane['P_320'] := 0
   hDane['P_321'] := 0
   hDane['P_322'] := 0
   hDane['P_323'] := 0
   hDane['P_324'] := 0
   hDane['P_325'] := 0
   hDane['P_326'] := 0
   hDane['P_327'] := 0
   hDane['P_328'] := 0
   hDane['P_329'] := 0
   hDane['P_330'] := 0
   hDane['P_331'] := 0
   hDane['P_332'] := 0
   hDane['P_333'] := 0
   hDane['P_334'] := 0
   hDane['P_335'] := 0
   hDane['P_336'] := 0
   hDane['P_337'] := 0
   hDane['P_338'] := 0
   hDane['P_339'] := 0
   hDane['P_340'] := 0
   hDane['P_341'] := 0
   hDane['P_342'] := 0
   hDane['P_343'] := 0
   hDane['P_344'] := 0
   hDane['P_345'] := 0
   hDane['P_346'] := 0
   hDane['P_347'] := 0
   hDane['P_348'] := 0
   hDane['P_349'] := 0
   hDane['P_350'] := 0
   hDane['P_351'] := 0
   hDane['P_352'] := 0
   hDane['P_353'] := 0
   hDane['P_354'] := 0
   hDane['P_355'] := 0
   hDane['P_356'] := 0
   hDane['P_357'] := 0
   hDane['P_358'] := 0
   hDane['P_359'] := 0
   hDane['P_360'] := 0
   hDane['P_361'] := 0
   hDane['P_362'] := 0
   hDane['P_363'] := 0
   hDane['P_364'] := 0
   hDane['P_365'] := 0
   hDane['P_366'] := 0
   hDane['P_367'] := 0
   hDane['P_368'] := 0
   hDane['P_369'] := 0
   hDane['P_370'] := 0
   hDane['P_371'] := 0
   hDane['P_372'] := 0
   hDane['P_373'] := 0
   hDane['P_374'] := 0
   hDane['P_375'] := 0
   hDane['P_376'] := 0
   hDane['P_377'] := 0
   hDane['P_378'] := 0
   hDane['P_379'] := 0
   hDane['P_380'] := 0
   hDane['P_381'] := 0

   hDane['P_382'] := z201
   hDane['P_383'] := z202
   hDane['P_384'] := z203
   hDane['P_385'] := z204
   hDane['P_386'] := z205
   hDane['P_387'] := z206
   hDane['P_388'] := z207
   hDane['P_389'] := z208
   hDane['P_390'] := z209
   hDane['P_391'] := z210
   hDane['P_392'] := z211
   hDane['P_393'] := z212
   hDane['P_394'] := z301
   hDane['P_395'] := z302
   hDane['P_396'] := z303
   hDane['P_397'] := z304
   hDane['P_398'] := z305
   hDane['P_399'] := z306
   hDane['P_400'] := z307
   hDane['P_401'] := z308
   hDane['P_402'] := z309
   hDane['P_403'] := z310
   hDane['P_404'] := z311
   hDane['P_405'] := z312
   hDane['P_406'] := z401
   hDane['P_407'] := z402
   hDane['P_408'] := z403
   hDane['P_409'] := z404
   hDane['P_410'] := z405
   hDane['P_411'] := z406
   hDane['P_412'] := z407
   hDane['P_413'] := z408
   hDane['P_414'] := z409
   hDane['P_415'] := z410
   hDane['P_416'] := z411
   hDane['P_417'] := z412
   hDane['P_418'] := z501
   hDane['P_419'] := z502
   hDane['P_420'] := z503
   hDane['P_421'] := z504
   hDane['P_422'] := z505
   hDane['P_423'] := z506
   hDane['P_424'] := z507
   hDane['P_425'] := z508
   hDane['P_426'] := z509
   hDane['P_427'] := z510
   hDane['P_428'] := z511
   hDane['P_429'] := z512

   hDane['P_430'] := '0'
   hDane['P_431'] := '0'
   hDane['P_432'] := '0'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw10()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := 0
   hDane['P_311'] := 0
   hDane['P_312'] := 0
   hDane['P_313'] := 0
   hDane['P_314'] := 0
   hDane['P_315'] := 0
   hDane['P_316'] := 0
   hDane['P_317'] := 0
   hDane['P_318'] := 0
   hDane['P_319'] := 0
   hDane['P_320'] := 0
   hDane['P_321'] := 0
   hDane['P_322'] := 0
   hDane['P_323'] := 0
   hDane['P_324'] := 0
   hDane['P_325'] := 0
   hDane['P_326'] := 0
   hDane['P_327'] := 0
   hDane['P_328'] := 0
   hDane['P_329'] := 0
   hDane['P_330'] := 0
   hDane['P_331'] := 0
   hDane['P_332'] := 0
   hDane['P_333'] := 0
   hDane['P_334'] := 0
   hDane['P_335'] := 0
   hDane['P_336'] := 0
   hDane['P_337'] := 0
   hDane['P_338'] := 0
   hDane['P_339'] := 0
   hDane['P_340'] := 0
   hDane['P_341'] := 0
   hDane['P_342'] := 0
   hDane['P_343'] := 0
   hDane['P_344'] := 0
   hDane['P_345'] := 0
   hDane['P_346'] := 0
   hDane['P_347'] := 0
   hDane['P_348'] := 0
   hDane['P_349'] := 0
   hDane['P_350'] := 0
   hDane['P_351'] := 0
   hDane['P_352'] := 0
   hDane['P_353'] := 0
   hDane['P_354'] := 0
   hDane['P_355'] := 0
   hDane['P_356'] := 0
   hDane['P_357'] := 0
   hDane['P_358'] := 0
   hDane['P_359'] := 0
   hDane['P_360'] := 0
   hDane['P_361'] := 0
   hDane['P_362'] := 0
   hDane['P_363'] := 0
   hDane['P_364'] := 0
   hDane['P_365'] := 0
   hDane['P_366'] := 0
   hDane['P_367'] := 0
   hDane['P_368'] := 0
   hDane['P_369'] := 0
   hDane['P_370'] := 0
   hDane['P_371'] := 0
   hDane['P_372'] := 0
   hDane['P_373'] := 0
   hDane['P_374'] := 0
   hDane['P_375'] := 0
   hDane['P_376'] := 0
   hDane['P_377'] := 0
   hDane['P_378'] := 0
   hDane['P_379'] := 0
   hDane['P_380'] := 0
   hDane['P_381'] := 0

   hDane['P_382'] := z201
   hDane['P_383'] := z202
   hDane['P_384'] := z203
   hDane['P_385'] := z204
   hDane['P_386'] := z205
   hDane['P_387'] := z206
   hDane['P_388'] := z207
   hDane['P_389'] := z208
   hDane['P_390'] := z209
   hDane['P_391'] := z210
   hDane['P_392'] := z211
   hDane['P_393'] := z212
   hDane['P_394'] := z301
   hDane['P_395'] := z302
   hDane['P_396'] := z303
   hDane['P_397'] := z304
   hDane['P_398'] := z305
   hDane['P_399'] := z306
   hDane['P_400'] := z307
   hDane['P_401'] := z308
   hDane['P_402'] := z309
   hDane['P_403'] := z310
   hDane['P_404'] := z311
   hDane['P_405'] := z312
   hDane['P_406'] := z401
   hDane['P_407'] := z402
   hDane['P_408'] := z403
   hDane['P_409'] := z404
   hDane['P_410'] := z405
   hDane['P_411'] := z406
   hDane['P_412'] := z407
   hDane['P_413'] := z408
   hDane['P_414'] := z409
   hDane['P_415'] := z410
   hDane['P_416'] := z411
   hDane['P_417'] := z412
   hDane['P_418'] := z501
   hDane['P_419'] := z502
   hDane['P_420'] := z503
   hDane['P_421'] := z504
   hDane['P_422'] := z505
   hDane['P_423'] := z506
   hDane['P_424'] := z507
   hDane['P_425'] := z508
   hDane['P_426'] := z509
   hDane['P_427'] := z510
   hDane['P_428'] := z511
   hDane['P_429'] := z512

   hDane['P_430'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_431'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_432'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_433'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_434'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_435'] := iif( aPit48Covid[ 6 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw11()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := 0
   hDane['P_311'] := 0
   hDane['P_312'] := 0
   hDane['P_313'] := 0
   hDane['P_314'] := 0
   hDane['P_315'] := 0
   hDane['P_316'] := 0
   hDane['P_317'] := 0
   hDane['P_318'] := 0
   hDane['P_319'] := 0
   hDane['P_320'] := 0
   hDane['P_321'] := 0
   hDane['P_322'] := 0
   hDane['P_323'] := 0
   hDane['P_324'] := 0
   hDane['P_325'] := 0
   hDane['P_326'] := 0
   hDane['P_327'] := 0
   hDane['P_328'] := 0
   hDane['P_329'] := 0
   hDane['P_330'] := 0
   hDane['P_331'] := 0
   hDane['P_332'] := 0
   hDane['P_333'] := 0
   hDane['P_334'] := 0
   hDane['P_335'] := 0
   hDane['P_336'] := 0
   hDane['P_337'] := 0
   hDane['P_338'] := 0
   hDane['P_339'] := 0
   hDane['P_340'] := 0
   hDane['P_341'] := 0
   hDane['P_342'] := 0
   hDane['P_343'] := 0
   hDane['P_344'] := 0
   hDane['P_345'] := 0
   hDane['P_346'] := 0
   hDane['P_347'] := 0
   hDane['P_348'] := 0
   hDane['P_349'] := 0
   hDane['P_350'] := 0
   hDane['P_351'] := 0
   hDane['P_352'] := 0
   hDane['P_353'] := 0
   hDane['P_354'] := 0
   hDane['P_355'] := 0
   hDane['P_356'] := 0
   hDane['P_357'] := 0
   hDane['P_358'] := 0
   hDane['P_359'] := 0
   hDane['P_360'] := 0
   hDane['P_361'] := 0
   hDane['P_362'] := 0
   hDane['P_363'] := 0
   hDane['P_364'] := 0
   hDane['P_365'] := 0
   hDane['P_366'] := 0
   hDane['P_367'] := 0
   hDane['P_368'] := 0
   hDane['P_369'] := 0
   hDane['P_370'] := 0
   hDane['P_371'] := 0
   hDane['P_372'] := 0
   hDane['P_373'] := 0
   hDane['P_374'] := 0
   hDane['P_375'] := 0
   hDane['P_376'] := 0
   hDane['P_377'] := 0
   hDane['P_378'] := 0
   hDane['P_379'] := 0
   hDane['P_380'] := 0
   hDane['P_381'] := 0

   hDane['P_382'] := z201
   hDane['P_383'] := z202
   hDane['P_384'] := z203
   hDane['P_385'] := z204
   hDane['P_386'] := z205
   hDane['P_387'] := z206
   hDane['P_388'] := z207
   hDane['P_389'] := z208
   hDane['P_390'] := z209
   hDane['P_391'] := z210
   hDane['P_392'] := z211
   hDane['P_393'] := z212
   hDane['P_394'] := z301
   hDane['P_395'] := z302
   hDane['P_396'] := z303
   hDane['P_397'] := z304
   hDane['P_398'] := z305
   hDane['P_399'] := z306
   hDane['P_400'] := z307
   hDane['P_401'] := z308
   hDane['P_402'] := z309
   hDane['P_403'] := z310
   hDane['P_404'] := z311
   hDane['P_405'] := z312
   hDane['P_406'] := z401
   hDane['P_407'] := z402
   hDane['P_408'] := z403
   hDane['P_409'] := z404
   hDane['P_410'] := z405
   hDane['P_411'] := z406
   hDane['P_412'] := z407
   hDane['P_413'] := z408
   hDane['P_414'] := z409
   hDane['P_415'] := z410
   hDane['P_416'] := z411
   hDane['P_417'] := z412
   hDane['P_418'] := z501
   hDane['P_419'] := z502
   hDane['P_420'] := z503
   hDane['P_421'] := z504
   hDane['P_422'] := z505
   hDane['P_423'] := z506
   hDane['P_424'] := z507
   hDane['P_425'] := z508
   hDane['P_426'] := z509
   hDane['P_427'] := z510
   hDane['P_428'] := z511
   hDane['P_429'] := z512

   hDane['P_430'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_431'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_432'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_433'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_434'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_435'] := iif( aPit48Covid[ 6 ], '1', '0' )
   hDane['P_436'] := iif( aPit48Covid[ 7 ], '1', '0' )
   hDane['P_437'] := iif( aPit48Covid[ 8 ], '1', '0' )
   hDane['P_438'] := iif( aPit48Covid[ 9 ], '1', '0' )
   hDane['P_439'] := iif( aPit48Covid[ 10 ], '1', '0' )
   hDane['P_440'] := iif( aPit48Covid[ 11 ], '1', '0' )
   hDane['P_441'] := iif( aPit48Covid[ 12 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw12()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := 0
   hDane['P_311'] := 0
   hDane['P_312'] := 0
   hDane['P_313'] := 0
   hDane['P_314'] := 0
   hDane['P_315'] := 0
   hDane['P_316'] := 0
   hDane['P_317'] := 0
   hDane['P_318'] := 0
   hDane['P_319'] := 0
   hDane['P_320'] := 0
   hDane['P_321'] := 0
   hDane['P_322'] := 0
   hDane['P_323'] := 0
   hDane['P_324'] := 0
   hDane['P_325'] := 0
   hDane['P_326'] := 0
   hDane['P_327'] := 0
   hDane['P_328'] := 0
   hDane['P_329'] := 0
   hDane['P_330'] := 0
   hDane['P_331'] := 0
   hDane['P_332'] := 0
   hDane['P_333'] := 0
   hDane['P_334'] := 0
   hDane['P_335'] := 0
   hDane['P_336'] := 0
   hDane['P_337'] := 0
   hDane['P_338'] := 0
   hDane['P_339'] := 0
   hDane['P_340'] := 0
   hDane['P_341'] := 0
   hDane['P_342'] := 0
   hDane['P_343'] := 0
   hDane['P_344'] := 0
   hDane['P_345'] := 0
   hDane['P_346'] := 0
   hDane['P_347'] := 0
   hDane['P_348'] := 0
   hDane['P_349'] := 0
   hDane['P_350'] := 0
   hDane['P_351'] := 0
   hDane['P_352'] := 0
   hDane['P_353'] := 0
   hDane['P_354'] := 0
   hDane['P_355'] := 0
   hDane['P_356'] := 0
   hDane['P_357'] := 0
   hDane['P_358'] := 0
   hDane['P_359'] := 0
   hDane['P_360'] := 0
   hDane['P_361'] := 0
   hDane['P_362'] := 0
   hDane['P_363'] := 0
   hDane['P_364'] := 0
   hDane['P_365'] := 0
   hDane['P_366'] := 0
   hDane['P_367'] := 0
   hDane['P_368'] := 0
   hDane['P_369'] := 0
   hDane['P_370'] := 0
   hDane['P_371'] := 0
   hDane['P_372'] := 0
   hDane['P_373'] := 0
   hDane['P_374'] := 0
   hDane['P_375'] := 0
   hDane['P_376'] := 0
   hDane['P_377'] := 0
   hDane['P_378'] := 0
   hDane['P_379'] := 0
   hDane['P_380'] := 0
   hDane['P_381'] := 0
   hDane['P_382'] := 0
   hDane['P_383'] := 0
   hDane['P_384'] := 0
   hDane['P_385'] := 0
   hDane['P_386'] := 0
   hDane['P_387'] := 0
   hDane['P_388'] := 0
   hDane['P_389'] := 0
   hDane['P_390'] := 0
   hDane['P_391'] := 0
   hDane['P_392'] := 0
   hDane['P_393'] := 0
   hDane['P_394'] := z201
   hDane['P_395'] := z202
   hDane['P_396'] := z203
   hDane['P_397'] := z204
   hDane['P_398'] := z205
   hDane['P_399'] := z206
   hDane['P_400'] := z207
   hDane['P_401'] := z208
   hDane['P_402'] := z209
   hDane['P_403'] := z210
   hDane['P_404'] := z211
   hDane['P_405'] := z212
   hDane['P_406'] := z301
   hDane['P_407'] := z302
   hDane['P_408'] := z303
   hDane['P_409'] := z304
   hDane['P_410'] := z305
   hDane['P_411'] := z306
   hDane['P_412'] := z307
   hDane['P_413'] := z308
   hDane['P_414'] := z309
   hDane['P_415'] := z310
   hDane['P_416'] := z311
   hDane['P_417'] := z312
   hDane['P_418'] := z401
   hDane['P_419'] := z402
   hDane['P_420'] := z403
   hDane['P_421'] := z404
   hDane['P_422'] := z405
   hDane['P_423'] := z406
   hDane['P_424'] := z407
   hDane['P_425'] := z408
   hDane['P_426'] := z409
   hDane['P_427'] := z410
   hDane['P_428'] := z411
   hDane['P_429'] := z412
   hDane['P_430'] := z501
   hDane['P_431'] := z502
   hDane['P_432'] := z503
   hDane['P_433'] := z504
   hDane['P_434'] := z505
   hDane['P_435'] := z506
   hDane['P_436'] := z507
   hDane['P_437'] := z508
   hDane['P_438'] := z509
   hDane['P_439'] := z510
   hDane['P_440'] := z511
   hDane['P_441'] := z512

   hDane['P_442'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_443'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_444'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_445'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_446'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_447'] := iif( aPit48Covid[ 6 ], '1', '0' )
   hDane['P_448'] := iif( aPit48Covid[ 7 ], '1', '0' )
   hDane['P_449'] := iif( aPit48Covid[ 8 ], '1', '0' )
   hDane['P_450'] := iif( aPit48Covid[ 9 ], '1', '0' )
   hDane['P_451'] := iif( aPit48Covid[ 10 ], '1', '0' )
   hDane['P_452'] := iif( aPit48Covid[ 11 ], '1', '0' )
   hDane['P_453'] := iif( aPit48Covid[ 12 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT8ARw13()
   LOCAL hDane := hb_Hash()

   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(p4r)
   hDane['P_5'] := iif( AllTrim(p6k) != '', KodUS2Nazwa( AllTrim(p6k) ), '' )
   hDane['P_6_1'] := iif( zDEKLKOR == 'D', '1', '0' )
   hDane['P_6_2'] := iif( zDEKLKOR <> 'D', '1', '0' )
   hDane['P_7_1'] := iif(rodzaj_korekty == 1, '1', '0' )
   hDane['P_7_2'] := iif(rodzaj_korekty == 2, '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   hDane['P_1'] := P1
   hDane['P_9'] := AllTrim(P8)
   hDane['P_10']  := z601
   hDane['P_11'] := z602
   hDane['P_12'] := z603
   hDane['P_13'] := z604
   hDane['P_14'] := z605
   hDane['P_15'] := z606
   hDane['P_16'] := z607
   hDane['P_17'] := z608
   hDane['P_18'] := z609
   hDane['P_19'] := z610
   hDane['P_20'] := z611
   hDane['P_21'] := z612
   hDane['P_22'] := 0
   hDane['P_23'] := 0
   hDane['P_24'] := 0
   hDane['P_25'] := 0
   hDane['P_26'] := 0
   hDane['P_27'] := 0
   hDane['P_28'] := 0
   hDane['P_29'] := 0
   hDane['P_30'] := 0
   hDane['P_31'] := 0
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := 0
   hDane['P_37'] := 0
   hDane['P_38'] := 0
   hDane['P_39'] := 0
   hDane['P_40'] := 0
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := 0
   hDane['P_47'] := 0
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := 0
   hDane['P_51'] := 0
   hDane['P_52'] := 0
   hDane['P_53'] := 0
   hDane['P_54'] := 0
   hDane['P_55'] := 0
   hDane['P_56'] := 0
   hDane['P_57'] := 0
   hDane['P_58'] := 0
   hDane['P_59'] := 0
   hDane['P_60'] := 0
   hDane['P_61'] := 0
   hDane['P_62'] := 0
   hDane['P_63'] := 0
   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0
   hDane['P_70'] := 0
   hDane['P_71'] := 0
   hDane['P_72'] := 0
   hDane['P_73'] := 0
   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_82'] := 0
   hDane['P_81'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0
   hDane['P_92'] := 0
   hDane['P_93'] := 0
   hDane['P_94'] := 0
   hDane['P_95'] := 0
   hDane['P_96'] := 0
   hDane['P_97'] := 0
   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0
   hDane['P_109'] := 0
   hDane['P_110'] := 0
   hDane['P_111'] := 0
   hDane['P_112'] := 0
   hDane['P_113'] := 0
   hDane['P_114'] := 0
   hDane['P_115'] := 0
   hDane['P_116'] := 0
   hDane['P_117'] := 0
   hDane['P_118'] := 0
   hDane['P_119'] := 0
   hDane['P_120'] := 0
   hDane['P_121'] := 0
   hDane['P_122'] := 0
   hDane['P_123'] := 0
   hDane['P_124'] := 0
   hDane['P_125'] := 0
   hDane['P_126'] := 0
   hDane['P_127'] := 0
   hDane['P_128'] := 0
   hDane['P_129'] := 0
   hDane['P_130'] := 0
   hDane['P_131'] := 0
   hDane['P_132'] := 0
   hDane['P_133'] := 0
   hDane['P_134'] := 0
   hDane['P_135'] := 0
   hDane['P_136'] := 0
   hDane['P_137'] := 0
   hDane['P_138'] := 0
   hDane['P_139'] := 0
   hDane['P_140'] := 0
   hDane['P_141'] := 0
   hDane['P_142'] := 0
   hDane['P_143'] := 0
   hDane['P_144'] := 0
   hDane['P_145'] := 0
   hDane['P_146'] := 0
   hDane['P_147'] := 0
   hDane['P_148'] := 0
   hDane['P_149'] := 0
   hDane['P_150'] := 0
   hDane['P_151'] := 0
   hDane['P_152'] := 0
   hDane['P_153'] := 0
   hDane['P_154'] := 0
   hDane['P_155'] := 0
   hDane['P_156'] := 0
   hDane['P_157'] := 0
   hDane['P_158'] := 0
   hDane['P_159'] := 0
   hDane['P_160'] := 0
   hDane['P_161'] := 0
   hDane['P_162'] := 0
   hDane['P_163'] := 0
   hDane['P_164'] := 0
   hDane['P_165'] := 0
   hDane['P_166'] := 0
   hDane['P_167'] := 0
   hDane['P_168'] := 0
   hDane['P_169'] := 0
   hDane['P_170'] := 0
   hDane['P_171'] := 0
   hDane['P_172'] := 0
   hDane['P_173'] := 0
   hDane['P_174'] := 0
   hDane['P_175'] := 0
   hDane['P_176'] := 0
   hDane['P_177'] := 0
   hDane['P_178'] := 0
   hDane['P_179'] := 0
   hDane['P_180'] := 0
   hDane['P_182'] := 0
   hDane['P_181'] := 0
   hDane['P_183'] := 0
   hDane['P_184'] := 0
   hDane['P_185'] := 0
   hDane['P_186'] := 0
   hDane['P_187'] := 0
   hDane['P_188'] := 0
   hDane['P_189'] := 0
   hDane['P_190'] := 0
   hDane['P_191'] := 0
   hDane['P_192'] := 0
   hDane['P_193'] := 0
   hDane['P_194'] := 0
   hDane['P_195'] := 0
   hDane['P_196'] := 0
   hDane['P_197'] := 0
   hDane['P_198'] := 0
   hDane['P_199'] := 0
   hDane['P_200'] := 0
   hDane['P_201'] := 0
   hDane['P_202'] := 0
   hDane['P_203'] := 0
   hDane['P_204'] := 0
   hDane['P_205'] := 0
   hDane['P_206'] := 0
   hDane['P_207'] := 0
   hDane['P_208'] := 0
   hDane['P_209'] := 0
   hDane['P_210'] := 0
   hDane['P_211'] := 0
   hDane['P_212'] := 0
   hDane['P_213'] := 0
   hDane['P_214'] := 0
   hDane['P_215'] := 0
   hDane['P_216'] := 0
   hDane['P_217'] := 0
   hDane['P_218'] := 0
   hDane['P_219'] := 0
   hDane['P_220'] := 0
   hDane['P_221'] := 0
   hDane['P_222'] := 0
   hDane['P_223'] := 0
   hDane['P_224'] := 0
   hDane['P_225'] := 0
   hDane['P_226'] := 0
   hDane['P_227'] := 0
   hDane['P_228'] := 0
   hDane['P_229'] := 0
   hDane['P_230'] := 0
   hDane['P_231'] := 0
   hDane['P_232'] := 0
   hDane['P_233'] := 0
   hDane['P_234'] := 0
   hDane['P_235'] := 0
   hDane['P_236'] := 0
   hDane['P_237'] := 0
   hDane['P_238'] := 0
   hDane['P_239'] := 0
   hDane['P_240'] := 0
   hDane['P_241'] := 0
   hDane['P_242'] := 0
   hDane['P_243'] := 0
   hDane['P_244'] := 0
   hDane['P_245'] := 0
   hDane['P_246'] := 0
   hDane['P_247'] := 0
   hDane['P_248'] := 0
   hDane['P_249'] := 0
   hDane['P_250'] := 0
   hDane['P_251'] := 0
   hDane['P_252'] := 0
   hDane['P_253'] := 0
   hDane['P_254'] := 0
   hDane['P_255'] := 0
   hDane['P_256'] := 0
   hDane['P_257'] := 0
   hDane['P_258'] := 0
   hDane['P_259'] := 0
   hDane['P_260'] := 0
   hDane['P_261'] := 0
   hDane['P_262'] := 0
   hDane['P_263'] := 0
   hDane['P_264'] := 0
   hDane['P_265'] := 0
   hDane['P_266'] := 0
   hDane['P_267'] := 0
   hDane['P_268'] := 0
   hDane['P_269'] := 0
   hDane['P_270'] := 0
   hDane['P_271'] := 0
   hDane['P_272'] := 0
   hDane['P_273'] := 0
   hDane['P_274'] := 0
   hDane['P_275'] := 0
   hDane['P_276'] := 0
   hDane['P_277'] := 0
   hDane['P_278'] := 0
   hDane['P_279'] := 0
   hDane['P_280'] := 0
   hDane['P_282'] := 0
   hDane['P_281'] := 0
   hDane['P_283'] := 0
   hDane['P_284'] := 0
   hDane['P_285'] := 0
   hDane['P_286'] := 0
   hDane['P_287'] := 0
   hDane['P_288'] := 0
   hDane['P_289'] := 0
   hDane['P_290'] := 0
   hDane['P_291'] := 0
   hDane['P_292'] := 0
   hDane['P_293'] := 0
   hDane['P_294'] := 0
   hDane['P_295'] := 0
   hDane['P_296'] := 0
   hDane['P_297'] := 0
   hDane['P_298'] := 0
   hDane['P_299'] := 0
   hDane['P_300'] := 0
   hDane['P_301'] := 0
   hDane['P_302'] := 0
   hDane['P_303'] := 0
   hDane['P_304'] := 0
   hDane['P_305'] := 0
   hDane['P_306'] := 0
   hDane['P_307'] := 0
   hDane['P_308'] := 0
   hDane['P_309'] := 0
   hDane['P_310'] := 0
   hDane['P_311'] := 0
   hDane['P_312'] := 0
   hDane['P_313'] := 0
   hDane['P_314'] := 0
   hDane['P_315'] := 0
   hDane['P_316'] := 0
   hDane['P_317'] := 0
   hDane['P_318'] := 0
   hDane['P_319'] := 0
   hDane['P_320'] := 0
   hDane['P_321'] := 0
   hDane['P_322'] := 0
   hDane['P_323'] := 0
   hDane['P_324'] := 0
   hDane['P_325'] := 0
   hDane['P_326'] := 0
   hDane['P_327'] := 0
   hDane['P_328'] := 0
   hDane['P_329'] := 0
   hDane['P_330'] := 0
   hDane['P_331'] := 0
   hDane['P_332'] := 0
   hDane['P_333'] := 0
   hDane['P_334'] := 0
   hDane['P_335'] := 0
   hDane['P_336'] := 0
   hDane['P_337'] := 0
   hDane['P_338'] := 0
   hDane['P_339'] := 0
   hDane['P_340'] := 0
   hDane['P_341'] := 0
   hDane['P_342'] := 0
   hDane['P_343'] := 0
   hDane['P_344'] := 0
   hDane['P_345'] := 0
   hDane['P_346'] := 0
   hDane['P_347'] := 0
   hDane['P_348'] := 0
   hDane['P_349'] := 0
   hDane['P_350'] := 0
   hDane['P_351'] := 0
   hDane['P_352'] := 0
   hDane['P_353'] := 0
   hDane['P_354'] := 0
   hDane['P_355'] := 0
   hDane['P_356'] := 0
   hDane['P_357'] := 0
   hDane['P_358'] := 0
   hDane['P_359'] := 0
   hDane['P_360'] := 0
   hDane['P_361'] := 0
   hDane['P_362'] := 0
   hDane['P_363'] := 0
   hDane['P_364'] := 0
   hDane['P_365'] := 0
   hDane['P_366'] := 0
   hDane['P_367'] := 0
   hDane['P_368'] := 0
   hDane['P_369'] := 0
   hDane['P_370'] := 0
   hDane['P_371'] := 0
   hDane['P_372'] := 0
   hDane['P_373'] := 0
   hDane['P_374'] := 0
   hDane['P_375'] := 0
   hDane['P_376'] := 0
   hDane['P_377'] := 0
   hDane['P_378'] := 0
   hDane['P_379'] := 0
   hDane['P_380'] := 0
   hDane['P_381'] := 0
   hDane['P_382'] := 0
   hDane['P_383'] := 0
   hDane['P_384'] := 0
   hDane['P_385'] := 0
   hDane['P_386'] := 0
   hDane['P_387'] := 0
   hDane['P_388'] := 0
   hDane['P_389'] := 0
   hDane['P_390'] := 0
   hDane['P_391'] := 0
   hDane['P_392'] := 0
   hDane['P_393'] := 0
   hDane['P_394'] := 0
   hDane['P_395'] := 0
   hDane['P_396'] := 0
   hDane['P_397'] := 0
   hDane['P_398'] := 0
   hDane['P_399'] := 0
   hDane['P_400'] := 0
   hDane['P_401'] := 0
   hDane['P_402'] := 0
   hDane['P_403'] := 0
   hDane['P_404'] := 0
   hDane['P_405'] := 0
   hDane['P_406'] := 0
   hDane['P_407'] := 0
   hDane['P_408'] := 0
   hDane['P_409'] := 0
   hDane['P_410'] := 0
   hDane['P_411'] := 0
   hDane['P_412'] := 0
   hDane['P_413'] := 0
   hDane['P_414'] := 0
   hDane['P_415'] := 0
   hDane['P_416'] := 0
   hDane['P_417'] := 0
   hDane['P_418'] := z201
   hDane['P_419'] := z202
   hDane['P_420'] := z203
   hDane['P_421'] := z204
   hDane['P_422'] := z205
   hDane['P_423'] := z206
   hDane['P_424'] := z207
   hDane['P_425'] := z208
   hDane['P_426'] := z209
   hDane['P_427'] := z210
   hDane['P_428'] := z211
   hDane['P_429'] := z212
   hDane['P_430'] := z301
   hDane['P_431'] := z302
   hDane['P_432'] := z303
   hDane['P_433'] := z304
   hDane['P_434'] := z305
   hDane['P_435'] := z306
   hDane['P_436'] := z307
   hDane['P_437'] := z308
   hDane['P_438'] := z309
   hDane['P_439'] := z310
   hDane['P_440'] := z311
   hDane['P_441'] := z312
   hDane['P_442'] := z401
   hDane['P_443'] := z402
   hDane['P_444'] := z403
   hDane['P_445'] := z404
   hDane['P_446'] := z405
   hDane['P_447'] := z406
   hDane['P_448'] := z407
   hDane['P_449'] := z408
   hDane['P_450'] := z409
   hDane['P_451'] := z410
   hDane['P_452'] := z411
   hDane['P_453'] := z412
   hDane['P_454'] := z501
   hDane['P_455'] := z502
   hDane['P_456'] := z503
   hDane['P_457'] := z504
   hDane['P_458'] := z505
   hDane['P_459'] := z506
   hDane['P_460'] := z507
   hDane['P_461'] := z508
   hDane['P_462'] := z509
   hDane['P_463'] := z510
   hDane['P_464'] := z511
   hDane['P_465'] := z512

   hDane['P_466_1'] := '0'
   hDane['P_466_2'] := '1'

   hDane['P_467'] := 0
   hDane['P_468'] := 0
   hDane['P_469'] := 0
   hDane['P_470'] := 0
   hDane['P_471'] := 0
   hDane['P_472'] := 0
   hDane['P_473'] := 0
   hDane['P_474'] := 0
   hDane['P_475'] := 0
   hDane['P_476'] := 0
   hDane['P_477'] := 0
   hDane['P_478'] := 0

   hDane['P_479'] := z501
   hDane['P_480'] := z502
   hDane['P_481'] := z503
   hDane['P_482'] := z504
   hDane['P_483'] := z505
   hDane['P_484'] := z506
   hDane['P_485'] := z507
   hDane['P_486'] := z508
   hDane['P_487'] := z509
   hDane['P_488'] := z510
   hDane['P_489'] := z511
   hDane['P_490'] := z512

   hDane['P_491'] := 0
   hDane['P_492'] := 0
   hDane['P_493'] := 0
   hDane['P_494'] := 0
   hDane['P_495'] := 0
   hDane['P_496'] := 0
   hDane['P_497'] := 0
   hDane['P_498'] := 0
   hDane['P_499'] := 0
   hDane['P_500'] := 0
   hDane['P_501'] := 0
   hDane['P_502'] := 0

   hDane['P_503'] := iif( aPit48Covid[ 1 ], '1', '0' )
   hDane['P_504'] := iif( aPit48Covid[ 2 ], '1', '0' )
   hDane['P_505'] := iif( aPit48Covid[ 3 ], '1', '0' )
   hDane['P_506'] := iif( aPit48Covid[ 4 ], '1', '0' )
   hDane['P_507'] := iif( aPit48Covid[ 5 ], '1', '0' )
   hDane['P_508'] := iif( aPit48Covid[ 6 ], '1', '0' )
   hDane['P_509'] := iif( aPit48Covid[ 7 ], '1', '0' )
   hDane['P_510'] := iif( aPit48Covid[ 8 ], '1', '0' )
   hDane['P_511'] := iif( aPit48Covid[ 9 ], '1', '0' )
   hDane['P_512'] := iif( aPit48Covid[ 10 ], '1', '0' )
   hDane['P_513'] := iif( aPit48Covid[ 11 ], '1', '0' )
   hDane['P_514'] := iif( aPit48Covid[ 12 ], '1', '0' )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w22()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_6_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_6_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_7_1'] := iif( spolka_, '1', '0' )
   hDane['P_7_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_8_N'] := p8n
      hDane['P_8_R'] := p8r
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ELSE
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_9_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_9_D'] := P8d
   ENDIF
   hDane['P_10_1'] := '1'
   hDane['P_10_2'] := '0'
   IF Len(AllTrim(P30)) = 0
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := AllTrim(P29)
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := AllTrim(P30)
   ENDIF
   hDane['P_15'] := AllTrim(P31)
   hDane['P_16'] := AllTrim(P32)
   hDane['P_17'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_18'] := 'POLSKA'
   hDane['P_19'] := AllTrim(P38)
   hDane['P_20'] := AllTrim(P38a)
   hDane['P_21'] := AllTrim(P39)
   hDane['P_22'] := AllTrim(P40)
   hDane['P_23'] := AllTrim(P41)
   hDane['P_24'] := AllTrim(P42)
   hDane['P_25'] := AllTrim(P43)
   hDane['P_26'] := AllTrim(P44)
   hDane['P_27'] := AllTrim(P45)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := p61+p50_2
   hDane['P_37'] := p61+p50_2
   hDane['P_38'] := p63+p53_2
   hDane['P_39'] := p50_3
   hDane['P_40'] := p50_3
   hDane['P_41'] := zKOR_ZWEM
   hDane['P_42'] := p53_3
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := p50_4
   hDane['P_47'] := p50_4
   hDane['P_48'] := p53_4
   hDane['P_49'] := p50_5
   hDane['P_50'] := p51_5
   hDane['P_51'] := p52_5a
   hDane['P_52'] := p53_5
   hDane['P_53'] := p50_9
   hDane['P_54'] := p51_9
   hDane['P_55'] := p52_9a
   hDane['P_56'] := p53_9
   hDane['P_57'] := 0
   hDane['P_58'] := p52_6a
   hDane['P_59'] := p53_6
   hDane['P_60'] := p50_6
   hDane['P_61'] := p51_6
   hDane['P_62'] := p50_1
   hDane['P_63'] := p51_1
   hDane['P_64'] := p52_1a
   hDane['P_65'] := p53_1
   hDane['P_66'] := p50_7
   hDane['P_67'] := p50_7
   hDane['P_68'] := zKOR_ZWIN
   hDane['P_69'] := p53_7

   hDane['P_70'] := p52+p52z
   hDane['P_71'] := zKOR_SPOLZ
   hDane['P_72'] := p54a+p54za+p64
   hDane['P_73'] := zKOR_ZDROZ

   hDane['P_74'] := 0
   hDane['P_75'] := 0

   hDane['P_76_1'] := '0'
   hDane['P_76_2'] := '1'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w23()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_6_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_6_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_7_1'] := iif( spolka_, '1', '0' )
   hDane['P_7_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_8_N'] := p8n
      hDane['P_8_R'] := p8r
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ELSE
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_9_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_9_D'] := P8d
   ENDIF
   hDane['P_10_1'] := '1'
   hDane['P_10_2'] := '0'
   IF Len(AllTrim(P30)) = 0
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := AllTrim(P29)
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := AllTrim(P30)
   ENDIF
   hDane['P_12'] := AllTrim( P_DokIDNr )
   hDane['P_13'] := PracDokRodzajStr( P_DokIDTyp )
   hDane['P_14'] := P_KrajID
   hDane['P_15'] := AllTrim(P31)
   hDane['P_16'] := AllTrim(P32)
   hDane['P_17'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_18'] := P_18Kraj
   hDane['P_19'] := AllTrim(P38)
   hDane['P_20'] := AllTrim(P38a)
   hDane['P_21'] := AllTrim(P39)
   hDane['P_22'] := AllTrim(P40)
   hDane['P_23'] := AllTrim(P41)
   hDane['P_24'] := AllTrim(P42)
   hDane['P_25'] := AllTrim(P43)
   hDane['P_26'] := AllTrim(P44)
   hDane['P_27'] := AllTrim(P45)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := p61+p50_2
   hDane['P_37'] := p61+p50_2
   hDane['P_38'] := p63+p53_2
   hDane['P_39'] := p50_3
   hDane['P_40'] := p50_3
   hDane['P_41'] := zKOR_ZWEM
   hDane['P_42'] := p53_3
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := p50_4
   hDane['P_47'] := p50_4
   hDane['P_48'] := p53_4
   hDane['P_49'] := p50_5
   hDane['P_50'] := p51_5
   hDane['P_51'] := p52_5a
   hDane['P_52'] := p53_5
   hDane['P_53'] := p50_9
   hDane['P_54'] := p51_9
   hDane['P_55'] := p52_9a
   hDane['P_56'] := p53_9
   hDane['P_57'] := 0
   hDane['P_58'] := p52_6a
   hDane['P_59'] := p53_6
   hDane['P_60'] := p50_6
   hDane['P_61'] := p51_6
   hDane['P_62'] := p50_1
   hDane['P_63'] := p51_1
   hDane['P_64'] := p52_1a
   hDane['P_65'] := p53_1
   hDane['P_66'] := p50_7
   hDane['P_67'] := p50_7
   hDane['P_68'] := zKOR_ZWIN
   hDane['P_69'] := p53_7

   hDane['P_70'] := p52+p52z
   hDane['P_71'] := zKOR_SPOLZ
   hDane['P_72'] := p54a+p54za+p64
   hDane['P_73'] := zKOR_ZDROZ

   hDane['P_74'] := 0
   hDane['P_75'] := 0

   hDane['P_76_1'] := '0'
   hDane['P_76_2'] := '1'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w24()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_6_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_6_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_7_1'] := iif( spolka_, '1', '0' )
   hDane['P_7_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_8_N'] := p8n
      hDane['P_8_R'] := p8r
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ELSE
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_9_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_9_D'] := P8d
   ENDIF
   hDane['P_10_1'] := iif( DP10 == 'T', '1', '0' )
   hDane['P_10_2'] := iif( DP10 == 'N', '1', '0' )
   IF Len(AllTrim(P30)) = 0
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := AllTrim(P29)
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := AllTrim(P30)
   ENDIF
   hDane['P_12'] := AllTrim( P_DokIDNr )
   hDane['P_13'] := PracDokRodzajStr( P_DokIDTyp )
   hDane['P_14'] := P_KrajID
   hDane['P_15'] := AllTrim(P31)
   hDane['P_16'] := AllTrim(P32)
   hDane['P_17'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_18'] := P_18Kraj
   hDane['P_19'] := AllTrim(P38)
   hDane['P_20'] := AllTrim(P38a)
   hDane['P_21'] := AllTrim(P39)
   hDane['P_22'] := AllTrim(P40)
   hDane['P_23'] := AllTrim(P41)
   hDane['P_24'] := AllTrim(P42)
   hDane['P_25'] := AllTrim(P43)
   hDane['P_26'] := AllTrim(P44)
   hDane['P_27'] := AllTrim(P45)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := p61+p50_2
   hDane['P_37'] := p61+p50_2
   hDane['P_38'] := p63+p53_2
   hDane['P_39'] := p50_3
   hDane['P_40'] := p50_3
   hDane['P_41'] := zKOR_ZWEM
   hDane['P_42'] := p53_3
   hDane['P_43'] := 0
   hDane['P_44'] := 0
   hDane['P_45'] := 0
   hDane['P_46'] := p50_4
   hDane['P_47'] := p50_4
   hDane['P_48'] := p53_4
   hDane['P_49'] := p50_5
   hDane['P_50'] := p51_5
   hDane['P_51'] := p52_5a
   hDane['P_52'] := p53_5
   hDane['P_53'] := p50_9
   hDane['P_54'] := p51_9
   hDane['P_55'] := p52_9a
   hDane['P_56'] := p53_9
   hDane['P_57'] := 0
   hDane['P_58'] := p52_6a
   hDane['P_59'] := p53_6
   hDane['P_60'] := p50_6
   hDane['P_61'] := p51_6
   hDane['P_62'] := p50_1
   hDane['P_63'] := p51_1
   hDane['P_64'] := p52_1a
   hDane['P_65'] := p53_1
   hDane['P_66'] := p50_7
   hDane['P_67'] := p50_7
   hDane['P_68'] := zKOR_ZWIN
   hDane['P_69'] := p53_7

   hDane['P_70'] := p52+p52z
   hDane['P_71'] := zKOR_SPOLZ
   hDane['P_72'] := p54a+p54za+p64
   hDane['P_73'] := zKOR_ZDROZ

   hDane['P_74'] := 0
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_81'] := 0
   hDane['P_82'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0

   hDane['P_85_1'] := '0'
   hDane['P_85_2'] := '1'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w25()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := ''
   hDane['P_6'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_7_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_7_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_9_N'] := p8n
      hDane['P_9_R'] := p8r
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ELSE
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_10_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_10_D'] := P8d
   ENDIF
   hDane['P_11_1'] := iif( DP10 == 'T', '1', '0' )
   hDane['P_11_2'] := iif( DP10 == 'N', '1', '0' )
   IF Len(AllTrim(P30)) = 0
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := AllTrim(P29)
   ELSE
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := AllTrim(P30)
   ENDIF
   hDane['P_13'] := AllTrim( P_DokIDNr )
   hDane['P_14'] := PracDokRodzajStr( P_DokIDTyp )
   hDane['P_15'] := P_KrajID
   hDane['P_16'] := AllTrim(P31)
   hDane['P_17'] := AllTrim(P32)
   hDane['P_18'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_19'] := P_18Kraj
   hDane['P_20'] := AllTrim(P38)
   hDane['P_21'] := AllTrim(P38a)
   hDane['P_22'] := AllTrim(P39)
   hDane['P_23'] := AllTrim(P40)
   hDane['P_24'] := AllTrim(P41)
   hDane['P_25'] := AllTrim(P42)
   hDane['P_26'] := AllTrim(P43)
   hDane['P_27'] := AllTrim(P44)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := P50_R262
   hDane['P_37'] := P51_R262
   hDane['P_38'] := P53a_R262
   hDane['P_39'] := zKOR_ZWET
   hDane['P_40'] := P55_R262
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := p50_3
   hDane['P_44'] := p50_3
   hDane['P_45'] := zKOR_ZWEM
   hDane['P_46'] := p53_3
   hDane['P_47'] := p50_11
   hDane['P_48'] := p51_11
   hDane['P_49'] := p52_11a
   hDane['P_50'] := p53_11
   hDane['P_51'] := p50_5
   hDane['P_52'] := p51_5
   hDane['P_53'] := p52_5a
   hDane['P_54'] := p53_5
   hDane['P_55'] := P50_5_R262
   hDane['P_56'] := P51_5_R262
   hDane['P_57'] := P52_5a_R262
   hDane['P_58'] := P53_5_R262
   hDane['P_59'] := 0
   hDane['P_60'] := p52_6a
   hDane['P_61'] := p53_6
   hDane['P_62'] := p50_6
   hDane['P_63'] := p51_6
   hDane['P_64'] := p50_7
   hDane['P_65'] := p51_7
   hDane['P_66'] := P50_7-P51_7
   hDane['P_67'] := zKOR_ZWIN
   hDane['P_68'] := p53_7
   hDane['P_69'] := p52+p52z
   hDane['P_70'] := p52_R262+p52z_R262
   hDane['P_71'] := p52_R26+p52z_R26
   hDane['P_72'] := p54a+p54za+p64
   hDane['P_73'] := p54a_R262+p54za_R262+p64_R262
   hDane['P_74'] := zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26

   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_81'] := 0
   hDane['P_82'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := P50_R26 + P50_5_R26
   hDane['P_87'] := P50_R26
   hDane['P_88'] := P50_5_R26

   hDane['P_89_1'] := '0'
   hDane['P_89_2'] := '1'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w27()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := ''
   hDane['P_6'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_7_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_7_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_9_N'] := p8n
      hDane['P_9_R'] := p8r
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ELSE
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_10_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_10_D'] := P8d
   ENDIF
   hDane['P_11_1'] := iif( DP10 == 'T', '1', '0' )
   hDane['P_11_2'] := iif( DP10 == 'N', '1', '0' )
   IF Len(AllTrim(P30)) = 0
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := AllTrim(P29)
   ELSE
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := AllTrim(P30)
   ENDIF
   hDane['P_13'] := AllTrim( P_DokIDNr )
   hDane['P_14'] := PracDokRodzajStr( P_DokIDTyp )
   hDane['P_15'] := P_KrajID
   hDane['P_16'] := AllTrim(P31)
   hDane['P_17'] := AllTrim(P32)
   hDane['P_18'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_19'] := P_18Kraj
   hDane['P_20'] := AllTrim(P38)
   hDane['P_21'] := AllTrim(P38a)
   hDane['P_22'] := AllTrim(P39)
   hDane['P_23'] := AllTrim(P40)
   hDane['P_24'] := AllTrim(P41)
   hDane['P_25'] := AllTrim(P42)
   hDane['P_26'] := AllTrim(P43)
   hDane['P_27'] := AllTrim(P44)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   hDane['P_36'] := P50_R262
   hDane['P_37'] := P51_R262
   hDane['P_38'] := P53a_R262
   hDane['P_39'] := zKOR_ZWET
   hDane['P_40'] := P55_R262
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   hDane['P_43'] := p50_3
   hDane['P_44'] := p50_3
   hDane['P_45'] := zKOR_ZWEM
   hDane['P_46'] := p53_3
   hDane['P_47'] := p50_11
   hDane['P_48'] := p51_11
   hDane['P_49'] := p52_11a
   hDane['P_50'] := p53_11
   hDane['P_51'] := p50_5
   hDane['P_52'] := p51_5
   hDane['P_53'] := p52_5a
   hDane['P_54'] := p53_5
   hDane['P_55'] := P50_5_R262
   hDane['P_56'] := P51_5_R262
   hDane['P_57'] := P52_5a_R262
   hDane['P_58'] := P53_5_R262
   hDane['P_59'] := 0
   hDane['P_60'] := p52_6a
   hDane['P_61'] := p53_6
   hDane['P_62'] := p50_6
   hDane['P_63'] := p51_6

   hDane['P_64'] := 0
   hDane['P_65'] := 0
   hDane['P_66'] := 0
   hDane['P_67'] := 0
   hDane['P_68'] := 0
   hDane['P_69'] := 0

   hDane['P_70'] := p50_7
   hDane['P_71'] := p51_7
   hDane['P_72'] := P50_7-P51_7
   hDane['P_73'] := zKOR_ZWIN
   hDane['P_74'] := p53_7
   hDane['P_75'] := p52+p52z
   hDane['P_76'] := p52_R262+p52z_R262
   hDane['P_77'] := p52_R26+p52z_R26
   hDane['P_78'] := p54a+p54za+p64
   hDane['P_79'] := p54a_R262+p54za_R262+p64_R262
   hDane['P_80'] := zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26

   hDane['P_81'] := 0
   hDane['P_82'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0
   hDane['P_90'] := 0
   hDane['P_91'] := 0

   hDane['P_92'] := P50_R26 + P50_5_R26
   hDane['P_93'] := P50_R26
   hDane['P_94'] := P50_5_R26

   hDane['P_95'] := 0

   hDane['P_96_1'] := '0'
   hDane['P_96_2'] := '1'

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_PIT11w29()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := p1s
   hDane['P_2'] := ''
   hDane['P_4'] := substr(p4,13)
   hDane['P_5'] := ''
   hDane['P_6'] := iif( AllTrim(p6_kod) != '', KodUS2Nazwa( AllTrim(p6_kod) ), '' )
   hDane['P_7_1'] := iif( JAKICEL == 'K', '0', '1' )
   hDane['P_7_2'] := iif( JAKICEL == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   IF spolka_
      hDane['P_9_N'] := p8n
      hDane['P_9_R'] := p8r
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ELSE
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := naz_imie_naz(AllTrim(P8n))
      hDane['P_10_I'] := naz_imie_imie(AllTrim(P8n))
      hDane['P_10_D'] := P8d
   ENDIF
   hDane['P_11_1'] := iif( DP10 == 'T', '1', '0' )
   hDane['P_11_2'] := iif( DP10 == 'N', '1', '0' )
   IF Len(AllTrim(P30)) = 0
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := AllTrim(P29)
   ELSE
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := AllTrim(P30)
   ENDIF
   hDane['P_13'] := AllTrim( P_DokIDNr )
   hDane['P_14'] := PracDokRodzajStr( P_DokIDTyp )
   hDane['P_15'] := P_KrajID
   hDane['P_16'] := AllTrim(P31)
   hDane['P_17'] := AllTrim(P32)
   hDane['P_18'] := substr(p36,1,4) + '-' + substr(p36,7,4) + '-' + substr(p36,13)
   hDane['P_19'] := P_18Kraj
   hDane['P_20'] := AllTrim(P38)
   hDane['P_21'] := AllTrim(P38a)
   hDane['P_22'] := AllTrim(P39)
   hDane['P_23'] := AllTrim(P40)
   hDane['P_24'] := AllTrim(P41)
   hDane['P_25'] := AllTrim(P42)
   hDane['P_26'] := AllTrim(P43)
   hDane['P_27'] := AllTrim(P44)

   hDane['P_28_1'] := iif( DP28 == '1', '1', '0' )
   hDane['P_28_2'] := iif( DP28 == '2', '1', '0' )
   hDane['P_28_3'] := iif( DP28 == '3', '1', '0' )
   hDane['P_28_4'] := iif( DP28 == '4', '1', '0' )

   hDane['P_29'] := P50
   hDane['P_30'] := P51
   hDane['P_31'] := P53a
   hDane['P_32'] := zKOR_ZWET
   hDane['P_33'] := P55
   hDane['P_34'] := 0
   hDane['P_35'] := 0
   IF lPonizej26l
      hDane['P_36'] := P50_R262
      hDane['P_37'] := P51_R262
      hDane['P_38'] := P53a_R262
      hDane['P_39'] := zKOR_ZWET
      hDane['P_40'] := P55_R262
   ELSE
      hDane['P_36'] := 0
      hDane['P_37'] := 0
      hDane['P_38'] := 0
      hDane['P_39'] := 0
      hDane['P_40'] := 0
   ENDIF
   hDane['P_41'] := 0
   hDane['P_42'] := 0
   IF lEmeryt
      hDane['P_43'] := P50_R262
      hDane['P_44'] := P51_R262
      hDane['P_45'] := P53a_R262
      hDane['P_46'] := zKOR_ZWET
      hDane['P_47'] := P55_R262
   ELSE
      hDane['P_43'] := 0
      hDane['P_44'] := 0
      hDane['P_45'] := 0
      hDane['P_46'] := 0
      hDane['P_47'] := 0
   ENDIF
   hDane['P_48'] := 0
   hDane['P_49'] := 0
   hDane['P_50'] := p50_3
   hDane['P_51'] := p50_3
   hDane['P_52'] := zKOR_ZWEM
   hDane['P_53'] := p53_3
   hDane['P_54'] := p50_11
   hDane['P_55'] := p51_11
   hDane['P_56'] := p52_11a
   hDane['P_57'] := p53_11
   hDane['P_58'] := p50_5
   hDane['P_59'] := p51_5
   hDane['P_60'] := p52_5a
   hDane['P_61'] := p53_5
   IF lPonizej26l
      hDane['P_62'] := P50_5_R262
      hDane['P_63'] := P51_5_R262
      hDane['P_64'] := P52_5a_R262
      hDane['P_65'] := P53_5_R262
   ELSE
      hDane['P_62'] := 0
      hDane['P_63'] := 0
      hDane['P_64'] := 0
      hDane['P_65'] := 0
   ENDIF
   IF lEmeryt
      hDane['P_66'] := P50_5_R262
      hDane['P_67'] := P51_5_R262
      hDane['P_68'] := P52_5a_R262
      hDane['P_69'] := P53_5_R262
   ELSE
      hDane['P_66'] := 0
      hDane['P_67'] := 0
      hDane['P_68'] := 0
      hDane['P_69'] := 0
   ENDIF
   hDane['P_70'] := 0
   hDane['P_71'] := p52_6a
   hDane['P_72'] := p53_6
   hDane['P_73'] := p50_6
   hDane['P_74'] := p51_6
   hDane['P_75'] := 0
   hDane['P_76'] := 0
   hDane['P_77'] := 0
   hDane['P_78'] := 0
   hDane['P_79'] := 0
   hDane['P_80'] := 0
   hDane['P_81'] := 0
   hDane['P_82'] := 0
   hDane['P_83'] := 0
   hDane['P_84'] := 0
   hDane['P_85'] := 0
   hDane['P_86'] := 0
   hDane['P_87'] := 0
   hDane['P_88'] := 0
   hDane['P_89'] := 0

   hDane['P_90'] := p50_7
   hDane['P_91'] := p51_7
   hDane['P_92'] := P50_7-P51_7
   hDane['P_93'] := zKOR_ZWIN
   hDane['P_94'] := p53_7
   hDane['P_95'] := p52+p52z
   hDane['P_96'] := p52_R262+p52z_R262
   hDane['P_97'] := p52_R26+p52z_R26
   //hDane['P_78'] := p54a+p54za+p64
   //hDane['P_79'] := p54a_R262+p54za_R262+p64_R262
   //hDane['P_80'] := zKOR_ZDROZ+p54a_R26+p54za_R26+p64_R26

   hDane['P_98'] := 0
   hDane['P_99'] := 0
   hDane['P_100'] := 0
   hDane['P_101'] := 0
   hDane['P_102'] := 0
   hDane['P_103'] := 0
   hDane['P_104'] := 0
   hDane['P_105'] := 0
   hDane['P_106'] := 0
   hDane['P_107'] := 0
   hDane['P_108'] := 0

   IF RodzajUlgi == 'T'
      hDane['P_109'] := P50_R26 + P50_5_R26
      hDane['P_110'] := P50_R26
      hDane['P_111'] := P50_5_R26
   ELSE
      hDane['P_109'] := 0
      hDane['P_110'] := 0
      hDane['P_111'] := 0
   ENDIF

   hDane['P_112'] := 0
   hDane['P_113'] := 0

   IF RodzajUlgi == 'E'
      hDane['P_114'] := P50_R26 + P50_5_R26
      hDane['P_115'] := P50_R26
      hDane['P_116'] := P50_5_R26
   ELSE
      hDane['P_114'] := 0
      hDane['P_115'] := 0
      hDane['P_116'] := 0
   ENDIF

   hDane['P_117'] := 0

   hDane['P_118_1'] := iif( RodzajUlgi == 'E' .AND. cRodzPrzychZwol == '1', '1', '0' )
   hDane['P_119_1'] := iif( RodzajUlgi == 'E' .AND. cRodzPrzychZwol == '2', '1', '0' )
   hDane['P_120_1'] := iif( RodzajUlgi == 'E' .AND. cRodzPrzychZwol == '3', '1', '0' )

   hDane['P_121_1'] := '0'
   hDane['P_121_2'] := '1'

   hDane['P_122'] := SklZdrow
   hDane['P_123'] := 0

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w15()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := znowytran
   hDane['P_38'] := P75
   hDane['P_39'] := P76
   hDane['P_40'] := Pp8
   hDane['P_41'] := P45dek
   hDane['P_42'] := P46dek
   hDane['P_43'] := P49dek
   hDane['P_44'] := P50dek
   hDane['P_45'] := zkorekst
   hDane['P_46'] := zkorekpoz
   hDane['P_47'] := 0
   hDane['P_48'] := P79
   hDane['P_49'] := P98a
   hDane['P_50'] := pp13
   hDane['P_51'] := P98b
   hDane['P_52'] := P99a
   hDane['P_53'] := P99
   hDane['P_54'] := P99c
   hDane['P_55'] := P99abc
   hDane['P_56'] := P99ab
   hDane['P_57'] := P99b
   hDane['P_58'] := P99d

   hDane['P_59'] := iif( zf2='T', '1', '0' )
   hDane['P_60'] := iif( zf3='T', '1', '0' )
   hDane['P_61'] := iif( zf4='T', '1', '0' )
   hDane['P_62'] := iif( zf5='T', '1', '0' )
   hDane['P_63_1'] := 0
   hDane['P_63_2'] := 0

   hDane['P_64_1'] := 0
   hDane['P_64_2'] := 0
   hDane['P_65_1'] := 0
   hDane['P_65_2'] := 0
   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w16()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := 0
   hDane['P_38'] := znowytran
   hDane['P_39'] := P75
   hDane['P_40'] := P76
   hDane['P_41'] := Pp8
   hDane['P_42'] := P45dek
   hDane['P_43'] := P46dek
   hDane['P_44'] := P49dek
   hDane['P_45'] := P50dek
   hDane['P_46'] := zkorekst
   hDane['P_47'] := zkorekpoz
   hDane['P_48'] := 0
   hDane['P_49'] := P79
   hDane['P_50'] := P98a
   hDane['P_51'] := pp13
   hDane['P_52'] := P98b
   hDane['P_53'] := P99a
   hDane['P_54'] := P99
   hDane['P_55'] := P99c
   hDane['P_56'] := P99abc
   hDane['P_57'] := P99ab
   hDane['P_58'] := P99b
   hDane['P_59'] := P99d

   hDane['P_60'] := iif( zf2='T', '1', '0' )
   hDane['P_61'] := iif( zf3='T', '1', '0' )
   hDane['P_62'] := iif( zf4='T', '1', '0' )
   hDane['P_63'] := iif( zf5='T', '1', '0' )
   hDane['P_64_1'] := 0
   hDane['P_64_2'] := 0

   hDane['P_65_1'] := 0
   hDane['P_65_2'] := 0
   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0
   hDane['P_67_1'] := 0
   hDane['P_67_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w17()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := 0
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( P99abc )
   hDane['P_59'] := Int( P99ab )
   hDane['P_60'] := Int( P99b )
   hDane['P_61'] := Int( P99d )

   hDane['P_62'] := iif( zf2='T', '1', '0' )
   hDane['P_63'] := iif( zf3='T', '1', '0' )
   hDane['P_64'] := iif( zf4='T', '1', '0' )
   hDane['P_65'] := iif( zf5='T', '1', '0' )

   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0
   hDane['P_67_1'] := 0
   hDane['P_67_2'] := 0
   hDane['P_68_1'] := 0
   hDane['P_68_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w18()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( P99d )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )

   hDane['P_69_1'] := 0
   hDane['P_69_2'] := 0
   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0
   hDane['P_71_1'] := 0
   hDane['P_71_2'] := 0

   hDane['P_74'] := zAdrEMail

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w19()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( Max( 0, P99d ) )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )

   hDane['P_69_1'] := 0
   hDane['P_69_2'] := 0

   hDane['P_72'] := zAdrEMail
   hDane['P_73'] := AllTrim(zDEKLTEL)

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7w20()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( Max( 0, P99d ) )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )
   hDane['P_69'] := iif( lSplitPayment, '1', '0' )

   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0

   hDane['P_73'] := zAdrEMail
   hDane['P_74'] := AllTrim(zDEKLTEL)

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw9()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := znowytran
   hDane['P_38'] := P75
   hDane['P_39'] := P76
   hDane['P_40'] := Pp8
   hDane['P_41'] := P45dek
   hDane['P_42'] := P46dek
   hDane['P_43'] := P49dek
   hDane['P_44'] := P50dek
   hDane['P_45'] := zkorekst
   hDane['P_46'] := zkorekpoz
   hDane['P_47'] := 0
   hDane['P_48'] := P79
   hDane['P_49'] := P98a
   hDane['P_50'] := pp13
   hDane['P_51'] := P98b
   hDane['P_52'] := P99a
   hDane['P_53'] := P99
   hDane['P_54'] := P99c
   hDane['P_55'] := P99abc
   hDane['P_56'] := P99ab
   hDane['P_57'] := P99b
   hDane['P_58'] := P99d

   hDane['P_59'] := iif( zf2='T', '1', '0' )
   hDane['P_60'] := iif( zf3='T', '1', '0' )
   hDane['P_61'] := iif( zf4='T', '1', '0' )
   hDane['P_62'] := iif( zf5='T', '1', '0' )
   hDane['P_63_1'] := 0
   hDane['P_63_2'] := 0

   hDane['P_64_1'] := 0
   hDane['P_64_2'] := 0
   hDane['P_65_1'] := 0
   hDane['P_65_2'] := 0
   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw10()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := 0
   hDane['P_38'] := znowytran
   hDane['P_39'] := P75
   hDane['P_40'] := P76
   hDane['P_41'] := Pp8
   hDane['P_42'] := P45dek
   hDane['P_43'] := P46dek
   hDane['P_44'] := P49dek
   hDane['P_45'] := P50dek
   hDane['P_46'] := zkorekst
   hDane['P_47'] := zkorekpoz
   hDane['P_48'] := 0
   hDane['P_49'] := P79
   hDane['P_50'] := P98a
   hDane['P_51'] := pp13
   hDane['P_52'] := P98b
   hDane['P_53'] := P99a
   hDane['P_54'] := P99
   hDane['P_55'] := P99c
   hDane['P_56'] := P99abc
   hDane['P_57'] := P99ab
   hDane['P_58'] := P99b
   hDane['P_59'] := P99d

   hDane['P_60'] := iif( zf2='T', '1', '0' )
   hDane['P_61'] := iif( zf3='T', '1', '0' )
   hDane['P_62'] := iif( zf4='T', '1', '0' )
   hDane['P_63'] := iif( zf5='T', '1', '0' )
   hDane['P_64_1'] := 0
   hDane['P_64_2'] := 0

   hDane['P_65_1'] := 0
   hDane['P_65_2'] := 0
   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0
   hDane['P_67_1'] := 0
   hDane['P_67_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw11()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := 0
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( P99abc )
   hDane['P_59'] := Int( P99ab )
   hDane['P_60'] := Int( P99b )
   hDane['P_61'] := Int( P99d )

   hDane['P_62'] := iif( zf2='T', '1', '0' )
   hDane['P_63'] := iif( zf3='T', '1', '0' )
   hDane['P_64'] := iif( zf4='T', '1', '0' )
   hDane['P_65'] := iif( zf5='T', '1', '0' )

   hDane['P_66_1'] := 0
   hDane['P_66_2'] := 0
   hDane['P_67_1'] := 0
   hDane['P_67_2'] := 0
   hDane['P_68_1'] := 0
   hDane['P_68_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw12()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( P99d )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )

   hDane['P_69_1'] := 0
   hDane['P_69_2'] := 0
   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0
   hDane['P_71_1'] := 0
   hDane['P_71_2'] := 0

   hDane['P_74'] := zAdrEMail

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw13()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( Max( 0, P99d ) )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )

   hDane['P_69_1'] := 0
   hDane['P_69_2'] := 0

   hDane['P_72'] := zAdrEMail
   hDane['P_73'] := AllTrim(zDEKLTEL)

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Kw14()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := Int( zKOL39 )
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( P99a )
   hDane['P_56'] := Int( P99 )
   hDane['P_57'] := Int( P99c )
   hDane['P_58'] := Int( zZwrRaVAT )
   hDane['P_59'] := Int( P99abc )
   hDane['P_60'] := Int( P99ab )
   hDane['P_61'] := Int( P99b )
   hDane['P_62'] := Int( Max( 0, P99d ) )

   hDane['P_63'] := iif( zf2='T', '1', '0' )
   hDane['P_64'] := iif( zf3='T', '1', '0' )
   hDane['P_65'] := iif( zf4='T', '1', '0' )
   hDane['P_66'] := iif( zf5='T', '1', '0' )
   hDane['P_67'] := '0'
   hDane['P_68'] := iif( zZwrRaVAT > 0, '1', '0' )
   hDane['P_69'] := iif( lSplitPayment, '1', '0' )

   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0

   hDane['P_73'] := zAdrEMail
   hDane['P_74'] := AllTrim(zDEKLTEL)

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Dw6()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := znowytran
   hDane['P_38'] := P75
   hDane['P_39'] := P76
   hDane['P_40'] := Pp8
   hDane['P_41'] := P45dek
   hDane['P_42'] := P46dek
   hDane['P_43'] := P49dek
   hDane['P_44'] := P50dek
   hDane['P_45'] := zkorekst
   hDane['P_46'] := zkorekpoz
   hDane['P_47'] := 0
   hDane['P_48'] := P79
   hDane['P_49'] := P98a
   hDane['P_50'] := pp13
   hDane['P_51'] := P98b
   hDane['P_52'] := zVATZALMIE
   hDane['P_53'] := zVATNADKWA
   hDane['P_54'] := P98dozap
   hDane['P_55'] := P98rozn
   hDane['P_56_1'] := iif( p98taknie == 'N', '0', '1' )
   hDane['P_56_2'] := iif( p98taknie == 'N', '1', '0' )
   hDane['P_57'] := P98doprze
   hDane['P_58'] := P99a
   hDane['P_59'] := P99
   hDane['P_60'] := P99c
   hDane['P_61'] := P99abc
   hDane['P_62'] := P99ab
   hDane['P_63'] := P99b
   hDane['P_64'] := P99d

   hDane['P_65'] := iif( zf2='T', '1', '0' )
   hDane['P_66'] := iif( zf3='T', '1', '0' )
   hDane['P_67'] := iif( zf4='T', '1', '0' )
   hDane['P_68'] := iif( zf5='T', '1', '0' )
   hDane['P_69_1'] := 0
   hDane['P_69_2'] := 0

   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0
   hDane['P_71_1'] := 0
   hDane['P_71_2'] := 0
   hDane['P_72_1'] := 0
   hDane['P_72_2'] := 0
   hDane['P_73_1'] := 0
   hDane['P_73_2'] := 0

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Dw7()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := P64
   hDane['P_11'] := P64exp
   hDane['P_12'] := P64expue
   hDane['P_13'] := P67
   hDane['P_14'] := P67art129
   hDane['P_15'] := P61+P61a
   hDane['P_16'] := P62+P62a
   hDane['P_17'] := P69
   hDane['P_18'] := P70
   hDane['P_19'] := P71
   hDane['P_20'] := P72
   hDane['P_21'] := P65ue
   hDane['P_22'] := P65
   hDane['P_23'] := P65dekue
   hDane['P_24'] := P65vdekue
   hDane['P_25'] := P65dekit
   hDane['P_26'] := P65vdekit
   hDane['P_27'] := P65dekus
   hDane['P_28'] := P65vdekus
   hDane['P_29'] := P65dekusu
   hDane['P_30'] := P65vdekusu
   hDane['P_31'] := SEK_CV7net
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := P65dekwe
   hDane['P_35'] := P65vdekwe
   hDane['P_36'] := Pp12
   hDane['P_37'] := 0
   hDane['P_38'] := znowytran
   hDane['P_39'] := P75
   hDane['P_40'] := P76
   hDane['P_41'] := Pp8
   hDane['P_42'] := P45dek
   hDane['P_43'] := P46dek
   hDane['P_44'] := P49dek
   hDane['P_45'] := P50dek
   hDane['P_46'] := zkorekst
   hDane['P_47'] := zkorekpoz
   hDane['P_48'] := 0
   hDane['P_49'] := P79
   hDane['P_50'] := P98a
   hDane['P_51'] := pp13
   hDane['P_52'] := P98b
   hDane['P_53'] := zVATZALMIE
   hDane['P_54'] := zVATNADKWA
   hDane['P_55'] := P98dozap
   hDane['P_56'] := P98rozn
   hDane['P_57_1'] := iif( p98taknie == 'N', '0', '1' )
   hDane['P_57_2'] := iif( p98taknie == 'N', '1', '0' )
   hDane['P_58'] := P98doprze
   hDane['P_59'] := P99a
   hDane['P_60'] := P99
   hDane['P_61'] := P99c
   hDane['P_62'] := P99abc
   hDane['P_63'] := P99ab
   hDane['P_64'] := P99b
   hDane['P_65'] := P99d

   hDane['P_66'] := iif( zf2='T', '1', '0' )
   hDane['P_67'] := iif( zf3='T', '1', '0' )
   hDane['P_68'] := iif( zf4='T', '1', '0' )
   hDane['P_69'] := iif( zf5='T', '1', '0' )
   hDane['P_70_1'] := 0
   hDane['P_70_2'] := 0

   hDane['P_71_1'] := 0
   hDane['P_71_2'] := 0
   hDane['P_72_1'] := 0
   hDane['P_72_2'] := 0
   hDane['P_73_1'] := 0
   hDane['P_73_2'] := 0
   hDane['P_74_1'] := 0
   hDane['P_74_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT7Dw8()
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_10'] := Int( P64 )
   hDane['P_11'] := Int( P64exp )
   hDane['P_12'] := Int( P64expue )
   hDane['P_13'] := Int( P67 )
   hDane['P_14'] := Int( P67art129 )
   hDane['P_15'] := Int( P61+P61a )
   hDane['P_16'] := Int( P62+P62a )
   hDane['P_17'] := Int( P69 )
   hDane['P_18'] := Int( P70 )
   hDane['P_19'] := Int( P71 )
   hDane['P_20'] := Int( P72 )
   hDane['P_21'] := Int( P65ue )
   hDane['P_22'] := Int( P65 )
   hDane['P_23'] := Int( P65dekue )
   hDane['P_24'] := Int( P65vdekue )
   hDane['P_25'] := Int( P65dekit )
   hDane['P_26'] := Int( P65vdekit )
   hDane['P_27'] := Int( P65dekus )
   hDane['P_28'] := Int( P65vdekus )
   hDane['P_29'] := Int( P65dekusu )
   hDane['P_30'] := Int( P65vdekusu )
   hDane['P_31'] := Int( SEK_CV7net )
   hDane['P_32'] := 0
   hDane['P_33'] := 0
   hDane['P_34'] := Int( P65dekwe )
   hDane['P_35'] := Int( P65vdekwe )
   hDane['P_36'] := Int( Pp12 )
   hDane['P_37'] := Int( art111u6 )
   hDane['P_38'] := Int( znowytran )
   hDane['P_39'] := 0
   hDane['P_40'] := Int( P75 )
   hDane['P_41'] := Int( P76 )
   hDane['P_42'] := Int( Pp8 )
   hDane['P_43'] := Int( P45dek )
   hDane['P_44'] := Int( P46dek )
   hDane['P_45'] := Int( P49dek )
   hDane['P_46'] := Int( P50dek )
   hDane['P_47'] := Int( zkorekst )
   hDane['P_48'] := Int( zkorekpoz )
   hDane['P_49'] := Int( art89b1 )
   hDane['P_50'] := Int( art89b4 )
   hDane['P_51'] := Int( P79 )
   hDane['P_52'] := Int( P98a )
   hDane['P_53'] := Int( pp13 )
   hDane['P_54'] := Int( P98b )
   hDane['P_55'] := Int( zVATZALMIE )
   hDane['P_56'] := Int( zVATNADKWA )
   hDane['P_57'] := Int( P98dozap )
   hDane['P_58'] := Int( P98rozn )
   hDane['P_59_1'] := iif( p98taknie == 'N', '0', '1' )
   hDane['P_59_2'] := iif( p98taknie == 'N', '1', '0' )
   hDane['P_60'] := Int( P98doprze )
   hDane['P_61'] := Int( P99a )
   hDane['P_62'] := Int( P99 )
   hDane['P_63'] := Int( P99c )
   hDane['P_64'] := Int( P99abc )
   hDane['P_65'] := Int( P99ab )
   hDane['P_66'] := Int( P99b )
   hDane['P_67'] := Int( P99d )

   hDane['P_68'] := iif( zf2='T', '1', '0' )
   hDane['P_69'] := iif( zf3='T', '1', '0' )
   hDane['P_70'] := iif( zf4='T', '1', '0' )
   hDane['P_71'] := iif( zf5='T', '1', '0' )

   hDane['P_72_1'] := 0
   hDane['P_72_2'] := 0
   hDane['P_73_1'] := 0
   hDane['P_73_2'] := 0
   hDane['P_74_1'] := 0
   hDane['P_74_2'] := 0
   hDane['P_75_1'] := 0
   hDane['P_75_2'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT8w11( hDane )

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_25'] := 0
   hDane['P_28'] := zAdrEMail
   hDane['P_29'] := AllTrim(zDEKLTEL)
   hDane['P_30'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT9Mw10( hDane )

   hDane['P_1'] := P4
   hDane['P_2'] := ''
   hDane['P_4'] := p5a
   hDane['P_5'] := p5b
   hDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   hDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   hDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( spolka_, '0', '1' )
   hDane['P_9'] := P8 + ',     ' + P11

   hDane['P_19'] := 0
   hDane['P_22'] := zAdrEMail
   hDane['P_23'] := AllTrim(zDEKLTEL)
   hDane['P_24'] := 0

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATUEw3()
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()
   /* IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )
   aGrupa1 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa1' )
   aGrupa2 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa2' )
   aGrupa3 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa3' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_6'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

   AEval(aGrupa1, {|hPoz|
      hPoz['pusty'] := '0'
      IF hPoz['P_Dd'] == '2'
         hPoz['P_Dd1'] := '1'
      ELSE
         hPoz['P_Dd1'] := '0'
      ENDIF
   })
   AAdd(aGrupa1, hb_Hash('pusty', '1', 'P_Da', '', 'P_Db', '', 'P_Dc', '', 'P_Dd', '0', 'P_Dd1', '0'))
   hDane['Grupa1'] := aGrupa1

   AEval(aGrupa2, {|hPoz|
      hPoz['pusty'] := '0'
      IF hPoz['P_Nd'] == '2'
         hPoz['P_Nd1'] := '1'
      ELSE
         hPoz['P_Nd1'] := '0'
      ENDIF
   })
   AAdd(aGrupa2, hb_Hash('pusty', '1', 'P_Na', '', 'P_Nb', '', 'P_Nc', '', 'P_Nd', '0', 'P_Nd1', '0'))
   hDane['Grupa2'] := aGrupa2

   AEval(aGrupa3, {|hPoz|
      hPoz['pusty'] := '0'
   })
   AAdd(aGrupa3, hb_Hash('pusty', '1', 'P_Ua', '', 'P_Ub', '', 'P_Uc', ''))
   hDane['Grupa3'] := aGrupa3
      */
   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATUEw4()
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := AllTrim(P4)
   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(miesiac)
   hDane['P_6'] := AllTrim(p5b)
   hDane['P_7'] := iif( P6a != '', KodUS2Nazwa( P6a ), '' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   IF ! spolka_
      hDane['P_9'] := naz_imie_naz(AllTrim(P8ni)) + ', ' ;
        + naz_imie_imie(AllTrim(P8ni)) + ',      ' + DToC( P11d )
   ELSE
      hDane['P_9'] := AllTrim(P8n) + ',      ' + AllTrim(P11)
   ENDIF

   hDane[ 'Grupa1' ] := {}
   AEval( aUEs, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Dd1'] := iif( aPoz[4], '1', '0' )
      hPoz['P_Dd'] := iif( aPoz[4], '2', '1' )
      hPoz['P_Da'] := AllTrim(aPoz[1])
      hPoz['P_Db'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Dc'] := Int( aPoz[3] )
      AAdd( hDane[ 'Grupa1' ], hPoz )
   })
   AAdd( hDane[ 'Grupa1' ], hb_Hash('pusty', '1', 'P_Da', '', 'P_Db', '', 'P_Dc', '', 'P_Dd', '0', 'P_Dd1', '0'))

   hDane[ 'Grupa2' ] := {}
   AEval( aUEz, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Nd1'] := iif( aPoz[4], '1', '0' )
      hPoz['P_Nd'] := iif( aPoz[4], '2', '1' )
      hPoz['P_Na'] := AllTrim(aPoz[1])
      hPoz['P_Nb'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Nc'] := Int( aPoz[3] )
      AAdd( hDane[ 'Grupa2' ], hPoz )
   })
   AAdd( hDane[ 'Grupa2' ], hb_Hash('pusty', '1', 'P_Na', '', 'P_Nb', '', 'P_Nc', '', 'P_Nd', '0', 'P_Nd1', '0'))

   hDane[ 'Grupa3' ] := {}
   AEval( aUEu, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Ua'] := AllTrim(aPoz[1])
      hPoz['P_Ub'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Uc'] := Int( aPoz[3] )
      AAdd( hDane[ 'Grupa3' ], hPoz )
   })
   AAdd( hDane[ 'Grupa3' ], hb_Hash('pusty', '1', 'P_Ua', '', 'P_Ub', '', 'P_Uc', '') )
      */
   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATUEKw4( aDane )
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := AllTrim( aDane[ 'nip' ] )
   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim( aDane[ 'miesiac' ] )
   hDane['P_6'] := AllTrim( aDane[ 'rok' ] )
   hDane['P_7'] := iif( aDane[ 'kod_urzedu' ] != '', KodUS2Nazwa( aDane[ 'kod_urzedu' ] ), '' )
   hDane['P_8_1'] := iif( aDane[ 'spolka' ], '1', '0' )
   hDane['P_8_2'] := iif( ! aDane[ 'spolka' ], '1', '0' )
   IF ! aDane[ 'spolka' ]
      hDane['P_9'] := naz_imie_naz( AllTrim( aDane[ 'nazwisko' ] ) ) + ', ' ;
        + naz_imie_imie( AllTrim( aDane[ 'imie' ] ) ) + ',      ' + DToC( aDane[ 'data_ur' ] )
   ELSE
      hDane['P_9'] := AllTrim( aDane[ 'nazwa' ] ) + ',      ' + AllTrim( aDane[ 'regon' ] )
   ENDIF

   hDane[ 'Grupa1' ] := {}
   AEval( aDane[ 'poz_c' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_DBd1'] := iif( aPoz[ 'trojstr' ] == 'T', '1', '0' )
      hPoz['P_DBd'] := iif( aPoz[ 'trojstr' ] == 'T', '2', '1' )
      hPoz['P_DBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_DBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_DBc'] := Int( aPoz[ 'wartosc' ] )
      hPoz['P_DJd1'] := iif( aPoz[ 'jtrojstr' ] == 'T', '1', '0' )
      hPoz['P_DJd'] := iif( aPoz[ 'jtrojstr' ] == 'T', '2', '1' )
      hPoz['P_DJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_DJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_DJc'] := Int( aPoz[ 'jwartosc' ] )
      AAdd( hDane[ 'Grupa1' ], hPoz )
   } )
   IF Len( hDane[ 'Grupa1' ] ) == 0
      AAdd( hDane[ 'Grupa1' ], hb_Hash( 'pusty', '1', 'P_DBa', '', 'P_DBb', '', 'P_DBc', '', 'P_DBd', '0', 'P_DBd1', '0', 'P_DJa', '', 'P_DJb', '', 'P_DJc', '', 'P_DJd', '0', 'P_DJd1', '0') )
   ENDIF

   hDane[ 'Grupa2' ] := {}
   AEval( aDane[ 'poz_d' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_NBd1'] := iif( aPoz[ 'trojstr' ] == 'T', '1', '0' )
      hPoz['P_NBd'] := iif( aPoz[ 'trojstr' ] == 'T', '2', '1' )
      hPoz['P_NBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_NBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_NBc'] := Int( aPoz[ 'wartosc' ] )
      hPoz['P_NJd1'] := iif( aPoz[ 'jtrojstr' ] == 'T', '1', '0' )
      hPoz['P_NJd'] := iif( aPoz[ 'jtrojstr' ] == 'T', '2', '1' )
      hPoz['P_NJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_NJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_NJc'] := Int( aPoz[ 'jwartosc' ] )
      AAdd( hDane[ 'Grupa2' ], hPoz )
   })
   IF Len( hDane[ 'Grupa2' ] ) == 0
      AAdd( hDane[ 'Grupa2' ], hb_Hash( 'pusty', '1', 'P_NBa', '', 'P_NBb', '', 'P_NBc', '', 'P_NBd', '0', 'P_NBd1', '0', 'P_NJa', '', 'P_NJb', '', 'P_NJc', '', 'P_NJd', '0', 'P_NJd1', '0') )
   ENDIF

   hDane[ 'Grupa3' ] := {}
   AEval( aDane[ 'poz_e' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_UBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_UBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_UBc'] := Int( aPoz[ 'wartosc' ] )
      hPoz['P_UJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_UJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_UJc'] := Int( aPoz[ 'jwartosc' ] )
      AAdd( hDane[ 'Grupa3' ], hPoz )
   })
   IF Len( hDane[ 'Grupa3' ] ) == 0
      AAdd( hDane[ 'Grupa3' ], hb_Hash( 'pusty', '1', 'P_UBa', '', 'P_UBb', '', 'P_UBc', '',  'P_UJa', '', 'P_UJb', '', 'P_UJc', '' ) )
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATUEw5()
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := AllTrim(P4)
   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim(miesiac)
   hDane['P_6'] := AllTrim(p5b)
   hDane['P_7'] := iif( P6a != '', KodUS2Nazwa( P6a ), '' )
   hDane['P_8_1'] := iif( spolka_, '1', '0' )
   hDane['P_8_2'] := iif( ! spolka_, '1', '0' )
   IF ! spolka_
      hDane['P_9'] := naz_imie_naz(AllTrim(P8ni)) + ', ' ;
        + naz_imie_imie(AllTrim(P8ni)) + ',      ' + DToC( P11d )
   ELSE
      hDane['P_9'] := AllTrim(P8n) + ',      ' + AllTrim(P11)
   ENDIF

   hDane[ 'Grupa1' ] := {}
   AEval( aUEs, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Dd1'] := iif( aPoz[4], '1', '0' )
      hPoz['P_Dd'] := iif( aPoz[4], '2', '1' )
      hPoz['P_Da'] := AllTrim(aPoz[1])
      hPoz['P_Db'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Dc'] := _round( aPoz[3], 0 )
      AAdd( hDane[ 'Grupa1' ], hPoz )
   })
   AAdd( hDane[ 'Grupa1' ], hb_Hash('pusty', '1', 'P_Da', '', 'P_Db', '', 'P_Dc', '', 'P_Dd', '0', 'P_Dd1', '0'))

   hDane[ 'Grupa2' ] := {}
   AEval( aUEz, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Nd1'] := iif( aPoz[4], '1', '0' )
      hPoz['P_Nd'] := iif( aPoz[4], '2', '1' )
      hPoz['P_Na'] := AllTrim(aPoz[1])
      hPoz['P_Nb'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Nc'] := _round( aPoz[3], 0 )
      AAdd( hDane[ 'Grupa2' ], hPoz )
   })
   AAdd( hDane[ 'Grupa2' ], hb_Hash('pusty', '1', 'P_Na', '', 'P_Nb', '', 'P_Nc', '', 'P_Nd', '0', 'P_Nd1', '0'))

   hDane[ 'Grupa3' ] := {}
   AEval( aUEu, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_Ua'] := AllTrim(aPoz[1])
      hPoz['P_Ub'] := edekNipUE(AllTrim(aPoz[2]))
      hPoz['P_Uc'] := _round( aPoz[3], 0 )
      AAdd( hDane[ 'Grupa3' ], hPoz )
   })
   AAdd( hDane[ 'Grupa3' ], hb_Hash('pusty', '1', 'P_Ua', '', 'P_Ub', '', 'P_Uc', '') )

   hDane[ 'Grupa4' ] := {}
   AEval( aSekcjaF, { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz[ 'pusty' ] := '0'
      hPoz[ 'P_Ca' ] := AllTrim( aPoz[ 'kraj' ] )
      hPoz[ 'P_Cb' ] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz[ 'P_Cc' ] := edekNipUE( AllTrim( aPoz[ 'nipz' ] ) )
      hPoz[ 'P_Cd' ] := iif( aPoz[ 'powrot' ] == 'T', '2', '1' )
      hPoz[ 'P_Cdl' ] := iif( aPoz[ 'powrot' ] == 'T', '1', '0' )
      AAdd( hDane[ 'Grupa4' ], hPoz )
   })
   AAdd( hDane[ 'Grupa4' ], hb_Hash('pusty', '1', 'P_Ca', '', 'P_Cb', '', 'P_Cc', '', 'P_Cd', '1', 'P_Cdl', '0') )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATUEKw5( aDane )
   LOCAL hPodmiot1, cTmp
   LOCAL hDane := hb_Hash()

   hDane['P_1'] := AllTrim( aDane[ 'nip' ] )
   hDane['P_2'] := ''
   hDane['P_4'] := AllTrim( aDane[ 'miesiac' ] )
   hDane['P_6'] := AllTrim( aDane[ 'rok' ] )
   hDane['P_7'] := iif( aDane[ 'kod_urzedu' ] != '', KodUS2Nazwa( aDane[ 'kod_urzedu' ] ), '' )
   hDane['P_8_1'] := iif( aDane[ 'spolka' ], '1', '0' )
   hDane['P_8_2'] := iif( ! aDane[ 'spolka' ], '1', '0' )
   IF ! aDane[ 'spolka' ]
      hDane['P_9'] := naz_imie_naz( AllTrim( aDane[ 'nazwisko' ] ) ) + ', ' ;
        + naz_imie_imie( AllTrim( aDane[ 'imie' ] ) ) + ',      ' + DToC( aDane[ 'data_ur' ] )
   ELSE
      hDane['P_9'] := AllTrim( aDane[ 'nazwa' ] ) + ',      ' + AllTrim( aDane[ 'regon' ] )
   ENDIF

   hDane[ 'Grupa1' ] := {}
   AEval( aDane[ 'poz_c' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_DBd1'] := iif( aPoz[ 'trojstr' ] /* == 'T' */, '1', '0' )
      hPoz['P_DBd'] := iif( aPoz[ 'trojstr' ] /* == 'T' */, '2', '1' )
      hPoz['P_DBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_DBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_DBc'] := _round( aPoz[ 'wartosc' ], 0 )
      hPoz['P_DJd1'] := iif( aPoz[ 'jtrojstr' ] /* == 'T' */, '1', '0' )
      hPoz['P_DJd'] := iif( aPoz[ 'jtrojstr' ] /* == 'T' */, '2', '1' )
      hPoz['P_DJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_DJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_DJc'] := _round( aPoz[ 'jwartosc' ], 0 )
      AAdd( hDane[ 'Grupa1' ], hPoz )
   } )
   IF Len( hDane[ 'Grupa1' ] ) == 0
      AAdd( hDane[ 'Grupa1' ], hb_Hash( 'pusty', '1', 'P_DBa', '', 'P_DBb', '', 'P_DBc', '', 'P_DBd', '0', 'P_DBd1', '0', 'P_DJa', '', 'P_DJb', '', 'P_DJc', '', 'P_DJd', '0', 'P_DJd1', '0') )
   ENDIF

   hDane[ 'Grupa2' ] := {}
   AEval( aDane[ 'poz_d' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_NBd1'] := iif( aPoz[ 'trojstr' ] /* == 'T' */, '1', '0' )
      hPoz['P_NBd'] := iif( aPoz[ 'trojstr' ] /* == 'T' */, '2', '1' )
      hPoz['P_NBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_NBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_NBc'] := _round( aPoz[ 'wartosc' ], 0 )
      hPoz['P_NJd1'] := iif( aPoz[ 'jtrojstr' ] /* == 'T' */, '1', '0' )
      hPoz['P_NJd'] := iif( aPoz[ 'jtrojstr' ] /* == 'T' */, '2', '1' )
      hPoz['P_NJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_NJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_NJc'] := _round( aPoz[ 'jwartosc' ], 0 )
      AAdd( hDane[ 'Grupa2' ], hPoz )
   })
   IF Len( hDane[ 'Grupa2' ] ) == 0
      AAdd( hDane[ 'Grupa2' ], hb_Hash( 'pusty', '1', 'P_NBa', '', 'P_NBb', '', 'P_NBc', '', 'P_NBd', '0', 'P_NBd1', '0', 'P_NJa', '', 'P_NJb', '', 'P_NJc', '', 'P_NJd', '0', 'P_NJd1', '0') )
   ENDIF

   hDane[ 'Grupa3' ] := {}
   AEval( aDane[ 'poz_e' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_UBa'] := AllTrim( aPoz[ 'kraj' ] )
      hPoz['P_UBb'] := edekNipUE( AllTrim( aPoz[ 'nip' ] ) )
      hPoz['P_UBc'] := _round( aPoz[ 'wartosc' ], 0 )
      hPoz['P_UJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_UJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_UJc'] := _round( aPoz[ 'jwartosc' ], 0 )
      AAdd( hDane[ 'Grupa3' ], hPoz )
   })
   IF Len( hDane[ 'Grupa3' ] ) == 0
      AAdd( hDane[ 'Grupa3' ], hb_Hash( 'pusty', '1', 'P_UBa', '', 'P_UBb', '', 'P_UBc', '',  'P_UJa', '', 'P_UJb', '', 'P_UJc', '' ) )
   ENDIF

   hDane[ 'Grupa4' ] := {}
   AEval( aDane[ 'poz_f' ], { | aPoz |
      LOCAL hPoz := hb_Hash()
      hPoz['pusty'] := '0'
      hPoz['P_CBa'] := AllTrim( aPoz[ 'bkraj' ] )
      hPoz['P_CBb'] := edekNipUE( AllTrim( aPoz[ 'bnip' ] ) )
      hPoz['P_CBc'] := edekNipUE( AllTrim( aPoz[ 'bnipz' ] ) )
      hPoz['P_CBd'] := iif( aPoz[ 'bpowrot' ] == 'T', '2', '1' )
      hPoz['P_CBdl'] := iif( aPoz[ 'bpowrot' ] == 'T', '1', '0' )
      hPoz['P_CJa'] := AllTrim( aPoz[ 'jkraj' ] )
      hPoz['P_CJb'] := edekNipUE( AllTrim( aPoz[ 'jnip' ] ) )
      hPoz['P_CJc'] := edekNipUE( AllTrim( aPoz[ 'jnipz' ] ) )
      hPoz['P_CJd'] := iif( aPoz[ 'jpowrot' ] == 'T', '2', '1' )
      hPoz['P_CJdl'] := iif( aPoz[ 'jpowrot' ] == 'T', '1', '0' )
      AAdd( hDane[ 'Grupa4' ], hPoz )
   })
   IF Len( hDane[ 'Grupa4' ] ) == 0
      AAdd( hDane[ 'Grupa4' ], hb_Hash( 'pusty', '1', 'P_CBa', '', 'P_CBb', '', 'P_CBc', '', 'P_CBd', '0', 'P_CBdl', '0', 'P_CJa', '', 'P_CJb', '', 'P_CJc', '', 'P_CJd', '0', 'P_CJdl', '0' ) )
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VIUDOw1( aDaneOSS )

   LOCAL aDane := {=>}, cKrajL, cRodzajL, nSumT, nSumU, nSumC

   aDane[ 'P_1' ] := aDaneOSS[ 'firma' ][ 'NIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_3' ] := ''
   aDane[ 'P_4' ] := aDaneOSS[ 'kwartal' ]
   aDane[ 'P_5' ] := aDaneOSS[ 'rok' ]
   aDane[ 'P_6' ] := KodUS2Nazwa( aDaneOSS[ 'kod_urzedu' ] )
   aDane[ 'P_7_1' ] := iif( aDaneOSS[ 'cel' ] == 'D', '1', '0' )
   aDane[ 'P_7_2' ] := iif( aDaneOSS[ 'cel' ] == 'R', '1', '0' )
   aDane[ 'P_8' ] := date2strxml( aDaneOSS[ 'data_wypelnienia' ] )
   aDane[ 'P_9_1' ] := iif( aDaneOSS[ 'firma' ][ 'Spolka' ], '1', '0' )
   aDane[ 'P_9_2' ] := iif( aDaneOSS[ 'firma' ][ 'Spolka' ], '0', '1' )
   aDane[ 'P_10' ] := iif( aDaneOSS[ 'firma' ][ 'Spolka' ], ;
      aDaneOSS[ 'firma' ][ 'PelnaNazwa' ], ;
      aDaneOSS[ 'firma' ][ 'Nazwisko' ] + '    ' + aDaneOSS[ 'firma' ][ 'ImiePierwsze' ] )
   aDane[ 'P_11' ] := iif( Empty( aDaneOSS[ 'okres_od' ] ), '', date2strxml( aDaneOSS[ 'okres_od' ] ) )
   aDane[ 'P_12' ] := iif( Empty( aDaneOSS[ 'okres_do' ] ), '', date2strxml( aDaneOSS[ 'okres_do' ] ) )

   nSumT := 0
   nSumU := 0
   aDane[ 'SekcjaC2' ] := {}
   hb_HEval( aDaneOSS[ 'sekcja_c2' ], { | cKraj, aRodzaje |
      cKrajL := cKraj
      hb_HEval( aRodzaje, { | cRodzaj, aStawki |
         cRodzajL := cRodzaj
         hb_HEval( aStawki, { | nStawka, aWartosci |
            AAdd( aDane[ 'SekcjaC2' ], { ;
               'kraj' => KrajUENazwa( cKrajL ), ;
               'rodzaj' => iif( cRodzajL == 'U', '�wiadczenie us�ug', 'Dostawa towar�w' ), ;
               'stawkard' => iif( aWartosci[ 'stawkard' ] == 'O', 'Obni�ona', 'Podstawowa' ), ;
               'stawka' => nStawka, ;
               'nettoeur' => aWartosci[ 'nettoeur' ], ;
               'vateur' => aWartosci[ 'vateur' ] ;
            } )
            IF cRodzajL == 'U'
               nSumU += aWartosci[ 'vateur' ]
            ELSE
               nSumT += aWartosci[ 'vateur' ]
            ENDIF
         } )
      } )
   } )
   aDane[ 'P_13' ] := nSumU
   aDane[ 'P_14' ] := nSumT

   nSumC := nSumU + nSumT

   nSumT := 0
   nSumU := 0
   aDane[ 'SekcjaC3' ] := {}
   hb_HEval( aDaneOSS[ 'sekcja_c3' ], { | cKraj, aPozycje |
      cKrajL := cKraj
      hb_HEval( aPozycje, { | cKlucz, aPoz |
         AAdd( aDane[ 'SekcjaC3' ], { ;
            'kraj' => KrajUENazwa( cKrajL ), ;
            'krajdz' => KrajUENazwa( aPoz[ 'krajdz' ] ), ;
            'nr_idvat' => aPoz[ 'nr_idvat' ], ;
            'nr_idpod' => aPoz[ 'nr_idpod' ], ;
            'rodzaj' => iif( aPoz[ 'rodzdost' ] == 'U', '�wiadczenie us�ug', 'Dostawa towar�w' ), ;
            'stawkard' => iif( aPoz[ 'stawkard' ] == 'O', 'Obni�ona', 'Podstawowa' ), ;
            'stawka' => aPoz[ 'stawka' ], ;
            'nettoeur' => aPoz[ 'nettoeur' ], ;
            'vateur' => aPoz[ 'vateur' ] ;
         } )
         IF aPoz[ 'rodzdost' ] == 'U'
            nSumU += aPoz[ 'vateur' ]
         ELSE
            nSumT += aPoz[ 'vateur' ]
         ENDIF
      } )
   } )
   aDane[ 'P_15' ] := nSumU
   aDane[ 'P_16' ] := nSumT

   nSumC += nSumU + nSumT

   aDane[ 'P_17' ] := nSumC

   aDane[ 'SekcjaC5' ] := {}
   hb_HEval( aDaneOSS[ 'sekcja_c5' ], { | cKraj, aPozycje |
      cKrajL := cKraj
      AEval( aPozycje, { | aPoz |
         AAdd( aDane[ 'SekcjaC5' ], { ;
            'kraj' => KrajUENazwa( cKrajL ), ;
            'rok' => aPoz[ 'rok' ], ;
            'kwartal' => aPoz[ 'kwartal' ], ;
            'kwota' => aPoz[ 'kwota' ] ;
         } )
         IF aPoz[ 'kwota' ] > 0
            nSumC += aPoz[ 'kwota' ]
         ENDIF
      } )
   } )


   nSumC := 0
   aDane[ 'SekcjaC6' ] := {}
   hb_HEval( aDaneOSS[ 'sekcja_c6' ], { | cKraj, nKwota |
      AAdd( aDane[ 'SekcjaC6' ], { ;
         'kraj' => KrajUENazwa( cKraj ), ;
         'kwota' => nKwota ;
      } )
      IF nKwota > 0
         nSumC += nKwota
      ENDIF
   } )

   aDane[ 'P_18' ] := nSumC

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT27w1()
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2
   LOCAL hDane := hb_Hash()
   /* IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )
   aGrupa1 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa_C' )
   aGrupa2 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa_D' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4_M'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_4_K'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_9_1'] := iif( !xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   hDane['P_9_2'] := iif( xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'OsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

   hDane['Grupa1Sum'] := 0
   AEval(aGrupa1, { | hPoz |
      hPoz['P_C4'] := iif(HB_ISSTRING(hPoz['P_C4']), Val(hPoz['P_C4']), 0.0)
      hDane['Grupa1Sum'] := hDane['Grupa1Sum'] + hPoz['P_C4']
      hPoz['pusty'] := '0'
   })
   AAdd(aGrupa1, hb_Hash('pusty', '1', 'P_C2', '', 'P_C3', '', 'P_C4', 0))
   hDane['Grupa1'] := aGrupa1
   hDane['Grupa2Sum'] := 0
   AEval(aGrupa2, { | hPoz |
      hPoz['P_D4'] := iif(HB_ISSTRING(hPoz['P_D4']), Val(hPoz['P_D4']), 0.0)
      hDane['Grupa2Sum'] := hDane['Grupa2Sum'] + hPoz['P_D4']
      hPoz['pusty'] := '0'
   })
   AAdd(aGrupa2, hb_Hash('pusty', '1', 'P_D2', '', 'P_D3', '', 'P_D4', 0))
   hDane['Grupa2'] := aGrupa2
   */
   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VAT27w2( aDane )

   LOCAL hDane := hb_Hash()

   hDane['P_1'] := aDane[ 'firma' ][ 'nip' ]
   hDane['P_2'] := ''
   hDane['P_4'] := Val( miesiac )
   hDane['P_5'] := param_rok
   cTmp := aDane[ 'urzad' ][ 'kodurzedu' ]
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( aDane[ 'cel' ], '0', '1' )
   hDane['P_8_2'] := iif( aDane[ 'cel' ], '1', '0' )
   hDane['P_9_1'] := iif( aDane[ 'firma' ][ 'spolka' ], '1', '0' )
   hDane['P_9_2'] := iif( ! aDane[ 'firma' ][ 'spolka' ], '1', '0' )
   IF ! aDane[ 'firma' ][ 'spolka' ]
      hDane['P_10'] := naz_imie_naz( aDane[ 'spolka' ][ 'naz_imie' ] ) + ', ' ;
        + naz_imie_imie( aDane[ 'spolka' ][ 'naz_imie' ] ) + ',      ' + DToC( aDane[ 'spolka' ][ 'data_ur' ] )
   ELSE
      hDane['P_10'] := aDane[ 'firma' ][ 'nazwa' ] + ',      ' + SubStr( aDane[ 'firma' ][ 'nr_regon' ], 3, 9 )
   ENDIF

   hDane['P_PODPIS_IMIE'] := zDEKLIMIE
   hDane['P_PODPIS_NAZWISKO'] := zDEKLNAZWI
   hDane['P_PODPIS_TEL'] := zDEKLTEL
   hDane['P_PODPIS_DATA'] := ''

   hDane['Grupa1Sum'] := 0
   hDane[ 'Grupa1' ] := {}
   AEval( aDane[ 'pozycje' ], { | hPoz |
      LOCAL hDP := hb_Hash()
      hDP[ 'P_C4' ] := hPoz[ 'wartosc' ]
      hDP[ 'P_C2' ] := hPoz[ 'nazwa' ]
      hDP[ 'P_C3' ] := hPoz[ 'nip' ]
      hDP[ 'P_C1' ] := iif( hPoz[ 'zmiana' ], '1', '0' )
      hDane['Grupa1Sum'] := hDane['Grupa1Sum'] + hPoz['wartosc']
      hDP['pusty'] := '0'
      AAdd( hDane[ 'Grupa1' ], hDP )
   } )
   AAdd( hDane[ 'Grupa1' ], hb_Hash('pusty', '1', 'P_C2', '', 'P_C3', '', 'P_C4', 0))

   hDane['Grupa2'] := {}
   hDane['Grupa2Sum'] := 0
   AEval( aDane[ 'pozycje_u' ], { | hPoz |
      LOCAL hDP := hb_Hash()
      hDP[ 'P_D4' ] := hPoz[ 'wartosc' ]
      hDP[ 'P_D2' ] := hPoz[ 'nazwa' ]
      hDP[ 'P_D3' ] := hPoz[ 'nip' ]
      hDP[ 'P_D1' ] := iif( hPoz[ 'zmiana' ], '1', '0' )
      hDane['Grupa2Sum'] := hDane['Grupa2Sum'] + hPoz['wartosc']
      hDP['pusty'] := '0'
      AAdd( hDane[ 'Grupa2' ], hDP )
   })
   AAdd( hDane[ 'Grupa2' ], hb_Hash('pusty', '1', 'P_D2', '', 'P_D3', '', 'P_D4', 0))

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_IFT1w13( aDaneZrd )
   LOCAL aDane := hb_Hash()

   aDane[ 'P_1' ] := aDaneZrd[ 'Dane' ][ 'FirmaNIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_4' ] := aDaneZrd[ 'Parametry' ][ 'DataOd' ]
   aDane[ 'P_5' ] := aDaneZrd[ 'Parametry' ][ 'DataDo' ]
   aDane[ 'P_6' ] := iif( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) != '', KodUS2Nazwa( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) ), '' )
   aDane[ 'P_7_1' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '0', '1' )
   aDane[ 'P_7_2' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '1', '0' )
   aDane[ 'P_8_1' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '1', '0' )
   aDane[ 'P_8_2' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '0', '1' )
   IF aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ]
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwa' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaREGON' ]
   ELSE
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwisko' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaImie' ] + ', ' + DToC( aDaneZrd[ 'Dane' ][ 'FirmaData' ] )
   ENDIF
   aDane[ 'P_10' ] := 'POLSKA'
   aDane[ 'P_11' ] := aDaneZrd[ 'Dane' ][ 'FirmaWojewodztwo' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'Dane' ][ 'FirmaPowiat' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'Dane' ][ 'FirmaGmina' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'Dane' ][ 'FirmaUlica' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrDomu' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrLokalu' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'Dane' ][ 'FirmaMiejscowosc' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'Dane' ][ 'FirmaKodPocztowy' ]
   aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'FirmaPoczta' ]

   aDane[ 'P_20' ] := aDaneZrd[ 'Dane' ][ 'OsobaNazwisko' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'Dane' ][ 'OsobaImiePierwsze' ]
   aDane[ 'P_22' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieOjca' ]
   aDane[ 'P_23' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieMatki' ]
   aDane[ 'P_24' ] := aDaneZrd[ 'Dane' ][ 'OsobaDataUrodzenia' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejsceUrodzenia' ]
   aDane[ 'P_26' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrId' ]
   aDane[ 'P_27' ] := PracDokRodzajStr( aDaneZrd[ 'Dane' ][ 'OsobaRodzajNrId' ] )
   aDane[ 'P_28' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejscowosc' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'Dane' ][ 'OsobaKodPocztowy' ]
   aDane[ 'P_32' ] := aDaneZrd[ 'Dane' ][ 'OsobaUlica' ]
   aDane[ 'P_33' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrDomu' ]
   aDane[ 'P_34' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrLokalu' ]

   aDane[ 'P_71' ] := 0
   aDane[ 'P_72' ] := aDaneZrd[ 'Dane' ][ 'P_72' ]
   aDane[ 'P_73' ] := aDaneZrd[ 'Dane' ][ 'P_73' ]
   aDane[ 'P_74' ] := aDaneZrd[ 'Dane' ][ 'P_74' ]

   aDane[ 'P_75' ] := aDaneZrd[ 'Parametry' ][ 'DataZlozenia' ]
   aDane[ 'P_76' ] := aDaneZrd[ 'Parametry' ][ 'DataPrzekazania' ]

   aDane[ 'ROCZNY' ] := iif( aDaneZrd[ 'Parametry' ][ 'Roczny' ], '1', '0' )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_IFT1w15( aDaneZrd )
   LOCAL aDane := hb_Hash()

   aDane[ 'P_1' ] := aDaneZrd[ 'Dane' ][ 'FirmaNIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_4' ] := aDaneZrd[ 'Parametry' ][ 'DataOd' ]
   aDane[ 'P_5' ] := aDaneZrd[ 'Parametry' ][ 'DataDo' ]
   aDane[ 'P_6' ] := iif( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) != '', KodUS2Nazwa( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) ), '' )
   aDane[ 'P_7_1' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '0', '1' )
   aDane[ 'P_7_2' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '1', '0' )
   aDane[ 'P_8_1' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '1', '0' )
   aDane[ 'P_8_2' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '0', '1' )
   IF aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ]
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwa' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaREGON' ]
   ELSE
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwisko' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaImie' ] + ', ' + DToC( aDaneZrd[ 'Dane' ][ 'FirmaData' ] )
   ENDIF
   aDane[ 'P_10' ] := 'POLSKA'
   aDane[ 'P_11' ] := aDaneZrd[ 'Dane' ][ 'FirmaWojewodztwo' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'Dane' ][ 'FirmaPowiat' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'Dane' ][ 'FirmaGmina' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'Dane' ][ 'FirmaUlica' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrDomu' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrLokalu' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'Dane' ][ 'FirmaMiejscowosc' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'Dane' ][ 'FirmaKodPocztowy' ]
   //aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'FirmaPoczta' ]

   aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'OsobaNazwisko' ]
   aDane[ 'P_20' ] := aDaneZrd[ 'Dane' ][ 'OsobaImiePierwsze' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieOjca' ]
   aDane[ 'P_22' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieMatki' ]
   aDane[ 'P_23' ] := aDaneZrd[ 'Dane' ][ 'OsobaDataUrodzenia' ]
   aDane[ 'P_24' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejsceUrodzenia' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrId' ]
   aDane[ 'P_26' ] := PracDokRodzajStr( aDaneZrd[ 'Dane' ][ 'OsobaRodzajNrId' ] )
   aDane[ 'P_27' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_28' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejscowosc' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'Dane' ][ 'OsobaKodPocztowy' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'Dane' ][ 'OsobaUlica' ]
   aDane[ 'P_32' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrDomu' ]
   aDane[ 'P_33' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrLokalu' ]

   aDane[ 'P_70' ] := 0
   aDane[ 'P_71' ] := aDaneZrd[ 'Dane' ][ 'P_71' ]
   aDane[ 'P_72' ] := aDaneZrd[ 'Dane' ][ 'P_72' ]
   aDane[ 'P_73' ] := aDaneZrd[ 'Dane' ][ 'P_73' ]

   aDane[ 'P_74' ] := aDaneZrd[ 'Parametry' ][ 'DataZlozenia' ]
   aDane[ 'P_75' ] := aDaneZrd[ 'Parametry' ][ 'DataPrzekazania' ]

   aDane[ 'ROCZNY' ] := iif( aDaneZrd[ 'Parametry' ][ 'Roczny' ], '1', '0' )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_IFT1w16( aDaneZrd )
   LOCAL aDane := hb_Hash()

   aDane[ 'P_1' ] := aDaneZrd[ 'Dane' ][ 'FirmaNIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_4' ] := aDaneZrd[ 'Parametry' ][ 'DataOd' ]
   aDane[ 'P_5' ] := aDaneZrd[ 'Parametry' ][ 'DataDo' ]
   aDane[ 'P_6' ] := iif( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) != '', KodUS2Nazwa( AllTrim( aDaneZrd[ 'Dane' ][ 'KodUrzedu' ] ) ), '' )
   aDane[ 'P_7_1' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '0', '1' )
   aDane[ 'P_7_2' ] := iif( aDaneZrd[ 'Parametry' ][ 'Korekta' ], '1', '0' )
   aDane[ 'P_8_1' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '1', '0' )
   aDane[ 'P_8_2' ] := iif( aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ], '0', '1' )
   IF aDaneZrd[ 'Dane' ][ 'FirmaSpolka' ]
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwa' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaREGON' ]
   ELSE
      aDane[ 'P_9' ] := aDaneZrd[ 'Dane' ][ 'FirmaNazwisko' ] + ', ' + aDaneZrd[ 'Dane' ][ 'FirmaImie' ] + ', ' + DToC( aDaneZrd[ 'Dane' ][ 'FirmaData' ] )
   ENDIF
   aDane[ 'P_10' ] := 'POLSKA'
   aDane[ 'P_11' ] := aDaneZrd[ 'Dane' ][ 'FirmaWojewodztwo' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'Dane' ][ 'FirmaPowiat' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'Dane' ][ 'FirmaGmina' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'Dane' ][ 'FirmaUlica' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrDomu' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'Dane' ][ 'FirmaNrLokalu' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'Dane' ][ 'FirmaMiejscowosc' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'Dane' ][ 'FirmaKodPocztowy' ]
   //aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'FirmaPoczta' ]

   aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'OsobaNazwisko' ]
   aDane[ 'P_20' ] := aDaneZrd[ 'Dane' ][ 'OsobaImiePierwsze' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieOjca' ]
   aDane[ 'P_22' ] := aDaneZrd[ 'Dane' ][ 'OsobaImieMatki' ]
   aDane[ 'P_23' ] := aDaneZrd[ 'Dane' ][ 'OsobaDataUrodzenia' ]
   aDane[ 'P_24' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejsceUrodzenia' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrId' ]
   aDane[ 'P_26' ] := PracDokRodzajStr( aDaneZrd[ 'Dane' ][ 'OsobaRodzajNrId' ] )
   aDane[ 'P_27' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_28' ] := aDaneZrd[ 'Dane' ][ 'OsobaKraj' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'Dane' ][ 'OsobaMiejscowosc' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'Dane' ][ 'OsobaKodPocztowy' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'Dane' ][ 'OsobaUlica' ]
   aDane[ 'P_32' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrDomu' ]
   aDane[ 'P_33' ] := aDaneZrd[ 'Dane' ][ 'OsobaNrLokalu' ]

   aDane[ 'P_70' ] := 0
   aDane[ 'P_71' ] := aDaneZrd[ 'Dane' ][ 'P_71' ]
   aDane[ 'P_72' ] := aDaneZrd[ 'Dane' ][ 'P_72' ]
   aDane[ 'P_73' ] := aDaneZrd[ 'Dane' ][ 'P_73' ]

   aDane[ 'P_74' ] := aDaneZrd[ 'Parametry' ][ 'DataZlozenia' ]
   aDane[ 'P_75' ] := aDaneZrd[ 'Parametry' ][ 'DataPrzekazania' ]

   aDane[ 'ROCZNY' ] := iif( aDaneZrd[ 'Parametry' ][ 'Roczny' ], '1', '0' )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_IFT2w9( aDaneZrd )
   LOCAL aDane := hb_Hash()

   aDane[ 'P_1' ] := aDaneZrd[ 'Firma' ][ 'NIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_4' ] := aDaneZrd[ 'data_od' ]
   aDane[ 'P_5' ] := aDaneZrd[ 'data_do' ]
   aDane[ 'P_6' ] := iif( AllTrim( aDaneZrd[ 'Firma' ][ 'KodUrzedu' ] ) != '', KodUS2Nazwa( AllTrim( aDaneZrd[ 'Firma' ][ 'KodUrzedu' ] ) ), '' )
   aDane[ 'P_7_1' ] := iif( aDaneZrd[ 'korekta' ] == '1', '1', '0' )
   aDane[ 'P_7_2' ] := iif( aDaneZrd[ 'korekta' ] == '2', '1', '0' )
   aDane[ 'P_8_1' ] := iif( aDaneZrd[ 'Firma' ][ 'Spolka' ], '1', '0' )
   aDane[ 'P_8_2' ] := iif( aDaneZrd[ 'Firma' ][ 'Spolka' ], '0', '1' )
   IF aDaneZrd[ 'Firma' ][ 'Spolka' ]
      aDane[ 'P_9' ] := aDaneZrd[ 'Firma' ][ 'PelnaNazwa' ]
   ELSE
      aDane[ 'P_9' ] := aDaneZrd[ 'Firma' ][ 'Nazwisko' ] + ', ' + aDaneZrd[ 'Firma' ][ 'ImiePierwsze' ] + ', ' + DToC( aDaneZrd[ 'Firma' ][ 'DataUrodzenia' ] )
   ENDIF
   aDane[ 'P_10' ] := 'POLSKA'
   aDane[ 'P_11' ] := aDaneZrd[ 'Firma' ][ 'Wojewodztwo' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'Firma' ][ 'Powiat' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'Firma' ][ 'Gmina' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'Firma' ][ 'Ulica' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'Firma' ][ 'NrDomu' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'Firma' ][ 'NrLokalu' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'Firma' ][ 'Miejscowosc' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'Firma' ][ 'KodPocztowy' ]
   //aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'FirmaPoczta' ]

   aDane[ 'P_19' ] := ''
   aDane[ 'P_20' ] := aDaneZrd[ 'nazwa' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'nazwaskr' ]
   aDane[ 'P_22' ] := iif( Empty( aDaneZrd[ 'datarozp' ] ), '', aDaneZrd[ 'datarozp' ] )
   aDane[ 'P_23' ] := aDaneZrd[ 'rodzajid' ]
   aDane[ 'P_23_1' ] := iif( aDaneZrd[ 'rodzajid' ] == '1', '1', '0' )
   aDane[ 'P_23_2' ] := iif( aDaneZrd[ 'rodzajid' ] == '2', '1', '0' )
   aDane[ 'P_24' ] := aDaneZrd[ 'nridpod' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'krajwyd' ]
   aDane[ 'P_26' ] := aDaneZrd[ 'kraj' ]
   aDane[ 'P_27' ] := aDaneZrd[ 'miasto' ]
   aDane[ 'P_28' ] := aDaneZrd[ 'kodpoczt' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'ulica' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'nrbud' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'nrlok' ]

   aDane[ 'P_32' ] := aDaneZrd[ 'D1D' ]
   aDane[ 'P_33' ] := aDaneZrd[ 'D1E' ]
   aDane[ 'P_34' ] := aDaneZrd[ 'D1F' ]
   aDane[ 'P_35' ] := aDaneZrd[ 'D1G' ]
   aDane[ 'P_36' ] := aDaneZrd[ 'D2D' ]
   aDane[ 'P_37' ] := aDaneZrd[ 'D2E' ]
   aDane[ 'P_38' ] := aDaneZrd[ 'D2F' ]
   aDane[ 'P_39' ] := aDaneZrd[ 'D2G' ]
   aDane[ 'P_40' ] := aDaneZrd[ 'D3D' ]
   aDane[ 'P_41' ] := aDaneZrd[ 'D3E' ]
   aDane[ 'P_42' ] := aDaneZrd[ 'D3F' ]
   aDane[ 'P_43' ] := aDaneZrd[ 'D3G' ]
   aDane[ 'P_44' ] := aDaneZrd[ 'D4D' ]
   aDane[ 'P_45' ] := aDaneZrd[ 'D4E' ]
   aDane[ 'P_46' ] := aDaneZrd[ 'D4F' ]
   aDane[ 'P_47' ] := aDaneZrd[ 'D4G' ]
   aDane[ 'P_48' ] := aDaneZrd[ 'D5D' ]
   aDane[ 'P_49' ] := aDaneZrd[ 'D5E' ]
   aDane[ 'P_50' ] := aDaneZrd[ 'D5F' ]
   aDane[ 'P_51' ] := aDaneZrd[ 'D5G' ]
   aDane[ 'P_52' ] := aDaneZrd[ 'D6D' ]
   aDane[ 'P_53' ] := aDaneZrd[ 'D6E' ]
   aDane[ 'P_54' ] := aDaneZrd[ 'D6F' ]
   aDane[ 'P_55' ] := aDaneZrd[ 'D6G' ]
   aDane[ 'P_56' ] := aDaneZrd[ 'D7D' ]
   aDane[ 'P_57' ] := aDaneZrd[ 'D7E' ]
   aDane[ 'P_58' ] := aDaneZrd[ 'D7F' ]
   aDane[ 'P_59' ] := aDaneZrd[ 'D7G' ]
   aDane[ 'P_60' ] := aDaneZrd[ 'D8D' ]
   aDane[ 'P_61' ] := aDaneZrd[ 'D8E' ]
   aDane[ 'P_62' ] := aDaneZrd[ 'D8F' ]
   aDane[ 'P_63' ] := aDaneZrd[ 'D8G' ]
   aDane[ 'P_64' ] := aDaneZrd[ 'D9D' ]
   aDane[ 'P_65' ] := aDaneZrd[ 'D9E' ]
   aDane[ 'P_66' ] := aDaneZrd[ 'D9F' ]
   aDane[ 'P_67' ] := aDaneZrd[ 'D9G' ]

   aDane[ 'P_68' ] := aDaneZrd[ 'K01' ]
   aDane[ 'P_69' ] := aDaneZrd[ 'K02' ]
   aDane[ 'P_70' ] := aDaneZrd[ 'K03' ]
   aDane[ 'P_71' ] := aDaneZrd[ 'K04' ]
   aDane[ 'P_72' ] := aDaneZrd[ 'K05' ]
   aDane[ 'P_73' ] := aDaneZrd[ 'K06' ]
   aDane[ 'P_74' ] := aDaneZrd[ 'P01' ]
   aDane[ 'P_75' ] := aDaneZrd[ 'P02' ]
   aDane[ 'P_76' ] := aDaneZrd[ 'P03' ]
   aDane[ 'P_77' ] := aDaneZrd[ 'P04' ]
   aDane[ 'P_78' ] := aDaneZrd[ 'P05' ]
   aDane[ 'P_79' ] := aDaneZrd[ 'P06' ]
   aDane[ 'P_80' ] := aDaneZrd[ 'K07' ]
   aDane[ 'P_81' ] := aDaneZrd[ 'K08' ]
   aDane[ 'P_82' ] := aDaneZrd[ 'K09' ]
   aDane[ 'P_83' ] := aDaneZrd[ 'K10' ]
   aDane[ 'P_84' ] := aDaneZrd[ 'K11' ]
   aDane[ 'P_85' ] := aDaneZrd[ 'K12' ]
   aDane[ 'P_86' ] := aDaneZrd[ 'P07' ]
   aDane[ 'P_87' ] := aDaneZrd[ 'P08' ]
   aDane[ 'P_88' ] := aDaneZrd[ 'P09' ]
   aDane[ 'P_89' ] := aDaneZrd[ 'P10' ]
   aDane[ 'P_90' ] := aDaneZrd[ 'P11' ]
   aDane[ 'P_91' ] := aDaneZrd[ 'P12' ]
   aDane[ 'P_92' ] := aDaneZrd[ 'K13' ]
   aDane[ 'P_93' ] := aDaneZrd[ 'K14' ]
   aDane[ 'P_94' ] := aDaneZrd[ 'K15' ]
   aDane[ 'P_95' ] := aDaneZrd[ 'K16' ]
   aDane[ 'P_96' ] := aDaneZrd[ 'K17' ]
   aDane[ 'P_97' ] := aDaneZrd[ 'K18' ]
   aDane[ 'P_98' ] := aDaneZrd[ 'P13' ]
   aDane[ 'P_99' ] := aDaneZrd[ 'P14' ]
   aDane[ 'P_100' ] := aDaneZrd[ 'P15' ]
   aDane[ 'P_101' ] := aDaneZrd[ 'P16' ]
   aDane[ 'P_102' ] := aDaneZrd[ 'P17' ]
   aDane[ 'P_103' ] := aDaneZrd[ 'P18' ]
   aDane[ 'P_104' ] := aDaneZrd[ 'K19' ]
   aDane[ 'P_105' ] := aDaneZrd[ 'K20' ]
   aDane[ 'P_106' ] := aDaneZrd[ 'K21' ]
   aDane[ 'P_107' ] := aDaneZrd[ 'K22' ]
   aDane[ 'P_108' ] := aDaneZrd[ 'K23' ]
   aDane[ 'P_109' ] := aDaneZrd[ 'KR' ]
   aDane[ 'P_110' ] := aDaneZrd[ 'P19' ]
   aDane[ 'P_111' ] := aDaneZrd[ 'P20' ]
   aDane[ 'P_112' ] := aDaneZrd[ 'P21' ]
   aDane[ 'P_113' ] := aDaneZrd[ 'P22' ]
   aDane[ 'P_114' ] := aDaneZrd[ 'P23' ]
   aDane[ 'P_115' ] := aDaneZrd[ 'PR' ]

   aDane[ 'P_116' ] := iif( aDaneZrd[ 'rocznie' ], aDaneZrd[ 'miesiace' ], '' )
   aDane[ 'P_117' ] := iif( ! aDaneZrd[ 'rocznie' ], aDaneZrd[ 'data_zl' ], '' )
   aDane[ 'P_118' ] := aDaneZrd[ 'data_prz' ]

   aDane[ 'ROCZNY' ] := iif( aDaneZrd[ 'rocznie' ], '1', '0' )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_IFT2w11( aDaneZrd )
   LOCAL aDane := hb_Hash(), bVal := { | nVal | iif( nVal == 0, '', nVal ) }

   aDane[ 'P_1' ] := aDaneZrd[ 'Firma' ][ 'NIP' ]
   aDane[ 'P_2' ] := ''
   aDane[ 'P_4' ] := aDaneZrd[ 'data_od' ]
   aDane[ 'P_5' ] := aDaneZrd[ 'data_do' ]
   aDane[ 'P_6' ] := iif( AllTrim( aDaneZrd[ 'Firma' ][ 'KodUrzedu' ] ) != '', KodUS2Nazwa( AllTrim( aDaneZrd[ 'Firma' ][ 'KodUrzedu' ] ) ), '' )
   aDane[ 'P_7_1' ] := iif( aDaneZrd[ 'korekta' ] == '1', '1', '0' )
   aDane[ 'P_7_2' ] := iif( aDaneZrd[ 'korekta' ] == '2', '1', '0' )
   aDane[ 'P_8_1' ] := iif( aDaneZrd[ 'Firma' ][ 'Spolka' ], '1', '0' )
   aDane[ 'P_8_2' ] := iif( aDaneZrd[ 'Firma' ][ 'Spolka' ], '0', '1' )
   IF aDaneZrd[ 'Firma' ][ 'Spolka' ]
      aDane[ 'P_9' ] := aDaneZrd[ 'Firma' ][ 'PelnaNazwa' ]
   ELSE
      aDane[ 'P_9' ] := aDaneZrd[ 'Firma' ][ 'Nazwisko' ] + ', ' + aDaneZrd[ 'Firma' ][ 'ImiePierwsze' ] + ', ' + DToC( aDaneZrd[ 'Firma' ][ 'DataUrodzenia' ] )
   ENDIF
   aDane[ 'P_10' ] := 'POLSKA'
   aDane[ 'P_11' ] := aDaneZrd[ 'Firma' ][ 'Wojewodztwo' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'Firma' ][ 'Powiat' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'Firma' ][ 'Gmina' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'Firma' ][ 'Ulica' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'Firma' ][ 'NrDomu' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'Firma' ][ 'NrLokalu' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'Firma' ][ 'Miejscowosc' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'Firma' ][ 'KodPocztowy' ]
   //aDane[ 'P_19' ] := aDaneZrd[ 'Dane' ][ 'FirmaPoczta' ]

   aDane[ 'P_19' ] := ''
   aDane[ 'P_20' ] := aDaneZrd[ 'nazwa' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'nazwaskr' ]
   aDane[ 'P_22' ] := iif( Empty( aDaneZrd[ 'datarozp' ] ), '', aDaneZrd[ 'datarozp' ] )
   aDane[ 'P_23' ] := aDaneZrd[ 'rodzajid' ]
   aDane[ 'P_23_1' ] := iif( aDaneZrd[ 'rodzajid' ] == '1', '1', '0' )
   aDane[ 'P_23_2' ] := iif( aDaneZrd[ 'rodzajid' ] == '2', '1', '0' )
   aDane[ 'P_24' ] := aDaneZrd[ 'nridpod' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'krajwyd' ]
   aDane[ 'P_26' ] := iif( aDaneZrd[ 'powiazany' ] == 'T', '1', '2' )
   aDane[ 'P_26_1' ] := iif( aDaneZrd[ 'powiazany' ] == 'T', '1', '0' )
   aDane[ 'P_26_2' ] := iif( aDaneZrd[ 'powiazany' ] == 'T', '0', '1' )
   aDane[ 'P_27' ] := aDaneZrd[ 'kraj' ]
   aDane[ 'P_28' ] := aDaneZrd[ 'miasto' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'kodpoczt' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'ulica' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'nrbud' ]
   aDane[ 'P_32' ] := aDaneZrd[ 'nrlok' ]

   aDane[ 'P_33' ] := Eval( bVal, aDaneZrd[ 'D1D' ] )
   aDane[ 'P_34' ] := Eval( bVal, aDaneZrd[ 'D1E' ] )
   aDane[ 'P_35' ] := Eval( bVal, aDaneZrd[ 'D1G' ] )
   aDane[ 'P_E1' ] := Eval( bVal, aDaneZrd[ 'D1F' ] )
   aDane[ 'P_E2' ] := Eval( bVal, aDaneZrd[ 'D1D' ] )
   aDane[ 'P_E3' ] := Eval( bVal, aDaneZrd[ 'D1E' ] )
   aDane[ 'P_E4' ] := Eval( bVal, aDaneZrd[ 'D1G' ] )
   aDane[ 'PE' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_E1' ] ) .OR. ! Empty( aDane[ 'P_E2' ] ) .OR. ! Empty( aDane[ 'P_E3' ] ) .OR. ! Empty( aDane[ 'P_E4' ] ), 1, 0 ), ;
      'P_E1' => aDane[ 'P_E1' ], ;
      'P_E2' => aDane[ 'P_E2' ], ;
      'P_E3' => aDane[ 'P_E3' ], ;
      'P_E4' => aDane[ 'P_E4' ] } }

   aDane[ 'P_36' ] := Eval( bVal, aDaneZrd[ 'D2D' ] )
   aDane[ 'P_37' ] := Eval( bVal, aDaneZrd[ 'D2E' ] )
   aDane[ 'P_38' ] := Eval( bVal, aDaneZrd[ 'D2G' ] )
   aDane[ 'P_F1' ] := Eval( bVal, aDaneZrd[ 'D2F' ] )
   aDane[ 'P_F2' ] := Eval( bVal, aDaneZrd[ 'D2D' ] )
   aDane[ 'P_F3' ] := Eval( bVal, aDaneZrd[ 'D2E' ] )
   aDane[ 'P_F4' ] := Eval( bVal, aDaneZrd[ 'D2G' ] )
   aDane[ 'PF' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_F1' ] ) .OR. ! Empty( aDane[ 'P_F2' ] ) .OR. ! Empty( aDane[ 'P_F3' ] ) .OR. ! Empty( aDane[ 'P_F4' ] ), 1, 0 ), ;
      'P_F1' => aDane[ 'P_F1' ], ;
      'P_F2' => aDane[ 'P_F2' ], ;
      'P_F3' => aDane[ 'P_F3' ], ;
      'P_F4' => aDane[ 'P_F4' ] } }

   aDane[ 'P_39' ] := Eval( bVal, aDaneZrd[ 'D3D' ] )
   aDane[ 'P_40' ] := Eval( bVal, aDaneZrd[ 'D3E' ] )
   aDane[ 'P_41' ] := Eval( bVal, aDaneZrd[ 'D3G' ] )
   aDane[ 'P_G1' ] := Eval( bVal, aDaneZrd[ 'D3F' ] )
   aDane[ 'P_G2' ] := Eval( bVal, aDaneZrd[ 'D3D' ] )
   aDane[ 'P_G3' ] := Eval( bVal, aDaneZrd[ 'D3E' ] )
   aDane[ 'P_G4' ] := Eval( bVal, aDaneZrd[ 'D3G' ] )
   aDane[ 'PG' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_G1' ] ) .OR. ! Empty( aDane[ 'P_G2' ] ) .OR. ! Empty( aDane[ 'P_G3' ] ) .OR. ! Empty( aDane[ 'P_G4' ] ), 1, 0 ), ;
      'P_G1' => aDane[ 'P_G1' ], ;
      'P_G2' => aDane[ 'P_G2' ], ;
      'P_G3' => aDane[ 'P_G3' ], ;
      'P_G4' => aDane[ 'P_G4' ] } }

   aDane[ 'P_42' ] := Eval( bVal, aDaneZrd[ 'D4D' ] )
   aDane[ 'P_43' ] := Eval( bVal, aDaneZrd[ 'D4E' ] )
   aDane[ 'P_44' ] := Eval( bVal, aDaneZrd[ 'D4G' ] )
   aDane[ 'P_H1' ] := Eval( bVal, aDaneZrd[ 'D4F' ] )
   aDane[ 'P_H2' ] := Eval( bVal, aDaneZrd[ 'D4D' ] )
   aDane[ 'P_H3' ] := Eval( bVal, aDaneZrd[ 'D4E' ] )
   aDane[ 'P_H4' ] := Eval( bVal, aDaneZrd[ 'D4G' ] )
   aDane[ 'PH' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_H1' ] ) .OR. ! Empty( aDane[ 'P_H2' ] ) .OR. ! Empty( aDane[ 'P_H3' ] ) .OR. ! Empty( aDane[ 'P_H4' ] ), 1, 0 ), ;
      'P_H1' => aDane[ 'P_H1' ], ;
      'P_H2' => aDane[ 'P_H2' ], ;
      'P_H3' => aDane[ 'P_H3' ], ;
      'P_H4' => aDane[ 'P_H4' ] } }

   aDane[ 'P_45' ] := Eval( bVal, aDaneZrd[ 'D5D' ] )
   aDane[ 'P_46' ] := Eval( bVal, aDaneZrd[ 'D5E' ] )
   aDane[ 'P_47' ] := Eval( bVal, aDaneZrd[ 'D5G' ] )
   aDane[ 'P_I1' ] := Eval( bVal, aDaneZrd[ 'D5F' ] )
   aDane[ 'P_I2' ] := Eval( bVal, aDaneZrd[ 'D5D' ] )
   aDane[ 'P_I3' ] := Eval( bVal, aDaneZrd[ 'D5E' ] )
   aDane[ 'P_I4' ] := Eval( bVal, aDaneZrd[ 'D5G' ] )
   aDane[ 'PI' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_I1' ] ) .OR. ! Empty( aDane[ 'P_I2' ] ) .OR. ! Empty( aDane[ 'P_I3' ] ) .OR. ! Empty( aDane[ 'P_I4' ] ), 1, 0 ), ;
      'P_I1' => aDane[ 'P_I1' ], ;
      'P_I2' => aDane[ 'P_I2' ], ;
      'P_I3' => aDane[ 'P_I3' ], ;
      'P_I4' => aDane[ 'P_I4' ] } }

   aDane[ 'P_48' ] := Eval( bVal, aDaneZrd[ 'D6D' ] )
   aDane[ 'P_49' ] := Eval( bVal, aDaneZrd[ 'D6E' ] )
   aDane[ 'P_50' ] := Eval( bVal, aDaneZrd[ 'D6G' ] )
   aDane[ 'P_J1' ] := Eval( bVal, aDaneZrd[ 'D6F' ] )
   aDane[ 'P_J2' ] := Eval( bVal, aDaneZrd[ 'D6D' ] )
   aDane[ 'P_J3' ] := Eval( bVal, aDaneZrd[ 'D6E' ] )
   aDane[ 'P_J4' ] := Eval( bVal, aDaneZrd[ 'D6G' ] )
   aDane[ 'PJ' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_J1' ] ) .OR. ! Empty( aDane[ 'P_J2' ] ) .OR. ! Empty( aDane[ 'P_J3' ] ) .OR. ! Empty( aDane[ 'P_J4' ] ), 1, 0 ), ;
      'P_J1' => aDane[ 'P_J1' ], ;
      'P_J2' => aDane[ 'P_J2' ], ;
      'P_J3' => aDane[ 'P_J3' ], ;
      'P_J4' => aDane[ 'P_J4' ] } }

   aDane[ 'P_51' ] := Eval( bVal, aDaneZrd[ 'D7D' ] )
   aDane[ 'P_52' ] := Eval( bVal, aDaneZrd[ 'D7E' ] )
   aDane[ 'P_53' ] := Eval( bVal, aDaneZrd[ 'D7G' ] )
   aDane[ 'P_K1' ] := Eval( bVal, aDaneZrd[ 'D7F' ] )
   aDane[ 'P_K2' ] := Eval( bVal, aDaneZrd[ 'D7D' ] )
   aDane[ 'P_K3' ] := Eval( bVal, aDaneZrd[ 'D7E' ] )
   aDane[ 'P_K4' ] := Eval( bVal, aDaneZrd[ 'D7G' ] )
   aDane[ 'PK' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_K1' ] ) .OR. ! Empty( aDane[ 'P_K2' ] ) .OR. ! Empty( aDane[ 'P_K3' ] ) .OR. ! Empty( aDane[ 'P_K4' ] ), 1, 0 ), ;
      'P_K1' => aDane[ 'P_K1' ], ;
      'P_K2' => aDane[ 'P_K2' ], ;
      'P_K3' => aDane[ 'P_K3' ], ;
      'P_K4' => aDane[ 'P_K4' ] } }

   aDane[ 'P_54' ] := Eval( bVal, aDaneZrd[ 'D8D' ] )
   aDane[ 'P_55' ] := Eval( bVal, aDaneZrd[ 'D8E' ] )
   aDane[ 'P_56' ] := Eval( bVal, aDaneZrd[ 'D8G' ] )
   aDane[ 'P_57' ] := Eval( bVal, 0 )
   aDane[ 'P_L1' ] := Eval( bVal, aDaneZrd[ 'D8F' ] )
   aDane[ 'P_L2' ] := Eval( bVal, aDaneZrd[ 'D8D' ] )
   aDane[ 'P_L3' ] := Eval( bVal, aDaneZrd[ 'D8E' ] )
   aDane[ 'P_L4' ] := Eval( bVal, aDaneZrd[ 'D8G' ] )
   aDane[ 'P_L5' ] := Eval( bVal, 0 )
   aDane[ 'PL' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_L1' ] ) .OR. ! Empty( aDane[ 'P_L2' ] ) .OR. ! Empty( aDane[ 'P_L3' ] ) .OR. ! Empty( aDane[ 'P_L4' ] ), 1, 0 ), ;
      'P_L1' => aDane[ 'P_L1' ], ;
      'P_L2' => aDane[ 'P_L2' ], ;
      'P_L3' => aDane[ 'P_L3' ], ;
      'P_L4' => aDane[ 'P_L4' ], ;
      'P_L5' => aDane[ 'P_L5' ] } }

   aDane[ 'P_58' ] := Eval( bVal, aDaneZrd[ 'D9D' ] )
   aDane[ 'P_59' ] := Eval( bVal, aDaneZrd[ 'D9E' ] )
   aDane[ 'P_60' ] := Eval( bVal, aDaneZrd[ 'D9G' ] )
   aDane[ 'P_61' ] := Eval( bVal, 0 )
   aDane[ 'P_M1' ] := Eval( bVal, aDaneZrd[ 'D9F' ] )
   aDane[ 'P_M2' ] := Eval( bVal, aDaneZrd[ 'D9D' ] )
   aDane[ 'P_M3' ] := Eval( bVal, aDaneZrd[ 'D9E' ] )
   aDane[ 'P_M4' ] := Eval( bVal, aDaneZrd[ 'D9G' ] )
   aDane[ 'P_M5' ] := Eval( bVal, 0 )
   aDane[ 'PM' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_M1' ] ) .OR. ! Empty( aDane[ 'P_M2' ] ) .OR. ! Empty( aDane[ 'P_M3' ] ) .OR. ! Empty( aDane[ 'P_M4' ] ), 1, 0 ), ;
      'P_M1' => aDane[ 'P_M1' ], ;
      'P_M2' => aDane[ 'P_M2' ], ;
      'P_M3' => aDane[ 'P_M3' ], ;
      'P_M4' => aDane[ 'P_M4' ], ;
      'P_M5' => aDane[ 'P_M5' ] } }

   aDane[ 'P_62' ] := Eval( bVal, aDaneZrd[ 'D10D' ] )
   aDane[ 'P_63' ] := Eval( bVal, aDaneZrd[ 'D10E' ] )
   aDane[ 'P_64' ] := Eval( bVal, aDaneZrd[ 'D10G' ] )
   aDane[ 'P_65' ] := Eval( bVal, 0 )
   aDane[ 'P_N1' ] := Eval( bVal, aDaneZrd[ 'D10F' ] )
   aDane[ 'P_N2' ] := Eval( bVal, aDaneZrd[ 'D10D' ] )
   aDane[ 'P_N3' ] := Eval( bVal, aDaneZrd[ 'D10E' ] )
   aDane[ 'P_N4' ] := Eval( bVal, aDaneZrd[ 'D10G' ] )
   aDane[ 'P_N5' ] := Eval( bVal, 0 )
   aDane[ 'PN' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_N1' ] ) .OR. ! Empty( aDane[ 'P_N2' ] ) .OR. ! Empty( aDane[ 'P_N3' ] ) .OR. ! Empty( aDane[ 'P_N4' ] ), 1, 0 ), ;
      'P_N1' => aDane[ 'P_N1' ], ;
      'P_N2' => aDane[ 'P_N2' ], ;
      'P_N3' => aDane[ 'P_N3' ], ;
      'P_N4' => aDane[ 'P_N4' ], ;
      'P_N5' => aDane[ 'P_N5' ] } }

   aDane[ 'P_66' ] := Eval( bVal, aDaneZrd[ 'D11D' ] )
   aDane[ 'P_67' ] := Eval( bVal, aDaneZrd[ 'D11E' ] )
   aDane[ 'P_68' ] := Eval( bVal, aDaneZrd[ 'D11G' ] )
   aDane[ 'P_O1' ] := Eval( bVal, aDaneZrd[ 'D11F' ] )
   aDane[ 'P_O2' ] := Eval( bVal, aDaneZrd[ 'D11D' ] )
   aDane[ 'P_O3' ] := Eval( bVal, aDaneZrd[ 'D11E' ] )
   aDane[ 'P_O4' ] := Eval( bVal, aDaneZrd[ 'D11G' ] )
   aDane[ 'PO' ] := { { 'aktywny' => iif( ! Empty( aDane[ 'P_O1' ] ) .OR. ! Empty( aDane[ 'P_O2' ] ) .OR. ! Empty( aDane[ 'P_O3' ] ) .OR. ! Empty( aDane[ 'P_O4' ] ), 1, 0 ), ;
      'P_O1' => aDane[ 'P_O1' ], ;
      'P_O2' => aDane[ 'P_O2' ], ;
      'P_O3' => aDane[ 'P_O3' ], ;
      'P_O4' => aDane[ 'P_O4' ] } }

   aDane[ 'P_69' ] := aDaneZrd[ 'K01' ]
   aDane[ 'P_70' ] := aDaneZrd[ 'K02' ]
   aDane[ 'P_71' ] := aDaneZrd[ 'K03' ]
   aDane[ 'P_72' ] := aDaneZrd[ 'K04' ]
   aDane[ 'P_73' ] := aDaneZrd[ 'K05' ]
   aDane[ 'P_74' ] := aDaneZrd[ 'K06' ]
   aDane[ 'P_75' ] := aDaneZrd[ 'P01' ]
   aDane[ 'P_76' ] := aDaneZrd[ 'P02' ]
   aDane[ 'P_77' ] := aDaneZrd[ 'P03' ]
   aDane[ 'P_78' ] := aDaneZrd[ 'P04' ]
   aDane[ 'P_79' ] := aDaneZrd[ 'P05' ]
   aDane[ 'P_80' ] := aDaneZrd[ 'P06' ]
   aDane[ 'P_81' ] := aDaneZrd[ 'K07' ]
   aDane[ 'P_82' ] := aDaneZrd[ 'K08' ]
   aDane[ 'P_83' ] := aDaneZrd[ 'K09' ]
   aDane[ 'P_84' ] := aDaneZrd[ 'K10' ]
   aDane[ 'P_85' ] := aDaneZrd[ 'K11' ]
   aDane[ 'P_86' ] := aDaneZrd[ 'K12' ]
   aDane[ 'P_87' ] := aDaneZrd[ 'P07' ]
   aDane[ 'P_88' ] := aDaneZrd[ 'P08' ]
   aDane[ 'P_89' ] := aDaneZrd[ 'P09' ]
   aDane[ 'P_90' ] := aDaneZrd[ 'P10' ]
   aDane[ 'P_91' ] := aDaneZrd[ 'P11' ]
   aDane[ 'P_92' ] := aDaneZrd[ 'P12' ]
   aDane[ 'P_93' ] := aDaneZrd[ 'K13' ]
   aDane[ 'P_94' ] := aDaneZrd[ 'K14' ]
   aDane[ 'P_95' ] := aDaneZrd[ 'K15' ]
   aDane[ 'P_96' ] := aDaneZrd[ 'K16' ]
   aDane[ 'P_97' ] := aDaneZrd[ 'K17' ]
   aDane[ 'P_98' ] := aDaneZrd[ 'K18' ]
   aDane[ 'P_99' ] := aDaneZrd[ 'P13' ]
   aDane[ 'P_100' ] := aDaneZrd[ 'P14' ]
   aDane[ 'P_101' ] := aDaneZrd[ 'P15' ]
   aDane[ 'P_102' ] := aDaneZrd[ 'P16' ]
   aDane[ 'P_103' ] := aDaneZrd[ 'P17' ]
   aDane[ 'P_104' ] := aDaneZrd[ 'P18' ]
   aDane[ 'P_105' ] := aDaneZrd[ 'K19' ]
   aDane[ 'P_106' ] := aDaneZrd[ 'K20' ]
   aDane[ 'P_107' ] := aDaneZrd[ 'K21' ]
   aDane[ 'P_108' ] := aDaneZrd[ 'K22' ]
   aDane[ 'P_109' ] := aDaneZrd[ 'K23' ]
   aDane[ 'P_110' ] := aDaneZrd[ 'KR' ]
   aDane[ 'P_111' ] := aDaneZrd[ 'P19' ]
   aDane[ 'P_112' ] := aDaneZrd[ 'P20' ]
   aDane[ 'P_113' ] := aDaneZrd[ 'P21' ]
   aDane[ 'P_114' ] := aDaneZrd[ 'P22' ]
   aDane[ 'P_115' ] := aDaneZrd[ 'P23' ]
   aDane[ 'P_116' ] := aDaneZrd[ 'PR' ]

   aDane[ 'P_117' ] := iif( aDaneZrd[ 'rocznie' ], aDaneZrd[ 'miesiace' ], '' )
   aDane[ 'P_118' ] := iif( ! aDaneZrd[ 'rocznie' ], aDaneZrd[ 'data_zl' ], '' )
   aDane[ 'P_119' ] := aDaneZrd[ 'data_prz' ]

   aDane[ 'ROCZNY' ] := iif( aDaneZrd[ 'rocznie' ], '1', '0' )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_JPKV7w1( aDaneZrd )

   LOCAL aDane := hb_Hash(), nI

   aDane[ 'KodFormularza' ] := 'JPK_V7' + iif( aDaneZrd[ 'Kwartalnie' ], 'K', 'M' )
   aDane[ 'WariantFormularza' ] := '1'
   aDane[ 'KodFormularzaDekl' ] := 'VAT-7' + iif( aDaneZrd[ 'Kwartalnie' ], 'K', 'M' )
   aDane[ 'WariantFormularzaDekl' ] := iif( aDaneZrd[ 'Kwartalnie' ], '15', '21' )
   aDane[ 'DataWytworzeniaJPK' ] := aDaneZrd[ 'DataWytworzeniaJPK' ]
   aDane[ 'NazwaSystemu' ] :=  'AMi-BOOK'
   aDane[ 'KodUrzedu' ] := aDaneZrd[ 'KodUrzedu' ]
   aDane[ 'Rok' ] := aDaneZrd[ 'Rok' ]
   IF aDaneZrd[ 'Kwartalnie' ]
      aDane[ 'Kwartal' ] := aDaneZrd[ 'Kwartal' ]
   ELSE
      aDane[ 'Kwartal' ] := 0
   ENDIF
   aDane[ 'Miesiac' ] := aDaneZrd[ 'Miesiac' ]
   cTmp := aDaneZrd[ 'KodUrzedu' ]
   aDane[ 'UrzadSkarbowy' ] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   aDane[ 'NrRef' ] := ''

   aDane[ 'NIP' ] := aDaneZrd[ 'NIP' ]

   aDane[ 'CelZlozenia1' ] := iif( ! aDaneZrd[ 'Korekta' ], '1', '0' )
   aDane[ 'CelZlozenia2' ] := iif( aDaneZrd[ 'Korekta' ], '1', '0' )
   aDane[ 'PodmiotSpolka' ] := iif( aDaneZrd[ 'Spolka' ], '1', '0' )
   aDane[ 'PodmiotOsoba' ] := iif( ! aDaneZrd[ 'Spolka' ], '1', '0' )
   IF ! aDaneZrd[ 'Spolka' ]
      aDane[ 'PodmiotNazwa' ] := aDaneZrd[ 'Nazwisko' ] + ', ' ;
        + aDaneZrd[ 'ImiePierwsze' ]
   ELSE
      aDane[ 'PodmiotNazwa' ] := aDaneZrd[ 'PelnaNazwa' ]
   ENDIF

   aDane[ 'Email' ] := ''
   aDane[ 'Telefon' ] := ''

   IF ! aDaneZrd[ 'Spolka' ]
      aDane[ 'P_8_N' ] := ''
      aDane[ 'P_8_R' ] := ''
      aDane[ 'P_9_N' ] := aDaneZrd[ 'Nazwisko' ]
      aDane[ 'P_9_I' ] := aDaneZrd[ 'ImiePierwsze' ]
      aDane[ 'P_9_D' ] := date2strxml( aDaneZrd[ 'DataUrodzenia' ] )
      aDane[ 'P_9_E' ] := ''
      aDane[ 'P_9_T' ] := ''
   ELSE
      aDane[ 'P_8_N' ] := aDaneZrd[ 'PelnaNazwa' ]
      aDane[ 'P_8_R' ] := aDaneZrd[ 'NIP' ]
      aDane[ 'P_9_N' ] := ''
      aDane[ 'P_9_I' ] := ''
      aDane[ 'P_9_D' ] := ''
      aDane[ 'P_9_E' ] := ''
      aDane[ 'P_9_T' ] := ''
   ENDIF

   IF aDaneZrd[ 'Deklaracja' ]
      aDane[ 'JestDeklaracja' ] := .T.
      aDane[ 'P_10' ] := aDaneZrd[ 'DekV7' ][ 'P_10' ]
      aDane[ 'P_11' ] := aDaneZrd[ 'DekV7' ][ 'P_11' ]
      aDane[ 'P_12' ] := aDaneZrd[ 'DekV7' ][ 'P_12' ]
      aDane[ 'P_13' ] := aDaneZrd[ 'DekV7' ][ 'P_13' ]
      aDane[ 'P_14' ] := aDaneZrd[ 'DekV7' ][ 'P_14' ]
      aDane[ 'P_15' ] := aDaneZrd[ 'DekV7' ][ 'P_15' ]
      aDane[ 'P_16' ] := aDaneZrd[ 'DekV7' ][ 'P_16' ]
      aDane[ 'P_17' ] := aDaneZrd[ 'DekV7' ][ 'P_17' ]
      aDane[ 'P_18' ] := aDaneZrd[ 'DekV7' ][ 'P_18' ]
      aDane[ 'P_19' ] := aDaneZrd[ 'DekV7' ][ 'P_19' ]
      aDane[ 'P_20' ] := aDaneZrd[ 'DekV7' ][ 'P_20' ]
      aDane[ 'P_21' ] := aDaneZrd[ 'DekV7' ][ 'P_21' ]
      aDane[ 'P_22' ] := aDaneZrd[ 'DekV7' ][ 'P_22' ]
      aDane[ 'P_23' ] := aDaneZrd[ 'DekV7' ][ 'P_23' ]
      aDane[ 'P_24' ] := aDaneZrd[ 'DekV7' ][ 'P_24' ]
      aDane[ 'P_25' ] := aDaneZrd[ 'DekV7' ][ 'P_25' ]
      aDane[ 'P_26' ] := aDaneZrd[ 'DekV7' ][ 'P_26' ]
      aDane[ 'P_27' ] := aDaneZrd[ 'DekV7' ][ 'P_27' ]
      aDane[ 'P_28' ] := aDaneZrd[ 'DekV7' ][ 'P_28' ]
      aDane[ 'P_29' ] := aDaneZrd[ 'DekV7' ][ 'P_29' ]
      aDane[ 'P_30' ] := aDaneZrd[ 'DekV7' ][ 'P_30' ]
      aDane[ 'P_31' ] := aDaneZrd[ 'DekV7' ][ 'P_31' ]
      aDane[ 'P_32' ] := aDaneZrd[ 'DekV7' ][ 'P_32' ]
      aDane[ 'P_33' ] := aDaneZrd[ 'DekV7' ][ 'P_33' ]
      aDane[ 'P_34' ] := aDaneZrd[ 'DekV7' ][ 'P_34' ]
      aDane[ 'P_35' ] := aDaneZrd[ 'DekV7' ][ 'P_35' ]
      aDane[ 'P_36' ] := aDaneZrd[ 'DekV7' ][ 'P_36' ]
      aDane[ 'P_37' ] := aDaneZrd[ 'DekV7' ][ 'P_37' ]
      aDane[ 'P_38' ] := aDaneZrd[ 'DekV7' ][ 'P_38' ]
      aDane[ 'P_39' ] := aDaneZrd[ 'DekV7' ][ 'P_39' ]
      aDane[ 'P_40' ] := aDaneZrd[ 'DekV7' ][ 'P_40' ]
      aDane[ 'P_41' ] := aDaneZrd[ 'DekV7' ][ 'P_41' ]
      aDane[ 'P_42' ] := aDaneZrd[ 'DekV7' ][ 'P_42' ]
      aDane[ 'P_43' ] := aDaneZrd[ 'DekV7' ][ 'P_43' ]
      aDane[ 'P_44' ] := aDaneZrd[ 'DekV7' ][ 'P_44' ]
      aDane[ 'P_45' ] := aDaneZrd[ 'DekV7' ][ 'P_45' ]
      aDane[ 'P_46' ] := aDaneZrd[ 'DekV7' ][ 'P_46' ]
      aDane[ 'P_47' ] := aDaneZrd[ 'DekV7' ][ 'P_47' ]
      aDane[ 'P_48' ] := aDaneZrd[ 'DekV7' ][ 'P_48' ]
      aDane[ 'P_49' ] := aDaneZrd[ 'DekV7' ][ 'P_49' ]
      aDane[ 'P_50' ] := aDaneZrd[ 'DekV7' ][ 'P_50' ]
      aDane[ 'P_51' ] := aDaneZrd[ 'DekV7' ][ 'P_51' ]
      aDane[ 'P_52' ] := aDaneZrd[ 'DekV7' ][ 'P_52' ]
      aDane[ 'P_53' ] := aDaneZrd[ 'DekV7' ][ 'P_53' ]
      aDane[ 'P_54' ] := aDaneZrd[ 'DekV7' ][ 'P_54' ]
      aDane[ 'P_55' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_55' ], '1', '0' )
      aDane[ 'P_56' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_56' ], '1', '0' )
      aDane[ 'P_57' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_57' ], '1', '0' )
      aDane[ 'P_58' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_58' ], '1', '0' )
      aDane[ 'P_59' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_59' ], '1', '0' )
      aDane[ 'P_60' ] := aDaneZrd[ 'DekV7' ][ 'P_60' ]
      aDane[ 'P_61' ] := aDaneZrd[ 'DekV7' ][ 'P_61' ]
      aDane[ 'P_62' ] := aDaneZrd[ 'DekV7' ][ 'P_62' ]
      aDane[ 'P_63' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_63' ], '1', '0' )
      aDane[ 'P_64' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_64' ], '1', '0' )
      aDane[ 'P_65' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_65' ], '1', '0' )
      aDane[ 'P_66' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_66' ], '1', '0' )
      aDane[ 'P_67' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_67' ], '1', '0' )
      aDane[ 'P_68' ] := aDaneZrd[ 'DekV7' ][ 'P_68' ]
      aDane[ 'P_69' ] := aDaneZrd[ 'DekV7' ][ 'P_69' ]
      IF aDaneZrd[ 'DekV7' ][ 'Korekta' ] .AND. Len( AllTrim( aDaneZrd[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         aDane[ 'P_ORDZU' ] := AllTrim( aDaneZrd[ 'DekV7' ][ 'ORDZU' ] )
      ELSE
         aDane[ 'P_ORDZU' ] := ''
      ENDIF
   ELSE
      aDane[ 'JestDeklaracja' ] := .F.
   ENDIF

   IF aDaneZrd[ 'Rejestry' ]

      aDane[ 'Sprzedaz' ] := {}
      IF Len( aDaneZrd[ 'sprzedaz' ] ) > 0
         aDane[ 'JestSprzedaz' ] := .T.
         nI := 1
         AEval( aDaneZrd[ 'sprzedaz' ], { | aPoz |
            aPoz[ 'LpSprzedazy' ] := nI
            nI++
            IF hb_HHasKey( aPoz, 'MPP' ) .AND. aPoz[ 'MPP' ]
               aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + ' MPP'
            ENDIF
            IF ! hb_HHasKey( aPoz, 'KorektaPodstawyOpodt' )
               aPoz[ 'KorektaPodstawyOpodt' ] := '0'
            ELSE
               aPoz[ 'KorektaPodstawyOpodt' ] := iif( aPoz[ 'KorektaPodstawyOpodt' ], '1', '0' )
            ENDIF
            aPoz[ 'DataWystawienia' ] := date2strxml( aPoz[ 'DataWystawienia' ] )
            aPoz[ 'K_10' ] := HGetDefault( aPoz, 'K_10', 0 )
            aPoz[ 'K_11' ] := HGetDefault( aPoz, 'K_11', 0 )
            aPoz[ 'K_12' ] := HGetDefault( aPoz, 'K_12', 0 )
            aPoz[ 'K_13' ] := HGetDefault( aPoz, 'K_13', 0 )
            aPoz[ 'K_14' ] := HGetDefault( aPoz, 'K_14', 0 )
            aPoz[ 'K_15' ] := HGetDefault( aPoz, 'K_15', 0 )
            aPoz[ 'K_16' ] := HGetDefault( aPoz, 'K_16', 0 )
            aPoz[ 'K_17' ] := HGetDefault( aPoz, 'K_17', 0 )
            aPoz[ 'K_18' ] := HGetDefault( aPoz, 'K_18', 0 )
            aPoz[ 'K_19' ] := HGetDefault( aPoz, 'K_19', 0 )
            aPoz[ 'K_20' ] := HGetDefault( aPoz, 'K_20', 0 )
            aPoz[ 'K_21' ] := HGetDefault( aPoz, 'K_21', 0 )
            aPoz[ 'K_22' ] := HGetDefault( aPoz, 'K_22', 0 )
            aPoz[ 'K_23' ] := HGetDefault( aPoz, 'K_23', 0 )
            aPoz[ 'K_24' ] := HGetDefault( aPoz, 'K_24', 0 )
            aPoz[ 'K_25' ] := HGetDefault( aPoz, 'K_25', 0 )
            aPoz[ 'K_26' ] := HGetDefault( aPoz, 'K_26', 0 )
            aPoz[ 'K_27' ] := HGetDefault( aPoz, 'K_27', 0 )
            aPoz[ 'K_28' ] := HGetDefault( aPoz, 'K_28', 0 )
            aPoz[ 'K_29' ] := HGetDefault( aPoz, 'K_29', 0 )
            aPoz[ 'K_30' ] := HGetDefault( aPoz, 'K_30', 0 )
            aPoz[ 'K_31' ] := HGetDefault( aPoz, 'K_31', 0 )
            aPoz[ 'K_32' ] := HGetDefault( aPoz, 'K_32V', 0 )
            aPoz[ 'K_33' ] := HGetDefault( aPoz, 'K_36', 0 )
            aPoz[ 'K_34' ] := HGetDefault( aPoz, 'K_37', 0 )
            aPoz[ 'K_35' ] := HGetDefault( aPoz, 'K_38', 0 )
            aPoz[ 'K_36' ] := HGetDefault( aPoz, 'K_39', 0 )
            aPoz[ 'SprzedazVAT_Marza' ] := HGetDefault( aPoz, 'SprzedazVAT_Marza', 0 )
            IF hb_HHasKey( aPoz, 'DataSprzedazy' )
               aPoz[ 'DataSprzedazy' ] := date2strxml( aPoz[ 'DataSprzedazy' ] )
            ELSE
               aPoz[ 'DataSprzedazy' ] := ""
            ENDIF
            IF ( hb_HHasKey( aPoz, 'TypDokumentu' ) .AND. AllTrim( aPoz[ 'TypDokumentu' ] ) == "FP" ) ;
               .OR. ( At( "MR_UZ", aPoz[ 'Procedura' ] ) > 0 .AND. ( aPoz[ 'K_10' ] < 0 .OR. ;
               aPoz[ 'K_11' ] < 0 .OR. aPoz[ 'K_12' ] < 0 .OR. aPoz[ 'K_13' ] < 0 .OR. ;
               aPoz[ 'K_14' ] < 0 .OR. aPoz[ 'K_15' ] < 0 .OR. aPoz[ 'K_17' ] < 0 .OR. ;
               aPoz[ 'K_19' ] < 0 .OR. aPoz[ 'K_21' ] < 0 .OR. aPoz[ 'K_22' ] < 0 ) )

               aPoz[ 'Sumuj' ] := 0
            ELSE
               aPoz[ 'Sumuj' ] := 1
            ENDIF
            AAdd( aDane[ 'Sprzedaz' ], aPoz )
         } )
      ELSE
         aDane[ 'JestSprzedaz' ] := .F.
      ENDIF

      aDane[ 'Zakup' ] := {}
      IF Len( aDaneZrd[ 'zakup' ] ) > 0
         aDane[ 'JestZakup' ] := .T.
         nI := 1
         AEval( aDaneZrd[ 'zakup' ], { | aPoz |
            aPoz[ 'LpZakupu' ] := nI
            nI++
            aPoz[ 'DataZakupu' ] := date2strxml( aPoz[ 'DataZakupu' ] )
            aPoz[ 'DokumentZakupu' ] := HGetDefault( aPoz, 'DokumentZakupu', '' )
            aPoz[ 'MPP' ] := iif( aPoz[ 'MPP' ], '1', '0' )
            aPoz[ 'IMP' ] := iif( aPoz[ 'IMP' ], '1', '0' )
            aPoz[ 'K_40' ] := HGetDefault( aPoz, 'K_43', 0 )
            aPoz[ 'K_41' ] := HGetDefault( aPoz, 'K_44', 0 )
            aPoz[ 'K_42' ] := HGetDefault( aPoz, 'K_45', 0 )
            aPoz[ 'K_43' ] := HGetDefault( aPoz, 'K_46', 0 )
            aPoz[ 'K_44' ] := HGetDefault( aPoz, 'K_47', 0 )
            aPoz[ 'K_45' ] := HGetDefault( aPoz, 'K_48', 0 )
            aPoz[ 'K_46' ] := HGetDefault( aPoz, 'K_49', 0 )
            aPoz[ 'K_47' ] := HGetDefault( aPoz, 'K_50', 0 )
            aPoz[ 'ZakupVAT_Marza' ] := HGetDefault( aPoz, 'ZakupVAT_Marza', 0 )
            IF hb_HHasKey( aPoz, 'DataWplywu' )
               aPoz[ 'DataWplywu' ] := date2strxml( aPoz[ 'DataWplywu' ] )
            ELSE
               aPoz[ 'DataWplywu' ] := ""
            ENDIF
            AAdd( aDane[ 'Zakup' ], aPoz )
         } )
      ELSE
         aDane[ 'JestZakup' ] := .F.
      ENDIF
   ELSE
      aDane[ 'JestSprzedaz' ] := .F.
      aDane[ 'JestZakup' ] := .F.
   ENDIF

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_JPKV7w2( aDaneZrd )

   LOCAL aDane := hb_Hash(), nI

   aDane[ 'KodFormularza' ] := 'JPK_V7' + iif( aDaneZrd[ 'Kwartalnie' ], 'K', 'M' )
   aDane[ 'WariantFormularza' ] := '1'
   aDane[ 'KodFormularzaDekl' ] := 'VAT-7' + iif( aDaneZrd[ 'Kwartalnie' ], 'K', 'M' )
   aDane[ 'WariantFormularzaDekl' ] := iif( aDaneZrd[ 'Kwartalnie' ], '15', '21' )
   aDane[ 'DataWytworzeniaJPK' ] := aDaneZrd[ 'DataWytworzeniaJPK' ]
   aDane[ 'NazwaSystemu' ] :=  'AMi-BOOK'
   aDane[ 'KodUrzedu' ] := aDaneZrd[ 'KodUrzedu' ]
   aDane[ 'Rok' ] := aDaneZrd[ 'Rok' ]
   IF aDaneZrd[ 'Kwartalnie' ]
      aDane[ 'Kwartal' ] := aDaneZrd[ 'Kwartal' ]
   ELSE
      aDane[ 'Kwartal' ] := 0
   ENDIF
   aDane[ 'Miesiac' ] := aDaneZrd[ 'Miesiac' ]
   cTmp := aDaneZrd[ 'KodUrzedu' ]
   aDane[ 'UrzadSkarbowy' ] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   aDane[ 'NrRef' ] := ''

   aDane[ 'NIP' ] := aDaneZrd[ 'NIP' ]

   aDane[ 'CelZlozenia1' ] := iif( ! aDaneZrd[ 'Korekta' ], '1', '0' )
   aDane[ 'CelZlozenia2' ] := iif( aDaneZrd[ 'Korekta' ], '1', '0' )
   aDane[ 'PodmiotSpolka' ] := iif( aDaneZrd[ 'Spolka' ], '1', '0' )
   aDane[ 'PodmiotOsoba' ] := iif( ! aDaneZrd[ 'Spolka' ], '1', '0' )
   IF ! aDaneZrd[ 'Spolka' ]
      aDane[ 'PodmiotNazwa' ] := aDaneZrd[ 'Nazwisko' ] + ', ' ;
        + aDaneZrd[ 'ImiePierwsze' ]
   ELSE
      aDane[ 'PodmiotNazwa' ] := aDaneZrd[ 'PelnaNazwa' ]
   ENDIF

   aDane[ 'Email' ] := ''
   aDane[ 'Telefon' ] := ''

   IF ! aDaneZrd[ 'Spolka' ]
      aDane[ 'P_8_N' ] := ''
      aDane[ 'P_8_R' ] := ''
      aDane[ 'P_9_N' ] := aDaneZrd[ 'Nazwisko' ]
      aDane[ 'P_9_I' ] := aDaneZrd[ 'ImiePierwsze' ]
      aDane[ 'P_9_D' ] := date2strxml( aDaneZrd[ 'DataUrodzenia' ] )
      aDane[ 'P_9_E' ] := ''
      aDane[ 'P_9_T' ] := ''
   ELSE
      aDane[ 'P_8_N' ] := aDaneZrd[ 'PelnaNazwa' ]
      aDane[ 'P_8_R' ] := aDaneZrd[ 'NIP' ]
      aDane[ 'P_9_N' ] := ''
      aDane[ 'P_9_I' ] := ''
      aDane[ 'P_9_D' ] := ''
      aDane[ 'P_9_E' ] := ''
      aDane[ 'P_9_T' ] := ''
   ENDIF

   IF aDaneZrd[ 'Deklaracja' ]
      aDane[ 'JestDeklaracja' ] := .T.
      aDane[ 'P_10' ] := aDaneZrd[ 'DekV7' ][ 'P_10' ]
      aDane[ 'P_11' ] := aDaneZrd[ 'DekV7' ][ 'P_11' ]
      aDane[ 'P_12' ] := aDaneZrd[ 'DekV7' ][ 'P_12' ]
      aDane[ 'P_13' ] := aDaneZrd[ 'DekV7' ][ 'P_13' ]
      aDane[ 'P_14' ] := aDaneZrd[ 'DekV7' ][ 'P_14' ]
      aDane[ 'P_15' ] := aDaneZrd[ 'DekV7' ][ 'P_15' ]
      aDane[ 'P_16' ] := aDaneZrd[ 'DekV7' ][ 'P_16' ]
      aDane[ 'P_17' ] := aDaneZrd[ 'DekV7' ][ 'P_17' ]
      aDane[ 'P_18' ] := aDaneZrd[ 'DekV7' ][ 'P_18' ]
      aDane[ 'P_19' ] := aDaneZrd[ 'DekV7' ][ 'P_19' ]
      aDane[ 'P_20' ] := aDaneZrd[ 'DekV7' ][ 'P_20' ]
      aDane[ 'P_21' ] := aDaneZrd[ 'DekV7' ][ 'P_21' ]
      aDane[ 'P_22' ] := aDaneZrd[ 'DekV7' ][ 'P_22' ]
      aDane[ 'P_23' ] := aDaneZrd[ 'DekV7' ][ 'P_23' ]
      aDane[ 'P_24' ] := aDaneZrd[ 'DekV7' ][ 'P_24' ]
      aDane[ 'P_25' ] := aDaneZrd[ 'DekV7' ][ 'P_25' ]
      aDane[ 'P_26' ] := aDaneZrd[ 'DekV7' ][ 'P_26' ]
      aDane[ 'P_27' ] := aDaneZrd[ 'DekV7' ][ 'P_27' ]
      aDane[ 'P_28' ] := aDaneZrd[ 'DekV7' ][ 'P_28' ]
      aDane[ 'P_29' ] := aDaneZrd[ 'DekV7' ][ 'P_29' ]
      aDane[ 'P_30' ] := aDaneZrd[ 'DekV7' ][ 'P_30' ]
      aDane[ 'P_31' ] := aDaneZrd[ 'DekV7' ][ 'P_31' ]
      aDane[ 'P_32' ] := aDaneZrd[ 'DekV7' ][ 'P_32' ]
      aDane[ 'P_33' ] := aDaneZrd[ 'DekV7' ][ 'P_33' ]
      aDane[ 'P_34' ] := aDaneZrd[ 'DekV7' ][ 'P_34' ]
      aDane[ 'P_35' ] := aDaneZrd[ 'DekV7' ][ 'P_35' ]
      aDane[ 'P_36' ] := aDaneZrd[ 'DekV7' ][ 'P_36' ]
      aDane[ 'P_37' ] := aDaneZrd[ 'DekV7' ][ 'P_37' ]
      aDane[ 'P_38' ] := aDaneZrd[ 'DekV7' ][ 'P_38' ]
      aDane[ 'P_39' ] := aDaneZrd[ 'DekV7' ][ 'P_39' ]
      aDane[ 'P_40' ] := aDaneZrd[ 'DekV7' ][ 'P_40' ]
      aDane[ 'P_41' ] := aDaneZrd[ 'DekV7' ][ 'P_41' ]
      aDane[ 'P_42' ] := aDaneZrd[ 'DekV7' ][ 'P_42' ]
      aDane[ 'P_43' ] := aDaneZrd[ 'DekV7' ][ 'P_43' ]
      aDane[ 'P_44' ] := aDaneZrd[ 'DekV7' ][ 'P_44' ]
      aDane[ 'P_45' ] := aDaneZrd[ 'DekV7' ][ 'P_45' ]
      aDane[ 'P_46' ] := aDaneZrd[ 'DekV7' ][ 'P_46' ]
      aDane[ 'P_47' ] := aDaneZrd[ 'DekV7' ][ 'P_47' ]
      aDane[ 'P_48' ] := aDaneZrd[ 'DekV7' ][ 'P_48' ]
      aDane[ 'P_49' ] := aDaneZrd[ 'DekV7' ][ 'P_49' ]
      aDane[ 'P_50' ] := aDaneZrd[ 'DekV7' ][ 'P_50' ]
      aDane[ 'P_51' ] := aDaneZrd[ 'DekV7' ][ 'P_51' ]
      aDane[ 'P_52' ] := aDaneZrd[ 'DekV7' ][ 'P_52' ]
      aDane[ 'P_53' ] := aDaneZrd[ 'DekV7' ][ 'P_53' ]
      aDane[ 'P_54' ] := aDaneZrd[ 'DekV7' ][ 'P_54' ]
      aDane[ 'P_540' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_540' ], '1', '0' )
      aDane[ 'P_55' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_55' ], '1', '0' )
      aDane[ 'P_56' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_56' ], '1', '0' )
      aDane[ 'P_560' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_560' ], '1', '0' )
      aDane[ 'P_57' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_57' ], '1', '0' )
      aDane[ 'P_58' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_58' ], '1', '0' )
      aDane[ 'P_59' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_59' ], '1', '0' )
      aDane[ 'P_60' ] := aDaneZrd[ 'DekV7' ][ 'P_60' ]
      aDane[ 'P_61' ] := aDaneZrd[ 'DekV7' ][ 'P_61' ]
      aDane[ 'P_62' ] := aDaneZrd[ 'DekV7' ][ 'P_62' ]
      aDane[ 'P_63' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_63' ], '1', '0' )
      aDane[ 'P_64' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_64' ], '1', '0' )
      aDane[ 'P_65' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_65' ], '1', '0' )
      aDane[ 'P_66' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_66' ], '1', '0' )
      aDane[ 'P_660' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_660' ], '1', '0' )
      aDane[ 'P_67' ] := iif( aDaneZrd[ 'DekV7' ][ 'P_67' ], '1', '0' )
      aDane[ 'P_68' ] := aDaneZrd[ 'DekV7' ][ 'P_68' ]
      aDane[ 'P_69' ] := aDaneZrd[ 'DekV7' ][ 'P_69' ]
      IF aDaneZrd[ 'DekV7' ][ 'Korekta' ] .AND. Len( AllTrim( aDaneZrd[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         aDane[ 'P_ORDZU' ] := AllTrim( aDaneZrd[ 'DekV7' ][ 'ORDZU' ] )
      ELSE
         aDane[ 'P_ORDZU' ] := ''
      ENDIF
   ELSE
      aDane[ 'JestDeklaracja' ] := .F.
   ENDIF

   IF aDaneZrd[ 'Rejestry' ]

      aDane[ 'Sprzedaz' ] := {}
      IF Len( aDaneZrd[ 'sprzedaz' ] ) > 0
         aDane[ 'JestSprzedaz' ] := .T.
         nI := 1
         AEval( aDaneZrd[ 'sprzedaz' ], { | aPoz |
            aPoz[ 'LpSprzedazy' ] := nI
            nI++
            IF hb_HHasKey( aPoz, 'MPP' ) .AND. aPoz[ 'MPP' ]
               aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + ' MPP'
            ENDIF
            IF ! hb_HHasKey( aPoz, 'KorektaPodstawyOpodt' )
               aPoz[ 'KorektaPodstawyOpodt' ] := '0'
            ELSE
               aPoz[ 'KorektaPodstawyOpodt' ] := iif( aPoz[ 'KorektaPodstawyOpodt' ], '1', '0' )
            ENDIF
            aPoz[ 'TerminPlatnosci' ] := date2strxml( xmlWartoscH( aPoz, 'TerminPlatnosci', '' ) )
            aPoz[ 'DataZaplaty' ] := date2strxml( xmlWartoscH( aPoz, 'DataZaplaty', '' ) )
            aPoz[ 'DataWystawienia' ] := date2strxml( aPoz[ 'DataWystawienia' ] )
            aPoz[ 'K_10' ] := HGetDefault( aPoz, 'K_10', 0 )
            aPoz[ 'K_11' ] := HGetDefault( aPoz, 'K_11', 0 )
            aPoz[ 'K_12' ] := HGetDefault( aPoz, 'K_12', 0 )
            aPoz[ 'K_13' ] := HGetDefault( aPoz, 'K_13', 0 )
            aPoz[ 'K_14' ] := HGetDefault( aPoz, 'K_14', 0 )
            aPoz[ 'K_15' ] := HGetDefault( aPoz, 'K_15', 0 )
            aPoz[ 'K_16' ] := HGetDefault( aPoz, 'K_16', 0 )
            aPoz[ 'K_17' ] := HGetDefault( aPoz, 'K_17', 0 )
            aPoz[ 'K_18' ] := HGetDefault( aPoz, 'K_18', 0 )
            aPoz[ 'K_19' ] := HGetDefault( aPoz, 'K_19', 0 )
            aPoz[ 'K_20' ] := HGetDefault( aPoz, 'K_20', 0 )
            aPoz[ 'K_21' ] := HGetDefault( aPoz, 'K_21', 0 )
            aPoz[ 'K_22' ] := HGetDefault( aPoz, 'K_22', 0 )
            aPoz[ 'K_23' ] := HGetDefault( aPoz, 'K_23', 0 )
            aPoz[ 'K_24' ] := HGetDefault( aPoz, 'K_24', 0 )
            aPoz[ 'K_25' ] := HGetDefault( aPoz, 'K_25', 0 )
            aPoz[ 'K_26' ] := HGetDefault( aPoz, 'K_26', 0 )
            aPoz[ 'K_27' ] := HGetDefault( aPoz, 'K_27', 0 )
            aPoz[ 'K_28' ] := HGetDefault( aPoz, 'K_28', 0 )
            aPoz[ 'K_29' ] := HGetDefault( aPoz, 'K_29', 0 )
            aPoz[ 'K_30' ] := HGetDefault( aPoz, 'K_30', 0 )
            aPoz[ 'K_31' ] := HGetDefault( aPoz, 'K_31', 0 )
            aPoz[ 'K_32' ] := HGetDefault( aPoz, 'K_32V', 0 )
            aPoz[ 'K_33' ] := HGetDefault( aPoz, 'K_36', 0 )
            aPoz[ 'K_34' ] := HGetDefault( aPoz, 'K_37', 0 )
            aPoz[ 'K_35' ] := HGetDefault( aPoz, 'K_38', 0 )
            aPoz[ 'K_36' ] := HGetDefault( aPoz, 'K_39', 0 )
            aPoz[ 'SprzedazVAT_Marza' ] := HGetDefault( aPoz, 'SprzedazVAT_Marza', 0 )
            IF hb_HHasKey( aPoz, 'DataSprzedazy' )
               aPoz[ 'DataSprzedazy' ] := date2strxml( aPoz[ 'DataSprzedazy' ] )
            ELSE
               aPoz[ 'DataSprzedazy' ] := ""
            ENDIF
            IF ( hb_HHasKey( aPoz, 'TypDokumentu' ) .AND. AllTrim( aPoz[ 'TypDokumentu' ] ) == "FP" ) ;
               .OR. ( At( "MR_UZ", aPoz[ 'Procedura' ] ) > 0 .AND. ( aPoz[ 'K_10' ] < 0 .OR. ;
               aPoz[ 'K_11' ] < 0 .OR. aPoz[ 'K_12' ] < 0 .OR. aPoz[ 'K_13' ] < 0 .OR. ;
               aPoz[ 'K_14' ] < 0 .OR. aPoz[ 'K_15' ] < 0 .OR. aPoz[ 'K_17' ] < 0 .OR. ;
               aPoz[ 'K_19' ] < 0 .OR. aPoz[ 'K_21' ] < 0 .OR. aPoz[ 'K_22' ] < 0 ) )

               aPoz[ 'Sumuj' ] := 0
            ELSE
               aPoz[ 'Sumuj' ] := 1
            ENDIF
            AAdd( aDane[ 'Sprzedaz' ], aPoz )
         } )
      ELSE
         aDane[ 'JestSprzedaz' ] := .F.
      ENDIF

      aDane[ 'Zakup' ] := {}
      IF Len( aDaneZrd[ 'zakup' ] ) > 0
         aDane[ 'JestZakup' ] := .T.
         nI := 1
         AEval( aDaneZrd[ 'zakup' ], { | aPoz |
            aPoz[ 'LpZakupu' ] := nI
            nI++
            aPoz[ 'DataZakupu' ] := date2strxml( aPoz[ 'DataZakupu' ] )
            aPoz[ 'DokumentZakupu' ] := HGetDefault( aPoz, 'DokumentZakupu', '' )
            //aPoz[ 'MPP' ] := iif( aPoz[ 'MPP' ], '1', '0' )
            aPoz[ 'IMP' ] := iif( aPoz[ 'IMP' ], '1', '0' )
            aPoz[ 'K_40' ] := HGetDefault( aPoz, 'K_43', 0 )
            aPoz[ 'K_41' ] := HGetDefault( aPoz, 'K_44', 0 )
            aPoz[ 'K_42' ] := HGetDefault( aPoz, 'K_45', 0 )
            aPoz[ 'K_43' ] := HGetDefault( aPoz, 'K_46', 0 )
            aPoz[ 'K_44' ] := HGetDefault( aPoz, 'K_47', 0 )
            aPoz[ 'K_45' ] := HGetDefault( aPoz, 'K_48', 0 )
            aPoz[ 'K_46' ] := HGetDefault( aPoz, 'K_49', 0 )
            aPoz[ 'K_47' ] := HGetDefault( aPoz, 'K_50', 0 )
            aPoz[ 'ZakupVAT_Marza' ] := HGetDefault( aPoz, 'ZakupVAT_Marza', 0 )
            IF hb_HHasKey( aPoz, 'DataWplywu' )
               aPoz[ 'DataWplywu' ] := date2strxml( aPoz[ 'DataWplywu' ] )
            ELSE
               aPoz[ 'DataWplywu' ] := ""
            ENDIF
            AAdd( aDane[ 'Zakup' ], aPoz )
         } )
      ELSE
         aDane[ 'JestZakup' ] := .F.
      ENDIF
   ELSE
      aDane[ 'JestSprzedaz' ] := .F.
      aDane[ 'JestZakup' ] := .F.
   ENDIF

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneDek_VATINFO( aDaneZrd )

   LOCAL aDane := hb_Hash()

   aDane['P_1'] := P4
   aDane['P_2'] := ''
   aDane['P_4'] := p5a
   aDane['P_5'] := p5b
   aDane['P_6'] := iif( AllTrim(p6a) != '', KodUS2Nazwa( AllTrim(p6a) ), '' )
   aDane['P_7_1'] := iif( kordek == 'K', '0', '1' )
   aDane['P_7_2'] := iif( kordek == 'K', '1', '0' )
   aDane['P_8_1'] := iif( spolka_, '1', '0' )
   aDane['P_8_2'] := iif( spolka_, '0', '1' )
   aDane['P_9'] := P8 + ',     ' + P11
   aDane[ 'P_10' ] := aDaneZrd[ 'P_10' ]
   aDane[ 'P_11' ] := aDaneZrd[ 'P_11' ]
   aDane[ 'P_12' ] := aDaneZrd[ 'P_12' ]
   aDane[ 'P_13' ] := aDaneZrd[ 'P_13' ]
   aDane[ 'P_14' ] := aDaneZrd[ 'P_14' ]
   aDane[ 'P_15' ] := aDaneZrd[ 'P_15' ]
   aDane[ 'P_16' ] := aDaneZrd[ 'P_16' ]
   aDane[ 'P_17' ] := aDaneZrd[ 'P_17' ]
   aDane[ 'P_18' ] := aDaneZrd[ 'P_18' ]
   aDane[ 'P_19' ] := aDaneZrd[ 'P_19' ]
   aDane[ 'P_20' ] := aDaneZrd[ 'P_20' ]
   aDane[ 'P_21' ] := aDaneZrd[ 'P_21' ]
   aDane[ 'P_22' ] := aDaneZrd[ 'P_22' ]
   aDane[ 'P_23' ] := aDaneZrd[ 'P_23' ]
   aDane[ 'P_24' ] := aDaneZrd[ 'P_24' ]
   aDane[ 'P_25' ] := aDaneZrd[ 'P_25' ]
   aDane[ 'P_26' ] := aDaneZrd[ 'P_26' ]
   aDane[ 'P_27' ] := aDaneZrd[ 'P_27' ]
   aDane[ 'P_28' ] := aDaneZrd[ 'P_28' ]
   aDane[ 'P_29' ] := aDaneZrd[ 'P_29' ]
   aDane[ 'P_30' ] := aDaneZrd[ 'P_30' ]
   aDane[ 'P_31' ] := aDaneZrd[ 'P_31' ]
   aDane[ 'P_32' ] := aDaneZrd[ 'P_32' ]
   aDane[ 'P_33' ] := aDaneZrd[ 'P_33' ]
   aDane[ 'P_34' ] := aDaneZrd[ 'P_34' ]
   aDane[ 'P_35' ] := aDaneZrd[ 'P_35' ]
   aDane[ 'P_36' ] := aDaneZrd[ 'P_36' ]
   aDane[ 'P_37' ] := aDaneZrd[ 'P_37' ]
   aDane[ 'P_38' ] := aDaneZrd[ 'P_38' ]
   aDane[ 'P_39' ] := aDaneZrd[ 'P_39' ]
   aDane[ 'P_40' ] := aDaneZrd[ 'P_40' ]
   aDane[ 'P_41' ] := aDaneZrd[ 'P_41' ]
   aDane[ 'P_42' ] := aDaneZrd[ 'P_42' ]
   aDane[ 'P_43' ] := aDaneZrd[ 'P_43' ]
   aDane[ 'P_44' ] := aDaneZrd[ 'P_44' ]
   aDane[ 'P_45' ] := aDaneZrd[ 'P_45' ]
   aDane[ 'P_46' ] := aDaneZrd[ 'P_46' ]
   aDane[ 'P_47' ] := aDaneZrd[ 'P_47' ]
   aDane[ 'P_48' ] := aDaneZrd[ 'P_48' ]
   aDane[ 'P_49' ] := aDaneZrd[ 'P_49' ]
   aDane[ 'P_50' ] := aDaneZrd[ 'P_50' ]
   aDane[ 'P_51' ] := aDaneZrd[ 'P_51' ]
   aDane[ 'P_52' ] := aDaneZrd[ 'P_52' ]
   aDane[ 'P_53' ] := aDaneZrd[ 'P_53' ]
   aDane[ 'P_54' ] := aDaneZrd[ 'P_54' ]
   aDane[ 'P_540' ] := iif( aDaneZrd[ 'P_540' ], '1', '0' )
   aDane[ 'P_55' ] := iif( aDaneZrd[ 'P_55' ], '1', '0' )
   aDane[ 'P_56' ] := iif( aDaneZrd[ 'P_56' ], '1', '0' )
   aDane[ 'P_560' ] := iif( aDaneZrd[ 'P_560' ], '1', '0' )
   aDane[ 'P_57' ] := iif( aDaneZrd[ 'P_57' ], '1', '0' )
   aDane[ 'P_58' ] := iif( aDaneZrd[ 'P_58' ], '1', '0' )
   aDane[ 'P_59' ] := iif( aDaneZrd[ 'P_59' ], '1', '0' )
   aDane[ 'P_60' ] := aDaneZrd[ 'P_60' ]
   aDane[ 'P_61' ] := aDaneZrd[ 'P_61' ]
   aDane[ 'P_62' ] := aDaneZrd[ 'P_62' ]
   aDane[ 'P_63' ] := iif( aDaneZrd[ 'P_63' ], '1', '0' )
   aDane[ 'P_64' ] := iif( aDaneZrd[ 'P_64' ], '1', '0' )
   aDane[ 'P_65' ] := iif( aDaneZrd[ 'P_65' ], '1', '0' )
   aDane[ 'P_66' ] := iif( aDaneZrd[ 'P_66' ], '1', '0' )
   aDane[ 'P_660' ] := iif( aDaneZrd[ 'P_660' ], '1', '0' )
   aDane[ 'P_67' ] := iif( aDaneZrd[ 'P_67' ], '1', '0' )
   aDane[ 'P_68' ] := aDaneZrd[ 'P_68' ]
   aDane[ 'P_69' ] := aDaneZrd[ 'P_69' ]

   RETURN aDane

/*----------------------------------------------------------------------*/

