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
   cRes := cRes + '    <P_1>' + TKwota2(aDane['P_1']) + '</P_1>' + nl
   cRes := cRes + '    <P_2>' + TKwota2(aDane['P_2']) + '</P_2>' + nl
   cRes := cRes + '    <P_3>' + TKwota2(aDane['P_3']) + '</P_3>' + nl
   cRes := cRes + '    <P_4>' + TKwota2(aDane['P_4']) + '</P_4>' + nl
   cRes := cRes + '  </PKPIRInfo>' + nl
   IF aDane['P_5']
      cRes := cRes + '  <PKPIRSpis typ="G">' + nl
      cRes := cRes + '    <P_5A>' + date2strxml(aDane['P_5A']) + '</P_5A>' + nl
      cRes := cRes + '    <P_5B>' + TKwota2(aDane['P_5B']) + '</P_5B>' + nl
      cRes := cRes + '  </PKPIRSpis>' + nl
   ENDIF
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <PKPIRWiersz typ="G">' + nl
      cRes := cRes + '    <K_1>' + AllTrim(Str(aDane['pozycje'][nI]['k1'])) + '</K_1>' + nl
      IF hb_HHasKey( aDane, 'rok' )
         cRes := cRes + '    <K_2>' + JPKData(aDane['rok'], aDane['miesiac'], aDane['pozycje'][nI]['k2']) + '</K_2>' + nl
      ELSE
         cRes := cRes + '    <K_2>' + date2strxml(aDane['pozycje'][nI]['k2']) + '</K_2>' + nl
      ENDIF
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

FUNCTION jpk_ewp_2(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2020/12/30/12301/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_EWP (2)" wersjaSchemy="1-0" >JPK_EWP</KodFormularza>' + nl
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
   //cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <EWPWiersz>' + nl
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
      cRes := cRes + '    <K_12>' + TKwota2(aDane['pozycje'][nI]['k12']) + '</K_12>' + nl
      IF Len( aDane['pozycje'][nI]['k13'] ) > 0
         cRes := cRes + '    <K_13>' + str2sxml(aDane['pozycje'][nI]['k13']) + '</K_13>' + nl
      ENDIF
      cRes := cRes + '  </EWPWiersz>' + nl
   NEXT
   cRes := cRes + '  <EWPCtrl>' + nl
   cRes := cRes + '    <LiczbaWierszy>' + AllTrim(Str(aDane['LiczbaWierszy'])) + '</LiczbaWierszy>' + nl
   cRes := cRes + '    <SumaPrzychodow>' + TKwota2(aDane['SumaPrzychodow']) + '</SumaPrzychodow>' + nl
   cRes := cRes + '  </EWPCtrl>' + nl
   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_ewp_2_11(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2021/01/25/01251/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_EWP (2)" wersjaSchemy="1-1" >JPK_EWP</KodFormularza>' + nl
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
   //cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <EWPWiersz>' + nl
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
      cRes := cRes + '    <K_12>' + TKwota2(aDane['pozycje'][nI]['k12']) + '</K_12>' + nl
      IF Len( aDane['pozycje'][nI]['k13'] ) > 0
         cRes := cRes + '    <K_13>' + str2sxml(aDane['pozycje'][nI]['k13']) + '</K_13>' + nl
      ENDIF
      cRes := cRes + '  </EWPWiersz>' + nl
   NEXT
   cRes := cRes + '  <EWPCtrl>' + nl
   cRes := cRes + '    <LiczbaWierszy>' + AllTrim(Str(aDane['LiczbaWierszy'])) + '</LiczbaWierszy>' + nl
   cRes := cRes + '    <SumaPrzychodow>' + TKwota2(aDane['SumaPrzychodow']) + '</SumaPrzychodow>' + nl
   cRes := cRes + '  </EWPCtrl>' + nl
   cRes := cRes + '</JPK>' + nl
RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_ewp_3(aDane)
   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI
   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2022/02/01/02011/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_EWP (3)" wersjaSchemy="1-1" >JPK_EWP</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>3</WariantFormularza>' + nl
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
   //cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len(aDane['pozycje'])
      cRes := cRes + '  <EWPWiersz>' + nl
      cRes := cRes + '    <K_1>' + AllTrim(Str(aDane['pozycje'][nI]['k1'])) + '</K_1>' + nl
      cRes := cRes + '    <K_2>' + AllTrim(aDane['pozycje'][nI]['k2']) + '</K_2>' + nl
      cRes := cRes + '    <K_3>' + AllTrim(aDane['pozycje'][nI]['k3']) + '</K_3>' + nl
      cRes := cRes + '    <K_4>' + JPKStrND(aDane['pozycje'][nI]['k4']) + '</K_4>' + nl
      cRes := cRes + '    <K_5>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 1 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 1 ] ], 0 ) ) + '</K_5>' + nl
      cRes := cRes + '    <K_6>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 2 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 2 ] ], 0 ) ) + '</K_6>' + nl
      cRes := cRes + '    <K_7>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 3 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 3 ] ], 0 ) ) + '</K_7>' + nl
      cRes := cRes + '    <K_8>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 4 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 4 ] ], 0 ) ) + '</K_8>' + nl
      cRes := cRes + '    <K_9>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 5 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 5 ] ], 0 ) ) + '</K_9>' + nl
      cRes := cRes + '    <K_10>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 6 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 6 ] ], 0 ) ) + '</K_10>' + nl
      cRes := cRes + '    <K_11>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 7 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 7 ] ], 0 ) ) + '</K_11>' + nl
      cRes := cRes + '    <K_12>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 8 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 8 ] ], 0 ) ) + '</K_12>' + nl
      cRes := cRes + '    <K_13>' + TKwota2( iif( ! Empty( aDane[ 'kolumny' ][ 9 ] ), aDane['pozycje'][nI][ aDane[ 'kolumny' ][ 9 ] ], 0 ) ) + '</K_13>' + nl
      cRes := cRes + '    <K_14>' + TKwota2(aDane['pozycje'][nI][ 'k14' ]) + '</K_14>' + nl
      IF Len( aDane['pozycje'][nI]['k15'] ) > 0
         cRes := cRes + '    <K_15>' + str2sxml(aDane['pozycje'][nI]['k15']) + '</K_15>' + nl
      ENDIF
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

FUNCTION jpk_fa3( aDane )

   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI

   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2019/09/27/09271/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/" xmlns:kck="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2013/05/23/eD/KodyCECHKRAJOW/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_FA (3)" wersjaSchemy="1-0" >JPK_FA</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>3</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
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
   //cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len( aDane[ 'Faktury' ] )
      cRes := cRes + '  <Faktura>' + nl
      cRes := cRes + '    <KodWaluty>PLN</KodWaluty>' + nl
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
      cRes := cRes + '    <P_18A>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_18A' ] ) + '</P_18A>' + nl
      cRes := cRes + '    <P_19>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_19' ] ) + '</P_19>' + nl
      cRes := cRes + '    <P_20>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_20' ] ) + '</P_20>' + nl
      cRes := cRes + '    <P_21>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_21' ] ) + '</P_21>' + nl
      cRes := cRes + '    <P_22>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_22' ] ) + '</P_22>' + nl
      cRes := cRes + '    <P_23>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_23' ] ) + '</P_23>' + nl
      cRes := cRes + '    <P_106E_2>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_106E_2' ] ) + '</P_106E_2>' + nl
      cRes := cRes + '    <P_106E_3>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_106E_3' ] ) + '</P_106E_3>' + nl
      cRes := cRes + '    <RodzajFaktury>' + str2sxml(aDane[ 'Faktury' ][ nI ][ 'RodzajFaktury' ] ) + '</RodzajFaktury>' + nl
      cRes := cRes + '  </Faktura>' + nl
   NEXT
   cRes := cRes + '  <FakturaCtrl>' + nl
   cRes := cRes + '    <LiczbaFaktur>' + AllTrim( Str( aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] ) ) + '</LiczbaFaktur>' + nl
   cRes := cRes + '    <WartoscFaktur>' + TKwota2( aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] ) + '</WartoscFaktur>' + nl
   cRes := cRes + '  </FakturaCtrl>' + nl

   FOR nI := 1 TO Len( aDane[ 'Pozycje' ] )
      cRes := cRes + '  <FakturaWiersz>' + nl
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

FUNCTION jpk_fa4( aDane )

   LOCAL cRes := '', nl := Chr(13) + Chr(10), nI

   cRes :=        '<?xml version="1.0" encoding="UTF-8"?>'
   cRes := cRes + '<JPK xmlns="http://jpk.mf.gov.pl/wzor/2022/02/17/02171/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2018/08/24/eD/DefinicjeTypy/">' + nl
   cRes := cRes + '  <Naglowek>' + nl
   cRes := cRes + '    <KodFormularza kodSystemowy="JPK_FA (4)" wersjaSchemy="1-0" >JPK_FA</KodFormularza>' + nl
   cRes := cRes + '    <WariantFormularza>4</WariantFormularza>' + nl
   cRes := cRes + '    <CelZlozenia>' + aDane['CelZlozenia'] + '</CelZlozenia>' + nl
   cRes := cRes + '    <DataWytworzeniaJPK>' + aDane['DataWytworzeniaJPK'] + '</DataWytworzeniaJPK>' + nl
   cRes := cRes + '    <DataOd>' + date2strxml(aDane['DataOd']) + '</DataOd>' + nl
   cRes := cRes + '    <DataDo>' + date2strxml(aDane['DataDo']) + '</DataDo>' + nl
   cRes := cRes + '    <KodUrzedu>' + aDane['KodUrzedu'] + '</KodUrzedu>' + nl
   cRes := cRes + '  </Naglowek>' + nl
   cRes := cRes + '  <Podmiot1>' + nl
   cRes := cRes + '    <IdentyfikatorPodmiotu>' + nl
   cRes := cRes + '      <NIP>' + trimnip(aDane['NIP']) + '</NIP>' + nl
   cRes := cRes + '      <PelnaNazwa>' + str2sxml(AllTrim(aDane['PelnaNazwa'])) + '</PelnaNazwa>' + nl
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
   //cRes := cRes + '      <etd:Poczta>' + str2sxml(AllTrim(aDane['Poczta'])) + '</etd:Poczta>' + nl
   cRes := cRes + '    </AdresPodmiotu>' + nl
   cRes := cRes + '  </Podmiot1>' + nl
   FOR nI := 1 TO Len( aDane[ 'Faktury' ] )
      cRes := cRes + '  <Faktura>' + nl
      cRes := cRes + '    <KodWaluty>PLN</KodWaluty>' + nl
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
      cRes := cRes + '    <P_18A>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_18A' ] ) + '</P_18A>' + nl
      cRes := cRes + '    <P_19>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_19' ] ) + '</P_19>' + nl
      cRes := cRes + '    <P_20>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_20' ] ) + '</P_20>' + nl
      cRes := cRes + '    <P_21>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_21' ] ) + '</P_21>' + nl
      cRes := cRes + '    <P_22>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_22' ] ) + '</P_22>' + nl
      cRes := cRes + '    <P_23>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_23' ] ) + '</P_23>' + nl
      cRes := cRes + '    <P_106E_2>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_106E_2' ] ) + '</P_106E_2>' + nl
      cRes := cRes + '    <P_106E_3>' + bool2sxml(aDane[ 'Faktury' ][ nI ][ 'P_106E_3' ] ) + '</P_106E_3>' + nl
      cRes := cRes + '    <RodzajFaktury>' + str2sxml(aDane[ 'Faktury' ][ nI ][ 'RodzajFaktury' ] ) + '</RodzajFaktury>' + nl
      IF hb_HHasKey( aDane[ 'Faktury' ][ nI ], 'PrzyczynaKorekty' )
         cRes := cRes + '    <PrzyczynaKorekty>' + str2sxml(aDane[ 'Faktury' ][ nI ][ 'PrzyczynaKorekty' ] ) + '</PrzyczynaKorekty>' + nl
      ENDIF
      IF hb_HHasKey( aDane[ 'Faktury' ][ nI ], 'NrFaKorygowanej' )
         cRes := cRes + '    <NrFaKorygowanej>' + str2sxml(aDane[ 'Faktury' ][ nI ][ 'NrFaKorygowanej' ] ) + '</NrFaKorygowanej>' + nl
      ENDIF
      cRes := cRes + '  </Faktura>' + nl
   NEXT
   cRes := cRes + '  <FakturaCtrl>' + nl
   cRes := cRes + '    <LiczbaFaktur>' + AllTrim( Str( aDane[ 'FakturaCtrl' ][ 'LiczbaFaktur' ] ) ) + '</LiczbaFaktur>' + nl
   cRes := cRes + '    <WartoscFaktur>' + TKwota2( aDane[ 'FakturaCtrl' ][ 'WartoscFaktur' ] ) + '</WartoscFaktur>' + nl
   cRes := cRes + '  </FakturaCtrl>' + nl

   FOR nI := 1 TO Len( aDane[ 'Pozycje' ] )
      cRes := cRes + '  <FakturaWiersz>' + nl
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

FUNCTION jpk_v7m_1( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2020/05/08/9393/" xmlns:tns="http://crd.gov.pl/wzor/2020/05/08/9393/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7M (1)" wersjaSchemy="1-2E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>1</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7 (21)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-2E">VAT-7</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>21</WariantFormularzaDekl>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SW' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'SW' ]
            cRes := cRes + '    <SW>1</SW>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'EE' ]
            cRes := cRes + '    <EE>1</EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </SprzedazWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'SprzedazCtrl' )
         cRes := cRes + '  <SprzedazCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszySprzedazy>' + AllTrim( Str( aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] ) ) + '</LiczbaWierszySprzedazy>' + nl
         cRes := cRes + '    <PodatekNalezny>' + TKwota2( aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] ) + '</PodatekNalezny>' + nl
         cRes := cRes + '  </SprzedazCtrl>' + nl
      ENDIF

      FOR nI := 1 TO Len( aDane[ 'zakup' ] )
         cRes := cRes + '  <ZakupWiersz>' + nl
         cRes := cRes + '    <LpZakupu>' + AllTrim( Str( nI ) ) + '</LpZakupu>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_v7k_1( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2020/05/08/9394/" xmlns:tns="http://crd.gov.pl/wzor/2020/05/08/9394/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2020/03/11/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7K (1)" wersjaSchemy="1-2E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>1</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7K (15)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-2E">VAT-7K</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>15</WariantFormularzaDekl>' + nl
      cRes += '      <Kwartal>' + TNaturalny( aDane[ 'Kwartal' ] ) + '</Kwartal>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SW' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'SW' ]
            cRes := cRes + '    <SW>1</SW>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'EE' ]
            cRes := cRes + '    <EE>1</EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
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
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_v7m_2( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2021/12/27/11148/" xmlns:tns="http://crd.gov.pl/wzor/2021/12/27/11148/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2021/06/08/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7M (2)" wersjaSchemy="1-0E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>2</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7 (22)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VAT-7</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>22</WariantFormularzaDekl>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_540' ]
         cRes += '      <P_540>1</P_540>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_560' ]
         cRes += '      <P_560>1</P_560>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_660' ]
         cRes += '      <P_660>1</P_660>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'WSTO_EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'WSTO_EE' ]
            cRes := cRes + '    <WSTO_EE>1</WSTO_EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'IED' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'IED' ]
            cRes := cRes + '    <IED>1</IED>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         //IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
         //   cRes := cRes + '    <MPP>1</MPP>' + nl
         //ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TerminPlatnosci' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] )
               cRes := cRes + '    <TerminPlatnosci>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] ) + '</TerminPlatnosci>' + nl
            ENDIF
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataZaplaty' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] )
               cRes := cRes + '    <DataZaplaty>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] ) + '</DataZaplaty>' + nl
            ENDIF
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </SprzedazWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'SprzedazCtrl' )
         cRes := cRes + '  <SprzedazCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszySprzedazy>' + AllTrim( Str( aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] ) ) + '</LiczbaWierszySprzedazy>' + nl
         cRes := cRes + '    <PodatekNalezny>' + TKwota2( aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] ) + '</PodatekNalezny>' + nl
         cRes := cRes + '  </SprzedazCtrl>' + nl
      ENDIF

      FOR nI := 1 TO Len( aDane[ 'zakup' ] )
         cRes := cRes + '  <ZakupWiersz>' + nl
         cRes := cRes + '    <LpZakupu>' + AllTrim( Str( nI ) ) + '</LpZakupu>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         /*IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF*/
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_v7k_2( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2021/12/27/11149/" xmlns:tns="http://crd.gov.pl/wzor/2021/12/27/11149/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2021/06/08/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7K (2)" wersjaSchemy="1-0E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>2</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7K (16)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VAT-7K</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>16</WariantFormularzaDekl>' + nl
      cRes += '      <Kwartal>' + TNaturalny( aDane[ 'Kwartal' ] ) + '</Kwartal>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_540' ]
         cRes += '      <P_540>1</P_540>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_560' ]
         cRes += '      <P_560>1</P_560>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_660' ]
         cRes += '      <P_660>1</P_660>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'WSTO_EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'WSTO_EE' ]
            cRes := cRes + '    <WSTO_EE>1</WSTO_EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'IED' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'IED' ]
            cRes := cRes + '    <IED>1</IED>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         //IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
         //   cRes := cRes + '    <MPP>1</MPP>' + nl
         //ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TerminPlatnosci' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] )
               cRes := cRes + '    <TerminPlatnosci>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] ) + '</TerminPlatnosci>' + nl
            ENDIF
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataZaplaty' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] )
               cRes := cRes + '    <DataZaplaty>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] ) + '</DataZaplaty>' + nl
            ENDIF
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
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
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         /*IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF*/
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_v7m_3( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2025/12/19/14090/" xmlns:tns="http://crd.gov.pl/wzor/2025/12/19/14090/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7M (3)" wersjaSchemy="1-0E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>3</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7 (23)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VAT-7</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>23</WariantFormularzaDekl>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_360>' + TKwotaC( aDane[ 'DekV7' ][ 'P_360' ] ) + '</P_360>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_540' ]
         cRes += '      <P_540>1</P_540>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_560' ]
         cRes += '      <P_560>1</P_560>' + nl
      ENDIF
      /*
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      */
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_660' ]
         cRes += '      <P_660>1</P_660>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'NrKSeF' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'NrKSeF' ] )
            cRes := cRes + '    <NrKSeF>' + aDane[ 'sprzedaz' ][ nI ][ 'NrKSeF' ] + '</NrKSeF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] $ ' B'
            cRes := cRes + '    <BFK>1</BFK>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] == 'O'
            cRes := cRes + '    <OFF>1</OFF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] == 'D'
            cRes := cRes + '    <DI>1</DI>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'WSTO_EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'WSTO_EE' ]
            cRes := cRes + '    <WSTO_EE>1</WSTO_EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'IED' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'IED' ]
            cRes := cRes + '    <IED>1</IED>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         //IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
         //   cRes := cRes + '    <MPP>1</MPP>' + nl
         //ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TerminPlatnosci' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] )
               cRes := cRes + '    <TerminPlatnosci>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] ) + '</TerminPlatnosci>' + nl
            ENDIF
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataZaplaty' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] )
               cRes := cRes + '    <DataZaplaty>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] ) + '</DataZaplaty>' + nl
            ENDIF
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_360' )
            cRes := cRes + '    <K_360>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_360' ] ) + '</K_360>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </SprzedazWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'SprzedazCtrl' )
         cRes := cRes + '  <SprzedazCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszySprzedazy>' + AllTrim( Str( aDane[ 'SprzedazCtrl' ][ 'LiczbaWierszySprzedazy' ] ) ) + '</LiczbaWierszySprzedazy>' + nl
         cRes := cRes + '    <PodatekNalezny>' + TKwota2( aDane[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] ) + '</PodatekNalezny>' + nl
         cRes := cRes + '  </SprzedazCtrl>' + nl
      ENDIF

      FOR nI := 1 TO Len( aDane[ 'zakup' ] )
         cRes := cRes + '  <ZakupWiersz>' + nl
         cRes := cRes + '    <LpZakupu>' + AllTrim( Str( nI ) ) + '</LpZakupu>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'NrKSeF' ) .AND. ! Empty( aDane[ 'zakup' ][ nI ][ 'NrKSeF' ] )
            cRes := cRes + '    <NrKSeF>' + aDane[ 'zakup' ][ nI ][ 'NrKSeF' ] + '</NrKSeF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] $ ' B'
            cRes := cRes + '    <BFK>1</BFK>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] == 'O'
            cRes := cRes + '    <OFF>1</OFF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] == 'D'
            cRes := cRes + '    <DI>1</DI>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         /*IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF*/
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION jpk_v7k_3( aDane )

   LOCAL cRes, nl := Chr(13) + Chr(10), nI
   LOCAL lDeklar := aDane[ 'Deklaracja' ]
   LOCAL lRejestry := aDane[ 'Rejestry' ]

   cRes := '<?xml version="1.0" encoding="UTF-8"?>' + nl
   cRes += '<JPK xmlns="http://crd.gov.pl/wzor/2025/12/19/14089/" xmlns:tns="http://crd.gov.pl/wzor/2025/12/19/14089/" xmlns:etd="http://crd.gov.pl/xml/schematy/dziedzinowe/mf/2022/09/13/eD/DefinicjeTypy/">' + nl
   cRes += '  <Naglowek>' + nl
   cRes += '    <KodFormularza kodSystemowy="JPK_V7K (3)" wersjaSchemy="1-0E">JPK_VAT</KodFormularza>' + nl
   cRes += '    <WariantFormularza>3</WariantFormularza>' + nl
   cRes += '    <DataWytworzeniaJPK>' + aDane[ 'DataWytworzeniaJPK' ] + '</DataWytworzeniaJPK>' + nl
   cRes += '    <NazwaSystemu>AMi-BOOK</NazwaSystemu>' + nl
   cRes += '    <CelZlozenia poz="P_7">' + aDane[ 'CelZlozenia' ] + '</CelZlozenia>' + nl
   cRes += '    <KodUrzedu>' + aDane[ 'KodUrzedu' ] + '</KodUrzedu>' + nl
   cRes += '    <Rok>' + TNaturalny( aDane[ 'Rok' ] ) + '</Rok>' + nl
   cRes += '    <Miesiac>' + TNaturalny( aDane[ 'Miesiac' ] ) + '</Miesiac>' + nl
   cRes += '  </Naglowek>' + nl
   cRes += '  <Podmiot1 rola="Podatnik">' + nl
   IF aDane[ 'Spolka' ]
      cRes += '    <OsobaNiefizyczna>' + nl
      cRes += '      <NIP>' + trimnip( aDane[ 'NIP' ] ) + '</NIP>' + nl
      cRes += '      <PelnaNazwa>' + str2sxml( aDane[ 'PelnaNazwa' ] ) + '</PelnaNazwa>' + nl
      cRes += '      <Email>' + str2sxml( aDane[ 'EMail' ] ) + '</Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</Telefon>' + nl
      ENDIF
      cRes += '    </OsobaNiefizyczna>' + nl
   ELSE
      cRes += '    <OsobaFizyczna>' + nl
      cRes += '      <etd:NIP>' + trimnip( aDane[ 'NIP' ] ) + '</etd:NIP>' + nl
      cRes += '      <etd:ImiePierwsze>' + str2sxml( aDane[ 'ImiePierwsze' ] ) + '</etd:ImiePierwsze>' + nl
      cRes += '      <etd:Nazwisko>' + str2sxml( aDane[ 'Nazwisko' ] ) + '</etd:Nazwisko>' + nl
      cRes += '      <etd:DataUrodzenia>' + date2strxml( aDane[ 'DataUrodzenia' ] ) + '</etd:DataUrodzenia>' + nl
      cRes += '      <tns:Email>' + str2sxml( aDane[ 'EMail' ] ) + '</tns:Email>' + nl
      IF Len( AllTrim( aDane[ 'Tel' ] ) ) > 0
         cRes += '      <tns:Telefon>' + str2sxml( aDane[ 'Tel' ] ) + '</tns:Telefon>' + nl
      ENDIF
      cRes += '    </OsobaFizyczna>' + nl
   ENDIF
   cRes += '  </Podmiot1>' + nl
   IF lDeklar
      cRes += '  <Deklaracja>' + nl
      cRes += '    <Naglowek>' + nl
      cRes += '      <KodFormularzaDekl kodSystemowy="VAT-7K (17)" kodPodatku="VAT" rodzajZobowiazania="Z" wersjaSchemy="1-0E">VAT-7K</KodFormularzaDekl>' + nl
      cRes += '      <WariantFormularzaDekl>17</WariantFormularzaDekl>' + nl
      cRes += '      <Kwartal>' + TNaturalny( aDane[ 'Kwartal' ] ) + '</Kwartal>' + nl
      cRes += '    </Naglowek>' + nl
      cRes += '    <PozycjeSzczegolowe>' + nl
      cRes += '      <P_10>' + TKwotaC( aDane[ 'DekV7' ][ 'P_10' ] ) + '</P_10>' + nl
      cRes += '      <P_11>' + TKwotaC( aDane[ 'DekV7' ][ 'P_11' ] ) + '</P_11>' + nl
      cRes += '      <P_12>' + TKwotaC( aDane[ 'DekV7' ][ 'P_12' ] ) + '</P_12>' + nl
      cRes += '      <P_13>' + TKwotaC( aDane[ 'DekV7' ][ 'P_13' ] ) + '</P_13>' + nl
      cRes += '      <P_14>' + TKwotaC( aDane[ 'DekV7' ][ 'P_14' ] ) + '</P_14>' + nl
      cRes += '      <P_15>' + TKwotaC( aDane[ 'DekV7' ][ 'P_15' ] ) + '</P_15>' + nl
      cRes += '      <P_16>' + TKwotaC( aDane[ 'DekV7' ][ 'P_16' ] ) + '</P_16>' + nl
      cRes += '      <P_17>' + TKwotaC( aDane[ 'DekV7' ][ 'P_17' ] ) + '</P_17>' + nl
      cRes += '      <P_18>' + TKwotaC( aDane[ 'DekV7' ][ 'P_18' ] ) + '</P_18>' + nl
      cRes += '      <P_19>' + TKwotaC( aDane[ 'DekV7' ][ 'P_19' ] ) + '</P_19>' + nl
      cRes += '      <P_20>' + TKwotaC( aDane[ 'DekV7' ][ 'P_20' ] ) + '</P_20>' + nl
      cRes += '      <P_21>' + TKwotaC( aDane[ 'DekV7' ][ 'P_21' ] ) + '</P_21>' + nl
      cRes += '      <P_22>' + TKwotaC( aDane[ 'DekV7' ][ 'P_22' ] ) + '</P_22>' + nl
      cRes += '      <P_23>' + TKwotaC( aDane[ 'DekV7' ][ 'P_23' ] ) + '</P_23>' + nl
      cRes += '      <P_24>' + TKwotaC( aDane[ 'DekV7' ][ 'P_24' ] ) + '</P_24>' + nl
      cRes += '      <P_25>' + TKwotaC( aDane[ 'DekV7' ][ 'P_25' ] ) + '</P_25>' + nl
      cRes += '      <P_26>' + TKwotaC( aDane[ 'DekV7' ][ 'P_26' ] ) + '</P_26>' + nl
      cRes += '      <P_27>' + TKwotaC( aDane[ 'DekV7' ][ 'P_27' ] ) + '</P_27>' + nl
      cRes += '      <P_28>' + TKwotaC( aDane[ 'DekV7' ][ 'P_28' ] ) + '</P_28>' + nl
      cRes += '      <P_29>' + TKwotaC( aDane[ 'DekV7' ][ 'P_29' ] ) + '</P_29>' + nl
      cRes += '      <P_30>' + TKwotaC( aDane[ 'DekV7' ][ 'P_30' ] ) + '</P_30>' + nl
      cRes += '      <P_31>' + TKwotaC( aDane[ 'DekV7' ][ 'P_31' ] ) + '</P_31>' + nl
      cRes += '      <P_32>' + TKwotaC( aDane[ 'DekV7' ][ 'P_32' ] ) + '</P_32>' + nl
      cRes += '      <P_33>' + TKwotaC( aDane[ 'DekV7' ][ 'P_33' ] ) + '</P_33>' + nl
      cRes += '      <P_34>' + TKwotaC( aDane[ 'DekV7' ][ 'P_34' ] ) + '</P_34>' + nl
      cRes += '      <P_35>' + TKwotaC( aDane[ 'DekV7' ][ 'P_35' ] ) + '</P_35>' + nl
      cRes += '      <P_36>' + TKwotaC( aDane[ 'DekV7' ][ 'P_36' ] ) + '</P_36>' + nl
      cRes += '      <P_360>' + TKwotaC( aDane[ 'DekV7' ][ 'P_360' ] ) + '</P_360>' + nl
      cRes += '      <P_37>' + TKwotaC( aDane[ 'DekV7' ][ 'P_37' ] ) + '</P_37>' + nl
      cRes += '      <P_38>' + TKwotaC( aDane[ 'DekV7' ][ 'P_38' ] ) + '</P_38>' + nl
      cRes += '      <P_39>' + TKwotaC( aDane[ 'DekV7' ][ 'P_39' ] ) + '</P_39>' + nl
      cRes += '      <P_40>' + TKwotaC( aDane[ 'DekV7' ][ 'P_40' ] ) + '</P_40>' + nl
      cRes += '      <P_41>' + TKwotaC( aDane[ 'DekV7' ][ 'P_41' ] ) + '</P_41>' + nl
      cRes += '      <P_42>' + TKwotaC( aDane[ 'DekV7' ][ 'P_42' ] ) + '</P_42>' + nl
      cRes += '      <P_43>' + TKwotaC( aDane[ 'DekV7' ][ 'P_43' ] ) + '</P_43>' + nl
      cRes += '      <P_44>' + TKwotaC( aDane[ 'DekV7' ][ 'P_44' ] ) + '</P_44>' + nl
      cRes += '      <P_45>' + TKwotaC( aDane[ 'DekV7' ][ 'P_45' ] ) + '</P_45>' + nl
      cRes += '      <P_46>' + TKwotaC( aDane[ 'DekV7' ][ 'P_46' ] ) + '</P_46>' + nl
      cRes += '      <P_47>' + TKwotaC( aDane[ 'DekV7' ][ 'P_47' ] ) + '</P_47>' + nl
      cRes += '      <P_48>' + TKwotaC( aDane[ 'DekV7' ][ 'P_48' ] ) + '</P_48>' + nl
      cRes += '      <P_49>' + TKwotaC( aDane[ 'DekV7' ][ 'P_49' ] ) + '</P_49>' + nl
      cRes += '      <P_50>' + TKwotaC( aDane[ 'DekV7' ][ 'P_50' ] ) + '</P_50>' + nl
      cRes += '      <P_51>' + TKwotaC( aDane[ 'DekV7' ][ 'P_51' ] ) + '</P_51>' + nl
      cRes += '      <P_52>' + TKwotaC( aDane[ 'DekV7' ][ 'P_52' ] ) + '</P_52>' + nl
      cRes += '      <P_53>' + TKwotaC( aDane[ 'DekV7' ][ 'P_53' ] ) + '</P_53>' + nl
      IF aDane[ 'DekV7' ][ 'P_54' ] <> 0
         cRes += '      <P_54>' + TKwotaC( aDane[ 'DekV7' ][ 'P_54' ] ) + '</P_54>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_540' ]
         cRes += '      <P_540>1</P_540>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_55' ]
         cRes += '      <P_55>1</P_55>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_56' ]
         cRes += '      <P_56>1</P_56>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_560' ]
         cRes += '      <P_560>1</P_560>' + nl
      ENDIF
      /*
      IF aDane[ 'DekV7' ][ 'P_57' ]
         cRes += '      <P_57>1</P_57>' + nl
      ENDIF
      */
      IF aDane[ 'DekV7' ][ 'P_58' ]
         cRes += '      <P_58>1</P_58>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_59' ]
         cRes += '      <P_59>1</P_59>' + nl
         cRes += '      <P_60>' + TKwotaC( aDane[ 'DekV7' ][ 'P_60' ] ) + '</P_60>' + nl
         cRes += '      <P_61>' + str2sxml( aDane[ 'DekV7' ][ 'P_61' ] ) + '</P_61>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_62' ] > 0
         cRes += '      <P_62>' + TKwotaC( aDane[ 'DekV7' ][ 'P_62' ] ) + '</P_62>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_63' ]
         cRes += '      <P_63>1</P_63>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_64' ]
         cRes += '      <P_64>1</P_64>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_65' ]
         cRes += '      <P_65>1</P_65>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_66' ]
         cRes += '      <P_66>1</P_66>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_660' ]
         cRes += '      <P_660>1</P_660>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'P_68' ] <> 0 .OR. aDane[ 'DekV7' ][ 'P_69' ] <> 0
         cRes += '      <P_68>' + TKwotaC( aDane[ 'DekV7' ][ 'P_68' ] ) + '</P_68>' + nl
         cRes += '      <P_69>' + TKwotaC( aDane[ 'DekV7' ][ 'P_69' ] ) + '</P_69>' + nl
      ENDIF
      IF aDane[ 'DekV7' ][ 'ORDZUrob' ] .AND. Len( AllTrim( aDane[ 'DekV7' ][ 'ORDZU' ] ) ) > 0
         cRes += '      <P_ORDZU>' + str2sxml( MemoTran( aDane[ 'DekV7' ][ 'ORDZU' ], ' ', ' ' ) ) + '</P_ORDZU>' + nl
      ENDIF
      cRes += '    </PozycjeSzczegolowe>' + nl
      cRes += '    <Pouczenia>1</Pouczenia>' + nl
      cRes += '  </Deklaracja>' + nl
   ENDIF
   IF lRejestry
      cRes := cRes + '  <Ewidencja>' + nl
      FOR nI := 1 TO Len( aDane[ 'sprzedaz' ])
         cRes := cRes + '  <SprzedazWiersz>' + nl
         cRes := cRes + '    <LpSprzedazy>' + AllTrim( Str( nI ) ) + '</LpSprzedazy>' + nl
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'sprzedaz' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrKontrahenta>' + JPKStrND( trimnip( aDane[ 'sprzedaz' ][ nI ][ 'NrKontrahenta' ] ) ) + '</NrKontrahenta>' + nl
         cRes := cRes + '    <NazwaKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'NazwaKontrahenta' ] ) ) + '</NazwaKontrahenta>' + nl
         //cRes := cRes + '    <AdresKontrahenta>' + JPKStrND( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'AdresKontrahenta' ] ) ) + '</AdresKontrahenta>' + nl
         cRes := cRes + '    <DowodSprzedazy>' + JPKStrND( AllTrim( UsunZnakHash( aDane[ 'sprzedaz' ][ nI ][ 'DowodSprzedazy' ] ) ) ) + '</DowodSprzedazy>' + nl
         cRes := cRes + '    <DataWystawienia>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataWystawienia' ] ) + '</DataWystawienia>' + nl
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataSprzedazy' )
            cRes := cRes + '    <DataSprzedazy>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataSprzedazy' ] ) + '</DataSprzedazy>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'NrKSeF' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'NrKSeF' ] )
            cRes := cRes + '    <NrKSeF>' + aDane[ 'sprzedaz' ][ nI ][ 'NrKSeF' ] + '</NrKSeF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] $ ' B'
            cRes := cRes + '    <BFK>1</BFK>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] == 'O'
            cRes := cRes + '    <OFF>1</OFF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KSeFStat' ] == 'D'
            cRes := cRes + '    <DI>1</DI>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TypDokumentu' ) .AND. Len( AllTrim( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) ) > 0
            cRes := cRes + '    <TypDokumentu>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'TypDokumentu' ] ) + '</TypDokumentu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_01' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_01' ]
            cRes := cRes + '    <GTU_01>1</GTU_01>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_02' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_02' ]
            cRes := cRes + '    <GTU_02>1</GTU_02>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_03' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_03' ]
            cRes := cRes + '    <GTU_03>1</GTU_03>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_04' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_04' ]
            cRes := cRes + '    <GTU_04>1</GTU_04>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_05' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_05' ]
            cRes := cRes + '    <GTU_05>1</GTU_05>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_06' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_06' ]
            cRes := cRes + '    <GTU_06>1</GTU_06>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_07' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_07' ]
            cRes := cRes + '    <GTU_07>1</GTU_07>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_08' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_08' ]
            cRes := cRes + '    <GTU_08>1</GTU_08>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_09' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_09' ]
            cRes := cRes + '    <GTU_09>1</GTU_09>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_10' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_10' ]
            cRes := cRes + '    <GTU_10>1</GTU_10>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_11' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_11' ]
            cRes := cRes + '    <GTU_11>1</GTU_11>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_12' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_12' ]
            cRes := cRes + '    <GTU_12>1</GTU_12>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'GTU_13' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'GTU_13' ]
            cRes := cRes + '    <GTU_13>1</GTU_13>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'WSTO_EE' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'WSTO_EE' ]
            cRes := cRes + '    <WSTO_EE>1</WSTO_EE>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'IED' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'IED' ]
            cRes := cRes + '    <IED>1</IED>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TP' ]
            cRes := cRes + '    <TP>1</TP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_WNT' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_WNT' ]
            cRes := cRes + '    <TT_WNT>1</TT_WNT>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TT_D' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'TT_D' ]
            cRes := cRes + '    <TT_D>1</TT_D>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_T' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_T' ]
            cRes := cRes + '    <MR_T>1</MR_T>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MR_UZ' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MR_UZ' ]
            cRes := cRes + '    <MR_UZ>1</MR_UZ>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_42' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_42' ]
            cRes := cRes + '    <I_42>1</I_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'I_63' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'I_63' ]
            cRes := cRes + '    <I_63>1</I_63>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV' ]
            cRes := cRes + '    <B_SPV>1</B_SPV>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_SPV_DOSTAWA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_SPV_DOSTAWA' ]
            cRes := cRes + '    <B_SPV_DOSTAWA>1</B_SPV_DOSTAWA>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'B_MPV_PROWIZJA' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'B_MPV_PROWIZJA' ]
            cRes := cRes + '    <B_MPV_PROWIZJA>1</B_MPV_PROWIZJA>' + nl
         ENDIF
         //IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'MPP' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'MPP' ]
         //   cRes := cRes + '    <MPP>1</MPP>' + nl
         //ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'KorektaPodstawyOpodt' ) .AND. aDane[ 'sprzedaz' ][ nI ][ 'KorektaPodstawyOpodt' ]
            cRes := cRes + '    <KorektaPodstawyOpodt>1</KorektaPodstawyOpodt>' + nl
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'TerminPlatnosci' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] )
               cRes := cRes + '    <TerminPlatnosci>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'TerminPlatnosci' ] ) + '</TerminPlatnosci>' + nl
            ENDIF
            IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'DataZaplaty' ) .AND. ! Empty( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] )
               cRes := cRes + '    <DataZaplaty>' + date2strxml( aDane[ 'sprzedaz' ][ nI ][ 'DataZaplaty' ] ) + '</DataZaplaty>' + nl
            ENDIF
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
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_32V' )
            cRes := cRes + '    <K_32>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_32V' ] ) + '</K_32>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_36' )
            cRes := cRes + '    <K_33>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_36' ] ) + '</K_33>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_34>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_34>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_35>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_35>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_36>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_36>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_360' )
            cRes := cRes + '    <K_360>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_360' ] ) + '</K_360>' + nl
         ENDIF
   /*      IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_37' )
            cRes := cRes + '    <K_37>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_37' ] ) + '</K_37>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_38' )
            cRes := cRes + '    <K_38>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_38' ] ) + '</K_38>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'K_39' )
            cRes := cRes + '    <K_39>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'K_39' ] ) + '</K_39>' + nl
         ENDIF */
         IF hb_HHasKey( aDane[ 'sprzedaz' ][ nI ], 'SprzedazVAT_Marza' )
            cRes := cRes + '    <SprzedazVAT_Marza>' + TKwota2( aDane[ 'sprzedaz' ][ nI ][ 'SprzedazVAT_Marza' ] ) + '</SprzedazVAT_Marza>' + nl
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
         cRes := cRes + '    <KodKrajuNadaniaTIN>' + aDane[ 'zakup' ][ nI ][ 'KodKrajuNadaniaTIN' ] + '</KodKrajuNadaniaTIN>' + nl
         cRes := cRes + '    <NrDostawcy>' + JPKStrND( trimnip( aDane[ 'zakup' ][ nI ][ 'NrDostawcy' ] ) ) + '</NrDostawcy>' + nl
         cRes := cRes + '    <NazwaDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'NazwaDostawcy' ] ) ) + '</NazwaDostawcy>' + nl
         //cRes := cRes + '    <AdresDostawcy>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'AdresDostawcy' ] ) ) + '</AdresDostawcy>' + nl
         cRes := cRes + '    <DowodZakupu>' + JPKStrND( AllTrim( aDane[ 'zakup' ][ nI ][ 'DowodZakupu' ] ) ) + '</DowodZakupu>' + nl
         cRes := cRes + '    <DataZakupu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataZakupu' ] ) + '</DataZakupu>' + nl
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DataWplywu' )
            cRes := cRes + '    <DataWplywu>' + date2strxml( aDane[ 'zakup' ][ nI ][ 'DataWplywu' ] ) + '</DataWplywu>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'NrKSeF' ) .AND. ! Empty( aDane[ 'zakup' ][ nI ][ 'NrKSeF' ] )
            cRes := cRes + '    <NrKSeF>' + aDane[ 'zakup' ][ nI ][ 'NrKSeF' ] + '</NrKSeF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] $ ' B'
            cRes := cRes + '    <BFK>1</BFK>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] == 'O'
            cRes := cRes + '    <OFF>1</OFF>' + nl
         ELSEIF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'KSeFStat' ) .AND. aDane[ 'zakup' ][ nI ][ 'KSeFStat' ] == 'D'
            cRes := cRes + '    <DI>1</DI>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'DokumentZakupu' ) .AND. Len( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) > 0
            cRes := cRes + '    <DokumentZakupu>' + AllTrim( aDane[ 'zakup' ][ nI ][ 'DokumentZakupu' ] ) + '</DokumentZakupu>' + nl
         ENDIF
         /*IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'MPP' ) .AND. aDane[ 'zakup' ][ nI ][ 'MPP' ]
            cRes := cRes + '    <MPP>1</MPP>' + nl
         ENDIF*/
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'IMP' ) .AND. aDane[ 'zakup' ][ nI ][ 'IMP' ]
            cRes := cRes + '    <IMP>1</IMP>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_43' )
            cRes := cRes + '    <K_40>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_43' ] ) + '</K_40>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_44' )
            cRes := cRes + '    <K_41>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_44' ] ) + '</K_41>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_45' )
            cRes := cRes + '    <K_42>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_45' ] ) + '</K_42>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_46' )
            cRes := cRes + '    <K_43>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_46' ] ) + '</K_43>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_47' )
            cRes := cRes + '    <K_44>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_47' ] ) + '</K_44>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_48' )
            cRes := cRes + '    <K_45>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_48' ] ) + '</K_45>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_49' )
            cRes := cRes + '    <K_46>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_49' ] ) + '</K_46>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'K_50' )
            cRes := cRes + '    <K_47>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'K_50' ] ) + '</K_47>' + nl
         ENDIF
         IF hb_HHasKey( aDane[ 'zakup' ][ nI ], 'ZakupVAT_Marza' )
            cRes := cRes + '    <ZakupVAT_Marza>' + TKwota2( aDane[ 'zakup' ][ nI ][ 'ZakupVAT_Marza' ] ) + '</ZakupVAT_Marza>' + nl
         ENDIF
         cRes := cRes + '  </ZakupWiersz>' + nl
      NEXT

      IF hb_HHasKey( aDane, 'ZakupCtrl' )
         cRes := cRes + '  <ZakupCtrl>' + nl
         cRes := cRes + '    <LiczbaWierszyZakupow>' + AllTrim( Str( aDane[ 'ZakupCtrl' ][ 'LiczbaWierszyZakupow' ] ) ) + '</LiczbaWierszyZakupow>' + nl
         cRes := cRes + '    <PodatekNaliczony>' + TKwota2( aDane[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] ) + '</PodatekNaliczony>' + nl
         cRes := cRes + '  </ZakupCtrl>' + nl
      ENDIF
      cRes := cRes + '  </Ewidencja>' + nl
   ENDIF

   cRes := cRes + '</JPK>' + nl

   RETURN cRes

/*----------------------------------------------------------------------*/

