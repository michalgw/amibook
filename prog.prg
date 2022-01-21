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

#require hbwin.ch
#include "hblang.ch"
#include "dbinfo.ch"
#include "hbgtinfo.ch"
#include "hbfr.ch"
#include "inkey.ch"

REQUEST HB_LANG_PL
REQUEST HB_CODEPAGE_PL852
REQUEST HB_GT_WIN_DEFAULT
REQUEST HB_GT_WVT
REQUEST DBFCDX
REQUEST ARRAYRDD

FUNCTION Main()

   LOCAL nCnt, GetList := {}
   LOCAL a, b, i
   LOCAL wersjadll, C1, C2, C3

   rddSetDefault( "DBFCDX" )
   HB_LANGSELECT( 'PL' )
   hb_cdpSelect( 'PL852' )
   SetMode( 25, 80 )
   SET DBFLOCKSCHEME TO DB_DBFLOCK_VFP
   SET AUTOPEN OFF
   hb_gtInfo( HB_GTI_PALETTE, { 0x000000, 0x800000, 0x008000, 0x808000, 0x000080, 0x800080, 0x008080, 0xc0c0c0, ;
     0x808080, 0xff0000, 0x00ff00, 0xffff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffffff } )
   hb_GtInfo( HB_GTI_CLOSABLE, .F. )
   hb_GtInfo( HB_GTI_ALTENTER, .T. )
   hb_gtInfo( HB_GTI_MAXIMIZED, .T. )

   // Tymczasowa nazwa pliku z wydrukiem
   PUBLIC RAPTEMP := ''

   // Wlasna obsluga bledow - rejestrowanie bledow
   AmiErrorSys()

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±± S R O D O W I S K O ±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

* Nowe zmienne globalen
   PUBLIC wersprog, wersjaprogramu, czy_edeklaracja, rob_edeklaracja, edeklaracja_plik, katalog_programu, amiDllH, trybSerwisowy, nrrewizjiprog, wys_edeklaracja
   // Licencja
   PUBLIC aLicencjaUzytkownika := hb_Hash()
   //wersjaprogramu = 140600
   UstawWersje()
   wersprog := wersja2str( wersjaprogramu )

   czy_edeklaracja := .F. // Czy druk mozliwy jako edeklaracja (funkcja mod_drk)
   rob_edeklaracja := .F. // Czy robimy edeklaracje (j.w.)
   wys_edeklaracja := .F. // Czy wysylamy eDeklaracje (uruchamiamy program zewnetrzny)
   edeklaracja_plik := '' // Plik docelowy edeklaracji
   PUBLIC edek_transport := 1 // Transport 1 - WinHTTP, 2 - Synapse + OpenSSL

   // Tytul okna
   hb_gtInfo( HB_GTI_WINTITLE, "AMi-BOOK " + wersprog )

   katalog_programu := hb_FNameDir( ft_Origin() )

   PUBLIC cPunktLogowania := NetName()

   // Czy wlaczamy debugger albo wlasna nazwa punktu? (parametr lini polecen TRYBSERWISOWY)

   IF hb_argc() > 0
      FOR nCnt := 1 TO hb_argc()
         IF Upper( hb_argv( nCnt ) ) == 'TRYBSERWISOWY'
            trybSerwisowy := .T.
         ENDIF
         IF Upper( hb_argv( nCnt ) ) == '//GTWVT'
            // nic nie rob
         ENDIF
         IF Upper( hb_argv( nCnt ) ) == '//PELNYEKRAN'
            hb_gtInfo( HB_GTI_ISFULLSCREEN, .T. )
         ENDIF
         IF Upper( hb_argv( nCnt ) ) <> 'TRYBSERWISOWY' .AND. Upper( hb_argv( nCnt ) ) <> '//GTWVT' .AND. Upper( hb_argv( nCnt ) ) <> '//PELNYEKRAN' .AND. Upper( hb_argv( nCnt ) ) <> '//OPENSSL'
            cPunktLogowania := hb_argv( nCnt )
         ENDIF
         IF Upper( hb_argv( nCnt ) ) == '//OPENSSL'
            edek_transport := 2
         ENDIF
      NEXT
   ENDIF

   // Urucamiamy debuger w trybie serwisowym
   IF trybSerwisowy
      AltD( 1 )
      AltD()
   ELSE
      AltD( 0 )
   ENDIF

   // licencja uzytkownika - nowa
   PUBLIC wersja1 := .T., wersja4 := .T., wersja2 := .F., wersja3 := .F., nr_uzytk := 0
   PUBLIC kod_uzytk := 'Licencja GNU GPL'
   PUBLIC nip_uzytk := ''

   // Tablica z domyslnymi parametrami dla poszczegolnych lat
   PUBLIC aDomyslneParametry := NIL
   DomyslneParametry()

   * Parametry eDeklaracji - wczytywane przed inicjacja amidll
   PUBLIC param_edka, param_edpr, param_edpz, param_edpw, param_edpv, param_edmo, param_edsh, param_ejmo, param_ejts
   param_edka := PadR( 'edek', 250 ) // katalog w ktorym beda zapisane edeklaracje
   param_edpr := Space( 250 )        // program (exe) do wysylania edeklaracji
   param_edpz := 'T'                 //
   param_edpw := 'P'
   param_edpv := 'P'
   param_edmo := 'W'

   // Parametry JPK
   param_ejmo := 'W'
   param_ejts := 'N'

   // Rodzaj SHA = 1 (SHA1)
   param_edsh = '1'

   // Urz¥d skarbowy dla IFT-2R
   param_eiku := '0671'

   // Urz¥d skarbowy dla VIU-DO
   param_evku := '1436'

   // Parametry edeklaracji
   IF File( 'paramedek.mem' )
      RESTORE FROM paramedek ADDITIVE
   ENDIF

   // wczytanie bibliteki amibook.dll i sprawdzenie wersji
   IF !amiDllZaladuj()
      Alert( 'Nie znaleziono pliku "amibook.dll".;Program dziaˆa z ograniczon¥ funkcjonalno˜ci¥.', { 'OK' } )
   ELSE

      wersjadll = amiInicjuj( wersjaprogramu, win_P2N( hb_gtInfo( HB_GTI_WINHANDLE ) ), edek_transport, Val( param_edsh ) )

      DO CASE
      CASE wersjadll == 0
         Alert( 'Brak licencji.;Program dziaˆa z ograniczon¥ funkcjonalno˜ci¥.', { 'OK' } )
      CASE wersjadll == wersjaprogramu
         IF amiPobierzLicencje( @kod_uzytk, @nip_uzytk, @nr_uzytk, @wersja1, @wersja2, @wersja3, @wersja4 ) == 0
            kod_uzytk := 'Licencja GNU GPL'
            nr_uzytk := 0
         ELSE
            kod_uzytk := AllTrim( kod_uzytk )
         ENDIF
      OTHERWISE
         Alert( 'Niezgodnosc wersji biblioteki "amibook.dll".;' + ;
           'Wymagana: ' + Str( wersjaprogramu ) + ';Odczytana: ' + Str( wersjadll ), { 'Zamknij' } )
         SET CURSOR ON
         amiDllZakoncz()
         CANCEL
      ENDCASE

      IF .NOT. trybSerwisowy
         hb_IdleAdd( { || amiProcessMessages() } )
      ENDIF

   ENDIF

   // tablica przechowujaca obiekty TFreeReport
   PUBLIC aListaRaportow := {}

   // Inicjowanie biblioteki hbfr.dll - freereport
   IF !hbfr_LoadLibrary( HBFR_LIB_NAME, .T. )
      Alert( 'Nie udaˆo si© zaˆadowa† biblioteki hbfr.dll. Sprawd« poprawno˜† instalacji.', { 'Zamknij' } )
      amiDllZakoncz()
      CANCEL
   ENDIF

   IF ! WinPrintInit()
      Alert( 'Nie udaˆo si© zaˆadowa† biblioteki libwinprint.dll. Sprawd« poprawno˜† instalacji.;Sterownik wydruku WIN zostaˆ wyˆ¥czony.', { 'OK' } )
   ENDIF

   PUBLIC param_ks5v, param_ks5d, param_kslp, param_ksnd, param_kskw, param_ksv7
   param_ks5v := '1'
   param_ks5d := '1'
   param_kslp := ''
   param_ksnd := 'N'
   param_kskw := 'N'
   param_ksv7 := 'T'

   //Bufor wydruku
   PUBLIC buforDruku := '', kodStartDruku := ''

   // Profile drukarek
   PUBLIC aProfileDrukarek := {}, aDomProfilDrukarki := hb_Hash(), nDomProfilDrukarkiIdx := 0,;
      nWybProfilDrukarkiIdx := 0

   // Profil uzytkownika
   PUBLIC hProfilUzytkownika := hb_Hash()

   *---

   // Kolory
   PRIVATE CCCN   := 'N'
   PRIVATE CCCW   := 'W'
   PRIVATE CCCG   := 'G'
   PRIVATE CCCGR  := 'GR'
   PRIVATE CCCGRJ := 'GR+'
   PRIVATE CCCR   := 'R'
   PRIVATE CCCRB  := 'RB'
   PRIVATE CCCRBJ := 'RB+'
   PRIVATE CCCBG  := 'BG'
   PRIVATE CCCB   := 'B'
   PRIVATE KINESKOP

   PRIVATE CColErr, CColInf, CColInb, CColDlg, CColStd, CColSta, CColSti, CColStb, CColPro, CColInv

   STORE '' to CColErr, CColInf, CColInb, CColDlg, CColStd, CColSta, CColSti, CColStb, CColPro, CColInv

   IF File('kolor.mem')
      RESTORE FROM kolor ADDITIVE
      zmienkolor()
   ELSE
      KINESKOP := 'K'
      CCCN     := 'N'
      CCCW     := 'W'
      CCCG     := 'G'
      CCCGR    := 'GR'
      CCCGRJ   := 'GR+'
      CCCR     := 'R'
      CCCRB    := 'RB'
      CCCRBJ   := 'RB+'
      CCCBG    := 'BG'
      CCCB     := 'B'

      CColErr := '&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
      CColInf := '&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColInb := '&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
      CColDlg := '&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCW'
      CColStd := '&CCCGR/&CCCN,&CCCN/&CCCG,&CCCGR/&CCCN,&CCCGR/&CCCN,&CCCN/&CCCW'
      CColSta := '&CCCG/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColSti := '&CCCN/&CCCG,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColStb := '&CCCG*/&CCCN,&CCCN/&CCCG,,&CCCN,&CCCG/&CCCN'
      CColPro := '&CCCN/&CCCGR,&CCCN/&CCCG,,&CCCN,&CCCN/&CCCGR'
      CColInv := '&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'

      IF .NOT. IsColor()
         CCCN   := 'N'
         CCCW   := 'W'
         CCCG   := 'G'
         CCCGR  := 'GR'
         CCCGRJ := 'GR+'
         CCCR   := 'R'
         CCCRB  := 'RB'
         CCCRBJ := 'RB+'
         CCCBG  := 'BG'
         CCCB   := 'B'

         c1 := CCCN + '/' + CCCW
         c2 := CCCW + '/' + CCCN
         c3 := CCCW + '+/' + CCCW

         KINESKOP := 'M'

         CColErr := '&CCCGRJ/&CCCR,&CCCGRJ/&CCCRBJ,,&CCCN,&CCCR/&CCCN'
         CColInf := '&CCCG/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
         CColInb := '&CCCG*/&CCCRBJ,&CCCGRJ/&CCCB,,&CCCN,&CCCN/&CCCBG'
         CColDlg := C2 + ',' + C1 + ',,&CCCN,&CCCN/&CCCW'
         CColStd := '&CCCGR/&CCCN,' + C3 + ',,&CCCN,&CCCN/&CCCW'
         CColSta := '&CCCG/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
         CColSti := '&CCCW/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
         CColStb := '&CCCG*/&CCCN,' + C3 + ',,&CCCN,&CCCG/&CCCN'
         CColPro := C2 + ',' + C1 + ',,&CCCN,' + C2
         CColInv := '&CCCGR/&CCCN,&CCCN/&CCCW,,&CCCN,&CCCGR/&CCCN'
      ENDIF
   ENDIF

   SAVE TO kolor ALL LIKE KINESKOP

   //---

   // Polskie znaki
   PRIVATE POLSKA_1
   PRIVATE POLSKA_2
   PRIVATE POLSKA_3
   PRIVATE POLSKA_D

   IF File('POLSKA.mem')
      RESTORE FROM polska ADDITIVE
   ELSE
      POLSKA_1 := .F.
      POLSKA_2 := .F.
      POLSKA_3 := '0'
      POLSKA_D := 'N'
      SAVE TO polska ALL LIKE polska_*
   ENDIF

   PRIVATE JESTPOL := .F.

   PRIVATE y, znaki

   IF POLSKA_1 .AND. File( 'POLZNAK.DEF' )
      y := FOpen( 'POLZNAK.DEF', 0 )
      znaki := FReadStr( y, 18 )
      IF FError() == 0
         JESTPOL := .T.
      ENDIF
      FClose( y )
   ELSE
      znaki := 'ACELNOSZZacelnoszz'
   ENDIF

   PRIVATE __A := SubStr( znaki, 1, 1 )
   PRIVATE __C := SubStr( znaki, 2, 1 )
   PRIVATE __E := SubStr( znaki, 3, 1 )
   PRIVATE __L := SubStr( znaki, 4, 1 )
   PRIVATE __N := SubStr( znaki, 5, 1 )
   PRIVATE __O := SubStr( znaki, 6, 1 )
   PRIVATE __S := SubStr( znaki, 7, 1 )
   PRIVATE __X := SubStr( znaki, 8, 1 )
   PRIVATE __Z := SubStr( znaki, 9, 1 )
   PRIVATE _A := SubStr( znaki, 10, 1 )
   PRIVATE _C := SubStr( znaki, 11, 1 )
   PRIVATE _E := SubStr( znaki, 12, 1 )
   PRIVATE _L := SubStr( znaki, 13, 1 )
   PRIVATE _N := SubStr( znaki, 14, 1 )
   PRIVATE _O := SubStr( znaki, 15, 1 )
   PRIVATE _S := SubStr( znaki, 16, 1 )
   PRIVATE _X := SubStr( znaki, 17, 1 )
   PRIVATE _Z := SubStr( znaki, 18, 1 )

   // ---

   // Ustawienie srodowiska
   SetCancel( .F. )
   ReadExit( .F. )
   ReadInsert( .F. )
   SET TALK OFF
   SET EXACT ON
   SET CURSOR OFF
   SET SOFTSEEK ON
   SET CENTURY ON
   SET DATE ANSI
   SET DELETED ON
   SET WRAP ON
   SET SCOREBOARD OFF

   // Sprawdzenie czy program uruchomiony przez starter (menu.exe lub ksiega.exe)
   IF ! File( 'start' )
      @ 24, 0 SAY 'wywo&_l.anie programu - KSIEGA.BAT'
      ?
      SET CURSOR ON
      hbfr_FreeLibrary()
      amiDllZakoncz()
      WinPrintDone()
      CANCEL
   ENDIF
   ERASE start

   // Sprawdzamy czy mamy wystarczajace miejsce na dysku
   IF ( SubStr( katalog_programu, 1, 2 ) <> '\\' ) .AND. ( DiskSpace() < 1000000 )
      CLEAR
      ColErr()
      center( 15, '                                     ' )
      center( 16, '   Brak pami&_e.ci dyskowej (min 1Mb)   ' )
      center( 17, '                                     ' )
      SET COLOR TO
      pause( 3 )
      SET CURSOR ON
      hbfr_FreeLibrary()
      amiDllZakoncz()
      WinPrintDone()
      CANCEL
   ENDIF

   // ---

   // Ogolne parametry

   // Haslo do programu
   PUBLIC param_has := Space( 8 )

   // Aktualny rok kalendarzowy na podstawie wersji programu
   PUBLIC param_rok := '20' + SubStr( PadL( AllTrim( Str( wersjaprogramu ) ), 6 ), 1, 2 )


   // Sygnal o VAT - kwota
   PUBLIC param_vat := 39800

   // Automateczne tworzenie kartoteki kontrahentow
   PUBLIC param_aut := 'T'

   // Numerowanie pozycji ksiegi
   PUBLIC param_lp  := 'N'

   // Podatek liniowy %
   PUBLIC param_lin := 19

   // Domyslne wojewodztwo i powiat
   PUBLIC param_woj := 'DOLNOSLASKIE        '
   PUBLIC param_pow := 'WROCLAWSKI          '

   // Dzwieki w programie
   PUBLIC param_dzw := 'T'

   // Wlasny tytul okna
   PUBLIC param_tyt := '                   '

   // ---

   // Parametry placowe

   // Podstawa do zus (51, 53)
   PUBLIC parap_p51 := 3155.40

   // Podstawa do zdrow. (52)
   PUBLIC parap_p52 := 4242.38

   // Koszt uzyskania przychodu
   PUBLIC parap_kos := 250

   // Miesieczne odliczanie podatku
   PUBLIC parap_odl := 525.12 / 12

   // Stawka podatku dochodowego
   PUBLIC parap_pod := 17

   // Stawka zasadnicza chorobowego (do 33 dni)
   PUBLIC parap_cho := 80

   // Zdrowotne do zus (ubezpieczony)
   PUBLIC parap_puz := 9

   // Zdrowotne do odliczen (ubezpieczony)
   PUBLIC parap_pzk := 9

   // Emerytalne (ubezpieczony)
   PUBLIC parap_pue := 9.76

   // Rentowe (ubezpieczony)
   PUBLIC parap_pur := 6.5

   // Chorobowe (ubezpieczony)
   PUBLIC parap_puc := 2.45

   // Stawka na ubezpieczenie wypadkowe (ubezpieczony)
   // TODO: do sprawdzenia: prawdopodobnie nieuzywana zmienna
   PUBLIC parap_puw := 0

   // Fundusz pracy (ubezpieczony)
   PUBLIC parap_pfp := 0

   // Fundusz G—P (ubezpieczony)
   PUBLIC parap_pfg := 0

   // 3-filar (ubezpieczony)
   PUBLIC parap_pf3 := 7

   // Zdrowotne do zus (platnik)
   PUBLIC parap_fuz := 0

   // Emerytalne (platnik)
   PUBLIC parap_fue := 9.76

   // Rentowe (platnik)
   PUBLIC parap_fur := 6.5

   // Chorobowe (platnik)
   PUBLIC parap_fuc := 0

   // Stawka na ubezpieczenie wypadkowe (platnik)
   // TODO: do sprawdzenia: prawdopodobnie nieuzywana zmienna
   PUBLIC parap_fuw := 1.62

   // Stawka na ubezpieczenie wypadkowe ?? (platnik)
   // TODO: do sprawdzenia: prawdopodobnie nieuzywana zmienna
   PUBLIC parap_fww := 1.62

   // Fundusz pracy (platnik)
   PUBLIC parap_ffp := 2.45

   // Fundusz G—P (platnik)
   PUBLIC parap_ffg := 0

   // 3-filar (platnik)
   PUBLIC parap_ff3 := 0

   // Domyslny symbol kasy choryc
   PUBLIC parap_rkc := '01R'

   // Liczba dni wolnych pˆatnych 100% przez pracodawc©
   PUBLIC parap_ldw := 33

   // ---

   // Parametry do obliczania korekt

   // Krotkie terminy zaplaty do dni
   PUBLIC parar_ter := 60

   // Korekta VAT gdy uplynie...
   PUBLIC parar_vat := 150

   // Korekta dla krotkich terminow (dni po terminie zaplaty)
   PUBLIC parar_kok := 30

   //Korekta dla dluzszych terminow (dni po zaliczeniu w koszty)
   PUBLIC parar_kod := 90

   // ---

   // PPK - Wpˆata podstawowa pracownik¢w (stawka %)
   PUBLIC parpk_sz := 2
   // PPK - Wpˆata podstawowa pracodawcy (stawka %)
   PUBLIC parpk_sp := 1.5

   // ---

   // Parametry eksportu do platnika i starej edeklaracji

   // Katalog wysciowy pliku
   PUBLIC paraz_cel := '.\' + Space( 58 )
   // Wersja KEDU ( 1 - 1.3; 2 - 5.2 )
   PUBLIC paraz_wer := 1

   // ---

   // Staweki podatku zrycz. przechowywane w pliku TAB_RYCZ.MEM

   // Handel
   PUBLIC staw_hand := 0.03

   // Produkcja
   PUBLIC staw_prod := 0.055

   // Uslugi
   PUBLIC staw_uslu := 0.085

   // Wolna zawody
   PUBLIC staw_ry20 := 0.17

   // Inne uslugi
   PUBLIC staw_ry17 := 0.15

   // Prawa maj.
   PUBLIC staw_ry10 := 0.1

   // Wynajem pow. 100000
   PUBLIC staw_rk07 := 0.125

   // Art. 6 ust. 1d
   PUBLIC staw_rk08 := 0.02

   // Opieka zdrow., architekt, projekt
   PUBLIC staw_rk09 := 0.14

   // ???
   PUBLIC staw_rk10 := 0.12

   // Wˆ¥cz osma kolumna ( stawka 2% )
   PUBLIC staw_k08w := .F.

   // Handel K9
   PUBLIC staw_ohand := 'Handel                  '

   // Produkcja K8
   PUBLIC staw_oprod := 'Produkcja               '

   // Uslugi K7
   PUBLIC staw_ouslu := 'Usˆugi                  '

   // Wolna zawody K5
   PUBLIC staw_ory20 := 'Wolne zawody            '

   // Inne uslugi K6
   PUBLIC staw_ory17 := 'Inne usˆugi             '

   // Prawa maj. K11
   PUBLIC staw_ory10 := 'Prawa maj¥tkowe         '

   // Wynajem pow. 100000 K10
   PUBLIC staw_ork07 := 'Wynajem pow.100000zˆ    '

   // Art. 6 ust. 1d
   PUBLIC staw_ork08 := 'Art. 6 ust. 1d          '

   // Opieka zdrow., architekt, projekt
   PUBLIC staw_ork09 := 'Opieka zdr, archit.,proj'

   // Opieka zdrow., architekt, projekt
   PUBLIC staw_ork10 := 'Usl.wyd.oprogr.,dor.komp'

   // ---

   // Stawki podatku VAT

   PUBLIC vat_A := 23
   PUBLIC vat_B := 8
   PUBLIC vat_C := 5
   PUBLIC vat_D := 7

   // ---

   // Sledzenie zaplat

   // Podczas ksiegowania do KSIEGI
   PUBLIC pzROZRZAPK := 'N'

   // Podczas ksigowania do REJ.SPRZEDAZY
   PUBLIC pzROZRZAPS := 'N'

   // Podczas ksiegowania do REJ.ZAKUPOW
   PUBLIC pzROZRZAPZ := 'N'

   // Podczas wystawiania FAKTUR
   PUBLIC pzROZRZAPF := 'N'

   PUBLIC param_kw := 525.12

   PUBLIC param_kwd := d"2019-10-01"
   PUBLIC param_kw2 := 525.12

   // --

   // Odtawrzamy parametry z param.mem
   //lub pokazujemy edycje parametrow jesli plik nie istnieje
   IF File( 'param.mem' )
      RESTORE FROM param ADDITIVE
   ELSE
      //DO PARAM
      Param()
   ENDIF

   // Parametry edeklaracji - ponowne pobranie bo nadpisane przez param.meme
   IF File( 'paramedek.mem' )
      RESTORE FROM paramedek ADDITIVE
   ENDIF

   // Usuwamy stare i niepotrzebne zmienne
   RELEASE param_drk, param_cal

   // Ustawienie wlasnego tytulu okna
   IF Len( AllTrim( param_tyt ) ) > 0
      hb_gtInfo( HB_GTI_WINTITLE, AllTrim( param_tyt ) + " - AMi-BOOK " + wersprog )
   ENDIF

   // ---

   // Kody sterujace drukarki

   PUBLIC kod_10cp, kod_12cp, kod_17cp, kod_8wc, kod_6wc, kod_res, kod_lf, kod_ff, ;
      kod_bold,kod_rbol, kod_mikr, kod_eject

   STORE '' TO kod_10cp, kod_12cp, kod_17cp, kod_8wc, kod_6wc, kod_res, kod_lf, kod_ff, ;
      kod_bold,kod_rbol, kod_mikr, kod_eject

   kod_eject := Chr( 12 ) + Chr( 13 )

   // ---

   // Wczytywanie parametrow z plikow mem
   // lub pokazanie odpowiedniego edytora parametrow

   // Parametry placowe i zus
   IF File( 'param_p.mem' )
      RESTORE FROM param_p ADDITIVE
   ELSE
      //DO param_p
      Param_P()
   ENDIF

   IF File( 'param_ppk.mem' )
      RESTORE FROM param_ppk ADDITIVE
   ENDIF

   // Parametry obliczania korekt
   IF File( 'param_r.mem' )
      RESTORE FROM param_r ADDITIVE
   ELSE
      //do param_ro
      Param_Ro()
   ENDIF

   // Parametry eksportu do Platnika
   IF File( 'param_zu.mem' )
      RESTORE FROM param_zu ADDITIVE
   ELSE
      //do param_zu
      Param_Zu()
   ENDIF

   // Stawki podatku zryczaltowanego
   IF File( 'tab_rycz.mem' )
      RESTORE FROM tab_rycz ADDITIVE
   ELSE
      //do tab_rycz
      Tab_Rycz()
   ENDIF

   // Parametry ksiegowe
   IF File( 'parksg.mem' )
      RESTORE FROM parksg ADDITIVE
   ENDIF

   // ---

   // Zmienne wydruku formularzy
   PUBLIC nazform := Array( 10 )
   PUBLIC strform := Array( 10 )
   AFill( nazform, '' )
   AFill( strform, 0 )

   // Czy wystapil blad
   // TODO: Sprawdzic czy jest uzywane
   PUBLIC awaria

   // Parametr logiczny uzywany w drukach przelewow i wplat
   PUBLIC zPodatki := .F.

   // ---

   // Zmienne parametrow aktualnej firmy

   // Identyfikator firmy - RecNo()
   PUBLIC ident_fir := Str( 0, 3 )

   // Czy platnik vat ('T'/'N')
   PUBLIC ZVAT

   // VAT miesiecznie / kwartalnie ('M'/'K')
   PUBLIC zVATOKRES

   // TODO: Parametr nieuzywany do usuniecia wraz z odwolaniami
   PUBLIC zVATOKRESDR

   // Rodzaj deklaracji VAT-7 ('7 ', '7D', '7K')
   PUBLIC zVATFORDR

   // Rodzaj deklaracji VAT-UE ('M'/'K')
   PUBLIC zUEOKRES

   // Czy firma jest na ryczalcie ('T'/'N')
   PUBLIC ZRYCZALT

   // Rachunki wprowadzac bruttem ('T'/'N')
   PUBLIC DETALISTA

   PUBLIC Firma_RodzNrKs := 'R'
   // ---

   // System wydruku tekstowego

   // Strona lewa/prawa/obie
   PUBLIC STRL := 1

   // Zakres wydruku
   PUBLIC STRONAP := 1
   PUBLIC STRONAK := 99999

   // Jaka zesc raportu jest drukowana
   PUBLIC CZESC := 0

   // Formaty liczb
   // TODO: Sprawdzic wykozystanie
   PUBLIC RPIC    := '@ZE 999999999.99'
   PUBLIC RPICOLD := '@ZE 9 999 999.99'
   PUBLIC RPICE   := '@ZE 999 999 999.99'
   PUBLIC FPIC    := '@ZE  99999999.99'
   PUBLIC RVPIC   := '@Z  99999999'
   PUBLIC FVPIC   := '@Z   9999999'
   PUBLIC DRPIC   := '@E 9 999 999.99'
   PUBLIC DRPICE  := '@E 999 999 999.99'
   PUBLIC DRVPIC  := ' 99999999'
   PUBLIC FPICOLD := '@ZE   9999999.99'
   PUBLIC DFPIC, DFVPIC

   // ---

   // Uwzgledniac remanent koncowy roku (T/N)
   PUBLIC _DEKLINW_ := 'T'

   // ---

   // Zmienne kalkulatora
   PUBLIC MEMKALK1, MEMKALK2, MEMKALK3, MEMKALK4
   STORE 0 TO MEMKALK1, MEMKALK2, MEMKALK3, MEMKALK4
   PUBLIC KALKDESK := ''
   PUBLIC POPOP := '+'
   PUBLIC TASMA := Array( 1 )
   TASMA[ 1 ] := '  ' + Transform( MEMKALK4, '999 999 999 999.99999' )
   PUBLIC LPTASMY := 1

   PUBLIC olparam_sa := .T.
   PUBLIC olparam_ra := .F.
   PUBLIC olparam_rd := 180

   PUBLIC firma_rodzajdrfv := 'G'

   // Parametry on-line
   IF File( 'olparam.mem' )
      RESTORE FROM olparam ADDITIVE
   ENDIF

   // ---

   // Ustawienie srotow klawiszowych
   SET KEY K_ALT_F9  TO kll
   SET KEY K_ALT_F10 TO kll
   SET KEY K_ALT_F11 TO kll
   SET KEY K_ALT_F12 TO kll
   SET KEY K_SH_F9   TO kll
   SET KEY K_SH_F10  TO kll
   SET KEY K_SH_F11  TO kll
   SET KEY K_SH_F12  TO kll
   SET KEY K_ALT_K   TO KALKUL
   SET KEY K_ALT_N   TO NOTES
   SET KEY K_ALT_F8  TO VAT_Sprzwdz_NIP_DlgK
   SET KEY K_ALT_F9  TO VAT_Sprawdz_Vies_DlgF

   // ---

   // Wyswitlamy czolowke jesli nie byly wykonywane zadania wymagajace przerwania programu
   IF ! File( 'arch.mem' ) .AND. ! File( 'odtw.mem' ) .AND. ! File( 'mslowo.mem' ) ;
      .AND. ! File( 'mks.mem' ) .AND. ! File( 'instart.bat' )

      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± A W A R I A ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      erase dalb.mem

      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±± I N S T A L A C J A ±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      IF ! File( '*.cdx' ) .OR. File( 'install.mem' )

         CLEAR

         ColInf()
         center( 24, 'Prosz&_e. czeka&_c....' )
         //TODO: zmienna 'awaria' prawdopodobnie nie uzywana
         SAVE TO install ALL LIKE awaria
         // Reindeksacja zbiorow
         Indeks()

         SET CURS OFF

         // Numeracja ksiegi
         //Numeruj()
         Ksiega_Przenumeruj()

         ERASE install.mem
         ColStd()
      ENDIF
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±± C Z O L O W K A ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
      *±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

      CLEAR
      ColStd()
      @ 24,0
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '                               ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ' )
      QOut( '                               Û°°°°°°°°°°°°°°°Û' )
      QOut( '                               Û°°°°AMi-BOOK°°°Û' )
      QOut( '                               Û°°°°ver.XX.X°°°Û' )
      QOut( '                               Û°°°°°°°°°°°°°°°Û' )
      QOut( '                               ßßßßßßßÛÛÛßßßßßßß' )
      QOut( '                            ÜÜÜÜÜÜÜÛÛÛÛÛÛÛÛÛÜÜÜÜÜÜÜ' )
      QOut( '                            ÛøøøÛÛÛÛÛÛÛÛÛÛÛÛÛÚÍÍÍ¿Û' )
      QOut( '                            ßßßßßßßßßßßßßßßßßßßßßßß' )
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '' )
      QOut( '                                   GM Systems  ' )
      QOut( '                               ul. Karola Marksa 9' )
      QOut( '                                 58-260 Bielawa' )
      QOut( '                                tel: 694 178 276' )
      QOut( '                                www.gmsystems.pl' )
      QOut( '' )
      QOut( '' )

      @ 8, 40 SAY wersprog

      a := 39
      b := 40
      ColSta()

      DO WHILE a >= 3
         @ 15, a, 17, b box( 'ÉÍ»º¼ÍÈº ' )
         a := a - 1
         b := b + 1
         i := 0
         DO WHILE i<3
            i := i + 1
         ENDDO
      ENDDO

      ***********
      @ 16,  4 SAY '°±²²Û  K S I &__E. G A    P R Z Y C H O D &__O. W   I   R O Z C H O D &__O. W  Û²²±°'
      @  7, 36 SAY 'AMi-BOOK'

      center( 23, 'U&_z.ytkownik: ' + AllTrim( code() ) )
      @ 24, 75 SAY STR( nr_uzytk, 4 )

      IF param_dzw == 'T'
         tone(510,1)
         tone(610,1)
         tone(510,1)
         tone(690,1)
         tone(690,1)
         tone(610,1)
         tone(690,1)
      ENDIF

      ColDlg()

      IF Empty( param_has )
         Inkey( 0 )
         IF LastKey() == K_ESC
            CLEAR
            SET CURSOR ON
            hbfr_FreeLibrary()
            amiDllZakoncz()
            WinPrintDone()
            CANCEL
         ENDIF
      ELSE
         center( 24, ' (Prosz&_e. poda&_c. has&_l.o) ' )
      ENDIF
      DO WHILE .T.
         IF haslo( AllTrim( param_has ) )
            ColStd()
            @ 24,0
            EXIT
         ELSE
            IF LastKey() == K_ESC
               CLEAR
               SET CURSOR ON
               hbfr_FreeLibrary()
               amiDllZakoncz()
               WinPrintDone()
               CANCEL
            ENDIF
            @ 24,0
            kom( 1, '+w',' Nieprawid&_l.owe has&_l.o ' )
         ENDIF
         center( 24, '(Prosz&_e. poda&_c. has&_l.o)' )
      ENDDO
      ColStd()
   ENDIF

   // Tworzenie tymczasowego pliku na wydruki
   IF Type( 'RAPTEMP' ) == 'L'
      RAPTEMP := '_' + StrTran( Time(), ':', '' ) + '_'
      dbCreate( RAPTEMP, { { "LINIA_L", "C", 190, 0 }, { "LINIA_P", "C", 190, 0 } }, "ARRAYRDD" )
   ELSE
      IF Len( AllTrim( RAPTEMP ) ) == 0
         RAPTEMP := '_' + StrTran( Time(), ':', '' ) + '_'
         dbCreate( RAPTEMP, { { "LINIA_L", "C", 190, 0 }, { "LINIA_P", "C", 190, 0 } }, "ARRAYRDD" )
      ENDIF
   ENDIF

   // Wczytanie profilu drukarek i uzytkownika
   WczytajProfileDrukarek()
   hProfilUzytkownika := WczytajProfilUzytkownika()

   IF hProfilUzytkownika[ 'mysz' ]
      SET EVENTMASK TO 255
      mSetCursor( .T. )
   ENDIF

   // Wybrany certyfikat do podpisu edeklaracji
   PUBLIC aWybranyCertyfikat := hb_Hash( 'wybrany', .F. )

   // Ustawienie sortowania ksiegi
   IF param_kslp == ''
      IF WERSJA4
         param_kslp := '1'
      ELSE
         param_kslp := '2'
      ENDIF
   ELSE
      IF param_kslp == '2'
         WERSJA4 := .F.
      ELSE
         WERSJA4 := .T.
      ENDIF
   ENDIF

   IF olparam_sa == .T.
      SprawdzAktualizacje( .F. )
   ENDIF

   // Uruchamiamy glowne menu
   menu_()

   // Usuwamy plik tymczasowy wydruku
   IF File( RAPTEMP + '.dbf' )
      DELETE FILE &RAPTEMP..dbf
   ENDIF
   IF File( RAPTEMP + '.cdx' )
      DELETE FILE &RAPTEMP..cdx
   ENDIF

   RELE ALL
   CLEAR ALL
   ERASE exit.mem
   SET CURSOR OFF
   SET COLOR TO
   CLEAR SCREEN

   RETURN NIL

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± M E N U ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±


FUNCTION _()
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± S T R O N A ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

   MEMVAR ident_fir, param_rok, scr, o

   ColSta()

   ident_fir := Str( 0, 3 )

   @  0, 0 SAY '                                                                                '
   @  1, 0 SAY status()
   @  2, 0 SAY 'ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ'
   ColStd()
   @  3, 0 SAY '°°°°°°°°°°°Rok ewidencyjny:' + param_rok + '°°°°°°°°°°°-Przedúzako&_n.czeniemúpracyúzúúprogramem'
   @  4, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° u&_z.ytkownikúpowinienúbezwzgl&_e.dnieúu&_z.y&_c'
   @  5, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° opcjiú"Zako&_n.czenieúpracyúprogramu".úú'
   @  6, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°-Przerwanieúpracyúprogramuúbezúúu&_z.ycia'
   @  7, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° opcjiúú"Zako&_n.czenieúúpracyúúprogramu"'
   @  8, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° (zúpowodu:úwy&_l.&_a.czeniaúkomputera,zani-'
   @  9, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° kuúnapi&_e.ciaúzasilaj&_a.cego,úawariiúkom-'
   @ 10, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° puteraúitp.)úmo&_z.eúspowodowa&_c.úkoniecz-'
   @ 11, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° no&_s.&_c.úodtworzeniaúdanychúúzúúdyskietek'
   @ 12, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° iúúichúúúewentualnegoúúúuzupe&_l.nienia.'
   @ 13, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° U&_z.ytkownikúpowinienúkopiowa&_c.údaneúúna'
   @ 14, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° dyskietkiú(przyúu&_z.yciuúopcjiúú"Kopio-'
   @ 15, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° wanieúdanych")útakúcz&_e.sto,abyúwúprzy-'
   @ 16, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° padkuúawariiúuzupe&_l.nienieúúutraconych'
   @ 17, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° informacjiúnieúby&_l.oúuci&_a.&_z.liwe.úúúúúúú'
   @ 18, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°-Oprogramowanieúposiadaúsystemúúwykry-'
   @ 19, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° waniaúingerencjiúúos&_o.búúniepowo&_l.anych'
   @ 20, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° wúwewn&_e.trzneústruktury.úúWúúprzypadku'
   @ 21, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° stwierdzeniaúfaktuúingerencjiúu&_z.ytko-'
   @ 22, 0 SAY '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°° wnikútraciúúuprawnieniaúúgwarancyjne.'
   @ 23, 0 SAY '                                                                                '
   @ 24, 0 SAY '                                                                                '
   ColSta()
   @  1, 0 SAY status()
   ColStd()

   // Zmienna 'scr' zdefiniowana w menu_()
   SAVE SCREEN TO scr

   // Zmienna 'o' zdefiniowana w menu_()
   o[ 1 ] := ' F - Obs&_l.uga firmy...                  '
   o[ 2 ] := ' P - Parametry programu...             '
   o[ 3 ] := ' D - Porz&_a.dkowanie zbior&_o.w...          '
   o[ 4 ] := ' I - Informacja o programie            '
   o[ 5 ] := ' K - Kopiowanie danych                 '
   o[ 6 ] := ' O - Odtwarzanie danych                '
   o[ 7 ] := ' 1 - Edytor tekst&_o.w (call ZADANIE1.BAT)'
   o[ 8 ] := ' 2 - Program zewn&_e.t.(call ZADANIE2.BAT)'
   o[ 9 ] := ' # - Instalacja nowej wersji AMi-BOOK  '
   o[ 10 ] := ' Z - Zako&_n.czenie pracy programu        '

   RETURN '4,1'

*******************************************
// Obsluga firmy
FUNCTION _a()

   MEMVAR aDomProfilDrukarki

   // Kody sterujace drukarki
   IF aDomProfilDrukarki[ 'sterownik' ] == 'IBM'

      kod_10cp := "chr(18)"
      //kod_10cp="''"
      kod_12cp := "chr(27)+chr(77)"
      //kod_17cp="chr(15)"
      kod_17cp := "chr(18)+chr(15)"
      kod_8wc  := "chr(27)+chr(51)+chr(24)"
      kod_6wc  := "chr(27)+chr(51)+chr(36)"
      kod_res  := "chr(27)+chr(64)"
      kod_lf   := "chr(10)+chr(13)"
      kod_ff   := "chr(12)"
      kod_bold := "chr(27)+chr(71)"
      kod_rbol := "chr(27)+chr(72)"
      kod_mikr := "chr(27)+chr(74)"

   ELSEIF aDomProfilDrukarki[ 'sterownik' ] == 'EPS' ;
      .OR. aDomProfilDrukarki[ 'sterownik' ] == 'WIN' ;
      .OR.aDomProfilDrukarki[ 'sterownik' ] == 'WN2'

      kod_10cp := "chr(18)"
      //kod_10cp="''"
      kod_12cp := "chr(27)+chr(77)"
      //kod_17cp="chr(15)"
      kod_17cp := "chr(27)+'P'+chr(15)"
      kod_8wc  := "chr(27)+chr(48)"
      kod_6wc  := "chr(27)+chr(50)"
      kod_res  := "chr(27)+chr(64)"
      kod_lf   := "chr(10)+chr(13)"
   //   IF param_dru == 'WIN'
   //      kod_lf = "chr(13)+" + kod_lf
   //   ENDIF
      kod_ff   := "chr(12)"
      kod_bold := "chr(27)+chr(71)"
      kod_rbol := "chr(27)+chr(72)"
      kod_mikr := "chr(27)+chr(74)"

   ELSEIF aDomProfilDrukarki['sterownik'] == 'PCL'

      kod_10cp := "chr(27)+chr(38)+chr(107)+chr(48)+chr(83)"
      kod_12cp := "chr(27)+chr(38)+chr(107)+chr(52)+chr(83)"
      kod_17cp := "chr(27)+chr(38)+chr(107)+chr(50)+chr(83)"
      kod_8wc  := "chr(27)+chr(38)+chr(108)+chr(56)+chr(68)"
      kod_6wc  := "chr(27)+chr(38)+chr(108)+chr(54)+chr(68)"
      kod_res  := "chr(27)+chr(69)"
      kod_lf   := "chr(27)+chr(38)+chr(107)+chr(49)+chr(71)+chr(13)"
      kod_ff   := "chr(27)+chr(38)+chr(108)+chr(48)+chr(72)"
      kod_bold := "''"
      kod_rbol := "''"
      kod_mikr := "''"

   ENDIF

   // Wybor firmy
   IF LastKey()#K_ESC
      // Wszycy maja dostep do wielofirm
      //IF wersja1
         //firma2()
      //ELSE
         firma1()
      //ENDIF
      IF LastKey() == K_ESC
         @ 0, 0 CLEAR TO 0, 40
         RETURN ''
      ENDIF
   ELSE
      @ 0, 0 CLEAR TO 0, 40
   ENDIF

   @ 3, 42 CLEAR TO 22, 79

   // Wyswietl podstawowe info o firmie w prawym gornym panelu
   infofirma()

   // Zmienna 'scr' zadeklarowana w funkcji menu_()
   SAVE SCREEN TO scr

   IF zRYCZALT == 'T'
      o[ 1 ] := ' P - Prowadzenie ewidencji i rejestr&_o.w '
   ELSE
      o[ 1 ] := ' P - Prowadzenie ksi&_e.gi i rejestr&_o.w... '
   ENDIF

   o[ 2 ]  := ' Z - Zestawienie sum miesi&_e.cznych      '
   o[ 3 ]  := ' O - Obliczenie dochodu na koniec roku '
   o[ 4 ]  := ' N - Nale&_z.no&_s.ci i zobowi&_a.zania...      '
   o[ 5 ]  := ' C - P&_l.ace...                          '
   o[ 6 ]  := ' W - Wyposa&_z.enie                       '
   o[ 7 ]  := ' S - &__S.rodki trwa&_l.e...                  '
   o[ 8 ]  := ' K - Katalogi firmy...                 '
   o[ 9 ]  := ' E - Eksport do Programu P&_l.atnika...   '
   o[ 10 ] := ' F - Parametry firmy...                '
   o[ 11 ] := ' D - eDeklaracje                       '

   RETURN '6,0'
*******************************************
// Prowadzenie ewidencji
FUNCTION _aa()

   ewid()
   RETURN ''

*******************************************
// Zestawienie sum miesiecznych
FUNCTION _ab()

   LOCAL nRes

   IF zRYCZALT == 'T'
      suma_mcr()
   ELSE
      IF ( nRes := GraficznyCzyTekst() ) > 0
         suma_mc( nRes == 1 )
      ENDIF
   ENDIF

   RETURN ''

*******************************************
// Obliczanie dochodu na koniec roku
FUNCTION _ac()

   IF zRYCZALT == 'T'
      kom( 5, '+w',' UWAGA !!! Funkcja nie jest aktywna dla p&_l.atnik&_o.w podatku zrycza&_l.towanego ' )
   ELSE
      roczne()
   ENDIF

   RETURN ''

*******************************************
// Naleznosci i zobowiazania
FUNCTION _ad()

   o[ 1 ]  := ' A - Aktualizacja zap&_l.at             '
   o[ 2 ]  := ' S - Stan zap&_l.at                     '
   o[ 3 ]  := ' F - Faktury z pozycjami wg kontrah. '
   o[ 4 ]  := ' O - Obroty z kontrahentem (dla nazw)'
   o[ 5 ]  := ' N - Obroty z kontrahentem (dla NIP) '
   o[ 6 ]  := ' D - Raport do korekt (doch)         '
   o[ 7 ]  := ' V - Raport do korekt (VAT)          '
   o[ 8 ]  := ' P - Przelewy standardowe            '
   o[ 9 ]  := ' T - Przelewy podatkowe              '
   o[ 10 ] := ' U - Parametry i ustawienia          '

   RETURN '11,1'

*******************************************
// Aktualizacja zaplat
FUNCTION _ada()

   rozrakt()

   RETURN ''

*******************************************
// Stan zaplat
FUNCTION _adb()

   kulmar2()

   RETURN ''

*******************************************
// Faktury z pozycjami wg kontrah.
FUNCTION _adc()

   spigiel()

   RETURN ''

*******************************************
// Obroty z kontrahentem (dla nazw)
FUNCTION _add()

   SWITCH GraficznyCzyTekst()
   CASE 1
      Obroty( 2, .F. )
      EXIT
   CASE 2
      Obroty( 2, .T. )
      //boramex()
      EXIT
   ENDSWITCH

   RETURN ''

*******************************************
// Obroty z kontrahentem (dla NIP)
FUNCTION _ade()

   SWITCH GraficznyCzyTekst()
   CASE 1
      Obroty( 1, .F. )
      EXIT
   CASE 2
      Obroty( 1, .T. )
      //obrotnip()
      EXIT
   ENDSWITCH

   RETURN ''

*******************************************
// Raport do korekt (doch)
FUNCTION _adf()

   rozrtab()

   RETURN ''

*******************************************
// Raport do korekt (VAT)
FUNCTION _adg()

   rozrvat()

   RETURN ''

*******************************************
// Przelewy standardowe
FUNCTION _adh()

   przelewy()

   RETURN ''

*******************************************
// Przelewy podatkowe
FUNCTION _adi()

   przelpod()

   RETURN ''

*******************************************
// Parametry i ustawienia
FUNCTION _adj()

   rozrustf()

   RETURN ''

*******************************************
// Place
FUNCTION _ae()

   o[ 1 ] := ' P - Pracownicy                     '
   o[ 2 ] := ' E - Etaty                          '
   o[ 3 ] := ' 4 - Etaty-dodatkowe dane do PIT-4R '
   o[ 4 ] := ' I - Inne wyp&_l.aty                   '
   o[ 5 ] := ' O - Og&_o.lne parametry p&_l.acowe i ZUS '
   o[ 6 ] := ' Z - Parametry ZUS dla firmy        '
   o[ 7 ] := ' K - Generowanie pliku PPK          '
   o[ 8 ] := ' L - Parametry PPK                  '

   RETURN '12,2'

*******************************************
// Pracownicy
FUNCTION _aea()

   pracow()

   RETURN ''

*******************************************
// Etaty
FUNCTION _aeb()

   etaty( 'C' )

   RETURN ''

*******************************************
// Etaty-dodatkowe dane do PIT-4R
FUNCTION _aec()

   etatytab( 'C' )

   RETURN ''

*******************************************
// Inne wyplaty
FUNCTION _aed()

   o[ 1 ] := ' E - Ewidencja innych wyp&_l.at   '
   o[ 2 ] := ' Z - Zestawienie innych wyp&_l.at '
   o[ 3 ] := ' U - Umowy            - wzorce '
   o[ 4 ] := ' R - Rachunek         - wzorce '
   o[ 5 ] := ' W - Wyp&_l.ata          - wzorce '

   RETURN '16,5'

*******************************************
// Ewidencja innych wyplat
FUNCTION _aeda()

   umowy()

   RETURN ''

*******************************************
// Zestawienie innych wyplat
FUNCTION _aedb()

   umowysum()

   RETURN ''

*******************************************
// Umowy - wzorce
// TODO: Polaczyc 3 ponizsze funkcje w jedna
FUNCTION _aedc()

   LOCAL _ilm
   LOCAL a, ZZ

   _ilm := ADir( 'umow*.txt' )
   a := Array( _ilm )
   ADir( 'umow*.txt', a )
   ASort( a )
   ZZ := 0
   IF _ilm > 21
      _ilm := 21
   ENDIF
   @ 21 - _ilm, 20 TO 22, 33
   ZZ := AChoice( 21 - ( _ilm - 1 ), 21, 21, 32, a, .T., .T., ZZ )
   IF ZZ <> 0
      Umowa( AllTrim( a[ ZZ ] ) )
   ENDIF

   RETURN ''

*******************************************
// Rachunek - wzorce
FUNCTION _aedd()

   LOCAL _ilm
   LOCAL a, ZZ

   _ilm := ADir( 'rach*.txt' )
   a := Array( _ilm )
   ADir( 'rach*.txt', a )
   ASort( a )
   ZZ := 0
   IF _ilm > 21
      _ilm := 21
   ENDIF
   @ 21 - _ilm, 20 TO 22, 33
   ZZ := AChoice( 21 - ( _ilm - 1 ), 21, 21, 32, a, .T., .T., ZZ )
   IF ZZ <> 0
      Umowa( AllTrim( a[ ZZ ] ) )
   ENDIF

   RETURN ''

*******************************************
// Wyplata - wzorce
FUNCTION _aede()

   LOCAL _ilm
   LOCAL a, ZZ

   _ilm := ADir( 'wypl*.txt' )
   a := Array( _ilm )
   ADir( 'wypl*.txt', a )
   ASort( a )
   ZZ := 0
   IF _ilm>21
      _ilm=21
   ENDIF
   @ 21 - _ilm, 20 TO 22, 33
   ZZ := AChoice( 21 - ( _ilm - 1 ), 21, 21, 32, a, .T., .T., ZZ )
   IF ZZ <> 0
      Umowa( AllTrim( a[ZZ] ) )
   ENDIF

   RETURN ''

*******************************************
// Ogolne parametry placowe i ZUS
FUNCTION _aee()

   Param_P()

   RETURN ''

*******************************************
// Parametry ZUS dla firmy
FUNCTION _aef()

   Param_PF()

   RETURN ''

*******************************************
// Generowanie plik¢w dla PPK
FUNCTION _aeg()

   o[ 1 ] := ' U - Zgˆoszenie uczestnik¢w PPK '
   o[ 2 ] := ' D - Deklaracje uczetnik¢w PPK  '
   o[ 3 ] := ' Z - Zwolnienie pracownika      '

   RETURN '18,4'

*******************************************
FUNCTION _aega()

   PPK_Zglos()

   RETURN ''

*******************************************
FUNCTION _aegb()

   PPK_Deklaracja()

   RETURN ''

*******************************************
FUNCTION _aegc()

   PPK_Zwolnienie()

   RETURN ''

*******************************************
// Parametry PPK
FUNCTION _aeh()

   Param_PPK()

   RETURN ''

*******************************************
// Wyposazenie
FUNCTION _af()

   EwidWyp()

   RETURN ''

*******************************************
// Srodki trwale...
FUNCTION _ag()

   o[ 1 ] := ' K - Kartoteki          '
   o[ 2 ] := ' T - Tabele amortyzacji '
   o[ 3 ] := ' V - Korekty VAT        '
   RETURN '14,7'

*******************************************
// Srodki trwale...Kartoteki
FUNCTION _aga()

   KartST()
   RETURN ''

*******************************************
// Srodki trwale...Tabele amortyzacji
FUNCTION _agb()

   TabAm( 'C' )

   RETURN ''

*******************************************
// Srodki trwale...Korekty VAT
FUNCTION _agc()

   KorVatST()
   RETURN ''

*******************************************
// Katalogi firmy...
FUNCTION _ah()

   o[ 1 ] := ' R - Rejestry VAT...       '
   o[ 2 ] := ' K - Kontrahenci           '
   o[ 3 ] := ' Z - Zdarzenia gospodarcze '
   o[ 4 ] := ' P - Pojazdy w&_l.a&_s.cicieli   '
   o[ 5 ] := ' F - Kasy fiskalne         '

   RETURN '15,6'

*******************************************
// Katalogi firmy...Rejestry VAT...
function _aha()

   o[ 1 ] := ' Z - Rejestry zakup&_o.w   '
   o[ 2 ] := ' S - Rejestry sprzeda&_z.y '

   RETURN '17,8'

*******************************************
// Katalogi firmy...Rejestry VAT...Rejestry zakupow
FUNCTION _ahaa()

   Kat_Rej( 'KAT_ZAK' )

   RETURN ''

*******************************************
// Katalogi firmy...Rejestry VAT...Rejestry sprzedazy
FUNCTION _ahab()

   Kat_Rej( 'KAT_SPR' )

   RETURN ''

*******************************************
// Katalogi firmy...Kontrahenci
FUNCTION _ahb()

   Kontr()

   RETURN ''

*******************************************
// Katalogi firmy...Zdarzenia gospodarcze
FUNCTION _ahc()

   Tresc()

   RETURN ''

*******************************************
// Katalogi firmy...Pojazdy wlascicieli
FUNCTION _ahd()

   Samochod()

   RETURN ''

*******************************************
// Kasy fiskalne...
FUNCTION _ahe()

   KasyFiskalne()

   RETURN ''

*******************************************
// Eksport do Programu Platnika...
FUNCTION _ai()

   o[ 1 ] := ' 1 - ZUA  zg&_l.oszenie do ubezpiecze&_n.     '
   o[ 2 ] := ' 2 - ZCZA zg&_l.oszenie cz&_l.onk&_o.w rodziny   '
   o[ 3 ] := ' 3 - ZCNA zg&_l.oszenie cz&_l.onk&_o.w rodziny   '
   o[ 4 ] := ' 4 - ZPA  zg&_l.oszenie p&_l.atnika (spolki)  '
   o[ 5 ] := ' 5 - ZFA  zg&_l.oszenie p&_l.atnika (os.fiz.) '

   RETURN '16,0'

*******************************************
// Eksport do Programu Platnika...ZUA
FUNCTION _aia()

   o[ 1 ] := ' 1 - Pracownicy  '
   o[ 2 ] := ' 2 - W&_l.a&_s.ciciele '

   RETURN '18,11'

*******************************************
// Eksport do Programu Platnika...ZUA...Pracownicy
FUNCTION _aiaa()

   ZusZua( 1 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZUA...Wlasciciele
FUNCTION _aiab()

   ZusZua( 2 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZCZA
FUNCTION _aib()

   o[ 1 ] := ' 1 - Pracownicy  '
   o[ 2 ] := ' 2 - W&_l.a&_s.ciciele '

   RETURN '19,11'

*******************************************
// Eksport do Programu Platnika...ZCZA...Pracownicy
FUNCTION _aiba()

   ZusZcza( 1 )

   RETURN ''
*******************************************
// Eksport do Programu Platnika...ZCZA...Wlasciciele
FUNCTION _aibb()

   ZusZcza( 2 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZCNA
FUNCTION _aic()

   o[ 1 ] := ' 1 - Pracownicy  '
   o[ 2 ] := ' 2 - W&_l.a&_s.ciciele '

   RETURN '19,11'

*******************************************
// Eksport do Programu Platnika...ZCNA...Pracownicy
FUNCTION _aica()

   ZusZcna( 1 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZCNA...Wlasciciele
FUNCTION _aicb()

   ZusZcna( 2 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZPA spolka
FUNCTION _aid()

   ZusZpa()

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZPA os. fiz.
FUNCTION _aie()

   o[ 1 ] := ' 1 - Firma jednoosobowa '
   o[ 2 ] := ' 2 - W&_l.a&_s.ciciele        '

   RETURN '18,11'

*******************************************
// Eksport do Programu Platnika...ZPA os. fiz...Firma jednoosobowa
FUNCTION _aiea()

   ZusZfa( 1 )

   RETURN ''

*******************************************
// Eksport do Programu Platnika...ZPA os. fiz...Wlasciciele
FUNCTION _aieb()

   ZusZfa( 2 )

   RETURN ''

*******************************************
// Parametry firmy...
FUNCTION _aj()

   o[ 1 ] := ' W - Informacje o w&_l.a&_s.cicielach firmy  '
   o[ 2 ] := ' Z - Inne zr&_o.d&_l.a przychod&_o.w            '
   o[ 3 ] := ' F - Informacje o firmie               '
   o[ 4 ] := ' P - Stawki na ubezpieczenie wypadkowe '

   RETURN '17,1'

*******************************************
// Parametry firmy...Informacje o wlascicielach firmy
FUNCTION _aja()

   Spolka()

   RETURN ''

*******************************************
// Parametry firmy...Inne zrodla przychodow
FUNCTION _ajb()

   Inne()

   RETURN ''

*******************************************
// Parametry firmy...
FUNCTION _ajc()

   Param_F()

   RETURN ''

*******************************************
// Parametry firmy...
FUNCTION _ajd()

   Param_PF()

   RETURN ''

*******************************************
// eDeklaracje
FUNCTION _ak()

   PokazEDeklaracje()

   RETURN ''

*******************************************
// Parametry programu...
FUNCTION _b()

   o[ 1 ]  := ' U - Urz&_e.dy Skarbowe                 '
   o[ 2 ]  := ' O - Organy Rejestrowe               '
   o[ 3 ]  := ' T - Tabela podatku dochodowego      '
   o[ 4 ]  := ' S - Stawki podatku zrycza&_l.towanego  '
   o[ 5 ]  := ' V - Tabela stawek VAT               '
   o[ 6 ]  := ' K - Stawki za 1km przebiegu pojazdu '
   o[ 7 ]  := ' N - Korekty niezap&_l.aconych faktur   '
   o[ 8 ]  := ' Z - Parametry p&_l.acowe i ZUS         '
   o[ 9 ]  := ' I - Inne parametry                  '
   o[ 10 ] := ' E - Parametry eDeklaracji           '
   o[ 11 ] := ' P - Polskie znaki...                '
   o[ 13 ] := ' D - Parametry drukarki              '
   o[ 14 ] := ' R - Parametry ksi©gowania           '
   o[ 15 ] := ' L - Parametry usˆug on-line         '

   DO CASE
   CASE KINESKOP == 'M'
      o[ 12 ] := ' M - Kolory: czarno-biale            '
   CASE KINESKOP == 'K'
      o[ 12 ] := ' M - Kolory: standardowe kolory      '
   CASE KINESKOP == 'U'
      o[ 12 ] := ' M - Kolory: uzytkownika             '
   OTHERWISE
      o[ 12 ] := ' M - Kolory: standardowe kolory      '
   ENDCASE

   RETURN '6,2'
*******************************************
// Urzedy Skarbowe
FUNCTION _ba()

   Urzedy()

   RETURN ''

*******************************************
// Organy Rejestrowe
FUNCTION _bb()

   o[ 1 ] := ' O - Nazwy Organ&_o.w Rejestrowych '
   o[ 2 ] := ' R - Nazwy Rejestr&_o.w            '

   RETURN '9,4'

*******************************************
// Nazwy Organow Rejestrowych
FUNCTION _bba()

   Organy()

   RETURN ''

*******************************************
// Nazwy Rejestrow
FUNCTION _bbb()

   Rejestry()

   RETURN ''

*******************************************
// Tabela podatku dochodowego
FUNCTION _bc()

   o[ 1 ] := ' T - Tabela pdatku dochodowego '
   o[ 2 ] := ' U - Ulga dla klasy ˜redniej   '

   RETURN '10,4'

*******************************************
// Tabela podatku dochodowego
FUNCTION _bca()

   Tab_Doch()

   RETURN ''

*******************************************
// Tabela ulgi dla klasy sredniej
FUNCTION _bcb()

   Tab_DochUKS()

   RETURN ''

********************************************
// Stawki podatku zryczaltowanego
FUNCTION _bd()

   Tab_Rycz()

   RETURN ''

********************************************
// Tabela stawek VAT
FUNCTION _be()

   o[ 1 ] := ' K - Krajowe stawki VAT         '
   o[ 2 ] := ' U - Stawki VAT w krajach UE    '

   RETURN '12,4'

// Tabela stawek VAT krajowych
FUNCTION _bea()

   Tab_Vat()

   RETURN ''

*******************************************
// Tabela stawek VAT UE
FUNCTION _beb()

   Tab_VatUE()

   RETURN ''

*******************************************
// Stawki za 1km przebiegu pojazdu
FUNCTION _bf()

   Tab_Poj()

   RETURN ''

*******************************************
// Korekty niezaplaconych faktur
FUNCTION _bg()

   Param_Ro()

   RETURN ''

*******************************************
// Parametry placowe i ZUS
FUNCTION _bh()

   Param_P()

   RETURN ''

*******************************************
// Inne parametry
FUNCTION _bi()

   Param()

   RETURN ''
*******************************************
// Parametry edeklaracji
FUNCTION _bj()

   edekKonfig()

   RETURN ''

*******************************************
// Polskie znaki
FUNCTION _bk()

   DO CASE
   CASE POLSKA_D == 'M'
      POLEXT := 'MAZ'
   CASE POLSKA_D == 'L'
      POLEXT := 'LAT'
   CASE POLSKA_D == 'I'
      POLEXT := 'ISO'
   OTHERWISE
      POLEXT := 'NON'
   ENDCASE

   o[ 1 ] := ' E - Ekran      ' + iif( POLSKA_1, 'CP852     ', 'Wy&_l.&_a.czone ' )
   o[ 2 ] := ' D - Drukarka   ' + iif( POLSKA_3 == '0', 'Wy&_l.&_a.czone ', ;
      iif( POLSKA_3 == '1', 'EPROM-' + POLEXT + ' ', 'LOAD -' + POLEXT + ' ' ) )

   RETURN '18,8'

*******************************************
// Polskie znaki - ekran
FUNCTION _bka()

   Polska1()

   RETURN ''

*******************************************
// Polskie znaki - drukarka
FUNCTION _bkb()

   Polska3()

   RETURN ''

*******************************************
// Kolory
FUNCTION _bl()

   Tab_Kolo()

   RETURN ''

*******************************************
// Parametry wydruku
FUNCTION _bm()

   o[ 1 ] := ' P - Profile drukarek (druk tekstowy) '
   o[ 2 ] := ' R - Parametry druku graficznego      '

   RETURN '19,2'

*******************************************
// Profile drukarek (druk tekstowy)
FUNCTION _bma()

   menuKonfigDruk2()

   RETURN ''

*******************************************
// Parametry druku graficznego
FUNCTION _bmb()

   paramDrukGraf()

   RETURN ''

*******************************************
// Parametry ksiegowania
FUNCTION _bn()

   menuKonfigKsiega()

   RETURN ''

*******************************************
// Parametry uslug on-line
FUNCTION _bo()

   LOCAL nRes

   nRes := amiKlientKonfig( @olparam_sa, @olparam_ra, @olparam_rd )

   CLEAR TYPEAHEAD

   IF nRes == 0
      SAVE TO olparam ALL LIKE olparam_*
   ENDIF

   RETURN ''

*******************************************
// Porzadkowanie zbiorow
FUNCTION _c()

   o[ 1 ] := ' I - Indeksowanie zbior&_o.w   '
   o[ 2 ] := ' K - Kasowanie obrot&_o.w roku '
   o[ 3 ] := ' @ - NOWY ROK '+str(val(param_rok)+1,4)+'          '

   RETURN '8,6'

*******************************************
// Indeksowanie zbiorow
FUNCTION _ca()

   LOCAL s_d

   SAVE SCREEN TO s_d
   ColInb()
   @ 24, 0
   center( 24, 'Prosz&_e. czeka&_c....' )

   Indeks()

   SET CURSOR OFF

   //Numeruj()
   Ksiega_Przenumeruj()

   REST SCREEN FROM s_d

   RETURN ''

*******************************************
// Kasowanie obrotow roku
FUNCTION _cb()

   Kasow()

   RETURN ''

*******************************************
// Nowy rok
FUNCTION _cc()

   ZamRok()

   RETURN ''

*******************************************
// Informacja o programie
FUNCTION _d()

   LOCAL PAM, AA
   LOCAL nKlaw

   PAM := Str( nr_uzytk, 5 )
   AA := ColInf()
   @  9, 4 CLEAR TO 21, 37
   @  9, 4 TO 21,37
   @ 10, 5 SAY ' System : AMi-BOOK              '
   @ 11, 5 SAY ' Wersja : ' + PadL( wersprog, 5 ) + '                 '
   @ 12, 5 SAY ' Nr licencji : ' + PAM + '          '
   @ 13, 5 SAY ' NIP u¾ytkownika : ' + PadR( trimnip( nip_uzytk ), 13 )
   @ 14, 5 SAY ' Autor  : 1991-2014 AMi-SYS s.c.'
   @ 15, 5 SAY '          2015-2022 GM Systems  '
   @ 16, 5 SAY '          ul. rtm.W.Pileckiego 9'
   @ 17, 5 SAY '          58-260 Bielawa        '
   @ 18, 5 SAY '  e-mail: info@gmsystems.pl     '
   @ 19, 5 SAY '  System powsta&_l. i jest ci&_a.gle  '
   @ 20, 5 SAY '   aktualizowany od 1991 roku   '

   ColStd()
   @ 23, 0 SAY PadC( 'U¾ytkownik: ' + AllTrim( kod_uzytk ), 80 )
   ColInf()
   @ 24, 0 SAY PadC( ' I - instalacja licencji |  dowolny klawisz - zamknij okno ', 80 )
   //kom( 10, '*+w',' Prosimy o uwagi odno&_s.nie pracy i rozbudowy systemu ' )

   nKlaw := Inkey( 0, INKEY_LDOWN + INKEY_RDOWN + INKEY_KEYBOARD )

   IF nKlaw == Asc( 'I' ) .OR. nKlaw == Asc( 'i' )
      nKlaw := amiInstalujLicencje()
      IF nKlaw == 0
         Komun( 'Licencja b©dzie aktywna po ponownym uruchomieniu programu' )
      ENDIF
   ENDIF

   SetColor( AA )

   RETURN ''

*******************************************
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±± MENU_    ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±Generator menu.                                                           ±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
PROCEDURE menu_()

   LOCAL _okno, _opcja, _y1, _x1, _y2, _x2, _i

   PRIVATE scr
   PRIVATE o[ 20 ]

   _okno := '_'
   _opcja := 1

   DO WHILE .T.
      SAVE SCREEN TO scr

      STORE '' TO o[ 1 ], o[ 2 ], o[ 3 ], o[ 4 ], o[ 5 ], o[ 6 ], o[ 7 ], o[ 8 ], ;
         o[ 9 ], o[ 10 ], o[ 11 ], o[ 12 ], o[ 13 ], o[ 14 ], o[ 15 ], o[ 16 ], ;
         o[ 17 ], o[ 18 ]

      _i := _okno + '()'
      _i := &_i

      RESTORE SCREEN FROM scr
      ColPro()

      IF o[ 1 ] == ''
         SET DEVICE TO SCREEN
         close_()
         keyboard( Chr( 27 ) )
         Inkey()
      ELSE
         _y1 := Val( Left( _i, At( ',', _i ) - 1 ) )
         _x1 := Val( SubStr( _i, At( ',', _i ) + 1 ) )
         _i := 1
         DO WHILE o[ _i ]#''
            @ _y1 + _i, _x1 + 1 PROMPT o[ _i ]
            _i := _i + 1
         ENDDO
         _y2 := _y1 + _i
         _x2 := _x1 + Len( o[1] ) + 1
         @ _y1, _x1 TO _y2, _x2
         *---------------
         // Ustawienie menu po powrocie z zewnetrznej operacji
         IF File( 'arch.mem' )
            _opcja := _y2 - _y1 - 6
            KEYBOARD Chr( 13 )
         ENDIF
         IF File( 'odtw.mem' )
            _opcja := _y2 - _y1 - 5
            KEYBOARD Chr( 13 )
         ENDIF
         IF File( 'zadanie1.mem' )
            _opcja := _y2 - _y1 - 4
            KEYBOARD Chr( 13 )
         ENDIF
         IF File( 'zadanie2.mem' )
            _opcja := _y2 - _y1 - 3
            KEYBOARD Chr( 13 )
         ENDIF
         IF File( 'instart.bat' )
            _opcja := _y2 - _y1 - 2
            KEYBOARD Chr(13)
         ENDIF
         *---------------
      ENDIF

      _opcja := menu( _opcja )

      ColStd()

      IF LastKey() == K_ESC .OR. o[ 1 ] == ''
         IF _okno == '_'
            _opcja := _y2 - _y1 - 1
         ELSE
            _opcja := Asc( Right( _okno, 1 ) ) - 96
            _okno := Left( _okno, Len( _okno ) - 1 )
            IF o[ 1 ]#''
               @ _y1, _x1, _y2, _x2 box('°°°°°°°°°')
            ENDIF
         ENDIF
      ELSE
         DO CASE
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 6
            SAVE SCREEN TO scr
            Arch()
            RESTORE SCREEN FROM scr
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 5
            SAVE SCREEN TO scr
            Odtw()
            RESTORE SCREEN FROM scr
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 4
            SAVE SCREEN TO scr
            Zadanie1()
            RESTORE SCREEN FROM scr
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 3
            SAVE SCREEN TO scr
            Zadanie2()
            RESTORE SCREEN FROM scr
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 2
            SAVE SCREEN TO scr
            Instaluj()
            RESTORE SCREEN FROM scr
         CASE _okno == '_' .AND. _opcja == _y2 - _y1 - 1
            IF param_dzw == 'T'
               Tone( 600, 1 )
               Tone( 580, 1 )
               Tone( 560, 1 )
               Tone( 540, 1 )
               Tone( 520, 1 )
               Tone( 500, 1 )
               Tone( 480, 1 )
               Tone( 460, 1 )
               Tone( 440, 1 )
               Tone( 420, 1 )
               Tone( 400, 1 )
            ENDIF
            hbfr_FreeLibrary()
            amiDllZakoncz()
            WinPrintDone()
            CLEAR
            RETURN
         OTHERWISE
            _okno := _okno + Chr( _opcja + 96 )
            _opcja := 1
         ENDCASE
      ENDIF
   ENDDO

   RETURN

*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± K O N I E C ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
