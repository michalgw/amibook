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
   METHOD EdytujDeklaracje( nIndeks )
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
   METHOD XMLDeklaracja( nIndeks )
   METHOD XMLZwolnienie( nIndeks )
EXPORTED:
   METHOD New()
   METHOD Wykonaj( nRodzaj )
   METHOD WykonajZglos() INLINE { ::Wykonaj( 1 ) }
   METHOD WykonajSkladka() INLINE { ::Wykonaj( 2 ) }
   METHOD WykonajKorSkladka() INLINE { ::Wykonaj( 3 ) }
   METHOD WykonajDeklaracja() INLINE { ::Wykonaj( 4 ) }
   METHOD WykonajZwolnienie() INLINE { ::Wykonaj( 5 ) }
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

   ::aFirma[ 'exp_id' ] := firma->ppkeidkadr == 'T'
   ::aFirma[ 'exp_id_eppk' ] := firma->ppkeideppk == 'T'
   ::aFirma[ 'exp_id_pzif' ] := firma->ppkeidpzif == 'T'

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

   DO WHILE ! prac->( Eof() ) .AND. prac->del == '+' .AND. prac->firma == ident_fir
      IF prac->status $ 'EU' .AND. prac->ppk $ iif( lPPKAktywni, 'T', ' N' )
         aPrac := hb_Hash( 'wybrany', .F. )
         aPrac[ 'id' ] := iif( Len( AllTrim( prac->ppkidkadr ) ) == 0, AllTrim( Str( prac->rec_no ) ), AllTrim( prac->ppkidkadr ) )
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

         aPrac[ 'data_dek' ] := Date()
         aPrac[ 'rezygnacja' ] := .F.
         aPrac[ 'wznowienie' ] := .F.
         aPrac[ 'wznowienie4' ] := .F.
         aPrac[ 'zmiana_pod' ] := .F.
         aPrac[ 'zmiana_dod' ] := .F.
         aPrac[ 'zmiana_pod_stawka' ] := prac->ppkzs1
         aPrac[ 'zmiana_dod_stawka' ] := prac->ppkzs2

         aPrac[ 'zwolnienie' ] := .F.
         aPrac[ 'data_zwolnienia' ] := prac->data_zwol

         aPrac[ 'id_eppk' ] := AllTrim( prac->ppkideppk )
         aPrac[ 'id_pzif' ] := AllTrim( prac->ppkidpzif )

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
      ENDIF
      prac->( dbSkip() )
   ENDDO

   IF HB_ISCHAR( ::cMiesiac )
      etaty->( dbCloseArea() )
   ENDIF
   prac->( dbCloseArea() )

   RETURN .T.

METHOD Pokaz( nRodzaj ) CLASS TPPK

   LOCAL aTytuly := { "REJESTRACJA UCZESTNIKA PPK", "SKùADKA PPK", "KOREKTA SKùADKI PPK", ;
      "DEKLARACJE UCZESTNIKA PPK", "ZAKO„CZENIE ZATRUDNIENIAPRACOWNIKA PPK" }
   LOCAL cKolor, cEkran
   LOCAL nElem := 1
   LOCAL aNaglowki := { "Wybrany", "Nr.Ident.", "Nazwisko i imie" }
   LOCAL aBlokiKolumn := { ;
      { || iif( ::aPracownicy[ nElem ][ "wybrany" ], "Tak", "Nie" ) }, ;
      { || Pad( SubStr( ::aPracownicy[ nElem ][ 'id' ], 9 ), 9 ) }, ;
      { || Pad( SubStr( ::aPracownicy[ nElem ][ 'nazwisko' ] + ' ' + ::aPracownicy[ nElem ][ 'imie' ], 1, 25 ), 25 ) } }
   LOCAL bColorBlock := { | xVal |
      IF ::aPracownicy[ nElem ][ "wybrany" ]
         RETURN { 1, 2 }
      ELSE
         RETURN { 6, 2 }
      ENDIF
   }
   LOCAL aKlawisze := { ;
      { { Asc( 'Z' ), Asc( 'z' ), K_SPACE }, { | nElem, ar, b |
         ar[ nElem ][ 'wybrany' ] := ! ar[ nElem ][ 'wybrany' ]
      } }, ;
      { { Asc( 'W' ), Asc( 'w' ) }, { ||
         AEval( ::aPracownicy, { | aEl | aEl[ 'wybrany' ] := .T. } )
      } }, ;
      { { Asc( 'N' ), Asc( 'n' ) }, { ||
         AEval( ::aPracownicy, { | aEl | aEl[ 'wybrany' ] := .F. } )
      } }, ;
      { K_F1, { ||
         LOCAL aPomoc := { ;
            "                                                    ", ;
            "    [Z]/[SPACJA].................zaznacz/odznacz    ", ;
            "    [W].........................zaznacz wszystko    ", ;
            "    [N].........................odznacz wszystko    ", ;
            "    [E]......................utw¢rz plik XML PPK    ", ;
            "    [ESC]................................wyjòcie    ", ;
            "                                                    " }
         DO CASE
         CASE nRodzaj == 1 .OR. nRodzaj == 2 .OR. nRodzaj == 3 .OR. nRodzaj == 5
            hb_AIns( aPomoc, 2, "    [ENTER]......................zaznacz/odznacz    ", .T. )
         CASE nRodzaj == 4
            hb_AIns( aPomoc, 2, "    [ENTER]............edytuj pozycj© deklaracji    ", .T. )
         ENDCASE
         WyswietlPomoc( aPomoc )
      } }, ;
      { { Asc( 'E' ), Asc( 'e' ) }, { ||
         ::XMLGeneruj( nRodzaj )
      } } ;
   }
   LOCAL aBlokiKoloru := {}

   DO CASE
   CASE nRodzaj == 1 .OR. nRodzaj == 2 .OR. nRodzaj == 3 .OR. nRodzaj == 5
      AAdd( aKlawisze, { K_ENTER, { | nElem, ar, b |
         ar[ nElem ][ 'wybrany' ] := ! ar[ nElem ][ 'wybrany' ]
      } } )
   CASE nRodzaj == 4
      AAdd( aNaglowki, "Data deklaracji" )
      AAdd( aNaglowki, "Deklaracje" )

      AAdd( aBlokiKolumn, { || Pad( DToS( ::aPracownicy[ nElem ][ 'data_dek' ] ) ) } )
      AAdd( aBlokiKolumn, { || Pad( ;
         iif( ::aPracownicy[ nElem ][ 'rezygnacja' ], "Rezygnacja ", "" ) + ;
         iif( ::aPracownicy[ nElem ][ 'wznowienie' ], "Wznowienie ", "" ) + ;
         iif( ::aPracownicy[ nElem ][ 'wznowienie4' ], "Wznow. po 4 latach ", "" ) + ;
         iif( ::aPracownicy[ nElem ][ 'zmiana_pod' ], "Zmiana skà. podst. ", "" ) + ;
         iif( ::aPracownicy[ nElem ][ 'zmiana_dod' ], "Zmiana skà. dodat.", "" ),25 ) } )

      AAdd( aKlawisze, { K_ENTER, { | nElem, ar, b |
         ::EdytujDeklaracje( nElem )
      } } )
   ENDCASE

   AEval( aBlokiKolumn, { || AAdd( aBlokiKoloru, bColorBlock ) } )

   SAVE SCREEN TO cEkran
   cKolor := ColSta()
   @ 1, 47 SAY '[F1]-pomoc'
   ColStd()
   @ 3, 0 SAY PadC( "GENEROWANIE PLIKU PPK - " + aTytuly[ nRodzaj ], 80 )
   GM_ArEdit( 4, 0, 22, 79, ::aPracownicy, @nElem, aNaglowki, aBlokiKolumn, NIL, NIL, { || .F. }, aKlawisze, SetColor() + ",N+/N", aBlokiKoloru )
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN NIL

METHOD EdytujDeklaracje( nIndeks ) CLASS TPPK

   LOCAL cRezyg, cWznow, cWznow4, cZmPod, cZmDod
   LOCAL dData
   LOCAL nProcPod, nProcDod
   LOCAL cEkran, cKolor
   LOCAL bWyswietlTn := { | nIndeks |
      LOCAL cKolor := SetColor( 'W' )
      DO CASE
      CASE nIndeks == 1
         @ 11, 53 SAY iif( cRezyg == 'T', 'ak', 'ie' )
      CASE nIndeks == 2
         @ 12, 53 SAY iif( cWznow == 'T', 'ak', 'ie' )
      CASE nIndeks == 3
         @ 13, 53 SAY iif( cWznow4 == 'T', 'ak', 'ie' )
      CASE nIndeks == 4
         @ 14, 53 SAY iif( cZmPod == 'T', 'ak', 'ie' )
      CASE nIndeks == 5
         @ 16, 53 SAY iif( cZmDod == 'T', 'ak', 'ie' )
      ENDCASE
      SetColor( cKolor )
      RETURN .T.
   }

   cRezyg := iif( ::aPracownicy[ nIndeks ][ 'rezygnacja' ], 'T', 'N' )
   cWznow := iif( ::aPracownicy[ nIndeks ][ 'wznowienie' ], 'T', 'N' )
   cWznow4 := iif( ::aPracownicy[ nIndeks ][ 'wznowienie4' ], 'T', 'N' )
   cZmPod := iif( ::aPracownicy[ nIndeks ][ 'zmiana_pod' ], 'T', 'N' )
   cZmDod := iif( ::aPracownicy[ nIndeks ][ 'zmiana_dod' ], 'T', 'N' )
   dData := ::aPracownicy[ nIndeks ][ 'data_dek' ]
   nProcPod := ::aPracownicy[ nIndeks ][ 'zmiana_pod_stawka' ]
   nProcDod := ::aPracownicy[ nIndeks ][ 'zmiana_dod_stawka' ]

   SAVE SCREEN TO cEkran
   @  8, 16 CLEAR TO 18, 63
   @  8, 16 TO 18, 63
   Eval( bWyswietlTn, 1 )
   Eval( bWyswietlTn, 2 )
   Eval( bWyswietlTn, 3 )
   Eval( bWyswietlTn, 4 )
   Eval( bWyswietlTn, 5 )
   @  9, 18 SAY "Pracownik: "
   cKolor := SetColor( 'W+' )
   @  9, 30 SAY ::aPracownicy[ nIndeks ][ 'nazwisko' ] + ' ' + ::aPracownicy[ nIndeks ][ 'imie' ]
   SetColor( cKolor )
   @ 10, 18 SAY "Data deklaracji:................." GET dData
   @ 11, 18 SAY "Rezygnacja:......................" GET cRezyg PICTURE '!' VALID cRezyg $ 'TN' .AND. Eval( bWyswietlTn, 1 )
   @ 12, 18 SAY "Wznowienie:......................" GET cWznow PICTURE '!' VALID cWznow $ 'TN' .AND. Eval( bWyswietlTn, 2 )
   @ 13, 18 SAY "Wznowienie po 4 latach:.........." GET cWznow4 PICTURE '!' VALID cWznow4 $ 'TN' .AND. Eval( bWyswietlTn, 3 )
   @ 14, 18 SAY "Zmiana stawki podstawowej:......." GET cZmPod PICTURE '!' VALID cZmPod $ 'TN' .AND. Eval( bWyswietlTn, 4 )
   @ 15, 20 SAY   "Stawka podstawowa:............." GET nProcPod PICTURE '99.99' WHEN cZmPod == 'T'
   @ 16, 18 SAY "Zmiana stawki dodatkowej:........" GET cZmDod PICTURE '!' VALID cZmDod $ 'TN' .AND. Eval( bWyswietlTn, 5 )
   @ 17, 20 SAY   "Stawka dodatkowa:.............." GET nProcDod PICTURE '99.99' WHEN cZmDod == 'T'

   READ

   IF LastKey() <> K_ESC
      ::aPracownicy[ nIndeks ][ 'rezygnacja' ] := cRezyg == 'T'
      ::aPracownicy[ nIndeks ][ 'wznowienie' ] := cWznow == 'T'
      ::aPracownicy[ nIndeks ][ 'wznowienie4' ] := cWznow4 == 'T'
      ::aPracownicy[ nIndeks ][ 'zmiana_pod' ] := cZmPod == 'T'
      ::aPracownicy[ nIndeks ][ 'zmiana_dod' ] := cZmDod == 'T'
      ::aPracownicy[ nIndeks ][ 'zmiana_pod_stawka' ] := nProcPod
      ::aPracownicy[ nIndeks ][ 'zmiana_dod_stawka' ] := nProcDod
      ::aPracownicy[ nIndeks ][ 'data_dek' ] := dData
      ::aPracownicy[ nIndeks ][ 'wybrany' ] := cRezyg == 'T' .OR. cWznow == 'T' .OR. cWznow4 == 'T' .OR. cZmPod == 'T' .OR. cZmDod == 'T'
   ENDIF

   RESTORE SCREEN FROM cEkran

   RETURN

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
   CASE nRodzaj == 4
      cPlik := cPlik + "DEKLARACJE"
   CASE nRodzaj == 5
      cPlik := cPlik + "ZWOLNIENIE"
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
         CASE nRodzaj == 4
            ::XMLDeklaracja( nI )
         CASE nRodzaj == 5
            ::XMLZwolnienie( nI )
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

   ::XMLDodaj( '<?xml version="1.0" encoding="UTF-8"?>' )
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
   IF ::aFirma[ 'exp_id' ] .AND. Len( ::aPracownicy[ nIndeks ][ 'id' ] ) > 0
      ::XMLDodaj( '      <ID_KADRY>' + str2sxml( ::aPracownicy[ nIndeks ][ 'id' ] ) + '</ID_KADRY>' )
   ENDIF
   ::XMLDodaj( '      <IMIE>' + str2sxml( ::aPracownicy[ nIndeks ][ 'imie' ] ) + '</IMIE>' )
   IF ! Empty( ::aPracownicy[ nIndeks ][ 'imie2' ] )
      ::XMLDodaj( '      <IMIE2>' + str2sxml( ::aPracownicy[ nIndeks ][ 'imie2' ] ) + '</IMIE2>' )
   ENDIF
   ::XMLDodaj( '      <NAZWISKO>' + str2sxml( ::aPracownicy[ nIndeks ][ 'nazwisko' ] ) + '</NAZWISKO>' )
   ::XMLDodaj( '      <PLEC>' + ::aPracownicy[ nIndeks ][ 'plec' ] + '</PLEC>' )
   ::XMLDodaj( '      <OBYW>' + ::aPracownicy[ nIndeks ][ 'kraj' ] + '</OBYW>' )
   ::XMLDodaj( '      <NR_PESEL>' + ::aPracownicy[ nIndeks ][ 'pesel' ] + '</NR_PESEL>' )
   ::XMLDodaj( '      <DATA_UR>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_urodzenia' ] ) + '</DATA_UR>' )
   IF ::aFirma[ 'exp_id_eppk' ] .AND. Len( ::aPracownicy[ nIndeks ][ 'id_eppk' ] ) > 0
      ::XMLDodaj( '      <ID_PPK>' + str2sxml( ::aPracownicy[ nIndeks ][ 'id_eppk' ] ) + '</ID_PPK>' )
   ENDIF
   IF ::aFirma[ 'exp_id_pzif' ] .AND. Len( ::aPracownicy[ nIndeks ][ 'id_pzif' ] ) > 0
      ::XMLDodaj( '      <PZIF_RACH_PPK>' + str2sxml( ::aPracownicy[ nIndeks ][ 'id_eppk' ] ) + '</PZIF_RACH_PPK>' )
   ENDIF

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

METHOD XMLDeklaracja( nIndeks ) CLASS TPPK

   IF ( hb_HHasKey( ::aPracownicy[ nIndeks ], 'rezygnacja' ) .AND. ::aPracownicy[ nIndeks ][ 'rezygnacja' ]  ) ;
      .OR. ( hb_HHasKey( ::aPracownicy[ nIndeks ], 'wznowienie' ) .AND. ::aPracownicy[ nIndeks ][ 'wznowienie' ]  ) ;
      .OR. ( hb_HHasKey( ::aPracownicy[ nIndeks ], 'wznowienie4' ) .AND. ::aPracownicy[ nIndeks ][ 'wznowienie4' ]  ) ;
      .OR. ( hb_HHasKey( ::aPracownicy[ nIndeks ], 'zmiana_pod' ) .AND. ::aPracownicy[ nIndeks ][ 'zmiana_pod' ]  ) ;
      .OR. ( hb_HHasKey( ::aPracownicy[ nIndeks ], 'zmiana_dod' ) .AND. ::aPracownicy[ nIndeks ][ 'zmiana_dod' ]  )

      ::XMLDodaj( '      <DANE_DEKLARACJI>' )

      IF hb_HHasKey( ::aPracownicy[ nIndeks ], 'rezygnacja' ) .AND. ::aPracownicy[ nIndeks ][ 'rezygnacja' ]
         ::XMLDodaj( '        <DEKLARACJA>' )
         ::XMLDodaj( '          <DATA_DEKLARACJI>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_dek' ] ) + '</DATA_DEKLARACJI>' )
         ::XMLDodaj( '          <TYP_DEKLARACJI>UCZ_REZYGNACJA</TYP_DEKLARACJI>' )
         ::XMLDodaj( '        </DEKLARACJA>' )
      ENDIF

      IF hb_HHasKey( ::aPracownicy[ nIndeks ], 'wznowienie' ) .AND. ::aPracownicy[ nIndeks ][ 'wznowienie' ]
         ::XMLDodaj( '        <DEKLARACJA>' )
         ::XMLDodaj( '          <DATA_DEKLARACJI>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_dek' ] ) + '</DATA_DEKLARACJI>' )
         ::XMLDodaj( '          <TYP_DEKLARACJI>UCZ_WZNOWIENIE</TYP_DEKLARACJI>' )
         ::XMLDodaj( '        </DEKLARACJA>' )
      ENDIF

      IF hb_HHasKey( ::aPracownicy[ nIndeks ], 'wznowienie4' ) .AND. ::aPracownicy[ nIndeks ][ 'wznowienie4' ]
         ::XMLDodaj( '        <DEKLARACJA>' )
         ::XMLDodaj( '          <DATA_DEKLARACJI>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_dek' ] ) + '</DATA_DEKLARACJI>' )
         ::XMLDodaj( '          <TYP_DEKLARACJI>UCZ_WZNOWIENIE_4</TYP_DEKLARACJI>' )
         ::XMLDodaj( '        </DEKLARACJA>' )
      ENDIF

      IF hb_HHasKey( ::aPracownicy[ nIndeks ], 'zmiana_pod' ) .AND. ::aPracownicy[ nIndeks ][ 'zmiana_pod' ]
         ::XMLDodaj( '        <DEKLARACJA>' )
         ::XMLDodaj( '          <DATA_DEKLARACJI>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_dek' ] ) + '</DATA_DEKLARACJI>' )
         ::XMLDodaj( '          <TYP_DEKLARACJI>' + str2sxml( 'UCZ_ZMIANA_SKùADKI_POD' ) + '</TYP_DEKLARACJI>' )
         ::XMLDodaj( '          <PROCENT_SKLADKI>' + TKwota2( ::aPracownicy[ nIndeks ][ 'zmiana_pod_stawka' ] ) + '</PROCENT_SKLADKI>' )
         ::XMLDodaj( '        </DEKLARACJA>' )
      ENDIF

      IF hb_HHasKey( ::aPracownicy[ nIndeks ], 'zmiana_dod' ) .AND. ::aPracownicy[ nIndeks ][ 'zmiana_dod' ]
         ::XMLDodaj( '        <DEKLARACJA>' )
         ::XMLDodaj( '          <DATA_DEKLARACJI>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_dek' ] ) + '</DATA_DEKLARACJI>' )
         ::XMLDodaj( '          <TYP_DEKLARACJI>' + str2sxml( 'UCZ_ZMIANA_SKùADKI_DOD' ) + '</TYP_DEKLARACJI>' )
         ::XMLDodaj( '          <PROCENT_SKLADKI>' + TKwota2( ::aPracownicy[ nIndeks ][ 'zmiana_dod_stawka' ] ) + '</PROCENT_SKLADKI>' )
         ::XMLDodaj( '        </DEKLARACJA>' )
      ENDIF

      ::XMLDodaj( '      </DANE_DEKLARACJI>' )
   ENDIF
   RETURN NIL

METHOD XMLZwolnienie( nIndeks ) CLASS TPPK

   IF ::aPracownicy[ nIndeks ][ 'zwolnienie' ]
      ::XMLDodaj( '      <ZWOLNIENIE>' )
      ::XMLDodaj( '        <DATA_ZWOLNIENIA>' + date2strxml( ::aPracownicy[ nIndeks ][ 'data_zwolnienia' ] ) + '<DATA_ZWOLNIENIA>' )
      ::XMLDodaj( '      </ZWOLNIENIE>' )
   ENDIF
   RETURN NIL

METHOD New() CLASS TPPK

   RETURN Self

METHOD Wykonaj( nRodzaj ) CLASS TPPK

   LOCAL nI
   LOCAL lTylkoPPK := nRodzaj <> 5

   DO CASE
   CASE nRodzaj == 1 .OR. nRodzaj == 4 .OR. nRodzaj == 5
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

/*----------------------------------------------------------------------*/

PROCEDURE PPK_Deklaracja()

   LOCAL oPPK := TPPK():New()

   oPPK:WykonajDeklaracja()
   oPPK := NIL

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE PPK_Zwolnienie()

   LOCAL oPPK := TPPK():New()

   oPPK:WykonajZwolnienie()
   oPPK := NIL

   RETURN NIL

/*----------------------------------------------------------------------*/

