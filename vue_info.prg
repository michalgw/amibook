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

PROCEDURE VUE_Info( nWersja )

   RAPORT := RAPTEMP
   PRIVATE P4, P5, P6, P6a, P7, P8, zWERVAT, aSekcjaF
   PRIVATE P11, P16, P17, P17a, P18, P19
   PRIVATE P20, P21, P22, P23, P24, P26, P29
   PRIVATE P35, P36, P37, P38, P39
   PRIVATE P40, P41, P42, P43, P44, P45, P46, P47, P48, P49
   PRIVATE P50, P51, P52, P53, P54, P55, P56, P57, P58, P59
   PRIVATE P60, P61, P62, P61a, P62a, P64, P66, P68
   STORE 0 TO P22, P23, P26, P35, P36, P37, P38
   STORE 0 TO P39, P40, P41, P42, P43, P44, P45, P46, P47, P48, P49, P50, P51, P52, P53, P54, P55
   STORE 0 TO P56, P57, P58, P59, P60, P61, P62, P61a, P62a, P64, P66, P68
   STORE '' TO P4, P5, P6, P7, P8, P11, P16, P17, P17a, P18, P19, P20, P21, P29
   _czy_close := .F.
   spolka_ := .F.

   aSekcjaF := {}

   *#################################     VAT_7      #############################
   BEGIN SEQUENCE
      zWERVAT := '(5) '
      _koniec := "del#[+].or.firma#ident_fir.or.mc#miesiac"

      ColInb()
      @ 24, 0
      center( 24, 'Prosz&_e. czeka&_c....' )
      ColStd()
      IF LastKey() == K_ESC
         BREAK
      ENDIF
      KONIEC1 := .F.

      SELECT 7
      IF Dostep( 'SPOLKA' )
         SetInd( 'SPOLKA' )
         SEEK '+' + ident_fir
      ELSE
         BREAK
      ENDIF
      IF del # '+' .OR. firma # ident_fir
         kom( 5, '*u', ' Prosz&_e. wpisa&_c. w&_l.a&_s.cicieli firmy w odpowiedniej opcji ' )
         BREAK
      ENDIF
      *--------------------------------------
      SELECT 6
      IF Dostep( 'URZEDY' )
         SET INDEX TO urzedy
      ELSE
         BREAK
      ENDIF

      SELECT 5
      IF Dostep( 'REJZ' )
         SetInd( 'REJZ' )
         SEEK '+' + IDENT_FIR + miesiac
      ELSE
         BREAK
      ENDIF

      SELECT 4
      IF Dostep( 'KONTR' )
         SetInd( 'KONTR' )
      ELSE
         BREAK
      ENDIF

      SELECT 3
      IF Dostep( 'FIRMA' )
         GO Val( ident_fir )
         spolka_ := spolka
      ELSE
         BREAK
      ENDIF

      SELECT 1
      IF Dostep( 'REJS' )
         SetInd( 'REJS' )
         SEEK '+' + IDENT_FIR + miesiac
      ELSE
         BREAK
      ENDIF

      STORE 0 TO p45, p46, p47, p48, p49, p50, p51, p52, p61, p62, p61a, p62a, p64, p65, ;
         p67, p69, p70, p71, p72, p75, p76, p77, p78, p79, p98, p99
      STORE 0 TO pp8, pp9, pp10, pp11, pp12, pp13, kkasa_odl, kkasa_zwr, p37, p38, p39, p40, p41, p42, p43, p44

      //tworzenie bazy roboczej
      dbCreate( "ROBVATUE", { ;
         { "REJ",      "C", 1, 0 }, ;
         { "KOREKTA",  "C", 1, 0 }, ;
         { "USLUGA",   "C", 1, 0 }, ;
         { "KRAJ",     "C", 2, 0 }, ;
         { "VATID",    "C", 30, 0 }, ;
         { "TROJCA",   "C", 1, 0 }, ;
         { "WARTOSC",  "N", 12, 2 } } )

      SELECT 2
      IF DostepEx( 'ROBVATUE' )
         INDEX ON rej + kraj + vatid + usluga + trojca TO robvatue
      ELSE
         BREAK
      ENDIF

      SELECT rejs
      DO WHILE ! &_koniec
         IF UE == 'T'
            sumuenet := wartzw + wart00 + wart02 + wart07 + wart22 + wart12
            zwart08 := wart08
            //ztrojstr := iif( trojstr == ' ', 'N', trojstr )
            ztrojstr := iif( ( ',TT_D,' $ ',' + AllTrim( procedur ) + ',' ) .OR. ( ',TT_WNT,' $ ',' + AllTrim( procedur ) + ',' ), 'T', 'N' )
            IF sumuenet <> 0.0
               vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'S' + a->Kraj + vidue + 'N' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + usluga + trojca == 'S' + A->Kraj + vidue + 'N' + ztrojstr
                  REPLACE Wartosc WITH Wartosc + sumuenet
                  commit_()
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'S', korekta WITH A->korekta, kraj WITH A->Kraj, vatid WITH vidue, wartosc WITH sumuenet, usluga WITH 'N', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
            IF zwart08 <> 0.0
               vidue := PadR( iif( SubStr( a->Nr_ident, 3, 1 ) == '-', SubStr( a->Nr_ident, 4 ), a->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'S' + a->Kraj + vidue + 'T' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + usluga + trojca == 'S' + A->Kraj + vidue + 'T' + ztrojstr
                  REPLACE Wartosc WITH Wartosc+zwart08
                  commit_()
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'S', korekta WITH A->korekta, kraj WITH A->Kraj, vatid WITH vidue, wartosc WITH zwart08, usluga WITH 'T', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
         ENDIF
         SELECT rejs
         SKIP 1
      ENDDO

      SELECT rejz
      DO WHILE ! &_koniec
         IF rach == 'F' .AND. UE == 'T' .AND. ( SEK_CV7 == 'WT' .OR. SEK_CV7 == 'WS' )
            STORE 0 TO p45ue, p47ue, p47aue, p49ue, p51ue, p51aue
            p45ue := iif( SP02 == 'S' .AND. ZOM02 == 'O', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'O', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'O', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'O', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 == 'O', WART00, 0 ) + iif( SPZW == 'S', WARTZW, 0 )
            p47ue := iif( SP02 == 'S' .AND. ZOM02 == 'M', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'M', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'M', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'M', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 == 'M', WART00, 0 )
            p47aue := iif( SP02 == 'S' .AND. ZOM02 == 'Z', WART02, 0 ) + iif( SP07 == 'S' .AND. ZOM07 == 'Z', WART07, 0 ) ;
               + iif( SP22 == 'S' .AND. ZOM22 == 'Z', WART22, 0 ) + iif( SP12 == 'S' .AND. ZOM12 == 'Z', WART12, 0 ) ;
               + iif( SP00 == 'S' .AND. ZOM00 =='Z', WART00, 0 )

            p49ue := iif( SP02 == 'P' .AND. ZOM02 == 'O', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'O', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'O', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'O', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'O', WART00, 0 ) + iif( SPZW == 'P', WARTZW, 0 )
            p51ue := iif( SP02 == 'P' .AND. ZOM02 == 'M', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'M', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'M', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'M', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'M', WART00, 0 )
            p51aue := iif( SP02 == 'P' .AND. ZOM02 == 'Z', WART02, 0 ) + iif( SP07 == 'P' .AND. ZOM07 == 'Z', WART07, 0 ) ;
               + iif( SP22 == 'P' .AND. ZOM22 == 'Z', WART22, 0 ) + iif( SP12 == 'P' .AND. ZOM12 == 'Z', WART12, 0 ) ;
               + iif( SP00 == 'P' .AND. ZOM00 == 'Z', WART00, 0 )

            p65dekue := p45ue + p47ue + p47aue + p49ue + p51ue + p51aue

            ztrojstr := iif( trojstr == ' ', 'N', trojstr )

            IF p65dekue <> 0.0
               vidue := PadR( iif( SubStr( e->Nr_ident, 3, 1 ) == '-', SubStr( e->Nr_ident, 4 ), e->Nr_ident ), 30, ' ' )
               SELECT 2
               SEEK 'Z' + e->Kraj + vidue + 'N' + ztrojstr
               IF Found() .AND. rej + kraj + vatid + trojca == 'Z' + e->Kraj + vidue + ztrojstr
                  REPLACE Wartosc WITH Wartosc + p65dekue
               ELSE
                  APPEND BLANK
                  REPLACE rej WITH 'Z', korekta WITH e->korekta, kraj WITH e->Kraj, vatid WITH vidue, wartosc WITH p65dekue, usluga WITH 'N', trojca WITH ztrojstr
                  commit_()
               ENDIF
            ENDIF
         ENDIF
         SELECT rejz
         SKIP 1
      ENDDO

      STORE 0 TO UEALL, UE, UEA, UEB, UEK, UEZAK, UESPR, UEZAKKOR, UESPRKOR, UEUSL
      STORE 0 TO ROBZAKKOR, ROBSPRKOR, ROBSPR, ROBZAK, ROBUSL
      SELECT 2
      GO TOP
      DO WHILE ! Eof()
         DO CASE
            CASE rej == 'S' .AND. usluga == 'N'
              UESPR := UESPR + 1

            CASE rej == 'S' .AND. usluga == 'T'
              UEUSL := UEUSL + 1

            CASE rej == 'Z'
              UEZAK := UEZAK + 1
         ENDCASE
         SKIP
      ENDDO

      vmmm := {}
      AAdd(vmmm, ' VAT-UE       ' + zWERVAT + '  druk graficzny   ')
      AAdd(vmmm, ' VAT-UE       ' + zWERVAT + '  eDeklaracja      ')
      AAdd(vmmm, ' Edycja sekcji C. VAT-UE ' + zWERVAT + '        ')
      AAdd(vmmm, ' Edycja sekcji D. VAT-UE ' + zWERVAT + '        ')
      AAdd(vmmm, ' Edycja sekcji E. VAT-UE ' + zWERVAT + '        ')
      AAdd(vmmm, ' Edycja sekcji F. VAT-UE ' + zWERVAT + '        ')

      STORE 0 TO gora
      gora := 14

      SELECT firma
      P4 := nip
      P5b := param_rok
      SELECT urzedy
      IF firma->skarb > 0
         GO firma->skarb
         P6 := SubStr( AllTrim( urzad ) + ',' + AllTrim( ulica ) + ' ' + AllTrim( nr_domu ) + ',' ;
            + AllTrim( kod_poczt ) + ' ' + AllTrim( miejsc_us ), 1, 60 )
         P6a := AllTrim( kodurzedu )
      ELSE
         P6 := Space( 60 )
         P6a := ''
      ENDIF
      IF spolka_
         SELECT firma
         P8 := AllTrim( nazwa ) + ', ' + SubStr( NR_REGON, 3, 9 )
         P8n := AllTrim( nazwa )
         P11 := SubStr( NR_REGON, 3, 9 )
      ELSE
         SELECT spolka
         SEEK '+' + ident_fir + firma->nazwisko
         IF Found()
            P8 := SubStr( NAZ_IMIE, 1, At( ' ', NAZ_IMIE ) )
            subim := SubStr( NAZ_IMIE, At( ' ', NAZ_IMIE ) + 1 )
            P8 := P8 + iif( At( ' ', subim ) == 0, subim, SubStr( subim, 1, At( ' ', subim ) ) )
            P11 := DToC( data_ur )
            P11d := data_ur
            P8ni := AllTrim( naz_imie )
         ELSE
            P8 := Space( 60 )
            P11 := Space( 10 )
         ENDIF
      ENDIF
      IF spolka_
         SELECT firma
         P16 := tlx
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := nr_domu
         P21 := nr_mieszk
         P22 := miejsc
         P23 := kod_p
         P24 := poczta
         P26 := tel
      else
         sele spolka
         P16 := kraj
         P17 := param_woj
         P17a := param_pow
         P18 := gmina
         P19 := ulica
         P20 := Left( nr_domu, 5 )
         P21 := Left( nr_mieszk, 5 )
         P22 := miejsc_zam
         P23 := kod_poczt
         P24 := poczta
         P26 := telefon
      endif


      PRIVATE aUEs, aUEz, aUEu, elemUE
      // Cza przepisac dane

      aUEs := {}
      SELECT 2
      SEEK 'S'
      DO WHILE ! Eof()
         IF REJ == 'S' .AND. usluga == 'N'
            elemUE := Array( 4 )
            elemUE[ 1 ] := kraj
            elemUE[ 2 ] := VATid
            elemUE[ 3 ] := wartosc
            elemUE[ 4 ] := iif( trojca == 'T', .T., .F. )
            AAdd( aUEs, elemUE )
         ENDIF
         SKIP
      ENDDO

      aUEz := {}
      SELECT 2
      SEEK 'Z'
      DO WHILE ! Eof()
         IF REJ == 'Z'
            elemUE := Array(4)
            elemUE[ 1 ] := kraj
            elemUE[ 2 ] := VATid
            elemUE[ 3 ] := wartosc
            elemUE[ 4 ] := iif( trojca == 'T', .T., .F. )
            AAdd( aUEz, elemUE )
         ENDIF
         SKIP
      ENDDO

      aUEu := {}
      SELECT 2
      SEEK 'S'
      DO WHILE ! Eof()
         IF REJ == 'S' .AND. usluga == 'T'
            elemUE := Array( 4 )
            elemUE[1] := kraj
            elemUE[2] := VATid
            elemUE[3] := wartosc
            elemUE[4] := iif( trojca == 'T', .T., .F. )
            AAdd( aUEu, elemUE )
         ENDIF
         SKIP
      ENDDO


      @ 24, 0

      xUE := 0
      opcja1v := 1
      SAVE SCREEN TO ROBSO11v
      DO WHILE .T.
         *=============================
         ColPro()
         @ gora, 1 TO gora + 7, 39
         FOR xUE := 1 TO Len( vmmm )
            @ gora + xUE, 2 PROMPT vmmm[ xUE ]
         NEXT
         opcja1v := menu( opcja1v )
         ColStd()
         if lastkey() == K_ESC
            EXIT
         ENDIF
         *=============================
         SAVE SCREEN TO scr22v
         papier := 'K'

         zDEKLNAZWI := firma->DEKLNAZWI
         zDEKLIMIE := firma->DEKLIMIE
         zDEKLTEL := firma->DEKLTEL

         IF opcja1v == 1

            DeklarDrukuj( iif( nWersja == 1, 'VATUE-5', 'VATUE-4' ) )

         ELSEIF opcja1v == 2

            PRIVATE zawartoscXml
            edeklaracja_plik = 'VATUE_5_' + normalizujNazwe( AllTrim( symbol_fir ) ) + '_' + AllTrim( miesiac )
            zawartoscXml = iif( Val( param_rok ) < 2021, edek_vatue_5(), edek_vatue_5e2() )
            edekZapiszXml( zawartoscXml, edeklaracja_plik, wys_edeklaracja, 'VATUE-5', .F., Val( miesiac ) )

         ELSEIF opcja1v == 3

            VATUE_EdycjaCDE( @aUEs, 1 )

         ELSEIF opcja1v == 4

            VATUE_EdycjaCDE( @aUEz, 2 )

         ELSEIF opcja1v == 5

            VATUE_EdycjaCDE( @aUEu, 3 )

         ELSEIF opcja1v == 6

            VATUE_EdycjaF( @aSekcjaF )

         ENDIF

         RESTORE SCREEN FROM SCR22v
      ENDDO
      RESTORE SCREEN FROM ROBSO11v
   END

   IF _czy_close
      close_()
   ENDIF

   RETURN

/*----------------------------------------------------------------------*/

PROCEDURE VATUE_EdycjaCDE( aDane, nSekcja )

   LOCAL cScr
   LOCAL xValue
   LOCAL nElem, cTytul := ""
   LOCAL aNaglowki := { "Kraj", "NIP kontrahenta", "Warto˜†" }
   LOCAL aKolBlock := { ;
      { || PadR( SubStr( aDane[ nElem, 1 ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem, 2 ], 1, 16 ), 16 ) }, ;
      { || Transform( aDane[ nElem, 3 ], RPIC ) } }
   LOCAL bGetFunc := { | b, ar, nDim, nElem |
      LOCAL GetList := {}
      LOCAL nRow := Row()
      LOCAL nCol := Col()
      DO CASE
      CASE nDim == 1
         xValue := PadR( ar[ nElem, 1 ], 2 )
         @ nRow, nCol GET xValue PICTURE "!!"
         READ
         IF LastKey() <> K_ESC
            ar[ nElem, 1 ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 2
         xValue := PadR( ar[ nElem, 2 ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S16 " + Replicate( "!", 30 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem, 2 ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 3
         xValue := ar[ nElem, 3 ]
         @ nRow, nCol GET xValue PICTURE RPIC
         READ
         IF LastKey() <> K_ESC
            ar[ nElem, 3 ] := xValue
         ENDIF
         b:refreshAll()
      CASE nDim == 4
         xValue := iif( ar[ nElem, 4 ], 'T', 'N' )
         @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
         READ
         IF LastKey() <> K_ESC
            ar[ nElem, 4 ] := xValue == 'T'
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
            AAdd( ar, { '  ', Space( 16 ), 0.0, .F. } )
         ENDIF
      ENDIF
      RETURN NIL
   }
   LOCAL bInsert := { | nEl, ar | AAdd( ar, { '  ', Space( 16 ), 0.0, .F. } ) }
   LOCAL bDeleteAll := { | nEl, ar |
      DO WHILE Len( ar ) > 0
         hb_ADel( ar, 1, .T. )
      ENDDO
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( ar, { '  ', Space( 16 ), 0.0, .F. } )
      ENDIF
      RETURN NIL
   }
   LOCAL aCustKeys := { { K_F8, bDeleteAll } }

   IF nSekcja < 3
      AAdd( aNaglowki, "Tr.Tr¢js." )
      AAdd( aKolBlock, { || iif( aDane[ nElem, 4 ], 'Tak', 'Nie' ) } )
   ENDIF

   cScr := SaveScreen()
   IF Len( aDane ) == 0
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( aDane, { '  ', Space( 16 ), 0.0, .F. } )
      ENDIF
   ENDIF
   IF Len( aDane ) > 0
      DO CASE
      CASE nSekcja == 1
         cTytul := "Sekcja C. - Wewn¥trzwsp¢lnotowa dostawa towar¢w"
      CASE nSekcja == 2
         cTytul := "Sekcja D. - Wewn¥trzwsp¢lnotowe nabycie towar¢w"
      CASE nSekcja == 3
         cTytul := "Sekcja D. - Wewn¥trzwsp¢lnotowe ˜wiadczenie usˆug"
      ENDCASE
      nElem := 1
      ColStd()
      @  3, 0 SAY PadC( cTytul, 80 )
      @ 24, 0 SAY PadC( "Ins - dodaj pozycje    Del - usuä pozycj©    F8 - Usuä wszystko    ESC - koniec", 80 )
      GM_ArEdit( 4, 0, 23, 79, aDane, @nElem, aNaglowki, aKolBlock, bGetFunc, bInsert, bDelete, aCustKeys )
      @ 24, 0
   ENDIF
   RestScreen( , , , , cScr )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE VATUE_EdycjaF( aDane )

   LOCAL cScr
   LOCAL xValue
   LOCAL nElem
   LOCAL aNaglowki := { "Kraj", "NIP kontrahenta", "NIP kontrah. zast¥p.", "Powr. przem." }
   LOCAL aKolBlock := { ;
      { || PadR( SubStr( aDane[ nElem ][ 'kraj' ], 1, 2 ), 2 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'nip' ], 1, 16 ), 16 ) }, ;
      { || PadR( SubStr( aDane[ nElem ][ 'nipz' ], 1, 16 ), 16 ) }, ;
      { || iif( aDane[ nElem ][ 'powrot' ] == 'T', 'Tak', 'Nie' ) } }
   LOCAL bGetFunc := { | b, ar, nDim, nElem |
      LOCAL GetList := {}
      LOCAL nRow := Row()
      LOCAL nCol := Col()
      DO CASE
      CASE nDim == 1
         xValue := PadR( ar[ nElem ][ 'kraj' ], 2 )
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
         xValue := PadR( ar[ nElem ][ 'nipz' ], 30 )
         @ nRow, nCol GET xValue PICTURE "@S30 " + Replicate( "X", 16 )
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'nipz' ] := AllTrim( xValue )
         ENDIF
         b:refreshAll()
      CASE nDim == 4
         xValue := ar[ nElem ][ 'powrot' ]
         @ nRow, nCol GET xValue PICTURE "!" VALID xValue$'TN'
         READ
         IF LastKey() <> K_ESC
            ar[ nElem ][ 'powrot' ] := xValue
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
            AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'nipz', Space(16), 'powrot', 'N' ) )
         ENDIF
      ENDIF
      RETURN NIL
   }
   LOCAL bInsert := { | nEl, ar | AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'nipz', Space(16), 'powrot', 'N' ) ) }
   LOCAL bDeleteAll := { | nEl, ar |
      DO WHILE Len( ar ) > 0
         hb_ADel( ar, 1, .T. )
      ENDDO
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( ar, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'nipz', Space(16), 'powrot', 'N' ) )
      ENDIF
      RETURN NIL
   }
   LOCAL aCustKeys := { { K_F8, bDeleteAll } }

   cScr := SaveScreen()
   IF Len( aDane ) == 0
      IF tnesc( , "Brak pozycji. Czy utworzy† pust¥ pozycj©? (T/N)" )
         AAdd( aDane, hb_Hash( 'kraj', '  ', 'nip', Space(16), 'nipz', Space(16), 'powrot', 'N' ) )
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
