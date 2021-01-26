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

FUNCTION ewid_dr16licz()
   LOCAL aRes := hb_Hash(), aRow, _czy_close := .T.

   begin sequence
      aRes['pozycje'] := {}
      _koniec="del#[+].or.firma#ident_fir.or.mc#miesiac"

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
      if dostep('EWID')
         do SETIND with 'EWID'
         seek [+]+ident_fir+miesiac
      else
         break
      endif

      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if &_koniec
         break
      endif
      *@@@@@@@@@@@@@@@@@@@@@@@@@ NAGLOWEK @@@@@@@@@@@@@@@@@@@@@@@@@@@@
      store 0 to s0_4,s0_4a,s0_4b,s0_4c,s0_5,s0_6,s0_7
      store 0 to s1_4,s1_4a,s1_4b,s1_4c,s1_5,s1_6,s1_7
      *@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      aRes['miesiac'] := AllTrim(upper(miesiac(val(miesiac))))
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

      aRes['staw_ory20'] := AllTrim( staw_ory20 )
      aRes['staw_ory17'] := AllTrim( staw_ory17 )
      aRes['staw_ory10'] := AllTrim( staw_ory10 )
      aRes['staw_ohand'] := AllTrim( staw_ohand )
      aRes['staw_oprod'] := AllTrim( staw_oprod )
      aRes['staw_ouslu'] := AllTrim( staw_ouslu )
      aRes['staw_ork07'] := AllTrim( staw_ork07 )

      do while .not.&_koniec
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
            iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         k8=uwagi
         aRow['k1'] := k1
         aRow['k2'] := k2
         aRow['k3'] := k2a
         aRow['k4'] := k3
         aRow['k5'] := k4a
         aRow['k6'] := k4b
         aRow['k7'] := k4
         aRow['k8'] := k5
         aRow['k9'] := k6
         aRow['k10'] := k4d
         aRow['k11'] := k4c
         aRow['k12'] := k7
         aRow['k13'] := AllTrim( k8 )
         aRow['k5_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4a)
         aRow['k6_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4b)
         aRow['k7_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4)
         aRow['k8_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k5)
         aRow['k9_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k6)
         aRow['k10_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4d)
         aRow['k11_f'] := iif('REM-P'$k3.or.'REM-K'$k3,0,k4c)
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
   LOCAL nKorekta
   aDane := ewid_dr16licz()
   IF Len(aDane['pozycje']) > 0

      SAVE SCREEN TO cScr
      cKolor := ColPro()
      @ 16, 1  CLEAR TO 21, 40
      @ 16, 1, 21, 40 BOX B_SINGLE
      @ 17, 2 PROMPT ' T - Druk tekstowy                    '
      @ 18, 2 PROMPT ' G - Druk graficzny A4 (pionowo)      '
      @ 19, 2 PROMPT ' G - Druk graficzny A4 (poziomo)      '
      @ 20, 2 PROMPT ' J - Jednolity Plik Kontrolny JPK_EWP '
      nPoz=menu(nPoz)
      ColStd()
      IF LastKey() == 27
         RETURN
      ENDIF

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

         oRap := TFreeReport():New()
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
         oRap:AddValue('k7st', aDane['staw_uslu'])
         oRap:AddValue('k8st', aDane['staw_prod'])
         oRap:AddValue('k9st', aDane['staw_hand'])
         oRap:AddValue('k10st', aDane['staw_rk07'])
         oRap:AddValue('k11st', aDane['staw_ry10'])

         oRap:AddValue('k5op', aDane['staw_ory20'])
         oRap:AddValue('k6op', aDane['staw_ory17'])
         oRap:AddValue('k7op', aDane['staw_ouslu'])
         oRap:AddValue('k8op', aDane['staw_oprod'])
         oRap:AddValue('k9op', aDane['staw_ohand'])
         oRap:AddValue('k10op', aDane['staw_ork07'])
         oRap:AddValue('k11op', aDane['staw_ory10'])

         oRap:AddDataset('pozycje')
         oRap:AddValue('FP7', 0.0, .T.)
         oRap:AddValue('FP8', 0.0, .T.)
         oRap:AddValue('FP9', 0.0, .T.)
         oRap:AddValue('FP10', 0.0, .T.)
         oRap:AddValue('FP11', 0.0, .T.)
         oRap:AddValue('FP12', 0.0, .T.)
         oRap:AddValue('FP13', 0.0, .T.)
         oRap:AddValue('FP14', 0.0, .T.)
         oRap:AddValue('FP16', 0.0, .T.)
         oRap:AddValue('FS7', 0.0, .T.)
         oRap:AddValue('FS8', 0.0, .T.)
         oRap:AddValue('FS9', 0.0, .T.)
         oRap:AddValue('FS10', 0.0, .T.)
         oRap:AddValue('FS11', 0.0, .T.)
         oRap:AddValue('FS12', 0.0, .T.)
         oRap:AddValue('FS13', 0.0, .T.)
         oRap:AddValue('FS14', 0.0, .T.)
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
         AEval(aDane['pozycje'], {|aRec| aDane['SumaPrzychodow'] := aDane['SumaPrzychodow'] + aRec['k12']  } )

         cJPK := jpk_ewp_2(aDane)

         edekZapiszXML( cJPK, normalizujNazwe( 'JPK_EWP_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKEWP-2', nKorekta == 2, Val(miesiac) )

         EXIT
      ENDSWITCH
      RESTORE SCREEN FROM cScr
   ELSE
      kom(3,[*w],[b r a k   d a n y c h])
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

