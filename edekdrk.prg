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

#require "xhb"
#include "hbxml.ch"

#include "hbfr.ch"

FUNCTION xmlWartoscH(hDane, cKlucz, cDomyslny)
   LOCAL cRes := ''
   IF hb_HHasKey(hDane, cKlucz)
      cRes := hDane[cKlucz]
   ELSE
      IF cDomyslny != NIL
         cRes := cDomyslny
      ENDIF
   ENDIF
   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION xml2date( cData, xDef )
   IF AllTrim( cData ) == ''
      IF HB_ISNIL( xDef )
         RETURN Date()
      ELSE
         RETURN xDef
      ENDIF
   ENDIF
   RETURN hb_SToD( StrTran( cData, '-', '' ) )

/*----------------------------------------------------------------------*/

PROCEDURE Drukuj_DeklarXML( cPlikXML, cTypDeklaracji, cNrRef )

   LOCAL oDoc, hDane := hb_Hash(), oRap, cPlikRap := ''
   LOCAL xRaport, nMenu, cKolor, cOrdzuFrf := 'frf\ordzu_w2.frf'
   LOCAL aRaporty := {}, aFRObj := {}

   IF !File(cPlikXML)
      RETURN
   ENDIF

   oDoc := TXMLDocument():New(cPlikXML)
   IF oDoc:nError != HBXML_ERROR_NONE
      RETURN
   ENDIF

   SWITCH cTypDeklaracji
   CASE 'PIT4R-6'
      hDane := DaneXML_PIT4Rw6( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w6.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT4R-8'
      hDane := DaneXML_PIT4Rw8( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w8.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT4R-9'
      hDane := DaneXML_PIT4Rw9( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w9.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT4R-10'
      hDane := DaneXML_PIT4Rw10( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w10.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT4R-11'
      hDane := DaneXML_PIT4Rw11( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w11.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT4R-12'
      hDane := DaneXML_PIT4Rw12( oDoc, cNrRef )
      cPlikRap := 'frf\pit4r_w12.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-6'
      hDane := DaneXML_PIT8ARw6( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w6.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-7'
      hDane := DaneXML_PIT8ARw7( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w7.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-8'
      hDane := DaneXML_PIT8ARw8( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w8.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-9'
      hDane := DaneXML_PIT8ARw9( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w9.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-10'
      hDane := DaneXML_PIT8ARw10( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w10.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-11'
      hDane := DaneXML_PIT8ARw11( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w11.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT8AR-12'
      hDane := DaneXML_PIT8ARw12( oDoc, cNrRef )
      cPlikRap := 'frf\pit8ar_w12.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-22'
      hDane := DaneXML_PIT11w22( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w22.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-23'
      hDane := DaneXML_PIT11w23( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w23.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-24'
      hDane := DaneXML_PIT11w24( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w24.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-25'
      hDane := DaneXML_PIT11w25( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w25.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-26'
      hDane := DaneXML_PIT11w25( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w26.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-27'
      hDane := DaneXML_PIT11w27( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w27.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'PIT11-29'
      hDane := DaneXML_PIT11w29( oDoc, cNrRef )
      cPlikRap := 'frf\pit11_w29.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-15'
      hDane := DaneXML_VAT7w15( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w15.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-16'
      hDane := DaneXML_VAT7w16( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w16.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-17'
      hDane := DaneXML_VAT7w17( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w17.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-18'
      hDane := DaneXML_VAT7w18( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w18.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-19'
      hDane := DaneXML_VAT7w19( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w19.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7-20'
      hDane := DaneXML_VAT7w20( oDoc, cNrRef )
      cPlikRap := 'frf\vat7_w20.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-9'
      hDane := DaneXML_VAT7Kw9( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w9.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-10'
      hDane := DaneXML_VAT7Kw10( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w10.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-11'
      hDane := DaneXML_VAT7Kw11( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w11.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-12'
      hDane := DaneXML_VAT7Kw12( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w12.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-13'
      hDane := DaneXML_VAT7Kw13( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w13.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7K-14'
      hDane := DaneXML_VAT7Kw14( oDoc, cNrRef )
      cPlikRap := 'frf\vat7k_w14.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7D-6'
      hDane := DaneXML_VAT7Dw6( oDoc, cNrRef )
      cPlikRap := 'frf\vat7d_w6.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7D-7'
      hDane := DaneXML_VAT7Dw7( oDoc, cNrRef )
      cPlikRap := 'frf\vat7d_w7.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT7D-8'
      hDane := DaneXML_VAT7Dw8( oDoc, cNrRef )
      cPlikRap := 'frf\vat7d_w8.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT8-11'
      hDane := DaneXML_VAT8w11( oDoc, cNrRef )
      cPlikRap := 'frf\vat8_w11.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT9M-10'
      hDane := DaneXML_VAT9Mw10( oDoc, cNrRef )
      cPlikRap := 'frf\vat9m_w10.frf'
      cOrdzuFrf := 'frf\ordzu_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VATUE-3'
      hDane := DaneXML_VATUEw3( oDoc, cNrRef )
      cPlikRap := 'frf\vatue_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VATUE-4'
      hDane := DaneXML_VATUEw4( oDoc, cNrRef )
      cPlikRap := 'frf\vatue_w4.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VATUEK-4'
      hDane := DaneXML_VATUEKw4( oDoc, cNrRef )
      cPlikRap := 'frf\vatuek_w4.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VATUE-5'
      hDane := DaneXML_VATUEw5( oDoc, cNrRef )
      cPlikRap := 'frf\vatue_w5.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VATUEK-5'
      hDane := DaneXML_VATUEKw5( oDoc, cNrRef )
      cPlikRap := 'frf\vatuek_w5.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VIUDO-1'
      hDane := DaneXML_VIUDOw1( oDoc, cNrRef )
      cPlikRap := 'frf\viudo_w1.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT27K-1'
   CASE 'VAT27-1'
      hDane := DaneXML_VAT27w1( oDoc, cNrRef )
      cPlikRap := 'frf\vat27_w1.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'VAT27-2'
      hDane := DaneXML_VAT27w2( oDoc, cNrRef )
      cPlikRap := 'frf\vat27_w2.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'IFT1-13'
   CASE 'IFT1R-13'
      hDane := DaneXML_IFT1w13( oDoc, cNrRef )
      cPlikRap := 'frf\ift1_w13.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'IFT1-15'
   CASE 'IFT1R-15'
      hDane := DaneXML_IFT1w15( oDoc, cNrRef )
      cPlikRap := 'frf\ift1_w15.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'IFT1-16'
   CASE 'IFT1R-16'
      hDane := DaneXML_IFT1w16( oDoc, cNrRef )
      cPlikRap := 'frf\ift1_w16.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'IFT2-9'
   CASE 'IFT2R-9'
      hDane := DaneXML_IFT2w9( oDoc, cNrRef )
      cPlikRap := 'frf\ift2_w9.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'IFT2-10'
   CASE 'IFT2R-10'
      hDane := DaneXML_IFT2w9( oDoc, cNrRef )
      cPlikRap := 'frf\ift2_w10.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'UPO'
      hDane := DaneXML_UPO( oDoc )
      cPlikRap := 'frf\upo_w6.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKVAT-2'
      hDane := DaneXML_JPKVATw2( oDoc, cNrRef )
      cPlikRap := 'frf\jpkvat_w2.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKVAT-3'
      hDane := DaneXML_JPKVATw3( oDoc, cNrRef )
      cPlikRap := 'frf\jpkvat_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKKPR-2'
      hDane := DaneXML_JPKPKPIRw2( oDoc, cNrRef )
      cPlikRap := 'frf\jpkpkpir_w2.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKEWP-1'
      hDane := DaneXML_JPKEWPw1( oDoc, cNrRef )
      cPlikRap := 'frf\jpkewp_w1.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKEWP-2'
      hDane := DaneXML_JPKEWPw2( oDoc, cNrRef )
      cPlikRap := 'frf\jpkewp_w2.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKEWP-3'
      hDane := DaneXML_JPKEWPw3( oDoc, cNrRef )
      cPlikRap := 'frf\jpkewp_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKFA-3'
      hDane := DaneXML_JPKFAw3( oDoc, cNrRef )
      cPlikRap := 'frf\jpkfa_w3.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKFA-4'
      hDane := DaneXML_JPKFAw4( oDoc, cNrRef )
      cPlikRap := 'frf\jpkfa_w4.frf'
      AAdd( aRaporty, { hDane, cPlikRap } )
      EXIT
   CASE 'JPKV7M-1'
   CASE 'JPKV7K-1'
      hDane := DaneXML_JPKV7w1( oDoc, cNrRef )
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
      hDane := DaneXML_JPKV7w2( oDoc, cNrRef )
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
      Komunikat('Brak szablonu wydruku dla tej deklaracji - ' + cTypDeklaracji )
      RETURN
   ENDSWITCH

   IF hb_HHasKey( hDane, 'ORDZU' )
      AAdd( aRaporty, { hDane[ 'ORDZU' ], cOrdzuFrf } )
   ENDIF

   IF hb_HHasKey( hDane, 'VATZZ' ) .AND. hDane[ 'VATZZ' ][ 'rob' ]
      cPlikRap := 'frf\vatzz_w5.frf'
      AAdd( aRaporty, { hDane[ 'VATZZ' ], cPlikRap } )
   ENDIF

   IF hb_HHasKey( hDane, 'VATZD' ) .AND. hDane[ 'VATZD' ][ 'rob' ]
      cPlikRap := 'frf\vatzd_w1.frf'
      AAdd( aRaporty, { hDane[ 'VATZD' ], cPlikRap } )
   ENDIF

   AEval( aRaporty, { | aPoz |
      oRap := TFreeReport():New()
      oRap:LoadFromFile( aPoz[ 2 ] )
      IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
         oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
      ENDIF
      RaportUstawDane( oRap, aPoz[ 1 ] )
      AAdd( aFRObj, oRap )
      } )

   IF Len( aFRObj ) > 1
      oRap := TFreeReport():New( .T. )
      AEval( aFRObj, { | oFRO | oRap:AddReport( oFRO ) } )
      AAdd( aFRObj, oRap )
      xRaport := aFRObj
   ELSE
      xRaport := oRap
   ENDIF

   IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
      oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
   ENDIF

   oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim( Str( DodajRaportDoListy( xRaport ) ) ) + ')'
   oRap:ModalPreview := .F.
   oRap:DoublePass := .T.
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
   @ 24, 0
   SetColor(cKolor)

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekXmlNaglowek(oDoc)
   LOCAL oNode, hRes := hb_Hash(), oIt, oEl
   oNode := oDoc:FindFirst('Naglowek')
   IF oNode != NIL
      oIt := TXMLIterator():New(oNode)
      DO WHILE .T.
         oEl := oIt:Next()
         IF oEl == NIL
            EXIT
         ENDIF
         hRes[oEl:cName] := sxml2str(oEl:cData)
         hb_HEval( oEl:aAttributes, { | cKey, cValue | hRes[ oEl:cName + ':' + cKey ] := cValue } )
      ENDDO
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlPodmiot1(oDoc)
   LOCAL oNode, hRes := hb_Hash(), oNodeOs, oIt, oEl
   oNode := oDoc:FindFirst('Podmiot1')
   IF oNode != NIL
      oIt := TXMLIteratorRegex():New(oNode)
      oNodeOs := oIt:Find('(([\w]*:)OsobaFizyczna|(^OsobaFizyczna))')
      IF oNodeOs == NIL
         oNodeOs := oIt:Find('(([\w]*:)OsobaNiefizyczna|(^OsobaNiefizyczna))')
         IF oNodeOs != NIL
            hRes['OsobaFizyczna'] := .F.
            hRes['lOsobaFizyczna' ] := .F.
         ENDIF
      ELSE
         hRes['OsobaFizyczna'] := .T.
         hRes['lOsobaFizyczna' ] := .T.
      ENDIF
      IF oNodeOs != NIL
         oIt := TXMLIterator():New( oNodeOs )
         DO WHILE .T.
            oEl := oIt:Next()
            IF oEl == NIL
               EXIT
            ENDIF
            hRes[oEl:cName] := sxml2str( oEl:cData )
         ENDDO
      ENDIF
      oIt := TXMLIterator():New( oNode )
      oNodeOs := oIt:Find( 'etd:AdresPol' )
      IF oNodeOs != NIL
         oIt := TXMLIterator():New( oNodeOs )
         DO WHILE .T.
            oEl := oIt:Next()
            IF oEl == NIL
               EXIT
            ENDIF
            hRes[oEl:cName] := sxml2str( oEl:cData )
         ENDDO
      ENDIF
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlPodmiot2(oDoc)
   LOCAL oNode, hRes := hb_Hash(), oNodeOs, oIt, oEl
   oNode := oDoc:FindFirst('Podmiot2')
   IF oNode != NIL
      oIt := TXMLIterator():New(oNode)
      oNodeOs := oIt:Find('OsobaFizyczna')
      IF oNodeOs == NIL
         oNodeOs := oIt:Find('OsobaNiefizyczna')
         IF oNodeOs != NIL
            hRes['OsobaFizyczna'] := .F.
         ELSE
            oNodeOs := oIt:Find( 'OsobaFizZagr' )
         ENDIF
      ELSE
         hRes['OsobaFizyczna'] := .T.
      ENDIF
      IF oNodeOs != NIL
         oIt := TXMLIterator():New( oNodeOs )
         DO WHILE .T.
            oEl := oIt:Next()
            IF oEl == NIL
               EXIT
            ENDIF
            hRes[oEl:cName] := sxml2str( oEl:cData )
         ENDDO
      ENDIF
      oIT := TXMLIterator():New(oNode)
      oNodeOs := oIt:Find('AdresZamieszkania')
      IF oNodeOs != NIL
         oIt := TXMLIterator():New(oNodeOs)
         DO WHILE .T.
            oEl := oIT:Next()
            IF oEl == NIL
               EXIT
            ENDIF
            hRes[oEl:cName] := sxml2str( oEl:cData )
         ENDDO
      ENDIF
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlGrupa(oDoc, cNazwaWezla)
   LOCAL hRes := hb_Hash(), oNode, oIt, oEl
   oNode := oDoc:FindFirst(cNazwaWezla)
   IF oNode != NIL
      oIt := TXMLIterator():New(oNode)
      DO WHILE .T.
         oEl := oIt:Next()
         IF oEl == NIL
            EXIT
         ENDIF
         hRes[oEl:cName] := sxml2str( oEl:cData )
      ENDDO
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlGrupaTab(oDoc, cNazwaWezla, cNazwaEl)
   LOCAL aRes := {}, hPoz := hb_Hash(), oNode, oIt, oEl, oEl2, oIt2
   oNode := oDoc:FindFirst(cNazwaWezla)
   IF oNode != NIL
      oIt := TXMLIterator():New(oNode)
      DO WHILE .T.
         oEl := oIt:Next()
         IF oEl == NIL
            EXIT
         ENDIF
         IF oEl:cName == cNazwaEl
            oIt2 := TXMLIterator():New( oEl )
            hPoz := hb_Hash()
            DO WHILE .T.
               oEl2 := oIt2:Next()
               IF oEl2 == NIL
                  EXIT
               ENDIF
               hPoz[oEl2:cName] := sxml2str( oEl2:cData )
            ENDDO
            AAdd(aRes, hPoz)
         ENDIF
      ENDDO
   ENDIF
   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlORDZU(oDoc)
   LOCAL hRes := '', oNode
   oNode := oDoc:FindFirst('zzu:P_13')
   IF oNode != NIL
      hRes := sxml2str(oNode:cData)
   ENDIF
   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlPobierzWartosc( oDoc, cNazwa, xDomyslnie )

   LOCAL oNode, xRes

   oNode := oDoc:FindFirst( cNazwa )
   IF oNode != NIL
      xRes := oNode:cData
   ELSE
      xRes := xDomyslie
   ENDIF

   RETURN xRes

/*----------------------------------------------------------------------*/


FUNCTION edekXmlVATZZ5( oDoc )

   LOCAL aRes := hb_Hash( 'P_8', 0, 'P_9', 0, 'P_10', '' )
   LOCAL xWar

   IF ! Empty( xWar := edekXmlPobierzWartosc( oDoc, 'vzz:P_8' ) )
      aRes[ 'P_8' ] := Val( xWar )
   ENDIF

   IF ! Empty( xWar := edekXmlPobierzWartosc( oDoc, 'vzz:P_9' ) )
      aRes[ 'P_9' ] := Val( xWar )
   ENDIF

   IF ! Empty( xWar := sxml2str( edekXmlPobierzWartosc( oDoc, 'vzz:P_10' ) ) )
      aRes[ 'P_10' ] := xWar
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION edekXmlVATZD1( oDoc )

   LOCAL aRes := hb_Hash( 'P_10', 0, 'P_11', 0, 'PB', {} )
   LOCAL xWar

   IF ! Empty( xWar := edekXmlPobierzWartosc( oDoc, 'vzd:P_10' ) )
      aRes[ 'P_10' ] := Val( xWar )
   ENDIF

   IF ! Empty( xWar := edekXmlPobierzWartosc( oDoc, 'vzd:P_11' ) )
      aRes[ 'P_11' ] := Val( xWar )
   ENDIF

   IF ! Empty( xWar := edekXmlGrupaTab( oDoc, 'vzd:PozycjeSzczegolowe', 'vzd:P_B' ) )
      AEval( xWar, { | aVal |
         LOCAL xV := hb_Hash()
         xV[ 'P_BB' ] := aVal[ 'vzd:P_BB' ]
         xV[ 'P_BC' ] := aVal[ 'vzd:P_BC' ]
         xV[ 'P_BD1' ] := aVal[ 'vzd:P_BD1' ]
         xV[ 'P_BD2' ] := aVal[ 'vzd:P_BD2' ]
         xV[ 'P_BE' ] := aVal[ 'vzd:P_BE' ]
         xV[ 'P_BF' ] := aVal[ 'vzd:P_BF' ]
         xV[ 'P_BG' ] := aVal[ 'vzd:P_BG' ]
         AAdd( aRes[ 'PB' ], xV )
      } )
   ENDIF

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_UPO(oDoc)
   LOCAL oObj, oIt, oEl
   LOCAL oRep, hDane := hb_Hash()

   hDane['NazwaPodmiotuPrzyjmujacego'] := ''
   hDane['NumerReferencyjny'] := ''
   hDane['DataWplyniecia'] := ''
   hDane['SkrotDokumentu'] := ''
   hDane['SkrotZlozonejStruktury'] := ''
   hDane['NazwaStrukturyLogicznej'] := ''
   hDane['Podmiot1Typ'] := ''
   hDane['Podmiot1Nr'] := ''
   hDane['Podmiot2Typ'] := ''
   hDane['Podmiot2Nr'] := ''
   hDane['KodUrzedu'] := ''
   hDane['NazwaUrzedu'] := ''
   hDane['StempelCzasu'] := ''
   hDane['UPOSigningTime'] := ''

   oObj := oDoc:findfirst('Potwierdzenie')
   IF oObj == NIL
      RETURN
   ENDIF
   oIt := TXMLIterator():New(oObj)
   DO WHILE .T.
      oEl := oIt:Next()
      IF oEl == NIL
         EXIT
      ENDIF
      IF hb_HHasKey(hDane, oEl:cName)
         hDane[oEl:cName] := oEl:cData
      ELSE
         SWITCH oEl:cName
         CASE 'NIP1'
            hDane['Podmiot1Typ'] := 'NIP'
            hDane['Podmiot1Nr'] := oEl:cData
            EXIT
         CASE 'PESEL1'
            hDane['Podmiot1Typ'] := 'PESEL'
            hDane['Podmiot1Nr'] := oEl:cData
            EXIT
         CASE 'NIP2'
            hDane['Podmiot2Typ'] := 'NIP'
            hDane['Podmiot2Nr'] := oEl:cData
            EXIT
         CASE 'PESEL2'
            hDane['Podmiot2Typ'] := 'PESEL'
            hDane['Podmiot2Nr'] := oEl:cData
            EXIT
         ENDSWITCH
      ENDIF
   ENDDO
   hDane['NazwaUrzedu'] := KodUS2Nazwa(hDane['KodUrzedu'])
   oObj := oDoc:FindFirst('xades:SigningTime')
   IF oObj != NIL
      hDane['UPOSigningTime'] := oObj:cData
   ENDIF
   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw6(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw8(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw9(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_170'] := xmlWartoscH( hPozycje, 'P_170', '' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw10(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_158'] := xmlWartoscH( hPozycje, 'P_158', '' )
   hDane['P_159'] := xmlWartoscH( hPozycje, 'P_159', '0' )
   hDane['P_160'] := xmlWartoscH( hPozycje, 'P_160', '0' )
   hDane['P_161'] := xmlWartoscH( hPozycje, 'P_161', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw11(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_158'] := xmlWartoscH( hPozycje, 'P_158', '' )
   hDane['P_159'] := xmlWartoscH( hPozycje, 'P_159', '0' )
   hDane['P_160'] := xmlWartoscH( hPozycje, 'P_160', '0' )
   hDane['P_161'] := xmlWartoscH( hPozycje, 'P_161', '0' )
   hDane['P_162'] := xmlWartoscH( hPozycje, 'P_162', '0' )
   hDane['P_163'] := xmlWartoscH( hPozycje, 'P_163', '0' )
   hDane['P_164'] := xmlWartoscH( hPozycje, 'P_164', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT4Rw12(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_158'] := xmlWartoscH( hPozycje, 'P_158', '' )
   hDane['P_159'] := xmlWartoscH( hPozycje, 'P_159', '0' )
   hDane['P_160'] := xmlWartoscH( hPozycje, 'P_160', '0' )
   hDane['P_161'] := xmlWartoscH( hPozycje, 'P_161', '0' )
   hDane['P_162'] := xmlWartoscH( hPozycje, 'P_162', '0' )
   hDane['P_163'] := xmlWartoscH( hPozycje, 'P_163', '0' )
   hDane['P_164'] := xmlWartoscH( hPozycje, 'P_164', '0' )
   hDane['P_165'] := xmlWartoscH( hPozycje, 'P_165', '0' )
   hDane['P_166'] := xmlWartoscH( hPozycje, 'P_166', '0' )
   hDane['P_167'] := xmlWartoscH( hPozycje, 'P_167', '0' )
   hDane['P_168'] := xmlWartoscH( hPozycje, 'P_168', '0' )
   hDane['P_169'] := xmlWartoscH( hPozycje, 'P_169', '0' )
   hDane['P_170'] := xmlWartoscH( hPozycje, 'P_170', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := ''
      hDane['ORDZU']['ORDZU_2_N'] := ''
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := ''
      hDane['ORDZU']['ORDZU_10'] := ''
      hDane['ORDZU']['ORDZU_11'] := ''
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw6(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw7(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw8(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := '0'
   hDane['P_7_2'] := '0'
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )
   hDane['P_357'] := sxml2num( xmlWartoscH( hPozycje, 'P_357' ) )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw9(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := '0'
   hDane['P_7_2'] := '0'
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )
   hDane['P_357'] := sxml2num( xmlWartoscH( hPozycje, 'P_357' ) )
   hDane['P_358'] := sxml2num( xmlWartoscH( hPozycje, 'P_358' ) )
   hDane['P_359'] := sxml2num( xmlWartoscH( hPozycje, 'P_359' ) )
   hDane['P_360'] := sxml2num( xmlWartoscH( hPozycje, 'P_360' ) )
   hDane['P_361'] := sxml2num( xmlWartoscH( hPozycje, 'P_361' ) )
   hDane['P_362'] := sxml2num( xmlWartoscH( hPozycje, 'P_362' ) )
   hDane['P_363'] := sxml2num( xmlWartoscH( hPozycje, 'P_363' ) )
   hDane['P_364'] := sxml2num( xmlWartoscH( hPozycje, 'P_364' ) )
   hDane['P_365'] := sxml2num( xmlWartoscH( hPozycje, 'P_365' ) )
   hDane['P_366'] := sxml2num( xmlWartoscH( hPozycje, 'P_366' ) )
   hDane['P_367'] := sxml2num( xmlWartoscH( hPozycje, 'P_367' ) )
   hDane['P_368'] := sxml2num( xmlWartoscH( hPozycje, 'P_368' ) )
   hDane['P_369'] := sxml2num( xmlWartoscH( hPozycje, 'P_369' ) )
   hDane['P_370'] := sxml2num( xmlWartoscH( hPozycje, 'P_370' ) )
   hDane['P_371'] := sxml2num( xmlWartoscH( hPozycje, 'P_371' ) )
   hDane['P_372'] := sxml2num( xmlWartoscH( hPozycje, 'P_372' ) )
   hDane['P_373'] := sxml2num( xmlWartoscH( hPozycje, 'P_373' ) )
   hDane['P_374'] := sxml2num( xmlWartoscH( hPozycje, 'P_374' ) )
   hDane['P_375'] := sxml2num( xmlWartoscH( hPozycje, 'P_375' ) )
   hDane['P_376'] := sxml2num( xmlWartoscH( hPozycje, 'P_376' ) )
   hDane['P_377'] := sxml2num( xmlWartoscH( hPozycje, 'P_377' ) )
   hDane['P_378'] := sxml2num( xmlWartoscH( hPozycje, 'P_378' ) )
   hDane['P_379'] := sxml2num( xmlWartoscH( hPozycje, 'P_379' ) )
   hDane['P_380'] := sxml2num( xmlWartoscH( hPozycje, 'P_380' ) )
   hDane['P_381'] := sxml2num( xmlWartoscH( hPozycje, 'P_381' ) )
   hDane['P_382'] := sxml2num( xmlWartoscH( hPozycje, 'P_382' ) )
   hDane['P_383'] := sxml2num( xmlWartoscH( hPozycje, 'P_383' ) )
   hDane['P_384'] := sxml2num( xmlWartoscH( hPozycje, 'P_384' ) )
   hDane['P_385'] := sxml2num( xmlWartoscH( hPozycje, 'P_385' ) )
   hDane['P_386'] := sxml2num( xmlWartoscH( hPozycje, 'P_386' ) )
   hDane['P_387'] := sxml2num( xmlWartoscH( hPozycje, 'P_387' ) )
   hDane['P_388'] := sxml2num( xmlWartoscH( hPozycje, 'P_388' ) )
   hDane['P_389'] := sxml2num( xmlWartoscH( hPozycje, 'P_389' ) )
   hDane['P_390'] := sxml2num( xmlWartoscH( hPozycje, 'P_390' ) )
   hDane['P_391'] := sxml2num( xmlWartoscH( hPozycje, 'P_391' ) )
   hDane['P_392'] := sxml2num( xmlWartoscH( hPozycje, 'P_392' ) )
   hDane['P_393'] := sxml2num( xmlWartoscH( hPozycje, 'P_393' ) )
   hDane['P_394'] := sxml2num( xmlWartoscH( hPozycje, 'P_394' ) )
   hDane['P_395'] := sxml2num( xmlWartoscH( hPozycje, 'P_395' ) )
   hDane['P_396'] := sxml2num( xmlWartoscH( hPozycje, 'P_396' ) )
   hDane['P_397'] := sxml2num( xmlWartoscH( hPozycje, 'P_397' ) )
   hDane['P_398'] := sxml2num( xmlWartoscH( hPozycje, 'P_398' ) )
   hDane['P_399'] := sxml2num( xmlWartoscH( hPozycje, 'P_399' ) )
   hDane['P_400'] := sxml2num( xmlWartoscH( hPozycje, 'P_400' ) )
   hDane['P_401'] := sxml2num( xmlWartoscH( hPozycje, 'P_401' ) )
   hDane['P_402'] := sxml2num( xmlWartoscH( hPozycje, 'P_402' ) )
   hDane['P_403'] := sxml2num( xmlWartoscH( hPozycje, 'P_403' ) )
   hDane['P_404'] := sxml2num( xmlWartoscH( hPozycje, 'P_404' ) )
   hDane['P_405'] := sxml2num( xmlWartoscH( hPozycje, 'P_405' ) )
   hDane['P_406'] := sxml2num( xmlWartoscH( hPozycje, 'P_406' ) )
   hDane['P_407'] := sxml2num( xmlWartoscH( hPozycje, 'P_407' ) )
   hDane['P_408'] := sxml2num( xmlWartoscH( hPozycje, 'P_408' ) )
   hDane['P_409'] := sxml2num( xmlWartoscH( hPozycje, 'P_409' ) )
   hDane['P_410'] := sxml2num( xmlWartoscH( hPozycje, 'P_410' ) )
   hDane['P_411'] := sxml2num( xmlWartoscH( hPozycje, 'P_411' ) )
   hDane['P_412'] := sxml2num( xmlWartoscH( hPozycje, 'P_412' ) )
   hDane['P_413'] := sxml2num( xmlWartoscH( hPozycje, 'P_413' ) )
   hDane['P_414'] := sxml2num( xmlWartoscH( hPozycje, 'P_414' ) )
   hDane['P_415'] := sxml2num( xmlWartoscH( hPozycje, 'P_415' ) )
   hDane['P_416'] := sxml2num( xmlWartoscH( hPozycje, 'P_416' ) )
   hDane['P_417'] := sxml2num( xmlWartoscH( hPozycje, 'P_417' ) )
   hDane['P_418'] := sxml2num( xmlWartoscH( hPozycje, 'P_418' ) )
   hDane['P_419'] := sxml2num( xmlWartoscH( hPozycje, 'P_419' ) )
   hDane['P_420'] := sxml2num( xmlWartoscH( hPozycje, 'P_420' ) )
   hDane['P_421'] := sxml2num( xmlWartoscH( hPozycje, 'P_421' ) )
   hDane['P_422'] := sxml2num( xmlWartoscH( hPozycje, 'P_422' ) )
   hDane['P_423'] := sxml2num( xmlWartoscH( hPozycje, 'P_423' ) )
   hDane['P_424'] := sxml2num( xmlWartoscH( hPozycje, 'P_424' ) )
   hDane['P_425'] := sxml2num( xmlWartoscH( hPozycje, 'P_425' ) )
   hDane['P_426'] := sxml2num( xmlWartoscH( hPozycje, 'P_426' ) )
   hDane['P_427'] := sxml2num( xmlWartoscH( hPozycje, 'P_427' ) )
   hDane['P_428'] := sxml2num( xmlWartoscH( hPozycje, 'P_428' ) )
   hDane['P_429'] := sxml2num( xmlWartoscH( hPozycje, 'P_429' ) )

   hDane['P_430'] := iif( xmlWartoscH( hPozycje, 'P_430' ) == '1', '1', '0' )
   hDane['P_431'] := iif( xmlWartoscH( hPozycje, 'P_431' ) == '1', '1', '0' )
   hDane['P_432'] := iif( xmlWartoscH( hPozycje, 'P_432' ) == '1', '1', '0' )


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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw10(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := '0'
   hDane['P_7_2'] := '0'
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )
   hDane['P_357'] := sxml2num( xmlWartoscH( hPozycje, 'P_357' ) )
   hDane['P_358'] := sxml2num( xmlWartoscH( hPozycje, 'P_358' ) )
   hDane['P_359'] := sxml2num( xmlWartoscH( hPozycje, 'P_359' ) )
   hDane['P_360'] := sxml2num( xmlWartoscH( hPozycje, 'P_360' ) )
   hDane['P_361'] := sxml2num( xmlWartoscH( hPozycje, 'P_361' ) )
   hDane['P_362'] := sxml2num( xmlWartoscH( hPozycje, 'P_362' ) )
   hDane['P_363'] := sxml2num( xmlWartoscH( hPozycje, 'P_363' ) )
   hDane['P_364'] := sxml2num( xmlWartoscH( hPozycje, 'P_364' ) )
   hDane['P_365'] := sxml2num( xmlWartoscH( hPozycje, 'P_365' ) )
   hDane['P_366'] := sxml2num( xmlWartoscH( hPozycje, 'P_366' ) )
   hDane['P_367'] := sxml2num( xmlWartoscH( hPozycje, 'P_367' ) )
   hDane['P_368'] := sxml2num( xmlWartoscH( hPozycje, 'P_368' ) )
   hDane['P_369'] := sxml2num( xmlWartoscH( hPozycje, 'P_369' ) )
   hDane['P_370'] := sxml2num( xmlWartoscH( hPozycje, 'P_370' ) )
   hDane['P_371'] := sxml2num( xmlWartoscH( hPozycje, 'P_371' ) )
   hDane['P_372'] := sxml2num( xmlWartoscH( hPozycje, 'P_372' ) )
   hDane['P_373'] := sxml2num( xmlWartoscH( hPozycje, 'P_373' ) )
   hDane['P_374'] := sxml2num( xmlWartoscH( hPozycje, 'P_374' ) )
   hDane['P_375'] := sxml2num( xmlWartoscH( hPozycje, 'P_375' ) )
   hDane['P_376'] := sxml2num( xmlWartoscH( hPozycje, 'P_376' ) )
   hDane['P_377'] := sxml2num( xmlWartoscH( hPozycje, 'P_377' ) )
   hDane['P_378'] := sxml2num( xmlWartoscH( hPozycje, 'P_378' ) )
   hDane['P_379'] := sxml2num( xmlWartoscH( hPozycje, 'P_379' ) )
   hDane['P_380'] := sxml2num( xmlWartoscH( hPozycje, 'P_380' ) )
   hDane['P_381'] := sxml2num( xmlWartoscH( hPozycje, 'P_381' ) )
   hDane['P_382'] := sxml2num( xmlWartoscH( hPozycje, 'P_382' ) )
   hDane['P_383'] := sxml2num( xmlWartoscH( hPozycje, 'P_383' ) )
   hDane['P_384'] := sxml2num( xmlWartoscH( hPozycje, 'P_384' ) )
   hDane['P_385'] := sxml2num( xmlWartoscH( hPozycje, 'P_385' ) )
   hDane['P_386'] := sxml2num( xmlWartoscH( hPozycje, 'P_386' ) )
   hDane['P_387'] := sxml2num( xmlWartoscH( hPozycje, 'P_387' ) )
   hDane['P_388'] := sxml2num( xmlWartoscH( hPozycje, 'P_388' ) )
   hDane['P_389'] := sxml2num( xmlWartoscH( hPozycje, 'P_389' ) )
   hDane['P_390'] := sxml2num( xmlWartoscH( hPozycje, 'P_390' ) )
   hDane['P_391'] := sxml2num( xmlWartoscH( hPozycje, 'P_391' ) )
   hDane['P_392'] := sxml2num( xmlWartoscH( hPozycje, 'P_392' ) )
   hDane['P_393'] := sxml2num( xmlWartoscH( hPozycje, 'P_393' ) )
   hDane['P_394'] := sxml2num( xmlWartoscH( hPozycje, 'P_394' ) )
   hDane['P_395'] := sxml2num( xmlWartoscH( hPozycje, 'P_395' ) )
   hDane['P_396'] := sxml2num( xmlWartoscH( hPozycje, 'P_396' ) )
   hDane['P_397'] := sxml2num( xmlWartoscH( hPozycje, 'P_397' ) )
   hDane['P_398'] := sxml2num( xmlWartoscH( hPozycje, 'P_398' ) )
   hDane['P_399'] := sxml2num( xmlWartoscH( hPozycje, 'P_399' ) )
   hDane['P_400'] := sxml2num( xmlWartoscH( hPozycje, 'P_400' ) )
   hDane['P_401'] := sxml2num( xmlWartoscH( hPozycje, 'P_401' ) )
   hDane['P_402'] := sxml2num( xmlWartoscH( hPozycje, 'P_402' ) )
   hDane['P_403'] := sxml2num( xmlWartoscH( hPozycje, 'P_403' ) )
   hDane['P_404'] := sxml2num( xmlWartoscH( hPozycje, 'P_404' ) )
   hDane['P_405'] := sxml2num( xmlWartoscH( hPozycje, 'P_405' ) )
   hDane['P_406'] := sxml2num( xmlWartoscH( hPozycje, 'P_406' ) )
   hDane['P_407'] := sxml2num( xmlWartoscH( hPozycje, 'P_407' ) )
   hDane['P_408'] := sxml2num( xmlWartoscH( hPozycje, 'P_408' ) )
   hDane['P_409'] := sxml2num( xmlWartoscH( hPozycje, 'P_409' ) )
   hDane['P_410'] := sxml2num( xmlWartoscH( hPozycje, 'P_410' ) )
   hDane['P_411'] := sxml2num( xmlWartoscH( hPozycje, 'P_411' ) )
   hDane['P_412'] := sxml2num( xmlWartoscH( hPozycje, 'P_412' ) )
   hDane['P_413'] := sxml2num( xmlWartoscH( hPozycje, 'P_413' ) )
   hDane['P_414'] := sxml2num( xmlWartoscH( hPozycje, 'P_414' ) )
   hDane['P_415'] := sxml2num( xmlWartoscH( hPozycje, 'P_415' ) )
   hDane['P_416'] := sxml2num( xmlWartoscH( hPozycje, 'P_416' ) )
   hDane['P_417'] := sxml2num( xmlWartoscH( hPozycje, 'P_417' ) )
   hDane['P_418'] := sxml2num( xmlWartoscH( hPozycje, 'P_418' ) )
   hDane['P_419'] := sxml2num( xmlWartoscH( hPozycje, 'P_419' ) )
   hDane['P_420'] := sxml2num( xmlWartoscH( hPozycje, 'P_420' ) )
   hDane['P_421'] := sxml2num( xmlWartoscH( hPozycje, 'P_421' ) )
   hDane['P_422'] := sxml2num( xmlWartoscH( hPozycje, 'P_422' ) )
   hDane['P_423'] := sxml2num( xmlWartoscH( hPozycje, 'P_423' ) )
   hDane['P_424'] := sxml2num( xmlWartoscH( hPozycje, 'P_424' ) )
   hDane['P_425'] := sxml2num( xmlWartoscH( hPozycje, 'P_425' ) )
   hDane['P_426'] := sxml2num( xmlWartoscH( hPozycje, 'P_426' ) )
   hDane['P_427'] := sxml2num( xmlWartoscH( hPozycje, 'P_427' ) )
   hDane['P_428'] := sxml2num( xmlWartoscH( hPozycje, 'P_428' ) )
   hDane['P_429'] := sxml2num( xmlWartoscH( hPozycje, 'P_429' ) )

   hDane['P_430'] := iif( xmlWartoscH( hPozycje, 'P_430' ) == '1', '1', '0' )
   hDane['P_431'] := iif( xmlWartoscH( hPozycje, 'P_431' ) == '1', '1', '0' )
   hDane['P_432'] := iif( xmlWartoscH( hPozycje, 'P_432' ) == '1', '1', '0' )
   hDane['P_433'] := iif( xmlWartoscH( hPozycje, 'P_433' ) == '1', '1', '0' )
   hDane['P_434'] := iif( xmlWartoscH( hPozycje, 'P_434' ) == '1', '1', '0' )
   hDane['P_435'] := iif( xmlWartoscH( hPozycje, 'P_435' ) == '1', '1', '0' )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw11(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := '0'
   hDane['P_7_2'] := '0'
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )
   hDane['P_357'] := sxml2num( xmlWartoscH( hPozycje, 'P_357' ) )
   hDane['P_358'] := sxml2num( xmlWartoscH( hPozycje, 'P_358' ) )
   hDane['P_359'] := sxml2num( xmlWartoscH( hPozycje, 'P_359' ) )
   hDane['P_360'] := sxml2num( xmlWartoscH( hPozycje, 'P_360' ) )
   hDane['P_361'] := sxml2num( xmlWartoscH( hPozycje, 'P_361' ) )
   hDane['P_362'] := sxml2num( xmlWartoscH( hPozycje, 'P_362' ) )
   hDane['P_363'] := sxml2num( xmlWartoscH( hPozycje, 'P_363' ) )
   hDane['P_364'] := sxml2num( xmlWartoscH( hPozycje, 'P_364' ) )
   hDane['P_365'] := sxml2num( xmlWartoscH( hPozycje, 'P_365' ) )
   hDane['P_366'] := sxml2num( xmlWartoscH( hPozycje, 'P_366' ) )
   hDane['P_367'] := sxml2num( xmlWartoscH( hPozycje, 'P_367' ) )
   hDane['P_368'] := sxml2num( xmlWartoscH( hPozycje, 'P_368' ) )
   hDane['P_369'] := sxml2num( xmlWartoscH( hPozycje, 'P_369' ) )
   hDane['P_370'] := sxml2num( xmlWartoscH( hPozycje, 'P_370' ) )
   hDane['P_371'] := sxml2num( xmlWartoscH( hPozycje, 'P_371' ) )
   hDane['P_372'] := sxml2num( xmlWartoscH( hPozycje, 'P_372' ) )
   hDane['P_373'] := sxml2num( xmlWartoscH( hPozycje, 'P_373' ) )
   hDane['P_374'] := sxml2num( xmlWartoscH( hPozycje, 'P_374' ) )
   hDane['P_375'] := sxml2num( xmlWartoscH( hPozycje, 'P_375' ) )
   hDane['P_376'] := sxml2num( xmlWartoscH( hPozycje, 'P_376' ) )
   hDane['P_377'] := sxml2num( xmlWartoscH( hPozycje, 'P_377' ) )
   hDane['P_378'] := sxml2num( xmlWartoscH( hPozycje, 'P_378' ) )
   hDane['P_379'] := sxml2num( xmlWartoscH( hPozycje, 'P_379' ) )
   hDane['P_380'] := sxml2num( xmlWartoscH( hPozycje, 'P_380' ) )
   hDane['P_381'] := sxml2num( xmlWartoscH( hPozycje, 'P_381' ) )
   hDane['P_382'] := sxml2num( xmlWartoscH( hPozycje, 'P_382' ) )
   hDane['P_383'] := sxml2num( xmlWartoscH( hPozycje, 'P_383' ) )
   hDane['P_384'] := sxml2num( xmlWartoscH( hPozycje, 'P_384' ) )
   hDane['P_385'] := sxml2num( xmlWartoscH( hPozycje, 'P_385' ) )
   hDane['P_386'] := sxml2num( xmlWartoscH( hPozycje, 'P_386' ) )
   hDane['P_387'] := sxml2num( xmlWartoscH( hPozycje, 'P_387' ) )
   hDane['P_388'] := sxml2num( xmlWartoscH( hPozycje, 'P_388' ) )
   hDane['P_389'] := sxml2num( xmlWartoscH( hPozycje, 'P_389' ) )
   hDane['P_390'] := sxml2num( xmlWartoscH( hPozycje, 'P_390' ) )
   hDane['P_391'] := sxml2num( xmlWartoscH( hPozycje, 'P_391' ) )
   hDane['P_392'] := sxml2num( xmlWartoscH( hPozycje, 'P_392' ) )
   hDane['P_393'] := sxml2num( xmlWartoscH( hPozycje, 'P_393' ) )
   hDane['P_394'] := sxml2num( xmlWartoscH( hPozycje, 'P_394' ) )
   hDane['P_395'] := sxml2num( xmlWartoscH( hPozycje, 'P_395' ) )
   hDane['P_396'] := sxml2num( xmlWartoscH( hPozycje, 'P_396' ) )
   hDane['P_397'] := sxml2num( xmlWartoscH( hPozycje, 'P_397' ) )
   hDane['P_398'] := sxml2num( xmlWartoscH( hPozycje, 'P_398' ) )
   hDane['P_399'] := sxml2num( xmlWartoscH( hPozycje, 'P_399' ) )
   hDane['P_400'] := sxml2num( xmlWartoscH( hPozycje, 'P_400' ) )
   hDane['P_401'] := sxml2num( xmlWartoscH( hPozycje, 'P_401' ) )
   hDane['P_402'] := sxml2num( xmlWartoscH( hPozycje, 'P_402' ) )
   hDane['P_403'] := sxml2num( xmlWartoscH( hPozycje, 'P_403' ) )
   hDane['P_404'] := sxml2num( xmlWartoscH( hPozycje, 'P_404' ) )
   hDane['P_405'] := sxml2num( xmlWartoscH( hPozycje, 'P_405' ) )
   hDane['P_406'] := sxml2num( xmlWartoscH( hPozycje, 'P_406' ) )
   hDane['P_407'] := sxml2num( xmlWartoscH( hPozycje, 'P_407' ) )
   hDane['P_408'] := sxml2num( xmlWartoscH( hPozycje, 'P_408' ) )
   hDane['P_409'] := sxml2num( xmlWartoscH( hPozycje, 'P_409' ) )
   hDane['P_410'] := sxml2num( xmlWartoscH( hPozycje, 'P_410' ) )
   hDane['P_411'] := sxml2num( xmlWartoscH( hPozycje, 'P_411' ) )
   hDane['P_412'] := sxml2num( xmlWartoscH( hPozycje, 'P_412' ) )
   hDane['P_413'] := sxml2num( xmlWartoscH( hPozycje, 'P_413' ) )
   hDane['P_414'] := sxml2num( xmlWartoscH( hPozycje, 'P_414' ) )
   hDane['P_415'] := sxml2num( xmlWartoscH( hPozycje, 'P_415' ) )
   hDane['P_416'] := sxml2num( xmlWartoscH( hPozycje, 'P_416' ) )
   hDane['P_417'] := sxml2num( xmlWartoscH( hPozycje, 'P_417' ) )
   hDane['P_418'] := sxml2num( xmlWartoscH( hPozycje, 'P_418' ) )
   hDane['P_419'] := sxml2num( xmlWartoscH( hPozycje, 'P_419' ) )
   hDane['P_420'] := sxml2num( xmlWartoscH( hPozycje, 'P_420' ) )
   hDane['P_421'] := sxml2num( xmlWartoscH( hPozycje, 'P_421' ) )
   hDane['P_422'] := sxml2num( xmlWartoscH( hPozycje, 'P_422' ) )
   hDane['P_423'] := sxml2num( xmlWartoscH( hPozycje, 'P_423' ) )
   hDane['P_424'] := sxml2num( xmlWartoscH( hPozycje, 'P_424' ) )
   hDane['P_425'] := sxml2num( xmlWartoscH( hPozycje, 'P_425' ) )
   hDane['P_426'] := sxml2num( xmlWartoscH( hPozycje, 'P_426' ) )
   hDane['P_427'] := sxml2num( xmlWartoscH( hPozycje, 'P_427' ) )
   hDane['P_428'] := sxml2num( xmlWartoscH( hPozycje, 'P_428' ) )
   hDane['P_429'] := sxml2num( xmlWartoscH( hPozycje, 'P_429' ) )

   hDane['P_430'] := iif( xmlWartoscH( hPozycje, 'P_430' ) == '1', '1', '0' )
   hDane['P_431'] := iif( xmlWartoscH( hPozycje, 'P_431' ) == '1', '1', '0' )
   hDane['P_432'] := iif( xmlWartoscH( hPozycje, 'P_432' ) == '1', '1', '0' )
   hDane['P_433'] := iif( xmlWartoscH( hPozycje, 'P_433' ) == '1', '1', '0' )
   hDane['P_434'] := iif( xmlWartoscH( hPozycje, 'P_434' ) == '1', '1', '0' )
   hDane['P_435'] := iif( xmlWartoscH( hPozycje, 'P_435' ) == '1', '1', '0' )
   hDane['P_436'] := iif( xmlWartoscH( hPozycje, 'P_436' ) == '1', '1', '0' )
   hDane['P_437'] := iif( xmlWartoscH( hPozycje, 'P_437' ) == '1', '1', '0' )
   hDane['P_438'] := iif( xmlWartoscH( hPozycje, 'P_438' ) == '1', '1', '0' )
   hDane['P_439'] := iif( xmlWartoscH( hPozycje, 'P_439' ) == '1', '1', '0' )
   hDane['P_440'] := iif( xmlWartoscH( hPozycje, 'P_440' ) == '1', '1', '0' )
   hDane['P_441'] := iif( xmlWartoscH( hPozycje, 'P_441' ) == '1', '1', '0' )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT8ARw12(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_7_1'] := '0'
   hDane['P_7_2'] := '0'
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_7_1'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPozycje, 'P_7' ) == '2', '1', '0' )
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
   hDane['P_213'] := sxml2num( xmlWartoscH( hPozycje, 'P_213' ) )
   hDane['P_214'] := sxml2num( xmlWartoscH( hPozycje, 'P_214' ) )
   hDane['P_215'] := sxml2num( xmlWartoscH( hPozycje, 'P_215' ) )
   hDane['P_216'] := sxml2num( xmlWartoscH( hPozycje, 'P_216' ) )
   hDane['P_217'] := sxml2num( xmlWartoscH( hPozycje, 'P_217' ) )
   hDane['P_218'] := sxml2num( xmlWartoscH( hPozycje, 'P_218' ) )
   hDane['P_219'] := sxml2num( xmlWartoscH( hPozycje, 'P_219' ) )
   hDane['P_220'] := sxml2num( xmlWartoscH( hPozycje, 'P_220' ) )
   hDane['P_221'] := sxml2num( xmlWartoscH( hPozycje, 'P_221' ) )
   hDane['P_222'] := sxml2num( xmlWartoscH( hPozycje, 'P_222' ) )
   hDane['P_223'] := sxml2num( xmlWartoscH( hPozycje, 'P_223' ) )
   hDane['P_224'] := sxml2num( xmlWartoscH( hPozycje, 'P_224' ) )
   hDane['P_225'] := sxml2num( xmlWartoscH( hPozycje, 'P_225' ) )
   hDane['P_226'] := sxml2num( xmlWartoscH( hPozycje, 'P_226' ) )
   hDane['P_227'] := sxml2num( xmlWartoscH( hPozycje, 'P_227' ) )
   hDane['P_228'] := sxml2num( xmlWartoscH( hPozycje, 'P_228' ) )
   hDane['P_229'] := sxml2num( xmlWartoscH( hPozycje, 'P_229' ) )
   hDane['P_230'] := sxml2num( xmlWartoscH( hPozycje, 'P_230' ) )
   hDane['P_231'] := sxml2num( xmlWartoscH( hPozycje, 'P_231' ) )
   hDane['P_232'] := sxml2num( xmlWartoscH( hPozycje, 'P_232' ) )
   hDane['P_233'] := sxml2num( xmlWartoscH( hPozycje, 'P_233' ) )
   hDane['P_234'] := sxml2num( xmlWartoscH( hPozycje, 'P_234' ) )
   hDane['P_235'] := sxml2num( xmlWartoscH( hPozycje, 'P_235' ) )
   hDane['P_236'] := sxml2num( xmlWartoscH( hPozycje, 'P_236' ) )
   hDane['P_237'] := sxml2num( xmlWartoscH( hPozycje, 'P_237' ) )
   hDane['P_238'] := sxml2num( xmlWartoscH( hPozycje, 'P_238' ) )
   hDane['P_239'] := sxml2num( xmlWartoscH( hPozycje, 'P_239' ) )
   hDane['P_240'] := sxml2num( xmlWartoscH( hPozycje, 'P_240' ) )
   hDane['P_241'] := sxml2num( xmlWartoscH( hPozycje, 'P_241' ) )
   hDane['P_242'] := sxml2num( xmlWartoscH( hPozycje, 'P_242' ) )
   hDane['P_243'] := sxml2num( xmlWartoscH( hPozycje, 'P_243' ) )
   hDane['P_244'] := sxml2num( xmlWartoscH( hPozycje, 'P_244' ) )
   hDane['P_245'] := sxml2num( xmlWartoscH( hPozycje, 'P_245' ) )
   hDane['P_246'] := sxml2num( xmlWartoscH( hPozycje, 'P_246' ) )
   hDane['P_247'] := sxml2num( xmlWartoscH( hPozycje, 'P_247' ) )
   hDane['P_248'] := sxml2num( xmlWartoscH( hPozycje, 'P_248' ) )
   hDane['P_249'] := sxml2num( xmlWartoscH( hPozycje, 'P_249' ) )
   hDane['P_250'] := sxml2num( xmlWartoscH( hPozycje, 'P_250' ) )
   hDane['P_251'] := sxml2num( xmlWartoscH( hPozycje, 'P_251' ) )
   hDane['P_252'] := sxml2num( xmlWartoscH( hPozycje, 'P_252' ) )
   hDane['P_253'] := sxml2num( xmlWartoscH( hPozycje, 'P_253' ) )
   hDane['P_254'] := sxml2num( xmlWartoscH( hPozycje, 'P_254' ) )
   hDane['P_255'] := sxml2num( xmlWartoscH( hPozycje, 'P_255' ) )
   hDane['P_256'] := sxml2num( xmlWartoscH( hPozycje, 'P_256' ) )
   hDane['P_257'] := sxml2num( xmlWartoscH( hPozycje, 'P_257' ) )
   hDane['P_258'] := sxml2num( xmlWartoscH( hPozycje, 'P_258' ) )
   hDane['P_259'] := sxml2num( xmlWartoscH( hPozycje, 'P_259' ) )
   hDane['P_260'] := sxml2num( xmlWartoscH( hPozycje, 'P_260' ) )
   hDane['P_261'] := sxml2num( xmlWartoscH( hPozycje, 'P_261' ) )
   hDane['P_262'] := sxml2num( xmlWartoscH( hPozycje, 'P_262' ) )
   hDane['P_263'] := sxml2num( xmlWartoscH( hPozycje, 'P_263' ) )
   hDane['P_264'] := sxml2num( xmlWartoscH( hPozycje, 'P_264' ) )
   hDane['P_265'] := sxml2num( xmlWartoscH( hPozycje, 'P_265' ) )
   hDane['P_266'] := sxml2num( xmlWartoscH( hPozycje, 'P_266' ) )
   hDane['P_267'] := sxml2num( xmlWartoscH( hPozycje, 'P_267' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_268'] := sxml2num( xmlWartoscH( hPozycje, 'P_268' ) )
   hDane['P_269'] := sxml2num( xmlWartoscH( hPozycje, 'P_269' ) )
   hDane['P_270'] := sxml2num( xmlWartoscH( hPozycje, 'P_270' ) )
   hDane['P_271'] := sxml2num( xmlWartoscH( hPozycje, 'P_271' ) )
   hDane['P_272'] := sxml2num( xmlWartoscH( hPozycje, 'P_272' ) )
   hDane['P_273'] := sxml2num( xmlWartoscH( hPozycje, 'P_273' ) )
   hDane['P_274'] := sxml2num( xmlWartoscH( hPozycje, 'P_274' ) )
   hDane['P_275'] := sxml2num( xmlWartoscH( hPozycje, 'P_275' ) )
   hDane['P_276'] := sxml2num( xmlWartoscH( hPozycje, 'P_276' ) )
   hDane['P_277'] := sxml2num( xmlWartoscH( hPozycje, 'P_277' ) )
   hDane['P_278'] := sxml2num( xmlWartoscH( hPozycje, 'P_278' ) )
   hDane['P_279'] := sxml2num( xmlWartoscH( hPozycje, 'P_279' ) )
   hDane['P_280'] := sxml2num( xmlWartoscH( hPozycje, 'P_280' ) )
   hDane['P_281'] := sxml2num( xmlWartoscH( hPozycje, 'P_281' ) )
   hDane['P_282'] := sxml2num( xmlWartoscH( hPozycje, 'P_282' ) )
   hDane['P_283'] := sxml2num( xmlWartoscH( hPozycje, 'P_283' ) )
   hDane['P_284'] := sxml2num( xmlWartoscH( hPozycje, 'P_284' ) )
   hDane['P_285'] := sxml2num( xmlWartoscH( hPozycje, 'P_285' ) )
   hDane['P_286'] := sxml2num( xmlWartoscH( hPozycje, 'P_286' ) )
   hDane['P_287'] := sxml2num( xmlWartoscH( hPozycje, 'P_287' ) )
   hDane['P_288'] := sxml2num( xmlWartoscH( hPozycje, 'P_288' ) )
   hDane['P_289'] := sxml2num( xmlWartoscH( hPozycje, 'P_289' ) )
   hDane['P_290'] := sxml2num( xmlWartoscH( hPozycje, 'P_290' ) )
   hDane['P_291'] := sxml2num( xmlWartoscH( hPozycje, 'P_291' ) )
   hDane['P_292'] := sxml2num( xmlWartoscH( hPozycje, 'P_292' ) )
   hDane['P_293'] := sxml2num( xmlWartoscH( hPozycje, 'P_293' ) )
   hDane['P_294'] := sxml2num( xmlWartoscH( hPozycje, 'P_294' ) )
   hDane['P_295'] := sxml2num( xmlWartoscH( hPozycje, 'P_295' ) )
   hDane['P_296'] := sxml2num( xmlWartoscH( hPozycje, 'P_296' ) )
   hDane['P_297'] := sxml2num( xmlWartoscH( hPozycje, 'P_297' ) )
   hDane['P_298'] := sxml2num( xmlWartoscH( hPozycje, 'P_298' ) )
   hDane['P_299'] := sxml2num( xmlWartoscH( hPozycje, 'P_299' ) )
   hDane['P_300'] := sxml2num( xmlWartoscH( hPozycje, 'P_300' ) )
   hDane['P_301'] := sxml2num( xmlWartoscH( hPozycje, 'P_301' ) )
   hDane['P_302'] := sxml2num( xmlWartoscH( hPozycje, 'P_302' ) )
   hDane['P_303'] := sxml2num( xmlWartoscH( hPozycje, 'P_303' ) )
   hDane['P_304'] := sxml2num( xmlWartoscH( hPozycje, 'P_304' ) )
   hDane['P_305'] := sxml2num( xmlWartoscH( hPozycje, 'P_305' ) )
   hDane['P_306'] := sxml2num( xmlWartoscH( hPozycje, 'P_306' ) )
   hDane['P_307'] := sxml2num( xmlWartoscH( hPozycje, 'P_307' ) )
   hDane['P_308'] := sxml2num( xmlWartoscH( hPozycje, 'P_308' ) )
   hDane['P_309'] := sxml2num( xmlWartoscH( hPozycje, 'P_309' ) )
   hDane['P_310'] := sxml2num( xmlWartoscH( hPozycje, 'P_310' ) )
   hDane['P_311'] := sxml2num( xmlWartoscH( hPozycje, 'P_311' ) )
   hDane['P_312'] := sxml2num( xmlWartoscH( hPozycje, 'P_312' ) )
   hDane['P_313'] := sxml2num( xmlWartoscH( hPozycje, 'P_313' ) )
   hDane['P_314'] := sxml2num( xmlWartoscH( hPozycje, 'P_314' ) )
   hDane['P_315'] := sxml2num( xmlWartoscH( hPozycje, 'P_315' ) )
   hDane['P_316'] := sxml2num( xmlWartoscH( hPozycje, 'P_316' ) )
   hDane['P_317'] := sxml2num( xmlWartoscH( hPozycje, 'P_317' ) )
   hDane['P_318'] := sxml2num( xmlWartoscH( hPozycje, 'P_318' ) )
   hDane['P_319'] := sxml2num( xmlWartoscH( hPozycje, 'P_319' ) )
   hDane['P_320'] := sxml2num( xmlWartoscH( hPozycje, 'P_320' ) )
   hDane['P_321'] := sxml2num( xmlWartoscH( hPozycje, 'P_321' ) )
   hDane['P_322'] := sxml2num( xmlWartoscH( hPozycje, 'P_322' ) )
   hDane['P_323'] := sxml2num( xmlWartoscH( hPozycje, 'P_323' ) )
   hDane['P_324'] := sxml2num( xmlWartoscH( hPozycje, 'P_324' ) )
   hDane['P_325'] := sxml2num( xmlWartoscH( hPozycje, 'P_325' ) )
   hDane['P_326'] := sxml2num( xmlWartoscH( hPozycje, 'P_326' ) )
   hDane['P_327'] := sxml2num( xmlWartoscH( hPozycje, 'P_327' ) )
   hDane['P_328'] := sxml2num( xmlWartoscH( hPozycje, 'P_328' ) )
   hDane['P_329'] := sxml2num( xmlWartoscH( hPozycje, 'P_329' ) )
   hDane['P_330'] := sxml2num( xmlWartoscH( hPozycje, 'P_330' ) )
   hDane['P_331'] := sxml2num( xmlWartoscH( hPozycje, 'P_331' ) )
   hDane['P_332'] := sxml2num( xmlWartoscH( hPozycje, 'P_332' ) )
   hDane['P_333'] := sxml2num( xmlWartoscH( hPozycje, 'P_333' ) )
   hDane['P_334'] := sxml2num( xmlWartoscH( hPozycje, 'P_334' ) )
   hDane['P_335'] := sxml2num( xmlWartoscH( hPozycje, 'P_335' ) )
   hDane['P_336'] := sxml2num( xmlWartoscH( hPozycje, 'P_336' ) )
   hDane['P_337'] := sxml2num( xmlWartoscH( hPozycje, 'P_337' ) )
   hDane['P_338'] := sxml2num( xmlWartoscH( hPozycje, 'P_338' ) )
   hDane['P_339'] := sxml2num( xmlWartoscH( hPozycje, 'P_339' ) )
   hDane['P_340'] := sxml2num( xmlWartoscH( hPozycje, 'P_340' ) )
   hDane['P_341'] := sxml2num( xmlWartoscH( hPozycje, 'P_341' ) )
   hDane['P_342'] := sxml2num( xmlWartoscH( hPozycje, 'P_342' ) )
   hDane['P_343'] := sxml2num( xmlWartoscH( hPozycje, 'P_343' ) )
   hDane['P_344'] := sxml2num( xmlWartoscH( hPozycje, 'P_344' ) )
   hDane['P_345'] := sxml2num( xmlWartoscH( hPozycje, 'P_345' ) )
   hDane['P_346'] := sxml2num( xmlWartoscH( hPozycje, 'P_346' ) )
   hDane['P_347'] := sxml2num( xmlWartoscH( hPozycje, 'P_347' ) )
   hDane['P_348'] := sxml2num( xmlWartoscH( hPozycje, 'P_348' ) )
   hDane['P_349'] := sxml2num( xmlWartoscH( hPozycje, 'P_349' ) )
   hDane['P_350'] := sxml2num( xmlWartoscH( hPozycje, 'P_350' ) )
   hDane['P_351'] := sxml2num( xmlWartoscH( hPozycje, 'P_351' ) )
   hDane['P_352'] := sxml2num( xmlWartoscH( hPozycje, 'P_352' ) )
   hDane['P_353'] := sxml2num( xmlWartoscH( hPozycje, 'P_353' ) )
   hDane['P_354'] := sxml2num( xmlWartoscH( hPozycje, 'P_354' ) )
   hDane['P_355'] := sxml2num( xmlWartoscH( hPozycje, 'P_355' ) )
   hDane['P_356'] := sxml2num( xmlWartoscH( hPozycje, 'P_356' ) )
   hDane['P_357'] := sxml2num( xmlWartoscH( hPozycje, 'P_357' ) )
   hDane['P_358'] := sxml2num( xmlWartoscH( hPozycje, 'P_358' ) )
   hDane['P_359'] := sxml2num( xmlWartoscH( hPozycje, 'P_359' ) )
   hDane['P_360'] := sxml2num( xmlWartoscH( hPozycje, 'P_360' ) )
   hDane['P_361'] := sxml2num( xmlWartoscH( hPozycje, 'P_361' ) )
   hDane['P_362'] := sxml2num( xmlWartoscH( hPozycje, 'P_362' ) )
   hDane['P_363'] := sxml2num( xmlWartoscH( hPozycje, 'P_363' ) )
   hDane['P_364'] := sxml2num( xmlWartoscH( hPozycje, 'P_364' ) )
   hDane['P_365'] := sxml2num( xmlWartoscH( hPozycje, 'P_365' ) )
   hDane['P_366'] := sxml2num( xmlWartoscH( hPozycje, 'P_366' ) )
   hDane['P_367'] := sxml2num( xmlWartoscH( hPozycje, 'P_367' ) )
   hDane['P_368'] := sxml2num( xmlWartoscH( hPozycje, 'P_368' ) )
   hDane['P_369'] := sxml2num( xmlWartoscH( hPozycje, 'P_369' ) )
   hDane['P_370'] := sxml2num( xmlWartoscH( hPozycje, 'P_370' ) )
   hDane['P_371'] := sxml2num( xmlWartoscH( hPozycje, 'P_371' ) )
   hDane['P_372'] := sxml2num( xmlWartoscH( hPozycje, 'P_372' ) )
   hDane['P_373'] := sxml2num( xmlWartoscH( hPozycje, 'P_373' ) )
   hDane['P_374'] := sxml2num( xmlWartoscH( hPozycje, 'P_374' ) )
   hDane['P_375'] := sxml2num( xmlWartoscH( hPozycje, 'P_375' ) )
   hDane['P_376'] := sxml2num( xmlWartoscH( hPozycje, 'P_376' ) )
   hDane['P_377'] := sxml2num( xmlWartoscH( hPozycje, 'P_377' ) )
   hDane['P_378'] := sxml2num( xmlWartoscH( hPozycje, 'P_378' ) )
   hDane['P_379'] := sxml2num( xmlWartoscH( hPozycje, 'P_379' ) )
   hDane['P_380'] := sxml2num( xmlWartoscH( hPozycje, 'P_380' ) )
   hDane['P_381'] := sxml2num( xmlWartoscH( hPozycje, 'P_381' ) )
   hDane['P_382'] := sxml2num( xmlWartoscH( hPozycje, 'P_382' ) )
   hDane['P_383'] := sxml2num( xmlWartoscH( hPozycje, 'P_383' ) )
   hDane['P_384'] := sxml2num( xmlWartoscH( hPozycje, 'P_384' ) )
   hDane['P_385'] := sxml2num( xmlWartoscH( hPozycje, 'P_385' ) )
   hDane['P_386'] := sxml2num( xmlWartoscH( hPozycje, 'P_386' ) )
   hDane['P_387'] := sxml2num( xmlWartoscH( hPozycje, 'P_387' ) )
   hDane['P_388'] := sxml2num( xmlWartoscH( hPozycje, 'P_388' ) )
   hDane['P_389'] := sxml2num( xmlWartoscH( hPozycje, 'P_389' ) )
   hDane['P_390'] := sxml2num( xmlWartoscH( hPozycje, 'P_390' ) )
   hDane['P_391'] := sxml2num( xmlWartoscH( hPozycje, 'P_391' ) )
   hDane['P_392'] := sxml2num( xmlWartoscH( hPozycje, 'P_392' ) )
   hDane['P_393'] := sxml2num( xmlWartoscH( hPozycje, 'P_393' ) )
   hDane['P_394'] := sxml2num( xmlWartoscH( hPozycje, 'P_394' ) )
   hDane['P_395'] := sxml2num( xmlWartoscH( hPozycje, 'P_395' ) )
   hDane['P_396'] := sxml2num( xmlWartoscH( hPozycje, 'P_396' ) )
   hDane['P_397'] := sxml2num( xmlWartoscH( hPozycje, 'P_397' ) )
   hDane['P_398'] := sxml2num( xmlWartoscH( hPozycje, 'P_398' ) )
   hDane['P_399'] := sxml2num( xmlWartoscH( hPozycje, 'P_399' ) )
   hDane['P_400'] := sxml2num( xmlWartoscH( hPozycje, 'P_400' ) )
   hDane['P_401'] := sxml2num( xmlWartoscH( hPozycje, 'P_401' ) )
   hDane['P_402'] := sxml2num( xmlWartoscH( hPozycje, 'P_402' ) )
   hDane['P_403'] := sxml2num( xmlWartoscH( hPozycje, 'P_403' ) )
   hDane['P_404'] := sxml2num( xmlWartoscH( hPozycje, 'P_404' ) )
   hDane['P_405'] := sxml2num( xmlWartoscH( hPozycje, 'P_405' ) )
   hDane['P_406'] := sxml2num( xmlWartoscH( hPozycje, 'P_406' ) )
   hDane['P_407'] := sxml2num( xmlWartoscH( hPozycje, 'P_407' ) )
   hDane['P_408'] := sxml2num( xmlWartoscH( hPozycje, 'P_408' ) )
   hDane['P_409'] := sxml2num( xmlWartoscH( hPozycje, 'P_409' ) )
   hDane['P_410'] := sxml2num( xmlWartoscH( hPozycje, 'P_410' ) )
   hDane['P_411'] := sxml2num( xmlWartoscH( hPozycje, 'P_411' ) )
   hDane['P_412'] := sxml2num( xmlWartoscH( hPozycje, 'P_412' ) )
   hDane['P_413'] := sxml2num( xmlWartoscH( hPozycje, 'P_413' ) )
   hDane['P_414'] := sxml2num( xmlWartoscH( hPozycje, 'P_414' ) )
   hDane['P_415'] := sxml2num( xmlWartoscH( hPozycje, 'P_415' ) )
   hDane['P_416'] := sxml2num( xmlWartoscH( hPozycje, 'P_416' ) )
   hDane['P_417'] := sxml2num( xmlWartoscH( hPozycje, 'P_417' ) )
   hDane['P_418'] := sxml2num( xmlWartoscH( hPozycje, 'P_418' ) )
   hDane['P_419'] := sxml2num( xmlWartoscH( hPozycje, 'P_419' ) )
   hDane['P_420'] := sxml2num( xmlWartoscH( hPozycje, 'P_420' ) )
   hDane['P_421'] := sxml2num( xmlWartoscH( hPozycje, 'P_421' ) )
   hDane['P_422'] := sxml2num( xmlWartoscH( hPozycje, 'P_422' ) )
   hDane['P_423'] := sxml2num( xmlWartoscH( hPozycje, 'P_423' ) )
   hDane['P_424'] := sxml2num( xmlWartoscH( hPozycje, 'P_424' ) )
   hDane['P_425'] := sxml2num( xmlWartoscH( hPozycje, 'P_425' ) )
   hDane['P_426'] := sxml2num( xmlWartoscH( hPozycje, 'P_426' ) )
   hDane['P_427'] := sxml2num( xmlWartoscH( hPozycje, 'P_427' ) )
   hDane['P_428'] := sxml2num( xmlWartoscH( hPozycje, 'P_428' ) )
   hDane['P_429'] := sxml2num( xmlWartoscH( hPozycje, 'P_429' ) )
   hDane['P_430'] := sxml2num( xmlWartoscH( hPozycje, 'P_430' ) )
   hDane['P_431'] := sxml2num( xmlWartoscH( hPozycje, 'P_431' ) )
   hDane['P_432'] := sxml2num( xmlWartoscH( hPozycje, 'P_432' ) )
   hDane['P_433'] := sxml2num( xmlWartoscH( hPozycje, 'P_433' ) )
   hDane['P_434'] := sxml2num( xmlWartoscH( hPozycje, 'P_434' ) )
   hDane['P_435'] := sxml2num( xmlWartoscH( hPozycje, 'P_435' ) )
   hDane['P_436'] := sxml2num( xmlWartoscH( hPozycje, 'P_436' ) )
   hDane['P_437'] := sxml2num( xmlWartoscH( hPozycje, 'P_437' ) )
   hDane['P_438'] := sxml2num( xmlWartoscH( hPozycje, 'P_438' ) )
   hDane['P_439'] := sxml2num( xmlWartoscH( hPozycje, 'P_439' ) )
   hDane['P_440'] := sxml2num( xmlWartoscH( hPozycje, 'P_440' ) )
   hDane['P_441'] := sxml2num( xmlWartoscH( hPozycje, 'P_441' ) )

   hDane['P_442'] := iif( xmlWartoscH( hPozycje, 'P_442' ) == '1', '1', '0' )
   hDane['P_443'] := iif( xmlWartoscH( hPozycje, 'P_443' ) == '1', '1', '0' )
   hDane['P_444'] := iif( xmlWartoscH( hPozycje, 'P_444' ) == '1', '1', '0' )
   hDane['P_445'] := iif( xmlWartoscH( hPozycje, 'P_445' ) == '1', '1', '0' )
   hDane['P_446'] := iif( xmlWartoscH( hPozycje, 'P_446' ) == '1', '1', '0' )
   hDane['P_447'] := iif( xmlWartoscH( hPozycje, 'P_447' ) == '1', '1', '0' )
   hDane['P_448'] := iif( xmlWartoscH( hPozycje, 'P_448' ) == '1', '1', '0' )
   hDane['P_449'] := iif( xmlWartoscH( hPozycje, 'P_449' ) == '1', '1', '0' )
   hDane['P_450'] := iif( xmlWartoscH( hPozycje, 'P_450' ) == '1', '1', '0' )
   hDane['P_451'] := iif( xmlWartoscH( hPozycje, 'P_452' ) == '1', '1', '0' )
   hDane['P_452'] := iif( xmlWartoscH( hPozycje, 'P_453' ) == '1', '1', '0' )
   hDane['P_453'] := iif( xmlWartoscH( hPozycje, 'P_453' ) == '1', '1', '0' )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w22(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_5'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_6_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_6_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   hDane['P_10_1'] := '1'
   hDane['P_10_2'] := '0'
   IF xmlWartoscH( hPodmiot2, 'etd:NIP' ) == ''
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'etd:PESEL' )
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'etd:NIP' )
   ENDIF
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'etd:Nazwisko' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'etd:ImiePierwsze' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'etd:DataUrodzenia' )
   hDane['P_18'] := 'POLSKA'
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'Poczta' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_76_1'] := iif( xmlWartoscH( hPozycje, 'P_76' ) == '1', '1', '0' )
   hDane['P_76_2'] := iif( xmlWartoscH( hPozycje, 'P_76' ) == '2', '1', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_11_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_11_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_8_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_8_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_15']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_17']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w23(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_5'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_6_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_6_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10_1'] := '1'
   hDane['P_10_2'] := '0'
   IF xmlWartoscH( hPodmiot2, 'NIP' ) == ''
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'PESEL' )
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'NIP' )
   ENDIF
   hDane['P_12'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_13'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_14'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'Nazwisko' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'ImiePierwsze' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'DataUrodzenia' )
   hDane['P_18'] := 'POLSKA'
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'Poczta' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_76_1'] := iif( xmlWartoscH( hPozycje, 'P_76' ) == '1', '1', '0' )
   hDane['P_76_2'] := iif( xmlWartoscH( hPozycje, 'P_76' ) == '2', '1', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_11_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_11_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_8_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_8_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_15']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_17']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w24(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_5'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_6_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_6_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_7_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10_1'] := iif( xmlWartoscH( hPozycje, 'P_10' ) == '1', '1', '0' )
   hDane['P_10_2'] := iif( xmlWartoscH( hPozycje, 'P_10' ) == '2', '1', '0' )
   IF xmlWartoscH( hPodmiot2, 'etd:NIP' ) == ''
      hDane['P_11_R'] := 'P'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'etd:PESEL' )
   ELSE
      hDane['P_11_R'] := 'N'
      hDane['P_11_N'] := xmlWartoscH( hPodmiot2, 'etd:NIP' )
   ENDIF
   hDane['P_12'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_13'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_14'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'etd:Nazwisko' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'etd:ImiePierwsze' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'etd:DataUrodzenia' )
   hDane['P_18'] := xmlWartoscH( hPodmiot2, 'KodKraju' )
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'Poczta' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_85_1'] := iif( xmlWartoscH( hPozycje, 'P_85' ) == '1', '1', '0' )
   hDane['P_85_2'] := iif( xmlWartoscH( hPozycje, 'P_85' ) == '2', '1', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_11_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_11_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_8_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_9_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_9_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_8_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_15']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_17']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w25(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   hDane['P_5'] := xmlWartoscH( hPozycje, 'P_5' )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_10_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_10_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ENDIF
   hDane['P_11_1'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '1', '1', '0' )
   hDane['P_11_2'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '2', '1', '0' )
   IF xmlWartoscH( hPodmiot2, 'etd:NIP' ) == ''
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'etd:PESEL' )
   ELSE
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'etd:NIP' )
   ENDIF
   hDane['P_13'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_14'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'etd:Nazwisko' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'etd:ImiePierwsze' )
   hDane['P_18'] := xmlWartoscH( hPodmiot2, 'etd:DataUrodzenia' )
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'KodKraju' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_89_1'] := iif( xmlWartoscH( hPozycje, 'P_89' ) == '1', '1', '0' )
   hDane['P_89_2'] := iif( xmlWartoscH( hPozycje, 'P_89' ) == '2', '1', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_12_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_12_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_10_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_10_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_10_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_17']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_18']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w27(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   hDane['P_5'] := xmlWartoscH( hPozycje, 'P_5' )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_10_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_10_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ENDIF
   hDane['P_11_1'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '1', '1', '0' )
   hDane['P_11_2'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '2', '1', '0' )
   IF xmlWartoscH( hPodmiot2, 'etd:NIP' ) == ''
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'etd:PESEL' )
   ELSE
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'etd:NIP' )
   ENDIF
   hDane['P_13'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_14'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'etd:Nazwisko' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'etd:ImiePierwsze' )
   hDane['P_18'] := xmlWartoscH( hPodmiot2, 'etd:DataUrodzenia' )
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'KodKraju' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_96_1'] := iif( xmlWartoscH( hPozycje, 'P_96' ) == '1', '1', '0' )
   hDane['P_96_2'] := iif( xmlWartoscH( hPozycje, 'P_96' ) == '2', '1', '0' )

   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_12_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_12_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_10_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_10_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_10_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_17']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_18']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_PIT11w29(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xmlWartoscH( hNaglowek, 'Rok', AllTrim( Str( Year( Date() ) ) ) )
   hDane['P_5'] := xmlWartoscH( hPozycje, 'P_5' )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_R'] := ''
      hDane['P_10_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_10_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_10_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_9_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_10_N'] := ''
      hDane['P_10_I'] := ''
      hDane['P_10_D'] := ''
   ENDIF
   hDane['P_11_1'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '1', '1', '0' )
   hDane['P_11_2'] := iif( xmlWartoscH( hPozycje, 'P_11' ) == '2', '1', '0' )
   IF xmlWartoscH( hPodmiot2, 'NIP' ) == ''
      hDane['P_12_R'] := 'P'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'PESEL' )
   ELSE
      hDane['P_12_R'] := 'N'
      hDane['P_12_N'] := xmlWartoscH( hPodmiot2, 'NIP' )
   ENDIF
   hDane['P_13'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_14'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_15'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_16'] := xmlWartoscH( hPodmiot2, 'Nazwisko' )
   hDane['P_17'] := xmlWartoscH( hPodmiot2, 'ImiePierwsze' )
   hDane['P_18'] := xmlWartoscH( hPodmiot2, 'DataUrodzenia' )
   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'KodKraju' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Wojewodztwo' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'Powiat' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'Gmina' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )

   hDane['P_28_1'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '1', '1', '0' )
   hDane['P_28_2'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '2', '1', '0' )
   hDane['P_28_3'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '3', '1', '0' )
   hDane['P_28_4'] := iif( xmlWartoscH( hPozycje, 'P_28' ) == '4', '1', '0' )

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

   hDane['P_118_1'] := iif( xmlWartoscH( hPozycje, 'P_118' ) == '1', '1', '0' )
   hDane['P_119_1'] := iif( xmlWartoscH( hPozycje, 'P_119' ) == '1', '1', '0' )
   hDane['P_120_1'] := iif( xmlWartoscH( hPozycje, 'P_120' ) == '1', '1', '0' )

   hDane['P_121_1'] := iif( xmlWartoscH( hPozycje, 'P_121' ) == '1', '1', '0' )
   hDane['P_121_2'] := iif( xmlWartoscH( hPozycje, 'P_121' ) == '2', '1', '0' )

   hDane['P_122'] := sxml2num( xmlWartoscH( hPozycje, 'P_122' ) )
   hDane['P_123'] := sxml2num( xmlWartoscH( hPozycje, 'P_123' ) )


   IF xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2' .AND. Len(edekXmlORDZU( oDoc )) > 0
      hDane['ORDZU'] := hb_Hash()
      hDane['ORDZU']['ORDZU_13'] := edekXmlORDZU( oDoc )
      hDane['ORDZU']['ORDZU_1_R'] := 'N'
      hDane['ORDZU']['ORDZU_1_N'] := hDane['P_1']
      hDane['ORDZU']['ORDZU_2_R'] := hDane['P_12_R']
      hDane['ORDZU']['ORDZU_2_N'] := hDane['P_12_N']
      hDane['ORDZU']['ORDZU_3'] := hDane['P_2']

      hDane['ORDZU']['ORDZU_5_N1'] := hDane['P_9_N']
      hDane['ORDZU']['ORDZU_5_N2'] := hDane['P_10_N']
      hDane['ORDZU']['ORDZU_6'] := hDane['P_10_I']
      hDane['ORDZU']['ORDZU_7'] := hDane['P_10_D']
      hDane['ORDZU']['ORDZU_8'] := hDane['P_9_N']

      hDane['ORDZU']['ORDZU_9'] := hDane['P_16']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_17']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_18']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w15(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_59'] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '1', '1', '0' )
   hDane['P_60'] := iif( xmlWartoscH( hPozycje, 'P_60' ) == '1', '1', '0' )
   hDane['P_61'] := iif( xmlWartoscH( hPozycje, 'P_61' ) == '1', '1', '0' )
   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63_1'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_63_2'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '2', '1', '0' )

   hDane['P_64_1'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_64_2'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '2', '1', '0' )
   hDane['P_65_1'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_65_2'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '2', '1', '0' )
   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )

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
   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w16(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_60'] := iif( xmlWartoscH( hPozycje, 'P_60' ) == '1', '1', '0' )
   hDane['P_61'] := iif( xmlWartoscH( hPozycje, 'P_61' ) == '1', '1', '0' )
   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64_1'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_64_2'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '2', '1', '0' )

   hDane['P_65_1'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_65_2'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '2', '1', '0' )
   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )
   hDane['P_67_1'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_67_2'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '2', '1', '0' )

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
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w17(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )

   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )
   hDane['P_67_1'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_67_2'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '2', '1', '0' )
   hDane['P_68_1'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_68_2'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '2', '1', '0' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_66' ) == '1'
      hDane[ 'VATZZ' ] := edekXmlVATZZ5( oDoc )
      hDane[ 'VATZZ' ][ 'rob' ] := .T.
      hDane[ 'VATZZ' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZZ' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZZ' ][ 'P_4' ] := hDane[ 'P_8_N' ] + hDane[ 'P_9_N' ]
      hDane[ 'VATZZ' ][ 'P_5' ] := hDane[ 'P_9_I' ]
      hDane[ 'VATZZ' ][ 'P_6' ] := hDane[ 'P_9_D' ]
      hDane[ 'VATZZ' ][ 'P_7' ] := hDane[ 'P_8_R' ]
   ELSE
      hDane[ 'VATZZ' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w18(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP', '' )
   IF hDane['P_1'] == ''
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )

   hDane['P_69_1'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_69_2'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '2', '1', '0' )
   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )
   hDane['P_71_1'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '1', '1', '0' )
   hDane['P_71_2'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '2', '1', '0' )

   hDane['P_74'] := xmlWartoscH( hPozycje, 'P_74' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_69' ) == '1'
      hDane[ 'VATZZ' ] := edekXmlVATZZ5( oDoc )
      hDane[ 'VATZZ' ][ 'rob' ] := .T.
      hDane[ 'VATZZ' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZZ' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZZ' ][ 'P_4' ] := hDane[ 'P_8_N' ] + hDane[ 'P_9_N' ]
      hDane[ 'VATZZ' ][ 'P_5' ] := hDane[ 'P_9_I' ]
      hDane[ 'VATZZ' ][ 'P_6' ] := hDane[ 'P_9_D' ]
      hDane[ 'VATZZ' ][ 'P_7' ] := hDane[ 'P_8_R' ]
   ELSE
      hDane[ 'VATZZ' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w19(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP', '' )
   IF hDane['P_1'] == ''
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )

   hDane['P_69_1'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_69_2'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '2', '1', '0' )

   hDane['P_72'] := xmlWartoscH( hPozycje, 'P_72' )
   hDane['P_73'] := xmlWartoscH( hPozycje, 'P_73' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_69' ) == '1'
      hDane[ 'VATZD' ] := edekXmlVATZD1( oDoc )
      hDane[ 'VATZD' ][ 'rob' ] := .T.
      hDane[ 'VATZD' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZD' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZD' ][ 'P_4' ] := hDane[ 'P_4' ]
      hDane[ 'VATZD' ][ 'P_5' ] := ''
      hDane[ 'VATZD' ][ 'P_6' ] := hDane[ 'P_5' ]
      hDane[ 'VATZD' ][ 'P_7' ] := '1'
      hDane[ 'VATZD' ][ 'P_8_1' ] := hDane[ 'P_8_1' ]
      hDane[ 'VATZD' ][ 'P_8_2' ] := hDane[ 'P_8_2' ]
      hDane[ 'VATZD' ][ 'P_9' ] := hDane[ 'P_9' ]
   ELSE
      hDane[ 'VATZD' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7w20(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_69'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )

   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )

   hDane['P_73'] := xmlWartoscH( hPozycje, 'P_73' )
   hDane['P_74'] := xmlWartoscH( hPozycje, 'P_74' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_70' ) == '1'
      hDane[ 'VATZD' ] := edekXmlVATZD1( oDoc )
      hDane[ 'VATZD' ][ 'rob' ] := .T.
      hDane[ 'VATZD' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZD' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZD' ][ 'P_4' ] := hDane[ 'P_4' ]
      hDane[ 'VATZD' ][ 'P_5' ] := ''
      hDane[ 'VATZD' ][ 'P_6' ] := hDane[ 'P_5' ]
      hDane[ 'VATZD' ][ 'P_7' ] := '1'
      hDane[ 'VATZD' ][ 'P_8_1' ] := hDane[ 'P_8_1' ]
      hDane[ 'VATZD' ][ 'P_8_2' ] := hDane[ 'P_8_2' ]
      hDane[ 'VATZD' ][ 'P_9' ] := hDane[ 'P_9' ]
   ELSE
      hDane[ 'VATZD' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw9(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_59'] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '1', '1', '0' )
   hDane['P_60'] := iif( xmlWartoscH( hPozycje, 'P_60' ) == '1', '1', '0' )
   hDane['P_61'] := iif( xmlWartoscH( hPozycje, 'P_61' ) == '1', '1', '0' )
   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63_1'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_63_2'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '2', '1', '0' )

   hDane['P_64_1'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_64_2'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '2', '1', '0' )
   hDane['P_65_1'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_65_2'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '2', '1', '0' )
   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )

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
   ENDIF
   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw10(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_60'] := iif( xmlWartoscH( hPozycje, 'P_60' ) == '1', '1', '0' )
   hDane['P_61'] := iif( xmlWartoscH( hPozycje, 'P_61' ) == '1', '1', '0' )
   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64_1'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_64_2'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '2', '1', '0' )

   hDane['P_65_1'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_65_2'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '2', '1', '0' )
   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )
   hDane['P_67_1'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_67_2'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '2', '1', '0' )

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
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw11(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['P_62'] := iif( xmlWartoscH( hPozycje, 'P_62' ) == '1', '1', '0' )
   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )

   hDane['P_66_1'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_66_2'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '2', '1', '0' )
   hDane['P_67_1'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_67_2'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '2', '1', '0' )
   hDane['P_68_1'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_68_2'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '2', '1', '0' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_66' ) == '1'
      hDane[ 'VATZZ' ] := edekXmlVATZZ5( oDoc )
      hDane[ 'VATZZ' ][ 'rob' ] := .T.
      hDane[ 'VATZZ' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZZ' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZZ' ][ 'P_4' ] := hDane[ 'P_8_N' ] + hDane[ 'P_9_N' ]
      hDane[ 'VATZZ' ][ 'P_5' ] := hDane[ 'P_9_I' ]
      hDane[ 'VATZZ' ][ 'P_6' ] := hDane[ 'P_9_D' ]
      hDane[ 'VATZZ' ][ 'P_7' ] := hDane[ 'P_8_R' ]
   ELSE
      hDane[ 'VATZZ' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw12(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP', '' )
   IF hDane['P_1'] == ''
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )

   hDane['P_69_1'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_69_2'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '2', '1', '0' )
   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )
   hDane['P_71_1'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '1', '1', '0' )
   hDane['P_71_2'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '2', '1', '0' )

   hDane['P_74'] := xmlWartoscH( hPozycje, 'P_74' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_69' ) == '1'
      hDane[ 'VATZZ' ] := edekXmlVATZZ5( oDoc )
      hDane[ 'VATZZ' ][ 'rob' ] := .T.
      hDane[ 'VATZZ' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZZ' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZZ' ][ 'P_4' ] := hDane[ 'P_8_N' ] + hDane[ 'P_9_N' ]
      hDane[ 'VATZZ' ][ 'P_5' ] := hDane[ 'P_9_I' ]
      hDane[ 'VATZZ' ][ 'P_6' ] := hDane[ 'P_9_D' ]
      hDane[ 'VATZZ' ][ 'P_7' ] := hDane[ 'P_8_R' ]
   ELSE
      hDane[ 'VATZZ' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw13(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP', '' )
   IF hDane['P_1'] == ''
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )

   hDane['P_69_1'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_69_2'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '2', '1', '0' )

   hDane['P_72'] := xmlWartoscH( hPozycje, 'P_72' )
   hDane['P_73'] := xmlWartoscH( hPozycje, 'P_73' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_69' ) == '1'
      hDane[ 'VATZD' ] := edekXmlVATZD1( oDoc )
      hDane[ 'VATZD' ][ 'rob' ] := .T.
      hDane[ 'VATZD' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZD' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZD' ][ 'P_4' ] := hDane[ 'P_4' ]
      hDane[ 'VATZD' ][ 'P_5' ] := ''
      hDane[ 'VATZD' ][ 'P_6' ] := hDane[ 'P_5' ]
      hDane[ 'VATZD' ][ 'P_7' ] := '1'
      hDane[ 'VATZD' ][ 'P_8_1' ] := hDane[ 'P_8_1' ]
      hDane[ 'VATZD' ][ 'P_8_2' ] := hDane[ 'P_8_2' ]
      hDane[ 'VATZD' ][ 'P_9' ] := hDane[ 'P_9' ]
   ELSE
      hDane[ 'VATZD' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Kw14(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP', '' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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

   hDane['P_63'] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
   hDane['P_64'] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_69'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )

   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )

   hDane['P_73'] := xmlWartoscH( hPozycje, 'P_73' )
   hDane['P_74'] := xmlWartoscH( hPozycje, 'P_74' )

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
   ENDIF

   IF xmlWartoscH( hPozycje, 'P_70' ) == '1'
      hDane[ 'VATZD' ] := edekXmlVATZD1( oDoc )
      hDane[ 'VATZD' ][ 'rob' ] := .T.
      hDane[ 'VATZD' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZD' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZD' ][ 'P_4' ] := ''
      hDane[ 'VATZD' ][ 'P_5' ] := hDane[ 'P_4' ]
      hDane[ 'VATZD' ][ 'P_6' ] := hDane[ 'P_5' ]
      hDane[ 'VATZD' ][ 'P_7' ] := '1'
      hDane[ 'VATZD' ][ 'P_8_1' ] := hDane[ 'P_8_1' ]
      hDane[ 'VATZD' ][ 'P_8_2' ] := hDane[ 'P_8_2' ]
      hDane[ 'VATZD' ][ 'P_9' ] := hDane[ 'P_9' ]
   ELSE
      hDane[ 'VATZD' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Dw6(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   hDane['P_56_1'] := iif( xmlWartoscH( hPozycje, 'P_56' ) == '1', '1', '0' )
   hDane['P_56_2'] := iif( xmlWartoscH( hPozycje, 'P_56' ) == '2', '1', '0' )
   hDane['P_57'] := sxml2num( xmlWartoscH( hPozycje, 'P_57' ) )
   hDane['P_58'] := sxml2num( xmlWartoscH( hPozycje, 'P_58' ) )
   hDane['P_59'] := sxml2num( xmlWartoscH( hPozycje, 'P_59' ) )
   hDane['P_60'] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
   hDane['P_61'] := sxml2num( xmlWartoscH( hPozycje, 'P_61' ) )
   hDane['P_62'] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
   hDane['P_63'] := sxml2num( xmlWartoscH( hPozycje, 'P_63' ) )
   hDane['P_64'] := sxml2num( xmlWartoscH( hPozycje, 'P_64' ) )

   hDane['P_65'] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_69_1'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_69_2'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '2', '1', '0' )

   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )
   hDane['P_71_1'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '1', '1', '0' )
   hDane['P_71_2'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '2', '1', '0' )
   hDane['P_72_1'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '1', '1', '0' )
   hDane['P_72_2'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '2', '1', '0' )
   hDane['P_73_1'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '1', '1', '0' )
   hDane['P_73_2'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '2', '1', '0' )

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

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Dw7(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   hDane['P_57_1'] := iif( xmlWartoscH( hPozycje, 'P_57' ) == '1', '1', '0' )
   hDane['P_57_2'] := iif( xmlWartoscH( hPozycje, 'P_57' ) == '2', '1', '0' )
   hDane['P_58'] := sxml2num( xmlWartoscH( hPozycje, 'P_58' ) )
   hDane['P_59'] := sxml2num( xmlWartoscH( hPozycje, 'P_59' ) )
   hDane['P_60'] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
   hDane['P_61'] := sxml2num( xmlWartoscH( hPozycje, 'P_61' ) )
   hDane['P_62'] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
   hDane['P_63'] := sxml2num( xmlWartoscH( hPozycje, 'P_63' ) )
   hDane['P_64'] := sxml2num( xmlWartoscH( hPozycje, 'P_64' ) )
   hDane['P_65'] := sxml2num( xmlWartoscH( hPozycje, 'P_65' ) )

   hDane['P_66'] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
   hDane['P_67'] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_69'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_70_1'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_70_2'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '2', '1', '0' )

   hDane['P_71_1'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '1', '1', '0' )
   hDane['P_71_2'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '2', '1', '0' )
   hDane['P_72_1'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '1', '1', '0' )
   hDane['P_72_2'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '2', '1', '0' )
   hDane['P_73_1'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '1', '1', '0' )
   hDane['P_73_2'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '2', '1', '0' )
   hDane['P_74_1'] := iif( xmlWartoscH( hPozycje, 'P_74' ) == '1', '1', '0' )
   hDane['P_74_2'] := iif( xmlWartoscH( hPozycje, 'P_74' ) == '2', '1', '0' )

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

   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT7Dw8(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Kwartal' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
   hDane['P_59_1'] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '1', '1', '0' )
   hDane['P_59_2'] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '2', '1', '0' )
   hDane['P_60'] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
   hDane['P_61'] := sxml2num( xmlWartoscH( hPozycje, 'P_61' ) )
   hDane['P_62'] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
   hDane['P_63'] := sxml2num( xmlWartoscH( hPozycje, 'P_63' ) )
   hDane['P_64'] := sxml2num( xmlWartoscH( hPozycje, 'P_64' ) )
   hDane['P_65'] := sxml2num( xmlWartoscH( hPozycje, 'P_65' ) )
   hDane['P_66'] := sxml2num( xmlWartoscH( hPozycje, 'P_66' ) )
   hDane['P_67'] := sxml2num( xmlWartoscH( hPozycje, 'P_67' ) )

   hDane['P_68'] := iif( xmlWartoscH( hPozycje, 'P_68' ) == '1', '1', '0' )
   hDane['P_69'] := iif( xmlWartoscH( hPozycje, 'P_69' ) == '1', '1', '0' )
   hDane['P_70'] := iif( xmlWartoscH( hPozycje, 'P_70' ) == '1', '1', '0' )
   hDane['P_71'] := iif( xmlWartoscH( hPozycje, 'P_71' ) == '1', '1', '0' )

   hDane['P_72_1'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '1', '1', '0' )
   hDane['P_72_2'] := iif( xmlWartoscH( hPozycje, 'P_72' ) == '2', '1', '0' )
   hDane['P_73_1'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '1', '1', '0' )
   hDane['P_73_2'] := iif( xmlWartoscH( hPozycje, 'P_73' ) == '2', '1', '0' )
   hDane['P_74_1'] := iif( xmlWartoscH( hPozycje, 'P_74' ) == '1', '1', '0' )
   hDane['P_74_2'] := iif( xmlWartoscH( hPozycje, 'P_74' ) == '2', '1', '0' )
   hDane['P_75_1'] := iif( xmlWartoscH( hPozycje, 'P_75' ) == '1', '1', '0' )
   hDane['P_75_2'] := iif( xmlWartoscH( hPozycje, 'P_75' ) == '2', '1', '0' )

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

   ENDIF

   IF xmlWartoscH( hPozycje, 'P_72' ) == '1'
      hDane[ 'VATZZ' ] := edekXmlVATZZ5( oDoc )
      hDane[ 'VATZZ' ][ 'rob' ] := .T.
      hDane[ 'VATZZ' ][ 'P_1' ] := hDane[ 'P_1' ]
      hDane[ 'VATZZ' ][ 'P_2' ] := hDane[ 'P_2' ]
      hDane[ 'VATZZ' ][ 'P_4' ] := hDane[ 'P_8_N' ] + hDane[ 'P_9_N' ]
      hDane[ 'VATZZ' ][ 'P_5' ] := hDane[ 'P_9_I' ]
      hDane[ 'VATZZ' ][ 'P_6' ] := hDane[ 'P_9_D' ]
      hDane[ 'VATZZ' ][ 'P_7' ] := hDane[ 'P_8_R' ]
   ELSE
      hDane[ 'VATZZ' ] := hb_Hash( 'rob', .F. )
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT8w11(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

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
   hDane['P_25'] := iif( xmlWartoscH( hPozycje, 'P_25' ) == '1', '1', '0' )
   hDane['P_28'] := xmlWartoscH( hPozycje, 'P_28' )
   hDane['P_29'] := xmlWartoscH( hPozycje, 'P_29' )
   hDane['P_30'] := xmlWartoscH( hPozycje, 'P_30' )

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
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT9Mw10(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF

   hDane['P_10'] := sxml2num( xmlWartoscH( hPozycje, 'P_10' ) )
   hDane['P_11'] := sxml2num( xmlWartoscH( hPozycje, 'P_11' ) )
   hDane['P_12'] := sxml2num( xmlWartoscH( hPozycje, 'P_12' ) )
   hDane['P_13'] := sxml2num( xmlWartoscH( hPozycje, 'P_13' ) )
   hDane['P_14'] := sxml2num( xmlWartoscH( hPozycje, 'P_14' ) )
   hDane['P_15'] := sxml2num( xmlWartoscH( hPozycje, 'P_15' ) )
   hDane['P_16'] := sxml2num( xmlWartoscH( hPozycje, 'P_16' ) )
   hDane['P_17'] := sxml2num( xmlWartoscH( hPozycje, 'P_17' ) )
   hDane['P_18'] := sxml2num( xmlWartoscH( hPozycje, 'P_18' ) )
   hDane['P_19'] := iif( xmlWartoscH( hPozycje, 'P_19' ) == '1', '1', '0' )
   hDane['P_22'] := xmlWartoscH( hPozycje, 'P_22' )
   hDane['P_23'] := xmlWartoscH( hPozycje, 'P_23' )
   hDane['P_24'] := xmlWartoscH( hPozycje, 'P_24' )

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
   ENDIF

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VATUEw3(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VATUEw4(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_6'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   RETURN hDane

/*----------------------------------------------------------------------*/


FUNCTION DaneXML_VATUEKw4(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_6'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
      hPoz['P_DBa'] := xmlWartoscH( hPoz, 'P_DBa' )
      hPoz['P_DBb'] := xmlWartoscH( hPoz, 'P_DBb' )
      hPoz['P_DBc'] := xmlWartoscH( hPoz, 'P_DBc' )
      hPoz['P_DBd'] := xmlWartoscH( hPoz, 'P_DBd' )
      hPoz['P_DJa'] := xmlWartoscH( hPoz, 'P_DJa' )
      hPoz['P_DJb'] := xmlWartoscH( hPoz, 'P_DJb' )
      hPoz['P_DJc'] := xmlWartoscH( hPoz, 'P_DJc' )
      hPoz['P_DJd'] := xmlWartoscH( hPoz, 'P_DJd' )
      IF hPoz['P_DBd'] == '2'
         hPoz['P_DBd1'] := '1'
      ELSE
         hPoz['P_DBd1'] := '0'
      ENDIF
      IF hPoz['P_DJd'] == '2'
         hPoz['P_DJd1'] := '1'
      ELSE
         hPoz['P_DJd1'] := '0'
      ENDIF
   })
   IF Len( aGrupa1 ) == 0
      AAdd(aGrupa1, hb_Hash( 'pusty', '1', 'P_DBa', '', 'P_DBb', '', 'P_DBc', '', 'P_DBd', '0', 'P_DBd1', '0', 'P_DJa', '', 'P_DJb', '', 'P_DJc', '', 'P_DJd', '0', 'P_DJd1', '0' ) )
   ENDIF
   hDane['Grupa1'] := aGrupa1

   AEval(aGrupa2, {|hPoz|
      hPoz['pusty'] := '0'
      hPoz['P_NBa'] := xmlWartoscH( hPoz, 'P_NBa' )
      hPoz['P_NBb'] := xmlWartoscH( hPoz, 'P_NBb' )
      hPoz['P_NBc'] := xmlWartoscH( hPoz, 'P_NBc' )
      hPoz['P_NBd'] := xmlWartoscH( hPoz, 'P_NBd' )
      hPoz['P_NJa'] := xmlWartoscH( hPoz, 'P_NJa' )
      hPoz['P_NJb'] := xmlWartoscH( hPoz, 'P_NJb' )
      hPoz['P_NJc'] := xmlWartoscH( hPoz, 'P_NJc' )
      hPoz['P_NJd'] := xmlWartoscH( hPoz, 'P_NJd' )
      IF hPoz['P_NBd'] == '2'
         hPoz['P_NBd1'] := '1'
      ELSE
         hPoz['P_NBd1'] := '0'
      ENDIF
      IF hPoz['P_NJd'] == '2'
         hPoz['P_NJd1'] := '1'
      ELSE
         hPoz['P_NJd1'] := '0'
      ENDIF
   })
   IF Len( aGrupa2 ) == 0
      AAdd(aGrupa2, hb_Hash( 'pusty', '1', 'P_NBa', '', 'P_NBb', '', 'P_NBc', '', 'P_NBd', '0', 'P_DNd1', '0', 'P_NJa', '', 'P_NJb', '', 'P_NJc', '', 'P_NJd', '0', 'P_NJd1', '0' ) )
   ENDIF
   hDane['Grupa2'] := aGrupa2

   AEval(aGrupa3, {|hPoz|
      hPoz['pusty'] := '0'
      hPoz['P_UBa'] := xmlWartoscH( hPoz, 'P_UBa' )
      hPoz['P_UBb'] := xmlWartoscH( hPoz, 'P_UBb' )
      hPoz['P_UBc'] := xmlWartoscH( hPoz, 'P_UBc' )
      hPoz['P_UJa'] := xmlWartoscH( hPoz, 'P_UJa' )
      hPoz['P_UJb'] := xmlWartoscH( hPoz, 'P_UJb' )
      hPoz['P_UJc'] := xmlWartoscH( hPoz, 'P_UJc' )
   })
   IF Len( aGrupa3 ) == 0
      AAdd(aGrupa3, hb_Hash( 'pusty', '1', 'P_UBa', '', 'P_UBb', '', 'P_UBc', '', 'P_UJa', '', 'P_UJb', '', 'P_UJc', '' ) )
   ENDIF
   hDane['Grupa3'] := aGrupa3

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VATUEw5(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3, aGrupa4
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )
   aGrupa1 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa1' )
   aGrupa2 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa2' )
   aGrupa3 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa3' )
   aGrupa4 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa4' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_6'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   AEval(aGrupa4, {|hPoz|
      hPoz['pusty'] := '0'
      IF ! hb_HHasKey( hPoz, 'P_Cc' )
         hPoz[ 'P_Cc' ] := ""
      ENDIF
      IF ! hb_HHasKey( hPoz, 'P_Cd' )
         hPoz[ 'P_Cd' ] := '1'
      ENDIF
      IF hPoz['P_Cd'] == '2'
         hPoz['P_Cdl'] := '1'
      ELSE
         hPoz['P_Cdl'] := '0'
      ENDIF
   })
   AAdd(aGrupa4, hb_Hash('pusty', '1', 'P_Ca', '', 'P_Cb', '', 'P_Cc', '', 'P_Cd', '0', 'P_Cdl', '0'))
   hDane['Grupa4'] := aGrupa4

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VATUEKw5(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2, aGrupa3, aGrupa4
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )
   aGrupa1 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa1' )
   aGrupa2 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa2' )
   aGrupa3 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa3' )
   aGrupa4 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa4' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_6'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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
      hPoz['P_DBa'] := xmlWartoscH( hPoz, 'P_DBa' )
      hPoz['P_DBb'] := xmlWartoscH( hPoz, 'P_DBb' )
      hPoz['P_DBc'] := xmlWartoscH( hPoz, 'P_DBc' )
      hPoz['P_DBd'] := xmlWartoscH( hPoz, 'P_DBd' )
      hPoz['P_DJa'] := xmlWartoscH( hPoz, 'P_DJa' )
      hPoz['P_DJb'] := xmlWartoscH( hPoz, 'P_DJb' )
      hPoz['P_DJc'] := xmlWartoscH( hPoz, 'P_DJc' )
      hPoz['P_DJd'] := xmlWartoscH( hPoz, 'P_DJd' )
      IF hPoz['P_DBd'] == '2'
         hPoz['P_DBd1'] := '1'
      ELSE
         hPoz['P_DBd1'] := '0'
      ENDIF
      IF hPoz['P_DJd'] == '2'
         hPoz['P_DJd1'] := '1'
      ELSE
         hPoz['P_DJd1'] := '0'
      ENDIF
   })
   IF Len( aGrupa1 ) == 0
      AAdd(aGrupa1, hb_Hash( 'pusty', '1', 'P_DBa', '', 'P_DBb', '', 'P_DBc', '', 'P_DBd', '0', 'P_DBd1', '0', 'P_DJa', '', 'P_DJb', '', 'P_DJc', '', 'P_DJd', '0', 'P_DJd1', '0' ) )
   ENDIF
   hDane['Grupa1'] := aGrupa1

   AEval(aGrupa2, {|hPoz|
      hPoz['pusty'] := '0'
      hPoz['P_NBa'] := xmlWartoscH( hPoz, 'P_NBa' )
      hPoz['P_NBb'] := xmlWartoscH( hPoz, 'P_NBb' )
      hPoz['P_NBc'] := xmlWartoscH( hPoz, 'P_NBc' )
      hPoz['P_NBd'] := xmlWartoscH( hPoz, 'P_NBd' )
      hPoz['P_NJa'] := xmlWartoscH( hPoz, 'P_NJa' )
      hPoz['P_NJb'] := xmlWartoscH( hPoz, 'P_NJb' )
      hPoz['P_NJc'] := xmlWartoscH( hPoz, 'P_NJc' )
      hPoz['P_NJd'] := xmlWartoscH( hPoz, 'P_NJd' )
      IF hPoz['P_NBd'] == '2'
         hPoz['P_NBd1'] := '1'
      ELSE
         hPoz['P_NBd1'] := '0'
      ENDIF
      IF hPoz['P_NJd'] == '2'
         hPoz['P_NJd1'] := '1'
      ELSE
         hPoz['P_NJd1'] := '0'
      ENDIF
   })
   IF Len( aGrupa2 ) == 0
      AAdd(aGrupa2, hb_Hash( 'pusty', '1', 'P_NBa', '', 'P_NBb', '', 'P_NBc', '', 'P_NBd', '0', 'P_DNd1', '0', 'P_NJa', '', 'P_NJb', '', 'P_NJc', '', 'P_NJd', '0', 'P_NJd1', '0' ) )
   ENDIF
   hDane['Grupa2'] := aGrupa2

   AEval(aGrupa3, {|hPoz|
      hPoz['pusty'] := '0'
      hPoz['P_UBa'] := xmlWartoscH( hPoz, 'P_UBa' )
      hPoz['P_UBb'] := xmlWartoscH( hPoz, 'P_UBb' )
      hPoz['P_UBc'] := xmlWartoscH( hPoz, 'P_UBc' )
      hPoz['P_UJa'] := xmlWartoscH( hPoz, 'P_UJa' )
      hPoz['P_UJb'] := xmlWartoscH( hPoz, 'P_UJb' )
      hPoz['P_UJc'] := xmlWartoscH( hPoz, 'P_UJc' )
   })
   IF Len( aGrupa3 ) == 0
      AAdd(aGrupa3, hb_Hash( 'pusty', '1', 'P_UBa', '', 'P_UBb', '', 'P_UBc', '', 'P_UJa', '', 'P_UJb', '', 'P_UJc', '' ) )
   ENDIF
   hDane['Grupa3'] := aGrupa3

   AEval(aGrupa4, {|hPoz|
      hPoz['pusty'] := '0'
      hPoz['P_CBa'] := xmlWartoscH( hPoz, 'P_CBa' )
      hPoz['P_CBb'] := xmlWartoscH( hPoz, 'P_CBb' )
      hPoz['P_CBc'] := xmlWartoscH( hPoz, 'P_CBc', "" )
      hPoz['P_CBd'] := xmlWartoscH( hPoz, 'P_CBd', "1" )
      hPoz['P_CJa'] := xmlWartoscH( hPoz, 'P_CJa' )
      hPoz['P_CJb'] := xmlWartoscH( hPoz, 'P_CJb' )
      hPoz['P_CJc'] := xmlWartoscH( hPoz, 'P_CJc', "" )
      hPoz['P_CJd'] := xmlWartoscH( hPoz, 'P_CJd', "1" )
      IF hPoz['P_CBd'] == '2'
         hPoz['P_CBdl'] := '1'
      ELSE
         hPoz['P_CBdl'] := '0'
      ENDIF
      IF hPoz['P_CJd'] == '2'
         hPoz['P_CJdl'] := '1'
      ELSE
         hPoz['P_CJdl'] := '0'
      ENDIF
   })
   IF Len( aGrupa4 ) == 0
      AAdd(aGrupa4, hb_Hash( 'pusty', '1', 'P_CBa', '', 'P_CBb', '', 'P_CBc', '', 'P_CBd', '0', 'P_CBdl', '0', 'P_CJa', '', 'P_CJb', '', 'P_CJc', '', 'P_CJd', '0', 'P_CJdl', '0' ) )
   ENDIF
   hDane['Grupa4'] := aGrupa4

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VIUDOw1( oDoc, cNrRef, hNaglowek )

   LOCAL hDane := {=>}, hPodmiot1, hPozycje, oElement
   LOCAL cKraj, aPoz, oNastEl, oIter1, oAktEl

   IF ! HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF

   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hDane[ 'P_1' ] := hPodmiot1[ 'dto:NIP' ]
   hDane[ 'P_2' ] := iif( HB_ISCHAR( cNrRef ), cNrRef, '' )
   hDane[ 'P_3' ] := ''
   hDane[ 'P_4' ] := hNaglowek[ 'Kwartal' ]
   hDane[ 'P_5' ] := hNaglowek[ 'Rok' ]
   hDane[ 'P_6' ] := KodUS2Nazwa( xmlWartoscH( hNaglowek, 'KodUrzedu', '' ) )
   hDane[ 'P_7_1' ] := iif( hNaglowek[ 'CelZlozenia' ] == '1', '1', '0' )
   hDane[ 'P_7_2' ] := iif( hNaglowek[ 'CelZlozenia' ] == '2', '1', '0' )
   hDane[ 'P_8' ] := hNaglowek[ 'DataWypelnienia' ]
   hDane[ 'P_9_1' ] := iif( hPodmiot1[ 'OsobaFizyczna' ], '0', '1' )
   hDane[ 'P_9_2' ] := iif( hPodmiot1[ 'OsobaFizyczna' ], '1', '0' )
   hDane[ 'P_10' ] := iif( hPodmiot1[ 'OsobaFizyczna' ], ;
      hPodmiot1[ 'dto:Nazwisko' ] + '    ' + hPodmiot1[ 'dto:ImiePierwsze' ], ;
      hPodmiot1[ 'dto:PelnaNazwa' ] )

   hPozycje := edekXmlGrupa( oDoc, 'Period' )
   hDane[ 'P_11' ] := xmlWartoscH( hPozycje, 'dto:StartDate' , '' )
   hDane[ 'P_12' ] := xmlWartoscH( hPozycje, 'dto:EndDate', '' )

   hDane[ 'SekcjaC2' ] := {}
   oElement := oDoc:FindFirst( 'MSIDSupplies' )
   DO WHILE ! Empty( oElement )
      cKraj := oElement:oChild:cData
      oIter1 := TXMLIteratorScan():New( oElement )
      oNastEl := oIter1:Find( 'dto:OSSVATReturnDetail' )
      DO WHILE ! Empty( oNastEl )
         aPoz := { 'kraj' => KrajUENazwa( cKraj ) }

         oNastEl := oNastEl:oChild
         aPoz[ 'rodzaj' ] := iif( oNastEl:cData == 'GOODS', 'Dostawa towar¢w', '—wiadczenie usˆug' )

         oNastEl := oNastEl:oNext
         aPoz[ 'stawkard' ] := iif( oNastEl:aAttributes[ 'type' ] == 'STANDARD', 'Podstawowa', 'Obni¾ona' )
         aPoz[ 'stawka' ] := Val( oNastEl:cData )

         oNastEl := oNastEl:oNext
         aPoz[ 'nettoeur' ] := Val( oNastEl:cData )

         oNastEl := oNastEl:oNext
         aPoz[ 'vateur' ] := Val( oNastEl:cData )

         AAdd( hDane[ 'SekcjaC2' ], aPoz )
         oNastEl := oIter1:Next()
      ENDDO
      oElement := oDoc:FindNext()
   ENDDO

   oElement := oDoc:FindFirst( 'GrandTotalMSIDServices' )
   hDane [ 'P_13' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   oElement := oDoc:FindFirst( 'GrandTotalMSIDGoods' )
   hDane [ 'P_14' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   hDane[ 'SekcjaC3' ] := {}
   oElement := oDoc:FindFirst( 'MSESTSupplies' )
   DO WHILE ! Empty( oElement )
      cKraj := oElement:oChild:cData
      oIter1 := TXMLIteratorScan():New( oElement )
      oAktEl := oIter1:Find( 'MSESTSupply' )
      DO WHILE ! Empty( oAktEl )
         aPoz := { 'kraj' => KrajUENazwa( cKraj ) }

         oNastEl := oAktel:oChild:oChild:oChild
         aPoz[ 'krajdz' ] := KrajUENazwa( oNastEl:aAttributes[ 'issuedBy' ] )
         IF oNastEl:cName == 'dto:VATIdentificationNumber'
            aPoz[ 'nr_idvat' ] := oNastEl:cData
            aPoz[ 'nr_idpod' ] := ''
         ELSE
            aPoz[ 'nr_idvat' ] := ''
            aPoz[ 'nr_idpod' ] := oNastEl:cData
         ENDIF

         oNastEl := oAktEl:oChild:oChild:oNext:oChild
         aPoz[ 'rodzaj' ] := iif( oNastEl:cData == 'GOODS', 'Dostawa towar¢w', '—wiadczenie usˆug' )

         oNastEl := oNastEl:oNext
         aPoz[ 'stawkard' ] := iif( oNastEl:aAttributes[ 'type' ] == 'STANDARD', 'Podstawowa', 'Obni¾ona' )
         aPoz[ 'stawka' ] := Val( oNastEl:cData )

         oNastEl := oNastEl:oNext
         aPoz[ 'nettoeur' ] := Val( oNastEl:cData )

         oNastEl := oNastEl:oNext
         aPoz[ 'vateur' ] := Val( oNastEl:cData )

         AAdd( hDane[ 'SekcjaC3' ], aPoz )
         oAktEl := oIter1:Next()
      ENDDO
      oElement := oDoc:FindNext()
   ENDDO

   oElement := oDoc:FindFirst( 'GrandTotalMSESTServices' )
   hDane [ 'P_15' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   oElement := oDoc:FindFirst( 'GrandTotalMSESTGoods' )
   hDane [ 'P_16' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   oElement := oDoc:FindFirst( 'GrandTotal' )
   hDane [ 'P_17' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   hDane[ 'SekcjaC5' ] := {}
   oElement := oDoc:FindFirst( 'Corrections' )
   DO WHILE ! Empty( oElement )
      cKraj := oElement:oChild:cData
      oIter1 := TXMLIteratorScan():New( oElement )
      oAktEl := oIter1:Find( 'dto:Correction' )
      DO WHILE ! Empty( oAktEl )
         aPoz := { 'kraj' => KrajUENazwa( cKraj ) }

         oNastEl := oAktEl:oChild:oChild
         aPoz[ 'rok' ] := oNastEl:cData

         oNastEl := oNastEl:oNext
         aPoz[ 'kwartal' ] := oNastEl:cData

         oNastEl := oAktEl:oChild:oNext
         aPoz[ 'kwota' ] := Val( oNastEl:cData )

         AAdd( hDane[ 'SekcjaC5' ], aPoz )
         oAktEl := oIter1:Next()
      ENDDO
      oElement := oDoc:FindNext()
   ENDDO

   hDane[ 'SekcjaC6' ] := {}
   oElement := oDoc:FindFirst( 'MSCONBalance' )
   DO WHILE ! Empty( oElement )
      AAdd( hDane[ 'SekcjaC6' ], { ;
         'kraj' => KrajUENazwa( oElement:oChild:cData ), ;
         'kwota' => Val( oElement:oChild:oNext:cData ) ;
      } )
      oElement := oDoc:FindNext()
   ENDDO

   oElement := oDoc:FindFirst( 'TotalAmountOfVATDue' )
   hDane [ 'P_18' ] := iif( ! Empty( oElement ), Val( oElement:cData ), 0 )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT27w1(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
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
   hDane['P_9_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_9_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_VAT27w2(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, cTmp, aGrupa1, aGrupa2
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )
   aGrupa1 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa_C' )
   aGrupa2 := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'Grupa_D' )

   hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := sxml2num( xmlWartoscH( hNaglowek, 'Miesiac' ) )
   hDane['P_5'] := sxml2num( xmlWartoscH( hNaglowek, 'Rok' ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_7'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_8_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_9_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_9_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_10'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ',      ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
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

   hDane['Grupa1Sum'] := 0
   AEval(aGrupa1, { | hPoz |
      hPoz['P_C4'] := iif(HB_ISSTRING(hPoz['P_C4']), Val(hPoz['P_C4']), 0.0)
      hDane['Grupa1Sum'] := hDane['Grupa1Sum'] + hPoz['P_C4']
      hPoz['pusty'] := '0'
      IF ! hb_HHasKey( hPoz, 'P_C1' )
         hPoz[ 'P_C1' ] := '0'
      ENDIF
   })
   AAdd(aGrupa1, hb_Hash('pusty', '1', 'P_C2', '', 'P_C3', '', 'P_C4', 0))
   hDane['Grupa1'] := aGrupa1
   hDane['Grupa2Sum'] := 0
   AEval(aGrupa2, { | hPoz |
      hPoz['P_D4'] := iif(HB_ISSTRING(hPoz['P_D4']), Val(hPoz['P_D4']), 0.0)
      hDane['Grupa2Sum'] := hDane['Grupa2Sum'] + hPoz['P_D4']
      hPoz['pusty'] := '0'
      IF ! hb_HHasKey( hPoz, 'P_D1' )
         hPoz[ 'P_D1' ] := '0'
      ENDIF
   })
   AAdd(aGrupa2, hb_Hash('pusty', '1', 'P_D2', '', 'P_D3', '', 'P_D4', 0))
   hDane['Grupa2'] := aGrupa2

   hDane['P_PODPIS_IMIE'] := ''
   hDane['P_PODPIS_NAZWISKO'] := ''
   hDane['P_PODPIS_TEL'] := ''
   hDane['P_PODPIS_DATA'] := ''

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_IFT1w13(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane[ 'ROCZNY' ] := iif( At( 'IFT-1R', hNaglowek[ 'KodFormularza:kodSystemowy' ] ) > 0, '1', '0' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xml2date( xmlWartoscH( hNaglowek, 'OkresOd', DToS( Date() ) ) )
   hDane['P_5'] := xml2date( xmlWartoscH( hNaglowek, 'OkresDo', DToS( Date() ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'Nazwisko' ) + ', ' + xmlWartoscH( hPodmiot1, 'ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'etd:PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'etd:REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10'] := 'POLSKA'
   hDane['P_11'] := xmlWartoscH( hPodmiot1, 'etd:Wojewodztwo', '' )
   hDane['P_12'] := xmlWartoscH( hPodmiot1, 'etd:Powiat', '' )
   hDane['P_13'] := xmlWartoscH( hPodmiot1, 'etd:Gmina', '' )
   hDane['P_14'] := xmlWartoscH( hPodmiot1, 'etd:Ulica', '' )
   hDane['P_15'] := xmlWartoscH( hPodmiot1, 'etd:NrDomu', '' )
   hDane['P_16'] := xmlWartoscH( hPodmiot1, 'etd:NrLokalu', '' )
   hDane['P_17'] := xmlWartoscH( hPodmiot1, 'etd:Miejscowosc', '' )
   hDane['P_18'] := xmlWartoscH( hPodmiot1, 'etd:KodPocztowy', '' )
   hDane['P_19'] := xmlWartoscH( hPodmiot1, 'etd:Poczta', '' )

   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'Nazwisko' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'ImiePierwsze' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'ImieOjca' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'ImieMatki' )
   hDane['P_24'] := xml2date( xmlWartoscH( hPodmiot2, 'DataUrodzenia', Date() ) )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'MiejsceUrodzenia' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_27'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_28'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_29'] := xmlWartoscH( hPodmiot2, 'etd:KodKraju' )
   hDane['P_30'] := xmlWartoscH( hPodmiot2, 'etd:Miejscowosc' )
   hDane['P_31'] := xmlWartoscH( hPodmiot2, 'etd:KodPocztowy' )
   hDane['P_32'] := xmlWartoscH( hPodmiot2, 'etd:Ulica' )
   hDane['P_33'] := xmlWartoscH( hPodmiot2, 'etd:NrDomu' )
   hDane['P_34'] := xmlWartoscH( hPodmiot2, 'etd:NrLokalu' )

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

   hDane['P_75'] := xml2date( xmlWartoscH( hPozycje, 'P_75' ) )
   hDane['P_76'] := xml2date( xmlWartoscH( hPozycje, 'P_76' ) )

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

      hDane['ORDZU']['ORDZU_9'] := hDane['P_20']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_21']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_24']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_IFT1w15(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane[ 'ROCZNY' ] := iif( At( 'IFT-1R', hNaglowek[ 'KodFormularza:kodSystemowy' ] ) > 0, '1', '0' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xml2date( xmlWartoscH( hNaglowek, 'OkresOd', DToS( Date() ) ) )
   hDane['P_5'] := xml2date( xmlWartoscH( hNaglowek, 'OkresDo', DToS( Date() ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ', ' + xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10'] := 'POLSKA'
   hDane['P_11'] := xmlWartoscH( hPodmiot1, 'etd:Wojewodztwo', '' )
   hDane['P_12'] := xmlWartoscH( hPodmiot1, 'etd:Powiat', '' )
   hDane['P_13'] := xmlWartoscH( hPodmiot1, 'etd:Gmina', '' )
   hDane['P_14'] := xmlWartoscH( hPodmiot1, 'etd:Ulica', '' )
   hDane['P_15'] := xmlWartoscH( hPodmiot1, 'etd:NrDomu', '' )
   hDane['P_16'] := xmlWartoscH( hPodmiot1, 'etd:NrLokalu', '' )
   hDane['P_17'] := xmlWartoscH( hPodmiot1, 'etd:Miejscowosc', '' )
   hDane['P_18'] := xmlWartoscH( hPodmiot1, 'etd:KodPocztowy', '' )
   //hDane['P_19'] := xmlWartoscH( hPodmiot1, 'etd:Poczta', '' )

   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'Nazwisko' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'ImiePierwsze' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'ImieOjca' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'ImieMatki' )
   hDane['P_23'] := xml2date( xmlWartoscH( hPodmiot2, 'DataUrodzenia', Date() ) )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'MiejsceUrodzenia' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_26'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_28'] := xmlWartoscH( hPodmiot2, 'etd:KodKraju' )
   hDane['P_29'] := xmlWartoscH( hPodmiot2, 'etd:Miejscowosc' )
   hDane['P_30'] := xmlWartoscH( hPodmiot2, 'etd:KodPocztowy' )
   hDane['P_31'] := xmlWartoscH( hPodmiot2, 'etd:Ulica' )
   hDane['P_32'] := xmlWartoscH( hPodmiot2, 'etd:NrDomu' )
   hDane['P_33'] := xmlWartoscH( hPodmiot2, 'etd:NrLokalu' )

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

   hDane['P_74'] := xml2date( xmlWartoscH( hPozycje, 'P_74' ), '' )
   hDane['P_75'] := xml2date( xmlWartoscH( hPozycje, 'P_75' ), '' )

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

      hDane['ORDZU']['ORDZU_9'] := hDane['P_19']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_20']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_23']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_IFT1w16(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje, aSekD
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane[ 'ROCZNY' ] := iif( At( 'IFT-1R', hNaglowek[ 'KodFormularza:kodSystemowy' ] ) > 0, '1', '0' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xml2date( xmlWartoscH( hNaglowek, 'OkresOd', DToS( Date() ) ) )
   hDane['P_5'] := xml2date( xmlWartoscH( hNaglowek, 'OkresDo', DToS( Date() ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ', ' + xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10'] := 'POLSKA'
   hDane['P_11'] := xmlWartoscH( hPodmiot1, 'etd:Wojewodztwo', '' )
   hDane['P_12'] := xmlWartoscH( hPodmiot1, 'etd:Powiat', '' )
   hDane['P_13'] := xmlWartoscH( hPodmiot1, 'etd:Gmina', '' )
   hDane['P_14'] := xmlWartoscH( hPodmiot1, 'etd:Ulica', '' )
   hDane['P_15'] := xmlWartoscH( hPodmiot1, 'etd:NrDomu', '' )
   hDane['P_16'] := xmlWartoscH( hPodmiot1, 'etd:NrLokalu', '' )
   hDane['P_17'] := xmlWartoscH( hPodmiot1, 'etd:Miejscowosc', '' )
   hDane['P_18'] := xmlWartoscH( hPodmiot1, 'etd:KodPocztowy', '' )
   //hDane['P_19'] := xmlWartoscH( hPodmiot1, 'etd:Poczta', '' )

   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'Nazwisko' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'ImiePierwsze' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'ImieOjca' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'ImieMatki' )
   hDane['P_23'] := xml2date( xmlWartoscH( hPodmiot2, 'DataUrodzenia', Date() ) )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'MiejsceUrodzenia' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'NrId' )
   hDane['P_26'] := PracDokRodzajStr( xmlWartoscH( hPodmiot2, 'RodzajNrId' ) )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_28'] := xmlWartoscH( hPodmiot2, 'etd:KodKraju' )
   hDane['P_29'] := xmlWartoscH( hPodmiot2, 'etd:Miejscowosc' )
   hDane['P_30'] := xmlWartoscH( hPodmiot2, 'etd:KodPocztowy' )
   hDane['P_31'] := xmlWartoscH( hPodmiot2, 'etd:Ulica' )
   hDane['P_32'] := xmlWartoscH( hPodmiot2, 'etd:NrDomu' )
   hDane['P_33'] := xmlWartoscH( hPodmiot2, 'etd:NrLokalu' )

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

   aSekD := edekXmlGrupaTab( oDoc, 'PozycjeSzczegolowe', 'P_D' )
   IF Len( aSekD ) > 0
      hDane['P_70'] := sxml2num( xmlWartoscH( aSekD[ 1 ], 'P_D70' ) )
      hDane['P_71'] := sxml2num( xmlWartoscH( aSekD[ 1 ], 'P_D71' ) )
      hDane['P_72'] := sxml2num( xmlWartoscH( aSekD[ 1 ], 'P_D72' ) )
      hDane['P_73'] := sxml2num( xmlWartoscH( aSekD[ 1 ], 'P_D73' ) )
   ELSE
      hDane['P_70'] := 0
      hDane['P_71'] := 0
      hDane['P_72'] := 0
      hDane['P_73'] := 0
   ENDIF

   hDane['P_74'] := xml2date( xmlWartoscH( hPozycje, 'P_74' ), '' )
   hDane['P_75'] := xml2date( xmlWartoscH( hPozycje, 'P_75' ), '' )

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

      hDane['ORDZU']['ORDZU_9'] := hDane['P_19']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_20']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_23']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_IFT2w9(oDoc, cNrRef, hNaglowek)
   LOCAL hPodmiot1, hPodmiot2, cTmp, hPozycje
   LOCAL hDane := hb_Hash()
   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF
   hPodmiot1 := edekXmlPodmiot1( oDoc )
   hPodmiot2 := edekXmlPodmiot2( oDoc )

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   hDane[ 'ROCZNY' ] := iif( At( 'IFT-2R', hNaglowek[ 'KodFormularza:kodSystemowy' ] ) > 0, '1', '0' )
   hDane['P_2'] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )
   hDane['P_4'] := xml2date( xmlWartoscH( hNaglowek, 'OkresOd', DToS( Date() ) ) )
   hDane['P_5'] := xml2date( xmlWartoscH( hNaglowek, 'OkresDo', DToS( Date() ) ) )
   cTmp := xmlWartoscH( hNaglowek, 'KodUrzedu' )
   hDane['P_6'] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane['P_7_1'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane['P_7_2'] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane['P_8_1'] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane['P_8_2'] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'DataUrodzenia' )
      hDane['P_8_N'] := ''
      hDane['P_8_R'] := ''
      hDane['P_9_N'] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane['P_9_I'] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane['P_9_D'] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
   ELSE
      hDane['P_1'] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane['P_9'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' ) + ', ' + xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_8_N'] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane['P_8_R'] := xmlWartoscH( hPodmiot1, 'REGON' )
      hDane['P_9_N'] := ''
      hDane['P_9_I'] := ''
      hDane['P_9_D'] := ''
   ENDIF
   hDane['P_10'] := 'POLSKA'
   hDane['P_11'] := xmlWartoscH( hPodmiot1, 'etd:Wojewodztwo', '' )
   hDane['P_12'] := xmlWartoscH( hPodmiot1, 'etd:Powiat', '' )
   hDane['P_13'] := xmlWartoscH( hPodmiot1, 'etd:Gmina', '' )
   hDane['P_14'] := xmlWartoscH( hPodmiot1, 'etd:Ulica', '' )
   hDane['P_15'] := xmlWartoscH( hPodmiot1, 'etd:NrDomu', '' )
   hDane['P_16'] := xmlWartoscH( hPodmiot1, 'etd:NrLokalu', '' )
   hDane['P_17'] := xmlWartoscH( hPodmiot1, 'etd:Miejscowosc', '' )
   hDane['P_18'] := xmlWartoscH( hPodmiot1, 'etd:KodPocztowy', '' )
   //hDane['P_19'] := xmlWartoscH( hPodmiot1, 'etd:Poczta', '' )

   hDane['P_19'] := xmlWartoscH( hPodmiot2, 'etd:NIP' )
   hDane['P_20'] := xmlWartoscH( hPodmiot2, 'etd:PelnaNazwa' )
   hDane['P_21'] := xmlWartoscH( hPodmiot2, 'etd:SkroconaNazwa' )
   hDane['P_22'] := xmlWartoscH( hPodmiot2, 'DataRozpoczeciaDzialalnosci', '' )
   hDane['P_23'] := xmlWartoscH( hPodmiot2, 'RodzajIdentyfikacji' )
   hDane['P_23_1'] := iif( hDane['P_23' ] == '1', '1', '0' )
   hDane['P_23_2'] := iif( hDane['P_23' ] == '2', '1', '0' )
   hDane['P_24'] := xmlWartoscH( hPodmiot2, 'NumerIdentyfikacyjnyPodatnika' )
   hDane['P_25'] := xmlWartoscH( hPodmiot2, 'KodKrajuWydania' )
   hDane['P_26'] := xmlWartoscH( hPodmiot2, 'KodKraju' )
   hDane['P_27'] := xmlWartoscH( hPodmiot2, 'Miejscowosc' )
   hDane['P_28'] := xmlWartoscH( hPodmiot2, 'KodPocztowy' )
   hDane['P_29'] := xmlWartoscH( hPodmiot2, 'Ulica' )
   hDane['P_30'] := xmlWartoscH( hPodmiot2, 'NrDomu' )
   hDane['P_31'] := xmlWartoscH( hPodmiot2, 'NrLokalu' )

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

   hDane['P_117'] := xml2date( xmlWartoscH( hPozycje, 'P_117' ), '' )
   hDane['P_118'] := xml2date( xmlWartoscH( hPozycje, 'P_118' ), '' )

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

      hDane['ORDZU']['ORDZU_9'] := hDane['P_19']
      hDane['ORDZU']['ORDZU_10'] := hDane['P_20']
      hDane['ORDZU']['ORDZU_11'] := hDane['P_23']

   ENDIF

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKVATw2( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'KodPocztowy' )
   aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'Poczta' )

   aDane[ 'Sprzedaz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'SprzedazWiersz' )
   AEval( aDane[ 'Sprzedaz' ], { | aPoz |
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
      aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
      aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
      aPoz[ 'K_15' ] := sxml2num( xmlWartoscH( aPoz, 'K_15' ), 0 )
      aPoz[ 'K_16' ] := sxml2num( xmlWartoscH( aPoz, 'K_16' ), 0 )
      aPoz[ 'K_17' ] := sxml2num( xmlWartoscH( aPoz, 'K_17' ), 0 )
      aPoz[ 'K_18' ] := sxml2num( xmlWartoscH( aPoz, 'K_18' ), 0 )
      aPoz[ 'K_19' ] := sxml2num( xmlWartoscH( aPoz, 'K_19' ), 0 )
      aPoz[ 'K_20' ] := sxml2num( xmlWartoscH( aPoz, 'K_20' ), 0 )
      aPoz[ 'K_21' ] := sxml2num( xmlWartoscH( aPoz, 'K_21' ), 0 )
      aPoz[ 'K_22' ] := sxml2num( xmlWartoscH( aPoz, 'K_22' ), 0 )
      aPoz[ 'K_23' ] := sxml2num( xmlWartoscH( aPoz, 'K_23' ), 0 )
      aPoz[ 'K_24' ] := sxml2num( xmlWartoscH( aPoz, 'K_24' ), 0 )
      aPoz[ 'K_25' ] := sxml2num( xmlWartoscH( aPoz, 'K_25' ), 0 )
      aPoz[ 'K_26' ] := sxml2num( xmlWartoscH( aPoz, 'K_26' ), 0 )
      aPoz[ 'K_27' ] := sxml2num( xmlWartoscH( aPoz, 'K_27' ), 0 )
      aPoz[ 'K_28' ] := sxml2num( xmlWartoscH( aPoz, 'K_28' ), 0 )
      aPoz[ 'K_29' ] := sxml2num( xmlWartoscH( aPoz, 'K_29' ), 0 )
      aPoz[ 'K_30' ] := sxml2num( xmlWartoscH( aPoz, 'K_30' ), 0 )
      aPoz[ 'K_31' ] := sxml2num( xmlWartoscH( aPoz, 'K_31' ), 0 )
      aPoz[ 'K_32' ] := sxml2num( xmlWartoscH( aPoz, 'K_32' ), 0 )
      aPoz[ 'K_33' ] := sxml2num( xmlWartoscH( aPoz, 'K_33' ), 0 )
      aPoz[ 'K_34' ] := sxml2num( xmlWartoscH( aPoz, 'K_34' ), 0 )
      aPoz[ 'K_35' ] := sxml2num( xmlWartoscH( aPoz, 'K_35' ), 0 )
      aPoz[ 'K_36' ] := sxml2num( xmlWartoscH( aPoz, 'K_36' ), 0 )
      aPoz[ 'K_37' ] := sxml2num( xmlWartoscH( aPoz, 'K_37' ), 0 )
      aPoz[ 'K_38' ] := sxml2num( xmlWartoscH( aPoz, 'K_38' ), 0 )
      aPoz[ 'K_39' ] := sxml2num( xmlWartoscH( aPoz, 'K_39' ), 0 )
      IF ! hb_HHasKey( aPoz, 'DataSprzedazy' )
         aPoz[ 'DataSprzedazy' ] := ""
      ENDIF
   } )

   aDane[ 'Zakup' ] := edekXmlGrupaTab( oDoc, 'JPK', 'ZakupWiersz' )
   AEval( aDane[ 'Zakup' ], { | aPoz |
      aPoz[ 'K_43' ] := sxml2num( xmlWartoscH( aPoz, 'K_43' ), 0 )
      aPoz[ 'K_44' ] := sxml2num( xmlWartoscH( aPoz, 'K_44' ), 0 )
      aPoz[ 'K_45' ] := sxml2num( xmlWartoscH( aPoz, 'K_45' ), 0 )
      aPoz[ 'K_46' ] := sxml2num( xmlWartoscH( aPoz, 'K_46' ), 0 )
      aPoz[ 'K_47' ] := sxml2num( xmlWartoscH( aPoz, 'K_47' ), 0 )
      aPoz[ 'K_48' ] := sxml2num( xmlWartoscH( aPoz, 'K_48' ), 0 )
      aPoz[ 'K_49' ] := sxml2num( xmlWartoscH( aPoz, 'K_49' ), 0 )
      aPoz[ 'K_50' ] := sxml2num( xmlWartoscH( aPoz, 'K_50' ), 0 )
      IF ! hb_HHasKey( aPoz, 'DataWplywu' )
         aPoz[ 'DataWplywu' ] := ""
      ENDIF
   } )

   aDane[ 'SprzedazCtrl' ] := edekXmlGrupa( oDoc, 'SprzedazCtrl' )
   aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] := sxml2num( xmlWartoscH( aDane[ 'SprzedazCtrl' ], 'LiczbaWierszySprzedazy' ) )
   aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] := sxml2num( xmlWartoscH( aDane[ 'SprzedazCtrl' ], 'PodatekNalezny' ) )

   aDane[ 'ZakupCtrl' ] := edekXmlGrupa( oDoc, 'ZakupCtrl' )
   aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] := sxml2num( xmlWartoscH( aDane[ 'ZakupCtrl' ], 'LiczbaWierszyZakupow' ) )
   aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] := sxml2num( xmlWartoscH( aDane[ 'ZakupCtrl' ], 'PodatekNaliczony' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKVATw3( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )

   aTemp := edekXmlGrupa( oDoc, 'Podmiot1' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'PelnaNazwa' )

   aDane[ 'Sprzedaz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'SprzedazWiersz' )
   AEval( aDane[ 'Sprzedaz' ], { | aPoz |
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
      aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
      aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
      aPoz[ 'K_15' ] := sxml2num( xmlWartoscH( aPoz, 'K_15' ), 0 )
      aPoz[ 'K_16' ] := sxml2num( xmlWartoscH( aPoz, 'K_16' ), 0 )
      aPoz[ 'K_17' ] := sxml2num( xmlWartoscH( aPoz, 'K_17' ), 0 )
      aPoz[ 'K_18' ] := sxml2num( xmlWartoscH( aPoz, 'K_18' ), 0 )
      aPoz[ 'K_19' ] := sxml2num( xmlWartoscH( aPoz, 'K_19' ), 0 )
      aPoz[ 'K_20' ] := sxml2num( xmlWartoscH( aPoz, 'K_20' ), 0 )
      aPoz[ 'K_21' ] := sxml2num( xmlWartoscH( aPoz, 'K_21' ), 0 )
      aPoz[ 'K_22' ] := sxml2num( xmlWartoscH( aPoz, 'K_22' ), 0 )
      aPoz[ 'K_23' ] := sxml2num( xmlWartoscH( aPoz, 'K_23' ), 0 )
      aPoz[ 'K_24' ] := sxml2num( xmlWartoscH( aPoz, 'K_24' ), 0 )
      aPoz[ 'K_25' ] := sxml2num( xmlWartoscH( aPoz, 'K_25' ), 0 )
      aPoz[ 'K_26' ] := sxml2num( xmlWartoscH( aPoz, 'K_26' ), 0 )
      aPoz[ 'K_27' ] := sxml2num( xmlWartoscH( aPoz, 'K_27' ), 0 )
      aPoz[ 'K_28' ] := sxml2num( xmlWartoscH( aPoz, 'K_28' ), 0 )
      aPoz[ 'K_29' ] := sxml2num( xmlWartoscH( aPoz, 'K_29' ), 0 )
      aPoz[ 'K_30' ] := sxml2num( xmlWartoscH( aPoz, 'K_30' ), 0 )
      aPoz[ 'K_31' ] := sxml2num( xmlWartoscH( aPoz, 'K_31' ), 0 )
      aPoz[ 'K_32' ] := sxml2num( xmlWartoscH( aPoz, 'K_32' ), 0 )
      aPoz[ 'K_33' ] := sxml2num( xmlWartoscH( aPoz, 'K_33' ), 0 )
      aPoz[ 'K_34' ] := sxml2num( xmlWartoscH( aPoz, 'K_34' ), 0 )
      aPoz[ 'K_35' ] := sxml2num( xmlWartoscH( aPoz, 'K_35' ), 0 )
      aPoz[ 'K_36' ] := sxml2num( xmlWartoscH( aPoz, 'K_36' ), 0 )
      aPoz[ 'K_37' ] := sxml2num( xmlWartoscH( aPoz, 'K_37' ), 0 )
      aPoz[ 'K_38' ] := sxml2num( xmlWartoscH( aPoz, 'K_38' ), 0 )
      aPoz[ 'K_39' ] := sxml2num( xmlWartoscH( aPoz, 'K_39' ), 0 )
      IF ! hb_HHasKey( aPoz, 'DataSprzedazy' )
         aPoz[ 'DataSprzedazy' ] := ""
      ENDIF
   } )

   aDane[ 'Zakup' ] := edekXmlGrupaTab( oDoc, 'JPK', 'ZakupWiersz' )
   AEval( aDane[ 'Zakup' ], { | aPoz |
      aPoz[ 'K_43' ] := sxml2num( xmlWartoscH( aPoz, 'K_43' ), 0 )
      aPoz[ 'K_44' ] := sxml2num( xmlWartoscH( aPoz, 'K_44' ), 0 )
      aPoz[ 'K_45' ] := sxml2num( xmlWartoscH( aPoz, 'K_45' ), 0 )
      aPoz[ 'K_46' ] := sxml2num( xmlWartoscH( aPoz, 'K_46' ), 0 )
      aPoz[ 'K_47' ] := sxml2num( xmlWartoscH( aPoz, 'K_47' ), 0 )
      aPoz[ 'K_48' ] := sxml2num( xmlWartoscH( aPoz, 'K_48' ), 0 )
      aPoz[ 'K_49' ] := sxml2num( xmlWartoscH( aPoz, 'K_49' ), 0 )
      aPoz[ 'K_50' ] := sxml2num( xmlWartoscH( aPoz, 'K_50' ), 0 )
      IF ! hb_HHasKey( aPoz, 'DataWplywu' )
         aPoz[ 'DataWplywu' ] := ""
      ENDIF
   } )

   aDane[ 'SprzedazCtrl' ] := edekXmlGrupa( oDoc, 'SprzedazCtrl' )
   aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] := sxml2num( xmlWartoscH( aDane[ 'SprzedazCtrl' ], 'LiczbaWierszySprzedazy' ) )
   aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] := sxml2num( xmlWartoscH( aDane[ 'SprzedazCtrl' ], 'PodatekNalezny' ) )

   aDane[ 'ZakupCtrl' ] := edekXmlGrupa( oDoc, 'ZakupCtrl' )
   aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] := sxml2num( xmlWartoscH( aDane[ 'ZakupCtrl' ], 'LiczbaWierszyZakupow' ) )
   aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] := sxml2num( xmlWartoscH( aDane[ 'ZakupCtrl' ], 'PodatekNaliczony' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKPKPIRw2( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'KodPocztowy' )
   aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'Poczta' )

   aTemp := edekXmlGrupa( oDoc, 'PKPIRInfo' )
   aDane[ 'P_1' ] := sxml2num( xmlWartoscH( aTemp, 'P_1' ), 0 )
   aDane[ 'P_2' ] := sxml2num( xmlWartoscH( aTemp, 'P_2' ), 0 )
   aDane[ 'P_3' ] := sxml2num( xmlWartoscH( aTemp, 'P_3' ), 0 )
   aDane[ 'P_4' ] := sxml2num( xmlWartoscH( aTemp, 'P_4' ), 0 )

   aTemp := edekXmlGrupa( oDoc, 'PKPIRSpis' )
   aDane[ 'P_5A' ] := xml2date( xmlWartoscH( aTemp, 'P_5A', '' ), '(brak)' )
   aDane[ 'P_5B' ] := sxml2num( xmlWartoscH( aTemp, 'P_5B' ), 0 )

   aDane[ 'PKPIRWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'PKPIRWiersz' )
   AEval( aDane[ 'PKPIRWiersz' ], { | aPoz |
      aPoz[ 'K_1' ] := sxml2num( xmlWartoscH( aPoz, 'K_1' ), 0 )
      aPoz[ 'K_2' ] := xml2date( xmlWartoscH( aPoz, 'K_2', '' ) )
      aPoz[ 'K_3' ] := sxml2str( xmlWartoscH( aPoz, 'K_3', '' ) )
      aPoz[ 'K_4' ] := sxml2str( xmlWartoscH( aPoz, 'K_4', '' ) )
      aPoz[ 'K_5' ] := sxml2str( xmlWartoscH( aPoz, 'K_5', '' ) )
      aPoz[ 'K_6' ] := sxml2str( xmlWartoscH( aPoz, 'K_6', '' ) )
      aPoz[ 'K_7' ] := sxml2num( xmlWartoscH( aPoz, 'K_7' ), 0 )
      aPoz[ 'K_8' ] := sxml2num( xmlWartoscH( aPoz, 'K_8' ), 0 )
      aPoz[ 'K_9' ] := sxml2num( xmlWartoscH( aPoz, 'K_9' ), 0 )
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
      aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
      aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
      aPoz[ 'K_15' ] := sxml2num( xmlWartoscH( aPoz, 'K_15' ), 0 )
      aPoz[ 'K_16A' ] := sxml2str( xmlWartoscH( aPoz, 'K_16A', '' ) )
      aPoz[ 'K_16B' ] := sxml2num( xmlWartoscH( aPoz, 'K_16B' ), 0 )
      aPoz[ 'K_17' ] := sxml2num( xmlWartoscH( aPoz, 'K_17' ), 0 )
   } )

   aDane[ 'PKPIRCtrl' ] := edekXmlGrupa( oDoc, 'PKPIRCtrl' )
   aDane[ 'PKPIRCtrl' ][ 'LiczbaWierszy' ] := sxml2num( xmlWartoscH( aDane[ 'PKPIRCtrl' ], 'LiczbaWierszy' ) )
   aDane[ 'PKPIRCtrl' ][ 'SumaPrzychodow' ] := sxml2num( xmlWartoscH( aDane[ 'PKPIRCtrl' ], 'SumaPrzychodow' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKEWPw1( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'etd:KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'etd:Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'etd:Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'etd:Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'etd:Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'etd:NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'etd:NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'etd:Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'etd:KodPocztowy' )
   aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'etd:Poczta' )

   aDane[ 'EWPWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'EWPWiersz' )
   AEval( aDane[ 'EWPWiersz' ], { | aPoz |
      aPoz[ 'K_1' ] := sxml2num( xmlWartoscH( aPoz, 'K_1' ), 0 )
      aPoz[ 'K_2' ] := xml2date( xmlWartoscH( aPoz, 'K_2', '' ) )
      aPoz[ 'K_3' ] := xml2date( xmlWartoscH( aPoz, 'K_3', '' ) )
      aPoz[ 'K_4' ] := sxml2str( xmlWartoscH( aPoz, 'K_4', '' ) )
      aPoz[ 'K_5' ] := sxml2num( xmlWartoscH( aPoz, 'K_5' ), 0 )
      aPoz[ 'K_6' ] := sxml2num( xmlWartoscH( aPoz, 'K_6' ), 0 )
      aPoz[ 'K_7' ] := sxml2num( xmlWartoscH( aPoz, 'K_7' ), 0 )
      aPoz[ 'K_8' ] := sxml2num( xmlWartoscH( aPoz, 'K_8' ), 0 )
      aPoz[ 'K_9' ] := sxml2num( xmlWartoscH( aPoz, 'K_9' ), 0 )
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2str( xmlWartoscH( aPoz, 'K_12', '' ) )
   } )

   aDane[ 'EWPCtrl' ] := edekXmlGrupa( oDoc, 'EWPCtrl' )
   aDane[ 'EWPCtrl' ][ 'LiczbaWierszy' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'LiczbaWierszy' ) )
   aDane[ 'EWPCtrl' ][ 'SumaPrzychodow' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'SumaPrzychodow' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKEWPw2( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'etd:KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'etd:Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'etd:Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'etd:Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'etd:Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'etd:NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'etd:NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'etd:Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'etd:KodPocztowy' )
   //aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'etd:Poczta' )

   aDane[ 'EWPWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'EWPWiersz' )
   AEval( aDane[ 'EWPWiersz' ], { | aPoz |
      aPoz[ 'K_1' ] := sxml2num( xmlWartoscH( aPoz, 'K_1' ), 0 )
      aPoz[ 'K_2' ] := xml2date( xmlWartoscH( aPoz, 'K_2', '' ) )
      aPoz[ 'K_3' ] := xml2date( xmlWartoscH( aPoz, 'K_3', '' ) )
      aPoz[ 'K_4' ] := sxml2str( xmlWartoscH( aPoz, 'K_4', '' ) )
      aPoz[ 'K_5' ] := sxml2num( xmlWartoscH( aPoz, 'K_5' ), 0 )
      aPoz[ 'K_6' ] := sxml2num( xmlWartoscH( aPoz, 'K_6' ), 0 )
      aPoz[ 'K_7' ] := sxml2num( xmlWartoscH( aPoz, 'K_7' ), 0 )
      aPoz[ 'K_8' ] := sxml2num( xmlWartoscH( aPoz, 'K_8' ), 0 )
      aPoz[ 'K_9' ] := sxml2num( xmlWartoscH( aPoz, 'K_9' ), 0 )
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
      aPoz[ 'K_13' ] := sxml2str( xmlWartoscH( aPoz, 'K_13', '' ) )
   } )

   aDane[ 'EWPCtrl' ] := edekXmlGrupa( oDoc, 'EWPCtrl' )
   aDane[ 'EWPCtrl' ][ 'LiczbaWierszy' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'LiczbaWierszy' ) )
   aDane[ 'EWPCtrl' ][ 'SumaPrzychodow' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'SumaPrzychodow' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKEWPw3( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'etd:KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'etd:Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'etd:Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'etd:Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'etd:Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'etd:NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'etd:NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'etd:Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'etd:KodPocztowy' )
   //aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'etd:Poczta' )

   aDane[ 'EWPWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'EWPWiersz' )
   AEval( aDane[ 'EWPWiersz' ], { | aPoz |
      aPoz[ 'K_1' ] := sxml2num( xmlWartoscH( aPoz, 'K_1' ), 0 )
      aPoz[ 'K_2' ] := xml2date( xmlWartoscH( aPoz, 'K_2', '' ) )
      aPoz[ 'K_3' ] := xml2date( xmlWartoscH( aPoz, 'K_3', '' ) )
      aPoz[ 'K_4' ] := sxml2str( xmlWartoscH( aPoz, 'K_4', '' ) )
      aPoz[ 'K_5' ] := sxml2num( xmlWartoscH( aPoz, 'K_5' ), 0 )
      aPoz[ 'K_6' ] := sxml2num( xmlWartoscH( aPoz, 'K_6' ), 0 )
      aPoz[ 'K_7' ] := sxml2num( xmlWartoscH( aPoz, 'K_7' ), 0 )
      aPoz[ 'K_8' ] := sxml2num( xmlWartoscH( aPoz, 'K_8' ), 0 )
      aPoz[ 'K_9' ] := sxml2num( xmlWartoscH( aPoz, 'K_9' ), 0 )
      aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
      aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
      aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
      aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
      aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
      aPoz[ 'K_15' ] := sxml2str( xmlWartoscH( aPoz, 'K_15', '' ) )
   } )

   aDane[ 'EWPCtrl' ] := edekXmlGrupa( oDoc, 'EWPCtrl' )
   aDane[ 'EWPCtrl' ][ 'LiczbaWierszy' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'LiczbaWierszy' ) )
   aDane[ 'EWPCtrl' ][ 'SumaPrzychodow' ] := sxml2num( xmlWartoscH( aDane[ 'EWPCtrl' ], 'SumaPrzychodow' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKFAw3( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'etd:NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'etd:PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'etd:REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'etd:KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'etd:Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'etd:Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'etd:Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'etd:Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'etd:NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'etd:NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'etd:Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'etd:KodPocztowy' )
   aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'etd:Poczta' )

   aDane[ 'Faktura' ] := edekXmlGrupaTab( oDoc, 'JPK', 'Faktura' )
   AEval( aDane[ 'Faktura' ], { | aPoz |
      aPoz[ 'KodWaluty' ] := sxml2str( xmlWartoscH( aPoz, 'KodWaluty', '' ) )
      aPoz[ 'P_1' ] := xml2date( xmlWartoscH( aPoz, 'P_1', '' ) )
      aPoz[ 'P_2A' ] := sxml2str( xmlWartoscH( aPoz, 'P_2A', '' ) )
      aPoz[ 'P_3A' ] := sxml2str( xmlWartoscH( aPoz, 'P_3A', '' ) )
      aPoz[ 'P_3B' ] := sxml2str( xmlWartoscH( aPoz, 'P_3B', '' ) )
      aPoz[ 'P_3C' ] := sxml2str( xmlWartoscH( aPoz, 'P_3C', '' ) )
      aPoz[ 'P_3D' ] := sxml2str( xmlWartoscH( aPoz, 'P_3D', '' ) )
      aPoz[ 'P_4A' ] := sxml2str( xmlWartoscH( aPoz, 'P_4A', '' ) )
      aPoz[ 'P_4B' ] := sxml2str( xmlWartoscH( aPoz, 'P_4B', '' ) )
      aPoz[ 'P_5A' ] := sxml2str( xmlWartoscH( aPoz, 'P_5A', '' ) )
      aPoz[ 'P_5B' ] := sxml2str( xmlWartoscH( aPoz, 'P_5B', '' ) )
      aPoz[ 'P_6' ] := xml2date( xmlWartoscH( aPoz, 'P_6', '' ) )
      aPoz[ 'P_13_1' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_1' ), 0 )
      aPoz[ 'P_14_1' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_1' ), 0 )
      aPoz[ 'P_14_1W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_1W' ), 0 )
      aPoz[ 'P_13_2' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_2' ), 0 )
      aPoz[ 'P_14_2' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_2' ), 0 )
      aPoz[ 'P_14_2W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_2W' ), 0 )
      aPoz[ 'P_13_3' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_3' ), 0 )
      aPoz[ 'P_14_3' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_3' ), 0 )
      aPoz[ 'P_14_3W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_3W' ), 0 )
      aPoz[ 'P_13_4' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_4' ), 0 )
      aPoz[ 'P_14_4' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_4' ), 0 )
      aPoz[ 'P_14_4W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_4W' ), 0 )
      aPoz[ 'P_13_5' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_5' ), 0 )
      aPoz[ 'P_13_6' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_6' ), 0 )
      aPoz[ 'P_13_7' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_7' ), 0 )
      aPoz[ 'P_15' ] := sxml2num( xmlWartoscH( aPoz, 'P_15' ), 0 )
      aPoz[ 'P_16' ] := sxml2bool( xmlWartoscH( aPoz, 'P_16' ), '' )
      aPoz[ 'P_17' ] := sxml2bool( xmlWartoscH( aPoz, 'P_17' ), '' )
      aPoz[ 'P_18' ] := sxml2bool( xmlWartoscH( aPoz, 'P_18' ), '' )
      aPoz[ 'P_18A' ] := sxml2bool( xmlWartoscH( aPoz, 'P_18A' ), '' )
      aPoz[ 'P_19' ] := sxml2bool( xmlWartoscH( aPoz, 'P_19' ), '' )
      aPoz[ 'P_19A' ] := sxml2str( xmlWartoscH( aPoz, 'P_19A', '' ) )
      aPoz[ 'P_19B' ] := sxml2str( xmlWartoscH( aPoz, 'P_19B', '' ) )
      aPoz[ 'P_19C' ] := sxml2str( xmlWartoscH( aPoz, 'P_19C', '' ) )
      aPoz[ 'P_20' ] := sxml2bool( xmlWartoscH( aPoz, 'P_20' ), '' )
      aPoz[ 'P_20A' ] := sxml2str( xmlWartoscH( aPoz, 'P_20A', '' ) )
      aPoz[ 'P_20B' ] := sxml2str( xmlWartoscH( aPoz, 'P_20B', '' ) )
      aPoz[ 'P_21' ] := sxml2bool( xmlWartoscH( aPoz, 'P_21' ), '' )
      aPoz[ 'P_21A' ] := sxml2str( xmlWartoscH( aPoz, 'P_21A', '' ) )
      aPoz[ 'P_21B' ] := sxml2str( xmlWartoscH( aPoz, 'P_21B', '' ) )
      aPoz[ 'P_21C' ] := sxml2str( xmlWartoscH( aPoz, 'P_21C', '' ) )
      aPoz[ 'P_22' ] := sxml2bool( xmlWartoscH( aPoz, 'P_22' ), '' )
      aPoz[ 'P_22A' ] := xml2date( xmlWartoscH( aPoz, 'P_22A', '' ) )
      aPoz[ 'P_22B' ] := sxml2str( xmlWartoscH( aPoz, 'P_22B', '' ) )
      aPoz[ 'P_22C' ] := sxml2str( xmlWartoscH( aPoz, 'P_22C', '' ) )
      aPoz[ 'P_23' ] := sxml2bool( xmlWartoscH( aPoz, 'P_23' ), '' )
      aPoz[ 'P_106E_2' ] := sxml2bool( xmlWartoscH( aPoz, 'P_106E_2' ), '' )
      aPoz[ 'P_106E_3' ] := sxml2bool( xmlWartoscH( aPoz, 'P_106E_3' ), '' )
      aPoz[ 'P_106E_3A' ] := sxml2str( xmlWartoscH( aPoz, 'P_106E_3A', '' ) )
      aPoz[ 'RodzajFaktury' ] := sxml2str( xmlWartoscH( aPoz, 'RodzajFaktury', '' ) )
      aPoz[ 'PrzyczynaKorekty' ] := sxml2str( xmlWartoscH( aPoz, 'PrzyczynaKorekty', '' ) )
      aPoz[ 'NrFaKorygowanej' ] := sxml2str( xmlWartoscH( aPoz, 'NrFaKorygowanej', '' ) )
      aPoz[ 'OkresFaKorygowanej' ] := sxml2str( xmlWartoscH( aPoz, 'OkresFaKorygowanej', '' ) )
      aPoz[ 'NrFaZaliczkowej' ] := sxml2str( xmlWartoscH( aPoz, 'NrFaZaliczkowej', '' ) )
   } )

   aDane[ 'FakturaCtrl' ] := edekXmlGrupa( oDoc, 'FakturaCtrl' )
   aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaCtrl' ], 'LiczbaFaktur' ) )
   aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaCtrl' ], 'WartoscFaktur' ) )

   aDane[ 'FakturaWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'FakturaWiersz' )
   AEval( aDane[ 'FakturaWiersz' ], { | aPoz |
      aPoz[ 'P_2B' ] := sxml2str( xmlWartoscH( aPoz, 'P_2B', '' ) )
      aPoz[ 'P_7' ] := sxml2str( xmlWartoscH( aPoz, 'P_7', '' ) )
      aPoz[ 'P_8A' ] := sxml2str( xmlWartoscH( aPoz, 'P_8A', '' ) )
      aPoz[ 'P_8B' ] := sxml2num( xmlWartoscH( aPoz, 'P_8B', '' ) )
      aPoz[ 'P_9A' ] := sxml2num( xmlWartoscH( aPoz, 'P_9A' ), 0 )
      aPoz[ 'P_9B' ] := sxml2num( xmlWartoscH( aPoz, 'P_9B' ), 0 )
      aPoz[ 'P_10' ] := sxml2num( xmlWartoscH( aPoz, 'P_10' ), 0 )
      aPoz[ 'P_11' ] := sxml2num( xmlWartoscH( aPoz, 'P_11' ), 0 )
      aPoz[ 'P_11A' ] := sxml2num( xmlWartoscH( aPoz, 'P_11A' ), 0 )
      aPoz[ 'P_12' ] := sxml2str( xmlWartoscH( aPoz, 'P_12', '' ) )
   } )

   aDane[ 'FakturaWierszCtrl' ] := edekXmlGrupa( oDoc, 'FakturaWierszCtrl' )
   aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaWierszCtrl' ], 'LiczbaWierszyFaktur' ) )
   aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaWierszCtrl' ], 'WartoscWierszyFaktur' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKFAw4( oDoc, cNrRef )

   LOCAL aDane := hb_Hash()
   LOCAL aZak, aSprz, aTemp

   aDane[ 'NrRef' ] := AllTrim( cNrRef )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   aDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   aDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   aDane[ 'DataOd' ] := xmlWartoscH( aTemp, 'DataOd' )
   aDane[ 'DataDo' ] := xmlWartoscH( aTemp, 'DataDo' )
   aDane[ 'DomyslnyKodWaluty' ] := xmlWartoscH( aTemp, 'DomyslnyKodWaluty' )
   aDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )

   aTemp := edekXmlGrupa( oDoc, 'IdentyfikatorPodmiotu' )
   aDane[ 'NIP' ] := xmlWartoscH( aTemp, 'NIP' )
   aDane[ 'PelnaNazwa' ] := xmlWartoscH( aTemp, 'PelnaNazwa' )
   aDane[ 'REGON' ] := xmlWartoscH( aTemp, 'REGON' )

   aTemp := edekXmlGrupa( oDoc, 'AdresPodmiotu' )
   aDane[ 'KodKraju' ] := xmlWartoscH( aTemp, 'etd:KodKraju' )
   aDane[ 'Wojewodztwo' ] := xmlWartoscH( aTemp, 'etd:Wojewodztwo' )
   aDane[ 'Powiat' ] := xmlWartoscH( aTemp, 'etd:Powiat' )
   aDane[ 'Gmina' ] := xmlWartoscH( aTemp, 'etd:Gmina' )
   aDane[ 'Ulica' ] := xmlWartoscH( aTemp, 'etd:Ulica' )
   aDane[ 'NrDomu' ] := xmlWartoscH( aTemp, 'etd:NrDomu' )
   aDane[ 'NrLokalu' ] := xmlWartoscH( aTemp, 'etd:NrLokalu' )
   aDane[ 'Miejscowosc' ] := xmlWartoscH( aTemp, 'etd:Miejscowosc' )
   aDane[ 'KodPocztowy' ] := xmlWartoscH( aTemp, 'etd:KodPocztowy' )
   aDane[ 'Poczta' ] := xmlWartoscH( aTemp, 'etd:Poczta' )

   aDane[ 'Faktura' ] := edekXmlGrupaTab( oDoc, 'JPK', 'Faktura' )
   AEval( aDane[ 'Faktura' ], { | aPoz |
      aPoz[ 'KodWaluty' ] := sxml2str( xmlWartoscH( aPoz, 'KodWaluty', '' ) )
      aPoz[ 'P_1' ] := xml2date( xmlWartoscH( aPoz, 'P_1', '' ) )
      aPoz[ 'P_2A' ] := sxml2str( xmlWartoscH( aPoz, 'P_2A', '' ) )
      aPoz[ 'P_3A' ] := sxml2str( xmlWartoscH( aPoz, 'P_3A', '' ) )
      aPoz[ 'P_3B' ] := sxml2str( xmlWartoscH( aPoz, 'P_3B', '' ) )
      aPoz[ 'P_3C' ] := sxml2str( xmlWartoscH( aPoz, 'P_3C', '' ) )
      aPoz[ 'P_3D' ] := sxml2str( xmlWartoscH( aPoz, 'P_3D', '' ) )
      aPoz[ 'P_4A' ] := sxml2str( xmlWartoscH( aPoz, 'P_4A', '' ) )
      aPoz[ 'P_4B' ] := sxml2str( xmlWartoscH( aPoz, 'P_4B', '' ) )
      aPoz[ 'P_5A' ] := sxml2str( xmlWartoscH( aPoz, 'P_5A', '' ) )
      aPoz[ 'P_5B' ] := sxml2str( xmlWartoscH( aPoz, 'P_5B', '' ) )
      aPoz[ 'P_6' ] := xml2date( xmlWartoscH( aPoz, 'P_6', '' ) )
      aPoz[ 'P_13_1' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_1' ), 0 )
      aPoz[ 'P_14_1' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_1' ), 0 )
      aPoz[ 'P_14_1W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_1W' ), 0 )
      aPoz[ 'P_13_2' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_2' ), 0 )
      aPoz[ 'P_14_2' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_2' ), 0 )
      aPoz[ 'P_14_2W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_2W' ), 0 )
      aPoz[ 'P_13_3' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_3' ), 0 )
      aPoz[ 'P_14_3' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_3' ), 0 )
      aPoz[ 'P_14_3W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_3W' ), 0 )
      aPoz[ 'P_13_4' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_4' ), 0 )
      aPoz[ 'P_14_4' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_4' ), 0 )
      aPoz[ 'P_14_4W' ] := sxml2num( xmlWartoscH( aPoz, 'P_14_4W' ), 0 )
      aPoz[ 'P_13_5' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_5' ), 0 )
      aPoz[ 'P_13_6' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_6' ), 0 )
      aPoz[ 'P_13_7' ] := sxml2num( xmlWartoscH( aPoz, 'P_13_7' ), 0 )
      aPoz[ 'P_15' ] := sxml2num( xmlWartoscH( aPoz, 'P_15' ), 0 )
      aPoz[ 'P_16' ] := sxml2bool( xmlWartoscH( aPoz, 'P_16' ), '' )
      aPoz[ 'P_17' ] := sxml2bool( xmlWartoscH( aPoz, 'P_17' ), '' )
      aPoz[ 'P_18' ] := sxml2bool( xmlWartoscH( aPoz, 'P_18' ), '' )
      aPoz[ 'P_18A' ] := sxml2bool( xmlWartoscH( aPoz, 'P_18A' ), '' )
      aPoz[ 'P_19' ] := sxml2bool( xmlWartoscH( aPoz, 'P_19' ), '' )
      aPoz[ 'P_19A' ] := sxml2str( xmlWartoscH( aPoz, 'P_19A', '' ) )
      aPoz[ 'P_19B' ] := sxml2str( xmlWartoscH( aPoz, 'P_19B', '' ) )
      aPoz[ 'P_19C' ] := sxml2str( xmlWartoscH( aPoz, 'P_19C', '' ) )
      aPoz[ 'P_20' ] := sxml2bool( xmlWartoscH( aPoz, 'P_20' ), '' )
      aPoz[ 'P_20A' ] := sxml2str( xmlWartoscH( aPoz, 'P_20A', '' ) )
      aPoz[ 'P_20B' ] := sxml2str( xmlWartoscH( aPoz, 'P_20B', '' ) )
      aPoz[ 'P_21' ] := sxml2bool( xmlWartoscH( aPoz, 'P_21' ), '' )
      aPoz[ 'P_21A' ] := sxml2str( xmlWartoscH( aPoz, 'P_21A', '' ) )
      aPoz[ 'P_21B' ] := sxml2str( xmlWartoscH( aPoz, 'P_21B', '' ) )
      aPoz[ 'P_21C' ] := sxml2str( xmlWartoscH( aPoz, 'P_21C', '' ) )
      aPoz[ 'P_22' ] := sxml2bool( xmlWartoscH( aPoz, 'P_22' ), '' )
      aPoz[ 'P_22A' ] := xml2date( xmlWartoscH( aPoz, 'P_22A', '' ) )
      aPoz[ 'P_22B' ] := sxml2str( xmlWartoscH( aPoz, 'P_22B', '' ) )
      aPoz[ 'P_22C' ] := sxml2str( xmlWartoscH( aPoz, 'P_22C', '' ) )
      aPoz[ 'P_23' ] := sxml2bool( xmlWartoscH( aPoz, 'P_23' ), '' )
      aPoz[ 'P_106E_2' ] := sxml2bool( xmlWartoscH( aPoz, 'P_106E_2' ), '' )
      aPoz[ 'P_106E_3' ] := sxml2bool( xmlWartoscH( aPoz, 'P_106E_3' ), '' )
      aPoz[ 'P_106E_3A' ] := sxml2str( xmlWartoscH( aPoz, 'P_106E_3A', '' ) )
      aPoz[ 'RodzajFaktury' ] := sxml2str( xmlWartoscH( aPoz, 'RodzajFaktury', '' ) )
      aPoz[ 'PrzyczynaKorekty' ] := sxml2str( xmlWartoscH( aPoz, 'PrzyczynaKorekty', '' ) )
      aPoz[ 'NrFaKorygowanej' ] := sxml2str( xmlWartoscH( aPoz, 'NrFaKorygowanej', '' ) )
      aPoz[ 'OkresFaKorygowanej' ] := sxml2str( xmlWartoscH( aPoz, 'OkresFaKorygowanej', '' ) )
      aPoz[ 'NrFaZaliczkowej' ] := sxml2str( xmlWartoscH( aPoz, 'NrFaZaliczkowej', '' ) )
   } )

   aDane[ 'FakturaCtrl' ] := edekXmlGrupa( oDoc, 'FakturaCtrl' )
   aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaCtrl' ], 'LiczbaFaktur' ) )
   aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaCtrl' ], 'WartoscFaktur' ) )

   aDane[ 'FakturaWiersz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'FakturaWiersz' )
   AEval( aDane[ 'FakturaWiersz' ], { | aPoz |
      aPoz[ 'P_2B' ] := sxml2str( xmlWartoscH( aPoz, 'P_2B', '' ) )
      aPoz[ 'P_7' ] := sxml2str( xmlWartoscH( aPoz, 'P_7', '' ) )
      aPoz[ 'P_8A' ] := sxml2str( xmlWartoscH( aPoz, 'P_8A', '' ) )
      aPoz[ 'P_8B' ] := sxml2num( xmlWartoscH( aPoz, 'P_8B', '' ) )
      aPoz[ 'P_9A' ] := sxml2num( xmlWartoscH( aPoz, 'P_9A' ), 0 )
      aPoz[ 'P_9B' ] := sxml2num( xmlWartoscH( aPoz, 'P_9B' ), 0 )
      aPoz[ 'P_10' ] := sxml2num( xmlWartoscH( aPoz, 'P_10' ), 0 )
      aPoz[ 'P_11' ] := sxml2num( xmlWartoscH( aPoz, 'P_11' ), 0 )
      aPoz[ 'P_11A' ] := sxml2num( xmlWartoscH( aPoz, 'P_11A' ), 0 )
      aPoz[ 'P_12' ] := sxml2str( xmlWartoscH( aPoz, 'P_12', '' ) )
   } )

   aDane[ 'FakturaWierszCtrl' ] := edekXmlGrupa( oDoc, 'FakturaWierszCtrl' )
   aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaWierszCtrl' ], 'LiczbaWierszyFaktur' ) )
   aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] := sxml2num( xmlWartoscH( aDane[ 'FakturaWierszCtrl' ], 'WartoscWierszyFaktur' ) )

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKV7w1( oDoc, cNrRef, hNaglowek )

   LOCAL hPodmiot1, cTmp, aTemp, hPozycje
   LOCAL hDane := hb_Hash()

   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF

   hPodmiot1 := edekXmlPodmiot1( oDoc )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   hDane[ 'KodFormularza' ] := xmlWartoscH( aTemp, 'KodFormularza' )
   hDane[ 'WariantFormularza' ] := xmlWartoscH( aTemp, 'WariantFormularza' )
   hDane[ 'KodFormularzaDekl' ] := xmlWartoscH( aTemp, 'KodFormularzaDekl' )
   hDane[ 'WariantFormularzaDekl' ] := xmlWartoscH( aTemp, 'WariantFormularzaDekl' )
   hDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   hDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   hDane[ 'NazwaSystemu' ] :=  xmlWartoscH( aTemp, 'NazwaSystemu' )
   hDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )
   hDane[ 'Rok' ] := sxml2num( xmlWartoscH( aTemp, 'Rok' ) )
   hDane[ 'Miesiac' ] := sxml2num( xmlWartoscH( aTemp, 'Miesiac' ), 0 )
   hDane[ 'Kwartal' ] := sxml2num( xmlWartoscH( aTemp, 'Kwartal' ), 0 )
   cTmp := xmlWartoscH( aTemp, 'KodUrzedu' )
   hDane[ 'UrzadSkarbowy' ] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane[ 'NrRef' ] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )

   hDane[ 'CelZlozenia1' ] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane[ 'CelZlozenia2' ] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane[ 'PodmiotSpolka' ] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane[ 'PodmiotOsoba' ] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane[ 'PodmiotNazwa' ] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
      hDane[ 'Email' ] := xmlWartoscH( hPodmiot1, 'tns:Email' )
      hDane[ 'Telefon' ] := xmlWartoscH( hPodmiot1, 'tns:Telefon' )
      hDane[ 'NIP' ] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   ELSE
      hDane[ 'PodmiotNazwa' ] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane[ 'Email' ] := xmlWartoscH( hPodmiot1, 'Email' )
      hDane[ 'Telefon' ] := xmlWartoscH( hPodmiot1, 'Telefon' )
      hDane[ 'NIP' ] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane[ 'P_8_N' ] := ''
      hDane[ 'P_8_R' ] := ''
      hDane[ 'P_9_N' ] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane[ 'P_9_I' ] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane[ 'P_9_D' ] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
      hDane[ 'P_9_E' ] := xmlWartoscH( hPodmiot1, 'tns:Email' )
      hDane[ 'P_9_T' ] := xmlWartoscH( hPodmiot1, 'tns:Telefon' )
   ELSE
      hDane[ 'P_8_N' ] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane[ 'P_8_R' ] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane[ 'P_9_N' ] := ''
      hDane[ 'P_9_I' ] := ''
      hDane[ 'P_9_D' ] := ''
      hDane[ 'P_9_E' ] := xmlWartoscH( hPodmiot1, 'Email' )
      hDane[ 'P_9_T' ] := xmlWartoscH( hPodmiot1, 'Telefon' )
   ENDIF

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   IF Len( hPozycje ) > 0
      hDane[ 'JestDeklaracja' ] := .T.
      hDane[ 'P_10' ] := sxml2num( xmlWartoscH( hPozycje, 'P_10' ) )
      hDane[ 'P_11' ] := sxml2num( xmlWartoscH( hPozycje, 'P_11' ) )
      hDane[ 'P_12' ] := sxml2num( xmlWartoscH( hPozycje, 'P_12' ) )
      hDane[ 'P_13' ] := sxml2num( xmlWartoscH( hPozycje, 'P_13' ) )
      hDane[ 'P_14' ] := sxml2num( xmlWartoscH( hPozycje, 'P_14' ) )
      hDane[ 'P_15' ] := sxml2num( xmlWartoscH( hPozycje, 'P_15' ) )
      hDane[ 'P_16' ] := sxml2num( xmlWartoscH( hPozycje, 'P_16' ) )
      hDane[ 'P_17' ] := sxml2num( xmlWartoscH( hPozycje, 'P_17' ) )
      hDane[ 'P_18' ] := sxml2num( xmlWartoscH( hPozycje, 'P_18' ) )
      hDane[ 'P_19' ] := sxml2num( xmlWartoscH( hPozycje, 'P_19' ) )
      hDane[ 'P_20' ] := sxml2num( xmlWartoscH( hPozycje, 'P_20' ) )
      hDane[ 'P_21' ] := sxml2num( xmlWartoscH( hPozycje, 'P_21' ) )
      hDane[ 'P_22' ] := sxml2num( xmlWartoscH( hPozycje, 'P_22' ) )
      hDane[ 'P_23' ] := sxml2num( xmlWartoscH( hPozycje, 'P_23' ) )
      hDane[ 'P_24' ] := sxml2num( xmlWartoscH( hPozycje, 'P_24' ) )
      hDane[ 'P_25' ] := sxml2num( xmlWartoscH( hPozycje, 'P_25' ) )
      hDane[ 'P_26' ] := sxml2num( xmlWartoscH( hPozycje, 'P_26' ) )
      hDane[ 'P_27' ] := sxml2num( xmlWartoscH( hPozycje, 'P_27' ) )
      hDane[ 'P_28' ] := sxml2num( xmlWartoscH( hPozycje, 'P_28' ) )
      hDane[ 'P_29' ] := sxml2num( xmlWartoscH( hPozycje, 'P_29' ) )
      hDane[ 'P_30' ] := sxml2num( xmlWartoscH( hPozycje, 'P_30' ) )
      hDane[ 'P_31' ] := sxml2num( xmlWartoscH( hPozycje, 'P_31' ) )
      hDane[ 'P_32' ] := sxml2num( xmlWartoscH( hPozycje, 'P_32' ) )
      hDane[ 'P_33' ] := sxml2num( xmlWartoscH( hPozycje, 'P_33' ) )
      hDane[ 'P_34' ] := sxml2num( xmlWartoscH( hPozycje, 'P_34' ) )
      hDane[ 'P_35' ] := sxml2num( xmlWartoscH( hPozycje, 'P_35' ) )
      hDane[ 'P_36' ] := sxml2num( xmlWartoscH( hPozycje, 'P_36' ) )
      hDane[ 'P_37' ] := sxml2num( xmlWartoscH( hPozycje, 'P_37' ) )
      hDane[ 'P_38' ] := sxml2num( xmlWartoscH( hPozycje, 'P_38' ) )
      hDane[ 'P_39' ] := sxml2num( xmlWartoscH( hPozycje, 'P_39' ) )
      hDane[ 'P_40' ] := sxml2num( xmlWartoscH( hPozycje, 'P_40' ) )
      hDane[ 'P_41' ] := sxml2num( xmlWartoscH( hPozycje, 'P_41' ) )
      hDane[ 'P_42' ] := sxml2num( xmlWartoscH( hPozycje, 'P_42' ) )
      hDane[ 'P_43' ] := sxml2num( xmlWartoscH( hPozycje, 'P_43' ) )
      hDane[ 'P_44' ] := sxml2num( xmlWartoscH( hPozycje, 'P_44' ) )
      hDane[ 'P_45' ] := sxml2num( xmlWartoscH( hPozycje, 'P_45' ) )
      hDane[ 'P_46' ] := sxml2num( xmlWartoscH( hPozycje, 'P_46' ) )
      hDane[ 'P_47' ] := sxml2num( xmlWartoscH( hPozycje, 'P_47' ) )
      hDane[ 'P_48' ] := sxml2num( xmlWartoscH( hPozycje, 'P_48' ) )
      hDane[ 'P_49' ] := sxml2num( xmlWartoscH( hPozycje, 'P_49' ) )
      hDane[ 'P_50' ] := sxml2num( xmlWartoscH( hPozycje, 'P_50' ) )
      hDane[ 'P_51' ] := sxml2num( xmlWartoscH( hPozycje, 'P_51' ) )
      hDane[ 'P_52' ] := sxml2num( xmlWartoscH( hPozycje, 'P_52' ) )
      hDane[ 'P_53' ] := sxml2num( xmlWartoscH( hPozycje, 'P_53' ) )
      hDane[ 'P_54' ] := sxml2num( xmlWartoscH( hPozycje, 'P_54' ) )
      hDane[ 'P_55' ] := iif( xmlWartoscH( hPozycje, 'P_55' ) == '1', '1', '0' )
      hDane[ 'P_56' ] := iif( xmlWartoscH( hPozycje, 'P_56' ) == '1', '1', '0' )
      hDane[ 'P_57' ] := iif( xmlWartoscH( hPozycje, 'P_57' ) == '1', '1', '0' )
      hDane[ 'P_58' ] := iif( xmlWartoscH( hPozycje, 'P_58' ) == '1', '1', '0' )
      hDane[ 'P_59' ] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '1', '1', '0' )
      hDane[ 'P_60' ] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
      hDane[ 'P_61' ] := xmlWartoscH( hPozycje, 'P_61' )
      hDane[ 'P_62' ] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
      hDane[ 'P_63' ] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
      hDane[ 'P_64' ] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
      hDane[ 'P_65' ] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
      hDane[ 'P_66' ] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
      hDane[ 'P_67' ] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
      hDane[ 'P_68' ] := sxml2num( xmlWartoscH( hPozycje, 'P_68' ) )
      hDane[ 'P_69' ] := sxml2num( xmlWartoscH( hPozycje, 'P_69' ) )
      hDane[ 'P_ORDZU' ] := xmlWartoscH( hPozycje, 'P_ORDZU' )
   ELSE
      hDane[ 'JestDeklaracja' ] := .F.
   ENDIF

   hDane[ 'Sprzedaz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'SprzedazWiersz' )

   IF Len( hDane[ 'Sprzedaz' ] ) > 0
      hDane[ 'JestSprzedaz' ] := .T.
      AEval( hDane[ 'Sprzedaz' ], { | aPoz |
         aPoz[ 'KodKrajuNadaniaTIN' ] := xmlWartoscH( aPoz, 'KodKrajuNadaniaTIN' )
         aPoz[ 'TypDokumentu' ] := xmlWartoscH( aPoz, 'TypDokumentu' )
         aPoz[ 'GTU' ] := ''
         IF ( aPoz[ 'GTU_01' ] := iif( xmlWartoscH( aPoz, 'GTU_01' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_01 '
         ENDIF
         IF ( aPoz[ 'GTU_02' ] := iif( xmlWartoscH( aPoz, 'GTU_02' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_02 '
         ENDIF
         IF ( aPoz[ 'GTU_03' ] := iif( xmlWartoscH( aPoz, 'GTU_03' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_03 '
         ENDIF
         IF ( aPoz[ 'GTU_04' ] := iif( xmlWartoscH( aPoz, 'GTU_04' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_04 '
         ENDIF
         IF ( aPoz[ 'GTU_05' ] := iif( xmlWartoscH( aPoz, 'GTU_05' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_05 '
         ENDIF
         IF ( aPoz[ 'GTU_06' ] := iif( xmlWartoscH( aPoz, 'GTU_06' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_06 '
         ENDIF
         IF ( aPoz[ 'GTU_07' ] := iif( xmlWartoscH( aPoz, 'GTU_07' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_07 '
         ENDIF
         IF ( aPoz[ 'GTU_08' ] := iif( xmlWartoscH( aPoz, 'GTU_08' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_08 '
         ENDIF
         IF ( aPoz[ 'GTU_09' ] := iif( xmlWartoscH( aPoz, 'GTU_09' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_09 '
         ENDIF
         IF ( aPoz[ 'GTU_10' ] := iif( xmlWartoscH( aPoz, 'GTU_10' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_10 '
         ENDIF
         IF ( aPoz[ 'GTU_11' ] := iif( xmlWartoscH( aPoz, 'GTU_11' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_11 '
         ENDIF
         IF ( aPoz[ 'GTU_12' ] := iif( xmlWartoscH( aPoz, 'GTU_12' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_12 '
         ENDIF
         IF ( aPoz[ 'GTU_13' ] := iif( xmlWartoscH( aPoz, 'GTU_13' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_13 '
         ENDIF
         aPoz[ 'Procedura' ] := ''
         IF ( aPoz[ 'SW' ] := iif( xmlWartoscH( aPoz, 'SW' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'SW '
         ENDIF
         IF ( aPoz[ 'EE' ] := iif( xmlWartoscH( aPoz, 'EE' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'EE '
         ENDIF
         IF ( aPoz[ 'TP' ] := iif( xmlWartoscH( aPoz, 'TP' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TP '
         ENDIF
         IF ( aPoz[ 'TT_WNT' ] := iif( xmlWartoscH( aPoz, 'TT_WNT' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TT_WNT '
         ENDIF
         IF ( aPoz[ 'TT_D' ] := iif( xmlWartoscH( aPoz, 'TT_D' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TT_D '
         ENDIF
         IF ( aPoz[ 'MR_T' ] := iif( xmlWartoscH( aPoz, 'MR_T' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MR_T '
         ENDIF
         IF ( aPoz[ 'MR_UZ' ] := iif( xmlWartoscH( aPoz, 'MR_UZ' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MR_UZ '
         ENDIF
         IF ( aPoz[ 'I_42' ] := iif( xmlWartoscH( aPoz, 'I_42' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'I_42 '
         ENDIF
         IF ( aPoz[ 'I_63' ] := iif( xmlWartoscH( aPoz, 'I_63' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'I_63 '
         ENDIF
         IF ( aPoz[ 'B_SPV' ] := iif( xmlWartoscH( aPoz, 'B_SPV' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_SPV '
         ENDIF
         IF ( aPoz[ 'B_SPV_DOSTAWA' ] := iif( xmlWartoscH( aPoz, 'B_SPV_DOSTAWA' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_SPV_DOSTAWA '
         ENDIF
         IF ( aPoz[ 'B_MPV_PROWIZJA' ] := iif( xmlWartoscH( aPoz, 'B_MPV_PROWIZJA' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_MPV_PROWIZJA '
         ENDIF
         IF ( aPoz[ 'MPP' ] := iif( xmlWartoscH( aPoz, 'MPP' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MPP '
         ENDIF
         aPoz[ 'KorektaPodstawyOpodt' ] := iif( xmlWartoscH( aPoz, 'KorektaPodstawyOpodt' ) == '1', '1', '0' )
         aPoz[ 'TerminPlatnosci' ] := xmlWartoscH( aPoz, 'TerminPlatnosci', '' )
         aPoz[ 'DataZaplaty' ] := xmlWartoscH( aPoz, 'DataZaplaty', '' )
         aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
         aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
         aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
         aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
         aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
         aPoz[ 'K_15' ] := sxml2num( xmlWartoscH( aPoz, 'K_15' ), 0 )
         aPoz[ 'K_16' ] := sxml2num( xmlWartoscH( aPoz, 'K_16' ), 0 )
         aPoz[ 'K_17' ] := sxml2num( xmlWartoscH( aPoz, 'K_17' ), 0 )
         aPoz[ 'K_18' ] := sxml2num( xmlWartoscH( aPoz, 'K_18' ), 0 )
         aPoz[ 'K_19' ] := sxml2num( xmlWartoscH( aPoz, 'K_19' ), 0 )
         aPoz[ 'K_20' ] := sxml2num( xmlWartoscH( aPoz, 'K_20' ), 0 )
         aPoz[ 'K_21' ] := sxml2num( xmlWartoscH( aPoz, 'K_21' ), 0 )
         aPoz[ 'K_22' ] := sxml2num( xmlWartoscH( aPoz, 'K_22' ), 0 )
         aPoz[ 'K_23' ] := sxml2num( xmlWartoscH( aPoz, 'K_23' ), 0 )
         aPoz[ 'K_24' ] := sxml2num( xmlWartoscH( aPoz, 'K_24' ), 0 )
         aPoz[ 'K_25' ] := sxml2num( xmlWartoscH( aPoz, 'K_25' ), 0 )
         aPoz[ 'K_26' ] := sxml2num( xmlWartoscH( aPoz, 'K_26' ), 0 )
         aPoz[ 'K_27' ] := sxml2num( xmlWartoscH( aPoz, 'K_27' ), 0 )
         aPoz[ 'K_28' ] := sxml2num( xmlWartoscH( aPoz, 'K_28' ), 0 )
         aPoz[ 'K_29' ] := sxml2num( xmlWartoscH( aPoz, 'K_29' ), 0 )
         aPoz[ 'K_30' ] := sxml2num( xmlWartoscH( aPoz, 'K_30' ), 0 )
         aPoz[ 'K_31' ] := sxml2num( xmlWartoscH( aPoz, 'K_31' ), 0 )
         aPoz[ 'K_32' ] := sxml2num( xmlWartoscH( aPoz, 'K_32' ), 0 )
         aPoz[ 'K_33' ] := sxml2num( xmlWartoscH( aPoz, 'K_33' ), 0 )
         aPoz[ 'K_34' ] := sxml2num( xmlWartoscH( aPoz, 'K_34' ), 0 )
         aPoz[ 'K_35' ] := sxml2num( xmlWartoscH( aPoz, 'K_35' ), 0 )
         aPoz[ 'K_36' ] := sxml2num( xmlWartoscH( aPoz, 'K_36' ), 0 )
         aPoz[ 'SprzedazVAT_Marza' ] := sxml2num( xmlWartoscH( aPoz, 'SprzedazVAT_Marza' ), 0 )
         IF ! hb_HHasKey( aPoz, 'DataSprzedazy' )
            aPoz[ 'DataSprzedazy' ] := ""
         ENDIF
         aPoz[ 'Sumuj' ] := iif( AllTrim( aPoz[ 'TypDokumentu' ] ) == "FP" .OR. ;
            ( At( "MR_UZ", aPoz[ 'Procedura' ] ) > 0 .AND. ( aPoz[ 'K_10' ] < 0 .OR. ;
            aPoz[ 'K_11' ] < 0 .OR. aPoz[ 'K_12' ] < 0 .OR. aPoz[ 'K_13' ] < 0 .OR. ;
            aPoz[ 'K_14' ] < 0 .OR. aPoz[ 'K_15' ] < 0 .OR. aPoz[ 'K_17' ] < 0 .OR. ;
            aPoz[ 'K_19' ] < 0 .OR. aPoz[ 'K_21' ] < 0 .OR. aPoz[ 'K_22' ] < 0 ) ), 0, 1 )
      } )
   ELSE
      hDane[ 'JestSprzedaz' ] := .F.
   ENDIF

   hDane[ 'Zakup' ] := edekXmlGrupaTab( oDoc, 'JPK', 'ZakupWiersz' )
   IF Len( hDane[ 'Zakup' ] ) > 0
      hDane[ 'JestZakup' ] := .T.
      AEval( hDane[ 'Zakup' ], { | aPoz |
         aPoz[ 'KodKrajuNadaniaTIN' ] := xmlWartoscH( aPoz, 'KodKrajuNadaniaTIN' )
         aPoz[ 'DokumentZakupu' ] := xmlWartoscH( aPoz, 'DokumentZakupu' )
         aPoz[ 'MPP' ] := iif( xmlWartoscH( aPoz, 'MPP' ) == '1', '1', '0' )
         aPoz[ 'IMP' ] := iif( xmlWartoscH( aPoz, 'IMP' ) == '1', '1', '0' )
         aPoz[ 'K_40' ] := sxml2num( xmlWartoscH( aPoz, 'K_40' ), 0 )
         aPoz[ 'K_41' ] := sxml2num( xmlWartoscH( aPoz, 'K_41' ), 0 )
         aPoz[ 'K_42' ] := sxml2num( xmlWartoscH( aPoz, 'K_42' ), 0 )
         aPoz[ 'K_43' ] := sxml2num( xmlWartoscH( aPoz, 'K_43' ), 0 )
         aPoz[ 'K_44' ] := sxml2num( xmlWartoscH( aPoz, 'K_44' ), 0 )
         aPoz[ 'K_45' ] := sxml2num( xmlWartoscH( aPoz, 'K_45' ), 0 )
         aPoz[ 'K_46' ] := sxml2num( xmlWartoscH( aPoz, 'K_46' ), 0 )
         aPoz[ 'K_47' ] := sxml2num( xmlWartoscH( aPoz, 'K_47' ), 0 )
         aPoz[ 'ZakupVAT_Marza' ] := sxml2num( xmlWartoscH( aPoz, 'ZakupVAT_Marza' ), 0 )
         IF ! hb_HHasKey( aPoz, 'DataWplywu' )
            aPoz[ 'DataWplywu' ] := ""
         ENDIF
      } )
   ELSE
      hDane[ 'JestZakup' ] := .F.
   ENDIF

   hDane[ 'SprzedazCtrl' ] := edekXmlGrupa( oDoc, 'SprzedazCtrl' )
   hDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] := sxml2num( xmlWartoscH( hDane[ 'SprzedazCtrl' ], 'LiczbaWierszySprzedazy' ) )
   hDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] := sxml2num( xmlWartoscH( hDane[ 'SprzedazCtrl' ], 'PodatekNalezny' ) )

   hDane[ 'ZakupCtrl' ] := edekXmlGrupa( oDoc, 'ZakupCtrl' )
   hDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] := sxml2num( xmlWartoscH( hDane[ 'ZakupCtrl' ], 'LiczbaWierszyZakupow' ) )
   hDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] := sxml2num( xmlWartoscH( hDane[ 'ZakupCtrl' ], 'PodatekNaliczony' ) )

   RETURN hDane

/*----------------------------------------------------------------------*/

FUNCTION DaneXML_JPKV7w2( oDoc, cNrRef, hNaglowek )

   LOCAL hPodmiot1, cTmp, aTemp, hPozycje
   LOCAL hDane := hb_Hash()

   IF !HB_ISHASH( hNaglowek )
      hNaglowek := edekXmlNaglowek( oDoc )
   ENDIF

   hPodmiot1 := edekXmlPodmiot1( oDoc )

   aTemp := edekXmlGrupa( oDoc, 'Naglowek' )
   hDane[ 'KodFormularza' ] := xmlWartoscH( aTemp, 'KodFormularza' )
   hDane[ 'WariantFormularza' ] := xmlWartoscH( aTemp, 'WariantFormularza' )
   hDane[ 'KodFormularzaDekl' ] := xmlWartoscH( aTemp, 'KodFormularzaDekl' )
   hDane[ 'WariantFormularzaDekl' ] := xmlWartoscH( aTemp, 'WariantFormularzaDekl' )
   hDane[ 'CelZlozenia' ] := xmlWartoscH( aTemp, 'CelZlozenia' )
   hDane[ 'DataWytworzeniaJPK' ] := xmlWartoscH( aTemp, 'DataWytworzeniaJPK' )
   hDane[ 'NazwaSystemu' ] :=  xmlWartoscH( aTemp, 'NazwaSystemu' )
   hDane[ 'KodUrzedu' ] := xmlWartoscH( aTemp, 'KodUrzedu' )
   hDane[ 'Rok' ] := sxml2num( xmlWartoscH( aTemp, 'Rok' ) )
   hDane[ 'Miesiac' ] := sxml2num( xmlWartoscH( aTemp, 'Miesiac' ), 0 )
   hDane[ 'Kwartal' ] := sxml2num( xmlWartoscH( aTemp, 'Kwartal' ), 0 )
   cTmp := xmlWartoscH( aTemp, 'KodUrzedu' )
   hDane[ 'UrzadSkarbowy' ] := iif( cTmp != '', KodUS2Nazwa( cTmp ), '' )
   hDane[ 'NrRef' ] := iif( HB_ISSTRING( cNrRef ), cNrRef, '' )

   hDane[ 'CelZlozenia1' ] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '1', '1', '0' )
   hDane[ 'CelZlozenia2' ] := iif( xmlWartoscH( hNaglowek, 'CelZlozenia' ) == '2', '1', '0' )
   hDane[ 'PodmiotSpolka' ] := iif( !xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   hDane[ 'PodmiotOsoba' ] := iif( xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. ), '1', '0' )
   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane[ 'PodmiotNazwa' ] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' ) + ', ' ;
        + xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' ) + ', ' + xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
      hDane[ 'Email' ] := xmlWartoscH( hPodmiot1, 'tns:Email' )
      hDane[ 'Telefon' ] := xmlWartoscH( hPodmiot1, 'tns:Telefon' )
      hDane[ 'NIP' ] := xmlWartoscH( hPodmiot1, 'etd:NIP' )
   ELSE
      hDane[ 'PodmiotNazwa' ] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane[ 'Email' ] := xmlWartoscH( hPodmiot1, 'Email' )
      hDane[ 'Telefon' ] := xmlWartoscH( hPodmiot1, 'Telefon' )
      hDane[ 'NIP' ] := xmlWartoscH( hPodmiot1, 'NIP' )
   ENDIF

   IF xmlWartoscH( hPodmiot1, 'lOsobaFizyczna', .T. )
      hDane[ 'P_8_N' ] := ''
      hDane[ 'P_8_R' ] := ''
      hDane[ 'P_9_N' ] := xmlWartoscH( hPodmiot1, 'etd:Nazwisko' )
      hDane[ 'P_9_I' ] := xmlWartoscH( hPodmiot1, 'etd:ImiePierwsze' )
      hDane[ 'P_9_D' ] := xmlWartoscH( hPodmiot1, 'etd:DataUrodzenia' )
      hDane[ 'P_9_E' ] := xmlWartoscH( hPodmiot1, 'tns:Email' )
      hDane[ 'P_9_T' ] := xmlWartoscH( hPodmiot1, 'tns:Telefon' )
   ELSE
      hDane[ 'P_8_N' ] := xmlWartoscH( hPodmiot1, 'PelnaNazwa' )
      hDane[ 'P_8_R' ] := xmlWartoscH( hPodmiot1, 'NIP' )
      hDane[ 'P_9_N' ] := ''
      hDane[ 'P_9_I' ] := ''
      hDane[ 'P_9_D' ] := ''
      hDane[ 'P_9_E' ] := xmlWartoscH( hPodmiot1, 'Email' )
      hDane[ 'P_9_T' ] := xmlWartoscH( hPodmiot1, 'Telefon' )
   ENDIF

   hPozycje := edekXmlGrupa( oDoc, 'PozycjeSzczegolowe' )

   IF Len( hPozycje ) > 0
      hDane[ 'JestDeklaracja' ] := .T.
      hDane[ 'P_10' ] := sxml2num( xmlWartoscH( hPozycje, 'P_10' ) )
      hDane[ 'P_11' ] := sxml2num( xmlWartoscH( hPozycje, 'P_11' ) )
      hDane[ 'P_12' ] := sxml2num( xmlWartoscH( hPozycje, 'P_12' ) )
      hDane[ 'P_13' ] := sxml2num( xmlWartoscH( hPozycje, 'P_13' ) )
      hDane[ 'P_14' ] := sxml2num( xmlWartoscH( hPozycje, 'P_14' ) )
      hDane[ 'P_15' ] := sxml2num( xmlWartoscH( hPozycje, 'P_15' ) )
      hDane[ 'P_16' ] := sxml2num( xmlWartoscH( hPozycje, 'P_16' ) )
      hDane[ 'P_17' ] := sxml2num( xmlWartoscH( hPozycje, 'P_17' ) )
      hDane[ 'P_18' ] := sxml2num( xmlWartoscH( hPozycje, 'P_18' ) )
      hDane[ 'P_19' ] := sxml2num( xmlWartoscH( hPozycje, 'P_19' ) )
      hDane[ 'P_20' ] := sxml2num( xmlWartoscH( hPozycje, 'P_20' ) )
      hDane[ 'P_21' ] := sxml2num( xmlWartoscH( hPozycje, 'P_21' ) )
      hDane[ 'P_22' ] := sxml2num( xmlWartoscH( hPozycje, 'P_22' ) )
      hDane[ 'P_23' ] := sxml2num( xmlWartoscH( hPozycje, 'P_23' ) )
      hDane[ 'P_24' ] := sxml2num( xmlWartoscH( hPozycje, 'P_24' ) )
      hDane[ 'P_25' ] := sxml2num( xmlWartoscH( hPozycje, 'P_25' ) )
      hDane[ 'P_26' ] := sxml2num( xmlWartoscH( hPozycje, 'P_26' ) )
      hDane[ 'P_27' ] := sxml2num( xmlWartoscH( hPozycje, 'P_27' ) )
      hDane[ 'P_28' ] := sxml2num( xmlWartoscH( hPozycje, 'P_28' ) )
      hDane[ 'P_29' ] := sxml2num( xmlWartoscH( hPozycje, 'P_29' ) )
      hDane[ 'P_30' ] := sxml2num( xmlWartoscH( hPozycje, 'P_30' ) )
      hDane[ 'P_31' ] := sxml2num( xmlWartoscH( hPozycje, 'P_31' ) )
      hDane[ 'P_32' ] := sxml2num( xmlWartoscH( hPozycje, 'P_32' ) )
      hDane[ 'P_33' ] := sxml2num( xmlWartoscH( hPozycje, 'P_33' ) )
      hDane[ 'P_34' ] := sxml2num( xmlWartoscH( hPozycje, 'P_34' ) )
      hDane[ 'P_35' ] := sxml2num( xmlWartoscH( hPozycje, 'P_35' ) )
      hDane[ 'P_36' ] := sxml2num( xmlWartoscH( hPozycje, 'P_36' ) )
      hDane[ 'P_37' ] := sxml2num( xmlWartoscH( hPozycje, 'P_37' ) )
      hDane[ 'P_38' ] := sxml2num( xmlWartoscH( hPozycje, 'P_38' ) )
      hDane[ 'P_39' ] := sxml2num( xmlWartoscH( hPozycje, 'P_39' ) )
      hDane[ 'P_40' ] := sxml2num( xmlWartoscH( hPozycje, 'P_40' ) )
      hDane[ 'P_41' ] := sxml2num( xmlWartoscH( hPozycje, 'P_41' ) )
      hDane[ 'P_42' ] := sxml2num( xmlWartoscH( hPozycje, 'P_42' ) )
      hDane[ 'P_43' ] := sxml2num( xmlWartoscH( hPozycje, 'P_43' ) )
      hDane[ 'P_44' ] := sxml2num( xmlWartoscH( hPozycje, 'P_44' ) )
      hDane[ 'P_45' ] := sxml2num( xmlWartoscH( hPozycje, 'P_45' ) )
      hDane[ 'P_46' ] := sxml2num( xmlWartoscH( hPozycje, 'P_46' ) )
      hDane[ 'P_47' ] := sxml2num( xmlWartoscH( hPozycje, 'P_47' ) )
      hDane[ 'P_48' ] := sxml2num( xmlWartoscH( hPozycje, 'P_48' ) )
      hDane[ 'P_49' ] := sxml2num( xmlWartoscH( hPozycje, 'P_49' ) )
      hDane[ 'P_50' ] := sxml2num( xmlWartoscH( hPozycje, 'P_50' ) )
      hDane[ 'P_51' ] := sxml2num( xmlWartoscH( hPozycje, 'P_51' ) )
      hDane[ 'P_52' ] := sxml2num( xmlWartoscH( hPozycje, 'P_52' ) )
      hDane[ 'P_53' ] := sxml2num( xmlWartoscH( hPozycje, 'P_53' ) )
      hDane[ 'P_54' ] := sxml2num( xmlWartoscH( hPozycje, 'P_54' ) )
      hDane[ 'P_540' ] := iif( xmlWartoscH( hPozycje, 'P_540' ) == '1', '1', '0' )
      hDane[ 'P_55' ] := iif( xmlWartoscH( hPozycje, 'P_55' ) == '1', '1', '0' )
      hDane[ 'P_56' ] := iif( xmlWartoscH( hPozycje, 'P_56' ) == '1', '1', '0' )
      hDane[ 'P_560' ] := iif( xmlWartoscH( hPozycje, 'P_560' ) == '1', '1', '0' )
      hDane[ 'P_57' ] := iif( xmlWartoscH( hPozycje, 'P_57' ) == '1', '1', '0' )
      hDane[ 'P_58' ] := iif( xmlWartoscH( hPozycje, 'P_58' ) == '1', '1', '0' )
      hDane[ 'P_59' ] := iif( xmlWartoscH( hPozycje, 'P_59' ) == '1', '1', '0' )
      hDane[ 'P_60' ] := sxml2num( xmlWartoscH( hPozycje, 'P_60' ) )
      hDane[ 'P_61' ] := xmlWartoscH( hPozycje, 'P_61' )
      hDane[ 'P_62' ] := sxml2num( xmlWartoscH( hPozycje, 'P_62' ) )
      hDane[ 'P_63' ] := iif( xmlWartoscH( hPozycje, 'P_63' ) == '1', '1', '0' )
      hDane[ 'P_64' ] := iif( xmlWartoscH( hPozycje, 'P_64' ) == '1', '1', '0' )
      hDane[ 'P_65' ] := iif( xmlWartoscH( hPozycje, 'P_65' ) == '1', '1', '0' )
      hDane[ 'P_66' ] := iif( xmlWartoscH( hPozycje, 'P_66' ) == '1', '1', '0' )
      hDane[ 'P_660' ] := iif( xmlWartoscH( hPozycje, 'P_660' ) == '1', '1', '0' )
      hDane[ 'P_67' ] := iif( xmlWartoscH( hPozycje, 'P_67' ) == '1', '1', '0' )
      hDane[ 'P_68' ] := sxml2num( xmlWartoscH( hPozycje, 'P_68' ) )
      hDane[ 'P_69' ] := sxml2num( xmlWartoscH( hPozycje, 'P_69' ) )
      hDane[ 'P_ORDZU' ] := xmlWartoscH( hPozycje, 'P_ORDZU' )
   ELSE
      hDane[ 'JestDeklaracja' ] := .F.
   ENDIF

   hDane[ 'Sprzedaz' ] := edekXmlGrupaTab( oDoc, 'JPK', 'SprzedazWiersz' )

   IF Len( hDane[ 'Sprzedaz' ] ) > 0
      hDane[ 'JestSprzedaz' ] := .T.
      AEval( hDane[ 'Sprzedaz' ], { | aPoz |
         aPoz[ 'KodKrajuNadaniaTIN' ] := xmlWartoscH( aPoz, 'KodKrajuNadaniaTIN' )
         aPoz[ 'TypDokumentu' ] := xmlWartoscH( aPoz, 'TypDokumentu' )
         aPoz[ 'GTU' ] := ''
         IF ( aPoz[ 'GTU_01' ] := iif( xmlWartoscH( aPoz, 'GTU_01' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_01 '
         ENDIF
         IF ( aPoz[ 'GTU_02' ] := iif( xmlWartoscH( aPoz, 'GTU_02' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_02 '
         ENDIF
         IF ( aPoz[ 'GTU_03' ] := iif( xmlWartoscH( aPoz, 'GTU_03' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_03 '
         ENDIF
         IF ( aPoz[ 'GTU_04' ] := iif( xmlWartoscH( aPoz, 'GTU_04' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_04 '
         ENDIF
         IF ( aPoz[ 'GTU_05' ] := iif( xmlWartoscH( aPoz, 'GTU_05' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_05 '
         ENDIF
         IF ( aPoz[ 'GTU_06' ] := iif( xmlWartoscH( aPoz, 'GTU_06' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_06 '
         ENDIF
         IF ( aPoz[ 'GTU_07' ] := iif( xmlWartoscH( aPoz, 'GTU_07' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_07 '
         ENDIF
         IF ( aPoz[ 'GTU_08' ] := iif( xmlWartoscH( aPoz, 'GTU_08' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_08 '
         ENDIF
         IF ( aPoz[ 'GTU_09' ] := iif( xmlWartoscH( aPoz, 'GTU_09' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_09 '
         ENDIF
         IF ( aPoz[ 'GTU_10' ] := iif( xmlWartoscH( aPoz, 'GTU_10' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_10 '
         ENDIF
         IF ( aPoz[ 'GTU_11' ] := iif( xmlWartoscH( aPoz, 'GTU_11' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_11 '
         ENDIF
         IF ( aPoz[ 'GTU_12' ] := iif( xmlWartoscH( aPoz, 'GTU_12' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_12 '
         ENDIF
         IF ( aPoz[ 'GTU_13' ] := iif( xmlWartoscH( aPoz, 'GTU_13' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'GTU' ] := aPoz[ 'GTU' ] + 'GTU_13 '
         ENDIF
         aPoz[ 'Procedura' ] := ''
         IF ( aPoz[ 'WSTO_EE' ] := iif( xmlWartoscH( aPoz, 'WSTO_EE' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'WSTO_EE '
         ENDIF
         IF ( aPoz[ 'IED' ] := iif( xmlWartoscH( aPoz, 'IED' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'IED '
         ENDIF
         IF ( aPoz[ 'TP' ] := iif( xmlWartoscH( aPoz, 'TP' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TP '
         ENDIF
         IF ( aPoz[ 'TT_WNT' ] := iif( xmlWartoscH( aPoz, 'TT_WNT' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TT_WNT '
         ENDIF
         IF ( aPoz[ 'TT_D' ] := iif( xmlWartoscH( aPoz, 'TT_D' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'TT_D '
         ENDIF
         IF ( aPoz[ 'MR_T' ] := iif( xmlWartoscH( aPoz, 'MR_T' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MR_T '
         ENDIF
         IF ( aPoz[ 'MR_UZ' ] := iif( xmlWartoscH( aPoz, 'MR_UZ' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MR_UZ '
         ENDIF
         IF ( aPoz[ 'I_42' ] := iif( xmlWartoscH( aPoz, 'I_42' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'I_42 '
         ENDIF
         IF ( aPoz[ 'I_63' ] := iif( xmlWartoscH( aPoz, 'I_63' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'I_63 '
         ENDIF
         IF ( aPoz[ 'B_SPV' ] := iif( xmlWartoscH( aPoz, 'B_SPV' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_SPV '
         ENDIF
         IF ( aPoz[ 'B_SPV_DOSTAWA' ] := iif( xmlWartoscH( aPoz, 'B_SPV_DOSTAWA' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_SPV_DOSTAWA '
         ENDIF
         IF ( aPoz[ 'B_MPV_PROWIZJA' ] := iif( xmlWartoscH( aPoz, 'B_MPV_PROWIZJA' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'B_MPV_PROWIZJA '
         ENDIF
         IF ( aPoz[ 'MPP' ] := iif( xmlWartoscH( aPoz, 'MPP' ) == '1', '1', '0' ) ) == '1'
            aPoz[ 'Procedura' ] := aPoz[ 'Procedura' ] + 'MPP '
         ENDIF
         aPoz[ 'KorektaPodstawyOpodt' ] := iif( xmlWartoscH( aPoz, 'KorektaPodstawyOpodt' ) == '1', '1', '0' )
         aPoz[ 'TerminPlatnosci' ] := xmlWartoscH( aPoz, 'TerminPlatnosci', '' )
         aPoz[ 'DataZaplaty' ] := xmlWartoscH( aPoz, 'DataZaplaty', '' )
         aPoz[ 'K_10' ] := sxml2num( xmlWartoscH( aPoz, 'K_10' ), 0 )
         aPoz[ 'K_11' ] := sxml2num( xmlWartoscH( aPoz, 'K_11' ), 0 )
         aPoz[ 'K_12' ] := sxml2num( xmlWartoscH( aPoz, 'K_12' ), 0 )
         aPoz[ 'K_13' ] := sxml2num( xmlWartoscH( aPoz, 'K_13' ), 0 )
         aPoz[ 'K_14' ] := sxml2num( xmlWartoscH( aPoz, 'K_14' ), 0 )
         aPoz[ 'K_15' ] := sxml2num( xmlWartoscH( aPoz, 'K_15' ), 0 )
         aPoz[ 'K_16' ] := sxml2num( xmlWartoscH( aPoz, 'K_16' ), 0 )
         aPoz[ 'K_17' ] := sxml2num( xmlWartoscH( aPoz, 'K_17' ), 0 )
         aPoz[ 'K_18' ] := sxml2num( xmlWartoscH( aPoz, 'K_18' ), 0 )
         aPoz[ 'K_19' ] := sxml2num( xmlWartoscH( aPoz, 'K_19' ), 0 )
         aPoz[ 'K_20' ] := sxml2num( xmlWartoscH( aPoz, 'K_20' ), 0 )
         aPoz[ 'K_21' ] := sxml2num( xmlWartoscH( aPoz, 'K_21' ), 0 )
         aPoz[ 'K_22' ] := sxml2num( xmlWartoscH( aPoz, 'K_22' ), 0 )
         aPoz[ 'K_23' ] := sxml2num( xmlWartoscH( aPoz, 'K_23' ), 0 )
         aPoz[ 'K_24' ] := sxml2num( xmlWartoscH( aPoz, 'K_24' ), 0 )
         aPoz[ 'K_25' ] := sxml2num( xmlWartoscH( aPoz, 'K_25' ), 0 )
         aPoz[ 'K_26' ] := sxml2num( xmlWartoscH( aPoz, 'K_26' ), 0 )
         aPoz[ 'K_27' ] := sxml2num( xmlWartoscH( aPoz, 'K_27' ), 0 )
         aPoz[ 'K_28' ] := sxml2num( xmlWartoscH( aPoz, 'K_28' ), 0 )
         aPoz[ 'K_29' ] := sxml2num( xmlWartoscH( aPoz, 'K_29' ), 0 )
         aPoz[ 'K_30' ] := sxml2num( xmlWartoscH( aPoz, 'K_30' ), 0 )
         aPoz[ 'K_31' ] := sxml2num( xmlWartoscH( aPoz, 'K_31' ), 0 )
         aPoz[ 'K_32' ] := sxml2num( xmlWartoscH( aPoz, 'K_32' ), 0 )
         aPoz[ 'K_33' ] := sxml2num( xmlWartoscH( aPoz, 'K_33' ), 0 )
         aPoz[ 'K_34' ] := sxml2num( xmlWartoscH( aPoz, 'K_34' ), 0 )
         aPoz[ 'K_35' ] := sxml2num( xmlWartoscH( aPoz, 'K_35' ), 0 )
         aPoz[ 'K_36' ] := sxml2num( xmlWartoscH( aPoz, 'K_36' ), 0 )
         aPoz[ 'SprzedazVAT_Marza' ] := sxml2num( xmlWartoscH( aPoz, 'SprzedazVAT_Marza' ), 0 )
         IF ! hb_HHasKey( aPoz, 'DataSprzedazy' )
            aPoz[ 'DataSprzedazy' ] := ""
         ENDIF
         aPoz[ 'Sumuj' ] := iif( AllTrim( aPoz[ 'TypDokumentu' ] ) == "FP" .OR. ;
            ( At( "MR_UZ", aPoz[ 'Procedura' ] ) > 0 .AND. ( aPoz[ 'K_10' ] < 0 .OR. ;
            aPoz[ 'K_11' ] < 0 .OR. aPoz[ 'K_12' ] < 0 .OR. aPoz[ 'K_13' ] < 0 .OR. ;
            aPoz[ 'K_14' ] < 0 .OR. aPoz[ 'K_15' ] < 0 .OR. aPoz[ 'K_17' ] < 0 .OR. ;
            aPoz[ 'K_19' ] < 0 .OR. aPoz[ 'K_21' ] < 0 .OR. aPoz[ 'K_22' ] < 0 ) ), 0, 1 )
      } )
   ELSE
      hDane[ 'JestSprzedaz' ] := .F.
   ENDIF

   hDane[ 'Zakup' ] := edekXmlGrupaTab( oDoc, 'JPK', 'ZakupWiersz' )
   IF Len( hDane[ 'Zakup' ] ) > 0
      hDane[ 'JestZakup' ] := .T.
      AEval( hDane[ 'Zakup' ], { | aPoz |
         aPoz[ 'KodKrajuNadaniaTIN' ] := xmlWartoscH( aPoz, 'KodKrajuNadaniaTIN' )
         aPoz[ 'DokumentZakupu' ] := xmlWartoscH( aPoz, 'DokumentZakupu' )
         //aPoz[ 'MPP' ] := iif( xmlWartoscH( aPoz, 'MPP' ) == '1', '1', '0' )
         aPoz[ 'IMP' ] := iif( xmlWartoscH( aPoz, 'IMP' ) == '1', '1', '0' )
         aPoz[ 'K_40' ] := sxml2num( xmlWartoscH( aPoz, 'K_40' ), 0 )
         aPoz[ 'K_41' ] := sxml2num( xmlWartoscH( aPoz, 'K_41' ), 0 )
         aPoz[ 'K_42' ] := sxml2num( xmlWartoscH( aPoz, 'K_42' ), 0 )
         aPoz[ 'K_43' ] := sxml2num( xmlWartoscH( aPoz, 'K_43' ), 0 )
         aPoz[ 'K_44' ] := sxml2num( xmlWartoscH( aPoz, 'K_44' ), 0 )
         aPoz[ 'K_45' ] := sxml2num( xmlWartoscH( aPoz, 'K_45' ), 0 )
         aPoz[ 'K_46' ] := sxml2num( xmlWartoscH( aPoz, 'K_46' ), 0 )
         aPoz[ 'K_47' ] := sxml2num( xmlWartoscH( aPoz, 'K_47' ), 0 )
         aPoz[ 'ZakupVAT_Marza' ] := sxml2num( xmlWartoscH( aPoz, 'ZakupVAT_Marza' ), 0 )
         IF ! hb_HHasKey( aPoz, 'DataWplywu' )
            aPoz[ 'DataWplywu' ] := ""
         ENDIF
      } )
   ELSE
      hDane[ 'JestZakup' ] := .F.
   ENDIF

   hDane[ 'SprzedazCtrl' ] := edekXmlGrupa( oDoc, 'SprzedazCtrl' )
   hDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] := sxml2num( xmlWartoscH( hDane[ 'SprzedazCtrl' ], 'LiczbaWierszySprzedazy' ) )
   hDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] := sxml2num( xmlWartoscH( hDane[ 'SprzedazCtrl' ], 'PodatekNalezny' ) )

   hDane[ 'ZakupCtrl' ] := edekXmlGrupa( oDoc, 'ZakupCtrl' )
   hDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] := sxml2num( xmlWartoscH( hDane[ 'ZakupCtrl' ], 'LiczbaWierszyZakupow' ) )
   hDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] := sxml2num( xmlWartoscH( hDane[ 'ZakupCtrl' ], 'PodatekNaliczony' ) )

   RETURN hDane

/*----------------------------------------------------------------------*/

