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
#include "Box.ch"
#include "hbgtinfo.ch"
#include "inkey.ch"
#include "memoedit.ch"
#include "hbcompat.ch"
#include "achoice.ch"

FUNCTION edekWeryfikuj( cZawartosc, cDeklaracja, lPlik, cNazwaOpcji, lPokazKomunSukces )

   LOCAL plikTmp, nazwaTmp, rezultat, powrot, cKomunikat
   LOCAL aOpcje := { "Przerwij", "Kopiuj komunikat" }

   hb_default( @lPlik, .F. )
   hb_default( @lPokazKomunSukces, .T. )

   IF HB_ISNIL( cNazwaOpcji )
      AAdd( aOpcje, "Zapisz plik mimo bˆ©du" )
   ELSE
      IF HB_ISCHAR( cNazwaOpcji ) .AND. Len( cNazwaOpcji ) > 0
         AAdd( aOpcje, cNazwaOpcji )
      ENDIF
   ENDIF

   IF lPlik
      nazwaTmp := cZawartosc
   ELSE
      plikTmp = hb_FTempCreate( , , , @nazwaTmp )
      FWrite( plikTmp, cZawartosc )
      FClose( plikTmp )
   ENDIF
//   rezultat = amiWeryfikujEDek(nazwaTmp, cDeklaracja)
   rezultat = amiEdekWeryfikuj( nazwaTmp )
   IF rezultat == 0
      IF lPokazKomunSukces
         komun( 'Weryfikacja: dokument jest poprawny', 5 )
      ENDIF
      powrot := 0
   ELSE
      cKomunikat := amiEdekBladTekst()
      powrot := 2
      DO WHILE powrot == 2
         powrot := Alert( 'Weryfikacja zakoäczona niepowodzeniem !;;' + cKomunikat, aOpcje, CColInf )
         DO CASE
            CASE powrot == 0 .OR. powrot == 1

            CASE powrot == 2
               hb_gtInfo( HB_GTI_CLIPBOARDDATA, rezultat )
               komun( 'Komunikat bˆ©du zostaˆ skopiowany do schowka.', 5 )
            CASE powrot == 3

         ENDCASE
      ENDDO
      powrot := powrot + 1
   ENDIF

   IF .NOT. lPlik
      FErase( nazwaTmp )
   ENDIF

   RETURN powrot

/*----------------------------------------------------------------------*/

FUNCTION naz_imie_imie(naz_imie)
   LOCAL imie, pozycja, pozkon
   imie = naz_imie

   pozycja = At( ',', naz_imie )
   IF pozycja > 0
      imie := AllTrim( SubStr( naz_imie, pozycja + 1 ) )
      pozkon = At(' ', imie)
      IF pozkon > 0
         imie = SubStr(imie, 1, pozkon - 1)
      ENDIF
   ELSE
      pozycja = At(' ', naz_imie)
      IF pozycja > 0
         imie = SubStr(naz_imie, pozycja + 1) //, Len(naz_imie) - pozycja)
         pozkon = At(' ', imie)
         IF pozkon > 0
            imie = SubStr(imie, 1, pozkon - 1)
         ENDIF
      ENDIF
   ENDIF
   RETURN imie

/*----------------------------------------------------------------------*/

FUNCTION naz_imie_naz(naz_imie)
   LOCAL naz, pozycja
   naz = naz_imie

   pozycja := At( ',', naz_imie )
   IF pozycja > 0
      naz := SubStr(naz_imie, 1, pozycja - 1)
   ELSE
      pozycja = At(' ', naz_imie)
      IF pozycja > 0
         naz = SubStr(naz_imie, 1, pozycja - 1)
      ENDIF
   ENDIF
   RETURN naz

/*----------------------------------------------------------------------*/

FUNCTION date2strxml(ddate)
   IF Empty( ddate )
      RETURN ''
   ELSE
      RETURN AllTrim(Str(Year(ddate))) + '-' + PadL(AllTrim(Str(Month(ddate))),2,'0') + '-' + PadL(AllTrim(Str(Day(ddate))),2,'0')
   ENDIF

/*----------------------------------------------------------------------*/

FUNCTION datetime2strxml(dDate)
   RETURN hb_DToC(dDate, 'YYYY-MM-DDT') + 'T' + hb_TToC(hb_DateTime(), '', 'HH:MM:SS')

/*----------------------------------------------------------------------*/

FUNCTION trimnip(anip)
   RETURN StrTran(StrTran(AllTrim(anip), '-'), ' ')

/*----------------------------------------------------------------------*/

FUNCTION TKwota2(akwota)
   RETURN StrTran(AllTrim(Transform(akwota, '999999999.99')), ',', '.')

/*----------------------------------------------------------------------*/

FUNCTION TIlosciJPK( nIlosc )
   RETURN StrTran( AllTrim( Transform( nIlosc, '999999999.999') ), ',', '.' )

/*----------------------------------------------------------------------*/

FUNCTION TKwotaC(akwota)
   RETURN AllTrim(Transform(akwota, '999999999'))

/*----------------------------------------------------------------------*/

FUNCTION TKwota2Nieujemna(akwota)
   IF akwota < 0
      akwota = 0
   ENDIF
   RETURN TKwota2(akwota)

/*----------------------------------------------------------------------*/

FUNCTION TKwotaCNieujemna(akwota)
   IF akwota < 0
      akwota = 0
   ENDIF
   RETURN TKwotaC(akwota)

/*----------------------------------------------------------------------*/

FUNCTION TNaturalny(awartosc)
   RETURN AllTrim(Transform(awartosc, '999999999'))

/*----------------------------------------------------------------------*/

FUNCTION TProcentowy( nWartosc )
   RETURN StrTran( AllTrim( Transform( nWartosc, '999.99' ) ), ',', '.' )

/*----------------------------------------------------------------------*/

FUNCTION xmlNiePusty(xWartosc, cTekst)
   LOCAL lRes := .F.
   DO CASE
      CASE HB_ISNUMERIC(xWartosc)
         IF xWartosc <> 0
            lRes := .T.
         ENDIF
      CASE HB_ISSTRING(xWartosc)
         IF Len(xWartosc) > 0
            lRes := .T.
         ENDIF
   ENDCASE
   RETURN iif(lRes, cTekst, '')

/*----------------------------------------------------------------------*/

FUNCTION str2sxml(cStr, lKonwUTF8)
   LOCAL cRes
   IF !HB_ISSTRING(cStr)
      RETURN ''
   ENDIF
   hb_default( @lKonwUTF8, .T. )
   //cRes := StrTran( AllTrim( cStr ), '"', '&#34;' /* '&quot;' */ )
   //cRes := StrTran(cRes, "'", '&#39;' /* '&apos;' */ )
   cRes := StrTran( AllTrim( cStr ), '<', '&#60;' /* '&lt;' */ )
   //cRes := StrTran(cRes, '>', '&#62;' /* '&gt;' */ )
   cRes := StrTran(cRes, '&', '&#38;' /* '&amp;' */ )
   RETURN iif( lKonwUTF8, hb_StrToUTF8(cRes), cRes )

/*----------------------------------------------------------------------*/

FUNCTION bool2sxml( lWartosc )

   RETURN iif( HB_ISLOGICAL( lWartosc ) .AND. lWartosc, 'true', 'false' )

/*----------------------------------------------------------------------*/

FUNCTION UnescapeXMLUTF8( cSource )

   LOCAL cResult, cBuf, cBuf2, i, nState, cChar

   nState := 1
   cResult := ''
   cBuf := ''
   cBuf2 := ''

   FOR i := 1 TO hb_utf8Len( cSource )
      cChar := hb_utf8SubStr( cSource, i, 1 )
      DO CASE
      CASE nState == 1
         IF cChar == '&'
            nState := 2
            cBuf2 := cBuf2 + cChar
         ELSE
            cResult := cResult + cChar
         ENDIF
      CASE nState == 2
         IF cChar == '#'
            nState := 3
            cBuf2 := cBuf2 + cChar
            cBuf := ''
         ELSE
            nState := 1
            cResult := cResult + cBuf2 + cChar
            cBuf2 := ''
         ENDIF
      CASE nState == 3
         IF cChar $ '0123456789ABCDEFabcdefx'
            cBuf := cBuf + cChar
            cBuf2 := cBuf2 + cChar
         ELSEIF cChar == ';'
            cResult := cResult + hb_utf8Chr( iif( hb_utf8SubStr( cBuf, 1, 1 ) == 'x', HexaToDec( SubStr( cBuf, 2 ) ), Val( cBuf ) ) )
            cBuf := ''
            cBuf2 := ''
            nState := 1
         ELSE
            cResult := cResult + cBuf2
            cBuf := ''
            cBuf2 := ''
            nState := 1
         ENDIF
      ENDCASE
   NEXT

   IF nState <> 1
      cResult := cResult + cBuf2
   ENDIF

   RETURN cResult

/*----------------------------------------------------------------------*/

FUNCTION sxml2str(cStr)
   LOCAL cRes
   IF !HB_ISSTRING(cStr)
      RETURN ''
   ENDIF
   cRes := hb_UTF8ToStr( UnescapeXMLUTF8( cStr ) )
   cRes := StrTran(cRes, '&quot;', '"')
   cRes := StrTran(cRes, '&apos;', "'")
   cRes := StrTran(cRes, '&lt;', '<')
   cRes := StrTran(cRes, '&gt;', '>')
   cRes := StrTran(cRes, '&amp;', '&')
   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION sxml2num( cStr, xDefVal )
   LOCAL xRes
   IF xDefVal == NIL
      xDefVal := ''
   ENDIF
   xRes := xDefVal
   IF HB_ISSTRING(cStr) .AND. Len(AllTrim(cStr)) > 0
      xRes := Val(cStr)
   ENDIF
   RETURN xRes

/*----------------------------------------------------------------------*/

FUNCTION sxml2date( cStr )

   RETURN hb_CToD( cStr, "YYYY-MM-DD" )

/*----------------------------------------------------------------------*/

FUNCTION sxml2bool( cStr )

   RETURN Lower( AllTrim( cStr ) ) == "true"

/*----------------------------------------------------------------------*/

FUNCTION sxmlTrim( cStr )

   LOCAL cRes := AllTrim( cStr )

   cRes := StrTran( StrTran( cRes, Chr( 13 ), ' ' ), Chr( 10 ), ' ' )
   DO WHILE At( '  ', cRes ) > 0
      cRes := StrTran( cRes, '  ', ' ' )
   ENDDO

   RETURN cRes

/*----------------------------------------------------------------------*/

FUNCTION edekZapiszXml(azawartosc, anazwapliku, awyslij, cDeklaracja, lKorekta, nMiesiac, nOsoba)

   LOCAL f, v, cTmpNF, cCzyWyslac, nCzyWer, lCzyWer := .F.
   LOCAL lJpk := Upper( SubStr( cDeklaracja, 1, 3 ) ) == 'JPK'

   IF lJpk
      IF param_ejmo == 'W'
         RETURN edekZapiszWewn(azawartosc, cDeklaracja, lKorekta, nMiesiac, nOsoba)
      ENDIF
   ELSE
      IF param_edmo == 'W'
         RETURN edekZapiszWewn(azawartosc, cDeklaracja, lKorekta, nMiesiac, nOsoba)
      ENDIF
   ENDIF

   IF (param_edpv == 'T') .OR. (param_edpv == 'P')
      IF (param_edpv == 'P')
         nCzyWer := TNEsc(.T. ,'Czy weryfikowa† eDeklaracj©? (T/N)')
         DO CASE
            CASE nCzyWer == 27
               RETURN .F.
            CASE Upper(Chr(nCzyWer)) == 'N'
               lCzyWer := .F.
            CASE Upper(Chr(nCzyWer)) == 'T'
               lCzyWer := .T.
         ENDCASE
      ELSE
         lCzyWer := .T.
      ENDIF
      IF lCzyWer
         ColSta()
         @ 24, 0
         @ 24, 0 SAY PadC('Weryfikacja deklaracji... Prosz© czeka†...', 80)
         v = edekWeryfikuj(azawartosc, cDeklaracja)
         ColStd()
         @ 24, 0
         IF v == 1 .OR. v == 2 .OR. v == 3
            RETURN .F.
         ENDIF
      ENDIF
   ENDIF

   IF lJpk
      IF ( cTempNF := win_GetSaveFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} }, , , ;
         anazwapliku ) ) <> ''
         f := FCreate(cTempNF)
         IF f != -1
            FWrite(f, azawartosc)
            FClose(f)
            komun('Utworzono plik JPK')
         ENDIF
      ENDIF

      RETURN .T.
   ENDIF

   IF param_edpz == 'T'
      cTmpNF = PadR(anazwapliku, 250)
      ColStd()
      @ 24, 0
      @ 24, 0 SAY 'Nazwa pliku ' GET cTmpNF PICTURE '@AS67' VALID {|oGet| Len(AllTrim(cTmpNF)) > 0 }
      read_()
      IF LastKey() = 27
         RETURN .F.
      ENDIF
   ENDIF

   IF !IsDir(AllTrim(param_edka))
      MakeDir(AllTrim(param_edka))
   ENDIF
   IF !IsDir(AllTrim(param_edka))
      Alert('Nie udaˆo si© utworzy† katalogu. Sprawd« konfiguracj© eDeklaracji.')
      RETURN .F.
   ENDIF
   f = FCreate(DodajBackslash(AllTrim(param_edka)) + AllTrim(anazwapliku) + '.xml')
   FWrite(f, azawartosc)
   FClose(f)

   cCzyWyslac = 'N'
   IF param_edpw = 'P' .AND. Len(AllTrim(param_edpr)) > 0
      @ 24,0
      @ 24, 1 SAY 'Czy wysˆa† deklaracj©? (Tak / Nie) ' get cCzyWyslac PICTURE '!' VALID {|oGet| cCzyWyslac#'TN' }
      read_()
      IF LastKey() = 27 .OR. cCzyWyslac == 'N'
         RETURN .F.
      ENDIF

      IF amiZnajdzPokazProces(HB_FNameNameExt(AllTrim(param_edpr))) == 1

      ELSE
         WAPI_SHELLEXECUTE(0, 0, AllTrim(param_edpr), 0, AllTrim(hb_FNameDir(param_edpr)), 1)
      ENDIF

   ENDIF

   IF param_dzw='T'
      tone(500,3)
   ENDIF
   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekZapiszWewn(cZawartosc, cSymbol, lKorekta, nMiesiac, nOsoba)
   LOCAL nID, nFile, lRes, oEdek
   hb_default(@nMiesiac, 0)
   hb_default(@nOsoba, 0)
   hb_default(@lKorekta, .F.)
   ColSta()
   @ 24, 0
   @ 24, 0 SAY PadC('Weryfikacja deklaracji... Prosz© czeka†...', 80)
   IF edekWeryfikuj(cZawartosc, cSymbol, , "", .F.) <> 0
      ColStd()
      @ 24, 0
      RETURN .F.
   ENDIF
   ColStd()
   @ 24, 0
   IF !DostepPro('EDEKLAR')
      RETURN .F.
   ENDIF
   setind('EDEKLAR')
   edeklar->(dbAppend())
   edeklar->firma := ident_fir
   edeklar->korekta := lKorekta
   edeklar->rodzaj := cSymbol
   IF nMiesiac > 0
      edeklar->miesiac := Str(nMiesiac, 2, 0)
   ENDIF
   IF nOsoba > 0
      edeklar->osoba := Str(nOsoba, 3, 0)
   ENDIF
   edeklar->utworzono := hb_DateTime()
   edeklar->(dbCommit())
   nID := edeklar->id
   IF !File('XML')
      dirmake('XML')
   ENDIF
   nFile := FCreate('XML\' + StrTran(Str(nID, 6, 0) , ' ', '0') + '.xml')
   IF nFile != -1
      FWrite(nFile, cZawartosc)
      FClose(nFile)
      lRes := .T.
   ELSE
      edeklar->(dbDelete())
      lRes := .F.
   ENDIF
   edeklar->(dbCloseArea())

   IF lRes
      IF TNEsc(.F., 'Utworzono eDeklaracj©. Czy przej˜† do listy eDeklaracji? (Tak/Nie)')
         oEdek := TEDeklaracje():New(nOsoba == 0)
         oEdek:Uruchom(nID)
         oEdek := NIL
      ENDIF
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION edekInicjuj()
      czy_edeklaracja = .T.
      rob_edeklaracja = .F.
      IF param_edpw == 'T'
         wys_edeklaracja = .T.
      ELSE
         wys_edeklaracja = .F.
      ENDIF
      edeklaracja_plik = ''
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekKoncz()
      czy_edeklaracja = .F.
      rob_edeklaracja = .F.
      wys_edeklaracja = .F.
      edeklaracja_plik = ''
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekNipUE(cNip)
   RETURN StrTran(cNip, ' ')

/*----------------------------------------------------------------------*/

FUNCTION edekOrdZuTrescMemo(nMode)
   IF (nMode == ME_UNKEY .OR. nMode == ME_UNKEYX) .AND. (LastKey() == K_ESC)
      lAnuluj := .T.
   ENDIF
   RETURN ME_DEFAULT

/*----------------------------------------------------------------------*/

FUNCTION edekOrdZuTrescPobierz(cSymbol, nID1, nID2)
   LOCAL cTresc := '', xScr
   PRIVATE lAnuluj := .F.
   cTresc := edekWczytajTrescKor(cSymbol, nID1, nID2)
   SAVE SCREEN TO xScr
   //ColPro()
   SET COLOR TO +W
   @ 3, 5, 22, 74 BOX B_SINGLE + Space(1)
   @ 20, 6, 20, 73 BOX B_SINGLE + Space(1)
   center(3, ' Tre˜† uzasadnienia korekty ')
   center(21, ' Zatwierdzenie - Alt-W      |      Anulowanie - ESC ')
   cTresc := MemoEdit(cTresc, 4, 6, 19, 73, .T., 'edekOrdZuTrescMemo')
   IF !lAnuluj .AND. Len(AllTrim(cTresc)) > 0
      edekZapiszTrescKor(cSymbol, nID1, nID2, cTresc)
   ENDIF
   RESTORE SCREEN FROM xScr
   RETURN iif(lAnuluj, .F., cTresc)

/*----------------------------------------------------------------------*/

FUNCTION edekCzyKorekta( nRow, nCol )
   LOCAL cRes := 'D', xScr, nRes, cKolor

   hb_default( @nRow, 10 )
   hb_default( @nCol, 22 )

   SAVE SCREEN TO xScr
   cKolor := ColPro()
   @ nRow, nCol, nRow + 2, nCol + 36 BOX B_SINGLE + Space(1)
   @ nRow + 1, nCol + 2 SAY 'Deklaracja czy korekta? (D/K): ' GET cRes PICTURE '!' VALID {|cV| cRes $ 'DK'}
   CLEAR TYPE
   read_()
   RESTORE SCREEN FROM xScr
   IF LastKey() <> K_ESC
      IF cRes == 'K'
         nRes := 2
      ELSE
         nRes := 1
      ENDIF
   ELSE
      nRes := 0
   ENDIF
   SetColor( cKolor )
   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION edekRodzajKorekty( nRow, nCol )
   LOCAL xScr, nRes := 1, cKolor

   hb_default( @nRow, 10 )
   hb_default( @nCol, 22 )

   SAVE SCREEN TO xScr
   cKolor := ColPro()
   @ nRow, nCol, nRow + 8, nCol + 36 BOX B_SINGLE + Space(1)
   @ nRow + 1, nCol + 2 SAY '        Rodzaj korekty  (1/2): ' GET nRes PICTURE '9' VALID {|cV| nRes == 1 .OR. nRes == 2 }
   @ nRow + 3, nCol + 2 SAY '1 - korekta dekl., o kt¢rej mowa'
   @ nRow + 4, nCol + 2 SAY '    w art. 81 Ordynacji podat.'
   @ nRow + 5, nCol + 2 SAY '2 - korekta dekl. skˆadana w toku'
   @ nRow + 6, nCol + 2 SAY '    post©powania w spr. unikania'
   @ nRow + 7, nCol + 2 SAY '    opodatkowania - art.81b p.1a'
   CLEAR TYPE
   read_()
   RESTORE SCREEN FROM xScr
   IF LastKey() == K_ESC
      nRes := 0
   ENDIF
   SetColor( cKolor )
   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION edekWczytajTrescKor(cSymbol, nID1, nID2)
   LOCAL cTresc := '', cWarunekSeek := ''
   hb_default(@nID1, 0)
   hb_default(@nID2, 0)
   SELECT 120
   IF dostep('TRESCKOR')
      setind('TRESCKOR')
      cWarunekSeek := PadR(cSymbol, 16) + Str(nID1, 6) + Str(nID2, 6)
      TRESCKOR->(dbSeek(cWarunekSeek))
      IF TRESCKOR->(Found())
         cTresc := TRESCKOR->TRESC
      ENDIF
   ENDIF
   TRESCKOR->(dbCloseArea())
   RETURN cTresc

/*----------------------------------------------------------------------*/

FUNCTION edekZapiszTrescKor(cSymbol, nID1, nID2, cTresc)
   LOCAL cWarunekSeek := ''
   hb_default(@nID1, 0)
   hb_default(@nID2, 0)
   SELECT 120
   IF dostep('TRESCKOR')
      setind('TRESCKOR')
      cWarunekSeek := PadR(cSymbol, 16) + Str(nID1, 6) + Str(nID2, 6)
      TRESCKOR->(dbSeek(cWarunekSeek))
      IF TRESCKOR->(Found())
         blokadar()
         TRESCKOR->TRESC := cTresc
         COMMIT
         UNLOCK
      ELSE
         TRESCKOR->(dbAppend())
         TRESCKOR->SYMBOL := cSymbol
         TRESCKOR->ID1 := nID1
         TRESCKOR->ID2 := nID2
         TRESCKOR->TRESC := cTresc
         TRESCKOR->(dbCommit())
      ENDIF
   ENDIF
   TRESCKOR->(dbCloseArea())
   RETURN

/*----------------------------------------------------------------------*/

FUNCTION edekWybierzCertyfikat()
   LOCAL lRes := .F., aPozycje := {}, nIlosc := 0, nI, cCert, nWybor, cScr, cKolor
   nIlosc := amiEdekCertyfikatIlosc()
   FOR nI := 1 TO nIlosc
      cScr := amiEdekCertyfikatDane(nI - 1, 3)
      cCert := amiEdekCertyfikatDane(nI - 1, 1) + ' (do ' + SubStr(cScr, 1, 4) + '-' + SubStr(cScr, 5, 2) + '-' + SubStr(cScr, 7, 2) + ')'
      AAdd(aPozycje, cCert)
   NEXT
   IF Len(aPozycje) > 0
      SAVE SCREEN TO cScr
      cKolor := ColPro()
      @ 3, 8 CLEAR TO 21, 70
      @ 3, 8 SAY PadC('Wyb¢r certyfikatu', 62)
      @ 21, 8 SAY PadC('ENTER - wyb¢r        I - informacja o ceryfikacie', 62)
      @ 4, 8, 20, 70 BOX B_SINGLE
      nWybor := AChoice(5, 9, 19, 69, aPozycje, ,'edekWybierzCertyfikatAChoice')
      IF nWybor > 0
         aWybranyCertyfikat['wybrany'] := .T.
         aWybranyCertyfikat['indeks'] := nWybor - 1
         aWybranyCertyfikat['nazwa'] := amiEdekCertyfikatDane(nWybor - 1, 1)
         aWybranyCertyfikat['od'] := amiEdekCertyfikatDane(nWybor - 1, 2)
         aWybranyCertyfikat['do'] := amiEdekCertyfikatDane(nWybor - 1, 3)
         aWybranyCertyfikat['serialno'] := amiEdekCertyfikatDane(nWybor - 1, 4)
         lRes := .T.
      ENDIF
      RESTORE SCREEN FROM cScr
      SetColor(cKolor)
   ENDIF
   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION edekWybierzCertyfikatAChoice(nMode, nCurElement, nRowPos)
   LOCAL nKey := LastKey(), nRes := AC_CONT
   DO CASE
      CASE nKey == Asc('I') .OR. nKey == Asc('i')
         ZablokujEkran('Informacje o certyfikacjie...')
         amiEdekCertyfikatPokaz(nCurElement - 1)
         OdblokujEkran()
      CASE nKey == K_ESC
         nRes := AC_ABORT
      CASE nKey == K_ENTER
         nRes := AC_SELECT
   ENDCASE
   RETURN nRes

/*----------------------------------------------------------------------*/

FUNCTION edekCzyDoraznie( cRodzaj )

   LOCAL lRes := .F.

   IF SubStr( cRodzaj, 1, 6 ) == 'JPKKPR'
      lRes := .T.
   ELSEIF SubStr( cRodzaj, 1, 6 ) == 'JPKEWP'
      lRes := .T.
   ENDIF

   RETURN lRes

/*----------------------------------------------------------------------*/

FUNCTION edekPodpiszDeklaracje( cPlikWej, cPlikWyj, cRodzaj )

   LOCAL nRes := 0

   IF ! File( cPlikWej )
      RETURN .F.
   ENDIF

   IF ! aWybranyCertyfikat[ 'wybrany' ]
      IF ! edekWybierzCertyfikat()
         RETURN .F.
      ENDIF
   ENDIF

   IF Upper( SubStr( cRodzaj, 1, 3 ) ) == 'JPK'
      nRes := amiJpkPodpisz2( cPlikWej, aWybranyCertyfikat[ 'indeks' ], param_ejts == 'T', edekCzyDoraznie( cRodzaj ), aWybranyCertyfikat[ 'serialno' ] )
   ELSE
      nRes := amiEdekPodpisz( cPlikWej, cPlikWyj, aWybranyCertyfikat[ 'indeks' ], aWybranyCertyfikat[ 'serialno' ] )
   ENDIF

   IF nRes <> 0
      Alert( 'Nie udaˆo si© podpisa† pliku: ' + amiEdekBladTekst(), { "Zamknij" } )
      RETURN .F.
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekPodpiszDeklaracjeAut( cPlikWej, cPlikWyj, cNIP, cImie, cNazwisko, dDataUr, nKwota, cRodzaj )

   LOCAL nRes

   IF !File( cPlikWej )
      RETURN .F.
   ENDIF

   IF Upper( SubStr( cRodzaj, 1, 3 ) ) == 'JPK'
      nRes := amiJpkPodpiszAut( cPlikWej, param_ejts == 'T', edekCzyDoraznie( cRodzaj ), ;
         trimnip( cNIP ), AllTrim( cImie ), AllTrim( cNazwisko ), date2strxml( dDataUr ), ;
         TKwota2( nKwota ) )
   ELSE
      nRes := amiEdekPodpiszAut( cPlikWej, cPlikWyj, trimnip( cNIP ), AllTrim( cImie ), ;
         AllTrim( cNazwisko ), date2strxml( dDataUr ), TKwota2( nKwota ) )
   ENDIF

   IF nRes <> 0
      Alert( 'Nie udaˆo si© podpisa† pliku: ' + amiEdekBladTekst(), { "Zamknij" } )
      RETURN .F.
   ENDIF

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION edekNazwaPliku(nNrID, cRozszezenie)
   hb_default(@cRozszezenie, '.xml')
   RETURN 'XML\' + StrTran(Str(edeklar->id, 6, 0), ' ', '0') + cRozszezenie

/*----------------------------------------------------------------------*/

FUNCTION xmlUsunNamespace( cWartosc )

   RETURN SubStr( cWartosc, At( ':', cWartosc ) + 1 )

/*----------------------------------------------------------------------*/

FUNCTION NrDokUsunHasz( cNrDok )

   LOCAL cRes

   IF SubStr( cNrDok, 1, 1 ) == '#'
      cRes := SubStr( cNrDok, 2 )
   ELSE
      cRes := cNrDok
   ENDIF

   RETURN cRes

/*----------------------------------------------------------------------*/


