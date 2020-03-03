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

#include "hbdyn.ch"

FUNCTION amiDllZaladuj()

   amiDllH := hb_libLoad( 'amibook.dll' )
   IF amiDllH == NIL
      RETURN .F.
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION amiDllZakoncz()

   IF amiDllH != NIL
      hb_LibFree( amiDllH )
      amiDllH := NIL
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION amiInicjuj( iWersja, nAppHandle, nTransport, nRodzajSHA )

   IF Empty( amiDllH )
      RETURN 0
   ENDIF

   hb_default( @nTransport, 1 )

   RETURN hb_DynCall( { 'amiInicjuj', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT_UNSIGNED, HB_DYN_CALLCONV_STDCALL ), ;
      HB_DYN_CTYPE_INT_UNSIGNED, HB_DYN_CTYPE_INT_UNSIGNED, ;
      HB_DYN_CTYPE_INT_UNSIGNED, HB_DYN_CTYPE_INT_UNSIGNED }, iWersja, ;
      nAppHandle, nTransport, nRodzajSHA )

/*----------------------------------------------------------------------*/

FUNCTION amiZnajdzPokazProces(cProgram)

   IF Empty( amiDllH )
      RETURN 0
   ENDIF

   RETURN hb_DynCall( { 'amiZnajdzPokazProces', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, cProgram )

/*----------------------------------------------------------------------*/

FUNCTION amiEdekCertyfikatIlosc()

   IF Empty( amiDllH )
      RETURN 0
   ENDIF

   RETURN hb_DynCall( { 'edekCertyfikatIlosc', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ) } )

/*----------------------------------------------------------------------*/

FUNCTION amiEdekCertyfikatDane( nIndeks, nTypDanych )

   LOCAL cTmpNazwa, nTmpDl, cRes := ''

   IF Empty( amiDllH )
      RETURN cRes
   ENDIF

   cTmpNazwa := Space( 1024 )
   nTmpDl := hb_DynCall( { 'edekCertyfikatDane', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      HB_DYN_CTYPE_INT, HB_DYN_CTYPE_INT, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, nIndeks, nTypDanych, @cTmpNazwa, @nTmpDl)

   IF nTmpDl > 0
      cRes := SubStr(cTmpNazwa, 1, nTmpDl)
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION amiEdekCertyfikatPokaz( nIndeks )

   IF Empty( amiDllH )
      RETURN NIL
   ENDIF

   hb_DynCall( { 'edekCertyfikatPokaz', amiDllH, ;
      HB_DYN_CALLCONV_STDCALL, HB_DYN_CTYPE_INT }, nIndeks )

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION amiEdekPodpisz( cPlikWej, cPlikWyj, nCertIndeks, cCertSerialNo )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( {'edekPodpisz', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT, hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, cPlikWej, cPlikWyj, nCertIndeks, cCertSerialNo )

/*----------------------------------------------------------------------*/

FUNCTION amiEdekPodpiszAut( cPlikWej, cPlikWyj, cNIP, cImie, cNazwisko, cDataUr, cKwota )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( { 'edekPodpiszAut', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, ;
      cPlikWej, cPlikWyj, cNIP, cImie, cNazwisko, cDataUr, cKwota )

/*----------------------------------------------------------------------*/

FUNCTION amiEdekBladTekst()

   LOCAL cTekst := '', nDlugosc

   IF Empty( amiDllH )
      RETURN 'Biblotega amibook.dll nie zostaˆa zaˆadowana'
   ENDIF

   hb_DynCall( { 'edekBladTekst', amiDllH, HB_DYN_CALLCONV_STDCALL, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, NIL, @nDlugosc )

   IF nDlugosc > 0
      cTekst := Space( nDlugosc )
      hb_DynCall( { 'edekBladTekst', amiDllH, HB_DYN_CALLCONV_STDCALL, ;
         hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
         HB_DYN_CTYPE_INT }, @cTekst, @nDlugosc )
   ENDIF

   RETURN cTekst

/*----------------------------------------------------------------------*/

FUNCTION amiEdekWyslij( cPlikDek, lBramkaTestowa, lPodpis, cRefId, nStatus, cStatusOpis )

   LOCAL nRefIdLen := 128, nStatusOpisLen := 4000, nRes

   IF Empty( amiDllH )
      cRefId := ''
      cStatusOpis := ''
      nStatus := 0
      RETURN 1
   ENDIF

   cRefId := Space( nRefIdLen )
   cStatusOpis := Space( nStatusOpisLen )

   nRes := hb_DynCall( {'edekWyslij', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL, HB_DYN_CTYPE_BOOL, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), HB_DYN_CTYPE_INT, ;
      HB_DYN_CTYPE_INT, hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT}, cPlikDek, lBramkaTestowa, lPodpis, @cRefId, ;
      @nRefIdLen, @nStatus, @cStatusOpis, @nStatusOpisLen )

   IF nRes == 0
      cRefId := iif( nRefIdLen > 0, SubStr( cRefId, 1, nRefIdLen ), '' )
      cStatusOpis := iif( nStatusOpisLen > 0, SubStr( cStatusOpis, 1, nStatusOpisLen ), '' )
   ELSE
      cRefId := ''
      cStatusOpis := ''
      nStatus := 0
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiEdekWeryfikuj( cPlik )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( { 'edekWeryfikuj', amiDllH, hb_bitOr( HB_DYN_CTYPE_INT, ;
      HB_DYN_CALLCONV_STDCALL ), hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, cPlik )

/*----------------------------------------------------------------------*/

FUNCTION amiEdekPobierzUPO( cRefId, lBramkaTestowa, cPlikUPO, nStatus, cStatusOpis )

   LOCAL nRes, nStatusOpisLen := 4000

   IF Empty( amiDllH )
      cRefId := ''
      cStatusOpis := ''
      nStatus := 0
      RETURN 1
   ENDIF

   cStatusOpis := Space( nStatusOpisLen )

   nRes := hb_DynCall( {'edekPobierzUPO', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL, hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT,  hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, cRefId, lBramkaTestowa, cPlikUPO, @nStatus, ;
      @cStatusOpis, @nStatusOpisLen )

   IF nRes == 0
      cStatusOpis := iif( Len( cStatusOpis ) > 0, SubStr( cStatusOpis, 1, nStatusOpisLen ), '' )
   ELSE
      cStatusOpis := ''
      nStatus := 0
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiPobierzLicencje( cUzytkownik, cNrNIP, nLicNr, lWer1, lWer2, lWer3, lWer4 )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   cUzytkownik := Space( 112 )
   cNrNIP := Space( 32 )
   nLicNr := 0
   lWer1 := .T.
   lWer2 := .F.
   lWer3 := .F.
   lWer4 := .T.

   RETURN hb_DynCall( { 'amiPobierzLicencje', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), HB_DYN_CTYPE_INT, ;
      HB_DYN_CTYPE_BOOL, HB_DYN_CTYPE_BOOL, HB_DYN_CTYPE_BOOL, HB_DYN_CTYPE_BOOL }, ;
      @cUzytkownik, @cNrNIP, @nLicNr, @lWer1, @lWer2, @lWer3, @lWer4 )

/*----------------------------------------------------------------------*/

FUNCTION amiJpkPodpisz( cPlikWej, nCertIndeks, lTestowa, cCertSerialNo )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( { 'jpkPodpisz', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT, HB_DYN_CTYPE_BOOL, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, cPlikWej, nCertIndeks, lTestowa, cCertSerialNo )

/*----------------------------------------------------------------------*/

FUNCTION amiJpkWyslij( cPlikWej, lTestowa, cNrRef, nNrRefLen )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   hb_default( @cNrRef, Space( 128 ) )
   hb_default( @nNrRefLen, Len( cNrRef ) )

   RETURN hb_DynCall( { 'jpkWyslij', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, cPlikWej, lTestowa, @cNrRef, @nNrRefLen )

/*----------------------------------------------------------------------*/

FUNCTION amiJpkPobierzUPO( cNrRef, cPlikWyj, lTestowa )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( { 'jpkPobierzUPO', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL }, cNrRef, cPlikWyj, lTestowa )

/*----------------------------------------------------------------------*/

FUNCTION amiSprawdzNIPVAT( cNIP )

   IF Empty( amiDllH )
      RETURN 5
   ENDIF

   RETURN hb_DynCall( { 'mfSprawdzVAT', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, ;
      cNIP )

/*----------------------------------------------------------------------*/

FUNCTION amiJpkMicroPodpisz( cPlikWej, cPlikWyj, cNIP, cImie, cNazwisko, cDataUr, cKwota, cEMail )

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   RETURN hb_DynCall( { 'jpkMicroPodpisz', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ) }, ;
      cPlikWej, cPlikWyj, cNIP, cImie, cNazwisko, cDataUr, cKwota, cEMail )

/*----------------------------------------------------------------------*/

FUNCTION amiJpkMicroWyslij( cPlikWej, lTestowa, cNrRef, nStatus, cStatusOpis )

   LOCAL nNrRefLen
   LOCAL nStatusOpisLen
   LOCAL nRes

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   hb_default( @cNrRef, Space( 128 ) )
   nNrRefLen := Len( cNrRef )
   hb_default( @cStatusOpis, Space( 4048 ) )
   nStatusOpisLen := Len( cStatusOpis )
   hb_default( @nStatus, 0 )

   nRes := hb_DynCall( { 'jpkMicroWyslij', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT, ;
      HB_DYN_CTYPE_INT, ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, ;
      cPlikWej, lTestowa, @cNrRef, @nNrRefLen, @nStatus, @cStatusOpis, @nStatusOpisLen )

   IF nRes == 0
      cNrRef := iif( nNrRefLen > 0, SubStr( cNrRef, 1, nNrRefLen ), '' )
      cStatusOpis := iif( nStatusOpisLen > 0, SubStr( cStatusOpis, 1, nStatusOpisLen ), '' )
   ELSE
      cRefId := ''
      cStatusOpis := ''
      nStatus := 0
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiJpkMicroPobierzUPO( cPlikUPO, cRefId, lBramkaTestowa, nStatus, cStatusOpis )

   LOCAL nRes, nStatusOpisLen := 4000

   IF Empty( amiDllH )
      cRefId := ''
      cStatusOpis := ''
      nStatus := 0
      RETURN 1
   ENDIF

   cStatusOpis := Space( nStatusOpisLen )

   nRes := hb_DynCall( {'jpkMicroPobierzUPO', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_BOOL,  ;
      HB_DYN_CTYPE_INT,  hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF16 ), ;
      HB_DYN_CTYPE_INT }, cPlikUPO, cRefId, lBramkaTestowa, @nStatus, ;
      @cStatusOpis, @nStatusOpisLen )

   IF nRes == 0
      cStatusOpis := iif( Len( cStatusOpis ) > 0, SubStr( cStatusOpis, 1, nStatusOpisLen ), '' )
   ELSE
      cStatusOpis := ''
      nStatus := 0
   ENDIF

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiSprawdzAktualizacje( lCzekaj )

   IF Empty( amiDllH )
      RETURN 5
   ENDIF

   RETURN hb_DynCall( { 'kliSprawdzAktualizacje', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      HB_DYN_CTYPE_BOOL }, lCzekaj )

/*----------------------------------------------------------------------*/

FUNCTION amiProcessMessages()

   LOCAL nRes

   IF Empty( amiDllH )
      RETURN NIL
   ENDIF

   nRes := hb_DynCall( { 'kliProcessMessages', amiDllH, HB_DYN_CALLCONV_STDCALL } )

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiInstalujLicencje()

   LOCAL nRes

   IF Empty( amiDllH )
      RETURN 3
   ENDIF

   cStopka = Space( 112 )
   nNrLic = 0

   nRes := hb_DynCall( { 'kliInstalujLicencje', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ) } )

   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION amiKlientKonfig( lSprAkt )

   IF Empty( amiDllH )
      RETURN 5
   ENDIF

   RETURN hb_DynCall( { 'kliKonfiguracja', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      HB_DYN_CTYPE_BOOL }, @lSprAkt )

/*----------------------------------------------------------------------*/

FUNCTION amiAktualizuj( lAuto )

   IF Empty( amiDllH )
      RETURN 5
   ENDIF

   RETURN hb_DynCall( { 'kliAktualizuj', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      HB_DYN_CTYPE_BOOL }, lAuto )

/*----------------------------------------------------------------------*/

PROCEDURE SprawdzAktualizacje( lCzekaj )

   LOCAL nRes
   LOCAL cEkr
   LOCAL cKolor

   IF lCzekaj
      cKolor := ColInf()
      @ 24, 0 SAY PadC( 'Sprawdzanie dost©pno˜ci aktualizacji...', 80, ' ' )
      SetColor( cKolor )
   ENDIF

   nRes := amiSprawdzAktualizacje( lCzekaj )

   IF lCzekaj
      SWITCH nRes
      CASE 0
         EXIT
      CASE 1
         Komun('Brak aktualizacji')
         EXIT
      CASE 2
         Komun( 'Bˆ¥d: ' + amiEdekBladTekst() )
         EXIT
      ENDSWITCH
      @ 24, 0
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION amiRest( cAdres, cContentType, cRequest, cMethod, cHeaders )

   LOCAL nRes

   IF Empty( amiDllH )
      RETURN 1
   ENDIF

   hb_default( @cContentType, "" )
   hb_default( @cRequest, "" )
   hb_default( @cMethod, "GET" )
   hb_default( @cHeaders, "" )

   RETURN hb_DynCall( { 'amiRest', amiDllH, ;
      hb_bitOr( HB_DYN_CTYPE_INT, HB_DYN_CALLCONV_STDCALL ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ), ;
      hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ) }, ;
      cAdres, cContentType, cRequest, cMethod, cHeaders )

/*----------------------------------------------------------------------*/

FUNCTION amiRestResponse()

   IF Empty( amiDllH )
      RETURN NIL
   ENDIF

   RETURN hb_DynCall( { 'amiRestResponse', amiDllH, ;
      hb_bitOr( hb_bitOr( HB_DYN_CTYPE_CHAR_PTR, HB_DYN_ENC_UTF8 ), HB_DYN_CALLCONV_STDCALL ) } )

/*----------------------------------------------------------------------*/

