/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2021  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

// nRodzaj: 1 - NIP, 2 - Nazwa
FUNCTION Obroty_Dane( nRodzaj, cDane, dDataOd, dDataDo, cGrupuj )

   LOCAL aDane := { 'ok' => .F., 'pozycje' => {}, 'rodzaj' => nRodzaj, ;
      'filtr' => cDane, 'data_od' => dDataOd, 'data_do' => dDataDo, ;
      'firma_nazwa' => '', 'firma_nip' => '' }
   LOCAL dDataDok, aPoz, aLista := {}, nI, cKlucz
   LOCAL aFiltr := { ;
      { | cTablica | Empty( cDane ) .OR. ( NormalizujNipPL( ( cTablica )->nr_ident ) == NormalizujNipPL( cDane ) ) }, ;
      { | cTablica | Empty( cDane ) .OR. ( hb_AtI( cDane, ( cTablica )->nazwa ) > 0 ) } }

   IF ! Dostep( 'FIRMA' )
      RETURN aDane
   ENDIF
   firma->( dbGoto( Val( ident_fir ) ) )
   aDane[ 'firma_nazwa' ] := AllTrim( firma->nazwa )
   aDane[ 'firma_nip' ] := AllTrim( firma->nip )
   firma->( dbCloseArea() )

   IF ! Dostep( 'OPER' )
      RETURN aDane
   ENDIF
   SetInd( 'OPER' )

   oper->( dbSeek( '+' + ident_fir ) )

   IF oper->( Found() )

      DO WHILE ! oper->( Eof() ) .AND. oper->del == '+' .AND. oper->firma == ident_fir

         dDataDok := hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) )

         IF dDataDok >= dDataOd .AND. dDataDok <= dDataDo .AND. Eval( aFiltr[ nRodzaj ], 'oper' )

            cKlucz := iif( AllTrim( oper->nr_ident ) == "", AllTrim( oper->nazwa ), ;
               AllTrim( NormalizujNipPL( oper->nr_ident ) ) )
            aPoz := {=>}
            aPoz[ 'klucz' ] := cKlucz
            aPoz[ 'rodzaj' ] := 1
            aPoz[ 'data' ] := dDataDok
            aPoz[ 'nazwa' ] := AllTrim( oper->nazwa )
            IF Left( oper->numer, 1 ) == Chr( 1 ) .OR. Left( oper->numer, 1 ) == Chr( 254 )
               aPoz[ 'nr_dok' ] := AllTrim( SubStr( oper->numer, 2 ) )
               aPoz[ 'np' ] := iif( oper->wyr_tow + oper->uslugi > 0, oper->wyr_tow + oper->uslugi, 0 )
               aPoz[ 'nr' ] := 0
               aPoz[ 'bp' ] := iif( oper->wyr_tow + oper->uslugi > 0, oper->wyr_tow + oper->uslugi, 0 )
               aPoz[ 'br' ] := 0
            ELSE
               aPoz[ 'nr_dok' ] := AllTrim( oper->numer )
               aPoz[ 'np' ] := 0
               aPoz[ 'nr' ] := oper->zakup + oper->uboczne + oper->wynagr_g + oper->wydatki
               aPoz[ 'bp' ] := 0
               aPoz[ 'br' ] := oper->zakup + oper->uboczne + oper->wynagr_g + oper->wydatki
            ENDIF

            nI := AScan( aLista, { | aElem | aElem[ 'klucz' ] == cKlucz } )
            IF nI == 0
               AAdd( aLista, { 'klucz' => cKlucz, 'nazwa' => aPoz[ 'nazwa' ], 'pozycje' => { aPoz } } )
            ELSE
               AAdd( aLista[ nI ][ 'pozycje' ], aPoz )
            ENDIF

         ENDIF

         oper->( dbSkip() )

      ENDDO

   ENDIF

   oper->( dbCloseArea() )

   IF ! Dostep( 'REJS' )
      RETURN aDane
   ENDIF
   SetInd( 'REJS' )

   rejs->( dbSeek( '+' + ident_fir ) )

   IF rejs->( Found() )

      DO WHILE ! rejs->( Eof() ) .AND. rejs->del == '+' .AND. rejs->firma == ident_fir

         dDataDok := hb_Date( Val( param_rok ), Val( rejs->mc ), Val( rejs->dzien ) )

         IF dDataDok >= dDataOd .AND. dDataDok <= dDataDo .AND. Eval( aFiltr[ nRodzaj ], 'rejs' )

            cKlucz := iif( AllTrim( rejs->nr_ident ) == "", AllTrim( rejs->nazwa ), ;
               AllTrim( NormalizujNipPL( rejs->nr_ident ) ) )
            aPoz := {=>}
            aPoz[ 'klucz' ] := cKlucz
            aPoz[ 'rodzaj' ] := 2
            aPoz[ 'data' ] := dDataDok
            aPoz[ 'nazwa' ] := AllTrim( rejs->nazwa )
            IF Left( rejs->numer, 1 ) == Chr( 1 ) .OR. Left( rejs->numer, 1 ) == Chr( 254 )
               aPoz[ 'nr_dok' ] := AllTrim( SubStr( rejs->numer, 2 ) )
            ELSE
               aPoz[ 'nr_dok' ] := AllTrim( rejs->numer )
            ENDIF
            aPoz[ 'np' ] := rejs->wartzw + rejs->wart00 + rejs->wart02 + rejs->wart07 ;
               + rejs->wart22 + rejs->wart12
            aPoz[ 'nr' ] := 0
            aPoz[ 'bp' ] := rejs->wartzw + rejs->wart00 + rejs->wart02 + rejs->wart07 ;
               + rejs->wart22 + rejs->wart12 + rejs->vat02 + rejs->vat07 + rejs->vat22 ;
               + rejs->vat12
            aPoz[ 'br' ] := 0

            nI := AScan( aLista, { | aElem | aElem[ 'klucz' ] == cKlucz } )
            IF nI == 0
               AAdd( aLista, { 'klucz' => cKlucz, 'nazwa' => aPoz[ 'nazwa' ], 'pozycje' => { aPoz } } )
            ELSE
               AAdd( aLista[ nI ][ 'pozycje' ], aPoz )
            ENDIF

         ENDIF

         rejs->( dbSkip() )

      ENDDO

   ENDIF

   rejs->( dbCloseArea() )

   IF ! Dostep( 'REJZ' )
      RETURN aDane
   ENDIF
   SetInd( 'REJZ' )

   rejz->( dbSeek( '+' + ident_fir ) )

   IF rejz->( Found() )

      DO WHILE ! rejz->( Eof() ) .AND. rejz->del == '+' .AND. rejz->firma == ident_fir

         dDataDok := hb_Date( Val( param_rok ), Val( rejz->mc ), Val( rejz->dzien ) )

         IF dDataDok >= dDataOd .AND. dDataDok <= dDataDo .AND. Eval( aFiltr[ nRodzaj ], 'rejz' )

            cKlucz := iif( AllTrim( rejz->nr_ident ) == "", AllTrim( rejz->nazwa ), ;
               AllTrim( NormalizujNipPL( rejz->nr_ident ) ) )
            aPoz := {=>}
            aPoz[ 'klucz' ] := cKlucz
            aPoz[ 'rodzaj' ] := 3
            aPoz[ 'data' ] := dDataDok
            aPoz[ 'nazwa' ] := AllTrim( rejz->nazwa )
            IF Left( rejz->numer, 1 ) == Chr( 1 ) .OR. Left( rejz->numer, 1 ) == Chr( 254 )
               aPoz[ 'nr_dok' ] := AllTrim( SubStr( rejz->numer, 2 ) )
            ELSE
               aPoz[ 'nr_dok' ] := AllTrim( rejz->numer )
            ENDIF
            aPoz[ 'np' ] := 0
            aPoz[ 'nr' ] := rejz->wartzw + rejz->wart00 + rejz->wart02 + rejz->wart07 ;
               + rejz->wart22 + rejz->wart12
            aPoz[ 'bp' ] := 0
            aPoz[ 'br' ] := rejz->wartzw + rejz->wart00 + rejz->wart02 + rejz->wart07 ;
               + rejz->wart22 + rejz->wart12 + rejz->vat02 + rejz->vat07 + rejz->vat22 ;
               + rejz->vat12

            nI := AScan( aLista, { | aElem | aElem[ 'klucz' ] == cKlucz } )
            IF nI == 0
               AAdd( aLista, { 'klucz' => cKlucz, 'nazwa' => aPoz[ 'nazwa' ], 'pozycje' => { aPoz } } )
            ELSE
               AAdd( aLista[ nI ][ 'pozycje' ], aPoz )
            ENDIF

         ENDIF

         rejz->( dbSkip() )

      ENDDO

   ENDIF

   rejz->( dbCloseArea() )

   ASort( aLista, , , { | a1, a2 | a1[ 'nazwa' ] < a2[ 'nazwa' ] } )
   FOR nI := 1 TO Len( aLista )
      ASort( aLista[ nI ][ 'pozycje' ], , , { | a1, a2 |
         IF a1[ 'rodzaj' ] <> a2[ 'rodzaj' ]
            RETURN a1[ 'rodzaj' ] < a2[ 'rodzaj' ]
         ELSE
            RETURN a1[ 'data' ] < a2[ 'data' ]
         ENDIF
      } )
   NEXT

   IF cGrupuj == 'K'
      AEval( aLista, { | aPozL |
         AEval( aPozL[ 'pozycje' ], { | aPozP |
            AAdd( aDane[ 'pozycje' ], aPozP )
         } )
      } )
   ELSE
      FOR nI := 1 TO 3
         AEval( aLista, { | aPozL |
            AEval( aPozL[ 'pozycje' ], { | aPozP |
               IF aPozP[ 'rodzaj' ] == nI
                  AAdd( aDane[ 'pozycje' ], aPozP )
               ENDIF
            } )
         } )
      NEXT
   ENDIF

   aDane[ 'ok' ] := .T.

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE Obroty( nRodzaj, lTekstowy )

   LOCAL cFiltr := Space( 100 )
   LOCAL dDataOd, dDataDo
   LOCAL aDane
   LOCAL cEkran, cKolor, cGrupuj := 'R'
   LOCAL bGrupujW := { | x |
      LOCAL cGrKolor := ColInf()
      @ 24, 0 SAY PadC( 'R - rodzaju rejestru      K - kontrahenta', 80 )
      SetColor( cGrKolor )
      RETURN .T.
   }
   LOCAL bGrupujV := { | x |
      IF cGrupuj $ 'KR'
         @ 24,  0
         @ 22, 35 SAY iif( cGrupuj == 'K', 'ontrahenta      ', 'odzaju dokumentu' )
         RETURN .T.
      ELSE
         @ 22, 35 SAY '                '
         RETURN .F.
      ENDIF
   }

   cEkran := SaveScreen()
   cKolor := ColStd()

   dDataOd := hb_Date( Val( param_rok ), 1, 1 )
   IF Val( param_rok ) < Year( Date() )
      dDataDo := hb_Date( Val( param_rok ), 12, 31 )
   ELSE
      dDataDo := EoM( hb_Date( Val( param_rok ), Month( Date() ), Day( Date() ) ) )
   ENDIF

   @ 20,  0 CLEAR TO 22, 79
   @ 21,  2 SAY 'Od dnia' GET dDataOd PICTURE '@D'
   @ 22,  2 SAY 'Do dnia' GET dDataDo PICTURE '@D'
   @ 21, 21 SAY 'Dla ' + iif( nRodzaj == 1, 'nr NIP', 'nazwy kontrahenta' ) GET cFiltr PICTURE '@S35 ' + Replicate( '!', 100 )
   IF ! lTekstowy
      @ 22, 21 SAY 'Grupu wedˆug' GET cGrupuj PICTURE '!' WHEN Eval( bGrupujW ) VALID Eval( bGrupujV )
      @ 22, 35 SAY 'odzaju dokumentu'
   ENDIF
   read_()
   IF LastKey() <> 27

      aDane := Obroty_Dane( nRodzaj, AllTrim( cFiltr ), dDataOd, dDataDo, cGrupuj )

      IF HB_ISHASH( aDane ) .AND. aDane[ 'ok' ]

         IF lTekstowy
            Obroty_Tekst( aDane )
         ELSE
            FRDrukuj( 'frf\' + iif( cGrupuj == 'K', 'obrotygk', 'obrotygr' ) + '.frf', aDane )
         ENDIF

      ENDIF

   ENDIF

   SetColor( cKolor )
   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

PROCEDURE Obroty_Tekst( aDane )

   LOCAL nI, nR, cGrupa := '!~@#@^&!', nIlosc
   *-----parametry wewnetrzne-----
   PRIVATE _papsz := 1
   PRIVATE _lewa := 1
   PRIVATE _prawa := 121
   PRIVATE _strona := .T.
   PRIVATE _czy_mon := .T.
   PRIVATE _czy_close := .T.
   PRIVATE czesc := 1
   PRIVATE _szerokosc := 121
   *------------------------------

   BEGIN SEQUENCE
      mon_drk( 'ö' + ProcName() )

      k1 := DToC( aDane[ 'data_od' ] )
      k2 := DToC( aDane[ 'data_do' ] )

      mon_drk( ' ZESTAWIENIE OBROTàW Z KONTRAHENTEM  (Filtr: ' + aDane[ 'filtr' ] + ')  za okres od  ' + k1 + '  do  ' + k2 )
      mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
      mon_drk( '³                                 ³   Data   ³   Numer  ³           N E T T O           ³          B R U T T O          ³' )
      mon_drk( '³       Kontrahent                ³ dokumentu³ dokumentu³    Przych¢d   ³     Rozch¢d   ³    Przych¢d   ³     Rozch¢d   ³' )
      mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )

      FOR nR := 1 TO 3
         STORE 0 TO s0_4, s0_5, s0_6, s0_7
         STORE 0 TO s1_4, s1_5, s1_6, s1_7
         nIlosc := 0

         mon_drk( 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿' )
         DO CASE
         CASE nR == 1
            mon_drk( '³                 O B R O T Y   Z   K S I ¨ G I                ³' )
         CASE nR == 2
            mon_drk( '³     O B R O T Y   Z   R E J E S T R U   S P R Z E D A ½ Y    ³' )
         CASE nR == 3
            mon_drk( '³       O B R O T Y   Z   R E J E S T R U   Z A K U P à W      ³' )
         ENDCASE
         mon_drk( 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ' )

         FOR nI := 1 TO Len( aDane[ 'pozycje' ] )
            IF aDane[ 'pozycje' ][ nI ][ 'rodzaj' ] == nR
               IF cGrupa <> aDane[ 'pozycje' ][ nI ][ 'klucz' ]
                  IF nIlosc > 0
                     mon_drk( '               R a z e m   k o n t r a h e n t            ' + kwota( s1_4, 14, 2 ) + '  ' + kwota( s1_5, 14, 2 ) + '  ' + kwota( s1_6, 14, 2 ) + '  ' + kwota( s1_7, 14, 2 ) )
                     mon_drk( 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
                  ENDIF
                  STORE 0 TO s1_4, s1_5, s1_6, s1_7
                  cGrupa := aDane[ 'pozycje' ][ nI ][ 'klucz' ]
                  nIlosc := 0
               ENDIF
               nIlosc++
               IF nIlosc == 1
                  k1 := Pad( SubStr( aDane[ 'pozycje' ][ nI ][ 'nazwa' ], 1, 33 ), 33 )
               ELSE
                  k1 := Space( 33 )
               ENDIF
               k2 := DToC( aDane[ 'pozycje' ][ nI ][ 'data' ] )
               k3 := Pad( SubStr( aDane[ 'pozycje' ][ nI ][ 'nr_dok' ], 1, 10 ), 10 )
               k4 := kwota( aDane[ 'pozycje' ][ nI ][ 'np' ], 14, 2 )
               k5 := kwota( aDane[ 'pozycje' ][ nI ][ 'nr' ], 14, 2 )
               k6 := kwota( aDane[ 'pozycje' ][ nI ][ 'bp' ], 14, 2 )
               k7 := kwota( aDane[ 'pozycje' ][ nI ][ 'br' ], 14, 2 )

               s0_4 := s0_4 + aDane[ 'pozycje' ][ nI ][ 'np' ]
               s0_5 := s0_5 + aDane[ 'pozycje' ][ nI ][ 'nr' ]
               s0_6 := s0_6 + aDane[ 'pozycje' ][ nI ][ 'bp' ]
               s0_7 := s0_7 + aDane[ 'pozycje' ][ nI ][ 'br' ]

               s1_4 := s1_4 + aDane[ 'pozycje' ][ nI ][ 'np' ]
               s1_5 := s1_5 + aDane[ 'pozycje' ][ nI ][ 'nr' ]
               s1_6 := s1_6 + aDane[ 'pozycje' ][ nI ][ 'bp' ]
               s1_7 := s1_7 + aDane[ 'pozycje' ][ nI ][ 'br' ]

               mon_drk( ' ' + k1 + ' ' + k2 + ' ' + k3 + '  ' + k4 + '  ' + k5 + '  ' + k6 + '  ' + k7 )

               IF nI == Len( aDane[ 'pozycje' ] )
                  mon_drk( '               R a z e m   k o n t r a h e n t            ' + kwota( s1_4, 14, 2 ) + '  ' + kwota( s1_5, 14, 2 ) + '  ' + kwota( s1_6, 14, 2 ) + '  ' + kwota( s1_7, 14, 2 ) )
                  mon_drk( 'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ' )
               ENDIF

            ENDIF
         NEXT

      NEXT

      mon_drk( '                                   O g ¢ ˆ e m            ' + kwota( s0_4, 14, 2 ) + '  ' + kwota( s0_5, 14, 2 ) + '  ' + kwota( s0_6, 14, 2 ) + '  ' + kwota( s0_7, 14, 2 ) )
      mon_drk( 'ş' )

   END

   RETURN NIL

/*----------------------------------------------------------------------*/

