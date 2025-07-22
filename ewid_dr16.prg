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

#include "box.ch"
#include "hbcompat.ch"

FUNCTION ewid_dr16licz( dDataOd, dDataDo )
   LOCAL aRes := hb_Hash(), aRow, _czy_close := .T., cMOd, cDOd, cMDo, cDDo

   begin sequence
      aRes['pozycje'] := {}

      IF dDataOd < hb_Date( Val( param_rok ), 1, 1 ) .OR. dDataDo > hb_Date( Val( param_rok ), 12, 31 )
         BREAK
      ENDIF

      //_koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"
      _koniec := { || del # '+' .or. firma # ident_fir .or. hb_Date( Val( param_rok ), Val( mc ), Val( dzien ) ) < dDataOd .OR. hb_Date( Val( param_rok ), Val( mc ), Val( dzien ) ) > dDataDo }

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
         set index to suma_mc
         seek [+]+ident_fir+mc_rozp
         liczba=firma->liczba-1
         do while del=[+].and.firma=ident_fir.and.mc<miesiac
            liczba=liczba+pozycje
            skip
         enddo
         liczba_=liczba
      else
         sele 1
         break
      endif
      select 1
      cMOd := Str( Month( dDataOd ), 2 )
      cDOd := Str( Day( dDataOd ), 2 )
      cMDo := Str( Month( dDataDo ), 2 )
      cDDo := Str( Day( dDataDo ), 2 )
      if dostep('EWID')
         do SETIND with 'EWID'
         //seek [+]+ident_fir+miesiac
         seek '+' + ident_fir + cMOd + cDOd
      else
         break
      endif

      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      IF Eval( _koniec )
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_4,s0_4a,s0_4b,s0_4c,s0_5,s0_6,s0_7
      store 0 to s1_4,s1_4a,s1_4b,s1_4c,s1_5,s1_6,s1_7
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      //aRes['miesiac'] := AllTrim(upper(miesiac(val(miesiac))))
      IF Month( dDataOd ) == Val( miesiac ) .AND. Month( dDataDo ) == Val( miesiac )
         aRes['miesiac'] := 'miesi¥c ' + AllTrim( Upper( miesiac( Val( miesiac ) ) ) ) + ' ' + param_rok
      ELSE
         aRes['miesiac'] := 'okres od ' + DToC( dDataOd ) + ' do ' + DToC( dDataDo )
      ENDIF
      aRes['rok'] := param_rok
      select firma
      aRes['firma'] := alltrim(nazwa)+[ ]+miejsc+[ ul.]+ulica+[ ]+nr_domu+iif(empty(nr_mieszk),[ ],[/])+nr_mieszk
      select ewid
      aRes['staw_ry20'] := staw_ry20 * 100
      aRes['staw_ry17'] := staw_ry17 * 100
      aRes['staw_ry10'] := staw_ry10 * 100
      aRes['staw_hand'] := staw_hand * 100
      aRes['staw_prod'] := staw_prod * 100
      aRes['staw_uslu'] := staw_uslu * 100
      aRes['staw_rk07'] := staw_rk07 * 100
      aRes['staw_rk09'] := staw_rk09 * 100
      aRes['staw_rk10'] := staw_rk10 * 100

      aRes['staw_ory20'] := AllTrim( staw_ory20 )
      aRes['staw_ory17'] := AllTrim( staw_ory17 )
      aRes['staw_ory10'] := AllTrim( staw_ory10 )
      aRes['staw_ohand'] := AllTrim( staw_ohand )
      aRes['staw_oprod'] := AllTrim( staw_oprod )
      aRes['staw_ouslu'] := AllTrim( staw_ouslu )
      aRes['staw_ork07'] := AllTrim( staw_ork07 )
      aRes['staw_ork09'] := AllTrim( staw_ork09 )
      aRes['staw_ork10'] := AllTrim( staw_ork10 )

      do while .NOT. Eval( _koniec )
         *@@@@@@@@@@@@@@@@@@@@@@ MODUL OBLICZEN @@@@@@@@@@@@@@@@@@@@@@@@@
         aRow := hb_Hash()
         k1=lp
         k2=strtran(param_rok + '-' + miesiac + '-' + dzien,' ','0')
         k2a=date2strxml(dataprzy)
         k3=iif(left(numer,1)=chr(1).or.left(numer,1)=chr(254),substr(numer,2)+[ ],numer)
         k4a=ry20
         k4b=ry17
         k4c=ry10
         k4d=ryk07
         k4e=ryk09
         k4f=ryk10
         k4=uslugi
         k5=produkcja
         k6=handel
*         iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         k7=iif('REM-P'$k3.or.'REM-K'$k3,0,k4)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k5)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k6)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4e)+;
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4f)
         k8=uwagi
         aRow['k1'] := k1
         aRow['k2'] := k2
         aRow['k3'] := k2a
         aRow['k4'] := k3
         aRow['k5'] := k4a
         aRow['k6'] := k4b
         aRow['k7'] := k4e
         aRow['k8'] := k4
         aRow['k9'] := k4f
         aRow['k10'] := k5
         aRow['k11'] := k6
         aRow['k12'] := k4d
         aRow['k13'] := k4c
         aRow['k14'] := k7
         aRow['k15'] := AllTrim( k8 )
         aRow['k5_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)
         aRow['k6_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)
         aRow['k7_g'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4e)
         aRow['k8_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         aRow['k9_h'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4f)
         aRow['k10_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k5)
         aRow['k11_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k6)
         aRow['k12_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         aRow['k13_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)
         AAdd(aRes['pozycje'], aRow)
         skip
      enddo
      *@@@@@@@@@@@@@@@@@@@@@@@ ZAKONCZENIE @@@@@@@@@@@@@@@@@@@@@@@@@@@
   end
   if _czy_close
      close_()
   endif

RETURN aRes

/*----------------------------------------------------------------------*/

PROCEDURE ewid_dr16rob()
   LOCAL aDane, oRap, nMonDruk, cScr, cKolor, nPoz := 1, cJPK, cPlik, nFile
   LOCAL nKorekta, oWorkbook, oWorksheet, cPlikWyj, nWiersz
   LOCAL KolOrd := Array( 9 ), KolStaw := { 170, 150, 140, 125, 120, 100, 85, 55, 30 }
   LOCAL nKol, nI, KolNaz := { 'staw_ry20', 'staw_ry17', 'staw_rk09', 'staw_uslu', ;
      'staw_rk10', 'staw_prod', 'staw_hand', 'staw_rk07', 'staw_ry10' }
   LOCAL xEwidDrZakres

   xEwidDrZakres := EwidDrMcLubZakres( 18, 7 )

   IF Empty( xEwidDrZakres )
      RETURN
   ENDIF

   aDane := ewid_dr16licz( xEwidDrZakres[ 1 ], xEwidDrZakres[ 2 ] )

   IF Len(aDane['pozycje']) > 0

      nPoz := GrafTekst_Wczytaj( ident_fir, "EwidDr16", nPoz )

      SAVE SCREEN TO cScr
      cKolor := ColPro()
      @ 16, 1  CLEAR TO 22, 40
      @ 16, 1, 22, 40 BOX B_SINGLE
      @ 17, 2 PROMPT ' T - Druk tekstowy                    '
      @ 18, 2 PROMPT ' G - Druk graficzny A4 (pionowo)      '
      @ 19, 2 PROMPT ' G - Druk graficzny A4 (poziomo)      '
      @ 20, 2 PROMPT ' J - Jednolity Plik Kontrolny JPK_EWP '
      @ 21, 2 PROMPT ' Z - Zapisz do pliku...               '
      nPoz=menu(nPoz)
      ColStd()
      IF LastKey() == 27
         RETURN
      ENDIF

      GrafTekst_Zapisz( ident_fir, "EwidDr16", nPoz )

      SetColor( cKolor )

      SWITCH nPoz
      CASE 1
         ewid_dr()
         EXIT
      CASE 2
      CASE 3
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

         TRY
            oRap := FRUtworzRaport()
            oRap:LoadFromFile( iif( nPoz == 2, 'frf\ewid.frf', 'frf\ewidp.frf' ) )

            IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
               oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
            ENDIF

            FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
               hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

            oRap:AddValue('uzytkownik', code())
            oRap:AddValue('miesiac', aDane['miesiac'])
            oRap:AddValue('rok', aDane['rok'])
            oRap:AddValue('firma', aDane['firma'])

            oRap:AddValue('k5st', aDane['staw_ry20'])
            oRap:AddValue('k6st', aDane['staw_ry17'])
            oRap:AddValue('k7st', aDane['staw_rk09'])
            oRap:AddValue('k8st', aDane['staw_uslu'])
            oRap:AddValue('k9st', aDane['staw_rk10'])
            oRap:AddValue('k10st', aDane['staw_prod'])
            oRap:AddValue('k11st', aDane['staw_hand'])
            oRap:AddValue('k12st', aDane['staw_rk07'])
            oRap:AddValue('k13st', aDane['staw_ry10'])

            oRap:AddValue('k5op', aDane['staw_ory20'])
            oRap:AddValue('k6op', aDane['staw_ory17'])
            oRap:AddValue('k7op', aDane['staw_ork09'])
            oRap:AddValue('k8op', aDane['staw_ouslu'])
            oRap:AddValue('k9op', aDane['staw_ork10'])
            oRap:AddValue('k10op', aDane['staw_oprod'])
            oRap:AddValue('k11op', aDane['staw_ohand'])
            oRap:AddValue('k12op', aDane['staw_ork07'])
            oRap:AddValue('k13op', aDane['staw_ory10'])

            oRap:AddDataset('pozycje')
            oRap:AddValue('FP7', 0.0, .T.)
            oRap:AddValue('FP8', 0.0, .T.)
            oRap:AddValue('FP9', 0.0, .T.)
            oRap:AddValue('FP10', 0.0, .T.)
            oRap:AddValue('FP11', 0.0, .T.)
            oRap:AddValue('FP12', 0.0, .T.)
            oRap:AddValue('FP13', 0.0, .T.)
            oRap:AddValue('FP14', 0.0, .T.)
            oRap:AddValue('FP15', 0.0, .T.)
            oRap:AddValue('FP16', 0.0, .T.)
            oRap:AddValue('FS7', 0.0, .T.)
            oRap:AddValue('FS8', 0.0, .T.)
            oRap:AddValue('FS9', 0.0, .T.)
            oRap:AddValue('FS10', 0.0, .T.)
            oRap:AddValue('FS11', 0.0, .T.)
            oRap:AddValue('FS12', 0.0, .T.)
            oRap:AddValue('FS13', 0.0, .T.)
            oRap:AddValue('FS14', 0.0, .T.)
            oRap:AddValue('FS15', 0.0, .T.)
            oRap:AddValue('FS16', 0.0, .T.)
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
         CATCH oErr
            Alert( "Wyst¥piˆ bˆ¥d podczas generowania wydruku;" + oErr:description )
         END

         oRap := NIL

         EXIT
      CASE 4

         nKorekta := edekCzyKorekta( 17, 2 )

         IF nKorekta == 0
            RETURN .F.
         ENDIF

         aDane['DataWytworzeniaJPK'] := datetime2strxml(hb_DateTime())
         aDane['DataOd'] := hb_Date(Val(param_rok), Val(miesiac), 1)
         aDane['DataDo'] := EoM(aDane['DataOd'])

         aDane['CelZlozenia'] := iif( nKorekta == 2, '2', '1' )

         IF ! DostepPro( 'URZEDY' )
            RETURN .F.
         ENDIF
         IF ! DostepPro( 'FIRMA', , .T., , 'FIRMA' )
            urzedy->( dbCloseArea() )
            RETURN .F.
         ENDIF
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
         AEval(aDane['pozycje'], {|aRec| aDane['SumaPrzychodow'] := aDane['SumaPrzychodow'] + aRec['k14']  } )

         nI := 1
         AEval( KolNaz, { | cNazwa |
            nKol := AScan( KolStaw, Int( aDane[ cNazwa ] * 10 ) )
            IF nKol > 0
               KolOrd[ nI ] := 'k' + AllTrim( Str( nKol + 4 ) )
            ENDIF
            nI++
         } )

         aDane[ 'kolumny' ] := KolOrd

         cJPK := jpk_ewp_3(aDane)

         edekZapiszXML( cJPK, normalizujNazwe( 'JPK_EWP_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKEWP-3', nKorekta == 2, Val(miesiac) )

         EXIT
      CASE 5
         IF ( cPlikWyj := FPSFileSaveDialog() ) <> ""
            IF ( oWorkbook := TsWorkbook():New() ) <> NIL
               IF ( oWorksheet := oWorkbook:AddWorksheet( "Ewidencja przychod¢w" ) ) <> NIL
                  oWorksheet:WriteColWidth( 0, 5, 0 )
                  oWorksheet:WriteColWidth( 1, 10, 0 )
                  oWorksheet:WriteColWidth( 2, 10, 0 )
                  oWorksheet:WriteColWidth( 3, 25, 0 )
                  oWorksheet:WriteColWidth( 4, 15, 0 )
                  oWorksheet:WriteColWidth( 5, 15, 0 )
                  oWorksheet:WriteColWidth( 6, 15, 0 )
                  oWorksheet:WriteColWidth( 7, 15, 0 )
                  oWorksheet:WriteColWidth( 8, 15, 0 )
                  oWorksheet:WriteColWidth( 9, 15, 0 )
                  oWorksheet:WriteColWidth( 10, 15, 0 )
                  oWorksheet:WriteColWidth( 11, 15, 0 )
                  oWorksheet:WriteColWidth( 12, 15, 0 )
                  oWorksheet:WriteColWidth( 13, 15, 0 )
                  oWorksheet:WriteColWidth( 14, 25, 0 )

                  oWorksheet:WriteText( 0, 0, aDane[ 'firma' ] )
                  oWorksheet:WriteText( 1, 0, "Miesi¥c: " + aDane[ 'miesiac' ] + " " + aDane[ 'rok' ] )

                  oWorksheet:WriteText( 3, 0, "L.p." )
                  oWorksheet:WriteText( 3, 1, "Data wpisu" )
                  oWorksheet:WriteText( 3, 2, "Data uzyskania przychodu" )
                  oWorksheet:WriteText( 3, 3, "Nr dowodu" )
                  oWorksheet:WriteText( 3, 4, "Przychody op. st. " + NumToStr( aDane[ 'staw_ry20' ] ) + "% (" + aDane[ 'staw_ory20' ] + ")" )
                  oWorksheet:WriteText( 3, 5, "Przychody op. st. " + NumToStr( aDane[ 'staw_ry17' ] ) + "% (" + aDane[ 'staw_ory17' ] + ")" )
                  oWorksheet:WriteText( 3, 6, "Przychody op. st. " + NumToStr( aDane[ 'staw_rk09' ] ) + "% (" + aDane[ 'staw_ork09' ] + ")" )
                  oWorksheet:WriteText( 3, 7, "Przychody op. st. " + NumToStr( aDane[ 'staw_uslu' ] ) + "% (" + aDane[ 'staw_ouslu' ] + ")" )
                  oWorksheet:WriteText( 3, 8, "Przychody op. st. " + NumToStr( aDane[ 'staw_rk10' ] ) + "% (" + aDane[ 'staw_ork10' ] + ")" )
                  oWorksheet:WriteText( 3, 9, "Przychody op. st. " + NumToStr( aDane[ 'staw_prod' ] ) + "% (" + aDane[ 'staw_oprod' ] + ")" )
                  oWorksheet:WriteText( 3, 10, "Przychody op. st. " + NumToStr( aDane[ 'staw_hand' ] ) + "% (" + aDane[ 'staw_ohand' ] + ")" )
                  oWorksheet:WriteText( 3, 11, "Przychody op. st. " + NumToStr( aDane[ 'staw_rk07' ] ) + "% (" + aDane[ 'staw_ork07' ] + ")" )
                  oWorksheet:WriteText( 3, 12, "Przychody op. st. " + NumToStr( aDane[ 'staw_ry10' ] ) + "% (" + aDane[ 'staw_ory10' ] + ")" )
                  oWorksheet:WriteText( 3, 13, "Og¢ˆem przychody" )
                  oWorksheet:WriteText( 3, 14, "Uwagi" )
                  nWiersz := 4
                  AEval( aDane[ 'pozycje' ], { | aRow |
                     oWorksheet:WriteNumber( nWiersz, 0, aRow['k1'] )
                     oWorksheet:WriteText( nWiersz, 1, aRow['k2'] )
                     oWorksheet:WriteText( nWiersz, 2, AllTrim( aRow['k3'] ) )
                     oWorksheet:WriteText( nWiersz, 3, AllTrim( aRow['k4'] ) )
                     IF aRow['k5'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 4, aRow['k5'] )
                     ENDIF
                     IF aRow['k6'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 5, aRow['k6'] )
                     ENDIF
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
                     IF aRow['k12'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 11, aRow['k12'] )
                     ENDIF
                     IF aRow['k13'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 12, aRow['k13'] )
                     ENDIF
                     IF aRow['k14'] <> 0
                        oWorksheet:WriteCurrency( nWiersz, 13, aRow['k14'] )
                     ENDIF
                     oWorksheet:WriteText( nWiersz, 14, AllTrim( aRow['k15'] ) )
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

