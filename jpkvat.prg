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

#include "inkey.ch"
#include "box.ch"
#include "hbcompat.ch"

PROCEDURE JPK_VAT_Rob()
   LOCAL nFirma, nMiesiacPocz, nMiesiacKon
   LOCAL aKw
   LOCAL aDane
   LOCAL cDaneXML
   LOCAL cPlik
   LOCAL nFile
   LOCAL nKorekta
   LOCAL cAdresEmail
   LOCAL nWersja

   nFirma := Val( ident_fir )
   nMiesiacPocz := Val( miesiac )
   nMiesiacKon := NIL

/*   IF zVATFORDR == '7 '
      nMiesiacPocz := Val( miesiac )
      nMiesiacKon := NIL
   ELSE
      aKw := ObliczKwartal( Val( miesiac ) )
      nMiesiacPocz := aKw[ 'kwapocz' ]
      nMiesiacKon := aKw[ 'kwakon' ]
   ENDIF */
   aDane := JPK_VAT_Dane( nFirma, nMiesiacPocz, nMiesiacKon, .F. )
   IF aDane[ 'OK' ]
      IF hb_HHasKey( aDane, 'SprzedazCtrl' ) .OR. hb_HHasKey( aDane, 'ZakupCtrl' )
   //      nKorekta := edekCzyKorekta()
         nWersja := MenuEx( 17, 2, { "JPK_VAT wersja 3 (od 2018)", "JPK_VAT wersja 2 (do 2017)" }, 1, .T. )
         IF nWersja > 0
            DO CASE
            CASE nWersja == 1
               nKorekta := JPK_VAT_PobierzNrWer( 17, 2, JPK_VAT_WczytajWERJPKVAT(), @cAdresEmail )
            CASE nWersja == 2
               nKorekta := edekCzyKorekta()
            ENDCASE
            IF nKorekta >= 0
               DO CASE
               CASE nWersja == 1
                  aDane[ 'CelZlozenia' ] := AllTrim( Str( nKorekta ) )
                  aDane[ 'Email' ] := AllTrim( cAdresEmail )
                  cDaneXML := jpk_vat3( aDane )
                  IF edekZapiszXML( cDaneXML, normalizujNazwe( 'JPK_VAT_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKVAT-3', nKorekta == 2, nMiesiacPocz )
                     JPK_VAT_ZapiszWERJPKVAT( nKorekta + 1 )
                  ENDIF
               CASE nWersja == 2
                  aDane[ 'CelZlozenia' ] := iif( nKorekta == 2, '2', '1' )
                  cDaneXML := jpk_vat( aDane )
                  edekZapiszXML( cDaneXML, normalizujNazwe( 'JPK_VAT_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ), wys_edeklaracja, 'JPKVAT-2', nKorekta == 2, nMiesiacPocz )
               ENDCASE
      /*         IF ( cPlik := win_GetSaveFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} }, , , ;
                  normalizujNazwe( 'JPK_VAT_' + AllTrim( aDane[ 'NazwaSkr' ] ) + '_' + param_rok + '_' + CMonth( aDane[ 'DataOd' ] ) ) ) ) <> ''
                  nFile := FCreate(cPlik)
                  IF nFile != -1
                     FWrite(nFile, cDaneXML)
                     FClose(nFile)
                     komun('Utworzono plik JPK')
                     IF Upper( Chr( TNEsc(.T. ,'Czy weryfikowa† eDeklaracj©? (T/N)') ) ) == 'T'
                        edekWeryfikuj( cPlik, 'JPKVAT2', .T. )
                     ENDIF
                  ENDIF
               ENDIF
               */
            ENDIF
         ENDIF
      ELSE
         komun('Brak danych')
      ENDIF
   ELSE
      komun('Bˆ¥d podczas pobierania danych')
   ENDIF
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION JPK_NIPEU( cNrIdent, lUE, cKraj )
   LOCAL cRes := cNrIdent

   IF lUE .AND. ( Upper( SubStr( cNrIdent, 1, 2 ) ) <> Upper( AllTrim( cKraj ) ) )
      cRes :=  AllTrim( cKraj ) + AllTrim( cNrIdent )
   ENDIF
   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION JPK_VAT_Dane( nFirma, nMiesiacPocz, nMiesiacKon, lV7 )
   LOCAL aRes := hb_Hash( 'OK', .F. )
   LOCAL aPozycje := {}
   LOCAL aPoz
   LOCAL cKoniec
   LOCAL nTemp := 0
   LOCAL cFiltr
   LOCAL lSprzedaz := .F.
   LOCAL nStruSProb

   aRes[ 'sprzedaz' ] := {}
   aRes[ 'zakup' ] := {}

   IF ! JPK_Dane_Firmy( nFirma, @aRes )
      RETURN aRes
   ENDIF

   nStruSProb := aRes[ 'strusprob' ]

   IF .NOT. DostepPro('REJS')
      RETURN aRes
   ENDIF
   setind('REJS')

   IF .NOT. DostepPro('REJZ')
      close_()
      RETURN aRes
   ENDIF
   setind('REJZ')

/*   IF .NOT. DostepPro('KONTR')
      close_()
      RETURN aRes
   ENDIF
*/
/*
   IF .NOT. DostepPro('FIRMA')
      close_()
      RETURN aRes
   ENDIF
   firma->( dbGoto( nFirma ) )
   IF firma->( RecNo() ) <> nFirma
      close_()
      RETURN nRes
   ENDIF

   IF .NOT. DostepPro('URZEDY')
      close_()
      RETURN aRes
   ENDIF
*/
   aRes[ 'CelZlozenia' ] := '1'
   aRes[ 'DataWytworzeniaJPK' ] := datetime2strxml( hb_DateTime() )
   aRes[ 'DataOd' ] := hb_Date( Val( param_rok ), nMiesiacPocz, 1 )
/*
   aRes[ 'NIP' ] := firma->nip
   IF firma->skarb > 0
      urzedy->( dbGoto( firma->skarb ) )
      IF urzedy->( RecNo() ) == firma->skarb
         aRes['KodUrzedu'] := urzedy->kodurzedu
      ENDIF
   ENDIF

   aRes['PelnaNazwa'] := firma->nazwa
   aRes['Wojewodztwo'] := firma->param_woj
   aRes['Powiat'] := firma->param_pow
   aRes['Gmina'] := firma->gmina
   aRes['Ulica'] := firma->ulica
   aRes['NrDomu'] := firma->nr_domu
   aRes['NrLokalu'] := firma->nr_mieszk
   aRes['Miejscowosc'] := firma->miejsc
   aRes['KodPocztowy'] := firma->kod_p
   aRes['Poczta'] := firma->poczta
   aRes['NazwaSkr'] := firma->nazwa_skr
*/

   IF ( nMiesiacKon == NIL ) .OR. ( ( ValType( nMiesiacKon ) == 'N' ) .AND. ( nMiesiacKon == nMiesiacPocz ) )
      cKoniec := 'del#[+].OR.firma#"' + Str(nFirma,3,0) + '".OR.mc#"' + Str(nMiesiacPocz,2,0) + '"'
      aRes[ 'DataDo' ] := EoM( aRes[ 'DataOd' ] )
   ELSE
      cKoniec := 'del#[+].OR.firma#"' + Str(nFirma,3,0) + '".OR.mc<"' + Str(nMiesiacPocz,2,0) + '".OR.mc>"' + Str(nMiesiacKon,2,0) + '"'
      aRes[ 'DataDo' ] := EoM( hb_Date( Val( param_rok ), nMiesiacKon, 1 ) )
   ENDIF

   SELECT REJS
   rejs->( dbSeek( '+' + Str( nFirma, 3, 0 ) + Str( nMiesiacPocz, 2, 0 ) ) )
   DO WHILE .NOT. &cKoniec
      aPoz := hb_Hash()
      DO CASE
         CASE rejs->sek_cv7 == '  ' .OR. rejs->sek_cv7 == 'SP'
            ADodajNieZero( @aPoz, 'K_10', rejs->wartzw )
            IF rejs->export == 'T'
               ADodajNieZero( @aPoz, 'K_11', rejs->wart08 )
               IF rejs->ue == 'T'
                  ADodajNieZero( @aPoz, 'K_12', rejs->wart08 )
               ENDIF
            ENDIF
            IF ( rejs->ue <> 'T' ) .AND. ( rejs->export <> 'T' )
               ADodajNieZero( @aPoz, 'K_13', rejs->wart00 )
            ENDIF
            ADodajNieZero( @aPoz, 'K_15', rejs->wart02 + rejs->wart12, 'K_16' )
            ADodajNieZero( @aPoz, 'K_16', rejs->vat02 + rejs->vat12, 'K_15' )
            ADodajNieZero( @aPoz, 'K_17', rejs->wart07, 'K_18' )
            ADodajNieZero( @aPoz, 'K_18', rejs->vat07, 'K_17' )
            ADodajNieZero( @aPoz, 'K_19', rejs->wart22, 'K_20' )
            ADodajNieZero( @aPoz, 'K_20', rejs->vat22, 'K_19' )
            IF rejs->ue == 'T'
               ADodajNieZero( @aPoz, 'K_21', rejs->wart00 )
            ENDIF
            IF ( rejs->ue <> 'T' ) .AND. ( rejs->export == 'T' )
               ADodajNieZero( @aPoz, 'K_22', rejs->wart00 )
            ENDIF
         CASE ( rejs->sek_cv7 == 'PN' ) .OR. ( rejs->sek_cv7 == 'PU' )
            ADodajNieZero( @aPoz, 'K_31', rejs->wart02 + rejs->wartzw + rejs->wart08 + rejs->wart07 + rejs->wart22 + rejs->wart00 + rejs->wart12, 'K_32V' )
            ADodajNieZero( @aPoz, 'K_32V', rejs->vat02 + rejs->vat07 + rejs->vat22 + rejs->vat12, 'K_31' )
         CASE ( rejs->sek_cv7 == 'DP' )
            ADodajNieZero( @aPoz, 'K_36', rejs->kol36 )
            ADodajNieZero( @aPoz, 'K_37', rejs->kol37 )
            ADodajNieZero( @aPoz, 'K_38', rejs->kol38 )
            ADodajNieZero( @aPoz, 'K_39', rejs->kol39 )
            ADodajNieZero( @aPoz, 'K_360', rejs->kol360 )
      ENDCASE

      aPoz[ 'DowodSprzedazy' ] := NrDokUsunHasz( rejs->numer )
      aPoz[ 'DataWystawienia' ] := rejs->datatran //hb_Date( Val( param_rok ), Val( rejs->mc ), Val( rejs->dzien ) )
      aPoz[ 'DataSprzedazy' ] := hb_Date( Val( rejs->roks ), Val( rejs->mcs ), Val( rejs->dziens ) )
      aPoz[ 'KodKrajuNadaniaTIN' ] := iif( AllTrim( rejs->kraj ) == "", "PL", rejs->kraj )
      aPoz[ 'NrKontrahenta' ] := JPK_NIPEU( rejs->nr_ident, rejs->ue == 'T', rejs->kraj )
      aPoz[ 'NazwaKontrahenta' ] := rejs->nazwa
      aPoz[ 'AdresKontrahenta' ] := rejs->adres
      aPoz[ 'TypDokumentu' ] := AllTrim( rejs->rodzdow )

      aPoz[ 'TerminPlatnosci' ] := SToD( '' )
      aPoz[ 'DataZaplaty' ] := SToD( '' )
      aPoz[ 'KorektaPodstawyOpodt' ] := rejs->korekta == 'Z'
      IF rejs->korekta == 'Z'
         IF rejs->vat02 + rejs->vat12 + rejs->vat07 + rejs->vat22 < 0
            aPoz[ 'TerminPlatnosci' ] := rejs->data_zap
         ELSE
            aPoz[ 'DataZaplaty' ] := rejs->data_zap
         ENDIF
      ENDIF

      AEval( hb_ATokens( rejs->opcje, ',' ), { | aElem |
         SWITCH Val( aElem )
         CASE 1
            aPoz[ 'GTU_01' ] := .T.
            EXIT
         CASE 2
            aPoz[ 'GTU_02' ] := .T.
            EXIT
         CASE 3
            aPoz[ 'GTU_03' ] := .T.
            EXIT
         CASE 4
            aPoz[ 'GTU_04' ] := .T.
            EXIT
         CASE 5
            aPoz[ 'GTU_05' ] := .T.
            EXIT
         CASE 6
            aPoz[ 'GTU_06' ] := .T.
            EXIT
         CASE 7
            aPoz[ 'GTU_07' ] := .T.
            EXIT
         CASE 8
            aPoz[ 'GTU_08' ] := .T.
            EXIT
         CASE 9
            aPoz[ 'GTU_09' ] := .T.
            EXIT
         CASE 10
            aPoz[ 'GTU_10' ] := .T.
            EXIT
         CASE 11
            aPoz[ 'GTU_11' ] := .T.
            EXIT
         CASE 12
            aPoz[ 'GTU_12' ] := .T.
            EXIT
         CASE 13
            aPoz[ 'GTU_13' ] := .T.
            EXIT
         ENDSWITCH
      } )

      aPoz[ 'GTU' ] := AllTrim( rejs->opcje )

      aPoz[ 'NrKSeF' ] := AllTrim( rejs->nrksef )
      aPoz[ 'KSeFStat' ] := rejs->ksefstat

      aPoz[ 'Procedura' ] := AllTrim( rejs->procedur )
      IF Len( AllTrim( rejs->procedur ) ) > 0
         AEval( hb_ATokens( rejs->procedur, ',' ), { | cElem |
            IF Len( AllTrim( cElem ) ) > 0
               aPoz[ AllTrim( cElem ) ] := .T.
            ENDIF
         } )
      ENDIF

      IF  ( rejs->sek_cv7 == 'PN' ) .OR. ( rejs->sek_cv7 == 'PU' ) .OR. ( rejs->sek_cv7 == 'SP' )
         aPoz[ 'MPP' ] := .T.
      ENDIF

      ADodajNieZero( @aPoz, 'SprzedazVAT_Marza', rejs->vatmarza )

      IF hb_HHasKey( aPoz, 'K_10' ) .OR. hb_HHasKey( aPoz, 'K_11' ) .OR. hb_HHasKey( aPoz, 'K_12' ) .OR. hb_HHasKey( aPoz, 'K_13' ) .OR. ;
         hb_HHasKey( aPoz, 'K_14' ) .OR. hb_HHasKey( aPoz, 'K_15' ) .OR. hb_HHasKey( aPoz, 'K_16' ) .OR. hb_HHasKey( aPoz, 'K_17' ) .OR. ;
         hb_HHasKey( aPoz, 'K_18' ) .OR. hb_HHasKey( aPoz, 'K_19' ) .OR. hb_HHasKey( aPoz, 'K_20' ) .OR. hb_HHasKey( aPoz, 'K_21' ) .OR. ;
         hb_HHasKey( aPoz, 'K_22' ) .OR. hb_HHasKey( aPoz, 'K_23' ) .OR. hb_HHasKey( aPoz, 'K_24' ) .OR. hb_HHasKey( aPoz, 'K_25' ) .OR. ;
         hb_HHasKey( aPoz, 'K_26' ) .OR. hb_HHasKey( aPoz, 'K_27' ) .OR. hb_HHasKey( aPoz, 'K_28' ) .OR. hb_HHasKey( aPoz, 'K_29' ) .OR. ;
         hb_HHasKey( aPoz, 'K_30' ) .OR. hb_HHasKey( aPoz, 'K_31' ) .OR. hb_HHasKey( aPoz, 'K_32' ) .OR. hb_HHasKey( aPoz, 'K_33' ) .OR. ;
         hb_HHasKey( aPoz, 'K_34' ) .OR. hb_HHasKey( aPoz, 'K_35' ) .OR. hb_HHasKey( aPoz, 'K_36' ) .OR. hb_HHasKey( aPoz, 'K_37' ) .OR. ;
         hb_HHasKey( aPoz, 'K_38' ) .OR. hb_HHasKey( aPoz, 'K_39' ) .OR. hb_HHasKey( aPoz, 'K_360' ) .OR. hb_HHasKey( aPoz, 'SprzedazVAT_Marza' )

         AAdd( aRes[ 'sprzedaz' ], aPoz )
      ENDIF
      rejs->( dbSkip() )
   ENDDO

   SELECT REJZ
   rejz->( dbSeek( '+' + Str( nFirma, 3, 0 ) + Str( nMiesiacPocz, 2, 0 ) ) )
   DO WHILE .NOT. &cKoniec
      IF rejz->rach == 'F'
         aPoz := hb_Hash()
         lSprzedaz := .F.
         DO CASE
            CASE rejz->sek_cv7 == 'WT' .OR. rejz->sek_cv7 == 'WS'
               lSprzedaz := .T.
               ADodajNieZero( @aPoz, 'K_23', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'S', rejz->wartzw, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'P', rejz->wartzw, 0) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ), 'K_24' )

               ADodajNieZero( @aPoz, 'K_24', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                  + rejz->paliwa + rejz->pojazdy ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ), 'K_23' )

            CASE rejz->sek_cv7 == 'IT' .OR. rejz->sek_cv7 == 'IS'
               lSprzedaz := .T.
               ADodajNieZero( @aPoz, 'K_25', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'S', rejz->wartzw, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'P', rejz->wartzw, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ), 'K_26' )

               ADodajNieZero( @aPoz, 'K_26', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'o', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'o', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'o', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'o', rejz->vat12, 0 ) ;
                  + rejz->paliwa + rejz->pojazdy ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ), 'K_25' )

            CASE SEK_CV7 == 'IU' .OR. SEK_CV7 == 'US'
               lSprzedaz := .T.

               IF rejz->ue == 'T'
                  ADodajNieZero( @aPoz, 'K_29', ;
                       iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                     + iif( rejz->spzw == 'S', rejz->wartzw, 0 ) ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                     + iif( rejz->spzw == 'P', rejz->wartzw, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ), 'K_30' )

                  ADodajNieZero( @aPoz, 'K_30', ;
                       iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                     + rejz->paliwa + rejz->pojazdy ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ), 'K_29' )

               ELSE
                  ADodajNieZero( @aPoz, 'K_27', ;
                       iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                     + iif( rejz->spzw == 'S', rejz->wartzw,0) ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                     + iif( rejz->spzw == 'P', rejz->wartzw, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                     + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ), 'K_28' )

                  ADodajNieZero( @aPoz, 'K_28', ;
                       iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                     + rejz->paliwa + rejz->pojazdy ;
                     + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                     + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                     + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                     + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                     + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ), 'K_27' )

               ENDIF

            CASE SEK_CV7=='PN'.OR.SEK_CV7=='PU' .OR. SEK_CV7 == 'PS'
               lSprzedaz := .T.
               ADodajNieZero( @aPoz, 'K_31', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'S', rejz->wartzw, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .and. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
                  + iif( rejz->spzw == 'P', rejz->wartzw, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'Z', rejz->wart02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'Z', rejz->wart07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .and. rejz->zom22 == 'Z', rejz->wart22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'Z', rejz->wart12, 0 ) ;
                  + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'Z', rejz->wart00, 0 ), 'K_32V' )

               ADodajNieZero( @aPoz, 'K_32V', ;
                    iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                  + rejz->paliwa + rejz->pojazdy ;
                  + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .and. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
                  + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
                  + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
                  + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
                  + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ), 'K_31' )

         ENDCASE

         IF rejz->sek_cv7 <> 'WS' .AND. rejz->sek_cv7 <> 'PS' .AND. rejz->sek_cv7 <> 'IS' .AND. rejz->sek_cv7 <> 'US'
            ADodajNieZero( @aPoz, 'K_43', ;
                 iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O' .AND. rejz->vat02 <> 0, rejz->wart02, 0 ) ;
               + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O' .AND. rejz->vat07 <> 0, rejz->wart07, 0 ) ;
               + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O' .AND. rejz->vat22 <> 0, rejz->wart22, 0 ) ;
               + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O' .AND. rejz->vat12 <> 0, rejz->wart12, 0 ) ;
               + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M' .AND. rejz->vat02 <> 0, rejz->wart02 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M' .AND. rejz->vat07 <> 0, rejz->wart07 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M' .AND. rejz->vat22 <> 0, rejz->wart22 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M' .AND. rejz->vat12 <> 0, rejz->wart12 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp00 == 'S' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ), 'K_44' )

            ADodajNieZero( @aPoz, 'K_44', ;
                 iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ;
               + iif( rejz->sp02 == 'S' .AND. rejz->zom02 == 'M', rejz->vat02 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp07 == 'S' .AND. rejz->zom07 == 'M', rejz->vat07 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp22 == 'S' .AND. rejz->zom22 == 'M', rejz->vat22 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp12 == 'S' .AND. rejz->zom12 == 'M', rejz->vat12 * ( nStruSProb / 100 ), 0 ), 'K_43' )

            ADodajNieZero( @aPoz, 'K_45', ;
               ( iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O' .AND. rejz->vat02 <> 0, rejz->wart02, 0 ) ;
               + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O' .AND. rejz->vat07 <> 0, rejz->wart07, 0 ) ;
               + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O' .AND. rejz->vat22 <> 0, rejz->wart22, 0 ) ;
               + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O' .AND. rejz->vat12 <> 0, rejz->wart12, 0 ) ;
               + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'O', rejz->wart00, 0 ) ;
               + iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M' .AND. rejz->vat02 <> 0, rejz->wart02 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M' .AND. rejz->vat07 <> 0, rejz->wart07 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M' .AND. rejz->vat22 <> 0, rejz->wart22 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M' .AND. rejz->vat12 <> 0, rejz->wart12 * ( nStruSProb / 100 ), 0 ) ;
               + iif( rejz->sp00 == 'P' .AND. rejz->zom00 == 'M', rejz->wart00, 0 ) ) * iif( rejz->opcje $ '257P' .AND. param_ks5d == '2', 0.5, 1 ), 'K_46' )

            ADodajNieZero( @aPoz, 'K_46', ;
               ( iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'O', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'O', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'O', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'O', rejz->vat12, 0 ) ) ;
               + ( ( ;
                 iif( rejz->sp02 == 'P' .AND. rejz->zom02 == 'M', rejz->vat02, 0 ) ;
               + iif( rejz->sp07 == 'P' .AND. rejz->zom07 == 'M', rejz->vat07, 0 ) ;
               + iif( rejz->sp22 == 'P' .AND. rejz->zom22 == 'M', rejz->vat22, 0 ) ;
               + iif( rejz->sp12 == 'P' .AND. rejz->zom12 == 'M', rejz->vat12, 0 ) ) * ;
               ( nStruSProb / 100 ) ), 'K_45' )

         ENDIF

         ADodajNieZero( @aPoz, 'K_47', rejz->kol47 )
         ADodajNieZero( @aPoz, 'K_48', rejz->kol48 )
         ADodajNieZero( @aPoz, 'K_49', rejz->kol49 )
         ADodajNieZero( @aPoz, 'K_50', rejz->kol50 )
         ADodajNieZero( @aPoz, 'ZakupVAT_Marza', rejz->vatmarza )


         IF lSprzedaz == .T.
            aPoz[ 'DowodSprzedazy' ] := NrDokUsunHasz( rejz->numer )
            aPoz[ 'DataWystawienia' ] := rejz->datatran //hb_Date( Val( param_rok ), Val( rejz->mc ), Val( rejz->dzien ) )
            aPoz[ 'DataSprzedazy' ] := hb_Date( Val( rejz->roks ), Val( rejz->mcs ), Val( rejz->dziens ) )

            aPoz[ 'KodKrajuNadaniaTIN' ] := iif( AllTrim( rejz->kraj ) == "", "PL", rejz->kraj )
            aPoz[ 'NrKontrahenta' ] := JPK_NIPEU( rejz->nr_ident, rejz->ue == 'T', rejz->kraj )
            aPoz[ 'NazwaKontrahenta' ] := rejz->nazwa
            aPoz[ 'AdresKontrahenta' ] := rejz->adres
            aPoz[ 'TypDokumentu' ] := ""
            aPoz[ 'GTU' ] := ""
            aPoz[ 'Procedura' ] := iif( rejz->trojstr == "T" .AND. ( rejz->sek_cv7 == "WT" .OR. rejz->sek_cv7 == "WS" ), "TT_WNT", "" )
            aPoz[ 'MPP' ] := .F.
         ENDIF
         aPoz[ 'DokumentZakupu' ] := AllTrim( rejz->rodzdow )
         aPoz[ 'DowodZakupu' ] := NrDokUsunHasz( rejz->numer )
         aPoz[ 'DataZakupu' ] := hb_Date( Val( rejz->roks ), Val( rejz->mcs ), Val( rejz->dziens ) )
         aPoz[ 'DataWplywu' ] := rejz->datatran //hb_Date( Val( param_rok ), Val( rejz->mc ), Val( rejz->dzien ) )

         aPoz[ 'KodKrajuNadaniaTIN' ] := iif( AllTrim( rejz->kraj ) == "", "PL", rejz->kraj )
         aPoz[ 'NrDostawcy' ] := JPK_NIPEU( rejz->nr_ident, rejz->ue == 'T', rejz->kraj )
         aPoz[ 'NazwaDostawcy' ] := rejz->nazwa
         aPoz[ 'AdresDostawcy' ] := rejz->adres

         aPoz[ 'MPP' ] := SEK_CV7 == 'PN' .OR. SEK_CV7 == 'PU' .OR. SEK_CV7 == 'PS' .OR. SEK_CV7 == 'SP'
         aPoz[ 'IMP' ] := SEK_CV7 == 'IT' .OR. SEK_CV7 == 'IZ' .OR. SEK_CV7 == 'IS' .OR. ( rejz->kraj <> "" .AND. rejz->kraj <> "PL" .AND. ! KrajUE( rejz->kraj ) .AND. SEK_CV7 <> 'IU' .AND. SEK_CV7 <> 'UZ' .AND. SEK_CV7 <> 'US' )

         aPoz[ 'NrKSeF' ] := AllTrim( rejz->nrksef )
         aPoz[ 'KSeFStat' ] := rejz->ksefstat

         IF lSprzedaz
            IF hb_HHasKey( aPoz, 'K_10' ) .OR. hb_HHasKey( aPoz, 'K_11' ) .OR. hb_HHasKey( aPoz, 'K_12' ) .OR. hb_HHasKey( aPoz, 'K_13' ) .OR. ;
               hb_HHasKey( aPoz, 'K_14' ) .OR. hb_HHasKey( aPoz, 'K_15' ) .OR. hb_HHasKey( aPoz, 'K_16' ) .OR. hb_HHasKey( aPoz, 'K_17' ) .OR. ;
               hb_HHasKey( aPoz, 'K_18' ) .OR. hb_HHasKey( aPoz, 'K_19' ) .OR. hb_HHasKey( aPoz, 'K_20' ) .OR. hb_HHasKey( aPoz, 'K_21' ) .OR. ;
               hb_HHasKey( aPoz, 'K_22' ) .OR. hb_HHasKey( aPoz, 'K_23' ) .OR. hb_HHasKey( aPoz, 'K_24' ) .OR. hb_HHasKey( aPoz, 'K_25' ) .OR. ;
               hb_HHasKey( aPoz, 'K_26' ) .OR. hb_HHasKey( aPoz, 'K_27' ) .OR. hb_HHasKey( aPoz, 'K_28' ) .OR. hb_HHasKey( aPoz, 'K_29' ) .OR. ;
               hb_HHasKey( aPoz, 'K_30' ) .OR. hb_HHasKey( aPoz, 'K_31' ) .OR. hb_HHasKey( aPoz, 'K_32' ) .OR. hb_HHasKey( aPoz, 'K_33' ) .OR. ;
               hb_HHasKey( aPoz, 'K_34' ) .OR. hb_HHasKey( aPoz, 'K_35' ) .OR. hb_HHasKey( aPoz, 'K_36' ) .OR. hb_HHasKey( aPoz, 'K_37' ) .OR. ;
               hb_HHasKey( aPoz, 'K_38' ) .OR. hb_HHasKey( aPoz, 'K_39' ) .OR. hb_HHasKey( aPoz, 'K_360' )

               AAdd( aRes[ 'sprzedaz' ], aPoz )
            ENDIF
         ENDIF
         IF hb_HHasKey( aPoz, 'K_43' ) .OR. hb_HHasKey( aPoz, 'K_44' ) .OR. ;
            hb_HHasKey( aPoz, 'K_45' ) .OR. hb_HHasKey( aPoz, 'K_46' ) .OR. ;
            hb_HHasKey( aPoz, 'K_47' ) .OR. hb_HHasKey( aPoz, 'K_48' ) .OR. ;
            hb_HHasKey( aPoz, 'K_49' ) .OR. hb_HHasKey( aPoz, 'K_50' ) .OR. ;
            hb_HHasKey( aPoz, 'ZakupVAT_Marza' )

            AAdd( aRes[ 'zakup' ], aPoz )
         ENDIF
      ENDIF
      rejz->( dbSkip() )
   ENDDO

   IF Len( aRes[ 'sprzedaz' ] ) == 0 .AND. ! lV7
      AAdd( aRes[ 'sprzedaz' ], hb_Hash( 'DowodSprzedazy', 'BRAK', 'DataWystawienia', hb_Date(), 'NrKontrahenta', 'BRAK', 'NazwaKontrahenta', 'BRAK', 'AdresKontrahenta', 'BRAK' ) )
   ENDIF
   ASort( aRes[ 'sprzedaz' ], , , { |x, y| x[ 'DataWystawienia' ] < y[ 'DataWystawienia' ] } )
   aRes[ 'SprzedazCtrl' ] := hb_Hash( 'LiczbaWierszySprzedazy', Len( aRes[ 'sprzedaz' ] ), 'PodatekNalezny', 0 )
   AEval( aRes[ 'sprzedaz' ], { | aRow |
      IF ! hb_HHasKey( aRow, 'TypDokumentu' ) .OR. aRow[ 'TypDokumentu' ] <> "FP"
         aRes[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] := aRes[ 'SprzedazCtrl' ][ 'PodatekNalezny' ] + ;
         iif( hb_HHasKey( aRow, 'K_16' ), aRow[ 'K_16' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_18' ), aRow[ 'K_18' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_20' ), aRow[ 'K_20' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_24' ), aRow[ 'K_24' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_26' ), aRow[ 'K_26' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_28' ), aRow[ 'K_28' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_30' ), aRow[ 'K_30' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_33' ), aRow[ 'K_33' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_35' ), aRow[ 'K_35' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_36' ), aRow[ 'K_36' ], 0 ) + ;
         iif( hb_HHasKey( aRow, 'K_37' ), aRow[ 'K_37' ], 0 ) - ;
         iif( hb_HHasKey( aRow, 'K_38' ), aRow[ 'K_38' ], 0 ) - ;
         iif( hb_HHasKey( aRow, 'K_39' ), aRow[ 'K_39' ], 0 ) - ;
         iif( hb_HHasKey( aRow, 'K_360' ), aRow[ 'K_360' ], 0 )
      ENDIF
   } )

   IF Len( aRes[ 'zakup' ] ) == 0 .AND. ! lV7
      AAdd( aRes[ 'zakup' ], hb_Hash( 'DowodZakupu', 'BRAK', 'DataZakupu', hb_Date(), 'NrDostawcy', 'BRAK', 'NazwaDostawcy', 'BRAK', 'AdresDostawcy', 'BRAK' ) )
   ENDIF
   ASort( aRes[ 'zakup' ], , , { |x, y| x[ 'DataZakupu' ] < y[ 'DataZakupu' ] } )
   aRes[ 'ZakupCtrl' ] := hb_Hash( 'LiczbaWierszyZakupow', Len( aRes[ 'zakup' ] ), 'PodatekNaliczony', 0 )
   AEval( aRes[ 'zakup' ] , { | aRow | ;
      aRes[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] := aRes[ 'ZakupCtrl' ][ 'PodatekNaliczony' ] + ;
      iif( hb_HHasKey( aRow, 'K_44' ), aRow[ 'K_44' ], 0 ) + ;
      iif( hb_HHasKey( aRow, 'K_46' ), aRow[ 'K_46' ], 0 ) + ;
      iif( hb_HHasKey( aRow, 'K_47' ), aRow[ 'K_47' ], 0 ) + ;
      iif( hb_HHasKey( aRow, 'K_48' ), aRow[ 'K_48' ], 0 ) + ;
      iif( hb_HHasKey( aRow, 'K_49' ), aRow[ 'K_49' ], 0 ) + ;
      iif( hb_HHasKey( aRow, 'K_50' ), aRow[ 'K_50' ], 0 ) } )

   close_()

   aRes[ 'OK' ] := .T.

   RETURN aRes

/*----------------------------------------------------------------------*/

FUNCTION VAT_InfoSum( nRaport, nFirma, nMiesiac )

   LOCAL aDane
   LOCAL oRap, nMonDruk

   aDane := JPK_VAT_Dane( nFirma, nMiesiac )

   IF Len( aDane[ 'zakup' ] ) > 0 .OR. Len( aDane[ 'sprzedaz' ] ) > 0

      aDane[ 'SP_10' ] := 0
      aDane[ 'SP_11' ] := 0
      aDane[ 'SP_12' ] := 0
      aDane[ 'SP_13' ] := 0
      aDane[ 'SP_14' ] := 0
      aDane[ 'SP_15' ] := 0
      aDane[ 'SP_16' ] := 0
      aDane[ 'SP_17' ] := 0
      aDane[ 'SP_18' ] := 0
      aDane[ 'SP_19' ] := 0
      aDane[ 'SP_20' ] := 0
      aDane[ 'SP_21' ] := 0
      aDane[ 'SP_22' ] := 0
      aDane[ 'SP_23' ] := 0
      aDane[ 'SP_24' ] := 0
      aDane[ 'SP_25' ] := 0
      aDane[ 'SP_26' ] := 0
      aDane[ 'SP_27' ] := 0
      aDane[ 'SP_28' ] := 0
      aDane[ 'SP_29' ] := 0
      aDane[ 'SP_30' ] := 0
      aDane[ 'SP_31' ] := 0
      aDane[ 'SP_32' ] := 0
      aDane[ 'SP_33' ] := 0
      aDane[ 'SP_34' ] := 0
      aDane[ 'SP_35' ] := 0
      aDane[ 'SP_36' ] := 0
      aDane[ 'SP_37' ] := 0
      aDane[ 'SP_38' ] := 0
      aDane[ 'SP_39' ] := 0

      aDane[ 'SP_43' ] := 0
      aDane[ 'SP_44' ] := 0
      aDane[ 'SP_45' ] := 0
      aDane[ 'SP_46' ] := 0
      aDane[ 'SP_47' ] := 0
      aDane[ 'SP_48' ] := 0
      aDane[ 'SP_49' ] := 0
      aDane[ 'SP_50' ] := 0

      aDane[ 'SP_360' ] := 0

      AEval( aDane[ 'sprzedaz' ], { | aPoz |



         IF ! hb_HHasKey( aPoz, 'K_10' )
            aPoz[ 'K_10' ] := 0
         ELSE
            aDane[ 'SP_10' ] := aDane[ 'SP_10' ] + aPoz[ 'K_10' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_11' )
            aPoz[ 'K_11' ] := 0
         ELSE
            aDane[ 'SP_11' ] := aDane[ 'SP_11' ] + aPoz[ 'K_11' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_12' )
            aPoz[ 'K_12' ] := 0
         ELSE
            aDane[ 'SP_12' ] := aDane[ 'SP_12' ] + aPoz[ 'K_12' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_13' )
            aPoz[ 'K_13' ] := 0
         ELSE
            aDane[ 'SP_13' ] := aDane[ 'SP_13' ] + aPoz[ 'K_13' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_14' )
            aPoz[ 'K_14' ] := 0
         ELSE
            aDane[ 'SP_14' ] := aDane[ 'SP_14' ] + aPoz[ 'K_14' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_15' )
            aPoz[ 'K_15' ] := 0
         ELSE
            aDane[ 'SP_15' ] := aDane[ 'SP_15' ] + aPoz[ 'K_15' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_16' )
            aPoz[ 'K_16' ] := 0
         ELSE
            aDane[ 'SP_16' ] := aDane[ 'SP_16' ] + aPoz[ 'K_16' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_17' )
            aPoz[ 'K_17' ] := 0
         ELSE
            aDane[ 'SP_17' ] := aDane[ 'SP_17' ] + aPoz[ 'K_17' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_18' )
            aPoz[ 'K_18' ] := 0
         ELSE
            aDane[ 'SP_18' ] := aDane[ 'SP_18' ] + aPoz[ 'K_18' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_19' )
            aPoz[ 'K_19' ] := 0
         ELSE
            aDane[ 'SP_19' ] := aDane[ 'SP_19' ] + aPoz[ 'K_19' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_20' )
            aPoz[ 'K_20' ] := 0
         ELSE
            aDane[ 'SP_20' ] := aDane[ 'SP_20' ] + aPoz[ 'K_20' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_21' )
            aPoz[ 'K_21' ] := 0
         ELSE
            aDane[ 'SP_21' ] := aDane[ 'SP_21' ] + aPoz[ 'K_21' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_22' )
            aPoz[ 'K_22' ] := 0
         ELSE
            aDane[ 'SP_22' ] := aDane[ 'SP_22' ] + aPoz[ 'K_22' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_23' )
            aPoz[ 'K_23' ] := 0
         ELSE
            aDane[ 'SP_23' ] := aDane[ 'SP_23' ] + aPoz[ 'K_23' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_24' )
            aPoz[ 'K_24' ] := 0
         ELSE
            aDane[ 'SP_24' ] := aDane[ 'SP_24' ] + aPoz[ 'K_24' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_25' )
            aPoz[ 'K_25' ] := 0
         ELSE
            aDane[ 'SP_25' ] := aDane[ 'SP_25' ] + aPoz[ 'K_25' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_26' )
            aPoz[ 'K_26' ] := 0
         ELSE
            aDane[ 'SP_26' ] := aDane[ 'SP_26' ] + aPoz[ 'K_26' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_27' )
            aPoz[ 'K_27' ] := 0
         ELSE
            aDane[ 'SP_27' ] := aDane[ 'SP_27' ] + aPoz[ 'K_27' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_28' )
            aPoz[ 'K_28' ] := 0
         ELSE
            aDane[ 'SP_28' ] := aDane[ 'SP_28' ] + aPoz[ 'K_28' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_29' )
            aPoz[ 'K_29' ] := 0
         ELSE
            aDane[ 'SP_29' ] := aDane[ 'SP_29' ] + aPoz[ 'K_29' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_30' )
            aPoz[ 'K_30' ] := 0
         ELSE
            aDane[ 'SP_30' ] := aDane[ 'SP_30' ] + aPoz[ 'K_30' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_31' )
            aPoz[ 'K_31' ] := 0
         ELSE
            aDane[ 'SP_31' ] := aDane[ 'SP_31' ] + aPoz[ 'K_31' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_32' )
            aPoz[ 'K_32' ] := 0
         ELSE
            aDane[ 'SP_32' ] := aDane[ 'SP_32' ] + aPoz[ 'K_32' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_33' )
            aPoz[ 'K_33' ] := 0
         ELSE
            aDane[ 'SP_33' ] := aDane[ 'SP_33' ] + aPoz[ 'K_33' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_34' )
            aPoz[ 'K_34' ] := 0
         ELSE
            aDane[ 'SP_34' ] := aDane[ 'SP_34' ] + aPoz[ 'K_34' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_35' )
            aPoz[ 'K_35' ] := 0
         ELSE
            aDane[ 'SP_35' ] := aDane[ 'SP_35' ] + aPoz[ 'K_35' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_36' )
            aPoz[ 'K_36' ] := 0
         ELSE
            aDane[ 'SP_36' ] := aDane[ 'SP_36' ] + aPoz[ 'K_36' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_37' )
            aPoz[ 'K_37' ] := 0
         ELSE
            aDane[ 'SP_37' ] := aDane[ 'SP_37' ] + aPoz[ 'K_37' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_38' )
            aPoz[ 'K_38' ] := 0
         ELSE
            aDane[ 'SP_38' ] := aDane[ 'SP_38' ] + aPoz[ 'K_38' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_39' )
            aPoz[ 'K_39' ] := 0
         ELSE
            aDane[ 'SP_39' ] := aDane[ 'SP_39' ] + aPoz[ 'K_39' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_360' )
            aPoz[ 'K_360' ] := 0
         ELSE
            aDane[ 'SP_360' ] := aDane[ 'SP_360' ] + aPoz[ 'K_360' ]
         ENDIF
      } )

      AEval( aDane[ 'zakup' ], { | aPoz |
         IF ! hb_HHasKey( aPoz, 'K_43' )
            aPoz[ 'K_43' ] := 0
         ELSE
            aDane[ 'SP_43' ] := aDane[ 'SP_43' ] + aPoz[ 'K_43' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_44' )
            aPoz[ 'K_44' ] := 0
         ELSE
            aDane[ 'SP_44' ] := aDane[ 'SP_44' ] + aPoz[ 'K_44' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_45' )
            aPoz[ 'K_45' ] := 0
         ELSE
            aDane[ 'SP_45' ] := aDane[ 'SP_45' ] + aPoz[ 'K_45' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_46' )
            aPoz[ 'K_46' ] := 0
         ELSE
            aDane[ 'SP_46' ] := aDane[ 'SP_46' ] + aPoz[ 'K_46' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_47' )
            aPoz[ 'K_47' ] := 0
         ELSE
            aDane[ 'SP_47' ] := aDane[ 'SP_47' ] + aPoz[ 'K_47' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_48' )
            aPoz[ 'K_48' ] := 0
         ELSE
            aDane[ 'SP_48' ] := aDane[ 'SP_48' ] + aPoz[ 'K_48' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_49' )
            aPoz[ 'K_49' ] := 0
         ELSE
            aDane[ 'SP_49' ] := aDane[ 'SP_49' ] + aPoz[ 'K_49' ]
         ENDIF
         IF ! hb_HHasKey( aPoz, 'K_50' )
            aPoz[ 'K_50' ] := 0
         ELSE
            aDane[ 'SP_50' ] := aDane[ 'SP_50' ] + aPoz[ 'K_50' ]
         ENDIF
      } )


      @ 24, 0
      @ 24, 26 PROMPT '[ Monitor ]'
      @ 24, 44 PROMPT '[ Drukarka ]'
      IF trybSerwisowy
         @ 24, 70 PROMPT '[ Edytor ]'
      ENDIF
      CLEAR TYPE
      menu TO nMonDruk
      IF LastKey() == K_ESC
         RETURN
      ENDIF

      TRY
         oRap := FRUtworzRaport()

         SWITCH nRaport
         CASE 1
            oRap:LoadFromFile( 'frf\infovats.frf' )
            EXIT
         CASE 2
            oRap:LoadFromFile( 'frf\infovat.frf' )
            EXIT
         ENDSWITCH

         IF Len( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) ) > 0
            oRap:SetPrinter( AllTrim( hProfilUzytkownika[ 'drukarka' ] ) )
         ENDIF

         FRUstawMarginesy( oRap, hProfilUzytkownika[ 'marginl' ], hProfilUzytkownika[ 'marginp' ], ;
            hProfilUzytkownika[ 'marging' ], hProfilUzytkownika[ 'margind' ] )

         oRap:AddValue( 'uzytkownik', code() )
         oRap:AddValue( 'miesiac', AllTrim( miesiac( nMiesiac ) ) )
         oRap:AddValue( 'rok', param_rok )
         oRap:AddValue( 'firma', AllTrim( aDane[ 'PelnaNazwa' ] ) + ' - ' + AllTrim( aDane[ 'NIP' ] ) )

         hb_HEval( aDane, { | cKey, xValue |
            IF ValType( cKey ) == 'C' .AND. ValType( xValue ) $ 'CNLDTM'
               oRap:AddValue( cKey, xValue )
            ENDIF
         } )

         oRap:AddDataset( 'sprzedaz' )
         AEval(aDane[ 'sprzedaz' ], { | aPoz | oRap:AddRow( 'sprzedaz', aPoz ) } )

         oRap:AddDataset( 'zakup' )
         AEval( aDane[ 'zakup' ], { | aPoz | oRap:AddRow( 'zakup', aPoz ) } )

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

   ELSE

   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JPK_VAT_PobierzNrWer( nTop, nLeft, nDomNr, cAdresEmail )

   LOCAL nTmpNr
   LOCAL cEkran := SaveScreen( 0, 0, MaxRow(), MaxCol() )
   LOCAL cKolor := ColStd()

   hb_default( @nDomNr, 0 )
   nTmpNr := nDomNr

   cAdresEmail := PadR( Firma_WczytajEmail(), 60 )

   @ nTop, nLeft, nTop + 3, nLeft + 77 BOX B_SINGLE + Space( 1 )
   @ nTop + 1, nLeft + 2 SAY "Numer kolejnej wersji ( 0 - pierwsze zˆo¾enie ):" GET nTmpNr PICTURE "999" VALID nTmpNr >= 0
   @ nTop + 2, nLeft + 2 SAY "Adres e-mail:" GET cAdresEmail PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
   Read_()
   IF LastKey() == K_ESC
      nTmpNr := -1
   ENDIF

   IF nTmpNr >= 0
      Firma_ZapiszEmail( cAdresEmail )
   ENDIF

   RestScreen( , , , , cEkran )

   RETURN nTmpNr

/*----------------------------------------------------------------------*/

FUNCTION JPK_VAT_WczytajWERJPKVAT()

   LOCAL nWorkNo := Select()
   LOCAL nWer := 0

   IF DostepPro( "SUMA_MC", "SUMA_MC", .T., "SUMA_MCW" )
      suma_mcw->( dbSeek( "+" + ident_fir + miesiac ) )
      IF suma_mcw->( Found() )
         nWer := suma_mcw->werjpkvat
      ENDIF
      suma_mcw->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN nWer

/*----------------------------------------------------------------------*/

PROCEDURE JPK_VAT_ZapiszWERJPKVAT( nWer )

   LOCAL nWorkNo := Select()

   IF DostepPro( "SUMA_MC", "SUMA_MC", .T., "SUMA_MCW" )
      suma_mcw->( dbSeek( "+" + ident_fir + miesiac ) )
      IF suma_mcw->( Found() )
         IF suma_mcw->( dbRLock() )
            suma_mcw->werjpkvat := nWer
            suma_mcw->( dbCommit() )
            suma_mcw->( dbRUnlock() )
         ENDIF
      ENDIF
      suma_mcw->( dbCloseArea() )
   ENDIF

   dbSelectArea( nWorkNo )

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE JPK_V7_Rob( nR, nC )

   LOCAL aDaneVat, aDane := hb_Hash()
   LOCAL nFirma, nMiesiacPocz, nMiesiacKon
   LOCAL cAdresEmail, cTel
   LOCAL cDaneXml, cMK
   LOCAL nMenu := 1, cKolor, cEkran := SaveScreen(), nMenuDekDruk := 1
   LOCAL lKorekta := NIL, nMenuDekWer := 1

   hb_default( @nR, 15 )
   hb_default( @nC, 4 )

   nFirma := Val( ident_fir )
//   nMiesiacPocz := Val( miesiac )
//   nMiesiacKon := NIL
//   IF zVATFORDR == '7 '
    nMiesiacPocz := Val( miesiac )
    nMiesiacKon := NIL
//   ELSE
//      aKw := ObliczKwartal( Val( miesiac ) )
//      nMiesiacPocz := aKw[ 'kwapocz' ]
//      nMiesiacKon := aKw[ 'kwakon' ]
//   ENDIF */

   aDane[ 'Kwartalnie' ] := zVATFORDR == '7K'
   aDane[ 'Miesiac' ] := nMiesiacPocz
   aDane[ 'Rok' ] := Val( param_rok )
   aDane[ 'Korekta' ] := .F.
   aDane[ 'DataWytworzeniaJPK' ] := datetime2strxml( hb_DateTime() )

   nMenuDekWer := MenuEx( nR, nC, { ' 3 - JPK_V' + Pad( AllTrim( zVATFORDR ), 2 ) + ' (3)   ', ;
      ' 2 - JPK_V' + Pad( AllTrim( zVATFORDR ), 2 ) + ' (2)   ' }, nMenuDekWer, .T. )

   IF nMenuDekWer == 0
      RestScreen( , , , , cEkran )
      RETURN NIL
   ENDIF

   nMenuDekDruk := MenuEx( nR, nC, { ' D - Wydruk      ', ' E - eDeklaracja ' }, ;
      nMenuDekDruk, .T. )

   IF nMenuDekDruk == 0
      RestScreen( , , , , cEkran )
      RETURN NIL
   ENDIF

   IF ! aDane[ 'Kwartalnie' ] .OR. AScan( { 3, 6, 9, 12 }, nMiesiacPocz ) > 0 .OR. nMenuDekDruk == 1
      aDane[ 'Kwartal' ] := ObliczKwartal( nMiesiacPocz )[ 'kwarta' ]
      nMenu := MenuEx( nR, nC, { ' J - Deklaracja + rejestry ', ;
         ' D - Tylko deklaracja      ', ' R - Tylko rejestry        ' }, ;
         nMenu, .T. )
   ELSE
      nMenu := 3
   ENDIF

   IF nMenu == 0
      RestScreen( , , , , cEkran )
      RETURN NIL
   ENDIF

   IF nMenu == 1 .OR. nMenu == 2
      aDaneVat := Vat_720( 0, 0, 1, 'J' )
      IF HB_ISNIL( aDaneVat ) .OR. ! HB_ISHASH( aDaneVat )
         RestScreen( , , , , cEkran )
         RETURN NIL
      ENDIF
      aDane[ 'Korekta' ] := aDaneVat[ 'Korekta' ]
   ENDIF

   IF nMenu == 1 .OR. nMenu == 3
      aDane := hb_HMerge( aDane, JPK_VAT_Dane( nFirma, nMiesiacPocz, nMiesiacKon, .T. ) )
   ENDIF

   aDane[ 'DekV7' ] := aDaneVat
   aDane[ 'Deklaracja' ] := nMenu == 1 .OR. nMenu == 2
   aDane[ 'Rejestry' ] := nMenu == 1 .OR. nMenu == 3

   IF ! JPK_Dane_Firmy( nFirma, @aDane )
      RETURN NIL
   ENDIF

   IF nMenu == 3
      lKorekta := .F.
   ENDIF

   IF nMenuDekDruk == 1
      DeklarDrukuj( 'JPKV7' + iif( aDane[ 'Kwartalnie' ], 'K', 'M' ) + '-' + iif( nMenuDekWer == 1, '3', '2' ) , aDane )
   ELSE
      IF JPK_V7_PobierzDaneAut( 17, 2, @cAdresEmail, @cTel, @lKorekta )
         IF HB_ISLOGICAL( lKorekta )
            aDane[ 'Korekta' ] := lKorekta
         ENDIF
         aDane[ 'CelZlozenia' ] := iif( aDane[ 'Korekta' ], '2', '1' )
         aDane[ 'Tel' ] := AllTrim( cTel )
         aDane[ 'EMail' ] := AllTrim( cAdresEmail )
         IF aDane[ 'Kwartalnie' ]
            cDaneXml := iif( nMenuDekWer == 1, jpk_v7k_3( aDane ), jpk_v7k_2( aDane ) )
         ELSE
            cDaneXml := iif( nMenuDekWer == 1, jpk_v7m_3( aDane ), jpk_v7m_2( aDane ) )
         ENDIF
         cMK := iif( aDane[ 'Kwartalnie' ], 'K', 'M' )
         edekZapiszXML( cDaneXML, normalizujNazwe( 'JPK_V7' + cMK + '_' + AllTrim( aDane[ 'NazwaSkr' ] ) ) + '_' + param_rok + '_' + CMonth( hb_Date( Val( param_rok ), aDane[ 'Miesiac' ], 1 ) ), wys_edeklaracja, 'JPKV7' + cMK + '-' + iif( nMenuDekWer == 1, '3', '2' ), aDane[ 'Korekta' ], nMiesiacPocz )
      ENDIF
   ENDIF

   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION JPK_V7_PobierzDaneAut( nTop, nLeft, cAdresEmail, cTel, lKorekta )

   LOCAL lRes := .F.
   LOCAL cEkran := SaveScreen( 0, 0, MaxRow(), MaxCol() )
   LOCAL cKolor := ColStd()
   LOCAL aDane
   LOCAL cKorekta, lJestKorekta := .F.

   IF HB_ISLOGICAL( lKorekta )
      lJestKorekta := .T.
      cKorekta := iif( lKorekta, 'T', 'N' )
   ENDIF

   aDane := Firma_Wczytaj( { "TEL", "EMAIL" } )

   cAdresEmail := PadR( aDane[ "EMAIL" ], 60 )
   cTel := PadR( aDane[ "TEL" ], 10 )

   @ nTop, nLeft, nTop + 3 + iif( lJestKorekta, 1, 0 ), nLeft + 77 BOX B_SINGLE + Space( 1 )
   @ nTop + 1, nLeft + 2 SAY "Numer telefonu:" GET cTel PICTURE "9999999999"
   @ nTop + 2, nLeft + 2 SAY "Adres e-mail:" GET cAdresEmail PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" VALID Len( AllTrim( cAdresEmail ) ) > 0
   IF lJestKorekta
      @ nTop + 3, nLeft + 2 SAY "Korekta deklaracji (Tak/Nie):" GET cKorekta PICTURE "!" VALID cKorekta $ 'TN'
   ENDIF
   Read_()
   IF LastKey() <> K_ESC
      aDane[ "EMAIL" ] := cAdresEmail
      aDane[ "TEL" ] := cTel
      Firma_Zapisz( aDane )
      lRes := .T.
      IF lJestKorekta
         lKorekta := cKorekta == 'T'
      ENDIF
   ENDIF

   RestScreen( , , , , cEkran )

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION JPK_Dane_Firmy( nFirma, aRes )

   hb_default( @aRes, hb_Hash() )
   hb_default( @nFirma, Val( ident_fir ) )

   IF .NOT. DostepPro( 'FIRMA' )
      close_()
      RETURN .F.
   ENDIF
   firma->( dbGoto( nFirma ) )
   IF firma->( RecNo() ) <> nFirma
      close_()
      RETURN .F.
   ENDIF

   IF .NOT. DostepPro( 'URZEDY' )
      close_()
      RETURN .F.
   ENDIF

   aRes[ 'NIP' ] := firma->nip
   IF firma->skarb > 0
      urzedy->( dbGoto( firma->skarb ) )
      IF urzedy->( RecNo() ) == firma->skarb
         aRes['KodUrzedu'] := urzedy->kodurzedu
      ENDIF
   ENDIF

   aRes['PelnaNazwa'] := firma->nazwa
   aRes['Wojewodztwo'] := firma->param_woj
   aRes['Powiat'] := firma->param_pow
   aRes['Gmina'] := firma->gmina
   aRes['Ulica'] := firma->ulica
   aRes['NrDomu'] := firma->nr_domu
   aRes['NrLokalu'] := firma->nr_mieszk
   aRes['Miejscowosc'] := firma->miejsc
   aRes['KodPocztowy'] := firma->kod_p
   aRes['Poczta'] := firma->poczta
   aRes['NazwaSkr'] := firma->nazwa_skr
   aRes['Spolka'] := firma->spolka

   IF ! aRes['Spolka']
      IF .NOT. DostepPro( 'SPOLKA', , , , 'SPOLKA' )
         close_()
         RETURN .F.
      ENDIF
      spolka->( dbSeek( "+" + ident_fir + firma->nazwisko ) )
      IF spolka->( Found() )
         aRes[ 'Nazwisko' ] := naz_imie_naz( spolka->naz_imie ) // SubStr( spolka->naz_imie, 1, At( ' ', spolka->naz_imie ) )
         aRes[ 'ImiePierwsze' ] := naz_imie_imie( spolka->naz_imie ) // SubStr( spolka->naz_imie, At( ' ', spolka->naz_imie ) + 1 )
         aRes[ 'DataUrodzenia' ] := spolka->data_ur
      ELSE
         Komunikat( "Prosz© wybra† nazwisko peˆnomocnika lub wˆa˜ciciela w informacji o firmie." )
         close_()
         RETURN .F.
      ENDIF
      spolka->( dbCloseArea() )
   ENDIF

   aRes['strusprob'] := firma->strusprob

   firma->( dbCloseArea() )
   urzedy->( dbCloseArea() )

   RETURN .T.

/*----------------------------------------------------------------------*/
