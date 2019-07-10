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

#include "Inkey.ch"
#include "Box.ch"

FUNCTION Vat27Druk( nDekKor )

   LOCAL aDane, aDek := hb_Hash(), aPozycje := {}, nI, nJ, nK, hPoz, nSumaD := 0, nSumaU := 0
   LOCAL aMenuPoz := {}, cScr, cScr2, cColor, nPT := 0, nPU := 0
   PRIVATE zDRUKDEKL := 'N', zDEKLNAZWI := Space( 20 ), zDEKLIMIE := Space( 15 ), zDEKLTEL := Space( 25 ) // , zDEKLKOR := 'N'

   // aDane := Vat27Oblicz(zVATFORDR <> '7 ')
   aDane := Vat27Oblicz( .F. )

   IF nDekKor == 2
      IF ! Vat27Edytuj( @aDane )
         RETURN NIL
      ENDIF
   ENDIF

   aDane[ 'cel' ] := iif( nDekKor == 2, .T., .F. )

   zDEKLNAZWI := aDane[ 'firma' ][ 'deklnazwi' ]
   zDEKLIMIE := aDane[ 'firma' ][ 'deklimie' ]
   zDEKLTEL := aDane[ 'firma' ][ 'dekltel' ]
   DeklPodp()

   IF LastKey() == K_ESC
      RETURN
   ENDIF

   SWITCH GraficznyCzyTekst()
   CASE 0
      RETURN
      EXIT
   CASE 1
      DeklarDrukuj( 'VAT27-2', aDane )
      RETURN
      EXIT
   CASE 2
      EXIT
   ENDSWITCH

   aDek[ 'p1' ] := aDane[ 'firma' ][ 'nip' ]
   aDek[ 'p4' ] := miesiac
   aDek[ 'p5' ] := param_rok
   aDek[ 'p6a' ] := 0
   aDek[ 'p6b' ] := 0
   aDek[ 'p7' ] := iif( aDane[ 'urzad' ][ 'OK' ], AllTrim( aDane[ 'urzad' ][ 'urzad' ] ) + ',' + ;
      AllTrim( aDane[ 'urzad' ][ 'ulica' ] ) + ' ' + AllTrim( aDane[ 'urzad' ][ 'nr_domu' ] ) + ',' + ;
      AllTrim( aDane[ 'urzad' ][ 'kod_poczt' ] ) + ' ' + AllTrim( aDane[ 'urzad' ][ 'miejsc_us' ] ), '' )
   aDek[ 'p8' ] := iif( aDane[ 'cel' ], 'K', 'I' )
   aDek[ 'p9' ] := aDane[ 'firma' ][ 'spolka' ]
   IF aDane[ 'firma' ][ 'spolka' ]
      aDek[ 'p10' ] := AllTrim( aDane[ 'firma' ][ 'nazwa' ] ) + '     ' + SubStr( aDane[ 'firma' ][ 'nr_regon' ], 3, 9 )
   ELSE
      aDek[ 'p10' ] := AllTrim( aDane[ 'spolka' ][ 'naz_imie' ] ) + '     ' + DToC( aDane[ 'spolka' ][ 'data_ur' ] )
   ENDIF

   nJ := Int( Len( aDane[ 'pozycje' ] ) / 30 ) + iif( ( Len( aDane[ 'pozycje' ] ) % 30 ) == 0, 0, 1 )
   aDek[ 'poz_t' ] := {}
   aDek[ 'sum_t' ] := {}
   IF nJ == 0
      nJ := 1
   ENDIF
   FOR nK := 1 TO nJ
      nSumaD := 0
      aPozycje := {}
      FOR nI := 1 TO 30
         hPoz := hb_Hash( 'nazwa', '', 'nip', '', 'wartosc', Space( 16 ), 'zmiana', .F. )
         IF Len( aDane[ 'pozycje' ] ) >= nI + ( ( nK -1 ) * 30 )
            hPoz[ 'nazwa' ] := aDane[ 'pozycje' ][ nI + ( ( nK -1 ) * 30 ) ][ 'nazwa' ]
            hPoz[ 'nip' ] := aDane[ 'pozycje' ][ nI + ( ( nK -1 ) * 30 ) ][ 'nip' ]
            hPoz[ 'wartosc' ] := kwota( aDane[ 'pozycje' ][ nI + ( ( nK -1 ) * 30 ) ][ 'wartosc' ], 16, 2 )
            hPoz[ 'zmiana' ] := aDane[ 'pozycje' ][ nI + ( ( nK -1 ) * 30 ) ][ 'zmiana' ]
            nSumaD := nSumaD + aDane[ 'pozycje' ][ nI + ( ( nK -1 ) * 30 ) ][ 'wartosc' ]
         ENDIF
         AAdd( aPozycje, hPoz )
      NEXT
      AAdd( aDek[ 'poz_t' ], aPozycje )
      AAdd( aDek[ 'sum_t' ], kwota( nSumaD, 16,2 ) )
   NEXT

   nJ := Int( Len( aDane[ 'pozycje_u' ] ) / 10 ) + iif( ( Len( aDane[ 'pozycje_u' ] ) % 10 ) == 0, 0, 1 )
   aDek[ 'poz_u' ] := {}
   aDek[ 'sum_u' ] := {}
   IF nJ == 0
      nJ := 1
   ENDIF
   FOR nK := 1 TO nJ
      nSumaD := 0
      aPozycje := {}
      FOR nI := 1 TO 10
         hPoz := hb_Hash( 'nazwa', '', 'nip', '', 'wartosc', Space( 16 ), 'zmiana', .F. )
         IF Len( aDane[ 'pozycje_u' ] ) >= nI + ( ( nK -1 ) * 30 )
            hPoz[ 'nazwa' ] := aDane[ 'pozycje_u' ][ nI + ( ( nK -1 ) * 30 ) ][ 'nazwa' ]
            hPoz[ 'nip' ] := aDane[ 'pozycje_u' ][ nI + ( ( nK -1 ) * 30 ) ][ 'nip' ]
            hPoz[ 'wartosc' ] := kwota( aDane[ 'pozycje_u' ][ nI + ( ( nK -1 ) * 30 ) ][ 'wartosc' ], 16, 2 )
            hPoz[ 'zmiana' ] := aDane[ 'pozycje_u' ][ nI + ( ( nK -1 ) * 30 ) ][ 'zmiana' ]
            nSumaD := nSumaD + aDane[ 'pozycje_u' ][ nI + ( ( nK -1 ) * 30 ) ][ 'wartosc' ]
         ENDIF
         AAdd( aPozycje, hPoz )
      NEXT
      AAdd( aDek[ 'poz_u' ], aPozycje )
      AAdd( aDek[ 'sum_u' ], kwota( nSumaD, 16, 2 ) )
   NEXT

   IF Len( aDek[ 'poz_u' ] ) > Len( aDek[ 'poz_t' ] )
      nPT := Len( aDek[ 'poz_t' ] )
      nPU := Len( aDek[ 'poz_u' ] )
      FOR nI := 1 TO nPU - nPT
         aPozycje := {}
         FOR nJ := 1 TO 30
            AAdd( aPozycje, hb_Hash( 'nazwa', '', 'nip', '', 'wartosc', Space( 16 ) ) )
         NEXT
         AAdd( aDek[ 'poz_t' ], aPozycje )
         AAdd( aDek[ 'sum_t' ], kwota( 0, 16, 2 ) )
      NEXT
   ENDIF

   IF Len( aDek[ 'poz_t' ] ) > Len( aDek[ 'poz_u' ] )
      nPT := Len( aDek[ 'poz_t' ] )
      nPU := Len( aDek[ 'poz_u' ] )
      FOR nI := 1 TO nPT - nPU
         aPozycje := {}
         FOR nJ := 1 TO 10
            AAdd( aPozycje, hb_Hash( 'nazwa', '', 'nip', '', 'wartosc', Space( 16 ) ) )
         NEXT
         AAdd( aDek[ 'poz_u' ], aPozycje )
         AAdd( aDek[ 'sum_u' ], kwota( 0, 16, 2 ) )
      NEXT
   ENDIF

   IF Len( aDek[ 'poz_t' ] ) > 1
      FOR nI := 1 TO Len( aDek[ 'poz_t' ] )
         AAdd( aMenuPoz, 'VAT-27 zaˆ¥cznik nr ' + Str( nI, 2 ) )
      NEXT
      SAVE SCREEN TO cScr
      cColor := ColPro()
      @ 9, 9, 10 + Len( aMenuPoz ), 36 BOX B_SINGLE + Space( 1 )
      nI := 1
      DO WHILE nI > 0
         ColPro()
         nI := AChoice( 10, 10, 10 + Len( aMenuPoz ), 35, aMenuPoz, , , nI )
         IF nI > 0
            SAVE SCREEN TO cScr2
            kvat27( aDek, nI, .T. )
            RESTORE SCREEN FROM cScr2
         ENDIF
      ENDDO
      SetColor( cColor )
      RESTORE SCREEN FROM cScr
   ELSE
      kvat27( aDek, 1, .F. )
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION Vat27Edeklaracja( nDekKor )

   LOCAL aDane, aDek := hb_Hash(), nI, nSumaD := 0, cTrescDek

   aDane := Vat27Oblicz()

   IF nDekKor == 2
      IF ! Vat27Edytuj( @aDane )
         RETURN NIL
      ENDIF
   ENDIF

   aDek[ 'cel' ] := iif( nDekKor == 2, '2', '1' )
   aDek[ 'miesiac' ] := Val( miesiac )
   aDek[ 'rok' ] := param_rok
   aDek[ 'spolka' ] := aDane[ 'firma' ][ 'spolka' ]
   aDek[ 'nip' ] := aDane[ 'firma' ][ 'nip' ]
   IF aDane[ 'firma' ][ 'spolka' ]
      aDek[ 'nazwa' ] := aDane[ 'firma' ][ 'nazwa' ]
      aDek[ 'regon' ] := SubStr( aDane[ 'firma' ][ 'nr_regon' ], 3, 9 )
   ELSE
      aDek[ 'nazwisko' ] := naz_imie_naz( aDane[ 'spolka' ][ 'naz_imie' ] )
      aDek[ 'imie' ] := naz_imie_imie( aDane[ 'spolka' ][ 'naz_imie' ] )
      aDek[ 'data_ur' ] := aDane[ 'spolka' ][ 'data_ur' ]
   ENDIF

   FOR nI := 1 TO Len( aDane[ 'pozycje' ] )
      nSumaD := nSumaD + aDane[ 'pozycje' ][ nI ][ 'wartosc' ]
   NEXT
   aDek[ 'pozycje' ] := aDane[ 'pozycje' ]
   aDek[ 'suma_d' ] := nSumaD

   nSumaD := 0
   FOR nI := 1 TO Len( aDane[ 'pozycje_u' ] )
      nSumaD := nSumaD + aDane[ 'pozycje_u' ][ nI ][ 'wartosc' ]
   NEXT
   aDek[ 'pozycje_u' ] := aDane[ 'pozycje_u' ]
   aDek[ 'suma_u' ] := nSumaD

   aDek[ 'kodurzedu' ] := aDane[ 'urzad' ][ 'kodurzedu' ]

   cTrescDek := edek_vat27_2( aDek )
   edeklaracja_plik := 'VAT_27_' + ;
      normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + ;
      AllTrim( aDek[ 'rok' ] ) + '_' + AllTrim( Str( aDek[ 'miesiac' ] ) )
   edekZapiszXml( cTrescDek, edeklaracja_plik, wys_edeklaracja, 'VAT27-2', iif( aDek[ 'cel' ] == '2', .T., .F. ), Val( miesiac ) )

   RETURN

/*----------------------------------------------------------------------*/

FUNCTION Vat27Oblicz()

   LOCAL hRes := hb_Hash( 'OK', .F. ), hTemp, aPoz := {}, nI, lJuzNaLiscie := .F.
   LOCAL aPozU := {}

   hTemp := PobierzFirme( Val( ident_fir ) )

   IF hTemp[ 'firma' ][ 'OK' ]
      hRes[ 'firma' ] := hTemp[ 'firma' ]
      IF !hTemp[ 'firma' ][ 'spolka' ]
         IF hTemp[ 'spolka' ][ 'OK' ]
            hRes[ 'spolka' ] := hTemp[ 'spolka' ]
         ELSE
            hRes[ 'OK' ] := .F.
            RETURN hRes
         ENDIF
      ENDIF
   ELSE
      hRes[ 'OK' ] := .F.
      RETURN hRes
   ENDIF

   IF hRes[ 'firma' ][ 'skarb' ] > 0
      hTemp := PobierzUrzad( hRes[ 'firma' ][ 'skarb' ] )
      IF hTemp[ 'OK' ]
         hRes[ 'urzad' ] := hTemp
      ELSE
         hRes[ 'urzad' ] := hb_Hash( 'OK', .F. )
      ENDIF
   ENDIF

   IF !DostepPro( 'REJS', 'REJS' )
      hRes[ 'OK' ] := .F.
      RETURN hRes
   ENDIF

   dbSetFilter( {|| rejs->del == '+' .AND. rejs->firma == ident_fir .AND. ( rejs->sek_cv7 == 'PN' ;
      .OR. rejs->sek_cv7 == 'PU' ) .AND. Val( rejs->mc ) == Val( miesiac ) } )

   dbGoTop()

   DO WHILE !Eof()

      lJuzNaLiscie := .F.

      IF rejs->sek_cv7 == 'PU'

         FOR nI := 1 TO Len( aPozU )
            IF AllTrim( aPozU[ nI ][ 'nip' ] ) == AllTrim( rejs->nr_ident )
               aPozU[ nI ][ 'wartosc' ] := aPozU[ nI ][ 'wartosc' ] + rejs->wartzw + rejs->wart00 + rejs->wart02 ;
                  + rejs->wart07 + rejs->wart22 + rejs->wart12 + rejs->wart08
               lJuzNaLiscie := .T.
               EXIT
            ENDIF
         NEXT

         IF !lJuzNaLiscie
            hTemp := hb_Hash()
            hTemp[ 'zmiana' ] := .F.
            hTemp[ 'nip' ] := AllTrim( rejs->nr_ident )
            hTemp[ 'nazwa' ] := AllTrim( rejs->nazwa )
            hTemp[ 'wartosc' ] := rejs->wartzw + rejs->wart00 + rejs->wart02 ;
               + rejs->wart07 + rejs->wart22 + rejs->wart12 + rejs->wart08
            AAdd( aPozU, hTemp )
         ENDIF

      ELSE

         FOR nI := 1 TO Len( aPoz )
            IF AllTrim( aPoz[ nI ][ 'nip' ] ) == AllTrim( rejs->nr_ident )
               aPoz[ nI ][ 'wartosc' ] := aPoz[ nI ][ 'wartosc' ] + rejs->wartzw + rejs->wart00 + rejs->wart02 ;
                  + rejs->wart07 + rejs->wart22 + rejs->wart12 + rejs->wart08
               lJuzNaLiscie := .T.
               EXIT
            ENDIF
         NEXT

         IF !lJuzNaLiscie
            hTemp := hb_Hash()
            hTemp[ 'zmiana' ] := .F.
            hTemp[ 'nip' ] := AllTrim( rejs->nr_ident )
            hTemp[ 'nazwa' ] := AllTrim( rejs->nazwa )
            hTemp[ 'wartosc' ] := rejs->wartzw + rejs->wart00 + rejs->wart02 ;
               + rejs->wart07 + rejs->wart22 + rejs->wart12 + rejs->wart08
            AAdd( aPoz, hTemp )
         ENDIF

      ENDIF

      dbSkip()

   ENDDO

   rejs->( dbCloseArea() )

   hRes[ 'pozycje' ] := aPoz
   hRes[ 'pozycje_u' ] := aPozU
   hRes[ 'OK' ] := .T.

   RETURN hRes

/*----------------------------------------------------------------------*/

FUNCTION Vat27Edytuj( aDane )
   LOCAL nMenu := 1
   LOCAL nElem
   LOCAL cScr
   LOCAL aNaglowki := { "Zmiana", "Nazwa lub nazwisko nabywcy", "Nr NIP", "Warto˜†" }
   LOCAL aKolBlock := { { || iif( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ][ nElem ][ 'zmiana' ], 'Tak', 'Nie' ) }, ;
      { || PadR( SubStr( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ][ nElem ][ 'nazwa' ], 1, 36 ), 36 ) }, ;
      { || PadR( SubStr( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ][ nElem ][ 'nip' ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ][ nElem ][ 'wartosc' ], RPIC ) } }
   LOCAL bGetFunc := { | b, ar, nDim, nElem | Vat27EdytujGet( b, ar, nDim, nElem ) }
   LOCAL bDelete := { | nEl, ar |
      hb_ADel( ar, nEl, .T. )
      IF Len( ar ) == 0
         IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
            AAdd( ar, hb_Hash( 'zmiana', .F., 'nip', Space(10), 'nazwa', Space(36), 'wartosc', 0 ) )
         ENDIF
      ENDIF
      RETURN NIL
   }
   LOCAL bInsert := { | nEl, ar | AAdd( ar, hb_Hash( 'zmiana', .F., 'nip', Space(10), 'nazwa', Space(36), 'wartosc', 0 ) ) }

   IF Empty( aDane )
      aDane := Vat27Oblicz()
   ENDIF

   cScr := SaveScreen()
   DO WHILE nMenu > 0 .AND. nMenu < 3
      nMenu := MenuEx( 17, 2, { "C - Informacja o dostawach towaru      (" + AllTrim( Str( Len( aDane[ 'pozycje' ] ) ) ) + ")", ;
         "D - Informacja o ˜wiadczonych usˆugach (" + AllTrim( Str( Len( aDane[ 'pozycje_u' ] ) ) ) + ")", ;
         "Z - Zatwierdzenie" }, nMenu, .F. )
      IF nMenu == 1 .OR. nMenu == 2
         IF Len( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ] ) == 0
            IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
               AAdd( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ], hb_Hash( 'zmiana', .F., 'nip', Space(10), 'nazwa', Space(36), 'wartosc', 0 ) )
            ENDIF
         ENDIF
         IF Len( aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ] ) > 0
            nElem := 1
            ColStd()
            @ 24, 0 SAY PadC( "Ins - dodaj pozycje          Del - usuä pozycj©          ESC - koniec", 80 )
            GM_ArEdit( 3, 0, 23, 79, aDane[ iif( nMenu == 2, 'pozycje_u', 'pozycje' ) ], @nElem, aNaglowki, aKolBlock, bGetFunc, bInsert, bDelete )
            @ 24, 0
         ENDIF
      ENDIF
   ENDDO
   RestScreen( , , , , cScr )

   RETURN nMenu > 0

FUNCTION Vat27EdytujGet( b, ar, nDim, nElem )

   LOCAL GetList := {}
   LOCAL nRow := Row()
   LOCAL nCol := Col()

   LOCAL xValue

   DO CASE
   CASE nDim == 1
      xValue := iif( ar[ nElem ][ 'zmiana' ], 'T', 'N' )
      @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'zmiana' ] := iif( xValue == 'T', .T., .F. )
      ENDIF
      b:refreshAll()
   CASE nDim == 2
      xValue := PadR( ar[ nElem ][ 'nazwa' ], 255)
      @ nRow, nCol GET xValue PICTURE "@S255 " + Replicate( "X", 36 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'nazwa' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 3
      xValue := PadR( ar[ nElem ][ 'nip' ], 30 )
      @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'nip' ] := AllTrim( xValue )
      ENDIF
      b:refreshAll()
   CASE nDim == 4
      xValue := ar[ nElem ][ 'wartosc' ]
      @ nRow, nCol GET xValue PICTURE RPIC
      READ
      IF LastKey() <> K_ESC
         ar[ nElem ][ 'wartosc' ] := xValue
      ENDIF
      b:refreshAll()
   ENDCASE
   @ nRow, nCol SAY ""

   RETURN .T.

/*----------------------------------------------------------------------*/



