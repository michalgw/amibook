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

#include "Inkey.ch"

FUNCTION VatUE4Oblicz()
   LOCAL _koniec := "del#[+].or.firma#ident_fir.or.mc#miesiac"
   LOCAL spolka_
   LOCAL p45,p46,p47,p48,p49,p50,p51,p52,p61,p62,p61a,p62a,p64,p65,p67,p69,p70,p71,p72,p75,p76,p77,p78,p79,p98,p99
   LOCAL pp8,pp9,pp10,pp11,pp12,pp13,kkasa_odl,kkasa_zwr,p37,p38,p39,p40,p41,p42,p43,p44
   LOCAL aDane := hb_Hash()
   LOCAL nPoz, lTrojstr


   ColInb()
   @ 24, 0
   center( 24, "Prosz© czeka†...")
   ColStd()

   SELECT 7
   IF dostep( 'SPOLKA' )
      setind( 'SPOLKA' )
      SEEK "+" + ident_fir
   ELSE
      BREAK
   ENDIF
   IF del#"+" .OR. firma#ident_fir
      kom( 5, "*u", " Prosz© wpisa† wˆa˜cicieli firmy w odpowiedniej opcji " )
      close_()
      RETURN NIL
   ENDIF

   SELECT 6
   IF dostep( 'URZEDY' )
      SET INDEX TO urzedy
   ELSE
      close_()
      RETURN NIL
   ENDIF

   SELECT 5
   IF dostep( 'REJZ' )
      setind( 'REJZ' )
      SEEK '+' + ident_fir + miesiac
   ELSE
      close_()
      RETURN NIL
   ENDIF

   SELECT 4
   IF dostep( 'KONTR' )
      setind( 'KONTR' )
   ELSE
      close_()
      RETURN NIL
   ENDIF

   SELECT 3
   IF dostep( 'FIRMA' )
      GO Val( ident_fir )
      spolka_ := spolka
   ELSE
      close_()
      RETURN NIL
   ENDIF

   SELECT 1
   IF dostep( 'REJS' )
      setind( 'REJS' )
      SEEK '+' + ident_fir + miesiac
   ELSE
      close_()
      RETURN NIL
   ENDIF

   STORE 0 TO p45,p46,p47,p48,p49,p50,p51,p52,p61,p62,p61a,p62a,p64,p65,p67,p69,p70,p71,p72,p75,p76,p77,p78,p79,p98,p99
   STORE 0 TO pp8,pp9,pp10,pp11,pp12,pp13,kkasa_odl,kkasa_zwr,p37,p38,p39,p40,p41,p42,p43,p44

   aDane[ 'poz_c' ] := {}
   aDane[ 'poz_d' ] := {}
   aDane[ 'poz_e' ] := {}

   SELECT rejs
   DO WHILE ! &_koniec
      IF UE == 'T'
         sumuenet := wartzw + wart00 + wart02 + wart07 + wart22 + wart12
         zwart08 := wart08
         IF sumuenet <> 0.0
            vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
            lTrojstr := ( ',TT_D,' $ ',' + AllTrim( procedur ) + ',' ) .OR. ( ',TT_WNT,' $ ',' + AllTrim( procedur ) + ',' )
            nPoz := AScan( aDane[ 'poz_c' ], { | aPoz | aPoz[ 'kraj' ] == kraj .AND. aPoz[ 'nip' ] == vidue .AND. aPoz[ 'trojstr' ] == lTrojstr } )

            IF nPoz > 0
               aDane[ 'poz_c' ][ nPoz ][ 'wartosc' ] := aDane[ 'poz_c' ][ nPoz ][ 'wartosc' ] + sumuenet
            ELSE
               AAdd( aDane[ 'poz_c' ], hb_Hash( 'kraj', kraj, 'nip', vidue, 'wartosc', sumuenet, 'trojstr', lTrojstr ) )
            ENDIF
         ENDIF
         IF zwart08 <> 0.0
            vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
            lTrojstr := ( ',TT_D,' $ ',' + AllTrim( procedur ) + ',' ) .OR. ( ',TT_WNT,' $ ',' + AllTrim( procedur ) + ',' )
            nPoz := AScan( aDane[ 'poz_e' ], { | aPoz | aPoz[ 'kraj' ] == kraj .AND. aPoz[ 'nip' ] == vidue .AND. aPoz[ 'trojstr' ] == lTrojstr } )

            IF nPoz > 0
               aDane[ 'poz_e' ][ nPoz ][ 'wartosc' ] := aDane[ 'poz_e' ][ nPoz ][ 'wartosc' ] + zwart08
            ELSE
               AAdd( aDane[ 'poz_e' ], hb_Hash( 'kraj', kraj, 'nip', vidue, 'wartosc', zwart08, 'trojstr', lTrojstr ) )
            ENDIF
         ENDIF
      ENDIF
      SKIP 1
   ENDDO

   SELECT rejz
   DO WHILE ! &_koniec
      IF rach == 'F' .AND. UE == 'T' .AND. ( SEK_CV7 == 'WT' .OR. SEK_CV7 == 'WS' )
         STORE 0 TO p45ue, p47ue, p47aue, p49ue, p51ue, p51aue
         p45ue=iif(SP02='S'.and.ZOM02='O',WART02,0)+iif(SP07='S'.and.ZOM07='O',WART07,0)+iif(SP22='S'.and. ZOM22='O',WART22,0)+iif(SP12='S'.and. ZOM12='O',WART12,0)+iif(SP00='S'.and. ZOM00='O',WART00,0)+iif(SPZW='S',WARTZW,0)
         p47ue=iif(SP02='S'.and.ZOM02='M',WART02,0)+iif(SP07='S'.and.ZOM07='M',WART07,0)+iif(SP22='S'.and. ZOM22='M',WART22,0)+iif(SP12='S'.and. ZOM12='M',WART12,0)+iif(SP00='S'.and. ZOM00='M',WART00,0)
         p47aue=iif(SP02='S'.and.ZOM02='Z',WART02,0)+iif(SP07='S'.and.ZOM07='Z',WART07,0)+iif(SP22='S'.and. ZOM22='Z',WART22,0)+iif(SP12='S'.and. ZOM12='Z',WART12,0)+iif(SP00='S'.and. ZOM00='Z',WART00,0)

         p49ue=iif(SP02='P'.and.ZOM02='O',WART02,0)+iif(SP07='P'.and.ZOM07='O',WART07,0)+iif(SP22='P'.and. ZOM22='O',WART22,0)+iif(SP12='P'.and. ZOM12='O',WART12,0)+iif(SP00='P'.and. ZOM00='O',WART00,0)+iif(SPZW='P',WARTZW,0)
         p51ue=iif(SP02='P'.and.ZOM02='M',WART02,0)+iif(SP07='P'.and.ZOM07='M',WART07,0)+iif(SP22='P'.and. ZOM22='M',WART22,0)+iif(SP12='P'.and. ZOM12='M',WART12,0)+iif(SP00='P'.and. ZOM00='M',WART00,0)
         p51aue=iif(SP02='P'.and.ZOM02='Z',WART02,0)+iif(SP07='P'.and.ZOM07='Z',WART07,0)+iif(SP22='P'.and. ZOM22='Z',WART22,0)+iif(SP12='P'.and. ZOM12='Z',WART12,0)+iif(SP00='P'.and. ZOM00='Z',WART00,0)

         p65dekue := p45ue + p47ue + p47aue + p49ue + p51ue + p51aue

         IF p65dekue <> 0.0
            vidue := PadR( iif( SubStr( e->Nr_ident, 3, 1 ) == '-', SubStr( e->Nr_ident, 4 ), e->Nr_ident ), 30, ' ' )

            nPoz := AScan( aDane[ 'poz_d' ], { | aPoz | aPoz[ 'kraj' ] == kraj .AND. aPoz[ 'nip' ] == vidue .AND. aPoz[ 'trojstr' ] == trojstr } )

            IF nPoz > 0
               aDane[ 'poz_d' ][ nPoz ][ 'wartosc' ] := aDane[ 'poz_d' ][ nPoz ][ 'wartosc' ] + p65dekue
            ELSE
               AAdd( aDane[ 'poz_d' ], hb_Hash( 'kraj', kraj, 'nip', vidue, 'wartosc', p65dekue, 'trojstr', trojstr ) )
            ENDIF
         ENDIF
      ENDIF
      SKIP 1
   ENDDO

   SELECT firma
   aDane[ 'nip' ] := nip
   aDane[ 'rok' ] := param_rok
   aDane[ 'miesiac' ] := AllTrim( miesiac )

   SELECT urzedy
   IF firma->skarb > 0
      GO firma->skarb
      aDane[ 'kod_urzedu' ] := kodurzedu
   ELSE
      aDane[ 'kod_urzedu' ] := ''
   ENDIF

   IF spolka_
      SELECT firma
      aDane[ 'nazwa' ] := AllTrim( nazwa )
      aDane[ 'regon' ] := SubStr( nr_regon, 3, 9 )
      aDane[ 'spolka' ] := .T.
   ELSE
      SELECT spolka
      SEEK '+' + ident_fir + firma->nazwisko
      IF Found()
         aDane[ 'nazwisko' ] := naz_imie_naz( AllTrim( naz_imie ) )
         aDane[ 'imie' ] := naz_imie_imie( AllTrim( naz_imie ) )
         aDane[ 'data_ur' ] := data_ur
      ELSE
         aDane[ 'nazwisko' ] := ''
         aDane[ 'imie' ] := ''
         aDane[ 'data_ur' ] := ''
      ENDIF
      aDane[ 'spolka' ] := .F.
   ENDIF

   close_()

   RETURN aDane

/*----------------------------------------------------------------------*/

FUNCTION VatUE4KRob( nWersja )
   LOCAL aDane
   LOCAL nMenu := 1, aPozMenu
   LOCAL nDek := 1
   LOCAL cTab
   LOCAL cDaneXML
   LOCAL bEv := { | aPoz |
         aPoz[ 'jkraj' ] := aPoz[ 'kraj' ]
         aPoz[ 'jnip' ] := aPoz[ 'nip' ]
         aPoz[ 'jwartosc' ] := aPoz[ 'wartosc' ]
         aPoz[ 'jtrojstr' ] := aPoz[ 'trojstr' ]
   }

   aDane := VatUE4Oblicz()
   aDane[ 'poz_f' ] := {}

   @ 24, 0

   IF HB_ISHASH( aDane ) .AND. Len( aDane[ 'poz_c' ] ) + Len( aDane[ 'poz_d' ] ) + Len( aDane[ 'poz_e' ] ) > 0

      AEval( aDane[ 'poz_c' ], bEv )
      AEval( aDane[ 'poz_d' ], bEv )
      AEval( aDane[ 'poz_e' ], bEv )

      DO WHILE nMenu >= 1 .AND. nMenu <= iif( nWersja == 1, 4, 3 )
         aPozMenu := { "C - Informacja o dostawach towaru  (" + AllTrim( Str( Len( aDane[ 'poz_c' ] ) ) ) + ")", ;
            "D - Informacja o nabyciach towar¢w (" + AllTrim( Str( Len( aDane[ 'poz_d' ] ) ) ) + ")", ;
            "E - Informacja o ˜wiadczeniu usˆug (" + AllTrim( Str( Len( aDane[ 'poz_e' ] ) ) ) + ")" }
         IF nWersja == 1
            AAdd( aPozMenu, "F - Informacja o call-off stock    (" + AllTrim( Str( Len( aDane[ 'poz_f' ] ) ) ) + ")" )
         ENDIF
         AAdd( aPozMenu, "Z - Zatwierdzenie" )
         nMenu := MenuEx( 17, 2, aPozMenu, nMenu, .F. )
         DO CASE
         CASE nMenu == 1
            VatUEEdytuj( aDane[ 'poz_c' ], "Informacja o dostawach towaru" )
         CASE nMenu == 2
            VatUEEdytuj( aDane[ 'poz_d' ], "Informacja o nabyciach towar¢w" )
         CASE nMenu == 3
            VatUEEdytuj( aDane[ 'poz_e' ], "Informacja o ˜wiadczeniu usˆug", .F. )
         CASE nWersja == 1 .AND. nMenu == 4
            VATUEK_EdycjaF( aDane[ 'poz_f' ] )
         ENDCASE
      ENDDO
      IF nMenu == iif( nWersja == 1, 5, 4 )
         nDek := MenuEx( 18, 3, { "G - Druk graficzny", "E - eDeklaracja" }, nDek )
         DO CASE
         CASE nDek == 1
            IF nWersja == 1
               DeklarDrukuj( "VATUEK-5", aDane )
            ELSE
               DeklarDrukuj( "VATUEK-4", aDane )
            ENDIF
         CASE nDek == 2
            IF nWersja == 1
               cDaneXML := iif( Val( param_rok ) < 2021, edek_vatuek_5( aDane ), edek_vatuek_5e2( aDane ) )
               edeklaracja_plik = 'VATUEK_5_' + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + AllTrim( miesiac )
               edekZapiszXml( cDaneXML, edeklaracja_plik, wys_edeklaracja, 'VATUEK-5', .F., Val( miesiac ) )
            ELSE
               cDaneXML := edek_vatuek_4( aDane )
               edeklaracja_plik = 'VATUEK_4_' + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + AllTrim( miesiac )
               edekZapiszXml( cDaneXML, edeklaracja_plik, wys_edeklaracja, 'VATUEK-4', .F., Val( miesiac ) )
            ENDIF
         ENDCASE
      ENDIF
   ELSE
      komun( "Brak danych", 15 )
   ENDIF

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION VatUEEdytuj( aDane, cTytul, lTrojstr )
   LOCAL nElem
   LOCAL cScr
   LOCAL aNaglowki := { { "BK", "Byˆo NIP", "B.Warto˜†", "BTT", "JK", "Jest NIP", "J.Wartosc", "JTT" }, ;
      { "BK", "Byˆo NIP", "B.Warto˜†", "JK", "Jest NIP", "J.Wartosc" } }
   LOCAL aKolBlock := { { ;
      { || PadR( SubStr( aDane[ nElem ][ 'kraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'nip' ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ nElem ][ 'wartosc' ], RPIC ) }, ;
      { || iif( aDane[ nElem ][ 'trojstr' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jkraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jnip' ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ nElem ][ 'jwartosc' ], RPIC ) }, ;
      { || iif( aDane[ nElem ][ 'jtrojstr' ] == 'T', 'Tak', 'Nie' ) } }, ;
      { { || PadR( SubStr( aDane[ nElem ][ 'kraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'nip' ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ nElem ][ 'wartosc' ], RPIC ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jkraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jnip' ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ nElem ][ 'jwartosc' ], RPIC ) } } }

   LOCAL bGetFunc := { { | b, ar, nDim, nElem | VatUEEdytujGet( b, ar, nDim, nElem ) }, ;
      { | b, ar, nDim, nElem | VatUEEdytujGet2( b, ar, nDim, nElem ) } }
   LOCAL bDelete := { | nEl, ar |
      hb_ADel( ar, nEl, .T. )
      IF Len( ar ) == 0
         IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
            AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'wartosc', 0, 'trojstr', 'N', 'jkraj', '  ', 'jnip', Space(16), 'jwartosc', 0, 'jtrojstr', 'N'  ) )
         ENDIF
      ENDIF
      RETURN NIL
   }
   LOCAL bInsert := { | nEl, ar | AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'wartosc', 0, 'trojstr', 'N', 'jkraj', '  ', 'jnip', Space(16), 'jwartosc', 0, 'jtrojstr', 'N'  ) ) }
   LOCAL bDeleteAll := { | nEl, ar |
      DO WHILE Len( ar ) > 0
         hb_ADel( ar, 1, .T. )
      ENDDO
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'wartosc', 0, 'trojstr', 'N', 'jkraj', '  ', 'jnip', Space(16), 'jwartosc', 0, 'jtrojstr', 'N'  ) )
      ENDIF
      RETURN NIL
   }
   LOCAL aCustKeys := { { K_F8, bDeleteAll } }

   hb_default( @cTytul, '' )
   hb_default( @lTrojstr, .T. )

   cScr := SaveScreen()
   IF Len( aDane ) == 0
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( aDane, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'wartosc', 0, 'trojstr', 'N', 'jkraj', '  ', 'jnip', Space(16), 'jwartosc', 0, 'jtrojstr', 'N'  ) )
      ENDIF
   ENDIF
   IF Len( aDane ) > 0
      nElem := 1
      ColStd()
      @  3, 0 SAY PadC( cTytul, 80 )
      @ 24, 0 SAY PadC( "Ins - dodaj pozycje    Del - usuä pozycj©    F8 - Usuä wszystko    ESC - koniec", 80 )
      IF lTrojstr
         GM_ArEdit( 4, 0, 23, 79, aDane, @nElem, aNaglowki[ 1 ], aKolBlock[ 1 ], bGetFunc[ 1 ], bInsert, bDelete, aCustKeys )
      ELSE
         GM_ArEdit( 4, 0, 23, 79, aDane, @nElem, aNaglowki[ 2 ], aKolBlock[ 2 ], bGetFunc[ 2 ], bInsert, bDelete, aCustKeys )
      ENDIF

      @ 24, 0
   ENDIF
   RestScreen( , , , , cScr )

   RETURN NIL

FUNCTION VatUEEdytujGet( b, ar, nDim, nElem )

   LOCAL GetList := {}
   LOCAL nRow := Row()
   LOCAL nCol := Col()

   LOCAL xValue

   DO CASE
   CASE nDim == 1
      xValue := PadR( ar[ nElem ][ 'kraj' ], 2)
      @ nRow, nCol GET xValue PICTURE "!!"
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'kraj' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 2
      xValue := PadR( ar[ nElem ][ 'nip' ], 30 )
      @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'nip' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 3
      xValue := ar[ nElem ][ 'wartosc' ]
      @ nRow, nCol GET xValue PICTURE RPIC
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'wartosc' ] := xValue
      ENDIF
      b:refreshAll()
   CASE nDim == 4
      xValue := ar[ nElem ][ 'trojstr' ]
      @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'trojstr' ] := xValue
      ENDIF
      b:refreshAll()
   CASE nDim == 5
      xValue := PadR( ar[ nElem ][ 'jkraj' ], 2)
      @ nRow, nCol GET xValue PICTURE "!!"
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jkraj' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 6
      xValue := PadR( ar[ nElem ][ 'jnip' ], 30 )
      @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jnip' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 7
      xValue := ar[ nElem ][ 'jwartosc' ]
      @ nRow, nCol GET xValue PICTURE RPIC
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jwartosc' ] := xValue
      ENDIF
      b:refreshAll()
   CASE nDim == 8
      xValue := ar[ nElem ][ 'jtrojstr' ]
      @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jtrojstr' ] := xValue
      ENDIF
      b:refreshAll()
   ENDCASE
   @ nRow, nCol SAY ""

   RETURN .T.

/*----------------------------------------------------------------------*/

FUNCTION VatUEEdytujGet2( b, ar, nDim, nElem )

   LOCAL GetList := {}
   LOCAL nRow := Row()
   LOCAL nCol := Col()

   LOCAL xValue

   DO CASE
   CASE nDim == 1
      xValue := PadR( ar[ nElem ][ 'kraj' ], 2)
      @ nRow, nCol GET xValue PICTURE "!!"
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'kraj' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 2
      xValue := PadR( ar[ nElem ][ 'nip' ], 30 )
      @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'nip' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 3
      xValue := ar[ nElem ][ 'wartosc' ]
      @ nRow, nCol GET xValue PICTURE RPIC
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'wartosc' ] := xValue
      ENDIF
      b:refreshAll()
   CASE nDim == 4
      xValue := PadR( ar[ nElem ][ 'jkraj' ], 2)
      @ nRow, nCol GET xValue PICTURE "!!"
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jkraj' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 5
      xValue := PadR( ar[ nElem ][ 'jnip' ], 30 )
      @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jnip' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 6
      xValue := ar[ nElem ][ 'jwartosc' ]
      @ nRow, nCol GET xValue PICTURE RPIC
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'jwartosc' ] := xValue
      ENDIF
      b:refreshAll()
   ENDCASE
   @ nRow, nCol SAY ""

   RETURN .T.

/*----------------------------------------------------------------------*/

PROCEDURE VATUEK_EdycjaF( aDane )

   LOCAL cScr
   LOCAL xValue
   LOCAL nElem
   LOCAL aNaglowki := { "BK", "B.NIP kontrahenta", "B.NIP kontrah. zast¥p.", "B.Powr. przem.", "JK", "J.NIP kontrahenta", "J.NIP kontrah. zast¥p.", "J.Powr. przem." }
   LOCAL aKolBlock := { ;
      { || PadR( SubStr( aDane[ nElem ][ 'bkraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'bnip' ], 1, 16 ), 16 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'bnipz' ], 1, 16 ), 16 ) }, ;
      { || iif( aDane[ nElem ][ 'bpowrot' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jkraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jnip' ], 1, 16 ), 16 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'jnipz' ], 1, 16 ), 16 ) }, ;
      { || iif( aDane[ nElem ][ 'jpowrot' ] == 'T', 'Tak', 'Nie' ) } }
   LOCAL bGetFunc := { | b, ar, nDim, nElem |
      LOCAL GetList := {}
      LOCAL nRow := Row()
      LOCAL nCol := Col()
      DO CASE
      CASE nDim == 1
         xValue := PadR( ar[ nElem ][ 'bkraj' ], 2 )
         @ nRow, nCol GET xValue PICTURE "!!"
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'bkraj' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 2
         xValue := PadR( ar[ nElem ][ 'bnip' ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'bnip' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 3
         xValue := PadR( ar[ nElem ][ 'bnipz' ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'bnipz' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 4
         xValue := ar[ nElem ][ 'bpowrot' ]
         @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'bpowrot' ] := xValue
         ENDIF
         b:refreshAll()
      CASE nDim == 5
         xValue := PadR( ar[ nElem ][ 'jkraj' ], 2 )
         @ nRow, nCol GET xValue PICTURE "!!"
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'jkraj' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 6
         xValue := PadR( ar[ nElem ][ 'jnip' ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'jnip' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 7
         xValue := PadR( ar[ nElem ][ 'jnipz' ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'jnipz' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 8
         xValue := ar[ nElem ][ 'jpowrot' ]
         @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'jpowrot' ] := xValue
         ENDIF
         b:refreshAll()
      ENDCASE
      @ nRow, nCol SAY ""
      RETURN .T.
   }
   LOCAL bDelete := { | nEl, ar |
      hb_ADel( ar, nEl, .T. )
      IF Len( ar ) == 0
         IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
            AAdd( ar, hb_Hash( 'bkraj', '  ', 'bnip', Space(16), 'bnipz', ;
               Space(16), 'bpowrot', 'N', 'jkraj', '  ', 'jnip', Space(16), ;
               'jnipz', Space(16), 'jpowrot', 'N' ) )
         ENDIF
      ENDIF
      RETURN NIL
   }
   LOCAL bInsert := { | nEl, ar | AAdd( ar, hb_Hash( 'bkraj', '  ', 'bnip', ;
      Space(16), 'bnipz', Space(16), 'bpowrot', 'N', 'jkraj', '  ', 'jnip', ;
      Space(16), 'jnipz', Space(16), 'jpowrot', 'N' ) ) }
   LOCAL bDeleteAll := { | nEl, ar |
      DO WHILE Len( ar ) > 0
         hb_ADel( ar, 1, .T. )
      ENDDO
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( ar, hb_Hash( 'bkraj', '  ', 'bnip', Space(16), 'bnipz', ;
            Space(16), 'bpowrot', 'N', 'jkraj', '  ', 'jnip', Space(16), ;
            'jnipz', Space(16), 'jpowrot', 'N' ) )
      ENDIF
      RETURN NIL
   }
   LOCAL aCustKeys := { { K_F8, bDeleteAll } }

   cScr := SaveScreen()
   IF Len( aDane ) == 0
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( aDane, hb_Hash( 'bkraj', '  ', 'bnip', Space(16), 'bnipz', ;
            Space(16), 'bpowrot', 'N', 'jkraj', '  ', 'jnip', Space(16), ;
            'jnipz', Space(16), 'jpowrot', 'N' ) )
      ENDIF
   ENDIF
   IF Len( aDane ) > 0
      nElem := 1
      ColStd()
      @  3, 0 SAY PadC( "Sekcja F. - przemieszczanie towaru w proc. call-off stock", 80 )
      @ 24, 0 SAY PadC( "Ins - dodaj pozycje    Del - usuä pozycj©    F8 - Usuä wszystko    ESC - koniec", 80 )
      GM_ArEdit( 4, 0, 23, 79, aDane, @nElem, aNaglowki, aKolBlock, bGetFunc, bInsert, bDelete, aCustKeys )
      @ 24, 0
   ENDIF
   RestScreen( , , , , cScr )

   RETURN NIL

/*----------------------------------------------------------------------*/
