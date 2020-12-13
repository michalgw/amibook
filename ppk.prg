/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2020  GM Systems Michaà Gawrycki (gmsystems.pl)

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

#include "hbclass.ch"
#include "Inkey.ch"

CREATE CLASS TPPK
HIDDEN:
   VAR aFirma        INIT NIL
   VAR aPracownicy   INIT {}
   VAR cXML          INIT ""
   VAR cMiesiac      INIT NIL

   METHOD WczytajDane( lPPKAktywni, cMiesiac )

   METHOD Pokaz( nRodzaj )
   METHOD WybierzPlik( cNazwa )

   METHOD XMLGeneruj( nRodzaj )
   METHOD XMLDodaj( cWiersz )
   METHOD XMLNaglowek()
   METHOD XMLKoniec()
   METHOD XMLUczestnicy()
   METHOD XMLUczestnicyKoniec()
   METHOD XMLUczestnik( nIndeks )
   METHOD XMLUczestnikKoniec()
   METHOD XMLZgloszenie( nIndeks )
   METHOD XMLSkladka( nIndeks )
   METHOD XMLKorSkladka( nIndeks )

EXPORTED:
   METHOD New()
   METHOD Wykonaj( nRodzaj )
   METHOD WykonajZglos() INLINE { ::Wykonaj( 1 ) }
   METHOD WykonajSkladka() INLINE { ::Wykonaj( 2 ) }
   METHOD WykonajKorSkladka() INLINE { ::Wykonaj( 3 ) }
ENDCLASS

METHOD WczytajDane( lPPKAktywni ) CLASS TPPK

   LOCAL aPrac

   hb_default( @lPPKAktywni, .T. )

   IF ! DostepPro( 'FIRMA', , .T., , 'FIRMA' )
      RETURN .F.
   ENDIF
   GO Val( ident_fir )

   ::aFirma := hb_Hash()
   ::aFirma[ 'id' ] := Val( ident_fir )
   ::aFirma[ 'nip' ] := StrTran( AllTrim( firma->nip ), '-', '' )
   ::aFirma[ 'regon' ] := SubStr( StrTran( ( AllTrim( SubStr( firma->nr_regon, 3 ) ) ), '-', '' ), 1, 9 )

   firma->( dbCloseArea() )

   IF ! DostepPro( 'PRAC', , .T., , 'PRAC' )
      RETURN .F.
   ENDIF
   prac->( dbGoTop() )
   prac->( dbSeek( '+' + ident_fir + '+') )

   IF HB_ISCHAR( ::cMiesiac )
      IF ! DostepPro( 'ETATY', , .T., , 'ETATY' )
         prac->( dbCloseArea() )
         RETURN .F.
      ENDIF
      etaty->( ordSetFocus( 2 ) )
   ENDIF

   DO WHILE ! prac->( Eof() ) .AND. prac->del == '+' .AND. prac->firma == ident_fir ;
      .AND. prac->status <= 'U' .AND. prac->ppk $ iif( lPPKAktywni, 'T', ' N' )

      aPrac := hb_Hash( 'wybrany', .F. )
      aPrac[ 'id' ] := prac->rec_no
      aPrac[ 'imie' ] := AllTrim( prac->imie1 )
      aPrac[ 'imie2' ] := AllTrim( prac->imie2 )
      aPrac[ 'nazwisko' ] := AllTrim( prac->nazwisko )
      aPrac[ 'plec' ] := iif( prac->plec $ 'MK', prac->plec, 'N' )
      aPrac[ 'pesel' ] := AllTrim( prac->pesel )
      aPrac[ 'data_urodzenia' ] := prac->data_ur
      aPrac[ 'rodzaj_dowodu' ] := prac->rodz_dok
      aPrac[ 'numer_dowodu' ] := prac->dowod_osob
      aPrac[ 'kraj' ] := iif( prac->dokidkraj == '  ', 'PL', prac->dokidkraj )
      aPrac[ 'kod_pocztowy' ] := AllTrim( prac->kod_poczt )
      aPrac[ 'poczta' ] := AllTrim( prac->poczta )
      aPrac[ 'miejscowosc' ] := AllTrim( prac->miejsc_zam )
      aPrac[ 'ulica' ] := AllTrim( prac->ulica )
      aPrac[ 'nr_domu' ] := AllTrim( prac->nr_domu )
      aPrac[ 'nr_mieszkania' ] := AllTrim( prac->nr_mieszk )
      aPrac[ 'pracodawca_dod_proc' ] := prac->ppkps2

      IF HB_ISCHAR( ::cMiesiac )
         etaty->( dbSeek( '+' + ident_fir + ::cMiesiac + Str( prac->rec_no, 5 ) ) )
         IF etaty->( Found() ) .AND. etaty->ppk == 'T'
            aPrac[ 'ppk' ] := .T.
            aPrac[ 'okres' ] := param_rok + '-' + StrTran( ::cMiesiac, ' ', '0' )
            aPrac[ 'wart_podst_pracownika' ] := etaty->ppkzk1
            aPrac[ 'wart_dodat_pracownika' ] := etaty->ppkzk2
            aPrac[ 'wart_podst_pracodawcy' ] := etaty->ppkpk1
            aPrac[ 'wart_dodat_pracodawcy' ] := etaty->ppkpk2
         ELSE
            aPrac[ 'ppk' ] := .F.
         ENDIF
      ENDIF

      AAdd( ::aPracownicy, aPrac )

      prac->( dbSkip() )
   ENDDO

   IF HB_ISCHAR( ::cMiesiac )
      etaty->( dbCloseArea() )
   ENDIF
   prac->( dbCloseArea() )

   RETURN .T.

METHOD Pokaz( nRodzaj ) CLASS TPPK

   LOCAL aTytuly := { "REJESTRACJA UCZESTNIKA PPK", "SKùADKA PPK", "KOREKTA SKùADKI PPK" }
   LOCAL cKolor, cEkran
   LOCAL nElem := 1
   LOCAL aNaglowki := { "Wybrany", "Nr.Ident.", "Nazwisko i imie" }
   LOCAL aBlokiKolumn := { ;
      { || iif( ::aPracownicy[ nElem ][ "wybrany" ], "Tak", "Nie" ) }, ;
      { || Str( ::aPracownicy[ nElem ][ 'id' ], 9 ) }, ;
      { || Pad( ::aPracownicy[ nElem ][ 'nazwisko' ] + ' ' + ::aPracownicy[ nElem ][ 'imie' ], 30 ) } }
   LOCAL bColorBlock := { | xVal |
      IF ::aPracownicy[ nElem ][ "wybrany" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aKlawisze := { ;
      { { K_SPACE, K_ENTER }, { | nElem, ar, b |
         ar[ nElem ][ 'wybrany' ] := ! ar[ nElem ][ 'wybrany' ]
      } }, ;
      { { Asc( 'Z' ), Asc( 'z' ) }, { ||
         AEval( ::aPracownicy, { | aEl | aEl[ 'wybrany' ] := .T. } )
      } }, ;
      { { Asc( 'N' ), Asc( 'n' ) }, { ||
         AEval( ::aPracownicy, { | aEl | aEl[ 'wybrany' ] := .F. } )
      } }, ;
      { K_F1, { ||
         WyswietlPomoc( { ;
            "                                            ", ;
            "    [Z].................zaznacz wszystko    ", ;
            "    [N].................odznacz wszystko    ", ;
            "    [E]..............utw¢rz plik XML PPK    ", ;
            "    [ESC]........................wyjòcie    ", ;
            "                                            " } )
      } }, ;
      { { Asc( 'E' ), Asc( 'e' ) }, { ||
         ::XMLGeneruj( nRodzaj )
      } } ;
   }
   LOCAL aBlokiKoloru := {}
   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   SAVE SCREEN TO cEkran
   cKolor := ColSta()
   @ 1, 47 SAY '[F1]-pomoc'
   ColStd()
   @ 3, 0 SAY PadC( "GENEROWANIE PLIKU PPK - " + aTytuly[ nRodzaj ], 80 )
   GM_ArEdit( 4, 0, 22, 79, ::aPracownicy, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, NIL, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru )
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN NIL

METHOD WybierzPlik( cNazwa ) CLASS TPPK

   RETURN ( cNazwa := win_GetSaveFileName( , , , 'xml', { {'Pliki XML', '*.xml'}, {'Wszystkie pliki', '*.*'} }, , , ;
         cNazwa ) ) <> ''

METHOD XMLGeneruj( nRodzaj ) CLASS TPPK

   LOCAL cPlik := "PPK_" + normalizujNazwe( AllTrim( symbol_fir ) ) + "_"
   LOCAL nWskPlik

   IF AScan( ::aPracownicy, { | aEl | aEl[ 'wybrany' ] } ) == 0
      Komun( 'Wybierz pracownik¢w' )
      RETURN
   ENDIF

   DO CASE
   CASE nRodzaj == 1
      cPlik := cPlik + "REJESTRACJA"
   CASE nRodzaj == 2
      cPlik := cPlik + "SKLADKA_" + param_rok + '_' + StrTran( ::cMiesiac, ' ', '0' )
   CASE nRodzaj == 3
      cPlik := cPlik + "KOREKTA_" + param_rok + '_' + StrTran( ::cMiesiac, ' ', '0' )
   ENDCASE

   cPlik := cPlik + '.xml'

   IF ! ::WybierzPlik( @cPlik )
      RETURN
   ENDIF

   IF Empty( cPlik )
      RETURN
   ENDIF

   ::cXML := ""

   ::XMLNaglowek()
   ::XMLUczestnicy()
   FOR nI := 1 TO Len( ::aPracownicy )
      IF ::aPracownicy[ nI ][ 'wybrany' ]
         ::XMLUczestnik( nI )
         DO CASE
         CASE nRodzaj == 1
            ::XMLZgloszenie( nI )
         CASE nRodzaj == 2
            ::XMLSkladka( nI )
         CASE nRodzaj == 3
            ::XMLKorSkladka( nI )
         ENDCASE
         ::XMLUczestnikKoniec()
      ENDIF
   NEXT
   ::XMLUczestnicyKoniec()
   ::XMLKoniec()

   nWskPlik := FCreate( cPlik )
   IF nWskPlik != -1
      FWrite( nWskPlik, ::cXML )
      FClose( nWskPlik )
      Komun( "  Utworzono plik XML PPK  " )
   ENDIF

   RETURN

METHOD XMLDodaj( cWiersz ) CLASS TPPK

   ::cXML := ::cXML + cWiersz + Chr( 13 ) + Chr( 10 )

   RETURN ::cXML

METHOD XMLNaglowek() CLASS TPPK

   ::XMLDodaj( '<?xml version="1.0" encoding="UTF-8"?><PPK wersja="1.0">' )
   ::XMLDodaj( '<PPK wersja="1.0">' )
   ::XMLDodaj( '  <WERSJA>GRUPA_PPK 2.00</WERSJA>' )
   ::XMLDodaj( '  <GENERACJA>' + hb_DToC( Date(), 'YYYY-MM-DDT' ) + ' ' + hb_TToC( hb_DateTime(), '', 'HH:MM:SS' ) + '</GENERACJA>' )

   ::XMLDodaj( '  <PRACODAWCA>' )
   ::XMLDodaj( '    <NIP>' + ::aFirma[ 'nip' ] + '</NIP>' )
   //::XMLDodaj( '    <REGON>' + ::aFirma[ 'regon' ] + '</REGON>' )
   ::XMLDodaj( '  </PRACODAWCA>' )

   RETURN NIL

METHOD XMLKoniec() CLASS TPPK

   ::XMLDodaj( '</PPK>' )

   RETURN NIL

METHOD XMLUczestnicy() CLASS TPPK

   ::XMLDodaj( '  <DANE_UCZESTNIKA>' )

   RETURN NIL

METHOD XMLUczestnicyKoniec() CLASS TPPK

   ::XMLDodaj( '  </DANE_UCZESTNIKA>' )

   RETURN NIL

METHOD XMLUczestnik( nIndeks ) CLASS TPPK

   ::XMLDodaj( '    <UCZESTNIK>' )
   ::XMLDodaj( '      <ID_KADRY>' + TNaturalny( ::aPracownicy[ nIndeks ][ 'id' ] ) + '</ID_KADRY>' )
   ::XMLDodaj( '      <IMIE>' + str2sxml( ::aPracownicy[ nIndeks ][ 'imie' ] ) + '</IMIE>' )
   IF ! Empty( ::aPracownicy[ nIndeks ][ 'imie2' ] )
      ::XMLDodaj( '      <IMIE2>' + str2sxml( ::aPracownicy[ nIndeks ][ 'imie2' ] ) + '</IMIE2>' )
   ENDIF
   ::XMLDodaj( '      <NAZWISKO>' + str2sxml( ::aPracownicy[ nIndeks ][ 'nazwisko' ] ) + '</NAZWISKO>' )
   ::XMLDodaj( '      <PLEC>' + ::aPracownicy[ nIndeks ][ 'plec' ] + '</PLEC>' )
   ::XMLDodaj( '      <OBYW>' + ::aPracownicy[ nIndeks ][ 'kraj' ] + '</OBYW>' )
   ::XMLDodaj( '      <NR_PESEL>' + ::aPracownicy[ nIndeks ][ 'pesel' ] + '</NR_PESEL>' )
   ::XMLDodaj( '      <DATA_UR>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_urodzenia' ] ) + '</DATA_UR>' )

   RETURN NIL

METHOD XMLUczestnikKoniec() CLASS TPPK

   ::XMLDodaj( '    </UCZESTNIK>' )

   RETURN NIL

METHOD XMLZgloszenie( nIndeks ) CLASS TPPK

   ::XMLDodaj( '      <REJESTRACJA>' )
   ::XMLDodaj( '        <ADR_ZAM_KRAJ>' + ::aPracownicy[ nIndeks ][ 'kraj' ] + '</ADR_ZAM_KRAJ>' )
   ::XMLDodaj( '        <ADR_ZAM_KOD_POCZ>' + ::aPracownicy[ nIndeks ][ 'kod_pocztowy' ] + '</ADR_ZAM_KOD_POCZ>' )
   ::XMLDodaj( '        <ADR_ZAM_POCZ>' + str2sxml( ::aPracownicy[ nIndeks ][ 'poczta' ] ) + '</ADR_ZAM_POCZ>' )
   ::XMLDodaj( '        <ADR_ZAM_MSC>' + str2sxml( ::aPracownicy[ nIndeks ][ 'miejscowosc' ] ) + '</ADR_ZAM_MSC>' )
   IF ! Empty( ::aPracownicy[ nIndeks ][ 'ulica' ] )
      ::XMLDodaj( '        <ADR_ZAM_ULICA>' + str2sxml( ::aPracownicy[ nIndeks ][ 'ulica' ] ) + '</ADR_ZAM_ULICA>' )
   ENDIF
   ::XMLDodaj( '        <ADR_ZAM_NR_DOMU>' + str2sxml( ::aPracownicy[ nIndeks ][ 'nr_domu' ] ) + '</ADR_ZAM_NR_DOMU>' )
   IF ! Empty( ::aPracownicy[ nIndeks ][ 'nr_mieszkania' ] )
      ::XMLDodaj( '        <ADR_ZAM_NR_MIESZ>' + str2sxml( ::aPracownicy[ nIndeks ][ 'nr_mieszkania' ] ) + '</ADR_ZAM_NR_MIESZ>' )
   ENDIF
   ::XMLDodaj( '        <FIR_SKL_DOD_PROCENT>' + TKwota2( ::aPracownicy[ nIndeks ][ 'pracodawca_dod_proc' ] ) + '</FIR_SKL_DOD_PROCENT>' )
   ::XMLDodaj( '      </REJESTRACJA>' )

   RETURN NIL

METHOD XMLSkladka( nIndeks ) CLASS TPPK

   IF ::aPracownicy[ nIndeks ][ 'ppk' ]
      ::XMLDodaj( '      <SKLADKA>' )
      ::XMLDodaj( '        <SKL_ZA_OKRES>' + ::aPracownicy[ nIndeks ][ 'okres' ] + '</SKL_ZA_OKRES>' )
      ::XMLDodaj( '        <UCZ_WAR_POD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_podst_pracownika' ] ) + '</UCZ_WAR_POD>' )
      ::XMLDodaj( '        <UCZ_WAR_DOD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_dodat_pracownika' ] ) + '</UCZ_WAR_DOD>' )
      ::XMLDodaj( '        <FIR_WAR_POD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_podst_pracodawcy' ] ) + '</FIR_WAR_POD>' )
      ::XMLDodaj( '        <FIR_WAR_DOD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_dodat_pracodawcy' ] ) + '</FIR_WAR_DOD>' )
      ::XMLDodaj( '        <UCZ_OBNIZ_SKL_POD>N</UCZ_OBNIZ_SKL_POD>' )
      ::XMLDodaj( '      </SKLADKA>' )
   ENDIF
   RETURN NIL

METHOD XMLKorSkladka( nIndeks ) CLASS TPPK

   IF ::aPracownicy[ nIndeks ][ 'ppk' ]
      ::XMLDodaj( '      <DANE_KOREKT>' )
      ::XMLDodaj( '        <KOREKTA>' )
      ::XMLDodaj( '          <SKL_ZA_OKRES>' + ::aPracownicy[ nIndeks ][ 'okres' ] + '</SKL_ZA_OKRES>' )
      ::XMLDodaj( '          <UCZ_WAR_POD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_podst_pracownika' ] ) + '</UCZ_WAR_POD>' )
      ::XMLDodaj( '          <UCZ_WAR_DOD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_dodat_pracownika' ] ) + '</UCZ_WAR_DOD>' )
      ::XMLDodaj( '          <FIR_WAR_POD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_podst_pracodawcy' ] ) + '</FIR_WAR_POD>' )
      ::XMLDodaj( '          <FIR_WAR_DOD>' + TKwota2( ::aPracownicy[ nIndeks ][ 'wart_dodat_pracodawcy' ] ) + '</FIR_WAR_DOD>' )
      ::XMLDodaj( '          <UCZ_OBNIZ_SKL_POD>N</UCZ_OBNIZ_SKL_POD>' )
      ::XMLDodaj( '        </KOREKTA>' )
      ::XMLDodaj( '      </DANE_KOREKT>' )
   ENDIF
   RETURN NIL

METHOD New() CLASS TPPK

   RETURN Self

METHOD Wykonaj( nRodzaj ) CLASS TPPK

   LOCAL nI
   LOCAL lTylkoPPK := .T.

   DO CASE
   CASE nRodzaj == 1
      ::cMiesiac := NIL
   CASE nRodzaj == 2 .OR. nRodzaj == 3
      ::cMiesiac := miesiac
   ENDCASE

   IF ! ::WczytajDane( lTylkoPPK )
      RETURN NIL
   ENDIF

   IF Len( ::aPracownicy ) == 0
      Komun( 'Brak pracownik¢w uczestnicz•cych w PPK' )
      RETURN NIL
   ENDIF

   ::Pokaz( nRodzaj )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE PPK_Zglos()

   LOCAL oPPK := TPPK():New()

   oPPK:WykonajZglos()
   oPPK := NIL

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE PPK_Skladka()

   LOCAL oPPK := TPPK():New()

   oPPK:WykonajSkladka()
   oPPK := NIL

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE PPK_KorSkladka()

   LOCAL oPPK := TPPK():New()

   oPPK:WykonajKorSkladka()
   oPPK := NIL

   RETURN NIL

