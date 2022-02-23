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

#include "Box.ch"
#include "hbwin.ch"

FUNCTION ksiega16licz()
   LOCAL aRes := hb_Hash(), aRow
begin sequence
      *------------------------------
      aRes['pozycje'] := {}
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
      *@@@@@@@@@@@@@@@@@@@@@@@@@@ ZAKRES @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      *@@@@@@@@@@@@@@@@@@@@ OTWARCIE BAZ DANYCH @@@@@@@@@@@@@@@@@@@@@@
      select 3
      if dostep('FIRMA')
         go val(ident_fir)
      else
         sele 1
         break
      endif
      select 2
      if dostep('SUMA_MC')
         set inde to suma_mc
      else
         sele 1
         break
      endif
      seek [+]+ident_fir+mc_rozp
      startl=firma->liczba-1
      do while del=[+].and.firma=ident_fir.and.mc<miesiac
         startl=startl+pozycje
         skip
      enddo
      liczba=startl
      liczba_=startl
      select 1
      if dostep('OPER')
         do SETIND with 'OPER'
      else
         sele 1
         break
      endif
      seek [+]+ident_fir+miesiac
      strona=0
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         break
      endif
     *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
     store 0 to s0_7,s0_8,s0_9,s0_10,s0_11,s0_13,s0_14,s0_15,s0_16
     store 0 to s1_7,s1_8,s1_9,s1_10,s1_11,s1_13,s1_14,s1_15,s1_16
     *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
     aRes['miesiac'] := AllTrim(upper(miesiac(val(miesiac))))
     aRes['rok'] := param_rok
     select firma
     aRes['firma'] := alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk
     select oper
     do while .not.&_koniec
             *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
             aRow := hb_Hash()
             liczba=liczba+1
             //k1=liczba
             k1=lp
             k2=dzien
             k3=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer)
             k4=substr(nazwa,1,38)
             k5=substr(adres,1,37)
             k6=tresc
             k7=wyr_tow
             k8=uslugi
             k9=k7+k8
             k10=zakup
             k11=uboczne
             k13=wynagr_g
             k14=wydatki
             k15=k13+k14
             k16=pusta
             k17=uwagi
             k16w := K16WART
             k16o := K16OPIS
             znumer=numer
             skip
             aRow['k1'] := k1
             aRow['k2'] := k2
             aRow['k3'] := k3
             aRow['k4'] := k4
             aRow['k5'] := k5
             aRow['k6'] := k6
             aRow['k7'] := k7
             aRow['k8'] := k8
             aRow['k9'] := k9
             aRow['k10'] := k10
             aRow['k11'] := k11
             aRow['k13'] := k13
             aRow['k14'] := k14
             aRow['k15'] := k15
             aRow['k16'] := k16
             aRow['k17'] := k17
             aRow['k16w'] := k16w
             aRow['k16o'] := AllTrim( k16o )
             IF left(znumer,1)#chr(1).and.left(znumer,1)#chr(254)
                aRow['k7s'] := k7
                aRow['k8s'] := k8
                aRow['k9s'] := k9
                aRow['k10s'] := k10
                aRow['k11s'] := k11
                aRow['k13s'] := k13
                aRow['k14s'] := k14
                aRow['k15s'] := k15
                aRow['k16s'] := k16
             ELSE
                aRow['k7s'] := 0
                aRow['k8s'] := 0
                aRow['k9s'] := 0
                aRow['k10s'] := 0
                aRow['k11s'] := 0
                aRow['k13s'] := 0
                aRow['k14s'] := 0
                aRow['k15s'] := 0
                aRow['k16s'] := 0
             ENDIF
             AAdd(aRes['pozycje'], aRow)
          *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
          *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
          *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      enddo
end
   close_()

RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE ksiega16()
   LOCAL aDane, oRap, nLewaPrawa := 1, nMonDruk, cScr, cKolor, nPoz := 1, cJPK, cPlik, nFile
   LOCAL nP_1 := 0, nP_2 := 0, nP_3 := 0, nP_4 := 0, dP_5A := CToD(''), nP_5B := 0, cP_5 := 'N'
   LOCAL cKorekta := 'D', oWorkbook, oWorksheet, cPlikWyj, nWiersz
   aDane := ksiega16licz()
   IF Len(aDane['pozycje']) > 0

      SAVE SCREEN TO cScr
      cKolor := ColPro()
      @ 15, 0  CLEAR TO 22, 41
      @ 15, 0, 22, 41 BOX B_SINGLE
      @ 16, 1 PROMPT ' T - Druk tekstowy                      '
      @ 17, 1 PROMPT ' P - Druk graficzny A4 (poziomo)        '
      @ 18, 1 PROMPT ' G - Druk graficzny A4 (2 str.)         '
      @ 19, 1 PROMPT ' H - Druk graficzny A3                  '
      @ 20, 1 PROMPT ' J - Jednolity Plik Kontrolny JPK_PKPIR '
      @ 21, 1 PROMPT ' Z - Zapisz do pluku...                 '
      nPoz=menu(nPoz)
      ColStd()
      IF LastKey() == 27
         RETURN
      ENDIF

      SetColor( cKolor )

      SWITCH nPoz
      CASE 1
         DO ksiega13
         EXIT
      CASE 2
         @ 24, 0
         @ 24, 26 PROMPT '[ Monitor ]'
         @ 24, 44 PROMPT '[ Drukarka ]'
         IF trybSerwisowy
            @ 24, 70 PROMPT '[ Edytor ]'
         ENDIF
         CLEAR TYPE
         menu TO nMonDruk
         if lastkey()=27
            RETURN
         endif
         oRap := TFreeReport():New()
         oRap:LoadFromFile('frf\ksiega16b.frf')

         IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
            oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
         ENDIF

         FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
            hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

         oRap:AddValue('uzytkownik', code())
         oRap:AddValue('miesiac', aDane['miesiac'])
         oRap:AddValue('rok', aDane['rok'])
         oRap:AddValue('firma', aDane['firma'])
         oRap:AddValue('FP7', 0.0, .T.)
         oRap:AddValue('FP8', 0.0, .T.)
         oRap:AddValue('FP9', 0.0, .T.)
         oRap:AddValue('FP10', 0.0, .T.)
         oRap:AddValue('FP11', 0.0, .T.)
         oRap:AddValue('FP12', 0.0, .T.)
         oRap:AddValue('FP13', 0.0, .T.)
         oRap:AddValue('FP14', 0.0, .T.)
         oRap:AddValue('FP16', 0.0, .T.)
         oRap:AddValue('FPPS', 0.0, .T.)
         oRap:AddValue('FS7', 0.0, .T.)
         oRap:AddValue('FS8', 0.0, .T.)
         oRap:AddValue('FS9', 0.0, .T.)
         oRap:AddValue('FS10', 0.0, .T.)
         oRap:AddValue('FS11', 0.0, .T.)
         oRap:AddValue('FS12', 0.0, .T.)
         oRap:AddValue('FS13', 0.0, .T.)
         oRap:AddValue('FS14', 0.0, .T.)
         oRap:AddValue('FS16', 0.0, .T.)
         oRap:AddValue('FSPS', 0.0, .T.)
         oRap:AddDataset('pozycje')
         AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

         oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
         oRap:ModalPreview := .F.

         SWITCH nMonDruk
         CASE 1
            oRap:ShowReport()
            EXIT
         CASE 2
            oRap:PrepareReport()
            oRap:PrintPreparedReport('', 1)
            EXIT
         CASE 3
            oRap:DesignReport()
            EXIT
         ENDSWITCH

         oRap := NIL
         EXIT

      CASE 3
         @ 24,0
         @ 24,15 prompt '[ Wszystke ]'
         @ 24,30 prompt '[ Lewe ]'
         @ 24,41 prompt '[ Prawe ]'
         clear type
         menu TO nLewaPrawa
         if lastkey()=27
            RETURN
         endif

         @ 24, 0
         @ 24, 26 PROMPT '[ Monitor ]'
         @ 24, 44 PROMPT '[ Drukarka ]'
         IF trybSerwisowy
            @ 24, 70 PROMPT '[ Edytor ]'
         ENDIF
         CLEAR TYPE
         menu TO nMonDruk
         if lastkey()=27
            RETURN
         endif

         IF nLewaPrawa == 1 .OR. nLewaPrawa == 2
            oRap := TFreeReport():New()
            oRap:LoadFromFile('frf\ksiega16l.frf')

            IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
               oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
            ENDIF

            FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
               hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

            oRap:AddValue('uzytkownik', code())
            oRap:AddValue('miesiac', aDane['miesiac'])
            oRap:AddValue('rok', aDane['rok'])
            oRap:AddValue('firma', aDane['firma'])
            oRap:AddDataset('pozycje')
            AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

            oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
            oRap:ModalPreview := .F.

            SWITCH nMonDruk
            CASE 1
               oRap:ShowReport()
               EXIT
            CASE 2
               oRap:PrepareReport()
               oRap:PrintPreparedReport('', 1)
               EXIT
            CASE 3
               oRap:DesignReport()
               EXIT
            ENDSWITCH

            oRap := NIL
         ENDIF

         IF nLewaPrawa == 1 .OR. nLewaPrawa == 3
            IF nLewaPrawa == 1 .AND. nMonDruk == 2
               do while .not.entesc([*i]," Teraz b&_e.dzie drukowana prawa cz&_e.&_s.&_c. ksi&_e.gi - zmie&_n. papier i naci&_s.nij [Enter] ")
                  if lastkey()=27
                     exit
                  endif
               enddo
            ENDIF
            oRap := TFreeReport():New()
            oRap:LoadFromFile('frf\ksiega16p.frf')

            IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
               oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
            ENDIF

            FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
               hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

            oRap:AddValue('uzytkownik', code())
            oRap:AddValue('miesiac', aDane['miesiac'])
            oRap:AddValue('rok', aDane['rok'])
            oRap:AddValue('firma', aDane['firma'])
            oRap:AddValue('FP7', 0.0, .T.)
            oRap:AddValue('FP8', 0.0, .T.)
            oRap:AddValue('FP9', 0.0, .T.)
            oRap:AddValue('FP10', 0.0, .T.)
            oRap:AddValue('FP11', 0.0, .T.)
            oRap:AddValue('FP12', 0.0, .T.)
            oRap:AddValue('FP13', 0.0, .T.)
            oRap:AddValue('FP14', 0.0, .T.)
            oRap:AddValue('FP16', 0.0, .T.)
            oRap:AddValue('FPPS', 0.0, .T.)
            oRap:AddValue('FS7', 0.0, .T.)
            oRap:AddValue('FS8', 0.0, .T.)
            oRap:AddValue('FS9', 0.0, .T.)
            oRap:AddValue('FS10', 0.0, .T.)
            oRap:AddValue('FS11', 0.0, .T.)
            oRap:AddValue('FS12', 0.0, .T.)
            oRap:AddValue('FS13', 0.0, .T.)
            oRap:AddValue('FS14', 0.0, .T.)
            oRap:AddValue('FS16', 0.0, .T.)
            oRap:AddValue('FSPS', 0.0, .T.)
            oRap:AddDataset('pozycje')
            AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

            oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
            oRap:ModalPreview := .F.

            SWITCH nMonDruk
            CASE 1
               oRap:ShowReport()
               EXIT
            CASE 2
               oRap:PrepareReport()
               oRap:PrintPreparedReport('', 1)
               EXIT
            CASE 3
               oRap:DesignReport()
               EXIT
            ENDSWITCH

            oRap := NIL
         ENDIF
         EXIT
      CASE 4
         @ 24, 0
         @ 24, 26 PROMPT '[ Monitor ]'
         @ 24, 44 PROMPT '[ Drukarka ]'
         IF trybSerwisowy
            @ 24, 70 PROMPT '[ Edytor ]'
         ENDIF
         CLEAR TYPE
         menu TO nMonDruk
         if lastkey()=27
            RETURN
         endif
         oRap := TFreeReport():New()
         oRap:LoadFromFile('frf\ksiega16.frf')

         IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
            oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
         ENDIF

         FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
            hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

         oRap:AddValue('uzytkownik', code())
         oRap:AddValue('miesiac', aDane['miesiac'])
         oRap:AddValue('rok', aDane['rok'])
         oRap:AddValue('firma', aDane['firma'])
         oRap:AddValue('FP7', 0.0, .T.)
         oRap:AddValue('FP8', 0.0, .T.)
         oRap:AddValue('FP9', 0.0, .T.)
         oRap:AddValue('FP10', 0.0, .T.)
         oRap:AddValue('FP11', 0.0, .T.)
         oRap:AddValue('FP12', 0.0, .T.)
         oRap:AddValue('FP13', 0.0, .T.)
         oRap:AddValue('FP14', 0.0, .T.)
         oRap:AddValue('FP16', 0.0, .T.)
         oRap:AddValue('FPPS', 0.0, .T.)
         oRap:AddValue('FS7', 0.0, .T.)
         oRap:AddValue('FS8', 0.0, .T.)
         oRap:AddValue('FS9', 0.0, .T.)
         oRap:AddValue('FS10', 0.0, .T.)
         oRap:AddValue('FS11', 0.0, .T.)
         oRap:AddValue('FS12', 0.0, .T.)
         oRap:AddValue('FS13', 0.0, .T.)
         oRap:AddValue('FS14', 0.0, .T.)
         oRap:AddValue('FS16', 0.0, .T.)
         oRap:AddValue('FSPS', 0.0, .T.)
         oRap:AddDataset('pozycje')
         AEval(aDane['pozycje'], { |aPoz| oRap:AddRow('pozycje', aPoz) })

         oRap:OnClosePreview := 'UsunRaportZListy(' + AllTrim(Str(DodajRaportDoListy(oRap))) + ')'
         oRap:ModalPreview := .F.

         SWITCH nMonDruk
         CASE 1
            oRap:ShowReport()
            EXIT
         CASE 2
            oRap:PrepareReport()
            oRap:PrintPreparedReport('', 1)
            EXIT
         CASE 3
            oRap:DesignReport()
            EXIT
         ENDSWITCH

         oRap := NIL
         EXIT
      CASE 5

         SAVE SCREEN TO cScr
         cKolor := ColStd()
         @ 6, 0 CLEAR TO 19, 79
         @ 8, 0, 18, 79 BOX B_SINGLE
         @ 9, 1 SAY '                                   Deklaracja czy Korekta (D/K)'
         @ 10, 1 SAY '            Warto˜† spisu z natury na pocz¥tek roku podatkowego'
         @ 11, 1 SAY '              Warto˜† spisu z natury na koniec roku podatkowego'
         @ 12, 1 SAY 'Koszty uzysk. przych.,wg obj.do podatk. ksi©gi przych. i rozch.'
         @ 13, 1 SAY '     Doch¢d osi¥gni©ty w roku podatkowym, wg obja˜nieä do PKPiR'
         @ 14, 1 SAY '          Spis z natury dokonany w ci¥gu roku podatkowego (T/N)'
         @ 15, 1 SAY '     Data spisu z natury sporz¥dzonego w ci¥gu roku podatkowego'
         @ 16, 1 SAY '  Warto˜† spisu z natury sporz¥dzonego w ci¥gu roku podatkowego'

         @ 9, 65 GET cKorekta PICTURE '!' VALID cKorekta#'DK'
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
         aDane['DataOd'] := hb_Date(Val(param_rok), Val(miesiac), 1)
         aDane['DataDo'] := EoM(aDane['DataOd'])
         aDane['CelZlozenia'] := iif(cKorekta == 'K', '2', '1')

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

         aDane['rok'] := Val(param_rok)
         aDane['miesiac'] := Val(miesiac)

         aDane['LiczbaWierszy'] := Len(aDane['pozycje'])
         aDane['SumaPrzychodow'] := 0
         AEval(aDane['pozycje'], {|aRec| aDane['SumaPrzychodow'] := aDane['SumaPrzychodow'] + aRec['k9']  } )

         cJPK := jpk_pkpir(aDane)
         //@24, 0 SAY PadC('... weryfikacja struktury pliku JPK ...')
         /* edekWeryfikuj(cJPK, 'JPKPKPIR-1') == 0 .AND. */

         edekZapiszXML( cJPK, normalizujNazwe( 'JPK_PKPIR_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKKPR-2', cKorekta == 'K', Val(miesiac) )

/*
         IF (cPlik := win_GetSaveFileName( , , , 'xml', {{'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'}}, , , ;
            'JPK_PKPiR ' + AllTrim(aDane['NazwaSkr']) + ' ' + param_rok + ' ' + CMonth(aDane['DataOd']))) <> ''
            nFile := FCreate(cPlik)
            IF nFile != -1
               FWrite(nFile, cJPK)
               FClose(nFile)
               komun('Utworzono plik JPK')
            ENDIF
         ENDIF
*/

         EXIT

      CASE 6
         IF ( cPlikWyj := FPSFileSaveDialog() ) <> ""
            IF ( oWorkbook := TsWorkbook():New() ) <> NIL
               IF ( oWorksheet := oWorkbook:AddWorksheet( "PKPiR" ) ) <> NIL
                  oWorksheet:WriteColWidth( 0, 5, 0 )
                  oWorksheet:WriteColWidth( 1, 10, 0 )
                  oWorksheet:WriteColWidth( 2, 15, 0 )
                  oWorksheet:WriteColWidth( 3, 25, 0 )
                  oWorksheet:WriteColWidth( 4, 25, 0 )
                  oWorksheet:WriteColWidth( 5, 25, 0 )
                  oWorksheet:WriteColWidth( 6, 15, 0 )
                  oWorksheet:WriteColWidth( 7, 15, 0 )
                  oWorksheet:WriteColWidth( 8, 15, 0 )
                  oWorksheet:WriteColWidth( 9, 15, 0 )
                  oWorksheet:WriteColWidth( 10, 15, 0 )
                  oWorksheet:WriteColWidth( 11, 15, 0 )
                  oWorksheet:WriteColWidth( 12, 15, 0 )
                  oWorksheet:WriteColWidth( 13, 15, 0 )
                  oWorksheet:WriteColWidth( 14, 5, 0 )
                  oWorksheet:WriteColWidth( 15, 25, 0 )
                  oWorksheet:WriteColWidth( 16, 15, 0 )
                  oWorksheet:WriteColWidth( 17, 25, 0 )
                  oWorksheet:WriteText( 0, 0, aDane[ 'firma' ] )
                  oWorksheet:WriteText( 1, 0, "Miesi¥c: " + aDane[ 'miesiac' ] + " " + aDane[ 'rok' ] )
                  oWorksheet:WriteText( 3, 0, "L.p." )
                  oWorksheet:WriteText( 3, 1, "Dzieä zdarzenia gospodarczego" )
                  oWorksheet:WriteText( 3, 2, "Nr dowodu ksi©gowego" )
                  oWorksheet:WriteText( 3, 3, "Kontrahent - nazwa" )
                  oWorksheet:WriteText( 3, 4, "Kontrahent - adres" )
                  oWorksheet:WriteText( 3, 5, "Opis zdarzenia" )
                  oWorksheet:WriteText( 3, 6, "Warto˜† sprzedanych towar¢w i usˆug" )
                  oWorksheet:WriteText( 3, 7, "Pozostaˆe przychody" )
                  oWorksheet:WriteText( 3, 8, "Razem przych¢d" )
                  oWorksheet:WriteText( 3, 9, "Zakup towar¢w i materiaˆ¢w" )
                  oWorksheet:WriteText( 3, 10, "Koszty uboczne zakupu" )
                  oWorksheet:WriteText( 3, 11, "Wynagrodzenia" )
                  oWorksheet:WriteText( 3, 12, "Pozostaˆe wydatki" )
                  oWorksheet:WriteText( 3, 13, "Razem wydatki" )
                  oWorksheet:WriteText( 3, 14, "(pusta)" )
                  oWorksheet:WriteText( 3, 15, "Dzieˆalno˜† badawcza - opis kosztu" )
                  oWorksheet:WriteText( 3, 16, "Dzieˆalno˜† badawcza - warto˜†" )
                  oWorksheet:WriteText( 3, 17, "Uwagi" )
                  nWiersz := 4
                  AEval( aDane[ 'pozycje' ], { | aRow |
                     oWorksheet:WriteNumber( nWiersz, 0, aRow['k1'] )
                     oWorksheet:WriteDate( nWiersz, 1,hb_Date( Val( param_rok ), Val( miesiac ), Val( aRow['k2'] ) ) )
                     oWorksheet:WriteText( nWiersz, 2, AllTrim( aRow['k3'] ) )
                     oWorksheet:WriteText( nWiersz, 3, AllTrim( aRow['k4'] ) )
                     oWorksheet:WriteText( nWiersz, 4, AllTrim( aRow['k5'] ) )
                     oWorksheet:WriteText( nWiersz, 5, AllTrim( aRow['k6'] ) )
                     IF aRow['k7'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 6, aRow['k7'] )
                     ENDIF
                     IF aRow['k8'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 7, aRow['k8'] )
                     ENDIF
                     IF aRow['k9'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 8, aRow['k9'] )
                     ENDIF
                     IF aRow['k10'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 9, aRow['k10'] )
                     ENDIF
                     IF aRow['k11'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 10, aRow['k11'] )
                     ENDIF
                     IF aRow['k13'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 11, aRow['k13'] )
                     ENDIF
                     IF aRow['k14'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 12, aRow['k14'] )
                     ENDIF
                     IF aRow['k15'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 13, aRow['k15'] )
                     ENDIF
                     IF aRow['k16'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 14, aRow['k16'] )
                     ENDIF
                     oWorksheet:WriteText( nWiersz, 15, AllTrim( aRow['k16o'] ) )
                     IF aRow['k16w'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 16, aRow['k16w'] )
                     ENDIF
                     oWorksheet:WriteText( nWiersz, 17, AllTrim( aRow['k17'] ) )
                     nWiersz++
                  } )
                  IF oWorkbook:WriteToFile( cPlikWyj ) == 0
                     Komun( "Plik zostaˆ utworzony" )
                  ENDIF
               ENDIF
            ELSE

            ENDIF
         ENDIF
         oWorksheet := NIL
         oWorkbook := NIL
         EXIT

      ENDSWITCH
      RESTORE SCREEN FROM cScr
   ELSE
      kom(3,[*w],[b r a k   d a n y c h])
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

