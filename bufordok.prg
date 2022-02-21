/************************************************************************

AMi-BOOK

Copyright (C) 1991-2014  AMi-SYS s.c.
              2015-2022  GM Systems Michaˆ Gawrycki (gmsystems.pl)

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

FUNCTION Bufor_Dok_Znajdz( cRodzaj, nRecNo )

   RETURN AScan( bufor_dok[ cRodzaj ], { | aRow | aRow[ 'ID' ] == nRecNo } )

/*----------------------------------------------------------------------*/

FUNCTION Bufor_Dok_Wybierz( cRodzaj )

   IF ! HB_ISHASH( bufor_dok ) .OR. ! hb_HHasKey( bufor_dok, cRodzaj ) .OR. Len( bufor_dok[ cRodzaj ] ) == 0
      Komun( "Brak dokument¢w w buforze" )
      RETURN NIL
   ENDIF

   DO CASE
   CASE cRodzaj == 'oper'
      RETURN Bufor_Dok_Wybierz_Oper()
   CASE cRodzaj == 'rycz'
      RETURN Bufor_Dok_Wybierz_Rycz()
   CASE cRodzaj == 'rejs'
      RETURN Bufor_Dok_Wybierz_RejS()
   CASE cRodzaj == 'rejz'
      RETURN Bufor_Dok_Wybierz_RejZ()
   ENDCASE

   RETURN NIL

/*----------------------------------------------------------------------*/

FUNCTION Bufor_Dok_Wybierz_Oper()

   LOCAL xRes := NIL
   LOCAL nElem := 1
   LOCAL cEkran
   LOCAL cKolor := ColStd()
   LOCAL aNaglowki := { "Dz.", "Nr dowodu", "NIP", "Nazwa", "Adres", ;
      "Opis", "Wart. sprz.", "Poz. przych.", "Zak. tow.", "Koszty", ;
      "Wynagrodzenia", "Pozostaˆe", "Wart. bad.", "Uwagi" }
   LOCAL aKolumny := { ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'DZIEN' ] }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'NUMER' ], 1, 16 ) }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'NR_IDENT' ], 1, 12 ) }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'NAZWA' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'ADRES' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'TRESC' ], 1, 20 ) }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'WYR_TOW' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'USLUGI' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'ZAKUP' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'UBOCZNE' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'WYNAGR_G' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'WYDATKI' ] }, ;
      { || bufor_dok[ 'oper' ][ nElem ][ 'K16WART' ] }, ;
      { || SubStr( bufor_dok[ 'oper' ][ nElem ][ 'UWAGI' ], 1, 40 ) } }

   SAVE SCREEN TO cEkran

   @  2, 0 SAY PadC( "BUFOR DOKUMENTàW", 80 )
   @ 22, 0 SAY PadC( "Enter - wyb¢r,   Delete - usuni©cie z bufora,   ESC - anuluj", 80 )
   nElem := GM_ArEdit( 3, 0, 21, 79, bufor_dok[ 'oper' ], @nElem, aNaglowki, aKolumny, NIL, NIL, NIL, NIL, SetColor() + ",N+/N" )

   IF LastKey() <> K_ESC .AND. nElem > 0 .AND. Len( bufor_dok[ 'oper' ] ) >= nElem
      xRes := bufor_dok[ 'oper' ][ nElem ]
   ENDIF

   CLEAR TYPEAHEAD
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN xRes

/*----------------------------------------------------------------------*/

FUNCTION Bufor_Dok_Wybierz_Rycz()

   LOCAL xRes := NIL
   LOCAL nElem := 1
   LOCAL cEkran
   LOCAL cKolor := ColStd()
   LOCAL aNaglowki := { "Dz.", "Data przych.", "Nr faktury", "Opis zdarzenia", "Waro˜† kol.5", ;
      "Waro˜† kol.6", "Waro˜† kol.7", "Waro˜† kol.8", "Waro˜† kol.9", ;
      "Waro˜† kol.10", "Waro˜† kol.11", "Waro˜† kol.12", "Waro˜† kol.13", "Uwagi" }
   LOCAL aKolumny := { ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'DZIEN' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'DATAPRZY' ] }, ;
      { || SubStr( bufor_dok[ 'rycz' ][ nElem ][ 'NUMER' ], 1, 15 ) }, ;
      { || SubStr( bufor_dok[ 'rycz' ][ nElem ][ 'TRESC' ], 1, 20 ) }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RY20' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RY17' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RYK09' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'USLUGI' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RYK10' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'PRODUKCJA' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'HANDEL' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RYK07' ] }, ;
      { || bufor_dok[ 'rycz' ][ nElem ][ 'RY10' ] }, ;
      { || SubStr( bufor_dok[ 'rycz' ][ nElem ][ 'UWAGI' ], 1, 30 ) } }

   SAVE SCREEN TO cEkran

   @  2, 0 SAY PadC( "BUFOR DOKUMENTàW", 80 )
   @ 22, 0 SAY PadC( "Enter - wyb¢r,   Delete - usuni©cie z bufora,   ESC - anuluj", 80 )
   nElem := GM_ArEdit( 3, 0, 21, 79, bufor_dok[ 'rycz' ], @nElem, aNaglowki, aKolumny, NIL, NIL, NIL, NIL, SetColor() + ",N+/N" )

   IF LastKey() <> K_ESC .AND. nElem > 0 .AND. Len( bufor_dok[ 'rycz' ] ) >= nElem
      xRes := bufor_dok[ 'rycz' ][ nElem ]
   ENDIF

   CLEAR TYPEAHEAD
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN xRes

/*----------------------------------------------------------------------*/

FUNCTION Bufor_Dok_Wybierz_RejS()

   LOCAL xRes := NIL
   LOCAL nElem := 1
   LOCAL cEkran
   LOCAL cKolor := ColStd()
   LOCAL aNaglowki := { "Dz.", "Rej.", "Nr dowodu", "NIP", "Nazwa", "Adres", ;
      "Opis", "Data sprz.", "Data wyst.", "Kor.", "Rodz.dow.", "Exp", "UE", ;
      "Kraj", "Oznaczenia", "Procedury", "Sekc.VAT", "Netto 23%", "VAT 23%", ;
      "Netto 8%", "VAT 8%", "Netto 5%", "VAT 5%", "Netto 7%", "VAT 7%", ;
      "Netto 0%", "ZW", "NP", "Sprzeda¾ mar¾a", "Do ksi©gi", "Kol", "Do ksi©gi", "Kol" }
   LOCAL aKolumny := { ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'DZIEN' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'SYMB_REJ' ] }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'NUMER' ], 1, 16 ) }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'NR_IDENT' ], 1, 12 ) }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'NAZWA' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'ADRES' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'TRESC' ], 1, 20 ) }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'DATAS' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'DATATRAN' ] }, ;
      { || iif( bufor_dok[ 'rejs' ][ nElem ][ 'KOREKTA' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'RODZDOW' ] }, ;
      { || iif( bufor_dok[ 'rejs' ][ nElem ][ 'EXPORT' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || iif( bufor_dok[ 'rejs' ][ nElem ][ 'UE' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'KRAJ' ] }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'OPCJE' ], 1, 10 ) }, ;
      { || SubStr( bufor_dok[ 'rejs' ][ nElem ][ 'PROCEDUR' ], 1, 10 ) }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'SEK_CV7' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART22' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'VAT22' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART07' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'VAT07' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART02' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'VAT02' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART12' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'VAT12' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART00' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WARTZW' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'WART08' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'VATMARZA' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'NETTO' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'KOLUMNA' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'NETTO2' ] }, ;
      { || bufor_dok[ 'rejs' ][ nElem ][ 'KOLUMNA2' ] } }

   SAVE SCREEN TO cEkran

   @  2, 0 SAY PadC( "BUFOR DOKUMENTàW", 80 )
   @ 22, 0 SAY PadC( "Enter - wyb¢r,   Delete - usuni©cie z bufora,   ESC - anuluj", 80 )
   nElem := GM_ArEdit( 3, 0, 21, 79, bufor_dok[ 'rejs' ], @nElem, aNaglowki, aKolumny, NIL, NIL, NIL, NIL, SetColor() + ",N+/N" )

   IF LastKey() <> K_ESC .AND. nElem > 0 .AND. Len( bufor_dok[ 'rejs' ] ) >= nElem
      xRes := bufor_dok[ 'rejs' ][ nElem ]
   ENDIF

   CLEAR TYPEAHEAD
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN xRes

/*----------------------------------------------------------------------*/

FUNCTION Bufor_Dok_Wybierz_RejZ()

   LOCAL xRes := NIL
   LOCAL nElem := 1
   LOCAL cEkran
   LOCAL cKolor := ColStd()
   LOCAL aNaglowki := { "Dz.", "Rej.", "Nr dowodu", "NIP", "Nazwa", "Adres", ;
      "Opis", "Data zak.", "Data wpˆy.", "Kor.", "Rodz.dow.", "UE", ;
      "Kraj", "TT", "Opcje", "Sekc.VAT", "Netto 23%", "VAT 23%", ;
      "Netto 8%", "VAT 8%", "Netto 5%", "VAT 5%", "Netto 7%", "VAT 7%", ;
      "Netto 0%", "ZW", "NP", "Sprzeda¾ mar¾a", "Do ksi©gi", "Kol", "Do ksi©gi", "Kol" }
   LOCAL aKolumny := { ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'DZIEN' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'SYMB_REJ' ] }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'NUMER' ], 1, 16 ) }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'NR_IDENT' ], 1, 12 ) }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'NAZWA' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'ADRES' ], 1, 20 ) }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'TRESC' ], 1, 20 ) }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'DATAS' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'DATATRAN' ] }, ;
      { || iif( bufor_dok[ 'rejz' ][ nElem ][ 'KOREKTA' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'RODZDOW' ] }, ;
      { || iif( bufor_dok[ 'rejz' ][ nElem ][ 'UE' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'KRAJ' ] }, ;
      { || iif( bufor_dok[ 'rejz' ][ nElem ][ 'TROJSTR' ] == 'T', 'Tak', 'Nie' ) }, ;
      { || SubStr( bufor_dok[ 'rejz' ][ nElem ][ 'OPCJE' ], 1, 10 ) }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'SEK_CV7' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WART22' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'VAT22' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WART07' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'VAT07' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WART02' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'VAT02' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WART12' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'VAT12' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WART00' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'WARTZW' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'VATMARZA' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'NETTO' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'KOLUMNA' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'NETTO2' ] }, ;
      { || bufor_dok[ 'rejz' ][ nElem ][ 'KOLUMNA2' ] } }

   SAVE SCREEN TO cEkran

   @  2, 0 SAY PadC( "BUFOR DOKUMENTàW", 80 )
   @ 22, 0 SAY PadC( "Enter - wyb¢r,   Delete - usuni©cie z bufora,   ESC - anuluj", 80 )
   nElem := GM_ArEdit( 3, 0, 21, 79, bufor_dok[ 'rejz' ], @nElem, aNaglowki, aKolumny, NIL, NIL, NIL, NIL, SetColor() + ",N+/N" )

   IF LastKey() <> K_ESC .AND. nElem > 0 .AND. Len( bufor_dok[ 'rejz' ] ) >= nElem
      xRes := bufor_dok[ 'rejz' ][ nElem ]
   ENDIF

   CLEAR TYPEAHEAD
   RESTORE SCREEN FROM cEkran
   SetColor( cKolor )

   RETURN xRes

/*----------------------------------------------------------------------*/
