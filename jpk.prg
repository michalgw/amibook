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

FUNCTION JPKData(nRok, nMiesiac, cDzien)
   RETURN Transform(nRok, "@L 9999") + '-' + Transform(nMiesiac, "@L 99") + '-' + Transform(Val(AllTrim(cDzien)), "@L 99")

/*----------------------------------------------------------------------*/

FUNCTION JPKStrND(cStr)
   IF Len( AllTrim( cStr ) ) == 0
      RETURN "brak"
   ELSE
      RETURN str2sxml( AllTrim( cStr ) )
   ENDIF

/*----------------------------------------------------------------------*/

FUNCTION jpk_pkpir(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2016/10/26/10262/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/" >' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_PKPIR (2)" wersjaSchemy="1-0" >JPK_PKPIR</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>2</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <DomyslnyKodWaluty>PLN</DomyslnyKodWaluty>' + nl
   cRes := cRes + '    <KodUrzedu>' + aDane['KodUrzedu'] + '</KodUrzedu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '    <IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '      <etd:NIP>' + trimnip(aDane['NIP']) + '</etd:NIP>' + nl
   cRes := cRes + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</etd:PelnaNazwa>' + nl
   cRes := cRes + '    </IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '    <AdresPodmiotu>' + nl
   cRes := cRes + '      <KodKraju>PL</KodKraju>' + nl
   cRes := cRes + '      <Wojewodztwo>' + str2sxml(AllTrim(aDane['Wojewodztwo'])) + '</Wojewodztwo>' + nl
   cRes := cRes + '      <Powiat>' + str2sxml(AllTrim(aDane['Powiat'])) + '</Powiat>' + nl
   cRes := cRes + '      <Gmina>' + str2sxml(AllTrim(aDane['Gmina'])) + '</Gmina>' + nl
   IF AllTrim(aDane['Ulica']) <> ''
      cRes := cRes + '      <Ulica>' + str2sxml(AllTrim(aDane['Ulica'])) + '</Ulica>' + nl
   ENDIF
   cRes := cRes + '      <NrDomu>' + str2sxml(AllTrim(aDane['NrDomu'])) + '</NrDomu>' + nl
   IF AllTrim(aDane['NrLokalu']) <> ''
      cRes := cRes + '      <NrLokalu>' + str2sxml(AllTrim(aDane['NrLokalu'])) + '</NrLokalu>' + nl
   ENDIF
   cRes := cRes + '      <Miejscowosc>' + str2sxml(AllTrim(aDane['Miejscowosc'])) + '</Miejscowosc>' + nl
   cRes := cRes + '      <KodPocztowy>' + str2sxml(AllTrim(aDane['KodPocztowy'])) + '</KodPocztowy>' + nl
   cRes := cRes + '      <Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   cRes := cRes + '  <PKPIRInfo>' + nl
   cRes := cRes + '      <P_1>' + TKwota2(aDane['P_1']) + '</P_1>' + nl
   cRes := cRes + '      <P_2>' + TKwota2(aDane['P_2']) + '</P_2>' + nl
   cRes := cRes + '      <P_3>' + TKwota2(aDane['P_3']) + '</P_3>' + nl
   cRes := cRes + '      <P_4>' + TKwota2(aDane['P_4']) + '</P_4>' + nl
   IF aDane['P_5']
      cRes := cRes + '      <P_5A>' + date2strxml(aDane['P_5A']) + '</P_5A>' + nl
      cRes := cRes + '      <P_5B>' + TKwota2(aDane['P_5B']) + '</P_5B>' + nl
   ENDIF
   cRes := cRes + '  </PKPIRInfo>' + nl
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <PKPIRWiersz typ="G">' + nl
      cRes := cRes + '    <K_1>' + AllTrim(Str(aDane['pozycje'][nI]['k1'])) + '</K_1>' + nl
      cRes := cRes + '    <K_2>' + JPKData(aDane['rok'], aDane['miesiac'], aDane['pozycje'][nI]['k2']) + '</K_2>' + nl
      cRes := cRes + '    <K_3>' + JPKStrND(aDane['pozycje'][nI]['k3']) + '</K_3>' + nl
      cRes := cRes + '    <K_4>' + JPKStrND(aDane['pozycje'][nI]['k4']) + '</K_4>' + nl
      cRes := cRes + '    <K_5>' + JPKStrND(aDane['pozycje'][nI]['k5']) + '</K_5>' + nl
      cRes := cRes + '    <K_6>' + JPKStrND(aDane['pozycje'][nI]['k6']) + '</K_6>' + nl
      cRes := cRes + '    <K_7>' + TKwota2(aDane['pozycje'][nI]['k7']) + '</K_7>' + nl
      cRes := cRes + '    <K_8>' + TKwota2(aDane['pozycje'][nI]['k8']) + '</K_8>' + nl
      cRes := cRes + '    <K_9>' + TKwota2(aDane['pozycje'][nI]['k9']) + '</K_9>' + nl
      cRes := cRes + '    <K_10>' + TKwota2(aDane['pozycje'][nI]['k10']) + '</K_10>' + nl
      cRes := cRes + '    <K_11>' + TKwota2(aDane['pozycje'][nI]['k11']) + '</K_11>' + nl
      cRes := cRes + '    <K_12>' + TKwota2(aDane['pozycje'][nI]['k13']) + '</K_12>' + nl
      cRes := cRes + '    <K_13>' + TKwota2(aDane['pozycje'][nI]['k14']) + '</K_13>' + nl
      cRes := cRes + '    <K_14>' + TKwota2(aDane['pozycje'][nI]['k15']) + '</K_14>' + nl
      cRes := cRes + '    <K_15>' + TKwota2(aDane['pozycje'][nI]['k16']) + '</K_15>' + nl
      IF ( aDane['pozycje'][nI]['k16w'] <> 0 ) .OR. ( Len( AllTrim( aDane['pozycje'][nI]['k16o'] ) ) > 0 )
         cRes := cRes + '    <K_16A>' + sxml2str(aDane['pozycje'][nI]['k16o']) + '</K_16A>' + nl
         cRes := cRes + '    <K_16B>' + TKwota2(aDane['pozycje'][nI]['k16w']) + '</K_16B>' + nl
      ENDIF
      IF AllTrim(aDane['pozycje'][nI]['k17']) <> ''
         cRes := cRes + '    <K_17>' + str2sxml(AllTrim(aDane['pozycje'][nI]['k17'])) + '</K_17>' + nl
      ENDIF
      cRes := cRes + '  </PKPIRWiersz>' + nl
   NEXT
   cRes := cRes + '  <PKPIRCtrl>' + nl
   cRes := cRes + '    <LiczbaWierszy>' + AllTrim(Str(aDane['LiczbaWierszy'])) + '</LiczbaWierszy>' + nl
   cRes := cRes + '    <SumaPrzychodow>' + TKwota2(aDane['SumaPrzychodow']) + '</SumaPrzychodow>' + nl
   cRes := cRes + '  </PKPIRCtrl>' + nl
   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_ewp(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2016/03/09/03097/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_EWP (1)" wersjaSchemy="1-0" >JPK_EWP</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>1</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <DomyslnyKodWaluty>PLN</DomyslnyKodWaluty>' + nl
   cRes := cRes + '    <KodUrzedu>' + aDane['KodUrzedu'] + '</KodUrzedu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '    <IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '      <etd:NIP>' + trimnip(aDane['NIP']) + '</etd:NIP>' + nl
   cRes := cRes + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</etd:PelnaNazwa>' + nl
   cRes := cRes + '    </IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '    <AdresPodmiotu>' + nl
   cRes := cRes + '      <etd:KodKraju>PL</etd:KodKraju>' + nl
   cRes := cRes + '      <etd:Wojewodztwo>' + str2sxml(AllTrim(aDane['Wojewodztwo'])) + '</etd:Wojewodztwo>' + nl
   cRes := cRes + '      <etd:Powiat>' + str2sxml(AllTrim(aDane['Powiat'])) + '</etd:Powiat>' + nl
   cRes := cRes + '      <etd:Gmina>' + str2sxml(AllTrim(aDane['Gmina'])) + '</etd:Gmina>' + nl
   IF AllTrim(aDane['Ulica']) <> ''
      cRes := cRes + '      <etd:Ulica>' + str2sxml(AllTrim(aDane['Ulica'])) + '</etd:Ulica>' + nl
   ENDIF
   cRes := cRes + '      <etd:NrDomu>' + str2sxml(AllTrim(aDane['NrDomu'])) + '</etd:NrDomu>' + nl
   IF AllTrim(aDane['NrLokalu']) <> ''
      cRes := cRes + '      <etd:NrLokalu>' + str2sxml(AllTrim(aDane['NrLokalu'])) + '</etd:NrLokalu>' + nl
   ENDIF
   cRes := cRes + '      <etd:Miejscowosc>' + str2sxml(AllTrim(aDane['Miejscowosc'])) + '</etd:Miejscowosc>' + nl
   cRes := cRes + '      <etd:KodPocztowy>' + str2sxml(AllTrim(aDane['KodPocztowy'])) + '</etd:KodPocztowy>' + nl
   cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <EWPWiersz typ="G">' + nl
      cRes := cRes + '    <K_1>' + AllTrim(Str(aDane['pozycje'][nI]['k1'])) + '</K_1>' + nl
      cRes := cRes + '    <K_2>' + AllTrim(aDane['pozycje'][nI]['k2']) + '</K_2>' + nl
      cRes := cRes + '    <K_3>' + AllTrim(aDane['pozycje'][nI]['k3']) + '</K_3>' + nl
      cRes := cRes + '    <K_4>' + JPKStrND(aDane['pozycje'][nI]['k4']) + '</K_4>' + nl
      cRes := cRes + '    <K_5>' + TKwota2(aDane['pozycje'][nI]['k5']) + '</K_5>' + nl
      cRes := cRes + '    <K_6>' + TKwota2(aDane['pozycje'][nI]['k6']) + '</K_6>' + nl
      cRes := cRes + '    <K_7>' + TKwota2(aDane['pozycje'][nI]['k7']) + '</K_7>' + nl
      cRes := cRes + '    <K_8>' + TKwota2(aDane['pozycje'][nI]['k8']) + '</K_8>' + nl
      cRes := cRes + '    <K_9>' + TKwota2(aDane['pozycje'][nI]['k9']) + '</K_9>' + nl
      cRes := cRes + '    <K_10>' + TKwota2(aDane['pozycje'][nI]['k10']) + '</K_10>' + nl
      cRes := cRes + '    <K_11>' + TKwota2(aDane['pozycje'][nI]['k11']) + '</K_11>' + nl
      //cRes := cRes + '    <K_12>' + TKwota2(aDane['pozycje'][nI]['k12']) + '</K_12>' + nl
      cRes := cRes + '  </EWPWiersz>' + nl
   NEXT
   cRes := cRes + '  <EWPCtrl>' + nl
   cRes := cRes + '    <LiczbaWierszy>' + AllTrim(Str(aDane['LiczbaWierszy'])) + '</LiczbaWierszy>' + nl
   cRes := cRes + '    <SumaPrzychodow>' + TKwota2(aDane['SumaPrzychodow']) + '</SumaPrzychodow>' + nl
   cRes := cRes + '  </EWPCtrl>' + nl
   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_vat(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2016/10/26/10261/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_VAT (2)" wersjaSchemy="1-0" >JPK_VAT</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>2</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <DomyslnyKodWaluty>PLN</DomyslnyKodWaluty>' + nl
   cRes := cRes + '    <KodUrzedu>' + aDane['KodUrzedu'] + '</KodUrzedu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '    <IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '      <etd:NIP>' + trimnip(aDane['NIP']) + '</etd:NIP>' + nl
   cRes := cRes + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</etd:PelnaNazwa>' + nl
   cRes := cRes + '    </IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '    <AdresPodmiotu>' + nl
   cRes := cRes + '      <KodKraju>PL</KodKraju>' + nl
   cRes := cRes + '      <Wojewodztwo>' + str2sxml(AllTrim(aDane['Wojewodztwo'])) + '</Wojewodztwo>' + nl
   cRes := cRes + '      <Powiat>' + str2sxml(AllTrim(aDane['Powiat'])) + '</Powiat>' + nl
   cRes := cRes + '      <Gmina>' + str2sxml(AllTrim(aDane['Gmina'])) + '</Gmina>' + nl
   IF AllTrim(aDane['Ulica']) <> ''
      cRes := cRes + '      <Ulica>' + str2sxml(AllTrim(aDane['Ulica'])) + '</Ulica>' + nl
   ENDIF
   cRes := cRes + '      <NrDomu>' + str2sxml(AllTrim(aDane['NrDomu'])) + '</NrDomu>' + nl
   IF AllTrim(aDane['NrLokalu']) <> ''
      cRes := cRes + '      <NrLokalu>' + str2sxml(AllTrim(aDane['NrLokalu'])) + '</NrLokalu>' + nl
   ENDIF
   cRes := cRes + '      <Miejscowosc>' + str2sxml(AllTrim(aDane['Miejscowosc'])) + '</Miejscowosc>' + nl
   cRes := cRes + '      <KodPocztowy>' + str2sxml(AllTrim(aDane['KodPocztowy'])) + '</KodPocztowy>' + nl
   cRes := cRes + '      <Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
      cRes := cRes + '  <SprzedazWiersz typ="G">' + nl
      cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
      cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
      cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
      cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
      cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
      cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
         cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_10' )
         cRes := cRes + '    <K_10>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_10' ] ) + '</K_10>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_11' )
         cRes := cRes + '    <K_11>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_11' ] ) + '</K_11>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_12' )
         cRes := cRes + '    <K_12>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_12' ] ) + '</K_12>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_13' )
         cRes := cRes + '    <K_13>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_13' ] ) + '</K_13>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_14' )
         cRes := cRes + '    <K_14>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_14' ] ) + '</K_14>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_15' )
         cRes := cRes + '    <K_15>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_15' ] ) + '</K_15>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_16' )
         cRes := cRes + '    <K_16>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_16' ] ) + '</K_16>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_17' )
         cRes := cRes + '    <K_17>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_17' ] ) + '</K_17>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_18' )
         cRes := cRes + '    <K_18>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_18' ] ) + '</K_18>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_19' )
         cRes := cRes + '    <K_19>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_19' ] ) + '</K_19>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_20' )
         cRes := cRes + '    <K_20>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_20' ] ) + '</K_20>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_21' )
         cRes := cRes + '    <K_21>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_21' ] ) + '</K_21>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_22' )
         cRes := cRes + '    <K_22>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_22' ] ) + '</K_22>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_23' )
         cRes := cRes + '    <K_23>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_23' ] ) + '</K_23>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_24' )
         cRes := cRes + '    <K_24>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_24' ] ) + '</K_24>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_25' )
         cRes := cRes + '    <K_25>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_25' ] ) + '</K_25>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_26' )
         cRes := cRes + '    <K_26>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_26' ] ) + '</K_26>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_27' )
         cRes := cRes + '    <K_27>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_27' ] ) + '</K_27>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_28' )
         cRes := cRes + '    <K_28>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_28' ] ) + '</K_28>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_29' )
         cRes := cRes + '    <K_29>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_29' ] ) + '</K_29>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_30' )
         cRes := cRes + '    <K_30>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_30' ] ) + '</K_30>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_31' )
         cRes := cRes + '    <K_31>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_31' ] ) + '</K_31>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32' )
         cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32' ] ) + '</K_32>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_33' )
         cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_33' ] ) + '</K_33>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_34' )
         cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_34' ] ) + '</K_34>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_35' )
         cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_35' ] ) + '</K_35>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
         cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_36>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
         cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
         cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
         cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
      ENDIF
      cRes := cRes + '  </SprzedazWiersz>' + nl
   NEXT

   IF hb_HHasKey( aDane, 'SprzedazCtrl' )
      cRes := cRes + '  <SprzedazCtrl>' + nl
      cRes := cRes + '    <LiczbaWierszySprzedazy>' + AllTrim( Str( aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] ) ) + '</LiczbaWierszySprzedazy>' + nl
      cRes := cRes + '    <PodatekNalezny>' + TKwota2( aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] ) + '</PodatekNalezny>' + nl
      cRes := cRes + '  </SprzedazCtrl>' + nl
   ENDIF

   FOR nI := 1 TO Len( aDane[ 'zakup' ])
      cRes := cRes + '  <ZakupWiersz typ="G">' + nl
      cRes := cRes + '    <LpZakupu>' + AllTrim( Str( nI ) ) + '</LpZakupu>' + nl
      cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
      cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
      cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
      cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
      cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
         cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
         cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_43>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
         cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_44>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
         cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_45>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
         cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_46>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
         cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_47>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
         cRes := cRes + '    <K_48>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_48>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
         cRes := cRes + '    <K_49>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_49>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
         cRes := cRes + '    <K_50>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_50>' + nl
      ENDIF
      cRes := cRes + '  </ZakupWiersz>' + nl
   NEXT

   IF hb_HHasKey( aDane, 'ZakupCtrl' )
      cRes := cRes + '  <ZakupCtrl>' + nl
      cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
      cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
      cRes := cRes + '  </ZakupCtrl>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl
RETURN cRes

FUNCTION jpk_vat3( aDane )
   LOCAL cRes := '', nl := Chr( 13 ) + Chr( 10 ), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2017/11/13/1113/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_VAT (3)" wersjaSchemy="1-1" >JPK_VAT</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>3</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '      <NIP>' + trimnip(aDane['NIP']) + '</NIP>' + nl
   cRes := cRes + '      <PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</PelnaNazwa>' + nl
   IF AllTrim( aDane[ 'Email' ] ) <> ""
      cRes := cRes + '      <Email>' + AllTrim( aDane[ 'Email' ] ) + '</Email>' + nl
   ENDIF
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
      cRes := cRes + '  <SprzedazWiersz>' + nl
      cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
      cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
      cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
      cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
      cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
      cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
         cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_10' )
         cRes := cRes + '    <K_10>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_10' ] ) + '</K_10>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_11' )
         cRes := cRes + '    <K_11>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_11' ] ) + '</K_11>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_12' )
         cRes := cRes + '    <K_12>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_12' ] ) + '</K_12>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_13' )
         cRes := cRes + '    <K_13>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_13' ] ) + '</K_13>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_14' )
         cRes := cRes + '    <K_14>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_14' ] ) + '</K_14>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_15' )
         cRes := cRes + '    <K_15>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_15' ] ) + '</K_15>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_16' )
         cRes := cRes + '    <K_16>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_16' ] ) + '</K_16>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_17' )
         cRes := cRes + '    <K_17>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_17' ] ) + '</K_17>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_18' )
         cRes := cRes + '    <K_18>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_18' ] ) + '</K_18>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_19' )
         cRes := cRes + '    <K_19>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_19' ] ) + '</K_19>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_20' )
         cRes := cRes + '    <K_20>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_20' ] ) + '</K_20>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_21' )
         cRes := cRes + '    <K_21>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_21' ] ) + '</K_21>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_22' )
         cRes := cRes + '    <K_22>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_22' ] ) + '</K_22>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_23' )
         cRes := cRes + '    <K_23>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_23' ] ) + '</K_23>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_24' )
         cRes := cRes + '    <K_24>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_24' ] ) + '</K_24>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_25' )
         cRes := cRes + '    <K_25>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_25' ] ) + '</K_25>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_26' )
         cRes := cRes + '    <K_26>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_26' ] ) + '</K_26>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_27' )
         cRes := cRes + '    <K_27>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_27' ] ) + '</K_27>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_28' )
         cRes := cRes + '    <K_28>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_28' ] ) + '</K_28>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_29' )
         cRes := cRes + '    <K_29>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_29' ] ) + '</K_29>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_30' )
         cRes := cRes + '    <K_30>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_30' ] ) + '</K_30>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_31' )
         cRes := cRes + '    <K_31>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_31' ] ) + '</K_31>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32' )
         cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32' ] ) + '</K_32>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_33' )
         cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_33' ] ) + '</K_33>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_34' )
         cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_34' ] ) + '</K_34>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_35' )
         cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_35' ] ) + '</K_35>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
         cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_36>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
         cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
         cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
         cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
      ENDIF
      cRes := cRes + '  </SprzedazWiersz>' + nl
   NEXT

   IF hb_HHasKey( aDane, 'SprzedazCtrl' )
      cRes := cRes + '  <SprzedazCtrl>' + nl
      cRes := cRes + '    <LiczbaWierszySprzedazy>' + AllTrim( Str( aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] ) ) + '</LiczbaWierszySprzedazy>' + nl
      cRes := cRes + '    <PodatekNalezny>' + TKwota2( aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] ) + '</PodatekNalezny>' + nl
      cRes := cRes + '  </SprzedazCtrl>' + nl
   ENDIF

   FOR nI := 1 TO Len( aDane[ 'zakup' ])
      cRes := cRes + '  <ZakupWiersz>' + nl
      cRes := cRes + '    <LpZakupu>' + AllTrim( Str( nI ) ) + '</LpZakupu>' + nl
      cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
      cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
      cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
      cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
      cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
         cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
         cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_43>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
         cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_44>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
         cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_45>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
         cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_46>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
         cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_47>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
         cRes := cRes + '    <K_48>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_48>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
         cRes := cRes + '    <K_49>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_49>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
         cRes := cRes + '    <K_50>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_50>' + nl
      ENDIF
      cRes := cRes + '  </ZakupWiersz>' + nl
   NEXT

   IF hb_HHasKey( aDane, 'ZakupCtrl' )
      cRes := cRes + '  <ZakupCtrl>' + nl
      cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
      cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
      cRes := cRes + '  </ZakupCtrl>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_fa1( aDane )

   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI

   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2016/03/09/03095/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2016/01/25/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_FA (1)" wersjaSchemy="1-0" >JPK_FA</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>1</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <DomyslnyKodWaluty>PLN</DomyslnyKodWaluty>' + nl
   cRes := cRes + '    <KodUrzedu>' + aDane['KodUrzedu'] + '</KodUrzedu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '    <IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '      <etd:NIP>' + trimnip(aDane['NIP']) + '</etd:NIP>' + nl
   cRes := cRes + '      <etd:PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</etd:PelnaNazwa>' + nl
   cRes := cRes + '    </IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '    <AdresPodmiotu>' + nl
   cRes := cRes + '      <etd:KodKraju>PL</etd:KodKraju>' + nl
   cRes := cRes + '      <etd:Wojewodztwo>' + str2sxml(AllTrim(aDane['Wojewodztwo'])) + '</etd:Wojewodztwo>' + nl
   cRes := cRes + '      <etd:Powiat>' + str2sxml(AllTrim(aDane['Powiat'])) + '</etd:Powiat>' + nl
   cRes := cRes + '      <etd:Gmina>' + str2sxml(AllTrim(aDane['Gmina'])) + '</etd:Gmina>' + nl
   IF AllTrim(aDane['Ulica']) <> ''
      cRes := cRes + '      <etd:Ulica>' + str2sxml(AllTrim(aDane['Ulica'])) + '</etd:Ulica>' + nl
   ENDIF
   cRes := cRes + '      <etd:NrDomu>' + str2sxml(AllTrim(aDane['NrDomu'])) + '</etd:NrDomu>' + nl
   IF AllTrim(aDane['NrLokalu']) <> ''
      cRes := cRes + '      <etd:NrLokalu>' + str2sxml(AllTrim(aDane['NrLokalu'])) + '</etd:NrLokalu>' + nl
   ENDIF
   cRes := cRes + '      <etd:Miejscowosc>' + str2sxml(AllTrim(aDane['Miejscowosc'])) + '</etd:Miejscowosc>' + nl
   cRes := cRes + '      <etd:KodPocztowy>' + str2sxml(AllTrim(aDane['KodPocztowy'])) + '</etd:KodPocztowy>' + nl
   cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len( aDane[ 'Faktury' ] )
      cRes := cRes + '  <Faktura typ="G">' + nl
      cRes := cRes + '    <P_1>' + date2strxml( aDane[ 'Faktury' ][ nI ][ 'P_1' ] ) + '</P_1>' + nl
      cRes := cRes + '    <P_2A>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_2A' ] ) + '</P_2A>' + nl
      cRes := cRes + '    <P_3A>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_3A' ] ) + '</P_3A>' + nl
      cRes := cRes + '    <P_3B>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_3B' ] ) + '</P_3B>' + nl
      cRes := cRes + '    <P_3C>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_3C' ] ) + '</P_3C>' + nl
      cRes := cRes + '    <P_3D>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_3D' ] ) + '</P_3D>' + nl
      cRes := cRes + '    <P_4A>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_4A' ] ) + '</P_4A>' + nl
      cRes := cRes + '    <P_4B>' + JPKStrND( TrimNIP( aDane[ 'Faktury' ][ nI ][ 'P_4B' ] ) ) + '</P_4B>' + nl
      IF AllTrim( aDane[ 'Faktury' ][ nI ][ 'P_5A' ] ) <> ''
         cRes := cRes + '    <P_5A>' + JPKStrND( aDane[ 'Faktury' ][ nI ][ 'P_5A' ] ) + '</P_5A>' + nl
      ENDIF
      IF AllTrim( aDane[ 'Faktury' ][ nI ][ 'P_5B' ] ) <> ''
         cRes := cRes + '    <P_5B>' + JPKStrND( TrimNIP( aDane[ 'Faktury' ][ nI ][ 'P_5B' ] ) ) + '</P_5B>' + nl
      ENDIF
      cRes := cRes + '    <P_6>' + date2strxml( aDane[ 'Faktury' ][ nI ][ 'P_6' ] ) + '</P_6>' + nl
      IF aDane[ 'Faktury' ][ nI ][ 'P_13_1' ] <> 0 .OR. aDane[ 'Faktury' ][ nI ][ 'P_14_1' ] <> 0
         cRes := cRes + '    <P_13_1>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_13_1' ] ) + '</P_13_1>' + nl
         cRes := cRes + '    <P_14_1>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_14_1' ] ) + '</P_14_1>' + nl
      ENDIF
      IF aDane[ 'Faktury' ][ nI ][ 'P_13_2' ] <> 0 .OR. aDane[ 'Faktury' ][ nI ][ 'P_14_2' ] <> 0
         cRes := cRes + '    <P_13_2>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_13_2' ] ) + '</P_13_2>' + nl
         cRes := cRes + '    <P_14_2>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_14_2' ] ) + '</P_14_2>' + nl
      ENDIF
      IF aDane[ 'Faktury' ][ nI ][ 'P_13_3' ] <> 0 .OR. aDane[ 'Faktury' ][ nI ][ 'P_14_3' ] <> 0
         cRes := cRes + '    <P_13_3>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_13_3' ] ) + '</P_13_3>' + nl
         cRes := cRes + '    <P_14_3>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_14_3' ] ) + '</P_14_3>' + nl
      ENDIF
      IF aDane[ 'Faktury' ][ nI ][ 'P_13_4' ] <> 0 .OR. aDane[ 'Faktury' ][ nI ][ 'P_14_4' ] <> 0
         cRes := cRes + '    <P_13_4>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_13_4' ] ) + '</P_13_4>' + nl
         cRes := cRes + '    <P_14_4>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_14_4' ] ) + '</P_14_4>' + nl
      ENDIF
       IF aDane[ 'Faktury' ][ nI ][ 'P_13_5' ] <> 0 .OR. aDane[ 'Faktury' ][ nI ][ 'P_14_5' ] <> 0
         cRes := cRes + '    <P_13_5>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_13_5' ] ) + '</P_13_5>' + nl
         cRes := cRes + '    <P_14_5>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_14_5' ] ) + '</P_14_5>' + nl
      ENDIF
      cRes := cRes + '    <P_15>' + TKwota2(aDane[ 'Faktury' ][ nI ][ 'P_15' ] ) + '</P_15>' + nl
      cRes := cRes + '    <P_16>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_16' ] ) + '</P_16>' + nl
      cRes := cRes + '    <P_17>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_17' ] ) + '</P_17>' + nl
      cRes := cRes + '    <P_18>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_18' ] ) + '</P_18>' + nl
      cRes := cRes + '    <P_19>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_19' ] ) + '</P_19>' + nl
      cRes := cRes + '    <P_20>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_20' ] ) + '</P_20>' + nl
      cRes := cRes + '    <P_21>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_21' ] ) + '</P_21>' + nl
      cRes := cRes + '    <P_23>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_23' ] ) + '</P_23>' + nl
      cRes := cRes + '    <P_106E_2>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_106E_2' ] ) + '</P_106E_2>' + nl
      cRes := cRes + '    <RodzajFaktury>' + str2sxml(aDane[ 'Faktury' ][ nI ][ 'RodzajFaktury' ] ) + '</RodzajFaktury>' + nl
      cRes := cRes + '  </Faktura>' + nl
   NEXT
   cRes := cRes + '  <FakturaCtrl>' + nl
   cRes := cRes + '    <LiczbaFaktur>' + AllTrim( Str( aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] ) ) + '</LiczbaFaktur>' + nl
   cRes := cRes + '    <WartoscFaktur>' + TKwota2( aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] ) + '</WartoscFaktur>' + nl
   cRes := cRes + '  </FakturaCtrl>' + nl

   cRes := cRes + '  <StawkiPodatku>' + nl
   cRes := cRes + '    <Stawka1>0.23</Stawka1>' + nl
   cRes := cRes + '    <Stawka2>0.08</Stawka2>' + nl
   cRes := cRes + '    <Stawka3>0.05</Stawka3>' + nl
   cRes := cRes + '    <Stawka4>0</Stawka4>' + nl
   cRes := cRes + '    <Stawka5>0</Stawka5>' + nl
   cRes := cRes + '  </StawkiPodatku>' + nl

   FOR nI := 1 TO Len( aDane[ 'Pozycje' ] )
      cRes := cRes + '  <FakturaWiersz typ="G">' + nl
      cRes := cRes + '    <P_2B>' + JPKStrND( aDane[ 'Pozycje' ][ nI ][ 'P_2B' ] ) + '</P_2B>' + nl
      cRes := cRes + '    <P_7>' + JPKStrND( aDane[ 'Pozycje' ][ nI ][ 'P_7' ] ) + '</P_7>' + nl
      cRes := cRes + '    <P_8A>' + JPKStrND( aDane[ 'Pozycje' ][ nI ][ 'P_8A' ] ) + '</P_8A>' + nl
      cRes := cRes + '    <P_8B>' + TIlosciJPK( aDane[ 'Pozycje' ][ nI ][ 'P_8B' ] ) + '</P_8B>' + nl
      cRes := cRes + '    <P_9A>' + TKwota2( aDane[ 'Pozycje' ][ nI ][ 'P_9A' ] ) + '</P_9A>' + nl
      cRes := cRes + '    <P_11>' + TKwota2( aDane[ 'Pozycje' ][ nI ][ 'P_11' ] ) + '</P_11>' + nl
      cRes := cRes + '    <P_12>' + aDane[ 'Pozycje' ][ nI ][ 'P_12' ] + '</P_12>' + nl
      cRes := cRes + '  </FakturaWiersz>' + nl
   NEXT
   cRes := cRes + '  <FakturaWierszCtrl>' + nl
   cRes := cRes + '    <LiczbaWierszyFaktur>' + AllTrim( Str( aDane[ 'FakturaWierszCtrl' ][ 'LiczbaWierszyFaktur' ] ) ) + '</LiczbaWierszyFaktur>' + nl
   cRes := cRes + '    <WartoscWierszyFaktur>' + TKwota2( aDane[ 'FakturaWierszCtrl' ][ 'WartoscWierszyFaktur' ] ) + '</WartoscWierszyFaktur>' + nl
   cRes := cRes + '  </FakturaWierszCtrl>' + nl

   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

