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
      'filtr' => cDane, 'data_od' => dDataOd, 'data_do' => dDataDo }
   LOCAL dDataDok, aPoz
   LOCAL aFiltr := { ;
      { | cTablica | Empty( cDane ) .OR. ( NormalizujNipPL( ( cTablica )->nr_ident ) == NormalizujNipPL( cDane ) ) }, ;
      { | cTablica | Empty( cDane ) .OR. ( hb_AtI( cDane, ( cTablica )->nazwa ) > 0 ) } }

   IF ! Dostep( 'OPER' )
      RETURN aDane
   ENDIF
   SetInd( 'OPER' )

   oper->( dbSeek( '+' + ident_fir ) )

   IF oper->( Found() )

      DO WHILE ! oper->( Eof() ) .AND. oper->del == '+' .AND. oper->firma == ident_fir

         dDataDok := hb_Date( Val( param_rok ), Val( oper->mc ), Val( oper->dzien ) )

         IF dDataDok >= dDataOd .AND. dDataDok <= dDataDo .AND. Eval( aFiltr[ nRodzaj ], 'oper' )

            aPoz := {=>}
            aPoz[ 'klucz' ] := iif( AllTrim( oper->nr_ident ) == "", AllTrim( oper->nazwa ), ;
               AllTrim( NormalizujNipPL( oper->nr_ident ) ) )
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

            AAdd( aDane[ 'pozycje' ], aPoz )

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

            aPoz := {=>}
            aPoz[ 'klucz' ] := iif( AllTrim( rejs->nr_ident ) == "", AllTrim( rejs->nazwa ), ;
               AllTrim( NormalizujNipPL( rejs->nr_ident ) ) )
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

            AAdd( aDane[ 'pozycje' ], aPoz )

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

            aPoz := {=>}
            aPoz[ 'klucz' ] := iif( AllTrim( rejz->nr_ident ) == "", AllTrim( rejz->nazwa ), ;
               AllTrim( NormalizujNipPL( rejz->nr_ident ) ) )
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

            AAdd( aDane[ 'pozycje' ], aPoz )

         ENDIF

         rejz->( dbSkip() )

      ENDDO

   ENDIF

   rejz->( dbCloseArea() )

   IF cGrupuj == 'K'

      ASort( aDane[ 'pozycje' ], , , { | a1, a2 |
         IF a1[ 'klucz' ] <> a2[ 'klucz' ]
            RETURN a1[ 'klucz' ] < a2[ 'klucz' ]
         ELSE
            RETURN a1[ 'rodzaj' ] < a2[ 'rodzaj' ]
         ENDIF
      } )

   ELSE

      ASort( aDane[ 'pozycje' ], , , { | a1, a2 |
         IF a1[ 'rodzaj' ] <> a2[ 'rodzaj' ]
            RETURN a1[ 'rodzaj' ] < a2[ 'rodzaj' ]
         ELSE
            RETURN a1[ 'klucz' ] < a2[ 'klucz' ]
         ENDIF
      } )

   ENDIF

   aDane[ 'ok' ] := .T.

   RETURN aDane

/*----------------------------------------------------------------------*/

PROCEDURE Obroty( nRodzaj )

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
   dDataDo := hb_Date( Val( param_rok ), Month( Date() ), Day( Date() ) )

   @ 20,  0 CLEAR TO 22, 79
   @ 21,  2 SAY 'Od dnia' GET dDataOd PICTURE '@D'
   @ 22,  2 SAY 'Do dnia' GET dDataDo PICTURE '@D'
   @ 21, 21 SAY 'Dla ' + iif( nRodzaj == 1, 'nr NIP', 'nazwy kontrahenta' ) GET cFiltr PICTURE '@S35 ' + Replicate( '!', 100 )
   @ 22, 21 SAY 'Grupu wedˆug' GET cGrupuj PICTURE '!' WHEN Eval( bGrupujW ) VALID Eval( bGrupujV )
   @ 22, 35 SAY 'odzaju dokumentu'
   read_()
   IF LastKey() <> 27

      aDane := Obroty_Dane( nRodzaj, AllTrim( cFiltr ), dDataOd, dDataDo, cGrupuj )

      IF HB_ISHASH( aDane ) .AND. aDane[ 'ok' ]

         FRDrukuj( 'frf\' + iif( cGrupuj == 'K', 'obrotygk', 'obrotygr' ) + '.frf', aDane )

      ENDIF

   ENDIF

   SetColor( cKolor )
   RestScreen( , , , , cEkran )

   RETURN NIL

/*----------------------------------------------------------------------*/

